Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DC6475B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243673AbhLOPEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243619AbhLOPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:04:34 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE015C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:04:33 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id v32-20020a05622a18a000b002b04d0d410dso30080657qtc.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=83InAJ/9TQT5U91Xgie7r2BlKtNP2vhF+If+0wRYzsg=;
        b=XdNgZz4rMxXsSFOfMtQ1EITNJ1K3Io9XZ9X6QdIgMQroX4DPSyplBMF1zUYo1W9rOy
         TyeJzUzm1Il2LCa/R3t3JKRqR7aFdLLLTY5JnJlqtQ3EDzD5b4NiLcu08nHsOC1FVils
         wR6L3nDjgEYKYqcHmkn7U1VrmKZlPUV47DIgPj6fpuFEShSIbtxzs2M4isOVk8P++Yuy
         DsPZaA8TwgbzFaRHP3V0jwZ2VCQcEiazfdsnMU4MUpAzs2otnGwBdD6aML2M+pRs3Cqp
         +DBuFPAvcrkUJNuXWrXzmT9dl7EQd78yD5+r20z6ru8Fvrk1swMo+X5WWzHYWdGj49wG
         tV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=83InAJ/9TQT5U91Xgie7r2BlKtNP2vhF+If+0wRYzsg=;
        b=O2nTZyOxFENrrkEcSjFHraDjmaYZJLF/4cSfh7741/NQ98oRuS/Yw+zgJom9CCjSZP
         vXPK1Ov6RU5tKdFEk7Pz+7P3Bh/Tq9Xk82ut9/fILGihf92yvbxLWY6p1c1dR3Y4QglP
         HOsEcr+tMe9Zd59+F693gaDQ37lP9YEK8tAwgMrNOVOH6vdouadGJalKwc6+qwGozgRT
         syUYYMH9ePQ7M4b47UmTO2SN3ToJKCNz2peBZf0fvLOs9auyCFJxo3TIn6x4MvzK7gKA
         Iw0EQMowzKNLLNXNmm+dPIwk5HhDAizslzvRIHbY9eLLiUt3M76a3mcd4dgZq/OYE2Rl
         a86w==
X-Gm-Message-State: AOAM532wXLZ3Y06QFs2aQLUxRYJsD0SKtOlFSZyX+wLNUAs5TipMAbca
        tsCTJY9NjCOHahyTAQEZyxbGcAVQbvMSmw==
X-Google-Smtp-Source: ABdhPJzAMGmcw6wDsNf6yQSJtkHecIaqOXJ3FheR+S5+0hHgawiFxjuyuMyDej/GLiS4uLFx4j1JmXSupTmwug==
X-Received: from dbrazdil.lon.corp.google.com ([2a00:79e0:d:209:8505:8095:9f82:42b7])
 (user=dbrazdil job=sendgmr) by 2002:a05:622a:145:: with SMTP id
 v5mr12652852qtw.146.1639580673037; Wed, 15 Dec 2021 07:04:33 -0800 (PST)
Date:   Wed, 15 Dec 2021 15:04:10 +0000
In-Reply-To: <20211215150410.1707849-1-dbrazdil@google.com>
Message-Id: <20211215150410.1707849-3-dbrazdil@google.com>
Mime-Version: 1.0
References: <20211215150410.1707849-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 2/2] misc: open-dice: Add driver to expose DICE data to userspace
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
index 000000000000..8ad5f07dcd55
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
+ *     read(fd, &size, sizeof(unsigned long));
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
+/*
+ * Copies the size of the reserved memory region to the user-provided buffer.
+ */
+static ssize_t open_dice_read(struct file *filp, char __user *ptr, size_t len,
+			      loff_t *off)
+{
+	unsigned long val = to_open_dice_drvdata(filp)->rmem->size;
+
+	return simple_read_from_buffer(ptr, len, off, &val, sizeof(val));
+}
+
+/*
+ * Triggers a wipe of the reserved memory region. The user-provided pointer is
+ * never dereferenced.
+ */
+static ssize_t open_dice_write(struct file *filp, const char __user *ptr,
+			       size_t len, loff_t *off)
+{
+	if (open_dice_wipe(to_open_dice_drvdata(filp)))
+		return -EIO;
+
+	/* Consume the buffer. */
+	return len;
+}
+
+/*
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
+	.owner = THIS_MODULE,
+	.read = open_dice_read,
+	.write = open_dice_write,
+	.mmap = open_dice_mmap,
+};
+
+static int __init open_dice_probe(struct platform_device *pdev)
+{
+	static unsigned int dev_idx;
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
+	if (!rmem->size || (rmem->size > ULONG_MAX)) {
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
+	snprintf(drvdata->name, sizeof(drvdata->name), DRIVER_NAME"%u", dev_idx++);
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

