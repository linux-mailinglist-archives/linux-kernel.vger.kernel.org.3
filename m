Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9080151E251
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444863AbiEFW6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444542AbiEFW6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:58:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B606D387;
        Fri,  6 May 2022 15:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651877660; x=1683413660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A3OTv2UkJBxyJkDp92fBqHhvTH56nfQMMMkIYq+yRZw=;
  b=aro3M58sV7sbls/iLGVWBO/SWTaAD1iuyd7GgJfEhbPvlfYldDPaqkHs
   LKipsupJcOG3s1l0wDPRbeIbc2RJ8fshV/shRxIpdIoHwzc6fR2LzVPsE
   /iea6s1J0Gh8Ndbrv3lKd7IVp8rZVcj/DvD/2OocnkZd5ZPubljk3sJmQ
   gLR8jFTeUFD8rqMEgYwALbwXH8lJl6Ywcfi27TBJAKElfa9AfqxxlT6Vj
   3mEO8xl9DRSsvHdvVYQ9zNVBk083Yv1ybXVEiPQK0Tduxy3ogWPeWHCvE
   nTk8BxhWWINH3Usr+TauEUFzZuswgvjsBHifx40tYT5VR9LKtMBYHRn3Z
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="256080792"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="256080792"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 15:54:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="695383627"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 15:54:18 -0700
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
Subject: [PATCH v7 04/12] platform/x86/intel/ifs: Add stub driver for In-Field Scan
Date:   Fri,  6 May 2022 15:54:02 -0700
Message-Id: <20220506225410.1652287-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506225410.1652287-1-tony.luck@intel.com>
References: <20220506014035.1173578-1-tony.luck@intel.com>
 <20220506225410.1652287-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Stub version of driver just does initial part of check for the IFS
feature. MSR_IA32_CORE_CAPS must enumerate the presence of the
MSR_INTEGRITY_CAPS MSR.

[1]: https://www.youtube.com/watch?v=QMF3rqhjYuM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 MAINTAINERS                             |  7 ++++
 drivers/platform/x86/intel/Kconfig      |  1 +
 drivers/platform/x86/intel/Makefile     |  1 +
 drivers/platform/x86/intel/ifs/Kconfig  | 13 +++++++
 drivers/platform/x86/intel/ifs/Makefile |  3 ++
 drivers/platform/x86/intel/ifs/core.c   | 48 +++++++++++++++++++++++++
 6 files changed, 73 insertions(+)
 create mode 100644 drivers/platform/x86/intel/ifs/Kconfig
 create mode 100644 drivers/platform/x86/intel/ifs/Makefile
 create mode 100644 drivers/platform/x86/intel/ifs/core.c

diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cdb85e8..bb0c4ff25942 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9862,6 +9862,13 @@ B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
 F:	drivers/idle/intel_idle.c
 
+INTEL IN FIELD SCAN (IFS) DEVICE
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
index c61bc3e97121..717933dd0cfd 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -5,6 +5,7 @@
 #
 
 obj-$(CONFIG_INTEL_ATOMISP2_PDX86)	+= atomisp2/
+obj-$(CONFIG_INTEL_IFS)			+= ifs/
 obj-$(CONFIG_INTEL_SAR_INT1092)		+= int1092/
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
diff --git a/drivers/platform/x86/intel/ifs/Kconfig b/drivers/platform/x86/intel/ifs/Kconfig
new file mode 100644
index 000000000000..d84491cfb0db
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/Kconfig
@@ -0,0 +1,13 @@
+config INTEL_IFS
+	tristate "Intel In Field Scan"
+	depends on X86 && 64BIT && SMP
+	select INTEL_IFS_DEVICE
+	help
+	  Enable support for the In Field Scan capability in select
+	  CPUs. The capability allows for running low level tests via
+	  a scan image distributed by Intel via Github to validate CPU
+	  operation beyond baseline RAS capabilities. To compile this
+	  support as a module, choose M here. The module will be called
+	  intel_ifs.
+
+	  If unsure, say N.
diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
new file mode 100644
index 000000000000..af904880e959
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_INTEL_IFS)		+= intel_ifs.o
+
+intel_ifs-objs			:= core.o
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
new file mode 100644
index 000000000000..e3623ac691b5
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. */
+
+#include <linux/module.h>
+#include <linux/kdev_t.h>
+
+#include <asm/cpu_device_id.h>
+
+#define X86_MATCH(model)				\
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,	\
+		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, NULL)
+
+static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
+	X86_MATCH(SAPPHIRERAPIDS_X),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
+
+static int __init ifs_init(void)
+{
+	const struct x86_cpu_id *m;
+	u64 msrval;
+
+	m = x86_match_cpu(ifs_cpu_ids);
+	if (!m)
+		return -ENODEV;
+
+	if (rdmsrl_safe(MSR_IA32_CORE_CAPS, &msrval))
+		return -ENODEV;
+
+	if (!(msrval & MSR_IA32_CORE_CAPS_INTEGRITY_CAPS))
+		return -ENODEV;
+
+	if (rdmsrl_safe(MSR_INTEGRITY_CAPS, &msrval))
+		return -ENODEV;
+
+	return 0;
+}
+
+static void __exit ifs_exit(void)
+{
+}
+
+module_init(ifs_init);
+module_exit(ifs_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel In Field Scan (IFS) device");
-- 
2.35.1

