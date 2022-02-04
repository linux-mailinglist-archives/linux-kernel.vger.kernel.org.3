Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD024A9333
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiBDFGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiBDFGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:06:16 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3FFC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 21:06:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d5so4434682pjk.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 21:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=8iIaekhxi09m7pSk70nnsISsTi/jiwvJuDakRs67WzM=;
        b=QQ9QGZR4swuOAW0lPBw4aDKrkuP3UYIWVJrFRADUR1r8bP8KJKL7IPFyPbfRs/U4fR
         2O6Z155M39uSvc2Ohxyt+bI9ZDvG6dKQBrTg4mqjh+SWE/aEEY00xoRORTuKB3oanIu+
         H2Mmz+gfg9rG8X3OwNyXxu5u7f5QUdrq0fm+/bUjNWYoD9ZB3eXc6T0RAv5ulnqfx29p
         q6Q/EO8BtoUuAvhaO8m6+u2y796/3Rq0VFkfXe7U15J7Jcl2QiLVfU93coGAim+Ukyad
         geaJdlibaDaQhMPDabG6y+DV7DRvOar16O7Sp8d6uwRnNF1eUs3nLK6Y2j8KTu+SamcW
         7Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=8iIaekhxi09m7pSk70nnsISsTi/jiwvJuDakRs67WzM=;
        b=jjpuk06kXUuW8+QGNkdq550dyaIvTHWwUZvRnD6VAepMWYs40itQIGI8ioH3EXVqPr
         tBsc0bmGTzVhAQh/9VeG8Tsc0lwEByS0YJqXdTuGI5c9Lt7cNHTJNsMJjZYGPIHiLrkt
         TQX72qksr2rcyurao90qFt+wQJMaG5AMR8BeL3PVxi4msYS3hGKhFVPjv9jXdRbJu18q
         3Jeoj4TgFRu/DlmFH6kMDblr2EJ+/yLln4oEaBDGL1Fdy+WajUaOKNEieScf9/yZ9cFR
         uJhgyZrkeCvAQ+Drz+vjftTCkwAltr5SCxHdlv4+46Jf9NCcbzQQY4TTGeg3tz40rcby
         ZFag==
X-Gm-Message-State: AOAM530jzPyZqi5K94x+25lg7FqN6dBXZqIgLpSyFrn6M0ZDPJZFmZGP
        nAqvIIAaT67ay/mA9GX0gBo=
X-Google-Smtp-Source: ABdhPJxciBopEAgZ/POSc3i/8dhx71oGzm7qVEf6WvE7YaH1iY8mA9ApWVkQYf5OKw8Iix+0MeDV/g==
X-Received: by 2002:a17:902:d044:: with SMTP id l4mr1487632pll.5.1643951175659;
        Thu, 03 Feb 2022 21:06:15 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id p22sm716627pfo.163.2022.02.03.21.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 21:06:15 -0800 (PST)
Date:   Fri, 4 Feb 2022 18:06:09 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: pi433: add debugfs interface
Message-ID: <Yfy0QSxL+3lbPlLK@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131134558.GL1951@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds debugfs interface that can be used for debugging possible
hardware/software issues.

It currently exposes the following debugfs entries for each SPI device
probed:

  /sys/kernel/debug/pi433/<DEVICE>/regs
  ...

The 'regs' file contains all rf69 uC registers values that are useful
for troubleshooting misconfigurations between 2 devices. It contains one
register per line so it should be easy to use normal filtering tools to
find the registers of interest if needed.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Changelog:

v4: remove unnecessary variable initializer, ensure mutex locks are
	released before returning from routine. Req: Dan Carpenter
v3: fix build error, remove redundant comments and validate return values
        from wait_event_interruptible routines: Req: Greg K-h, Dan Carpenter
v2: remove redudant references to dentry pointers in the code and perform
     debugsfs_lookup instead. Req: Greg k-h
v1: https://lore.kernel.org/lkml/20220123073855.GA79453@mail.google.com/
---
 drivers/staging/pi433/pi433_if.c | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 86ad497417f7..4fbac3ccef74 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -41,6 +41,8 @@
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 #endif
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 
 #include "pi433_if.h"
 #include "rf69.h"
@@ -1098,12 +1100,76 @@ static const struct file_operations pi433_fops = {
 	.llseek =	no_llseek,
 };
 
