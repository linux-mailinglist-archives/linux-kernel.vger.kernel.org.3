Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43616473568
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbhLMT6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242690AbhLMT6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:58:44 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA5C061756
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:58:44 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id g81-20020a1c9d54000000b003330e488323so6615738wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bej45Nc2UVydd6t+QiQ55ufJzck3tTLRuB4UO0oewsY=;
        b=AJnLyTA7bPsLUdFwTHl20xb5+p0R3JyczpT7AEyeb95LxiM+Ti5vtSL1gr8xOW/8xU
         D64q4ABsqV3LmUxafpsjQRMs37AnRsxsQRH4ykGHd8SKLjj/t9SPbQsJv1ebWa2gUPQ5
         JR4OOBNoRGeHMNA3gG12S2pKJVu8tgCSaFSCqJ/5t8zNOiB5zEO+4aBI1ilCiNXBU3ZG
         IL+tyHn5cqMvHiyczzx6DzIAuw3/LWdvSeCWUIg6y5jpKBlzD7mHcpZHe19dQNqUYTxu
         GHWjqjAwRMJ5zdFhfloRTkDwMF5WV3H8D42ougRDDpaBQw/UOJPkeH/XuMGngMNjhLPj
         +TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bej45Nc2UVydd6t+QiQ55ufJzck3tTLRuB4UO0oewsY=;
        b=3L9RZQwaQ1ZFvAZ2rfLR3rgrN3L4TRT3rkNBmgdMOOxEr5rVewAY5XTRS1+jY1pjao
         vQrnNNZx8rUkQO8Bp4MTcFqOqRGVEVAaP1SFsNPznflFvkEI092CqeyKIppIN8J3HdYk
         6/csY3KXQu5Cn0Xku/rJxJW2hUPVbwxsyima3OGsJJDcnMdMPRTPfHVA6jpQ3kq5Lgjm
         XLWVfzKJThOdq9x0v0If+QP4XYjz6z+qH4o3ap28H5pkjNpSYpWl5QxbGQ66CFi9Vh6d
         UbYICDbqc9Z7ZhnaDvTRq6EGOD2e0+sQQW5YGROw3G4OkgLMRLipsuLcyAWFLYDA1kuV
         z/gA==
X-Gm-Message-State: AOAM530wr5G+LsBIytz1iTgmfAD+nMdQ92RXuVskEXBppte6lxyzpHnQ
        /NsuMdm8WoANOLxZqTTjOY791eFg5yqRCg==
X-Google-Smtp-Source: ABdhPJy8UnLdnVCVsYJTW3l0wSMuQhT5+njXKvy7Ksg9vIwY2UznHGeb3RmTCG8wGAxWtbFMIVDZXA6Lu6Yj2Q==
X-Received: from dbrazdil.lon.corp.google.com ([2a00:79e0:d:209:3e63:6f60:9fab:4549])
 (user=dbrazdil job=sendgmr) by 2002:a05:600c:4154:: with SMTP id
 h20mr40035535wmm.189.1639425522531; Mon, 13 Dec 2021 11:58:42 -0800 (PST)
Date:   Mon, 13 Dec 2021 19:58:33 +0000
In-Reply-To: <20211213195833.772892-1-dbrazdil@google.com>
Message-Id: <20211213195833.772892-3-dbrazdil@google.com>
Mime-Version: 1.0
References: <20211213195833.772892-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 2/2] misc: open-dice: Add driver to expose DICE data to userspace
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Open Profile for DICE is an open protocol for measured boot compatible
with the Trusted Computing Group's Device Identifier Composition
Engine (DICE) specification. The generated Compound Device Identifier
(CDI) certificates represent the hardware/software combination measured
by DICE, and can be used for remote attestation and sealing.

Add a driver that exposes reserved memory regions populated by firmware
with DICE CDIs and exposes them to userspace via a character device.

Userspace obtains the memory region's size from read() and calls mmap()
to create a mapping of the memory region in its address space. The
mapping is not allowed to be write+shared, giving userspace a guarantee
that the data were not overwritten by another process.

Userspace can also call write(), which triggers a wipe of the DICE data
by the driver. Because both the kernel and userspace mappings use
write-combine semantics, all clients observe the memory as zeroed after
the syscall has returned.

Cc: Andrew Scull <ascull@google.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/misc/Kconfig     |  12 +++
 drivers/misc/Makefile    |   1 +
 drivers/misc/open-dice.c | 197 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100644 drivers/misc/open-dice.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0f5a49fc7c9e..4d996485f5a7 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -470,6 +470,18 @@ config HISI_HIKEY_USB
 	  switching between the dual-role USB-C port and the USB-A host ports
 	  using only one USB controller.
 
