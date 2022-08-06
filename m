Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7416D58B842
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiHFUlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 16:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiHFUlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:41:06 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8197C9FD1
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 13:41:03 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 13so5402201pgc.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=jDXAH923YYZ+sHLRY2tr0XE7uSJao69/WOe3HLM/LMc=;
        b=PXZrgwzIAmb2JTDNLGQxn/pO8fCatPZopM0kf0MLee7Onf+EST9tEW3FCtHLITrLBw
         8esDaNcv7sRfjCTQK/0t0c7cX7x+xBnyV2XSQWzmuO5+NRiAXEDiu3eSx2QinSK63sJr
         BKX1SSXJUsneSvybDtQcZygIbjNr0YdWT2+Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=jDXAH923YYZ+sHLRY2tr0XE7uSJao69/WOe3HLM/LMc=;
        b=y57GQbZ+dTAJHEhJOvDnPeUg633P/prxiiTZ7WgbcKzd4GsaMNOnQ9e/kJZdO2rwXu
         rb72fq1EZ6YuRI/TmxIEy4ghRSxgZlsnxAdmSjc/8N2Dp+FEbHylFKVPZb9D7gCkfzOJ
         ZE7WF0RVK2hS3sn6FReVLnE7CK35evvtXb4EvH2HNCjWmx6fVMCeQ914ztqJe+kEy4wP
         OmJtimTqPDcb2ConmwF4x02jA7t5m7NZOhs8oRMRK1VvVL76zkrVO/7O3GsP28WmYUAg
         TOcCwTpbYo1og7bF/BOgZgEpqRfntq3S7aqA+MrTvXXp/RGJNELById2xIdyVU7LHrln
         RZpQ==
X-Gm-Message-State: ACgBeo3jDMEBj9MBbkdc+cYAMRV2yyP6LjZtZyfMEvTemp4LtSXoWm7J
        uhwR5qF9FupJkrrgON8ugalVIymG0cW8if2eNaw=
X-Google-Smtp-Source: AA6agR4AR77mma9kqhtzD2XxmErU3Sqmh3Qcale8FI/8ud82dzDR36N9MJnV0VdSWJvmERWFWrTo8A==
X-Received: by 2002:a05:6a00:2283:b0:52e:2371:89d with SMTP id f3-20020a056a00228300b0052e2371089dmr12701221pfe.62.1659818462581;
        Sat, 06 Aug 2022 13:41:02 -0700 (PDT)
Received: from jrosenth45.corp.google.com ([2620:15c:7c:200:43d8:ac7e:8aab:d91e])
        by smtp.gmail.com with ESMTPSA id iz4-20020a170902ef8400b0016d9b101413sm5363361plb.200.2022.08.06.13.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 13:41:01 -0700 (PDT)
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: [PATCH v7] firmware: google: Implement cbmem in sysfs driver
Date:   Sat,  6 Aug 2022 13:40:53 -0700
Message-Id: <20220806204053.3275096-1-jrosenth@chromium.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Julius Werner <jwerner@chromium.org>
Tested-by: Jack Rosenthal <jrosenth@chromium.org>
Signed-off-by: Jack Rosenthal <jrosenth@chromium.org>
---
v7: Updated based on review comments from Stephen Boyd:
    - /sys/firmware/coreboot now created in coreboot_table.c
    - Documentation for each sysfs file now split out into individual
      sections.
    - now /sys/firmware/coreboot/cbmem/<id>/ instead of
          /sys/frimware/coreboot/cbmem-<id>/
 .../ABI/testing/sysfs-firmware-coreboot       |  49 ++++
 drivers/firmware/google/Kconfig               |   8 +
 drivers/firmware/google/Makefile              |   3 +
 drivers/firmware/google/cbmem.c               | 231 ++++++++++++++++++
 drivers/firmware/google/coreboot_table.c      |  10 +
 drivers/firmware/google/coreboot_table.h      |  16 ++
 6 files changed, 317 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-coreboot
 create mode 100644 drivers/firmware/google/cbmem.c