+static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
+{
+	struct pi433_device *dev;
+	u8 reg_data[114];
+	int i;
+	char *fmt = "0x%02x, 0x%02x\n";
+	int ret;
+
+	dev = m->private;
+
+	mutex_lock(&dev->tx_fifo_lock);
+	mutex_lock(&dev->rx_lock);
+
+	// wait for on-going operations to finish
+	ret = wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);
+	if (ret)
+		goto out_unlock;
+
+	ret = wait_event_interruptible(dev->tx_wait_queue, !dev->rx_active);
+	if (ret)
+		goto out_unlock;
+
+	// skip FIFO register (0x0) otherwise this can affect some of uC ops
+	for (i = 1; i < 0x50; i++)
+		reg_data[i] = rf69_read_reg(dev->spi, i);
+
+	reg_data[REG_TESTLNA] = rf69_read_reg(dev->spi, REG_TESTLNA);
+	reg_data[REG_TESTPA1] = rf69_read_reg(dev->spi, REG_TESTPA1);
+	reg_data[REG_TESTPA2] = rf69_read_reg(dev->spi, REG_TESTPA2);
+	reg_data[REG_TESTDAGC] = rf69_read_reg(dev->spi, REG_TESTDAGC);
+	reg_data[REG_TESTAFC] = rf69_read_reg(dev->spi, REG_TESTAFC);
+
+	seq_puts(m, "# reg, val\n");
+
+	for (i = 1; i < 0x50; i++)
+		seq_printf(m, fmt, i, reg_data[i]);
+
+	seq_printf(m, fmt, REG_TESTLNA, reg_data[REG_TESTLNA]);
+	seq_printf(m, fmt, REG_TESTPA1, reg_data[REG_TESTPA1]);
+	seq_printf(m, fmt, REG_TESTPA2, reg_data[REG_TESTPA2]);
+	seq_printf(m, fmt, REG_TESTDAGC, reg_data[REG_TESTDAGC]);
+	seq_printf(m, fmt, REG_TESTAFC, reg_data[REG_TESTAFC]);
+
+out_unlock:
+	mutex_unlock(&dev->rx_lock);
+	mutex_unlock(&dev->tx_fifo_lock);
+
+	return ret;
+}
+
+static int pi433_debugfs_regs_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, pi433_debugfs_regs_show, inode->i_private);
+}
+
+static const struct file_operations debugfs_fops = {
+	.llseek =	seq_lseek,
+	.open =		pi433_debugfs_regs_open,
+	.owner =	THIS_MODULE,
+	.read =		seq_read,
+	.release =	single_release
+};
+
 /*-------------------------------------------------------------------------*/
 
 static int pi433_probe(struct spi_device *spi)
 {
 	struct pi433_device	*device;
 	int			retval;
+	struct dentry		*entry;
 
 	/* setup spi parameters */
 	spi->mode = 0x00;
@@ -1252,6 +1318,10 @@ static int pi433_probe(struct spi_device *spi)
 	/* spi setup */
 	spi_set_drvdata(spi, device);
 
+	entry = debugfs_create_dir(dev_name(device->dev),
+				   debugfs_lookup(KBUILD_MODNAME, NULL));
+	debugfs_create_file("regs", 0400, entry, device, &debugfs_fops);
+
 	return 0;
 
 del_cdev:
@@ -1275,6 +1345,9 @@ static int pi433_probe(struct spi_device *spi)
 static int pi433_remove(struct spi_device *spi)
 {
 	struct pi433_device	*device = spi_get_drvdata(spi);
+	struct dentry *mod_entry = debugfs_lookup(KBUILD_MODNAME, NULL);
+
+	debugfs_remove(debugfs_lookup(dev_name(device->dev), mod_entry));
 
 	/* free GPIOs */
 	free_gpio(device);
@@ -1349,6 +1422,8 @@ static int __init pi433_init(void)
 		return PTR_ERR(pi433_class);
 	}
 
+	debugfs_create_dir(KBUILD_MODNAME, NULL);
+
 	status = spi_register_driver(&pi433_spi_driver);
 	if (status < 0) {
 		class_destroy(pi433_class);
@@ -1366,6 +1441,7 @@ static void __exit pi433_exit(void)
 	spi_unregister_driver(&pi433_spi_driver);
 	class_destroy(pi433_class);
 	unregister_chrdev(MAJOR(pi433_dev), pi433_spi_driver.driver.name);
+	debugfs_remove_recursive(debugfs_lookup(KBUILD_MODNAME, NULL));
 }
 module_exit(pi433_exit);
 
-- 
2.34.1

