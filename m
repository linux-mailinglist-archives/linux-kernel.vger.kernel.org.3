Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200B346BB74
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhLGMkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbhLGMkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:40:11 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E4AC061354
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:36:41 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id d7-20020a5d6447000000b00186a113463dso2903043wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 04:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+it6TBuEONNY2ktvfP0dJvqwNkGpFBVOgIY34wKk8II=;
        b=RAli2KT98sQtxF3L1GfsfWOTrzmwEV+EChdt9LbzGLN6mtyivD8mVu8AHBbBMd/lv8
         DuQryvypnlTVA7PDkCvBEiwuR43/d5ulu3bOk8anNxLHCsGuvz3H/7HB/w8Tpen9NySJ
         oK69MTseXelexN9S4r9XAR5dyheivPvdvygI+I9BSC+ZXElCDHz7sWeJF+6hGptN9cRw
         GzNIiWhrcHQbzhhjsF2xs/VbQ6Y2rLDkBxu4NfKan1ogfQ/XwIorjn9SPvHWahKG60HO
         PW8cUjJ0uyiV2JrFF6Ay8rH5dU3CAHpIQRkCHRTOrjLMnwOzzg8mdRIE/AskL57A9mzz
         g7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+it6TBuEONNY2ktvfP0dJvqwNkGpFBVOgIY34wKk8II=;
        b=J+scDRcc4nF/GUR7fLqxxFXNj0CIO/j9ShbCpAyoEYV1zt2VDKvuAApdGTd2Rgr1fm
         4HOdXUOHHHQdIlFnkb5biuvvSydwdzH51vmeoZ0i6M+WQBuK2Ez1ZCoSP/M9fH/nIsse
         AzuluL73vxOK1LFxjr01pA47wIHWAHrqXKDBNj4u7LpTKiJ1F0Uh74OypV+MgmLsPX7J
         6vY7NP6dt/VExUXL6IXG3FlLuGjNYLLU1Src1efEyvLBj0tHx6vdNaTxG4HlQ8O5R07m
         P2xzzg2UbQ4E5w3YjOkywxIOp4Bmwz78TOlTiZ3Zm8NapqVlBa4cRuf6YfgFVdrKkHPQ
         2kQg==
X-Gm-Message-State: AOAM5338mHOkLAC+wfGDO9YbwoNXCrJb00ijlqqUMSHSfSW+UAxxmB2+
        8bMMVEuYDPWBYXrZyEllm6fDfkJiOO9DwA==
X-Google-Smtp-Source: ABdhPJyya6wiHVXArEx3+3ZMPZfIi7EyFOTY3MM12XkPq/vPyNS80v2L9sFeaoEYu7npIMFepEs3dQlxIQeMvw==
X-Received: from dbrazdil.lon.corp.google.com ([2a00:79e0:d:209:cb8b:b013:316d:b2f1])
 (user=dbrazdil job=sendgmr) by 2002:a7b:cd0b:: with SMTP id
 f11mr6648138wmj.3.1638880599568; Tue, 07 Dec 2021 04:36:39 -0800 (PST)
Date:   Tue,  7 Dec 2021 12:36:17 +0000
In-Reply-To: <20211207123617.3040177-1-dbrazdil@google.com>
Message-Id: <20211207123617.3040177-3-dbrazdil@google.com>
Mime-Version: 1.0
References: <20211207123617.3040177-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 2/2] misc: dice: Add driver to forward secrets to userspace
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Brazdil <dbrazdil@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Open Profile for DICE is a protocol for deriving unique secrets at boot,
used by some Android devices. The firmware/bootloader hands over secrets
in a reserved memory region, this driver takes ownership of the memory
region and exposes it to userspace via a character device that
lets userspace mmap the memory region into its process.

The character device can only be opened once at any given time.

Userspace can issue an ioctl requesting that the memory be wiped after
the current FD is released. In that case, the driver will clear
the buffer and refuse to open any new FDs.

Cc: Andrew Scull <ascull@google.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/misc/Kconfig                          |   8 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/dice.c                           | 254 ++++++++++++++++++
 include/uapi/linux/dice.h                     |  14 +
 5 files changed, 278 insertions(+)
 create mode 100644 drivers/misc/dice.c
 create mode 100644 include/uapi/linux/dice.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index cfe6cccf0f44..4b8bee2ffd1e 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -341,6 +341,7 @@ Code  Seq#    Include File                                           Comments
 0xAE  40-FF  linux/kvm.h                                             Kernel-based Virtual Machine
                                                                      <mailto:kvm@vger.kernel.org>
 0xAE  20-3F  linux/nitro_enclaves.h                                  Nitro Enclaves
