Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BEE587DDB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiHBOEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiHBOEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:04:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665771EC4B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 07:04:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t2so13549341ply.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=h60LT7vOJu8wqSmm/HktHMkQmeA1gQ/DEgCvsUcna1M=;
        b=npiLFS37AOl37xB+nP8iunASf8ELSxY2kWwEjdptJLDH8bpe2cw9qZO9slMUOS5EOa
         scWUgoq7wajdkJcWdXR1BcHFxsHQmWKGpfQVjT6Uku7I0URuRhdQbRCD5u+saTgGxwFu
         xBEqNjIULTRuuT2S7szwQCL4B5L6Wit4AfdOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=h60LT7vOJu8wqSmm/HktHMkQmeA1gQ/DEgCvsUcna1M=;
        b=iXzCvYNewKQyp0HgvYzu3Az2blPWTNyxTO/Q2rd4Do+FuC55gFxh/LCon5YSCpj5re
         ZftCj1Zg6erPrumeCyPiRO2hhrMeAHWzETlNaEjPi3TnVLC5w0Nm9UNoXUoFc39egbcc
         PKkFlEVUTNcZdN9kGH8oU3LdDzCn3pHdPMv8ffLKTyQX3poNfPtNYDSJMl2CMQSQjJqw
         xrrkm6FF2aBDn3YPftKfZmv7L5muRUX9oRZxVUm0dofgqwzTgxB0FSff8jycuzP9BeLe
         FdFFpsXVNzM154AK/s5LyXV5jGw/+ij9aUszK3DYW9xb07ze050q1y58mba9FhYI8e4o
         DqaA==
X-Gm-Message-State: ACgBeo1zQDqrl+qWMmp481XScPzQq+cRUxdpCn2sESrZ8kJs4TsXSvIA
        w/nxr3OMmekslpBN3yN1PHVP3F5ifUusr8ZC
X-Google-Smtp-Source: AA6agR43oQ7XqbCtRIzCXt06HqHsU/plB9BjAexvDftt+VoalVjFgS6xtm5wemVUOpM/0V+l/Uib9A==
X-Received: by 2002:a17:902:7fcf:b0:16d:c92b:8ac1 with SMTP id t15-20020a1709027fcf00b0016dc92b8ac1mr21271285plb.74.1659449070364;
        Tue, 02 Aug 2022 07:04:30 -0700 (PDT)
Received: from jrosenth45.corp.google.com ([2620:0:1000:5e10:431f:4dea:8126:62a])
        by smtp.gmail.com with ESMTPSA id c3-20020a656743000000b004161e62a3a5sm9213040pgu.78.2022.08.02.07.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 07:04:29 -0700 (PDT)
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6] firmware: google: Implement cbmem in sysfs driver
Date:   Tue,  2 Aug 2022 07:03:43 -0700
Message-Id: <20220802140343.3468976-1-jrosenth@chromium.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <CAODwPW-eQ-dYvfCGZ13tOzh4gPdLU9ZoFg9joWpRTX22OXa4Ow@mail.gmail.com>
References: <CAODwPW-eQ-dYvfCGZ13tOzh4gPdLU9ZoFg9joWpRTX22OXa4Ow@mail.gmail.com>
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

cbmem entries can be read from coreboot table
0x31 (LB_TAG_CBMEM_ENTRY).  This commit exports access to cbmem
entries in sysfs under /sys/firmware/coreboot/cbmem-*.

Link: https://issuetracker.google.com/239604743
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Julius Werner <jwerner@chromium.org>
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Jack Rosenthal <jrosenth@chromium.org>
Signed-off-by: Jack Rosenthal <jrosenth@chromium.org>
---
v6: Modified commit message.
 .../ABI/testing/sysfs-firmware-coreboot       |  17 ++
 drivers/firmware/google/Kconfig               |   8 +
 drivers/firmware/google/Makefile              |   3 +
 drivers/firmware/google/cbmem.c               | 232 ++++++++++++++++++
 drivers/firmware/google/coreboot_table.h      |  11 +
 5 files changed, 271 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-coreboot
 create mode 100644 drivers/firmware/google/cbmem.c

