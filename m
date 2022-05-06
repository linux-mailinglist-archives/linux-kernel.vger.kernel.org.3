Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6241A51CE8D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388078AbiEFBos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387992AbiEFBo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:44:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE1B5BD36;
        Thu,  5 May 2022 18:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651801247; x=1683337247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MYSh0ikaKtRZ32y+j+FGoa2BpcHcDUqd1Dhnwhabyo4=;
  b=l3hqCpD66FXhF6J2v3l6wgKmNL8MRqt0twd+Bds8TJicGauPNqWbBQXN
   PRbnQdsLlJQhcx50ioX9NzISKDouN5ULTcxcUyZuUPLaPvctSm6LfghG9
   Y7VNIeoormNPK3PlGFBc21WIkuQ+ung2ggM7AsfO910rTQEAXUTLHCwsG
   hlHlgiOtRxXEtneU5rl/gOtMJxjgPf6l2F5glDFbANuuEcWPt4a6yn/4X
   wEsF6xZkkd6c/J+uFpsHnxhRlWHUIsVkpo63shfgzzLBc5ybDh1bjPk6r
   JySxkNEAkFEIC/89eyiTsOBH2HCKTSuV5Sbk5JYnhDrOzV4xThKlb+iVv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293519431"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="293519431"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:40:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537645034"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:40:45 -0700
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
Subject: [PATCH v6 05/11] platform/x86/intel/ifs: Read IFS firmware image
Date:   Thu,  5 May 2022 18:40:29 -0700
Message-Id: <20220506014035.1173578-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506014035.1173578-1-tony.luck@intel.com>
References: <20220428153849.295779-1-tony.luck@intel.com>
 <20220506014035.1173578-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel/ifs/Makefile |  2 +-
 drivers/platform/x86/intel/ifs/core.c   | 22 ++++++++++++++++++-
 drivers/platform/x86/intel/ifs/ifs.h    | 25 ++++++++++++++++++++++
 drivers/platform/x86/intel/ifs/load.c   | 28 +++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/x86/intel/ifs/ifs.h
 create mode 100644 drivers/platform/x86/intel/ifs/load.c

diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
index af904880e959..98b6fde15689 100644
--- a/drivers/platform/x86/intel/ifs/Makefile
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_INTEL_IFS)		+= intel_ifs.o
 
-intel_ifs-objs			:= core.o
+intel_ifs-objs			:= core.o load.o
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index e3623ac691b5..f62578dae8e9 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -6,6 +6,8 @@
 
 #include <asm/cpu_device_id.h>
 
+#include "ifs.h"
+
 #define X86_MATCH(model)				\
 	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,	\
 		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, NULL)
@@ -16,6 +18,17 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
 
+static struct ifs_device ifs_device = {
+	.data = {
+		.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
+	},
+	.misc = {
+		.name = "intel_ifs_0",
+		.nodename = "intel_ifs/0",
+		.minor = MISC_DYNAMIC_MINOR,
+	},
+};
+
 static int __init ifs_init(void)
 {
 	const struct x86_cpu_id *m;
@@ -34,11 +47,18 @@ static int __init ifs_init(void)
 	if (rdmsrl_safe(MSR_INTEGRITY_CAPS, &msrval))
 		return -ENODEV;
 
-	return 0;
+	if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
+	    !misc_register(&ifs_device.misc)) {
+		ifs_load_firmware(ifs_device.misc.this_device);
+		return 0;
+	}
+
+	return -ENODEV;
 }
 
 static void __exit ifs_exit(void)
 {
+	misc_deregister(&ifs_device.misc);
 }
 
 module_init(ifs_init);
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
new file mode 100644
index 000000000000..47e5f8344fd8
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2022 Intel Corporation. */
+
+#ifndef _IFS_H_
+#define _IFS_H_
+
+#include <linux/device.h>
+#include <linux/miscdevice.h>
+
+/**
+ * struct ifs_data - attributes related to intel IFS driver
+ * @integrity_cap_bit - MSR_INTEGRITY_CAPS bit enumerating this test
+ */
+struct ifs_data {
+	int	integrity_cap_bit;
+};
+
+struct ifs_device {
+	struct ifs_data data;
+	struct miscdevice misc;
+};
+
+void ifs_load_firmware(struct device *dev);
+
+#endif
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
new file mode 100644
index 000000000000..9fb71d38c819
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. */
+
+#include <linux/firmware.h>
+
+#include "ifs.h"
+
+/*
+ * Load ifs image. Before loading ifs module, the ifs image must be located
+ * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
+ */
+void ifs_load_firmware(struct device *dev)
+{
+	const struct firmware *fw;
+	char scan_path[32];
+	int ret;
+
+	snprintf(scan_path, sizeof(scan_path), "intel/ifs/%02x-%02x-%02x.scan",
+		 boot_cpu_data.x86, boot_cpu_data.x86_model, boot_cpu_data.x86_stepping);
+
+	ret = request_firmware_direct(&fw, scan_path, dev);
+	if (ret) {
+		dev_err(dev, "ifs file %s load failed\n", scan_path);
+		return;
+	}
+
+	release_firmware(fw);
+}
-- 
2.35.1

