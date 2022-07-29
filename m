Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83B2585596
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbiG2Tbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiG2Tbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:31:43 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABF1E0A3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:31:42 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id t15so2894132ilm.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6GXLhFn5AUZcr0XKccgrkCqVGuLZqmvdx86neava4i0=;
        b=huMBJ0SQ71VdzCftzJd1AeXSzeK6AocvWzF8DmRg+iXKEDKAwPuT7TFtlwJ8+GX0hy
         PeuwTrbkKtqICYNcsJTU5eNqcyJ3TyZXPvUmcNf7JGHZf4PETEsCc6Yag8H5E5GIn1TH
         JAP/CAwS5RSRGGVbZPfiu3JRalt693g3XSGJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6GXLhFn5AUZcr0XKccgrkCqVGuLZqmvdx86neava4i0=;
        b=OUZrrBUrQfCS0cNg0xRSmTUPJBkoAr/cOl82Nkyhze13Gm2o7ZvqMnY33oMOWg+708
         aOy+ctafGuOhqvzZDxJ3bp8JYcRWldCx1N+wUY+b5ME794Htp2JrcGkDLvihloNVNAeq
         POd3EMjJ5+l9nYtWVZfvzx6QGnIpLNgW2luRUL7cFzkhcmn4HAOSQUk4MVekWWV2SEXR
         xwOb5omzQyVzWtvKXIEodLWLjWnGPNml3kSNUw3tXL1ZZUiKQaTu8An1oTeIpXaaQysB
         E8+izW+BM92dNKF5hHQEHSVgomPg9NBaNKa0ql1mHngJOMQWP98DU2p4Zdfj0LC80xXA
         HvBg==
X-Gm-Message-State: AJIora+UthLBzYDggr3fPuodi3CSlwrZtpXr6Yb4FAT6VoKiYRXm2l/Z
        hks/Cms2KMDnEyvjw49jzjDmDDJ4fmT2yQ==
X-Google-Smtp-Source: AGRyM1shKLIWsKB6evzMUdB2/9QXnpNfJQ8u+eVPIEYXj21KHWs2D2xmCh1Nh6wf/xRXgXH7Rn2QJg==
X-Received: by 2002:a92:db47:0:b0:2dd:5e7:fe99 with SMTP id w7-20020a92db47000000b002dd05e7fe99mr1903842ilq.238.1659123101042;
        Fri, 29 Jul 2022 12:31:41 -0700 (PDT)
Received: from jrosenth45.corp.google.com ([2601:285:8300:c23:c82a:e170:891f:5bf])
        by smtp.gmail.com with ESMTPSA id f7-20020a028487000000b00341d28e07f4sm1996677jai.105.2022.07.29.12.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:31:40 -0700 (PDT)
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: [PATCH v3] firmware: google: Implement cbmem in sysfs driver
Date:   Fri, 29 Jul 2022 13:31:07 -0600
Message-Id: <20220729193107.2466530-1-jrosenth@chromium.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <YuGTL79tPPoalk/j@chromium.org>
References: <YuGTL79tPPoalk/j@chromium.org>
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
Cc: Julius Werner <jwerner@chromium.org>
Tested-by: Jack Rosenthal <jrosenth@chromium.org>
Signed-off-by: Jack Rosenthal <jrosenth@chromium.org>
---
 .../ABI/testing/sysfs-firmware-coreboot       |  16 +
 drivers/firmware/google/Kconfig               |   8 +
 drivers/firmware/google/Makefile              |   3 +
 drivers/firmware/google/cbmem.c               | 408 ++++++++++++++++++
 drivers/firmware/google/coreboot_table.h      |  11 +
 5 files changed, 446 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-coreboot
 create mode 100644 drivers/firmware/google/cbmem.c

