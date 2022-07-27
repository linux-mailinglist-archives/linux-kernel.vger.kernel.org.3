Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945BA581CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 02:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbiG0AMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 20:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiG0AMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 20:12:43 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D33E0FB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 17:12:42 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y10so354043ili.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 17:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DocosmU9Kih0cpMr66Xs6WDlyGW3+GYjRnYbNFkWMN0=;
        b=NWGur+C0j3Nw/dMU+vHao3G7hasFNp8oVPBmdLU74TXTT7+bsLq8GrujVjA0TD7eOL
         JX4Nw0V8FaKfSu9Y4vNjXP4ffFaUfaDa7hW+GLU5ZMP37np8bro0ZgwbxpbLDOCrXPRE
         LVhKvW9/I4OzmrU8GCe9Xg4G7P+ZEc4aWEPgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DocosmU9Kih0cpMr66Xs6WDlyGW3+GYjRnYbNFkWMN0=;
        b=GXb9T8HnjkUWauNbUAugqdIr/G9Cppqu4FrpRUjp5u1SFG6cdTnkQxSEnontpZEEWE
         4B09JatG594GuyHX5GoOURH/SWBUuV1r0NUyicZKDTuZ04p28IFfq6lzkMsU4zrxI2CZ
         E/GdkI2q3mHF0PAeZAMOrVLLaIMMYGR8de0+LkFILOitdeFaGoODukN8pzxtvOGczMaO
         /MDT2NjL5doaHWGXdqAN5cOsJsvuXldV97E1PCu8veux5irVjWnHuKwEgZlFJ691icjo
         1pnBHMyXt7LFJYIn4jdeMvSf29kq7npR/XogPPmdFMBsMeTxIhdUNPOWbmA+z0bMiCp6
         A1eA==
X-Gm-Message-State: AJIora+dr25bmxE4W7K2/RV4tCzhfru0AkdewADv8GaU/D3/lwt6sRdS
        ysK77tUCg1PzJhXt2qydz/kJGfIQcvtawypOY/E=
X-Google-Smtp-Source: AGRyM1sfQH526VAJg3UdB1E919SRjnpNvpENIAV1y/d52pxfJV3KswI8ZQ+ShUgq10WHNTNzbp4mtw==
X-Received: by 2002:a05:6e02:1c8e:b0:2dd:470e:3d6f with SMTP id w14-20020a056e021c8e00b002dd470e3d6fmr5432653ill.189.1658880761629;
        Tue, 26 Jul 2022 17:12:41 -0700 (PDT)
Received: from jrosenth45.corp.google.com ([100.107.108.177])
        by smtp.gmail.com with ESMTPSA id z3-20020a92d183000000b002dae42fa5f2sm6120577ilz.56.2022.07.26.17.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 17:12:41 -0700 (PDT)
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: [PATCH v2] firmware: google: Implement vboot workbuf in sysfs
Date:   Tue, 26 Jul 2022 18:12:19 -0600
Message-Id: <20220727001219.1300288-1-jrosenth@chromium.org>
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
 drivers/firmware/google/vboot.c  | 174 +++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)
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
index 000000000000..3c1e3d3ea0d9
--- /dev/null
+++ b/drivers/firmware/google/vboot.c
@@ -0,0 +1,174 @@
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
+} __packed;
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
+		dev_err(&dev->dev, "%s: workbuf has invalid magic number\n",
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
+		dev_err(&dev->dev, "%s: workbuf v%hu.%hu not supported",
+			__func__, workbuf->version_major,
+			workbuf->version_minor);
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

