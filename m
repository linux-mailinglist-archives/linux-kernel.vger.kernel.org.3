Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682CE49714C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiAWL17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiAWL15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:27:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58C0C06173B;
        Sun, 23 Jan 2022 03:27:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F30DB80CAD;
        Sun, 23 Jan 2022 11:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0F5C340E2;
        Sun, 23 Jan 2022 11:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642937274;
        bh=7TDyT2ov/pUJEShDBdQyFwxCKcd+j+fZvAVRuyVngh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfqZem12Uv5Qrzbf4hJqG5a+grzVRhBjjF13Y6ShThNyc9Pypg0hLlZgh4M75lHFt
         Ab0pSIRNIZ+sUUaYa5y8xt6qC+kgAwx5yb471AV0nVVXHat70/az+sdwNUfZn8bzi0
         TDhb24a7hz4Iw5trjSy6i2MM0MhJb5u4CvIZG9Eo=
Date:   Sun, 23 Jan 2022 12:27:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ulpi: Add debugfs support
Message-ID: <Ye07t/O8oOQRILyZ@kroah.com>
References: <20220114163947.790078-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114163947.790078-1-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 11:39:47AM -0500, Sean Anderson wrote:
> This adds a debugfs file for ULPI devices which contains a dump of their
> registers. This is useful for debugging basic connectivity problems. The
> file is created in ulpi_register because many devices will never have a
> driver bound (as they are managed in hardware by the USB controller
> device).
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>  drivers/usb/common/ulpi.c   | 100 ++++++++++++++++++++++++++++++++++--
>  include/linux/ulpi/driver.h |   3 ++
>  2 files changed, 99 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index 4169cf40a03b..a39c48e04013 100644
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
> +static int __maybe_unused ulpi_regs_read(struct seq_file *seq, void *data)
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
> +static int __maybe_unused ulpi_regs_open(struct inode *inode, struct file *f)
> +{
> +	struct ulpi *ulpi = inode->i_private;
> +
> +	return single_open(f, ulpi_regs_read, ulpi);
> +}
> +
> +static const struct file_operations __maybe_unused ulpi_regs_ops = {
> +	.owner = THIS_MODULE,
> +	.open = ulpi_regs_open,
> +	.release = single_release,
> +	.read = seq_read,
> +	.llseek = seq_lseek
> +};
> +
> +static struct dentry *ulpi_root = (void *)-EPROBE_DEFER;

There is no need for this variable, nor is there ever a need to set this
to an error value like this.  If you need to find the root, just look it
up!

> +
>  static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  {
>  	int ret;
> +	struct dentry *regs;
>  
>  	ulpi->dev.parent = dev; /* needed early for ops */
>  	ulpi->dev.bus = &ulpi_bus;
> @@ -245,16 +301,39 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  
>  	ret = ulpi_read_id(ulpi);
>  	if (ret)
> -		return ret;
> +		goto err_of;
>  
>  	ret = device_register(&ulpi->dev);
>  	if (ret)
> -		return ret;
> +		goto err_of;
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_FS)) {

This check is not needed, the compiler will handle it all for your
automatically.

> +		ulpi->root = debugfs_create_dir(dev_name(dev), ulpi_root);
> +		if (IS_ERR(ulpi->root)) {

No need to check this, just keep moving on.  debugfs return values
shoudl NEVER be checked as your code should not care what happens.

> +			ret = PTR_ERR(ulpi->root);
> +			goto err_dev;
> +		}
> +
> +		regs = debugfs_create_file("regs", 0444, ulpi->root, ulpi,
> +					   &ulpi_regs_ops);

Also, there is no need to save the dentry of "root", just make that a
local variable and look it up when you want to remove it.

> +		if (IS_ERR(regs)) {

Again, no need to check this at all.

> +			ret = PTR_ERR(regs);
> +			goto err_debugfs;
> +		}
> +	}

All of this logic here can be reduced to 2 lines of code and one
variable:
	struct dentry *dir;

	...

	dir = debugfs_create_dir(dev_name(dev),
			         debugfs_lookup(KBUILD_MODULE_NAME, NULL));
	debugfs_create_file("regs", 0444, dir, ulpi, &ulpi_regs_ops);

and that's it.



>  
>  	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
>  		ulpi->id.vendor, ulpi->id.product);
>  
>  	return 0;
> +
> +err_debugfs:
> +	debugfs_remove(ulpi->root);

debugfs_remove_recursive()?

> +err_dev:
> +	device_unregister(&ulpi->dev);
> +err_of:
> +	of_node_put(ulpi->dev.of_node);
> +	return ret;
>  }
>  
>  /**
> @@ -296,8 +375,9 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
>   */
>  void ulpi_unregister_interface(struct ulpi *ulpi)
>  {
> -	of_node_put(ulpi->dev.of_node);
> +	debugfs_remove_recursive(ulpi->root);

again, look up the name you want to remove, no need to store it around
anywhere:
	debugfs_remove_recursive(debugfs_lookup(dev_name(ulpi->dev), debugfs_lookup(KBUILD_MODULE_NAME, NULL)));

>  	device_unregister(&ulpi->dev);
> +	of_node_put(ulpi->dev.of_node);
>  }
>  EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
>  
> @@ -305,13 +385,25 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
>  
>  static int __init ulpi_init(void)
>  {
> -	return bus_register(&ulpi_bus);
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_FS)) {

Again, no need to check

> +		ulpi_root = debugfs_create_dir("ulpi", NULL);

Again, no need to keep this, it can just be:
	debugfs_create_dir(KBUILD_MODULE_NAME, NULL);

> +		if (IS_ERR(ulpi_root))
> +			return PTR_ERR(ulpi_root);
> +	}
> +
> +	ret = bus_register(&ulpi_bus);
> +	if (ret)
> +		debugfs_remove(ulpi_root);
> +	return ret;
>  }
>  subsys_initcall(ulpi_init);
>  
>  static void __exit ulpi_exit(void)
>  {
>  	bus_unregister(&ulpi_bus);
> +	debugfs_remove(ulpi_root);

	debugfs_remove_recursive(debugfs_lookup(KBUILD_MODULE_NAME, NULL));

>  }
>  module_exit(ulpi_exit);
>  
> diff --git a/include/linux/ulpi/driver.h b/include/linux/ulpi/driver.h
> index c7a1810373e3..083ea2d2e873 100644
> --- a/include/linux/ulpi/driver.h
> +++ b/include/linux/ulpi/driver.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/device.h>
>  
> +struct dentry;
>  struct ulpi_ops;
>  
>  /**
> @@ -13,10 +14,12 @@ struct ulpi_ops;
>   * @id: vendor and product ids for ULPI device
>   * @ops: I/O access
>   * @dev: device interface
> + * @root: root directory for debugfs files

No need for this, as pointed out above.

This should make you patch a _lot_ smaller.

thanks,

greg k-h
