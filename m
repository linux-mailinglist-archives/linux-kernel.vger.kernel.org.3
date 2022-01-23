Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DEF497147
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiAWLVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:21:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43336 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiAWLVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:21:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F0CF60BBE
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E051AC340E2;
        Sun, 23 Jan 2022 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642936860;
        bh=j6L0awpaUy8W+1Dut/K6oVZ7q9Gq/P1OiHHmseBHsgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNIZoUMYxvuubuHZaXWTLGPBjH5hfUPVjldzBJDOoqvlFhlfWHI5eWsAd+Cqe/Ckb
         4QaK2crcxWDVjwSCIbq8Y+qH+A8ZPF/wKv7Pn8OvrJHGpcDoARkaW/SaGfyR/kFZfA
         AJ+VjY90dnQgIOW9VMdbQI+yYhHAFVyb27kwaDjs=
Date:   Sun, 23 Jan 2022 12:20:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: pi433: add debugfs interface
Message-ID: <Ye06GfUzwzQBvfLy@kroah.com>
References: <20220123073855.GA79453@mail.google.com>
 <20220123074029.GA79722@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123074029.GA79722@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 08:40:29PM +1300, Paulo Miguel Almeida wrote:
> This adds debugfs interface that can be used for debugging possible
> hardware/software issues.
> 
> It currently exposes the following debugfs entries for each SPI device
> probed:
> 
>   /sys/kernel/debug/pi433/<DEVICE>/regs
>   ...
> 
> The 'regs' file contains all rf69 uC registers values that are useful
> for troubleshooting misconfigurations between 2 devices. It contains one
> register per line so it should be easy to use normal filtering tools to
> find the registers of interest if needed.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Meta-comments:
> 
> - I'm not entirely sure if I'm allowed to add additional dependencies to Kconfig
> the way I did or if I should surround debugfs routines with 
> #ifdef CONFIG_DEBUG_FS. I saw both approaches couldn't put my finger on which 
> one is the 'right' way here. I'm taking suggestions :)

Neither is really needed at all.  The debugfs api will work properly if
the main config option is not enabled, and the code will be compiled
away properly.

So no need to add any dependancy to your driver at all.

debugfs was designed to be simple to use, and adding dependancies is not
simple.  Same goes for my comments below, the goal is to keep it simple
and not worry about any error handling.

> - I saw that in some other drivers there is a tendency to have debugfs routines
> in a separate file such as debugfs.c and in that way this allows for smaller 
> files (which I do like) and Makefile that build files based on selected 
> configs such as:
> 
> pi433-$(CONFIG_DEBUG_FS) += debugfs.o 

Again, not needed.

> The only way I could achieve such thing would be if I moved pi433_device struct
> to pi433_if.h but I wanted to double check if reviewers would agree with this 
> approach first.
> 
> ---
>  drivers/staging/pi433/Kconfig    |  2 +-
>  drivers/staging/pi433/pi433_if.c | 82 ++++++++++++++++++++++++++++++++
>  drivers/staging/pi433/rf69.c     |  2 +-
>  drivers/staging/pi433/rf69.h     |  1 +
>  4 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/pi433/Kconfig b/drivers/staging/pi433/Kconfig
> index dd9e4709d1a8..9a8b7ef3e670 100644
> --- a/drivers/staging/pi433/Kconfig
> +++ b/drivers/staging/pi433/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config PI433
>  	tristate "Pi433 - a 433MHz radio module for Raspberry Pi"
> -	depends on SPI
> +	depends on SPI && DEBUG_FS

You can drop this.

>  	help
>  	  This option allows you to enable support for the radio module Pi433.
>  
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 17ff51f6a9da..e3a0d78385c0 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -41,6 +41,9 @@
>  #ifdef CONFIG_COMPAT
>  #include <linux/compat.h>
>  #endif
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +
>  
>  #include "pi433_if.h"
>  #include "rf69.h"
> @@ -56,6 +59,8 @@ static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
>  
>  static struct class *pi433_class; /* mainly for udev to create /dev/pi433 */
>  
> +static struct dentry *dbgfs_root_entry;

There is no need for this dentry.  Just look it up if you care about it.

> +
>  /*
>   * tx config is instance specific
>   * so with each open a new tx config struct is needed
> @@ -103,6 +108,9 @@ struct pi433_device {
>  	bool			rx_active;
>  	bool			tx_active;
>  	bool			interrupt_rx_allowed;
> +
> +	/* debug fs */
> +	struct dentry		*entry;

Again, no need for this, look it up if you need it.

