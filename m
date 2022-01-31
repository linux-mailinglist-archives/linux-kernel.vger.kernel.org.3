Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE704A436E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359508AbiAaLV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:21:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:14349 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359194AbiAaLLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643627463; x=1675163463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U3v/Ejg1TqWehoSepyEfalh7OZ7aWlKrYEYrNmIK/cM=;
  b=fDcU1++foXQsOnmeejwlsac5I4tOUNA/ZOTRedP5QKWPwj64TtUbaxZd
   QVtpL3J4UgYi5NVaE64vgoEw+xYgxhDDps/H03z7ayJo1+Sh2K0iwUR/z
   yH4v66NhWAI/WidXEDN8TQlJFfNm4zrYp2fExYhsscfLPoNWWTXw3zL7O
   N8OQKllK0ZEsKmR9XlDklTxxQW2a754jS9VY6lNRACjGxTh+JFItbCq2h
   WRjmCGJvwNck6rjlNTO8gAH8XyidIuXHoWLMlOhv1y9wH3pkLje8ZKu6x
   W5Bj0oMWUU2D7efjIQzGmvBmWhb27IdMlpPLekor0L9vJMCdGGNO1AONC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="245033606"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="245033606"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 03:10:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="675694572"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Jan 2022 03:10:03 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 Jan 2022 13:10:02 +0200
Date:   Mon, 31 Jan 2022 13:10:02 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] usb: ulpi: Add debugfs support
Message-ID: <YffDipQOBUvouz+4@kuha.fi.intel.com>
References: <20220127190004.1446909-1-sean.anderson@seco.com>
 <20220127190004.1446909-4-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127190004.1446909-4-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:00:04PM -0500, Sean Anderson wrote:
> This adds a debugfs file for ULPI devices which contains a dump of their
> registers. This is useful for debugging basic connectivity problems. The
> file is created in ulpi_register because many devices will never have a
> driver bound (as they are managed in hardware by the USB controller
> device).
> 
> The root directory of this subsystem is created before we register the
> bus to ensure that devices can always create their directories.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Always create debugfs files and ignore errors
> - Look up dentries dynamically
> 
>  drivers/usb/common/ulpi.c | 71 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index dedcb749a02f..897e1a374f9e 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/debugfs.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/clk/clk-conf.h>
> @@ -229,9 +230,64 @@ static int ulpi_read_id(struct ulpi *ulpi)
>  	return 0;
>  }
>  
> +static int ulpi_regs_read(struct seq_file *seq, void *data)
> +{
> +	struct ulpi *ulpi = seq->private;
> +
> +#define ulpi_print(name, reg) do { \
> +	int ret = ulpi_read(ulpi, reg); \
> +	if (ret < 0) \
> +		return ret; \
> +	seq_printf(seq, name " %.02x\n", ret); \
> +} while (0)
> +
> +	ulpi_print("Vendor ID Low               ", ULPI_VENDOR_ID_LOW);
> +	ulpi_print("Vendor ID High              ", ULPI_VENDOR_ID_HIGH);
> +	ulpi_print("Product ID Low              ", ULPI_PRODUCT_ID_LOW);
> +	ulpi_print("Product ID High             ", ULPI_PRODUCT_ID_HIGH);
> +	ulpi_print("Function Control            ", ULPI_FUNC_CTRL);
> +	ulpi_print("Interface Control           ", ULPI_IFC_CTRL);
> +	ulpi_print("OTG Control                 ", ULPI_OTG_CTRL);
> +	ulpi_print("USB Interrupt Enable Rising ", ULPI_USB_INT_EN_RISE);
> +	ulpi_print("USB Interrupt Enable Falling", ULPI_USB_INT_EN_FALL);
> +	ulpi_print("USB Interrupt Status        ", ULPI_USB_INT_STS);
> +	ulpi_print("USB Interrupt Latch         ", ULPI_USB_INT_LATCH);
> +	ulpi_print("Debug                       ", ULPI_DEBUG);
> +	ulpi_print("Scratch Register            ", ULPI_SCRATCH);
> +	ulpi_print("Carkit Control              ", ULPI_CARKIT_CTRL);
> +	ulpi_print("Carkit Interrupt Delay      ", ULPI_CARKIT_INT_DELAY);
> +	ulpi_print("Carkit Interrupt Enable     ", ULPI_CARKIT_INT_EN);
> +	ulpi_print("Carkit Interrupt Status     ", ULPI_CARKIT_INT_STS);
> +	ulpi_print("Carkit Interrupt Latch      ", ULPI_CARKIT_INT_LATCH);
> +	ulpi_print("Carkit Pulse Control        ", ULPI_CARKIT_PLS_CTRL);
> +	ulpi_print("Transmit Positive Width     ", ULPI_TX_POS_WIDTH);
> +	ulpi_print("Transmit Negative Width     ", ULPI_TX_NEG_WIDTH);
> +	ulpi_print("Receive Polarity Recovery   ", ULPI_POLARITY_RECOVERY);
> +
> +	return 0;
> +}
> +
> +static int ulpi_regs_open(struct inode *inode, struct file *f)
> +{
> +	struct ulpi *ulpi = inode->i_private;
> +
> +	return single_open(f, ulpi_regs_read, ulpi);
> +}
> +
> +static const struct file_operations ulpi_regs_ops = {
> +	.owner = THIS_MODULE,
> +	.open = ulpi_regs_open,
> +	.release = single_release,
> +	.read = seq_read,
> +	.llseek = seq_lseek
> +};
> +
> +#define ULPI_ROOT debugfs_lookup(KBUILD_MODNAME, NULL)
> +
>  static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  {
>  	int ret;
> +	struct dentry *root;
>  
>  	ulpi->dev.parent = dev; /* needed early for ops */
>  	ulpi->dev.bus = &ulpi_bus;
> @@ -256,6 +312,9 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  		return ret;
>  	}
>  
> +	root = debugfs_create_dir(dev_name(dev), ULPI_ROOT);
> +	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_ops);
> +
>  	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
>  		ulpi->id.vendor, ulpi->id.product);
>  
> @@ -301,6 +360,8 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
>   */
>  void ulpi_unregister_interface(struct ulpi *ulpi)
>  {
> +	debugfs_remove_recursive(debugfs_lookup(dev_name(&ulpi->dev),
> +						ULPI_ROOT));
>  	device_unregister(&ulpi->dev);
>  }
>  EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
> @@ -309,13 +370,21 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
>  
>  static int __init ulpi_init(void)
>  {
> -	return bus_register(&ulpi_bus);
> +	int ret;
> +	struct dentry *root;
> +
> +	root = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +	ret = bus_register(&ulpi_bus);
> +	if (ret)
> +		debugfs_remove(root);
> +	return ret;
>  }
>  subsys_initcall(ulpi_init);
>  
>  static void __exit ulpi_exit(void)
>  {
>  	bus_unregister(&ulpi_bus);
> +	debugfs_remove_recursive(ULPI_ROOT);
>  }
>  module_exit(ulpi_exit);
>  
> -- 
> 2.25.1

thanks,

-- 
heikki
