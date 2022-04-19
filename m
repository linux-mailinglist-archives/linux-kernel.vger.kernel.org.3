Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C605073B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354894AbiDSQm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354754AbiDSQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A9E15FC5;
        Tue, 19 Apr 2022 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650386349; x=1681922349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NLrqu/pKW+TURbMxtYrEbcPFcWVgS9/aTQM+0w4anyU=;
  b=codKyXn6xpDdgdy2PS/Ct/EP++Yd7X2HusGsfVpZh50hSOc/BmfdQx9l
   ugzdyMsrcbSyQ5VWQJXwjlqg3DkrW1f5eIiC2W2ip9oSYQ4WCVkSrY7qe
   p6xSnC8WUNv9X8QTByOOVknv10PjbZY35tV8eZPGGMRuhsotVyBVuo1w5
   YNqphVfx37vpmtGjHu6fClpGh2mLlp1XesZKO1wGlTUdJldpRqk0jMIUd
   3UchTdA0HlXAXtEWC/5SwTlOcegXqaHY3MaLJiIQcUPOmwwyMT1lcyhQD
   D2EUrdTOBXcDfpCRq3zpt0wJE5z5DcevcmeIjLLMnoB1bKUsRv+7RdiPB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245702531"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245702531"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554802143"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:07 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v3 05/11] platform/x86/intel/ifs: Read IFS firmware image
Date:   Tue, 19 Apr 2022 09:38:53 -0700
Message-Id: <20220419163859.2228874-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419163859.2228874-1-tony.luck@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jithu Joseph <jithu.joseph@intel.com>

Driver probe routine allocates structure to communicate status
and parameters between functions in the driver. Also call
load_ifs_binary() to load the scan image file.

There is a separate scan image file for each processor family,
model, stepping combination. This is read from the static path:

  /lib/firmware/intel/ifs/{ff-mm-ss}.scan

Step 1 in loading is to generate the correct path and use
request_firmware_direct() to load into memory.

Subsequent patches will use the IFS MSR interfaces to copy
the image to BIOS reserved memory and validate the SHA256
checksums.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/Makefile |  2 +-
 drivers/platform/x86/intel/ifs/core.c   | 23 ++++++++++++++++++
 drivers/platform/x86/intel/ifs/ifs.h    | 19 +++++++++++++++
 drivers/platform/x86/intel/ifs/load.c   | 31 +++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/intel/ifs/ifs.h
 create mode 100644 drivers/platform/x86/intel/ifs/load.c

diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
index bf8adc57892c..eab0cc81f38e 100644
--- a/drivers/platform/x86/intel/ifs/Makefile
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -2,4 +2,4 @@ obj-$(CONFIG_INTEL_IFS_DEVICE)	+= intel_ifs_device.o
 
 obj-$(CONFIG_INTEL_IFS)		+= intel_ifs.o
 
-intel_ifs-objs			:= core.o
+intel_ifs-objs			:= core.o load.o
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index eb34b877dac0..139449f11a64 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -4,7 +4,30 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
+#include "ifs.h"
+
+static int ifs_probe(struct platform_device *pdev)
+{
+	struct ifs_data *ifsd;
+
+	ifsd = devm_kzalloc(&pdev->dev, sizeof(*ifsd), GFP_KERNEL);
+	if (!ifsd)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, ifsd);
+
+	switch (pdev->id) {
+	case 0:
+		/* Load IFS binary to BIOS reserved memory area */
+		ifsd->loaded = !load_ifs_binary(&pdev->dev);
+		break;
+	}
+
+	return 0;
+}
+
 static struct platform_driver intel_ifs_driver = {
+	.probe = ifs_probe,
 	.driver = {
 		.name = "intel_ifs",
 	},
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
new file mode 100644
index 000000000000..dacc8b6ce159
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2022 Intel Corporation. */
+
+#ifndef _IFS_H_
+#define _IFS_H_
+
+/**
+ * struct ifs_data - attributes related to intel IFS driver
+ * @loaded_version: stores the currently loaded ifs image version.
+ * @loaded: If a valid test binary has been loaded into the memory
+ */
+struct ifs_data {
+	int loaded_version;
+	bool loaded;
+};
+
+int load_ifs_binary(struct device *dev);
+
+#endif
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
new file mode 100644
index 000000000000..fa6c64707a73
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. */
+
+#include <linux/firmware.h>
+#include <linux/platform_device.h>
+
+static const char *ifs_path = "intel/ifs/";
+
+/*
+ * Load ifs image. Before loading ifs module, the ifs image must be located
+ * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
+ */
+int load_ifs_binary(struct device *dev)
+{
+	const struct firmware *fw;
+	char scan_path[256];
+	int ret;
+
+	snprintf(scan_path, sizeof(scan_path), "%s%02x-%02x-%02x.scan", ifs_path,
+		 boot_cpu_data.x86, boot_cpu_data.x86_model, boot_cpu_data.x86_stepping);
+
+	ret = request_firmware_direct(&fw, scan_path, dev);
+	if (ret) {
+		dev_err(dev, "ifs file %s load failed\n", scan_path);
+		return ret;
+	}
+
+	release_firmware(fw);
+
+	return ret;
+}
-- 
2.35.1

