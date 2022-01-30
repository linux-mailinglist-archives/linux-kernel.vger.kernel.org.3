Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5564A3367
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 03:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353799AbiA3C5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 21:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353274AbiA3C5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 21:57:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A992C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 18:57:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so8984771pjq.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 18:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=hyjaqV00PXV1hP8HC0tm5VzjlRs2Xpo6guoz0GL6a50=;
        b=i13y+QEhfUTTZjUL4sP4Td7Wtev+Yp6HL8u+Qmx0DLBzIHzqxzG1f7FGf1zpZ6WHU4
         wgfHtu1ygOdPPwIjiXJa+RkqMxmfCOAq31Xa2rjBbWmqzL/XlKWFGlvbHHHEnvloeX3O
         mtpEEF+PPguAnTt3WUoAwM4lA3eMs2bXX9QDBDK8anpX/jFIZgNXM6paL+CZrWy1X719
         FLZmfnRZwOVyipw7OO5S3Drhgqfjy2oHPkuwxEs272KQkUQ8loLbzYUMCFBBNUkoyheA
         tLVM/8ixSBzVQIOKTMYwmWyLvXG6nnxnw480qj0wN0cpbPzaMc0AAMcE6Xqex9WKnsz9
         ylfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=hyjaqV00PXV1hP8HC0tm5VzjlRs2Xpo6guoz0GL6a50=;
        b=UjLkwFUfxiLIpZxhnnpWgteniqThjOT2RdRc5Xe5WiXyEOZXGrfUnyW9XLIPCBEQCP
         96cuV2w8o9pRcGvKNCCjpEFzD7+w8TiMvhEnTAL8YqoVQORXYeshwdGBpAnur2beNGx8
         6FwcxEme1nRE3mQNUQZv9qAWFG4AvA3pAwoGX+3MGFy0PvNhhCucDPeDydnFzM80D+Dv
         EuYEUIjsI7mcGxEdjNu2WvDCXmPRnUjVPWjEoI3PRMcPzUq03fsPPZB+04G0dfipJdDK
         40no6S/pc3KU9Ko9EFERlr4BZb6PV8/FUFrjeLM2RvNY7jKCu5GQecEieEaIOl0ahQdz
         qJEg==
X-Gm-Message-State: AOAM532Dwmzcte/FYMEOJjj9EKv5/zJ6UilOqo/6uL/TiEajJSeH89za
        AcWRvwNwaQ8wc2iex0x90GMaTwxyk/1uzdwO
X-Google-Smtp-Source: ABdhPJzRRW6wkNIGS7BUfv3L6Cm/2INQ4QYEu9lW/awOwN5FXYeNlHVm3Zlw92NW7XkPkK6AS1WDyw==
X-Received: by 2002:a17:90b:1b03:: with SMTP id nu3mr10477195pjb.130.1643511452846;
        Sat, 29 Jan 2022 18:57:32 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id nn4sm6602382pjb.39.2022.01.29.18.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 18:57:32 -0800 (PST)
Date:   Sun, 30 Jan 2022 15:57:26 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: pi433: add debugfs interface
Message-ID: <YfX+llwDWZZMz+NY@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126132116.GA1951@kadam>
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

v3: fix build error, remove redundant comments and validate return values
	from wait_event_interruptible routines: Req: Greg K-h, Dan Carpenter
v2: remove redudant references to dentry pointers in the code and perform 
     debugsfs_lookup instead. Req: Greg k-h  
v1: https://lore.kernel.org/lkml/20220123073855.GA79453@mail.google.com/
---
 drivers/staging/pi433/pi433_if.c | 75 ++++++++++++++++++++++++++++++++
 drivers/staging/pi433/rf69.c     |  2 +-
 drivers/staging/pi433/rf69.h     |  1 +
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 17ff51f6a..74748d3cd 100644
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
@@ -1102,12 +1104,75 @@ static const struct file_operations pi433_fops = {
 	.llseek =	no_llseek,
 };
 
+static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
+{
+	struct pi433_device *dev;
+	u8 reg_data[114];
+	int i;
+	char *fmt = "0x%02x, 0x%02x\n";
+	int ret = 0;
+
+	dev = m->private;
+
+	mutex_lock(&dev->tx_fifo_lock);
+	mutex_lock(&dev->rx_lock);
+
+	// wait for on-going operations to finish
+	ret = wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);
+	if (ret)
+		return ret;
+
+	ret = wait_event_interruptible(dev->tx_wait_queue, !dev->rx_active);
+	if (ret)
+		return ret;
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
@@ -1256,6 +1321,10 @@ static int pi433_probe(struct spi_device *spi)
 	/* spi setup */
 	spi_set_drvdata(spi, device);
 
+	entry = debugfs_create_dir(dev_name(device->dev),
+				   debugfs_lookup(KBUILD_MODNAME, NULL));
+	debugfs_create_file("regs", 0400, entry, device, &debugfs_fops);
+
 	return 0;
 
 del_cdev:
@@ -1279,6 +1348,9 @@ static int pi433_probe(struct spi_device *spi)
 static int pi433_remove(struct spi_device *spi)
 {
 	struct pi433_device	*device = spi_get_drvdata(spi);
+	struct dentry *mod_entry = debugfs_lookup(KBUILD_MODNAME, NULL);
+
+	debugfs_remove(debugfs_lookup(dev_name(device->dev), mod_entry));
 
 	/* free GPIOs */
 	free_gpio(device);
@@ -1353,6 +1425,8 @@ static int __init pi433_init(void)
 		return PTR_ERR(pi433_class);
 	}
 
+	debugfs_create_dir(KBUILD_MODNAME, NULL);
+
 	status = spi_register_driver(&pi433_spi_driver);
 	if (status < 0) {
 		class_destroy(pi433_class);
@@ -1370,6 +1444,7 @@ static void __exit pi433_exit(void)
 	spi_unregister_driver(&pi433_spi_driver);
 	class_destroy(pi433_class);
 	unregister_chrdev(MAJOR(pi433_dev), pi433_spi_driver.driver.name);
+	debugfs_remove_recursive(debugfs_lookup(KBUILD_MODNAME, NULL));
 }
 module_exit(pi433_exit);
 
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index d60514a84..b1a3382f4 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -24,7 +24,7 @@
 
 /*-------------------------------------------------------------------------*/
 
-static u8 rf69_read_reg(struct spi_device *spi, u8 addr)
+u8 rf69_read_reg(struct spi_device *spi, u8 addr)
 {
 	int retval;
 
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index c25942f14..3ff5609ec 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -17,6 +17,7 @@
 #define FIFO_SIZE	66		/* bytes */
 #define FIFO_THRESHOLD	15		/* bytes */
 
+u8 rf69_read_reg(struct spi_device *spi, u8 addr);
 int rf69_get_version(struct spi_device *spi);
 int rf69_set_mode(struct spi_device *spi, enum mode mode);
 int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
-- 
2.34.1

