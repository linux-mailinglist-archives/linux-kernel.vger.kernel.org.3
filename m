Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242F549CA56
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiAZNFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiAZNFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:05:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DDBC06161C;
        Wed, 26 Jan 2022 05:05:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6739161A22;
        Wed, 26 Jan 2022 13:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE0DC340E8;
        Wed, 26 Jan 2022 13:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643202333;
        bh=JLCan6waIZPT/I1GPVdQc3XfUHc7DS+/BERGgYzszzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=et5Y20uRyhGslMY0SD9TNyynPzEn/gRMGCsYAQr8M9elPlHMonjqeE7ufsSPGY7da
         ec6tcn38NjzXen9MFbhsGBWRLYaeQJRw6AkRvQW9yB8Tck1B1kFfcR24K45XaTDg5B
         tvymRxXUkMSFfyAjb/P6Niwv7m1LlVM8A0I1jqv8=
Date:   Wed, 26 Jan 2022 14:05:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 1/2] usb: ulpi: Add debugfs support
Message-ID: <YfFHFnPYeW0H8+/Y@kroah.com>
References: <20220124173344.874885-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124173344.874885-1-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 12:33:43PM -0500, Sean Anderson wrote:
> This adds a debugfs file for ULPI devices which contains a dump of their
> registers. This is useful for debugging basic connectivity problems. The
> file is created in ulpi_register because many devices will never have a
> driver bound (as they are managed in hardware by the USB controller
> device).
> 
> This also modifies the error handling in ulpi_register a bit to ensure
> that ulpi->dev.of_node is always put.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
> Changes in v2:
> - Always create debugfs files and ignore errors
> - Look up dentries dynamically
> 
>  drivers/usb/common/ulpi.c | 71 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index 4169cf40a03b..87deb514eb78 100644
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
> @@ -228,9 +229,64 @@ static int ulpi_read_id(struct ulpi *ulpi)
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
> @@ -251,6 +307,9 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  	if (ret)
>  		return ret;
>  
> +	root = debugfs_create_dir(dev_name(dev), ULPI_ROOT);
> +	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_ops);
> +
>  	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
>  		ulpi->id.vendor, ulpi->id.product);
>  
> @@ -296,6 +355,8 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
>   */
>  void ulpi_unregister_interface(struct ulpi *ulpi)
>  {
> +	debugfs_remove_recursive(debugfs_lookup(dev_name(&ulpi->dev),
> +						ULPI_ROOT));
>  	of_node_put(ulpi->dev.of_node);
>  	device_unregister(&ulpi->dev);
>  }
> @@ -305,13 +366,21 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
>  
>  static int __init ulpi_init(void)
>  {
> -	return bus_register(&ulpi_bus);
> +	int ret;
> +	struct dentry *root;
> +
> +	root = debugfs_create_dir(KBUILD_MODNAME, NULL);

The file could be accesed now, but you don't register the bus until
after this returns:

> +	ret = bus_register(&ulpi_bus);
> +	if (ret)
> +		debugfs_remove(root);

Can you flip the order around please?

thanks,

greg k-h
