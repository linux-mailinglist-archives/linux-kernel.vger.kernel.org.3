Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7790483F9B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiADKHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiADKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:06:58 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B907C06179C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 02:06:56 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id f13-20020adfe90d000000b001a15c110077so11464354wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 02:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2bOH2oJjIvdfSW7pk+D64LWeafheAKYSzcyVanqLfZc=;
        b=E2Fy6UidtejNOcRBZEU6Hlsp5sOtbd32q4RBl3S4cJkr639I2kyBEIWznRFTmodGQX
         UaRVfl1PmJEybaUKjAZKYcpv2QJT0n8icELIzkrOifsuOfhzA+3Ro50Oqe5sf6yh+DiN
         ygpn/dNS8id+3PjOEvrhy2fzh8fVD0ASJztYYkoN3VCdWZZGRTpH35YxCCzmLYk5D5Pj
         GKT1cyUdXau7Gyc9Sq89lumlTXx0oa9aqfgqGz+cdKrmlZfVUkcs+xNnullZeMyHvWtM
         s60Vz5lcfND/CZ6BRQycYtcGkTw55TWbjG3r5hFp8rCTEwWj3MwOExl3A5M/54qCIIGS
         cYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2bOH2oJjIvdfSW7pk+D64LWeafheAKYSzcyVanqLfZc=;
        b=YPQYrnMQ/+xhiQMaatHuaaTheEz8/2TsgbkQxhkB0MBG81gKIat0R8JKfvS69VLXt6
         QlvlKzylftyEX8CsSiaNV6Oz41XveguCIRIPD+8mJnYDDb15vxw+xElNBmr1+4Nm8aTO
         BBYzO57QYMDpHnVhfrgydf78mqMZpPOkL2yHX0iJ6WacHV7dmkEbQTrgIfsPvsiTKmVE
         ssIYem16MpC6ipZ7juEjcrkeifWMWFd80y+MGRFHbOQeQGAbclA9QAbrjVbslvcAdW9I
         wgh9nZvQ+do6T5Ii+jUdcdp9266+7ndjbWEuFmzmzgoY9kZGOmcJvXz6G0MzsoJQT0VY
         NmyA==
X-Gm-Message-State: AOAM530f6EqQHeHOaWQsZ5sqW443UEljVFSu+oZ/GTnJZQkvWE1NAUsy
        2uJexHdW7CL6RiftSr8tdcxW05Vu8fE7vg==
X-Google-Smtp-Source: ABdhPJy5y7kMovWK/+Wzbr37Bh/et2OQoQyV2fz586BohWdRjieetJlZAz31j+Ve/gESo5gNFpLTVtHYpeTD0g==
X-Received: from dbrazdil.lon.corp.google.com ([2a00:79e0:d:209:ab7e:2ff0:8fa0:3029])
 (user=dbrazdil job=sendgmr) by 2002:adf:e844:: with SMTP id
 d4mr40646736wrn.151.1641290814869; Tue, 04 Jan 2022 02:06:54 -0800 (PST)
Date:   Tue,  4 Jan 2022 10:06:45 +0000
In-Reply-To: <20220104100645.1810028-1-dbrazdil@google.com>
Message-Id: <20220104100645.1810028-3-dbrazdil@google.com>
Mime-Version: 1.0
References: <20220104100645.1810028-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v6 2/2] misc: open-dice: Add driver to expose DICE data to userspace
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
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
 drivers/misc/open-dice.c | 188 +++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c    |   1 +
 4 files changed, 202 insertions(+)
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
index 000000000000..f1819f951173
--- /dev/null
+++ b/drivers/misc/open-dice.c
@@ -0,0 +1,188 @@
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
+module_platform_driver_probe(open_dice_driver, open_dice_probe);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("David Brazdil <dbrazdil@google.com>");
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b3faf89744aa..d659ed0be342 100644
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
2.34.1.448.ga2b2bfdf31-goog

