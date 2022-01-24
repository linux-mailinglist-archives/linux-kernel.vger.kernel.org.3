Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E15497826
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbiAXE12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiAXE11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:27:27 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4955C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 20:27:26 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d7so14319283plr.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 20:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=svTekGvyDZ2bj2QSTavJFICPjSj2BK/HSxFtjLcNUZg=;
        b=cj0eJduN2KD5xEDRexDuFEFl4CfVOoLVzYDtJOl6ELjecKQaraYubvOQIp/D4VOY7v
         UXiZigrN4Yxe2fl431ykYdmnkNlqcUUs3NdayA6V22qLlplls/yxNcjFPZqaNT/xj53e
         52NV5Ib7Y8zOJ3OAbkDz2TO9D7FGMCP0/HHX9dxHUzYj5sD0fmVwbBp5uzlGRD49lgmQ
         bQHnFornUjHarm30lAbpt2/DNZJPsMBMvHrWroKKpHvrGrodTj7XH0v9wIQ3FexNMSU5
         TDPxTbOGliqV3ns6VwnkwvAp9FOtk3poUVwbhbPkEtDASeOfwzdtLp5ymwDkwY/UE/wn
         OSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=svTekGvyDZ2bj2QSTavJFICPjSj2BK/HSxFtjLcNUZg=;
        b=IC+XMJ9iOwAttwGivAhIQanvlZrNCR+pqbo4pPJDI2kg5geK7PL0Vy+hYXGx7RhsBb
         gYRGlMlocnGiw1JWAOqezcH12QcvYBzoaaVMqp2bIBVmoxLa63opK/PFvBgF5ckDSF5f
         cFC/BmCF+3eSLETPi9COnrj5r8SdW26Y/oFDo6lbQber4otEhGYPkIaXkg6wNb3J5/Ff
         /5L8/AZYKqkzb4go7QjdjXZensCoXkV8Qtzf6RADeAGS3vNTm9s1AE02TNMXi9OAI/h6
         IHpPUeUs/Z1yRVq7mgxaRvJbjkAx0bN/Ceg9qyEXndIBsnQ8c+VqcIexFejOzcr5QeuD
         zggg==
X-Gm-Message-State: AOAM533AuKSatKT7i5SxmF0rC5L7588UKs7lsVyyCreDi0niUbk4XPCl
        MMthllZFNlKEf8yS7PfmFD4=
X-Google-Smtp-Source: ABdhPJwKJtczzDDaS0Jalw6m0S4Hj+FDST5vD3k+dEoP4A9L2yVgAJ4dVMz4b4B7Ef/4kbkBPUgj0g==
X-Received: by 2002:a17:902:b40c:b0:14a:792:741f with SMTP id x12-20020a170902b40c00b0014a0792741fmr12884384plr.113.1642998446441;
        Sun, 23 Jan 2022 20:27:26 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id 189sm2875339pfg.142.2022.01.23.20.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 20:27:26 -0800 (PST)
Date:   Mon, 24 Jan 2022 17:27:21 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] staging: pi433: add debugfs interface
Message-ID: <20220124042721.GA8078@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124042506.GA7662@mail.google.com>
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
 drivers/staging/pi433/pi433_if.c | 80 ++++++++++++++++++++++++++++++++
 drivers/staging/pi433/rf69.c     |  2 +-
 drivers/staging/pi433/rf69.h     |  1 +
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 17ff51f6a9da..54bb2af2c2ea 100644
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
@@ -1102,11 +1104,77 @@ static const struct file_operations pi433_fops = {
 	.llseek =	no_llseek,
 };
 
