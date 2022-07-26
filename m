Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DD0581C92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 01:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiGZXv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 19:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiGZXvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 19:51:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF81326D0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:51:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id o2so4511000iof.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=fOAxeBHm7oOWXYpgG8a7LRuvwjtrVNpukeRNTpkkk3Y=;
        b=fbPYi4h8MO14nv7YRDAOD5DE6p0n2efuOV4Ir3nCNk4KpiK3R2wFcQGaGB3SZFilYw
         EBaYMDSBME2BYAjukvyQPyBtHsiK6FviLIsRFzH0KBv+VhSzixrN9NEYq3I6KWXFPo+R
         KrpxrSHF4qgygZ6KEdWPCCfy8PKrHskvRxc3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fOAxeBHm7oOWXYpgG8a7LRuvwjtrVNpukeRNTpkkk3Y=;
        b=ShLc1jwHhwogFA6mafzQ7CYiHhF+LWkPViUbxqxG2YWl4q/zE28ZCYx5dO25YDyvUz
         e0XHXdaiSftC7hfVAryKzaALnVjd+momvE8ApsFW5458xPGBTLu/PeQlNKUenfwZe6O9
         2uEn/sQiSQCsTL3YBZcH1VUU2s+BW/MrjXTjVw9GZXZSYQX+8QY8KTwn0K9wpW8PImWs
         hxRMfUkZw/m9YxyMfRCERTn0zKDAtLKaUcShc5KbEa2RgC3wi3biJtxzEveeL4hc8+TJ
         IXMFbXESP7OO2DbpC+Gg4R5wWnSyX0J56bSdDHw2PoBB2HvXaeznVgVbocSEXBo7B3bx
         14Ng==
X-Gm-Message-State: AJIora+44RzYzSkZqMu+EESk/KvjlDJpj6ualdhIIacTyVlkaMYhBqNH
        /Z3JlbHZaEMaONZW3bprzYFfRPbdBMhIra+xOEE=
X-Google-Smtp-Source: AGRyM1uqywEVYU5xkfxI9W5IsmTcBeaFgrj/McYDj76Enp+C/0RPGha+hdOXPRBMkJvhRsEu3oSaxw==
X-Received: by 2002:a05:6638:210b:b0:33f:5635:4c4b with SMTP id n11-20020a056638210b00b0033f56354c4bmr8438265jaj.116.1658879512265;
        Tue, 26 Jul 2022 16:51:52 -0700 (PDT)
Received: from jrosenth45.corp.google.com ([100.107.108.177])
        by smtp.gmail.com with ESMTPSA id a12-20020a92d58c000000b002dc0d743570sm6153108iln.43.2022.07.26.16.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 16:51:51 -0700 (PDT)
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: [PATCH] firmware: google: Implement vboot workbuf in sysfs
Date:   Tue, 26 Jul 2022 17:51:15 -0600
Message-Id: <20220726235115.1184532-1-jrosenth@chromium.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vboot workbuf is a large data structure exposed by coreboot for
payloads and the operating system to use.  Existing tools like
crossystem re-create this structure in userspace by reading the
deprecated vboot v1 VBSD structure from FDT/ACPI, and translating it
back to a vboot v2 workbuf.  Since not all data required for vboot v2
is available in the VBSD structure, crossystem also has to shell out
to tools like flashrom to fill in the missing bits.

Since coreboot commit a8bda43, this workbuf is also available in
CBMEM, and since workbuf struct version 2 (vboot commit ecdca93), this
data also contains the vboot context, making it useful.  Exposing it
via sysfs enables tools like crossystem significantly easier access to
read and manipulate vboot variables.

Link: https://issuetracker.google.com/239604743
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Tested-by: Jack Rosenthal <jrosenth@chromium.org>
Signed-off-by: Jack Rosenthal <jrosenth@chromium.org>
---
 drivers/firmware/google/Kconfig  |   8 ++
 drivers/firmware/google/Makefile |   1 +
 drivers/firmware/google/vboot.c  | 173 +++++++++++++++++++++++++++++++
 3 files changed, 182 insertions(+)
 create mode 100644 drivers/firmware/google/vboot.c

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index 983e07dc022e..f0e691cb9496 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -67,6 +67,14 @@ config GOOGLE_MEMCONSOLE_COREBOOT
 	  the coreboot table.  If found, this log is exported to userland
 	  in the file /sys/firmware/log.
 
+config GOOGLE_VBOOT_SYSFS
+	tristate "Verified Boot in sysfs"
+	depends on GOOGLE_COREBOOT_TABLE
+	help
+	  This option enables the kernel to search for the Verified Boot
+	  workbuf coreboot table.  If found, the workbuf is exported
+	  to userland in /sys/firmware/vboot.
+
 config GOOGLE_VPD
 	tristate "Vital Product Data"
 	depends on GOOGLE_COREBOOT_TABLE
diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
index d17caded5d88..f8db06764725 100644
--- a/drivers/firmware/google/Makefile
+++ b/drivers/firmware/google/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT)  += framebuffer-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) += memconsole-x86-legacy.o
+obj-$(CONFIG_GOOGLE_VBOOT_SYSFS)           += vboot.o
 
 vpd-sysfs-y := vpd.o vpd_decode.o
 obj-$(CONFIG_GOOGLE_VPD)		+= vpd-sysfs.o