>  };
>  
>  struct pi433_instance {
> @@ -1102,6 +1110,72 @@ static const struct file_operations pi433_fops = {
>  	.llseek =	no_llseek,
>  };
>  
> +static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
> +{
> +	struct pi433_device *dev;
> +	u8 reg_data[114];
> +	size_t i;
> +	char *fmt = "0x%02x, 0x%02x\n";
> +
> +	// obtain pi433_device reference
> +	dev = m->private;

That is not a "reference", that is just a normal empty pointer.  No need
to call it something else, that's just confusing.

> +
> +	// acquire locks to avoid race conditions
> +	mutex_lock(&dev->tx_fifo_lock);
> +	mutex_lock(&dev->rx_lock);
> +
> +	// wait for on-going operations to finish
> +	if (dev->tx_active)
> +		wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);
> +
> +	if (dev->rx_active)
> +		wait_event_interruptible(dev->tx_wait_queue, !dev->rx_active);
> +
> +	// read contiguous regs
> +	// skip FIFO register (0x0) otherwise this can affect some of uC ops
> +	for (i = 1; i < 0x50; i++)
> +		reg_data[i] = rf69_read_reg(dev->spi, i);
> +
> +	// read non-contiguous regs
> +	reg_data[REG_TESTLNA] = rf69_read_reg(dev->spi, REG_TESTLNA);
> +	reg_data[REG_TESTPA1] = rf69_read_reg(dev->spi, REG_TESTPA1);
> +	reg_data[REG_TESTPA2] = rf69_read_reg(dev->spi, REG_TESTPA2);
> +	reg_data[REG_TESTDAGC] = rf69_read_reg(dev->spi, REG_TESTDAGC);
> +	reg_data[REG_TESTAFC] = rf69_read_reg(dev->spi, REG_TESTAFC);
> +
> +	seq_puts(m, "# reg, val\n");
> +
> +	// print contiguous regs
> +	for (i = 1; i < 0x50; i++)
> +		seq_printf(m, fmt, i, reg_data[i]);
> +
> +	// print non-contiguous regs
> +	seq_printf(m, fmt, REG_TESTLNA, reg_data[REG_TESTLNA]);
> +	seq_printf(m, fmt, REG_TESTPA1, reg_data[REG_TESTPA1]);
> +	seq_printf(m, fmt, REG_TESTPA2, reg_data[REG_TESTPA2]);
> +	seq_printf(m, fmt, REG_TESTDAGC, reg_data[REG_TESTDAGC]);
> +	seq_printf(m, fmt, REG_TESTAFC, reg_data[REG_TESTAFC]);
> +
> +	// release locks
> +	mutex_unlock(&dev->tx_fifo_lock);
> +	mutex_unlock(&dev->rx_lock);
> +
> +	return 0;
> +}
> +
> +static ssize_t pi433_debugfs_regs_open(struct inode *inode, struct file *filp)
> +{
> +	return single_open(filp, pi433_debugfs_regs_show, inode->i_private);
> +}
> +
> +static const struct file_operations debugfs_fops = {
> +	.llseek =	seq_lseek,
> +	.open =		pi433_debugfs_regs_open,
> +	.owner =	THIS_MODULE,
> +	.read =		seq_read,
> +	.release =	single_release
> +};
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static int pi433_probe(struct spi_device *spi)
> @@ -1256,6 +1330,10 @@ static int pi433_probe(struct spi_device *spi)
>  	/* spi setup */
>  	spi_set_drvdata(spi, device);
>  
> +	/* debugfs setup */
> +	device->entry = debugfs_create_dir(dev_name(device->dev), dbgfs_root_entry);

Make "entry" a local variable, and then pass it to the next call.

And look up dbgfs_root_entry as well.  This can be rewritten as:
	entry = debugfs_create_dir(dev_name(device->dev,
					    debugfs_lookup("pi433", NULL);

> +	debugfs_create_file("regs", 0400, device->entry, device, &debugfs_fops);

When do you ever remove the debugfs entry for the device?  I do not see
that in any release function here.  Did you forget about that?

> +
>  	return 0;
>  
>  del_cdev:
> @@ -1353,6 +1431,8 @@ static int __init pi433_init(void)
>  		return PTR_ERR(pi433_class);
>  	}
>  
> +	dbgfs_root_entry = debugfs_create_dir("pi433", NULL);

Again, no need to keep this around, see above.

> +
>  	status = spi_register_driver(&pi433_spi_driver);
>  	if (status < 0) {
>  		class_destroy(pi433_class);
> @@ -1370,6 +1450,8 @@ static void __exit pi433_exit(void)
>  	spi_unregister_driver(&pi433_spi_driver);
>  	class_destroy(pi433_class);
>  	unregister_chrdev(MAJOR(pi433_dev), pi433_spi_driver.driver.name);
> +	debugfs_remove_recursive(dbgfs_root_entry);

Can be rewritten as:
	debugfs_remove_recursive(debugfs_lookup("pi433", NULL));

Or better yet:
	debugfs_remove_recursive(debugfs_lookup(KBUILD_MODULE_NAME, NULL));

thanks,

greg k-h