+static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
+{
+	struct pi433_device *dev;
+	u8 reg_data[114];
+	size_t i;
+	char *fmt = "0x%02x, 0x%02x\n";
+
+	dev = m->private;
+
+	// acquire locks to avoid race conditions
+	mutex_lock(&dev->tx_fifo_lock);
+	mutex_lock(&dev->rx_lock);
+
+	// wait for on-going operations to finish
+	if (dev->tx_active)
+		wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);
+
+	if (dev->rx_active)
+		wait_event_interruptible(dev->tx_wait_queue, !dev->rx_active);
+
+	// read contiguous regs
+	// skip FIFO register (0x0) otherwise this can affect some of uC ops
+	for (i = 1; i < 0x50; i++)
+		reg_data[i] = rf69_read_reg(dev->spi, i);
+
+	// read non-contiguous regs
+	reg_data[REG_TESTLNA] = rf69_read_reg(dev->spi, REG_TESTLNA);
+	reg_data[REG_TESTPA1] = rf69_read_reg(dev->spi, REG_TESTPA1);
+	reg_data[REG_TESTPA2] = rf69_read_reg(dev->spi, REG_TESTPA2);
+	reg_data[REG_TESTDAGC] = rf69_read_reg(dev->spi, REG_TESTDAGC);
+	reg_data[REG_TESTAFC] = rf69_read_reg(dev->spi, REG_TESTAFC);
+
+	seq_puts(m, "# reg, val\n");
+
+	// print contiguous regs
+	for (i = 1; i < 0x50; i++)
+		seq_printf(m, fmt, i, reg_data[i]);
+
+	// print non-contiguous regs
+	seq_printf(m, fmt, REG_TESTLNA, reg_data[REG_TESTLNA]);
+	seq_printf(m, fmt, REG_TESTPA1, reg_data[REG_TESTPA1]);
+	seq_printf(m, fmt, REG_TESTPA2, reg_data[REG_TESTPA2]);
+	seq_printf(m, fmt, REG_TESTDAGC, reg_data[REG_TESTDAGC]);
+	seq_printf(m, fmt, REG_TESTAFC, reg_data[REG_TESTAFC]);
+
+	// release locks
+	mutex_unlock(&dev->tx_fifo_lock);
+	mutex_unlock(&dev->rx_lock);
+
+	return 0;
+}
+
+static ssize_t pi433_debugfs_regs_open(struct inode *inode, struct file *filp)
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
+	struct dentry		*entry; /* debugfs */
 	int			retval;
 
 	/* setup spi parameters */
@@ -1256,6 +1324,11 @@ static int pi433_probe(struct spi_device *spi)
 	/* spi setup */
 	spi_set_drvdata(spi, device);
 
+	/* debugfs setup */
+	entry = debugfs_create_dir(dev_name(device->dev),
+				   debugfs_lookup(KBUILD_MODNAME, NULL));
+	debugfs_create_file("regs", 0400, entry, device, &debugfs_fops);
+
 	return 0;
 
 del_cdev:
@@ -1279,6 +1352,10 @@ static int pi433_probe(struct spi_device *spi)
 static int pi433_remove(struct spi_device *spi)
 {
 	struct pi433_device	*device = spi_get_drvdata(spi);
+	struct dentry *mod_entry = debugfs_lookup(KBUILD_MODNAME, NULL);
+
+	/* debugfs */
+	debugfs_remove(debugfs_lookup(dev_name(device->dev), mod_entry));
 
 	/* free GPIOs */
 	free_gpio(device);
@@ -1353,6 +1430,8 @@ static int __init pi433_init(void)
 		return PTR_ERR(pi433_class);
 	}
 
+	debugfs_create_dir(KBUILD_MODNAME, NULL);
+
 	status = spi_register_driver(&pi433_spi_driver);
 	if (status < 0) {
 		class_destroy(pi433_class);
@@ -1370,6 +1449,7 @@ static void __exit pi433_exit(void)
 	spi_unregister_driver(&pi433_spi_driver);
 	class_destroy(pi433_class);
 	unregister_chrdev(MAJOR(pi433_dev), pi433_spi_driver.driver.name);
+	debugfs_remove_recursive(debugfs_lookup(KBUILD_MODNAME, NULL));
 }
 module_exit(pi433_exit);
 
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index d60514a840c2..b1a3382f4042 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -24,7 +24,7 @@
 
 /*-------------------------------------------------------------------------*/
 
-static u8 rf69_read_reg(struct spi_device *spi, u8 addr)
+u8 rf69_read_reg(struct spi_device *spi, u8 addr)
 {
 	int retval;
 
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index c25942f142a6..3ff5609ecf2e 100644
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
2.25.4

