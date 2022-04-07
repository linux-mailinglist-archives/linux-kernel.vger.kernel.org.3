Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E924F87E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiDGTRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242715AbiDGTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:16:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6A423EC55;
        Thu,  7 Apr 2022 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649358865; x=1680894865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7eM9pzEoBBO/CEb/X2lrrHN+IpqxMUZxnvmVPvUQTg0=;
  b=lsjZA5piTPmXwTZ/lJ3h12Puu6uEvLLbn1PG8FDJ9mIantgdWq43Hasu
   yVCRUa4+aVeqnaZ/EI1PnIm/VlDSb+GXKBY3840CqcfDE0OhN3Hwa6NuZ
   C73OwTj6SFpc4gCiYGg781siX6Fk3ISroIZugkxty7MA96ZqjsIsB173p
   qboEfP4oBhjvU0+zXwVUWMlcswuSb1y4fxeQJX4B3eyJLGOrZDEUVNmCK
   3RMoL9T68nz18S3WEJxyfgO4lIJFcwv3XpuJmvQdHAi3Cpz+qBqOvZxPe
   oMgdAydSWh7F9KvqZOHfvz4nhZ/Rhhbay7eSB9fiDBxDFin9E9rKJ8jE9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260255380"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="260255380"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571193714"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:16 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v2 04/10] platform/x86/intel/ifs: Load IFS Image
Date:   Thu,  7 Apr 2022 12:13:41 -0700
Message-Id: <20220407191347.9681-5-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220407191347.9681-1-jithu.joseph@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS uses a scan image format that shares the same header as
microcode updates and deployment approach for these images mirrors
that of microcode update. Specifically, enable images to be deployed
relative to a static symlink in /lib/firmware and then load
into kernel memory via request_firmware().

The image is specific to a processor family, model and stepping.
IFS requires that a test image be loaded before any ifs test is
initiated. Load the image that matches processor signature.
The IFS image is signed by Intel.

The IFS image file follows a similar naming convention as used for
Intel CPU microcode files. The file must be located in the firmware
directory where the microcode files are placed and named as {family/model
/stepping}.scan as below:

/lib/firmware/intel/ifs/{ff-mm-ss}.scan

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/Makefile |  2 +-
 drivers/platform/x86/intel/ifs/core.c   | 62 ++++++++++++++++++++
 drivers/platform/x86/intel/ifs/ifs.h    | 15 +++++
 drivers/platform/x86/intel/ifs/load.c   | 76 +++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/intel/ifs/load.c

diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
index c44305dff542..b69d026ca9da 100644
--- a/drivers/platform/x86/intel/ifs/Makefile
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_INTEL_IFS)			+= intel_ifs.o
 
-intel_ifs-objs				:= core.o
+intel_ifs-objs				:= core.o load.o
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 87956623208f..716f333a064b 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -2,10 +2,14 @@
 /* Copyright(c) 2022 Intel Corporation. */
 
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <asm/cpu_device_id.h>
 
 #include "ifs.h"
 
+struct platform_device *ifs_pdev;
+struct ifs_binary ifs_binary;
+
 #define X86_MATCH(model)					\
 	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
 		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, NULL)
@@ -17,10 +21,39 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
 
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
 
+static int ifs_probe(struct platform_device *pdev)
+{
+	/* Load IFS binary to BIOS reserved memory area */
+	if (load_ifs_binary()) {
+		ifs_binary.loaded = false;
+		dev_err(&ifs_pdev->dev, "Failed to Load IFS binary. Try reloading.\n");
+		return -EPERM;
+	}
+	ifs_binary.loaded = true;
+	return 0;
+}
+
+static int ifs_remove(struct platform_device *pdev)
+{
+	ifs_binary.loaded = false;
+	ifs_binary.loaded_version = 0;
+	/* No OS managed memory to free */
+	return 0;
+}
+
+static struct platform_driver ifs_driver = {
+	.probe = ifs_probe,
+	.remove = ifs_remove,
+	.driver = {
+		.name = "intel_ifs",
+	},
+};
+
 static int __init ifs_init(void)
 {
 	const struct x86_cpu_id *m;
 	u64 ia32_core_caps;
+	int ret;
 
 	/* ifs capability check */
 	m = x86_match_cpu(ifs_cpu_ids);
@@ -31,11 +64,40 @@ static int __init ifs_init(void)
 	if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_INTEGRITY))
 		return -ENODEV;
 
+	ifs_binary.loaded = false;
+
+	ret = platform_driver_register(&ifs_driver);
+	if (ret) {
+		pr_err("intel_ifs: platform driver register failed\n");
+		return ret;
+	}
+
+	ifs_pdev = platform_device_alloc("intel_ifs", -1);
+	if (!ifs_pdev) {
+		pr_err("intel_ifs: platform device allocation failed\n");
+		ret = -ENOMEM;
+		goto drv_unreg;
+	}
+
+	ret = platform_device_add(ifs_pdev);
+	if (ret) {
+		pr_err("intel_ifs: platform device add failed\n");
+		platform_device_put(ifs_pdev);
+		goto drv_unreg;
+	}
+
 	return 0;
+
+drv_unreg:
+	platform_driver_unregister(&ifs_driver);
+	return ret;
+
 }
 
 static void __exit ifs_exit(void)
 {
+	platform_device_unregister(ifs_pdev);
+	platform_driver_unregister(&ifs_driver);
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index bb25a4cd3af6..e1c9c16cbadb 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -8,4 +8,19 @@
 #define MSR_IA32_CORE_CAPS_INTEGRITY_BIT	2
 #define MSR_IA32_CORE_CAPS_INTEGRITY		BIT(MSR_IA32_CORE_CAPS_INTEGRITY_BIT)
 
+#define IFS_BLOB_REV_ERR_INJ			BIT(30)
+#define IFS_BLOB_REV_DEBUG			BIT(31)
+/**
+ * struct ifs_binary - attributes related to test binary
+ * @loaded_version: stores the currently loaded ifs image version.
+ * @loaded: If a valid test binary has been loaded into the memory
+ */
+struct ifs_binary {
+	int loaded_version;
+	bool loaded;
+};
+
+int load_ifs_binary(void);
+extern struct platform_device *ifs_pdev;
+extern struct ifs_binary ifs_binary;
 #endif
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
new file mode 100644
index 000000000000..a1be4d6558a1
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. */
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
+	const struct firmware *fw;
+	int err;
+
+	err = request_firmware_direct(&fw, path, &ifs_pdev->dev);
+	if (err) {
+		dev_err(&ifs_pdev->dev, "ifs file %s load failed\n", path);
+		goto out;
+	}
+
+out:
+
+	return fw;
+}
+
+static void check_binary_flags(struct ifs_header *new_image_ptr)
+{
+	if (new_image_ptr->blob_revision & IFS_BLOB_REV_DEBUG)
+		dev_warn(&ifs_pdev->dev, "Debug flag is set in the binary loaded\n");
+	if (new_image_ptr->blob_revision & IFS_BLOB_REV_ERR_INJ)
+		dev_warn(&ifs_pdev->dev, "Error Injection flag is set in the binary loaded\n");
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
+	ifs_header_ptr = (struct ifs_header *)scan_fw->data;
+	ifs_hash_ptr = (u64)(ifs_header_ptr + 1);
+
+	check_binary_flags(ifs_header_ptr);
+	release_firmware(scan_fw);
+
+	return ret;
+}
-- 
2.17.1

