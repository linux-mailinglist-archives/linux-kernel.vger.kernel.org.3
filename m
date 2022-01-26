Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF92049C9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbiAZM2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:28:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51160 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbiAZM2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:28:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1256CB81B99;
        Wed, 26 Jan 2022 12:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1F9C340E6;
        Wed, 26 Jan 2022 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643200125;
        bh=JDYmW4ZoybujXBTRgOaP0WReuDW0MypIno9+z1llHEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCRkNEFIanjThujf/WhTxahyIZPC4c+gC4npeXVQR+JFK123EvRnIVP2h5DhvvXw5
         kHUBDQJ6c14hH5wttiaUjfDuKj25a1hx/DMKGlKtN7FGiYnNwI0oFfxkKIuUHrYYZf
         9HCTMNc2IYKdcNXBWMjhAJaR1/0X+HTbnmDayCYQ=
Date:   Wed, 26 Jan 2022 13:28:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ulpi: Add debugfs support
Message-ID: <YfE+euszbG5Ghck3@kroah.com>
References: <20220114163947.790078-1-sean.anderson@seco.com>
 <Ye07t/O8oOQRILyZ@kroah.com>
 <d317e3bb-fe99-d82c-5cab-2f318ed39906@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d317e3bb-fe99-d82c-5cab-2f318ed39906@seco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:28:26AM -0500, Sean Anderson wrote:
> 
> 
> On 1/23/22 6:27 AM, Greg Kroah-Hartman wrote:
> > On Fri, Jan 14, 2022 at 11:39:47AM -0500, Sean Anderson wrote:
> >> This adds a debugfs file for ULPI devices which contains a dump of their
> >> registers. This is useful for debugging basic connectivity problems. The
> >> file is created in ulpi_register because many devices will never have a
> >> driver bound (as they are managed in hardware by the USB controller
> >> device).
> >> 
> >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> >> ---
> >> 
> >>  drivers/usb/common/ulpi.c   | 100 ++++++++++++++++++++++++++++++++++--
> >>  include/linux/ulpi/driver.h |   3 ++
> >>  2 files changed, 99 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> >> index 4169cf40a03b..a39c48e04013 100644
> >> --- a/drivers/usb/common/ulpi.c
> >> +++ b/drivers/usb/common/ulpi.c
> >> @@ -13,6 +13,7 @@
> >>  #include <linux/module.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/acpi.h>
> >> +#include <linux/debugfs.h>
> >>  #include <linux/of.h>
> >>  #include <linux/of_device.h>
> >>  #include <linux/clk/clk-conf.h>
> >> @@ -228,9 +229,64 @@ static int ulpi_read_id(struct ulpi *ulpi)
> >>  	return 0;
> >>  }
> >>  
> >> +static int __maybe_unused ulpi_regs_read(struct seq_file *seq, void *data)
> >> +{
> >> +	struct ulpi *ulpi = seq->private;
> >> +
> >> +#define ulpi_print(name, reg) do { \
> >> +	int ret = ulpi_read(ulpi, reg); \
> >> +	if (ret < 0) \
> >> +		return ret; \
> >> +	seq_printf(seq, name " %.02x\n", ret); \
> >> +} while (0)
> >> +
> >> +	ulpi_print("Vendor ID Low               ", ULPI_VENDOR_ID_LOW);
> >> +	ulpi_print("Vendor ID High              ", ULPI_VENDOR_ID_HIGH);
> >> +	ulpi_print("Product ID Low              ", ULPI_PRODUCT_ID_LOW);
> >> +	ulpi_print("Product ID High             ", ULPI_PRODUCT_ID_HIGH);
> >> +	ulpi_print("Function Control            ", ULPI_FUNC_CTRL);
> >> +	ulpi_print("Interface Control           ", ULPI_IFC_CTRL);
> >> +	ulpi_print("OTG Control                 ", ULPI_OTG_CTRL);
> >> +	ulpi_print("USB Interrupt Enable Rising ", ULPI_USB_INT_EN_RISE);
> >> +	ulpi_print("USB Interrupt Enable Falling", ULPI_USB_INT_EN_FALL);
> >> +	ulpi_print("USB Interrupt Status        ", ULPI_USB_INT_STS);
> >> +	ulpi_print("USB Interrupt Latch         ", ULPI_USB_INT_LATCH);
> >> +	ulpi_print("Debug                       ", ULPI_DEBUG);
> >> +	ulpi_print("Scratch Register            ", ULPI_SCRATCH);
> >> +	ulpi_print("Carkit Control              ", ULPI_CARKIT_CTRL);
> >> +	ulpi_print("Carkit Interrupt Delay      ", ULPI_CARKIT_INT_DELAY);
> >> +	ulpi_print("Carkit Interrupt Enable     ", ULPI_CARKIT_INT_EN);
> >> +	ulpi_print("Carkit Interrupt Status     ", ULPI_CARKIT_INT_STS);
> >> +	ulpi_print("Carkit Interrupt Latch      ", ULPI_CARKIT_INT_LATCH);
> >> +	ulpi_print("Carkit Pulse Control        ", ULPI_CARKIT_PLS_CTRL);
> >> +	ulpi_print("Transmit Positive Width     ", ULPI_TX_POS_WIDTH);
> >> +	ulpi_print("Transmit Negative Width     ", ULPI_TX_NEG_WIDTH);
> >> +	ulpi_print("Receive Polarity Recovery   ", ULPI_POLARITY_RECOVERY);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int __maybe_unused ulpi_regs_open(struct inode *inode, struct file *f)
> >> +{
> >> +	struct ulpi *ulpi = inode->i_private;
> >> +
> >> +	return single_open(f, ulpi_regs_read, ulpi);
> >> +}
> >> +
> >> +static const struct file_operations __maybe_unused ulpi_regs_ops = {
> >> +	.owner = THIS_MODULE,
> >> +	.open = ulpi_regs_open,
> >> +	.release = single_release,
> >> +	.read = seq_read,
> >> +	.llseek = seq_lseek
> >> +};
> >> +
> >> +static struct dentry *ulpi_root = (void *)-EPROBE_DEFER;
> > 
> > There is no need for this variable, nor is there ever a need to set this
> > to an error value like this.  If you need to find the root, just look it
> > up!
> 
> The reason why it is set to a non-zero value is so that it doesn't get
> coalesced with other zero-initialized static variables.

