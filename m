Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE1446EADF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbhLIPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbhLIPPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:15:15 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B627CC0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:11:41 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q7-20020adff507000000b0017d160d35a8so1506256wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 07:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HAIE2N1rLpj+MNpgeaPMo0s8u4ndic3hqGHpZLvEDr4=;
        b=ovky0yDq6BeIHLXa2TOcqEmeqx5BH/WNOAMNGbBgjqHFOR2nq3lEXJg4JjfVZJbMf7
         RA+cBouTteTI2DD0DRAOs705BaAbQikOMBmw0wuk20J3g/RxEMcAqCIzjWmFq9I/noO9
         X3zE1e/dVT6lW6+JWijMmNQnG/TcFczHWAdAHKk9hbk/aQYV1/89owl8MK/fJJMRftFD
         3yNgsPY8JSoIrhR9JAvXVViZi8wneRYBmI4RSHJnTKV11d89VlH23hCo3CGdNpc1LGh+
         gB8CwpGXTjjDLVNsot01tJVYFOeVsDmQpmlpw22HMO5YoKj6TVeiEftGZQFQ+JZGvnzo
         CnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HAIE2N1rLpj+MNpgeaPMo0s8u4ndic3hqGHpZLvEDr4=;
        b=5RpC2P3UPur6nJg8mtQJcOcnppb654/vakA0HnlXkWC4Xbkj65pbkVw9CnWUtM0YyL
         ZCuBMnksK5oLpKX+xz481UhdNQZVzI9kXjrBq2WsXTXuxgTjPK5DR/OkWAEH79Kv1owd
         M+u+GoCCkTzrHGsJUS7m2a85dJsmDCIJAs0BcergjHGHoIw0eRIYPteZu0839syFUA32
         WBiLc3ACC4K78Hi2Y1NfETZFWJcbT6UMHKKlKdyUo4BQx/7PTPBWhcDBLRqE/16Vb1i1
         sVSEj2GWLVSlgQi6RGHTbQ7jiabEOYXtCvPy/JvOlHUeBvZkSjK7GtvEKP7ykc4Q7V+K
         RnJw==
X-Gm-Message-State: AOAM530IWfK2wlhBAOROcod+Uua+ASYenPgIiG6z5bR5/FwsoPp7j0BF
        gtZzgIrv5RvX4nIBtJfQQlUXJkNFQPK6eg==
X-Google-Smtp-Source: ABdhPJzfyofgKUxSiNeuHzmszjfdjaFroDZBIWHdD/40xDiJZNJMfUiFXi8BUZnR3OQBJyXc/Wjp+VbWG0brNA==
X-Received: from dbrazdil.lon.corp.google.com ([2a00:79e0:d:209:8f9e:94f7:810:211b])
 (user=dbrazdil job=sendgmr) by 2002:a1c:208b:: with SMTP id
 g133mr8038039wmg.128.1639062700123; Thu, 09 Dec 2021 07:11:40 -0800 (PST)
Date:   Thu,  9 Dec 2021 15:11:23 +0000
In-Reply-To: <20211209151123.3759999-1-dbrazdil@google.com>
Message-Id: <20211209151123.3759999-3-dbrazdil@google.com>
Mime-Version: 1.0
References: <20211209151123.3759999-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v2 2/2] misc: dice: Add driver to forward secrets to userspace
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

Open Profile for DICE is a protocol for deriving unique secrets at boot
used by some Android devices. The firmware/bootloader hands over secrets
in a reserved memory region, which this driver takes ownership of and
exposes it to userspace via a misc device.

Userspace obtains the region's size using an ioctl and mmaps the memory
to its address space. This mapping cannot be write+shared, giving
userspace a guarantee that the secrets have not been overwritten by
another process.

Userspace can also issue an ioctl requesting that the memory be wiped by
the driver. Because both the kernel and userspace mappings use
write-combine semantics, all clients will observe the memory as zeroed
after the ioctl has returned.

