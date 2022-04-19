Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED4D50735A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354831AbiDSQmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354753AbiDSQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B236515A38;
        Tue, 19 Apr 2022 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650386348; x=1681922348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3+cnaOKNg1DXMe24Z7ON6hVz8Ha5Eswt2xisuNXIrDk=;
  b=X/jNg+DZmornmyHkvqQxVjEat9iq2/2iiC+9bV+dViTT0as6NAXZ4W6w
   RoKviYv/g4EM+0mqH/Gu9yh+rkdKhbjFdiQ8KkCVF6Dp/3jPqoYMipmeN
   W9oOm/z5wGXNzeNqdJl3vODGl3383JgJO305nb3lOQsxsZsOhtCG2UEqZ
   MiMDVEgSIpnFxgjoodewEzuE8u9KMfpFAZHILp6019rI6bb8hpuCUBWab
   GYZtPEPzdYqwFGgxsKcwyR6k5P6WeCIg7KVQzBsnQ3/C8ffzK4pF6Jq7L
   z1Wl8+ehmXp5fyAUbDVzcJDz3U66AV2BFMRq7H8b/55Q0zs/YOTQFu0yf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245702526"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245702526"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554802136"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:06 -0700
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
Subject: [PATCH v3 03/11] platform/x86/intel/ifs: Create device for Intel IFS (In Field Scan)
Date:   Tue, 19 Apr 2022 09:38:51 -0700
Message-Id: <20220419163859.2228874-4-tony.luck@intel.com>
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

The initial implementation of IFS is model specific. Enumeration is
via a combination of family-model-stepping and a check for a bit in the
CORE_CAPABILITIES MSR.

Linux has handled this lack of enumeration before with a code stub to
create a device.  See arch/x86/kernel/pmem.c. Use the same approach
here.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 MAINTAINERS                                   |  7 +++
 drivers/platform/x86/intel/Kconfig            |  1 +
 drivers/platform/x86/intel/Makefile           |  1 +
 drivers/platform/x86/intel/ifs/Kconfig        |  2 +
 drivers/platform/x86/intel/ifs/Makefile       |  1 +
 .../platform/x86/intel/ifs/intel_ifs_device.c | 50 +++++++++++++++++++
 6 files changed, 62 insertions(+)
 create mode 100644 drivers/platform/x86/intel/ifs/Kconfig
 create mode 100644 drivers/platform/x86/intel/ifs/Makefile
 create mode 100644 drivers/platform/x86/intel/ifs/intel_ifs_device.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 40fa1955ca3f..9e372a960fa5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9861,6 +9861,13 @@ B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
 F:	drivers/idle/intel_idle.c
 
+INTEL IN FIELD SCAN (IFS) DRIVER
+M:	Jithu Joseph <jithu.joseph@intel.com>
+R:	Ashok Raj <ashok.raj@intel.com>
+R:	Tony Luck <tony.luck@intel.com>
+S:	Maintained
+F:	drivers/platform/x86/intel/ifs
+
 INTEL INTEGRATED SENSOR HUB DRIVER
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 M:	Jiri Kosina <jikos@kernel.org>
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 1f01a8a23c57..794968bda115 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -4,6 +4,7 @@
 #
 
 source "drivers/platform/x86/intel/atomisp2/Kconfig"
+source "drivers/platform/x86/intel/ifs/Kconfig"
 source "drivers/platform/x86/intel/int1092/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
 source "drivers/platform/x86/intel/pmc/Kconfig"
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index c61bc3e97121..10285d0fd16a 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -5,6 +5,7 @@
 #
 
 obj-$(CONFIG_INTEL_ATOMISP2_PDX86)	+= atomisp2/
+obj-y					+= ifs/
 obj-$(CONFIG_INTEL_SAR_INT1092)		+= int1092/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
diff --git a/drivers/platform/x86/intel/ifs/Kconfig b/drivers/platform/x86/intel/ifs/Kconfig
new file mode 100644
index 000000000000..51325b699563
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/Kconfig
@@ -0,0 +1,2 @@
+config INTEL_IFS_DEVICE
+	bool
diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
new file mode 100644
index 000000000000..12c2f5ce9925
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_INTEL_IFS_DEVICE)	+= intel_ifs_device.o
diff --git a/drivers/platform/x86/intel/ifs/intel_ifs_device.c b/drivers/platform/x86/intel/ifs/intel_ifs_device.c
new file mode 100644
index 000000000000..64a143871d72
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/intel_ifs_device.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 Intel Corporation. */
+
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <asm/cpu_device_id.h>
+
+#define MSR_IA32_CORE_CAPS_INTEGRITY_BIT	2
+#define MSR_IA32_CORE_CAPS_INTEGRITY		BIT(MSR_IA32_CORE_CAPS_INTEGRITY_BIT)
+
+#define X86_MATCH(model)					\
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
+		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, NULL)
+
+static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
+	X86_MATCH(SAPPHIRERAPIDS_X),
+	{}
+};
+
+static __init int register_ifs_device(void)
+{
+	struct platform_device *pdev;
+	const struct x86_cpu_id *m;
+	u64 ia32_core_caps;
+
+	m = x86_match_cpu(ifs_cpu_ids);
+	if (!m)
+		return -ENODEV;
+
+	if (rdmsrl_safe(MSR_IA32_CORE_CAPS, &ia32_core_caps))
+		return -ENODEV;
+
+	if (ia32_core_caps & MSR_IA32_CORE_CAPS_INTEGRITY) {
+		pdev = platform_device_alloc("intel_ifs", 0);
+		if (pdev) {
+			if (platform_device_add(pdev))
+				platform_device_put(pdev);
+		}
+	}
+
+	/*
+	 * Failure here will be visible by a missing device
+	 * in sysfs. Returning an error code would not make
+	 * that any easier to diagnose. Would also complicate
+	 * future implementations that may support a subset of
+	 * the types of tests.
+	 */
+	return 0;
+}
+device_initcall(register_ifs_device);
-- 
2.35.1