That doesn't matter, you shouldn't need to initialize this.

> >> +
> >>  static int ulpi_register(struct device *dev, struct ulpi *ulpi)
> >>  {
> >>  	int ret;
> >> +	struct dentry *regs;
> >>  
> >>  	ulpi->dev.parent = dev; /* needed early for ops */
> >>  	ulpi->dev.bus = &ulpi_bus;
> >> @@ -245,16 +301,39 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
> >>  
> >>  	ret = ulpi_read_id(ulpi);
> >>  	if (ret)
> >> -		return ret;
> >> +		goto err_of;
> >>  
> >>  	ret = device_register(&ulpi->dev);
> >>  	if (ret)
> >> -		return ret;
> >> +		goto err_of;
> >> +
> >> +	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> > 
> > This check is not needed, the compiler will handle it all for your
> > automatically.
> > 
> >> +		ulpi->root = debugfs_create_dir(dev_name(dev), ulpi_root);
> >> +		if (IS_ERR(ulpi->root)) {
> > 
> > No need to check this, just keep moving on.  debugfs return values
> > shoudl NEVER be checked as your code should not care what happens.
> 
> OK. The reason we have the above check is so we don't fail here because
> if we don't have CONFIG_DEBUG_FS then debugfs_create_dir() will fail
> with -ENODEV.

That's fine, there is no need to check a debugfs call, and any result
returned by a debugfs call can be passed to another debugfs call with no
problems.

thanks,

greg k-h