+0xAE  40-5F  uapi/linux/dice.h                                       Open Profile for DICE driver
 0xAF  00-1F  linux/fsl_hypervisor.h                                  Freescale hypervisor
 0xB0  all                                                            RATIO devices in development:
                                                                      <mailto:vgo@ratio.de>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0f5a49fc7c9e..7165f4b6c41b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -470,6 +470,14 @@ config HISI_HIKEY_USB
 	  switching between the dual-role USB-C port and the USB-A host ports
 	  using only one USB controller.
 
+config DICE
+	tristate "Open Profile for DICE driver"
+	depends on OF_RESERVED_MEM
+	help
+	  This driver allows to ownership of a reserved memory region
+	  containing DICE secrets and expose them to userspace via
+	  a character device.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a086197af544..f73c6bb23ccd 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
+obj-$(CONFIG_DICE)		+= dice.o
diff --git a/drivers/misc/dice.c b/drivers/misc/dice.c
new file mode 100644
index 000000000000..c5217793328e
--- /dev/null
+++ b/drivers/misc/dice.c
@@ -0,0 +1,254 @@
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
+ * process via a character device. The memory region can also be wiped, removing
+ * the secrets from memory.
+ *
+ * Userspace can access the data by (w/o error handling):
+ *
+ *     int fd = open("/dev/dice", O_RDONLY | O_CLOEXEC);
+ *     size_t size = ioctl(fd, DICE_GET_SIZE);
+ *     ioctl(fd, DICE_SET_WIPE_ON_CLOSE);
+ *     void *data = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+ *     close(fd);
+ */
+
+#include <linux/cdev.h>
+#include <linux/dice.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+
+#define DICE_MKDEV		MKDEV(MAJOR(dice_devt), 0)
+#define DICE_MINOR_COUNT	1
+
+enum dice_state {
+	DICE_STATE_READY = 0,
+	DICE_STATE_BUSY,
+	DICE_STATE_BUSY_WIPE_ON_CLOSE,
+	DICE_STATE_WIPED,
+};
+
+struct dice_data {
+	struct device *dev;
+	struct cdev cdev;
+	atomic_t state;
+	phys_addr_t base;
+	size_t size;
+};
+
+static dev_t dice_devt;
+static struct class *dice_class;
+
+static int dice_open(struct inode *inode, struct file *filp)
+{
+	struct dice_data *data;
+
+	data = container_of(inode->i_cdev, struct dice_data, cdev);
+
+	/* Never allow write access. */
+	if (filp->f_mode & FMODE_WRITE)
+		return -EROFS;
+
+	switch (atomic_cmpxchg(&data->state, DICE_STATE_READY, DICE_STATE_BUSY)) {
+	case DICE_STATE_READY:
+		break;
+	case DICE_STATE_WIPED:
+		/* Return error to inform caller memory has been wiped. */
+		return -EACCES;
+	default:
+		return -EBUSY;
+	}
+
+	filp->private_data = data;
+	nonseekable_open(inode, filp);
+	return 0;
+}
+
+static int dice_release(struct inode *inode, struct file *filp)
+{
+	struct dice_data *data = filp->private_data;
+	void *base;
+
+	if (atomic_read(&data->state) == DICE_STATE_BUSY_WIPE_ON_CLOSE) {
+		base = devm_memremap(data->dev, data->base, data->size, MEMREMAP_WT);
+		if (!WARN_ON(!base)) {
+			memzero_explicit(base, data->size);
+			devm_memunmap(data->dev, base);
+		}
+		atomic_set(&data->state, DICE_STATE_WIPED);
+		return 0;
+	}
+
+	atomic_set(&data->state, DICE_STATE_READY);
+	return 0;
+}
+
+static int dice_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct dice_data *data = filp->private_data;
+
+	vma->vm_flags |= VM_DONTCOPY;
+	return vm_iomap_memory(vma, data->base, data->size);
+}
+
+static long dice_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct dice_data *data = filp->private_data;
+
+	switch (cmd) {
+	case DICE_GET_SIZE:
+		/* Checked against INT_MAX in dice_probe(). */
+		return data->size;
+	case DICE_SET_WIPE_ON_CLOSE:
+		atomic_set(&data->state, DICE_STATE_BUSY_WIPE_ON_CLOSE);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations dice_fops = {
+	.open = dice_open,
+	.release = dice_release,
+	.mmap = dice_mmap,
+	.unlocked_ioctl = dice_ioctl,
+	.llseek = no_llseek,
+};
+
+static int __init dice_probe(struct platform_device *pdev)
+{
+	struct device *chr_dev, *dev = &pdev->dev;
+	struct device_node *rmem_np;
+	struct reserved_mem *rmem;
+	struct dice_data *data;
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
+	if (!PAGE_ALIGNED(rmem->base) || !PAGE_ALIGNED(rmem->size)) {
+		dev_err(dev, "memory region must be page-aligned\n");
+		return -EINVAL;
+	}
+
+	if (rmem->size > INT_MAX) {
+		dev_err(dev, "memory region too large\n");
+		return -EINVAL;
+	}
+
+	data = devm_kmalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	*data = (struct dice_data){
+		.dev = dev,
+		.base = rmem->base,
+		.size = rmem->size,
+		.state = ATOMIC_INIT(DICE_STATE_READY),
+	};
+
+	cdev_init(&data->cdev, &dice_fops);
+	data->cdev.owner = THIS_MODULE;
+	ret = cdev_add(&data->cdev, DICE_MKDEV, 1);
+	if (ret)
+		return ret;
+
+	chr_dev = device_create(dice_class, dev, DICE_MKDEV, NULL, "dice");
+	if (IS_ERR(chr_dev)) {
+		cdev_del(&data->cdev);
+		return PTR_ERR(chr_dev);
+	}
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+}
+
+static int dice_remove(struct platform_device *pdev)
+{
+	struct dice_data *data = platform_get_drvdata(pdev);
+
+	cdev_del(&data->cdev);
+	device_destroy(dice_class, DICE_MKDEV);
+	return 0;
+}
+
+static char *dice_devnode(struct device *dev, umode_t *mode)
+{
+	/* Initial permissions: read-only by owner */
+	if (mode)
+		*mode = 0400;
+	return NULL;
+}
+
+static const struct of_device_id dice_of_match[] = {
+	{ .compatible = "google,dice" },
+	{},
+};
+
+static struct platform_driver dice_driver = {
+	.remove = dice_remove,
+	.driver = {
+		.name = "dice",
+		.of_match_table = dice_of_match,
+	},
+};
+
+static int __init dice_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&dice_devt, 0, DICE_MINOR_COUNT, "dice");
+	if (ret)
+		return ret;
+
+	dice_class = class_create(THIS_MODULE, "dice");
+	if (IS_ERR(dice_class)) {
+		ret = PTR_ERR(dice_class);
+		goto fail;
+	}
+	dice_class->devnode = dice_devnode;
+
+	ret = platform_driver_probe(&dice_driver, dice_probe);
+	if (ret)
+		goto fail;
+
+	return 0;
+
+fail:
+	class_destroy(dice_class);
+	unregister_chrdev_region(dice_devt, DICE_MINOR_COUNT);
+	return ret;
+}
+
+static void __exit dice_exit(void)
+{
+	platform_driver_unregister(&dice_driver);
+	class_destroy(dice_class);
+	unregister_chrdev_region(dice_devt, DICE_MINOR_COUNT);
+}
+
+module_init(dice_init);
+module_exit(dice_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("David Brazdil <dbrazdil@google.com>");
diff --git a/include/uapi/linux/dice.h b/include/uapi/linux/dice.h
new file mode 100644
index 000000000000..19d679c56d06
--- /dev/null
+++ b/include/uapi/linux/dice.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * IOCTLs for Open Profile for DICE character device
+ */
+
+#ifndef _UAPI_DICE_H_
+#define _UAPI_DICE_H_
+
+#include <linux/ioctl.h>
+
+#define DICE_GET_SIZE		_IO(0xAE, 0x40)
+#define DICE_SET_WIPE_ON_CLOSE	_IO(0xAE, 0x41)
+
+#endif
-- 
2.34.1.400.ga245620fadb-goog

