Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1044C9537
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiCAT4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiCAT4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:56:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A936D392;
        Tue,  1 Mar 2022 11:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646164555; x=1677700555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NL3tmVP6e7ebwMaEfzotOOpoe8/22/j35aqUXMTqY4w=;
  b=WdNJLTpNvXPjgKetOZoitJYeFuw2FKy6WQk6tDlzZ7fLF3yxDufBBHjr
   U8zTTagGls0sZ4qHLZwvDGLqVgtChwo3Nth88FBxnqMYjzy3tjhHts0RL
   F80O6fbGWtVsGyXv8Zs0FFQWhSxms/NnN5DBxHjkioIUbYc3UKxPx3prR
   iReCXGEVk1emO7yLeRAvNMGOYvO++bTCLtGlLn2zVDFWymrUTMbb5SHbX
   ENznMKc88E5hdlUybOuYWt5yZIQjaYaeynWkopRJ5n0giBbgLbq+UETK+
   +FILxr60deDnOkuMPdO4FTfqKe1WsdtoA4zK9EjAs1GJsbr5VZ7KsBhBn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233194893"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233194893"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:53 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630133164"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:53 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: [RFC 04/10] platform/x86/intel/ifs: Load IFS Image
Date:   Tue,  1 Mar 2022 11:54:51 -0800
Message-Id: <20220301195457.21152-5-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220301195457.21152-1-jithu.joseph@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS uses a test image that can be regarded as firmware. The image is
specific to a processor family, model and stepping. IFS requires that a
test image be loaded before any ifs test is initiated. Load the image
that matches processor signature. The IFS image is signed by Intel.

The IFS image file follows a similar naming convention as used for
Intel CPU microcode files. The file must be located in the firmware
directory where the microcode files are placed and named as {family/model
/stepping}.scan as below:

/lib/firmware/intel/ifs/{ff-mm-ss}.scan

Originally-by: Kyung Min Park <kyung.min.park@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/Makefile |  2 +-
 drivers/platform/x86/intel/ifs/core.c   |  8 +++
 drivers/platform/x86/intel/ifs/ifs.h    | 13 ++++
 drivers/platform/x86/intel/ifs/load.c   | 95 +++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/intel/ifs/load.c

diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
index 05b4925402b4..105b377de410 100644
--- a/drivers/platform/x86/intel/ifs/Makefile
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_INTEL_IFS)			+= intel_ifs.o
 
-intel_ifs-objs				:= core.o
+intel_ifs-objs				:= core.o load.o
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index fb3c864d3085..765d9a2c4683 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -8,6 +8,7 @@
 #include <asm/cpu_device_id.h>
 
 #include "ifs.h"
+struct ifs_params ifs_params;
 
 #define X86_MATCH(model)					\
 	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
@@ -24,6 +25,7 @@ static int __init ifs_init(void)
 {
 	const struct x86_cpu_id *m;
 	u64 ia32_core_caps;
+	int ret;
 
 	/* ifs capability check */
 	m = x86_match_cpu(ifs_cpu_ids);
@@ -34,6 +36,12 @@ static int __init ifs_init(void)
 	if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_INTEGRITY))
 		return -ENODEV;
 
+	ret = load_ifs_binary();
+	if (ret) {
+		pr_err("loading ifs binaries failed\n");
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index f3f924fced06..f2daf2cfd3e6 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -7,8 +7,21 @@
 #ifndef _IFS_H_
 #define _IFS_H_
 
+#undef pr_fmt
+#define pr_fmt(fmt) "ifs: " fmt
+
 /* These bits are in the IA32_CORE_CAPABILITIES MSR */
 #define MSR_IA32_CORE_CAPS_INTEGRITY_BIT	2
 #define MSR_IA32_CORE_CAPS_INTEGRITY		BIT(MSR_IA32_CORE_CAPS_INTEGRITY_BIT)
 
+/**
+ * struct ifs_params - global ifs parameter for all cpus.
+ * @loaded_version: stores the currently loaded ifs image version.
+ */
+struct ifs_params {
+	int loaded_version;
+};
+
+int load_ifs_binary(void);
+extern struct ifs_params ifs_params;
 #endif
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
new file mode 100644
index 000000000000..1a5e906c51af
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation.
+ *
+ * Author: Jithu Joseph <jithu.joseph@intel.com>
+ */
+
+#include <linux/firmware.h>
+#include <linux/platform_device.h>
+
+#include "ifs.h"
+static const char *ifs_path = "intel/ifs/";
+
+struct ifs_header {
+	u32 header_ver;
+	u32 blob_revision;
+	u32 date;
+	u32 processor_sig;
+	u32 check_sum;
+	u32 loader_rev;
+	u32 processor_flags;
+	u32 metadata_size;
+	u32 total_size;
+	u32 fusa_info;
+	u64 reserved;
+};
+
+#define IFS_HEADER_SIZE	(sizeof(struct ifs_header))
+static struct ifs_header *ifs_header_ptr;	/* pointer to the ifs image header */
+static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
+
+static const struct firmware *load_binary(const char *path)
+{
+	struct platform_device *ifs_pdev;
+	const struct firmware *fw;
+	int err;
+
+	ifs_pdev = platform_device_register_simple("ifs", -1, NULL, 0);
+	if (IS_ERR(ifs_pdev)) {
+		pr_err("platform device register failed\n");
+		return NULL;
+	}
+	err = request_firmware_direct(&fw, path, &ifs_pdev->dev);
+	if (err) {
+		pr_err("ifs file %s load failed\n", path);
+		goto out;
+	}
+
+out:
+	platform_device_unregister(ifs_pdev);
+
+	return fw;
+}
+
+/*
+ * Compare the image version whenever loading a new image.
+ * Load the new image only if it is later or equal than the current version.
+ */
+static bool is_newer_binary(int current_loaded_version, struct ifs_header *new_image_ptr)
+{
+	return current_loaded_version <= new_image_ptr->blob_revision;
+}
+
+/*
+ * Load ifs image. Before loading ifs module, the ifs image must be located
+ * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
+ */
+int load_ifs_binary(void)
+{
+	const struct firmware *scan_fw;
+	char scan_path[256];
+	int ret;
+
+	snprintf(scan_path, sizeof(scan_path), "%s%02x-%02x-%02x.scan", ifs_path,
+		 boot_cpu_data.x86, boot_cpu_data.x86_model, boot_cpu_data.x86_stepping);
+
+	scan_fw = load_binary(scan_path);
+	if (!scan_fw)
+		return -ENOENT;
+
+	/* only reload new scan image for later version than currently loaded */
+	if (!is_newer_binary(ifs_params.loaded_version, (struct ifs_header *)scan_fw->data)) {
+		pr_warn("Refusing to load older binary");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ifs_header_ptr = (struct ifs_header *)scan_fw->data;
+	ifs_hash_ptr = (u64)(ifs_header_ptr + 1);
+
+	ret = 0;
+out:
+	release_firmware(scan_fw);
+
+	return ret;
+}
-- 
2.17.1

