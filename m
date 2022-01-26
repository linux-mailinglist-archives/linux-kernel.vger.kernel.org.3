Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64C049D604
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiAZXNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiAZXM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:12:58 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E56C061748
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:12:57 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso604469wmb.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jz5nT6IxUun/IIsla62xxjEmgJ8/cgjOJmGN7YMpXI0=;
        b=nvHjSZ4oFlP/ViObmLn7mhwyUQVPTnkH/BBHa5zW2QQ1t97/kP1AZW2Mgq/2lKRVSw
         BjnYPtR3X7NmIDE7HHavhQBit6bYkOhk4sR3PlW5EJHmedp0vfnNTiW6/PbPbQ/kJOEz
         ph63f1rJLpsscpyf8s2db0vRfplPdlbVt4u/iVtKMgIVjWyka7tyikOGzx9s8D+IQpbd
         NuPx+XjvTAsmaXNZ5mjby4fDmhcnfaiT+2c7lkC96gC/MXP+8DhJB0201gkdYWsyUU3X
         HLIBk2e+WOH0tT/LVUuIfKEogaJ2q1/H7K2KAuFQcxg1GlNDIRXQDKsfnMvBY+BLEOVP
         /ydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jz5nT6IxUun/IIsla62xxjEmgJ8/cgjOJmGN7YMpXI0=;
        b=KRXckK7QIwQNlcorzCvraFY4ivrXyg4SNbaGZbCl8kONorxG3FI6OO/hxDBWAZ2sdZ
         eNrQPy4eOxgyu2jFfcg9byIV508lASc1h9BPW+PNizi/Gisjqi7R7AS9BGuFIzjh1Fyp
         D/j4z0PBWjNor+cJO6m7gJCwEM8VM8696FFik23uykcTKkfmXSvxuIiX2gOINbLpuCK7
         gvuV5cmso4srKCIGXU8T8gHj3uei9LZ8AUBWekOTEYTdbr1ZFiFPKpuLzjbSvvQBpGuW
         0pb6SDgZ2JBhnb4jgTHJ5/G2igQhNsUCfo7TRajqfN8gvb9YbsLW7Br24LHWFBUxAayp
         e1qw==
X-Gm-Message-State: AOAM532Y14wXlmtUwMJrfMCfR75pVJoZ9G6kZwBZ+EZFo+zvQf9HOeMj
        Vw4rDJxRyt5qNspXzveiPJcTfJzKLOJGPA==
X-Google-Smtp-Source: ABdhPJzsM21LS3Q7uRnccC+nmYJODL2vfxJW9tZS+muJ2O6O0w/UPo9iNAe6UU3VDPprEgTavXFuP+KoazV2IQ==
X-Received: from dbrazdil.lon.corp.google.com ([2a00:79e0:d:209:bd2e:4d3b:b065:fa46])
 (user=dbrazdil job=sendgmr) by 2002:a7b:c145:: with SMTP id
 z5mr941296wmi.0.1643238775707; Wed, 26 Jan 2022 15:12:55 -0800 (PST)
Date:   Wed, 26 Jan 2022 23:12:37 +0000
In-Reply-To: <20220126231237.529308-1-dbrazdil@google.com>
Message-Id: <20220126231237.529308-3-dbrazdil@google.com>
Mime-Version: 1.0
References: <20220126231237.529308-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v7 2/2] misc: open-dice: Add driver to expose DICE data to userspace
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
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

Acked-by: Rob Herring <robh@kernel.org>
Cc: Andrew Scull <ascull@google.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/misc/Kconfig     |  12 +++
 drivers/misc/Makefile    |   1 +
 drivers/misc/open-dice.c | 208 +++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c    |   1 +
 4 files changed, 222 insertions(+)
 create mode 100644 drivers/misc/open-dice.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0f5a49fc7c9e..a2b26426efba 100644
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
+	  measured boot flow. Userspace can use CDIs for remote attestation
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
index 000000000000..c61be3404c6f
--- /dev/null
+++ b/drivers/misc/open-dice.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 - Google LLC
+ * Author: David Brazdil <dbrazdil@google.com>
+ *
+ * Driver for Open Profile for DICE.
+ *
+ * This driver takes ownership of a reserved memory region containing data
+ * generated by the Open Profile for DICE measured boot protocol. The memory
+ * contents are not interpreted by the kernel but can be mapped into a userspace
+ * process via a misc device. Userspace can also request a wipe of the memory.
+ *
+ * Userspace can access the data with (w/o error handling):
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
+	struct mutex lock;
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
+	mutex_lock(&drvdata->lock);
+	kaddr = devm_memremap(drvdata->misc.this_device, drvdata->rmem->base,
+			      drvdata->rmem->size, MEMREMAP_WC);
+	if (IS_ERR(kaddr)) {
+		mutex_unlock(&drvdata->lock);
+		return PTR_ERR(kaddr);
+	}
+
+	memset(kaddr, 0, drvdata->rmem->size);
+	devm_memunmap(drvdata->misc.this_device, kaddr);
+	mutex_unlock(&drvdata->lock);
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
+ * Triggers a wipe of the reserved memory region. The user-provided pointer
+ * is never dereferenced.
+ */
+static ssize_t open_dice_write(struct file *filp, const char __user *ptr,
+			       size_t len, loff_t *off)
+{
+	if (open_dice_wipe(to_open_dice_drvdata(filp)))
+		return -EIO;
+
+	/* Consume the input buffer. */
+	return len;
+}
+
+/*
+ * Creates a mapping of the reserved memory region in user address space.
+ */
+static int open_dice_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct open_dice_drvdata *drvdata = to_open_dice_drvdata(filp);
+
+	/* Do not allow userspace to modify the underlying data. */
+	if ((vma->vm_flags & VM_WRITE) && (vma->vm_flags & VM_SHARED))
+		return -EPERM;
+
+	/* Ensure userspace cannot acquire VM_WRITE + VM_SHARED later. */
+	if (vma->vm_flags & VM_WRITE)
+		vma->vm_flags &= ~VM_MAYSHARE;
+	else if (vma->vm_flags & VM_SHARED)
+		vma->vm_flags &= ~VM_MAYWRITE;
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
+	struct reserved_mem *rmem;
+	struct open_dice_drvdata *drvdata;
+	int ret;
+
+	rmem = of_reserved_mem_lookup(dev->of_node);
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
+		.lock = __MUTEX_INITIALIZER(drvdata->lock),
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
+	/* Index overflow check not needed, misc_register() will fail. */
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
+static int __init open_dice_init(void)
+{
+	int ret = platform_driver_probe(&open_dice_driver, open_dice_probe);
+
+	/* DICE regions are optional. Succeed even with zero instances. */
+	return (ret == -ENODEV) ? 0 : ret;
+}
+
+static void __exit open_dice_exit(void)
+{
+	platform_driver_unregister(&open_dice_driver);
+}
+
+module_init(open_dice_init);
+module_exit(open_dice_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("David Brazdil <dbrazdil@google.com>");
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 793350028906..a16b74f32aa9 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -514,6 +514,7 @@ static const struct of_device_id reserved_mem_matches[] = {
 	{ .compatible = "qcom,smem" },
 	{ .compatible = "ramoops" },
 	{ .compatible = "nvmem-rmem" },
+	{ .compatible = "google,open-dice" },
 	{}
 };
 
-- 
2.35.0.rc0.227.g00780c9af4-goog

