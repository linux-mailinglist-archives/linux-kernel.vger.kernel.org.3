Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5A47CC26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 05:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242424AbhLVEc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 23:32:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:2246 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242423AbhLVEcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 23:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640147551; x=1671683551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ayhw8UgqGgeb1tTaoQn+SV4YjVsL1Nw1JdQvu2b/qBw=;
  b=LCI1wB6ueonRGANZwgU4Fbc2uVxjdYfUHt3t+NdJ6vfejs1NtaWT45Pj
   zNsACI9N9Md3/Z7xKj4PsPtsXdvF80KELtiyhaW+D43bSFaYT7RKjtEmv
   TTrcyEDF/ZPC8hNbw5+IQnD652/bebzDhtydeiq3wOnJeWy736JolQFpx
   HJVDJgVDvV8pIj57kHs/9qgBGulAmX8UAuGgbQ83ur0K8xyA12rGMc2Yi
   n2F8pm+MbltnKb9Qgr2WybmapEb0PYvzqs/OyL71IeIeE8hVc/Ula+K4K
   46g/qIk3qZ8j4Ao5wj7Spr21QKBVLNGTKNV/oxGBc7rkMBee0kG2xnTD/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240768289"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="240768289"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 20:32:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="617004928"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.186])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2021 20:32:27 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Hongyu Ning <hongyu.ning@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v13 3/4] drivers/acpi: Introduce Platform Firmware Runtime Telemetry
Date:   Wed, 22 Dec 2021 12:32:02 +0800
Message-Id: <383fa2feec875c57211b6300d3947dfeabc2fc7c.1640007183.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1640007183.git.yu.c.chen@intel.com>
References: <cover.1640007183.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver allows user space to fetch telemetry data from the
firmware with the help of the Platform Firmware Runtime Telemetry
interface.

Both PFRU and PFRT are based on ACPI _DSM interfaces located under
special device objects in the ACPI Namespace, but these interfaces are
different from each other, so it is better to provide a separate
driver from each of them. However, they share some common definitions
and naming conventions.

Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Tested-by: Hongyu Ning <hongyu.ning@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v13:Print the _DSM failure result if invalid EFI capsule is provided.
    (Hongyu Ning)
v12:Change the subject to "Introduce Platform Firmware Runtime
    Telemetry", because there is no "update" part in it.
    (Rafael J. Wysocki)
    Revise the commit log.(Rafael J. Wysocki)
    Move pfr_update.c and pfr_telemetry.c) directly in drivers/acpi/
    (Rafael J. Wysocki)
    Update Kconfig with the information regarding PFRT
    (Rafael J. Wysocki)
    Describe the driver briefly at the beginning of the source code
    (Rafael J. Wysocki)
    Replace all PFRU prefix with PFRT.(Rafael J. Wysocki)
    Rename pfru_log_device to pfrt_log_device(Rafael J. Wysocki)
    Rename pfru_log_ida to pfrt_log_ida(Rafael J. Wysocki)
    Replace pfru with pfrt prefix for all function names.
    (Rafael J. Wysocki)
    Use blank lines to separate the cases visually from each
    other.(Rafael J. Wysocki)
    Replace pfru_telemetry%d with pfrt%d, and
    acpi_pfru_telemetry%d to acpi_pfr_telemetry.
    (Rafael J. Wysocki)
v11:No change since v10.
v10:Remove the explicit assignment of the last item of enum.
    (Andy Shevchenko)
v9: Use GUID_INIT() instead of guid_parse() during boot up.
    (Andy Shevchenko)
    Drop uuid from struct pfru_log_device.(Andy Shevchenko)
    Use kfree() instead of ACPI_FREE() in non-ACPICA usage.
    (Andy Shevchenko)
    Use devm_add_action_or_reset() to add ida release into dev resource
    management. (Andy Shevchenko)
    Use devm_kasprintf() instead of kasprintf() to format the
    pfru_log_dev name.(Andy Shevchenko)
    Remove redundant 0 in acpi_pfru_log_ids. (Andy Shevchenko)