Cc: Andrew Scull <ascull@google.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/misc/Kconfig                          |   8 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/dice.c                           | 161 ++++++++++++++++++
 include/uapi/linux/dice.h                     |  14 ++
 5 files changed, 185 insertions(+)
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
index 000000000000..06f3754feb71
--- /dev/null
+++ b/drivers/misc/dice.c
@@ -0,0 +1,161 @@
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
+ *     int fd = open("/dev/dice", O_RDONLY | O_CLOEXEC);
+ *     size_t size = ioctl(fd, DICE_GET_SIZE);
+ *     void *data = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+ *     ioctl(fd, DICE_WIPE);
+ *     close(fd);
+ */
+
+#include <linux/dice.h>
+#include <linux/io.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+
+static int dice_mmap(struct file *filp, struct vm_area_struct *vma);
+static long dice_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+
+static const struct file_operations dice_fops = {
+	.mmap = dice_mmap,
+	.unlocked_ioctl = dice_ioctl,
+};
+
+static struct miscdevice dice_misc = {
+	.name	= "dice",
+	.minor	= MISC_DYNAMIC_MINOR,
+	.fops	= &dice_fops,
+	.mode	= 0400,
+};
+
+static struct reserved_mem *dice_rmem;
+static DEFINE_SPINLOCK(dice_lock);
+
+static int dice_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	/* Do not allow userspace to modify the underlying data. */
+	if ((vma->vm_flags & VM_WRITE) && (vma->vm_flags & VM_SHARED))
+		return -EPERM;
+
+	/* Create write-combine mapping so all clients observe a wipe. */
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	vma->vm_flags |= VM_DONTCOPY | VM_DONTDUMP;
+	return vm_iomap_memory(vma, dice_rmem->base, dice_rmem->size);
+}
+
+static int dice_wipe(void)
+{
+	void *kaddr;
+
+	spin_lock(&dice_lock);
+	kaddr = devm_memremap(dice_misc.this_device, dice_rmem->base,
+			      dice_rmem->size, MEMREMAP_WC);
+	if (IS_ERR(kaddr)) {
+		spin_unlock(&dice_lock);
+		return PTR_ERR(kaddr);
+	}
+
+	memzero_explicit(kaddr, dice_rmem->size);
+	devm_memunmap(dice_misc.this_device, kaddr);
+	spin_unlock(&dice_lock);
+	return 0;
+}
+
+static long dice_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case DICE_GET_SIZE:
+		/* Checked against INT_MAX in dice_probe(). */
+		return dice_rmem->size;
+	case DICE_WIPE:
+		return dice_wipe();
+	}
+
+	return -ENOIOCTLCMD;
+}
+
+static int __init dice_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *rmem_np;
+	struct reserved_mem *rmem;
+	int ret;
+
+	if (dice_rmem) {
+		dev_err(dev, "only one instance of device allowed\n");
+		return -EBUSY;
+	}
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
+	if (!rmem->size || (rmem->size > INT_MAX)) {
+		dev_err(dev, "invalid memory region size\n");
+		return -EINVAL;
+	}
+
+	dice_misc.parent = dev;
+	ret = misc_register(&dice_misc);
+	if (ret) {
+		dev_err(dev, "failed to register misc device: %d\n", ret);
+		return ret;
+	}
+
+	dice_rmem = rmem;
+	return 0;
+}
+
+static int dice_remove(struct platform_device *pdev)
+{
+	misc_deregister(&dice_misc);
+	dice_rmem = NULL;
+	return 0;
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
+module_platform_driver_probe(dice_driver, dice_probe);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("David Brazdil <dbrazdil@google.com>");
diff --git a/include/uapi/linux/dice.h b/include/uapi/linux/dice.h
new file mode 100644
index 000000000000..68f7304408ed
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
+#define DICE_GET_SIZE	_IO(0xAE, 0x40)
+#define DICE_WIPE	_IO(0xAE, 0x41)
+
+#endif
--
2.34.1.400.ga245620fadb-goog