+config OPEN_DICE
+	tristate "Open Profile for DICE driver"
+	depends on OF_RESERVED_MEM
+	help
+	  This driver exposes a DICE reserved memory region to userspace via
+	  a character device. The memory region contains Compound Device
+	  Identifiers (CDIs) generated by firmware as an output of DICE
+	  measured boot flow. Userspace can uses CDIs for remote attestation
+	  and sealing.
+
+	  If unsure, say N.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a086197af544..70e800e9127f 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
+obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
new file mode 100644
index 000000000000..ea7b1a8d49ac
--- /dev/null
+++ b/drivers/misc/open-dice.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 - Google LLC
+ * Author: David Brazdil <dbrazdil@google.com>
+ *
+ * Driver for Open Profile for DICE.
+ *
+ * This driver takes ownership of a reserved memory region containing secrets
+ * derived following the Open Profile for DICE. The contents of the memory
+ * region are not interpreted by the kernel but can be mapped into a userspace
+ * process via a misc device. The memory region can also be wiped, removing
+ * the secrets from memory.
+ *
+ * Userspace can access the data by (w/o error handling):
+ *
+ *     fd = open("/dev/open-dice0", O_RDWR);
+ *     size = read(fd, NULL, 0);
+ *     data = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+ *     write(fd, NULL, 0); // wipe
+ *     close(fd);
+ */
+
+#include <linux/io.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+
+#define DRIVER_NAME "open-dice"
+
+struct open_dice_drvdata {
+	spinlock_t lock;
+	char name[16];
+	struct reserved_mem *rmem;
+	struct miscdevice misc;
+};
+
+static inline struct open_dice_drvdata *to_open_dice_drvdata(struct file *filp)
+{
+	return container_of(filp->private_data, struct open_dice_drvdata, misc);
+}
+
+static int open_dice_size(struct open_dice_drvdata *drvdata)
+{
+	/* '0 < size <= INT_MAX' is checked in the probe function. */
+	return drvdata->rmem->size;
+}
+
+static int open_dice_wipe(struct open_dice_drvdata *drvdata)
+{
+	void *kaddr;
+
+	spin_lock(&drvdata->lock);
+	kaddr = devm_memremap(drvdata->misc.this_device, drvdata->rmem->base,
+			      drvdata->rmem->size, MEMREMAP_WC);
+	if (IS_ERR(kaddr)) {
+		spin_unlock(&drvdata->lock);
+		return PTR_ERR(kaddr);
+	}
+
+	memset(kaddr, 0, drvdata->rmem->size);
+	devm_memunmap(drvdata->misc.this_device, kaddr);
+	spin_unlock(&drvdata->lock);
+	return 0;
+}
+
+/**
+ * Returns the size of the reserved memory region. The user-provided pointer is
+ * never dereferenced.
+ */
+static ssize_t open_dice_read(struct file *filp, char __user *ptr, size_t len,
+			      loff_t *off)
+{
+	return open_dice_size(to_open_dice_drvdata(filp));
+}
+
+/**
+ * Triggers a wipe of the reserved memory region. The user-provided pointer is
+ * never dereferenced.
+ */
+static ssize_t open_dice_write(struct file *filp, const char __user *ptr,
+			       size_t len, loff_t *off)
+{
+	return open_dice_wipe(to_open_dice_drvdata(filp));
+}
+
+/**
+ * Creates a mapping of the reserved memory region in a user address space.
+ */
+static int open_dice_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct open_dice_drvdata *drvdata = to_open_dice_drvdata(filp);
+
+	/* Do not allow userspace to modify the underlying data. */
+	if ((vma->vm_flags & VM_WRITE) && (vma->vm_flags & VM_SHARED))
+		return -EPERM;
+
+	/* Create write-combine mapping so all clients observe a wipe. */
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	vma->vm_flags |= VM_DONTCOPY | VM_DONTDUMP;
+	return vm_iomap_memory(vma, drvdata->rmem->base, drvdata->rmem->size);
+}
+
+static const struct file_operations open_dice_fops = {
+	.read = open_dice_read,
+	.write = open_dice_write,
+	.mmap = open_dice_mmap,
+};
+
+static int __init open_dice_probe(struct platform_device *pdev)
+{
+	static size_t dev_idx;
+	struct device *dev = &pdev->dev;
+	struct device_node *rmem_np;
+	struct reserved_mem *rmem;
+	struct open_dice_drvdata *drvdata;
+	int ret;
+
+	rmem_np = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (!rmem_np) {
+		dev_err(dev, "missing 'memory-region' property\n");
+		return -EINVAL;
+	}
+
+	rmem = of_reserved_mem_lookup(rmem_np);
+	of_node_put(rmem_np);
+	if (!rmem) {
+		dev_err(dev, "failed to lookup reserved memory\n");
+		return -EINVAL;
+	}
+
+	if (!rmem->size || (rmem->size > INT_MAX)) {
+		dev_err(dev, "invalid memory region size\n");
+		return -EINVAL;
+	}
+
+	if (!PAGE_ALIGNED(rmem->base) || !PAGE_ALIGNED(rmem->size)) {
+		dev_err(dev, "memory region must be page-aligned\n");
+		return -EINVAL;
+	}
+
+	drvdata = devm_kmalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	*drvdata = (struct open_dice_drvdata){
+		.lock = __SPIN_LOCK_UNLOCKED(drvdata->lock),
+		.rmem = rmem,
+		.misc = (struct miscdevice){
+			.parent	= dev,
+			.name	= drvdata->name,
+			.minor	= MISC_DYNAMIC_MINOR,
+			.fops	= &open_dice_fops,
+			.mode	= 0600,
+		},
+	};
+
+	/* Index overflow check not needed. misc_register() will fail. */
+	snprintf(drvdata->name, sizeof(drvdata->name), DRIVER_NAME"%d", dev_idx++);
+
+	ret = misc_register(&drvdata->misc);
+	if (ret) {
+		dev_err(dev, "failed to register misc device '%s': %d\n",
+			drvdata->name, ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, drvdata);
+	return 0;
+}
+
+static int open_dice_remove(struct platform_device *pdev)
+{
+	struct open_dice_drvdata *drvdata = platform_get_drvdata(pdev);
+
+	misc_deregister(&drvdata->misc);
+	return 0;
+}
+
+static const struct of_device_id open_dice_of_match[] = {
+	{ .compatible = "google,open-dice" },
+	{},
+};
+
+static struct platform_driver open_dice_driver = {
+	.remove = open_dice_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = open_dice_of_match,
+	},
+};
+
+module_platform_driver_probe(open_dice_driver, open_dice_probe);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("David Brazdil <dbrazdil@google.com>");
-- 
2.34.1.173.g76aa8bc2d0-goog

