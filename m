Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154064F87D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbiDGTQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiDGTQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:16:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDA923EC7A;
        Thu,  7 Apr 2022 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649358864; x=1680894864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Y4gJAbytw/F2rabC0TV0qHXjA19vEQTh9ZYHXlLb3LE=;
  b=WIdSmwuSMHAoYsnVQMfpLtMpCarz/v8f+T7/uWXluPL5rhbiSc5B0JnN
   maIfQfAY72wgsTkuH6l7m1IwLDapyGUtc5p49KMfzitE0aM+F+Wst00ZT
   Xsh4POpKgmr+zBC8shvD67vFtQuInhaYEoMOMmkCJ9PV+PW/dVmk6jya/
   aOQ4OsQGuGVfL4NcmnO5hHsbII+TnUKlTMdQabB7KGBHty7A1/P3mRUgK
   mb9fp7Vwy2IhmIEnGLyJtrd1EsZwFhm9YpZkcySyqvNvOutT2hpUgJWeu
   0BzG5/esuX/IolmS59UO0hWMdPoZj26APHj7/zay4EQraOPYpsHIFnoIH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260255378"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="260255378"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571193709"
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
Subject: [PATCH v2 03/10] platform/x86/intel/ifs: Add driver for In-Field Scan
Date:   Thu,  7 Apr 2022 12:13:40 -0700
Message-Id: <20220407191347.9681-4-jithu.joseph@intel.com>
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

Cloud Service Providers that operate fleets of servers have reported
[1] occasions where they can detect that a CPU has gone bad due to
effects like electromigration, or isolated manufacturing defects.
However, that detection method is A/B testing seemingly random
application failures looking for a pattern. In-Field Scan (IFS) is
a driver for a platform capability to load a crafted 'scan image'
to run targeted low level diagnostics outside of the CPU's architectural
error detection capabilities.

[1]: https://www.youtube.com/watch?v=QMF3rqhjYuM

IFS will be available in some server SKUs starting with Sapphire Rapids.

Add basic parts of the IFS module (initialization and check IFS capability
support in a processor).

MSR IA32_CORE_CAPABILITY is a feature-enumerating MSR, bit 2 of which
reports MSR_INTEGRITY_CAPABILITIES. Processor that supports IFS
should reports the MSR_INTEGRITY_CAPABILITIES enabled.

Please check the latest Intel 64 and IA-32 Architectures Software
Developer's Manual for more detailed information on the MSR and the
MSR_INTEGRITY_CAPABILITIES.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 MAINTAINERS                             |  7 ++++
 drivers/platform/x86/intel/Kconfig      |  1 +
 drivers/platform/x86/intel/Makefile     |  1 +
 drivers/platform/x86/intel/ifs/Kconfig  |  9 +++++
 drivers/platform/x86/intel/ifs/Makefile |  3 ++
 drivers/platform/x86/intel/ifs/core.c   | 44 +++++++++++++++++++++++++
 drivers/platform/x86/intel/ifs/ifs.h    | 11 +++++++
 7 files changed, 76 insertions(+)
 create mode 100644 drivers/platform/x86/intel/ifs/Kconfig
 create mode 100644 drivers/platform/x86/intel/ifs/Makefile
 create mode 100644 drivers/platform/x86/intel/ifs/core.c
 create mode 100644 drivers/platform/x86/intel/ifs/ifs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 777cd6fa2b3d..4c9912c0d725 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9685,6 +9685,13 @@ B:	https://bugzilla.kernel.org
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
index 8e65086bb6c8..7339e7daf0a1 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -4,6 +4,7 @@
 #
 
 source "drivers/platform/x86/intel/atomisp2/Kconfig"
+source "drivers/platform/x86/intel/ifs/Kconfig"
 source "drivers/platform/x86/intel/int1092/Kconfig"
 source "drivers/platform/x86/intel/int33fe/Kconfig"
 source "drivers/platform/x86/intel/int3472/Kconfig"
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 35f2066578b2..bd7f2ef5e767 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -5,6 +5,7 @@
 #
 
 obj-$(CONFIG_INTEL_ATOMISP2_PDX86)	+= atomisp2/
+obj-$(CONFIG_INTEL_IFS)			+= ifs/
 obj-$(CONFIG_INTEL_SAR_INT1092)		+= int1092/
 obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
diff --git a/drivers/platform/x86/intel/ifs/Kconfig b/drivers/platform/x86/intel/ifs/Kconfig
new file mode 100644
index 000000000000..88e3d4fa1759
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/Kconfig
@@ -0,0 +1,9 @@
+config INTEL_IFS
+	tristate "Intel In Field Scan"
+	depends on X86 && 64BIT && SMP
+	help
+	  Enable support for In Field Scan in Intel CPU to perform core
+	  logic test in the field. To compile this driver as a module, choose
+	  M here. The module will be called intel_ifs.
+
+	  If unsure, say N.
diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
new file mode 100644
index 000000000000..c44305dff542
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_INTEL_IFS)			+= intel_ifs.o
+
+intel_ifs-objs				:= core.o
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
new file mode 100644
index 000000000000..87956623208f
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. */
+
+#include <linux/module.h>
+#include <asm/cpu_device_id.h>
+
+#include "ifs.h"
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
+MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
+
+static int __init ifs_init(void)
+{
+	const struct x86_cpu_id *m;
+	u64 ia32_core_caps;
+
+	/* ifs capability check */
+	m = x86_match_cpu(ifs_cpu_ids);
+	if (!m)
+		return -ENODEV;
+	if (rdmsrl_safe(MSR_IA32_CORE_CAPS, &ia32_core_caps))
+		return -ENODEV;
+	if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_INTEGRITY))
+		return -ENODEV;
+
+	return 0;
+}
+
+static void __exit ifs_exit(void)
+{
+}
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel In Field Scan (IFS) driver");
+module_init(ifs_init);
+module_exit(ifs_exit);
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
new file mode 100644
index 000000000000..bb25a4cd3af6
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2022 Intel Corporation. */
+
+#ifndef _IFS_H_
+#define _IFS_H_
+
+/* These bits are in the IA32_CORE_CAPABILITIES MSR */
+#define MSR_IA32_CORE_CAPS_INTEGRITY_BIT	2
+#define MSR_IA32_CORE_CAPS_INTEGRITY		BIT(MSR_IA32_CORE_CAPS_INTEGRITY_BIT)
+
+#endif
-- 
2.17.1