v8: Add blank line between generic include header and uapi header.
    (Andy Shevchenko)
    Arrange the order between devm_kzalloc() and normal allocation in
    acpi_pfru_log_probe() that, the former should always be ahead of the
    latter. (Andy Shevchenko)
    Amend commit message to elaborate the reason why PFRU and PRFU_Telemetry
    drivers look the same. (Andy Shevchenko)
v7: Use ida_alloc() to allocate a ID, and release the ID when
    device is removed. (Greg Kroah-Hartman)
    Check the _DSM method at early stage, before allocate or parse
    anything in acpi_pfru_log_probe(). (Greg Kroah-Hartman)
    Set the parent of the misc device. (Greg Kroah-Hartman)
    Use module_platform_driver() instead of platform_driver_register()
    in module_init(). Separate pfru driver and pfru_telemetry driver
    to two files. (Greg Kroah-Hartman) 
v6: Remove linux/uuid.h and use raw buffers to contain uuid.
    (Andy Shevchenko)
    Include types.h in pfru.h. (Andy Shevchenko)
    Use __u8[16] instead of uuid_t. (Andy Shevchenko)
    Replace enum in pfru.h with __u32 as enum size is not the
    same on all possible architectures.
    (Andy Shevchenko)
    Directly return results from the switch cases in pfru_log_ioctl().
    (Andy Shevchenko)
v5: Remove the log output sample in commit log. (Greg Kroah-Hartman)
    Add link for corresponding userspace tool in the commit log.
    (Greg Kroah-Hartman)
    Replace the telemetry .read() with .mmap() so that the userspace
    could mmap once, and read multiple times. (Greg Kroah-Hartman)
    Fix the compile warning by declaring the pfru_log_ioctl() as
    static. (kernel test robot LKP)
v4: Change the write() to be the code injection/update, the read() to
    be telemetry retrieval and all of the rest to be ioctl()s under
    one special device file.(Rafael J. Wysocki)
    Remove redundant parens. (Rafael J. Wysocki)
    Putting empty code lines after an if () statement that is not
    followed by a block. (Rafael J. Wysocki)
    Remove "goto" tags to make the code more readable. (Rafael J. Wysocki)
v3: Use __u32 instead of int and __64 instead of unsigned long
    in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
    Rename the structure in uapi to start with a prefix pfru so as
    to avoid confusing in the global namespace. (Greg Kroah-Hartman)
v2: Do similar clean up as pfru_update driver:
    Add sanity check for duplicated instance of ACPI device.
    Update the driver to work with allocated telem_device objects.
    (Mike Rapoport)
    For each switch case pair, get rid of the magic case numbers
    and add a default clause with the error handling.
    (Mike Rapoport)
---
 drivers/acpi/Kconfig         |   8 +-
 drivers/acpi/Makefile        |   2 +-
 drivers/acpi/pfr_telemetry.c | 434 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/pfrut.h   |  88 +++++++
 4 files changed, 529 insertions(+), 3 deletions(-)
 create mode 100644 drivers/acpi/pfr_telemetry.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index d0b3ca9d4a97..91f1da16934d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -532,8 +532,12 @@ config ACPI_PFRUT
 	  The existing firmware code can be modified (driver update) or
 	  extended by adding new code to the firmware (code injection).
 
-	  To compile this driver as module, choose M here:
-	  the module will be called pfr_update.
+	  Besides, the telemetry driver allows user space to fetch telemetry
+	  data from the firmware with the help of the Platform Firmware Runtime
+	  Telemetry interface.
+
+	  To compile the drivers as modules, choose M here:
+	  the modules will be called pfr_update and pfr_telemetry.
 
 if ARM64
 source "drivers/acpi/arm64/Kconfig"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 2ad2e821cc08..d3dc79298ce3 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -102,7 +102,7 @@ obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
-obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o
+obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
new file mode 100644
index 000000000000..da50dd80192c
--- /dev/null
+++ b/drivers/acpi/pfr_telemetry.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI Platform Firmware Runtime Telemetry driver
+ *
+ * Copyright (C) 2021 Intel Corporation
+ * Author: Chen Yu <yu.c.chen@intel.com>
+ *
+ * This driver allows user space to fetch telemetry data from the
+ * firmware with the help of the Platform Firmware Runtime Telemetry
+ * interface.
+ */
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/uio.h>
+#include <linux/uuid.h>
+
+#include <uapi/linux/pfrut.h>
+
+#define PFRT_LOG_EXEC_IDX	0
+#define PFRT_LOG_HISTORY_IDX	1
+
+#define PFRT_LOG_ERR		0
+#define PFRT_LOG_WARN	1
+#define PFRT_LOG_INFO	2
+#define PFRT_LOG_VERB	4
+
+#define PFRT_FUNC_SET_LEV		1
+#define PFRT_FUNC_GET_LEV		2
+#define PFRT_FUNC_GET_DATA		3
+
+#define PFRT_REVID_1		1
+#define PFRT_REVID_2		2
+#define PFRT_DEFAULT_REV_ID	PFRT_REVID_1
+
+enum log_index {
+	LOG_STATUS_IDX = 0,
+	LOG_EXT_STATUS_IDX = 1,
+	LOG_MAX_SZ_IDX = 2,
+	LOG_CHUNK1_LO_IDX = 3,
+	LOG_CHUNK1_HI_IDX = 4,
+	LOG_CHUNK1_SZ_IDX = 5,
+	LOG_CHUNK2_LO_IDX = 6,
+	LOG_CHUNK2_HI_IDX = 7,
+	LOG_CHUNK2_SZ_IDX = 8,
+	LOG_ROLLOVER_CNT_IDX = 9,
+	LOG_RESET_CNT_IDX = 10,
+	LOG_NR_IDX
+};
+
+struct pfrt_log_device {
+	int index;
+	struct pfrt_log_info info;
+	struct device *parent_dev;
+	struct miscdevice miscdev;
+};
+
+/* pfrt_guid is the parameter for _DSM method */
+static const guid_t pfrt_log_guid =
+	GUID_INIT(0x75191659, 0x8178, 0x4D9D, 0xB8, 0x8F, 0xAC, 0x5E,
+		  0x5E, 0x93, 0xE8, 0xBF);
+
+static DEFINE_IDA(pfrt_log_ida);
+
+static inline struct pfrt_log_device *to_pfrt_log_dev(struct file *file)
+{
+	return container_of(file->private_data, struct pfrt_log_device, miscdev);
+}
+
+static int get_pfrt_log_data_info(struct pfrt_log_data_info *data_info,
+				  struct pfrt_log_device *pfrt_log_dev)
+{
+	acpi_handle handle = ACPI_HANDLE(pfrt_log_dev->parent_dev);
+	union acpi_object *out_obj, in_obj, in_buf;
+	int ret = -EBUSY;
+
+	memset(&in_obj, 0, sizeof(in_obj));
+	memset(&in_buf, 0, sizeof(in_buf));
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = 1;
+	in_obj.package.elements = &in_buf;
+	in_buf.type = ACPI_TYPE_INTEGER;
+	in_buf.integer.value = pfrt_log_dev->info.log_type;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfrt_log_guid,
+					  pfrt_log_dev->info.log_revid, PFRT_FUNC_GET_DATA,
+					  &in_obj, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return -EINVAL;
+
+	if (out_obj->package.count < LOG_NR_IDX ||
+	    out_obj->package.elements[LOG_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[LOG_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[LOG_MAX_SZ_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[LOG_CHUNK1_LO_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[LOG_CHUNK1_HI_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[LOG_CHUNK1_SZ_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[LOG_CHUNK2_LO_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[LOG_CHUNK2_HI_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[LOG_CHUNK2_SZ_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[LOG_ROLLOVER_CNT_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[LOG_RESET_CNT_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	data_info->status = out_obj->package.elements[LOG_STATUS_IDX].integer.value;
+	data_info->ext_status =
+		out_obj->package.elements[LOG_EXT_STATUS_IDX].integer.value;
+	if (data_info->status != DSM_SUCCEED) {
+		dev_dbg(pfrt_log_dev->parent_dev, "Error Status:%d\n", data_info->status);
+		dev_dbg(pfrt_log_dev->parent_dev, "Error Extend Status:%d\n",
+			data_info->ext_status);
+		goto free_acpi_buffer;
+	}
+
+	data_info->max_data_size =
+		out_obj->package.elements[LOG_MAX_SZ_IDX].integer.value;
+	data_info->chunk1_addr_lo =
+		out_obj->package.elements[LOG_CHUNK1_LO_IDX].integer.value;
+	data_info->chunk1_addr_hi =
+		out_obj->package.elements[LOG_CHUNK1_HI_IDX].integer.value;
+	data_info->chunk1_size =
+		out_obj->package.elements[LOG_CHUNK1_SZ_IDX].integer.value;
+	data_info->chunk2_addr_lo =
+		out_obj->package.elements[LOG_CHUNK2_LO_IDX].integer.value;
+	data_info->chunk2_addr_hi =
+		out_obj->package.elements[LOG_CHUNK2_HI_IDX].integer.value;
+	data_info->chunk2_size =
+		out_obj->package.elements[LOG_CHUNK2_SZ_IDX].integer.value;
+	data_info->rollover_cnt =
+		out_obj->package.elements[LOG_ROLLOVER_CNT_IDX].integer.value;
+	data_info->reset_cnt =
+		out_obj->package.elements[LOG_RESET_CNT_IDX].integer.value;
+
+	ret = 0;
+
+free_acpi_buffer:
+	kfree(out_obj);
+
+	return ret;
+}
+
+static int set_pfrt_log_level(int level, struct pfrt_log_device *pfrt_log_dev)
+{
+	acpi_handle handle = ACPI_HANDLE(pfrt_log_dev->parent_dev);
+	union acpi_object *out_obj, *obj, in_obj, in_buf;
+	enum pfru_dsm_status status, ext_status;
+	int ret = 0;
+
+	memset(&in_obj, 0, sizeof(in_obj));
+	memset(&in_buf, 0, sizeof(in_buf));
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = 1;
+	in_obj.package.elements = &in_buf;
+	in_buf.type = ACPI_TYPE_INTEGER;
+	in_buf.integer.value = level;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfrt_log_guid,
+					  pfrt_log_dev->info.log_revid, PFRT_FUNC_SET_LEV,
+					  &in_obj, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return -EINVAL;
+
+	obj = &out_obj->package.elements[0];
+	status = obj->integer.value;
+	if (status != DSM_SUCCEED) {
+		obj = &out_obj->package.elements[1];
+		ext_status = obj->integer.value;
+		dev_dbg(pfrt_log_dev->parent_dev, "Error Status:%d\n", status);
+		dev_dbg(pfrt_log_dev->parent_dev, "Error Extend Status:%d\n", ext_status);
+		ret = -EBUSY;
+	}
+
+	kfree(out_obj);
+
+	return ret;
+}
+
+static int get_pfrt_log_level(struct pfrt_log_device *pfrt_log_dev)
+{
+	acpi_handle handle = ACPI_HANDLE(pfrt_log_dev->parent_dev);
+	union acpi_object *out_obj, *obj;
+	enum pfru_dsm_status status, ext_status;
+	int ret = -EBUSY;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfrt_log_guid,
+					  pfrt_log_dev->info.log_revid, PFRT_FUNC_GET_LEV,
+					  NULL, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return -EINVAL;
+
+	obj = &out_obj->package.elements[0];
+	if (obj->type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	status = obj->integer.value;
+	if (status != DSM_SUCCEED) {
+		obj = &out_obj->package.elements[1];
+		ext_status = obj->integer.value;
+		dev_dbg(pfrt_log_dev->parent_dev, "Error Status:%d\n", status);
+		dev_dbg(pfrt_log_dev->parent_dev, "Error Extend Status:%d\n", ext_status);
+		goto free_acpi_buffer;
+	}
+
+	obj = &out_obj->package.elements[2];
+	if (obj->type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	ret = obj->integer.value;
+
+free_acpi_buffer:
+	kfree(out_obj);
+
+	return ret;
+}
+
+static int valid_log_level(u32 level)
+{
+	return level == PFRT_LOG_ERR || level == PFRT_LOG_WARN ||
+	       level == PFRT_LOG_INFO || level == PFRT_LOG_VERB;
+}
+
+static int valid_log_type(u32 type)
+{
+	return type == PFRT_LOG_EXEC_IDX || type == PFRT_LOG_HISTORY_IDX;
+}
+
+static inline int valid_log_revid(u32 id)
+{
+	return id == PFRT_REVID_1 || id == PFRT_REVID_2;
+}
+
+static long pfrt_log_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pfrt_log_device *pfrt_log_dev = to_pfrt_log_dev(file);
+	struct pfrt_log_data_info data_info;
+	struct pfrt_log_info info;
+	void __user *p;
+	int ret = 0;
+
+	p = (void __user *)arg;
+
+	switch (cmd) {
+	case PFRT_LOG_IOC_SET_INFO:
+		if (copy_from_user(&info, p, sizeof(info)))
+			return -EFAULT;
+
+		if (valid_log_revid(info.log_revid))
+			pfrt_log_dev->info.log_revid = info.log_revid;
+
+		if (valid_log_level(info.log_level)) {
+			ret = set_pfrt_log_level(info.log_level, pfrt_log_dev);
+			if (ret < 0)
+				return ret;
+
+			pfrt_log_dev->info.log_level = info.log_level;
+		}
+
+		if (valid_log_type(info.log_type))
+			pfrt_log_dev->info.log_type = info.log_type;
+
+		return 0;
+
+	case PFRT_LOG_IOC_GET_INFO:
+		info.log_level = get_pfrt_log_level(pfrt_log_dev);
+		if (ret < 0)
+			return ret;
+
+		info.log_type = pfrt_log_dev->info.log_type;
+		info.log_revid = pfrt_log_dev->info.log_revid;
+		if (copy_to_user(p, &info, sizeof(info)))
+			return -EFAULT;
+
+		return 0;
+
+	case PFRT_LOG_IOC_GET_DATA_INFO:
+		ret = get_pfrt_log_data_info(&data_info, pfrt_log_dev);
+		if (ret)
+			return ret;
+
+		if (copy_to_user(p, &data_info, sizeof(struct pfrt_log_data_info)))
+			return -EFAULT;
+
+		return 0;
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+static int
+pfrt_log_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct pfrt_log_device *pfrt_log_dev;
+	struct pfrt_log_data_info info;
+	unsigned long psize, vsize;
+	phys_addr_t base_addr;
+	int ret;
+
+	if (vma->vm_flags & VM_WRITE)
+		return -EROFS;
+
+	/* changing from read to write with mprotect is not allowed */
+	vma->vm_flags &= ~VM_MAYWRITE;
+
+	pfrt_log_dev = to_pfrt_log_dev(file);
+
+	ret = get_pfrt_log_data_info(&info, pfrt_log_dev);
+	if (ret)
+		return ret;
+
+	base_addr = (phys_addr_t)((info.chunk2_addr_hi << 32) | info.chunk2_addr_lo);
+	/* pfrt update has not been launched yet */
+	if (!base_addr)
+		return -ENODEV;
+
+	psize = info.max_data_size;
+	/* base address and total buffer size must be page aligned */
+	if (!PAGE_ALIGNED(base_addr) || !PAGE_ALIGNED(psize))
+		return -ENODEV;
+
+	vsize = vma->vm_end - vma->vm_start;
+	if (vsize > psize)
+		return -EINVAL;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	if (io_remap_pfn_range(vma, vma->vm_start, PFN_DOWN(base_addr),
+			       vsize, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static const struct file_operations acpi_pfrt_log_fops = {
+	.owner		= THIS_MODULE,
+	.mmap		= pfrt_log_mmap,
+	.unlocked_ioctl = pfrt_log_ioctl,
+	.llseek		= noop_llseek,
+};
+
+static int acpi_pfrt_log_remove(struct platform_device *pdev)
+{
+	struct pfrt_log_device *pfrt_log_dev = platform_get_drvdata(pdev);
+
+	misc_deregister(&pfrt_log_dev->miscdev);
+
+	return 0;
+}
+
+static void pfrt_log_put_idx(void *data)
+{
+	struct pfrt_log_device *pfrt_log_dev = data;
+
+	ida_free(&pfrt_log_ida, pfrt_log_dev->index);
+}
+
+static int acpi_pfrt_log_probe(struct platform_device *pdev)
+{
+	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
+	struct pfrt_log_device *pfrt_log_dev;
+	int ret;
+
+	if (!acpi_has_method(handle, "_DSM")) {
+		dev_dbg(&pdev->dev, "Missing _DSM\n");
+		return -ENODEV;
+	}
+
+	pfrt_log_dev = devm_kzalloc(&pdev->dev, sizeof(*pfrt_log_dev), GFP_KERNEL);
+	if (!pfrt_log_dev)
+		return -ENOMEM;
+
+	ret = ida_alloc(&pfrt_log_ida, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	pfrt_log_dev->index = ret;
+	ret = devm_add_action_or_reset(&pdev->dev, pfrt_log_put_idx, pfrt_log_dev);
+	if (ret)
+		return ret;
+
+	pfrt_log_dev->info.log_revid = PFRT_DEFAULT_REV_ID;
+	pfrt_log_dev->parent_dev = &pdev->dev;
+
+	pfrt_log_dev->miscdev.minor = MISC_DYNAMIC_MINOR;
+	pfrt_log_dev->miscdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						    "pfrt%d",
+						    pfrt_log_dev->index);
+	if (!pfrt_log_dev->miscdev.name)
+		return -ENOMEM;
+
+	pfrt_log_dev->miscdev.nodename = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+							"acpi_pfr_telemetry%d",
+							pfrt_log_dev->index);
+	if (!pfrt_log_dev->miscdev.nodename)
+		return -ENOMEM;
+
+	pfrt_log_dev->miscdev.fops = &acpi_pfrt_log_fops;
+	pfrt_log_dev->miscdev.parent = &pdev->dev;
+
+	ret = misc_register(&pfrt_log_dev->miscdev);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, pfrt_log_dev);
+
+	return 0;
+}
+
+static const struct acpi_device_id acpi_pfrt_log_ids[] = {
+	{"INTC1081"},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, acpi_pfrt_log_ids);
+
+static struct platform_driver acpi_pfrt_log_driver = {
+	.driver = {
+		.name = "pfr_telemetry",
+		.acpi_match_table = acpi_pfrt_log_ids,
+	},
+	.probe = acpi_pfrt_log_probe,
+	.remove = acpi_pfrt_log_remove,
+};
+module_platform_driver(acpi_pfrt_log_driver);
+
+MODULE_DESCRIPTION("Platform Firmware Runtime Update Telemetry driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/pfrut.h b/include/uapi/linux/pfrut.h
index fa97e80a93b7..42fa15f8310d 100644
--- a/include/uapi/linux/pfrut.h
+++ b/include/uapi/linux/pfrut.h
@@ -171,4 +171,92 @@ struct pfru_updated_result {
 	__u64 high_exec_time;
 };
 
+/**
+ * struct pfrt_log_data_info - Log Data from telemetry service.
+ * @status: Indicator of whether this update succeed.
+ * @ext_status: Implementation specific update result.
+ * @chunk1_addr_lo: Low 32bit physical address of the telemetry data chunk1
+ *                  starting address.
+ * @chunk1_addr_hi: High 32bit physical address of the telemetry data chunk1
+ *                  starting address.
+ * @chunk2_addr_lo: Low 32bit physical address of the telemetry data chunk2
+ *                  starting address.
+ * @chunk2_addr_hi: High 32bit physical address of the telemetry data chunk2
+ *                  starting address.
+ * @max_data_size: Maximum supported size of data of all data chunks combined.
+ * @chunk1_size: Data size in bytes of the telemetry data chunk1 buffer.
+ * @chunk2_size: Data size in bytes of the telemetry data chunk2 buffer.
+ * @rollover_cnt: Number of times telemetry data buffer is overwritten
+ *                since telemetry buffer reset.
+ * @reset_cnt: Number of times telemetry services resets that results in
+ *             rollover count and data chunk buffers are reset.
+ */
+struct pfrt_log_data_info {
+	__u32 status;
+	__u32 ext_status;
+	__u64 chunk1_addr_lo;
+	__u64 chunk1_addr_hi;
+	__u64 chunk2_addr_lo;
+	__u64 chunk2_addr_hi;
+	__u32 max_data_size;
+	__u32 chunk1_size;
+	__u32 chunk2_size;
+	__u32 rollover_cnt;
+	__u32 reset_cnt;
+};
+
+/**
+ * struct pfrt_log_info - Telemetry log information.
+ * @log_level: The telemetry log level.
+ * @log_type: The telemetry log type(history and execution).
+ * @log_revid: The telemetry log revision id.
+ */
+struct pfrt_log_info {
+	__u32 log_level;
+	__u32 log_type;
+	__u32 log_revid;
+};
+
+/**
+ * PFRT_LOG_IOC_SET_INFO - _IOW(PFRUT_IOCTL_MAGIC, 0x06,
+ *				struct pfrt_log_info)
+ *
+ * Return:
+ * * 0			- success
+ * * -EFAULT		- fail to get the setting parameter
+ * * -EINVAL		- fail to set the log level
+ *
+ * Set the PFRT log level and log type. The input information is
+ * a struct pfrt_log_info.
+ */
+#define PFRT_LOG_IOC_SET_INFO _IOW(PFRUT_IOCTL_MAGIC, 0x06, struct pfrt_log_info)
+
+/**
+ * PFRT_LOG_IOC_GET_INFO - _IOR(PFRUT_IOCTL_MAGIC, 0x07,
+ *				struct pfrt_log_info)
+ *
+ * Return:
+ * * 0			- success
+ * * -EINVAL		- fail to get the log level
+ * * -EFAULT		- fail to copy the result back to userspace
+ *
+ * Retrieve log level and log type of the telemetry. The information is
+ * a struct pfrt_log_info.
+ */
+#define PFRT_LOG_IOC_GET_INFO _IOR(PFRUT_IOCTL_MAGIC, 0x07, struct pfrt_log_info)
+
+/**
+ * PFRT_LOG_IOC_GET_DATA_INFO - _IOR(PFRUT_IOCTL_MAGIC, 0x08,
+ *				     struct pfrt_log_data_info)
+ *
+ * Return:
+ * * 0			- success
+ * * -EINVAL		- fail to get the log buffer information
+ * * -EFAULT		- fail to copy the log buffer information to userspace
+ *
+ * Retrieve data information about the telemetry. The information
+ * is a struct pfrt_log_data_info.
+ */
+#define PFRT_LOG_IOC_GET_DATA_INFO _IOR(PFRUT_IOCTL_MAGIC, 0x08, struct pfrt_log_data_info)
+
 #endif /* __PFRUT_H__ */
-- 
2.25.1