diff --git a/Documentation/ABI/testing/sysfs-firmware-coreboot b/Documentation/ABI/testing/sysfs-firmware-coreboot
new file mode 100644
index 000000000000..02a0190d418f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-coreboot
@@ -0,0 +1,49 @@
+What:		/sys/firmware/coreboot/
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		Kernel objects associated with the Coreboot-based BIOS firmware.
+
+What:		/sys/firmware/coreboot/cbmem/
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		Coreboot provides a variety of information in CBMEM.  This
+		directory contains each CBMEM entry, which can be found via
+		Coreboot tables.
+
+What:		/sys/firmware/coreboot/cbmem/<id>/
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		Each CBMEM entry is given a directory based on the id
+		corresponding to the entry.  A list of ids known to coreboot can
+		be found in the coreboot source tree at
+		``src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h``.
+
+What:		/sys/firmware/coreboot/cbmem/<id>/address
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		The memory address that the CBMEM entry's data begins at.
+
+What:		/sys/firmware/coreboot/cbmem/<id>/size
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		The size of the data being stored.
+
+What:		/sys/firmware/coreboot/cbmem/<id>/id
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		The CBMEM id corresponding to the entry.
+
+What:		/sys/firmware/coreboot/cbmem/<id>/mem
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		A file exposing read/write memory access to the entry's data.
+		Note that this file does not support mmap(), and should be used
+		for basic data access only.  Users requiring mmap() should read
+		the address and size files, and mmap() /dev/mem.
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
index 000000000000..6454dd5fa3fe
--- /dev/null
+++ b/drivers/firmware/google/cbmem.c
@@ -0,0 +1,231 @@
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
+static struct kobject *cbmem_kobj;
+
+struct cbmem_entry;
+struct cbmem_entry_attr {
+	struct kobj_attribute kobj_attr;
+	struct cbmem_entry *entry;
+};
+
+struct cbmem_entry {
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
+	return sysfs_emit(buf, "0x%08x\n",
+			  entry_attr->entry->dev->cbmem_entry.id);
+}
+
+static int cbmem_entry_setup(struct cbmem_entry *entry)
+{
+	int ret;
+	char *kobj_name;
+
+	entry->mem_file_buf =
+		devm_memremap(&entry->dev->dev, entry->dev->cbmem_entry.address,
+			      entry->dev->cbmem_entry.entry_size, MEMREMAP_WB);
+	if (!entry->mem_file_buf)
+		return -ENOMEM;
+
+	kobj_name = devm_kasprintf(&entry->dev->dev, GFP_KERNEL, "%08x",
+				   entry->dev->cbmem_entry.id);
+	if (!kobj_name)
+		return -ENOMEM;
+
+	entry->kobj = kobject_create_and_add(kobj_name, cbmem_kobj);
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
+	cbmem_kobj = kobject_create_and_add("cbmem", coreboot_kobj);
+	if (!coreboot_kobj)
+		return -ENOMEM;
+
+	ret = coreboot_driver_register(&cbmem_entry_driver);
+	if (ret) {
+		kobject_put(cbmem_kobj);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(cbmem_init);
+
+static void __exit cbmem_exit(void)
+{
+	kobject_put(cbmem_kobj);
+	coreboot_driver_unregister(&cbmem_entry_driver);
+}
+module_exit(cbmem_exit);
+
+MODULE_AUTHOR("Jack Rosenthal <jrosenth@chromium.org>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index c52bcaa9def6..a3e2720e4638 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -14,16 +14,21 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include "coreboot_table.h"
 
 #define CB_DEV(d) container_of(d, struct coreboot_device, dev)
 #define CB_DRV(d) container_of(d, struct coreboot_driver, drv)
 
+struct kobject *coreboot_kobj;
+EXPORT_SYMBOL(coreboot_kobj);
+
 static int coreboot_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct coreboot_device *device = CB_DEV(dev);
@@ -157,6 +162,10 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	}
 	memunmap(ptr);
 
+	coreboot_kobj = kobject_create_and_add("coreboot", firmware_kobj);
+	if (!coreboot_kobj)
+		return -ENOMEM;
+
 	return ret;
 }
 
@@ -170,6 +179,7 @@ static int coreboot_table_remove(struct platform_device *pdev)
 {
 	bus_for_each_dev(&coreboot_bus_type, NULL, NULL, __cb_dev_unregister);
 	bus_unregister(&coreboot_bus_type);
+	kobject_put(coreboot_kobj);
 	return 0;
 }
 
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index beb778674acd..76c31e6e5376 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -14,6 +14,11 @@
 
 #include <linux/device.h>
 
+struct kobject;
+
+/* This is /sys/firmware/coreboot */
+extern struct kobject *coreboot_kobj;
+
 /* Coreboot table header structure */
 struct coreboot_table_header {
 	char signature[4];
@@ -39,6 +44,16 @@ struct lb_cbmem_ref {
 	u64 cbmem_addr;
 };
 
+/* Corresponds to LB_TAG_CBMEM_ENTRY */
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
@@ -65,6 +80,7 @@ struct coreboot_device {
 	union {
 		struct coreboot_table_entry entry;
 		struct lb_cbmem_ref cbmem_ref;
+		struct lb_cbmem_entry cbmem_entry;
 		struct lb_framebuffer framebuffer;
 	};
 };
-- 
2.37.1.559.g78731f0fdb-goog