diff --git a/drivers/firmware/google/vboot.c b/drivers/firmware/google/vboot.c
new file mode 100644
index 000000000000..25feb1a33dcd
--- /dev/null
+++ b/drivers/firmware/google/vboot.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vboot.c
+ *
+ * Driver for exporting the vboot workbuf to sysfs.
+ *
+ * Copyright 2022 Google Inc.
+ */
+
+#include <linux/capability.h>
+#include <linux/ctype.h>
+#include <linux/dev_printk.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#include "coreboot_table.h"
+
+#define LB_TAG_VBOOT_WORKBUF 0x34
+
+/* "V2SD" = vb2_shared_data.magic */
+#define VB2_SHARED_DATA_MAGIC 0x44533256
+#define VB2_CONTEXT_MAX_SIZE_V2 192
+#define VB2_CONTEXT_MAX_SIZE_V3 384
+
+struct workbuf {
+	u32 magic;
+	u16 version_major;
+	u16 version_minor;
+	union {
+		/*
+		 * V1 not supported as workbuf and vboot context
+		 * located separately.
+		 */
+		struct {
+			u8 context_padding[VB2_CONTEXT_MAX_SIZE_V2];
+			u32 workbuf_size;
+		} v2;
+		struct {
+			u8 context_padding[VB2_CONTEXT_MAX_SIZE_V3];
+			u32 workbuf_size;
+		} v3;
+	};
+};
+
+static struct kobject *vboot_kobj;
+
+static struct {
+	u8 *buf;
+	u32 size;
+	struct bin_attribute bin_attr;
+} workbuf_info;
+
+static ssize_t workbuf_read(struct file *filp, struct kobject *kobp,
+			    struct bin_attribute *bin_attr, char *buf,
+			    loff_t pos, size_t count)
+{
+	return memory_read_from_buffer(buf, count, &pos, workbuf_info.buf,
+				       workbuf_info.size);
+}
+
+static ssize_t workbuf_write(struct file *filp, struct kobject *kobp,
+			     struct bin_attribute *bin_attr, char *buf,
+			     loff_t pos, size_t count)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (pos < 0 || pos >= workbuf_info.size)
+		return -EINVAL;
+	if (count > workbuf_info.size - pos)
+		count = workbuf_info.size - pos;
+
+	memcpy(workbuf_info.buf + pos, buf, count);
+	return count;
+}
+
+/*
+ * This function should only be called during initialization -- prior
+ * to workbuf being added to sysfs.  The workbuf can be manipulated
+ * via sysfs, and thus, we should not trust the size in the workbuf
+ * after we've given the user write access to the buffer.
+ */
+static int get_workbuf_size(struct coreboot_device *dev, u32 *size_out)
+{
+	int ret = 0;
+	struct workbuf *workbuf;
+
+	workbuf = memremap(dev->cbmem_ref.cbmem_addr, sizeof(struct workbuf),
+			   MEMREMAP_WB);
+
+	if (workbuf->magic != VB2_SHARED_DATA_MAGIC) {
+		dev_err(dev, "%s: workbuf has invalid magic number\n",
+			__func__);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	switch (workbuf->version_major) {
+	case 2:
+		*size_out = workbuf->v2.workbuf_size;
+		break;
+	case 3:
+		*size_out = workbuf->v3.workbuf_size;
+		break;
+	default:
+		dev_err(dev, "%s: workbuf v%hu.%hu not supported", __func__,
+			workbuf->version_major, workbuf->version_minor);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+exit:
+	memunmap(workbuf);
+	return ret;
+}
+
+static int vboot_probe(struct coreboot_device *dev)
+{
+	int ret;
+
+	vboot_kobj = kobject_create_and_add("vboot", firmware_kobj);
+	if (!vboot_kobj)
+		return -ENOMEM;
+
+	ret = get_workbuf_size(dev, &workbuf_info.size);
+	if (ret)
+		goto exit;
+
+	workbuf_info.buf = memremap(dev->cbmem_ref.cbmem_addr,
+				    workbuf_info.size, MEMREMAP_WB);
+
+	sysfs_bin_attr_init(&workbuf_info.bin_attr);
+	workbuf_info.bin_attr.attr.name = "workbuf";
+	workbuf_info.bin_attr.attr.mode = 0666;
+	workbuf_info.bin_attr.size = workbuf_info.size;
+	workbuf_info.bin_attr.read = workbuf_read;
+	workbuf_info.bin_attr.write = workbuf_write;
+
+	ret = sysfs_create_bin_file(vboot_kobj, &workbuf_info.bin_attr);
+
+exit:
+	if (ret) {
+		kobject_put(vboot_kobj);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void vboot_remove(struct coreboot_device *dev)
+{
+	sysfs_remove_bin_file(vboot_kobj, &workbuf_info.bin_attr);
+	kobject_put(vboot_kobj);
+	memunmap(&workbuf_info.buf);
+}
+
+static struct coreboot_driver vboot_driver = {
+	.probe = vboot_probe,
+	.remove = vboot_remove,
+	.drv = {
+		.name = "vboot",
+	},
+	.tag = LB_TAG_VBOOT_WORKBUF,
+};
+module_coreboot_driver(vboot_driver);
+
+MODULE_AUTHOR("Google, Inc.");
+MODULE_LICENSE("GPL");
-- 
2.37.1.359.gd136c6c3e2-goog