diff --git a/Documentation/ABI/testing/sysfs-firmware-coreboot b/Documentation/ABI/testing/sysfs-firmware-coreboot
new file mode 100644
index 000000000000..c66ef96647e9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-coreboot
@@ -0,0 +1,16 @@
+What:		/sys/firmware/coreboot/
+Date:		July 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		Coreboot-based BIOS firmware provides a variety of information
+		in CBMEM.  Each CBMEM entry can be found via Coreboot tables.
+		For each CBMEM entry, the following are exposed:
+
+		address: A hexidecimal value of the memory address the data for
+			the entry begins at.
+		size: The size of the data stored.
+		id: The id corresponding to the entry. A list of ids known to
+			coreboot can be found in the coreboot tree at
+			src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h
+		alias: A common name for the id of the entry.
+		mem: A file exposing the raw memory for the entry.
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
index 000000000000..71c5de17e243
--- /dev/null
+++ b/drivers/firmware/google/cbmem.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * cbmem.c
+ *
+ * Driver for exporting cbmem entries in sysfs.
+ *
+ * Copyright 2022 Google Inc.
+ */
+
+#include <linux/capability.h>
+#include <linux/ctype.h>
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
+/*
+ * This list should be kept in sync with
+ * src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h from coreboot.
+ */
+static const struct {
+	const char *alias;
+	u32 id;
+} cbmem_aliases[] = {
+	{ "acpi", 0x41435049 },
+	{ "acpi-bert", 0x42455254 },
+	{ "acpi-cnvs", 0x434e5653 },
+	{ "acpi-gnvs", 0x474e5653 },
+	{ "acpi-hest", 0x48455354 },
+	{ "acpi-ucsi", 0x55435349 },
+	{ "after-car", 0xc4787a93 },
+	{ "agesa-runtime", 0x41474553 },
+	{ "agesa-mtrr", 0xf08b4b9d },
+	{ "amdmct-meminfo", 0x494d454e },
+	{ "car-globals", 0xcac4e6a3 },
+	{ "cbtable", 0x43425442 },
+	{ "cbtable-fwd", 0x43425443 },
+	{ "cb-early-dram", 0x4544524d },
+	{ "console", 0x434f4e53 },
+	{ "cpu-crashlog", 0x4350555f },
+	{ "coverage", 0x47434f56 },
+	{ "cse-update", 0x43534555 },
+	{ "ehci-debug", 0xe4c1deb9 },
+	{ "elog", 0x454c4f47 },
+	{ "freespace", 0x46524545 },
+	{ "fsp-reserved-memory", 0x46535052 },
+	{ "fsp-runtime", 0x52505346 },
+	{ "gdt", 0x4c474454 },
+	{ "hob-pointer", 0x484f4221 },
+	{ "igd-opregion", 0x4f444749 },
+	{ "imd-root", 0xff4017ff },
+	{ "imd-small", 0x53a11439 },
+	{ "mdata-hash", 0x6873484d },
+	{ "meminfo", 0x494d454d },
+	{ "mma-data", 0x4d4d4144 },
+	{ "mmc-status", 0x4d4d4353 },
+	{ "mptable", 0x534d5054 },
+	{ "mrcdata", 0x4d524344 },
+	{ "pmc-crashlog", 0x504d435f },
+	{ "var-mrcdata", 0x4d524345 },
+	{ "mtc", 0xcb31d31c },
+	{ "none", 0x00000000 },
+	{ "pirq", 0x49525154 },
+	{ "power-state", 0x50535454 },
+	{ "ram-oops", 0x05430095 },
+	{ "ramstage", 0x9a357a9e },
+	{ "ramstage-cache", 0x9a3ca54e },
+	{ "refcode", 0x04efc0de },
+	{ "refcode-cache", 0x4efc0de5 },
+	{ "resume", 0x5245534d },
+	{ "resume-scratch", 0x52455343 },
+	{ "romstage-info", 0x47545352 },
+	{ "romstage-ram-stack", 0x90357ac4 },
+	{ "root", 0xff4007ff },
+	{ "smbios", 0x534d4254 },
+	{ "smm-save-space", 0x07e9acee },
+	{ "stagex-meta", 0x57a9e000 },
+	{ "stagex-cache", 0x57a9e100 },
+	{ "stagex-mem", 0x57a9e200 },
+	{ "storage-data", 0x53746f72 },
+	{ "tcpa-log", 0x54435041 },
+	{ "tcpa-tcg-log", 0x54445041 },
+	{ "timestamp", 0x54494d45 },
+	{ "tpm2-tcg-log", 0x54504d32 },
+	{ "tpm-ppi", 0x54505049 },
+	{ "vboot-handoff", 0x780074f0 },
+	{ "vboot-sel-reg", 0x780074f1 },
+	{ "vboot-workbuf", 0x78007343 },
+	{ "vpd", 0x56504420 },
+	{ "wifi-calibration", 0x57494649 },
+	{ "ec-hostevent", 0x63ccbbc3 },
+	{ "ext-vbt", 0x69866684 },
+	{ "vga-rom0", 0x524f4d30 },
+	{ "vga-rom1", 0x524f4d31 },
+	{ "vga-rom2", 0x524f4d32 },
+	{ "vga-rom3", 0x524f4d33 },
+	{ "fmap", 0x464d4150 },
+	{ "cbfs-ro-mcache", 0x524d5346 },
+	{ "cbfs-rw-mcache", 0x574d5346 },
+	{ "fsp-logo", 0x4c4f474f },
+	{ "smm-combuffer", 0x53534d32 },
+	{ "type-c-info", 0x54595045 },
+	{ "mem-chip-info", 0x5048434d },
+};
+
+static const char *get_alias(u32 cbmem_id)
+{
+	for (int i = 0; i < ARRAY_SIZE(cbmem_aliases); i++) {
+		if (cbmem_id == cbmem_aliases[i].id)
+			return cbmem_aliases[i].alias;
+	}
+
+	return NULL;
+}
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
+	const char *alias;
+	struct cbmem_entry_attr alias_name_file;
+	char *alias_link_name;
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
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (pos < 0 || pos >= bin_attr->size)
+		return -EINVAL;
+	if (count > bin_attr->size - pos)
+		count = bin_attr->size - pos;
+
+	memcpy(entry->mem_file_buf + pos, buf, count);
+	return count;
+}
+
+static ssize_t cbmem_entry_alias_name_show(struct kobject *kobj,
+					   struct kobj_attribute *a, char *buf)
+{
+	struct cbmem_entry_attr *entry_attr = to_cbmem_entry_attr(a);
+
+	return sysfs_emit(buf, "%s\n", entry_attr->entry->alias);
+}
+
+static int cbmem_entry_setup_alias(struct cbmem_entry *entry)
+{
+	int ret;
+
+	entry->alias = get_alias(entry->dev->cbmem_entry.id);
+	if (!entry->alias)
+		return 0;
+
+	sysfs_attr_init(&entry->alias_name_file.kobj_attr.attr);
+	entry->alias_name_file.kobj_attr.attr.name = "alias";
+	entry->alias_name_file.kobj_attr.attr.mode = 0444;
+	entry->alias_name_file.kobj_attr.show = cbmem_entry_alias_name_show;
+	entry->alias_name_file.entry = entry;
+	ret = sysfs_create_file(entry->kobj,
+				&entry->alias_name_file.kobj_attr.attr);
+	if (ret)
+		return ret;
+
+	entry->alias_link_name =
+		kasprintf(GFP_KERNEL, "cbmem-%s", entry->alias);
+	if (!entry->alias_link_name) {
+		ret = -ENOMEM;
+		goto free_alias_name_file;
+	}
+
+	ret = sysfs_create_link(coreboot_kobj, entry->kobj,
+				entry->alias_link_name);
+	if (ret)
+		goto free_alias_link_name;
+
+	return 0;
+
+free_alias_link_name:
+	kfree(entry->alias_link_name);
+free_alias_name_file:
+	sysfs_remove_file(entry->kobj, &entry->alias_name_file.kobj_attr.attr);
+
+	return ret;
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
+	entry->mem_file_buf = memremap(entry->dev->cbmem_entry.address,
+				       entry->dev->cbmem_entry.entry_size,
+				       MEMREMAP_WB);
+	if (!entry->mem_file_buf)
+		return -ENOMEM;
+
+	entry->kobj_name =
+		kasprintf(GFP_KERNEL, "cbmem-%08x", entry->dev->cbmem_entry.id);
+	if (!entry->kobj_name) {
+		ret = -ENOMEM;
+		goto memunmap;
+	}
+
+	entry->kobj = kobject_create_and_add(entry->kobj_name, coreboot_kobj);
+	if (!entry->kobj) {
+		ret = -ENOMEM;
+		goto free_name;
+	}
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
+	ret = cbmem_entry_setup_alias(entry);
+	if (ret)
+		goto free_id_file;
+
+	return 0;
+
+free_id_file:
+	sysfs_remove_file(entry->kobj, &entry->id_file.kobj_attr.attr);
+free_size_file:
+	sysfs_remove_file(entry->kobj, &entry->size_file.kobj_attr.attr);
+free_address_file:
+	sysfs_remove_file(entry->kobj, &entry->address_file.kobj_attr.attr);
+free_mem_file:
+	sysfs_remove_bin_file(entry->kobj, &entry->mem_file);
+free_kobj:
+	kobject_put(entry->kobj);
+free_name:
+	kfree(entry->kobj_name);
+memunmap:
+	memunmap(entry->mem_file_buf);
+	return ret;
+}
+
+static int cbmem_entry_probe(struct coreboot_device *dev)
+{
+	int ret;
+	struct cbmem_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	dev_set_drvdata(&dev->dev, entry);
+	entry->dev = dev;
+	ret = cbmem_entry_setup(entry);
+	if (ret) {
+		kfree(entry);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void cbmem_entry_remove(struct coreboot_device *dev)
+{
+	struct cbmem_entry *entry = dev_get_drvdata(&dev->dev);
+
+	sysfs_remove_file(entry->kobj, &entry->alias_name_file.kobj_attr.attr);
+	sysfs_remove_bin_file(entry->kobj, &entry->mem_file);
+	if (entry->alias)
+		sysfs_remove_link(entry->kobj, entry->alias_link_name);
+	kfree(entry->alias_link_name);
+	memunmap(entry->mem_file_buf);
+	kobject_put(entry->kobj);
+	kfree(entry->kobj_name);
+	kfree(entry);
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
+MODULE_AUTHOR("Google, Inc.");
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