diff --git a/Documentation/ABI/testing/sysfs-firmware-coreboot b/Documentation/ABI/testing/sysfs-firmware-coreboot
new file mode 100644
index 000000000000..2401483bb86c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-coreboot
@@ -0,0 +1,17 @@
+What:		/sys/firmware/coreboot/
+Date:		July 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		Coreboot-based BIOS firmware provides a variety of information
+		in CBMEM.  Each CBMEM entry can be found via Coreboot tables.
+		For each CBMEM entry, the following are exposed:
+
+		======= =======================================================
+		address A hexidecimal value of the memory address the data for
+			the entry begins at.
+		size	The size of the data stored.
+		id	The id corresponding to the entry. A list of ids known
+			to coreboot can be found in the coreboot source tree at
+			``src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h``
+		mem	A file exposing the raw memory for the entry.
+		======= =======================================================
diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index 983e07dc022e..bf8316d1cb31 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -19,6 +19,14 @@ config GOOGLE_SMI
 	  driver provides an interface for reading and writing NVRAM
 	  variables.
 
+config GOOGLE_CBMEM
+	tristate "CBMEM entries in sysfs"
+	depends on GOOGLE_COREBOOT_TABLE
+	help
+	  This option enables the kernel to search for Coreboot CBMEM
+	  entries, and expose the memory for each entry in sysfs under
+	  /sys/firmware/coreboot.
+
 config GOOGLE_COREBOOT_TABLE
 	tristate "Coreboot Table Access"
 	depends on HAS_IOMEM && (ACPI || OF)
diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
index d17caded5d88..8151e323cc43 100644
--- a/drivers/firmware/google/Makefile
+++ b/drivers/firmware/google/Makefile
@@ -7,5 +7,8 @@ obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) += memconsole-x86-legacy.o
 
+# Must come after coreboot_table.o, as this driver depends on that bus type.
+obj-$(CONFIG_GOOGLE_CBMEM)		+= cbmem.o
+
 vpd-sysfs-y := vpd.o vpd_decode.o
 obj-$(CONFIG_GOOGLE_VPD)		+= vpd-sysfs.o
diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/google/cbmem.c
new file mode 100644
index 000000000000..9646a8047742
--- /dev/null
+++ b/drivers/firmware/google/cbmem.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * cbmem.c
+ *
+ * Driver for exporting cbmem entries in sysfs.
+ *
+ * Copyright 2022 Google LLC
+ */
+
+#include <linux/ctype.h>
+#include <linux/device.h>
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
+#define LB_TAG_CBMEM_ENTRY 0x31
+
+static struct kobject *coreboot_kobj;
+
+struct cbmem_entry;
+struct cbmem_entry_attr {
+	struct kobj_attribute kobj_attr;
+	struct cbmem_entry *entry;
+};
+
+struct cbmem_entry {
+	char *kobj_name;
+	struct kobject *kobj;
+	struct coreboot_device *dev;
+	struct bin_attribute mem_file;
+	char *mem_file_buf;
+	struct cbmem_entry_attr address_file;
+	struct cbmem_entry_attr size_file;
+	struct cbmem_entry_attr id_file;
+};
+
+static struct cbmem_entry_attr *to_cbmem_entry_attr(struct kobj_attribute *a)
+{
+	return container_of(a, struct cbmem_entry_attr, kobj_attr);
+}
+
+static ssize_t cbmem_entry_mem_read(struct file *filp, struct kobject *kobp,
+				    struct bin_attribute *bin_attr, char *buf,
+				    loff_t pos, size_t count)
+{
+	struct cbmem_entry *entry = bin_attr->private;
+
+	return memory_read_from_buffer(buf, count, &pos, entry->mem_file_buf,
+				       bin_attr->size);
+}
+
+static ssize_t cbmem_entry_mem_write(struct file *filp, struct kobject *kobp,
+				     struct bin_attribute *bin_attr, char *buf,
+				     loff_t pos, size_t count)
+{
+	struct cbmem_entry *entry = bin_attr->private;
+
+	if (pos < 0 || pos >= bin_attr->size)
+		return -EINVAL;
+	if (count > bin_attr->size - pos)
+		count = bin_attr->size - pos;
+
+	memcpy(entry->mem_file_buf + pos, buf, count);
+	return count;
+}
+
+static ssize_t cbmem_entry_address_show(struct kobject *kobj,
+					struct kobj_attribute *a, char *buf)
+{
+	struct cbmem_entry_attr *entry_attr = to_cbmem_entry_attr(a);
+
+	return sysfs_emit(buf, "0x%llx\n",
+			  entry_attr->entry->dev->cbmem_entry.address);
+}
+
+static ssize_t cbmem_entry_size_show(struct kobject *kobj,
+				     struct kobj_attribute *a, char *buf)
+{
+	struct cbmem_entry_attr *entry_attr = to_cbmem_entry_attr(a);
+
+	return sysfs_emit(buf, "0x%x\n",
+			  entry_attr->entry->dev->cbmem_entry.entry_size);
+}
+
+static ssize_t cbmem_entry_id_show(struct kobject *kobj,
+				   struct kobj_attribute *a, char *buf)
+{
+	struct cbmem_entry_attr *entry_attr = to_cbmem_entry_attr(a);
+
+	return sysfs_emit(buf, "0x%x\n",
+			  entry_attr->entry->dev->cbmem_entry.id);
+}
+
+static int cbmem_entry_setup(struct cbmem_entry *entry)
+{
+	int ret;
+
+	entry->mem_file_buf =
+		devm_memremap(&entry->dev->dev, entry->dev->cbmem_entry.address,
+			      entry->dev->cbmem_entry.entry_size, MEMREMAP_WB);
+	if (!entry->mem_file_buf)
+		return -ENOMEM;
+
+	entry->kobj_name = devm_kasprintf(&entry->dev->dev, GFP_KERNEL,
+					  "cbmem-%08x",
+					  entry->dev->cbmem_entry.id);
+	if (!entry->kobj_name)
+		return -ENOMEM;
+
+	entry->kobj = kobject_create_and_add(entry->kobj_name, coreboot_kobj);
+	if (!entry->kobj)
+		return -ENOMEM;
+
+	sysfs_bin_attr_init(&entry->mem_file);
+	entry->mem_file.attr.name = "mem";
+	entry->mem_file.attr.mode = 0664;
+	entry->mem_file.size = entry->dev->cbmem_entry.entry_size;
+	entry->mem_file.read = cbmem_entry_mem_read;
+	entry->mem_file.write = cbmem_entry_mem_write;
+	entry->mem_file.private = entry;
+	ret = sysfs_create_bin_file(entry->kobj, &entry->mem_file);
+	if (ret)
+		goto free_kobj;
+
+	sysfs_attr_init(&entry->address_file.kobj_attr.attr);
+	entry->address_file.kobj_attr.attr.name = "address";
+	entry->address_file.kobj_attr.attr.mode = 0444;
+	entry->address_file.kobj_attr.show = cbmem_entry_address_show;
+	entry->address_file.entry = entry;
+	ret = sysfs_create_file(entry->kobj,
+				&entry->address_file.kobj_attr.attr);
+	if (ret)
+		goto free_mem_file;
+
+	sysfs_attr_init(&entry->size_file.kobj_attr.attr);
+	entry->size_file.kobj_attr.attr.name = "size";
+	entry->size_file.kobj_attr.attr.mode = 0444;
+	entry->size_file.kobj_attr.show = cbmem_entry_size_show;
+	entry->size_file.entry = entry;
+	ret = sysfs_create_file(entry->kobj, &entry->size_file.kobj_attr.attr);
+	if (ret)
+		goto free_address_file;
+
+	sysfs_attr_init(&entry->id_file.kobj_attr.attr);
+	entry->id_file.kobj_attr.attr.name = "id";
+	entry->id_file.kobj_attr.attr.mode = 0444;
+	entry->id_file.kobj_attr.show = cbmem_entry_id_show;
+	entry->id_file.entry = entry;
+	ret = sysfs_create_file(entry->kobj, &entry->id_file.kobj_attr.attr);
+	if (ret)
+		goto free_size_file;
+
+	return 0;
+
+free_size_file:
+	sysfs_remove_file(entry->kobj, &entry->size_file.kobj_attr.attr);
+free_address_file:
+	sysfs_remove_file(entry->kobj, &entry->address_file.kobj_attr.attr);
+free_mem_file:
+	sysfs_remove_bin_file(entry->kobj, &entry->mem_file);
+free_kobj:
+	kobject_put(entry->kobj);
+	return ret;
+}
+
+static int cbmem_entry_probe(struct coreboot_device *dev)
+{
+	struct cbmem_entry *entry;
+
+	entry = devm_kzalloc(&dev->dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	dev_set_drvdata(&dev->dev, entry);
+	entry->dev = dev;
+	return cbmem_entry_setup(entry);
+}
+
+static void cbmem_entry_remove(struct coreboot_device *dev)
+{
+	struct cbmem_entry *entry = dev_get_drvdata(&dev->dev);
+
+	sysfs_remove_bin_file(entry->kobj, &entry->mem_file);
+	sysfs_remove_file(entry->kobj, &entry->address_file.kobj_attr.attr);
+	sysfs_remove_file(entry->kobj, &entry->size_file.kobj_attr.attr);
+	sysfs_remove_file(entry->kobj, &entry->id_file.kobj_attr.attr);
+	kobject_put(entry->kobj);
+}
+
+static struct coreboot_driver cbmem_entry_driver = {
+	.probe = cbmem_entry_probe,
+	.remove = cbmem_entry_remove,
+	.drv = {
+		.name = "cbmem",
+	},
+	.tag = LB_TAG_CBMEM_ENTRY,
+};
+
+static int __init cbmem_init(void)
+{
+	int ret;
+
+	coreboot_kobj = kobject_create_and_add("coreboot", firmware_kobj);
+	if (!coreboot_kobj)
+		return -ENOMEM;
+
+	ret = coreboot_driver_register(&cbmem_entry_driver);
+	if (ret) {
+		kobject_put(coreboot_kobj);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(cbmem_init);
+
+static void __exit cbmem_exit(void)
+{
+	kobject_put(coreboot_kobj);
+	coreboot_driver_unregister(&cbmem_entry_driver);
+}
+module_exit(cbmem_exit);
+
+MODULE_AUTHOR("Jack Rosenthal <jrosenth@chromium.org>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index beb778674acd..6c03a8852d1b 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -39,6 +39,16 @@ struct lb_cbmem_ref {
 	u64 cbmem_addr;
 };
 
+/* Corresponds to LB_TAG_CBMEM_ENTRY. */
+struct lb_cbmem_entry {
+	u32 tag;
+	u32 size;
+
+	u64 address;
+	u32 entry_size;
+	u32 id;
+};
+
 /* Describes framebuffer setup by coreboot */
 struct lb_framebuffer {
 	u32 tag;
@@ -65,6 +75,7 @@ struct coreboot_device {
 	union {
 		struct coreboot_table_entry entry;
 		struct lb_cbmem_ref cbmem_ref;
+		struct lb_cbmem_entry cbmem_entry;
 		struct lb_framebuffer framebuffer;
 	};
 };
-- 
2.37.1.455.g008518b4e5-goog

