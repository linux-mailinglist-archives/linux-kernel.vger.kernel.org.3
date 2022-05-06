Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51E751CD49
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387113AbiEFAEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387211AbiEFAC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:02:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDB261615
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795079; x=1683331079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kUyeigYz7qVM6Mrp46t6dkjR9tV464c8drNXHNVDlvU=;
  b=DCgVPK2dKe7XRceCqzmpXAADDOxku5ZKqAR9XeVj+PJBoODchlftagWN
   k6IXNCfNHYhUl2SmQr3Sa2M49g/zE814K9ZPV61C1mBmPGAma1L2jB4iN
   5dnXKkLzabw5UND8US933BwsYAwe87l+/solNvH565QOvbAcvNmlnc061
   +QPBkwTDA38LnLcGgRPjO+VSnHVuRaXhT41mu5wpMJFy4bcV64t3ckKQE
   Dvz5eCpytQgPLeFd66Kx7KHlglpCC+xTO6B5TXjZFunrJ/kDx04WwZR1M
   mbC/AwujxOj//mK+loQM+trmTUncaMGVvRl1Hz7cGgjgeNl7W2XgTEjsF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283660"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283660"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914442"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:55 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v6 25/29] watchdog/hardlockup/hpet: Only enable the HPET watchdog via a boot parameter
Date:   Thu,  5 May 2022 17:00:04 -0700
Message-Id: <20220506000008.30892-26-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the HPET-based hardlockup detector disabled unless explicitly enabled
via a command-line argument. If such parameter is not given, the
initialization of the HPET-based hardlockup detector fails and the NMI
watchdog will fall back to use the perf-based implementation.

Implement the command-line parsing using an early_param, as
__setup("nmi_watchdog=") only parses generic options.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
--
Changes since v5:
 * None

Changes since v4:
 * None

Changes since v3:
 * None

Changes since v2:
 * Do not imply that using nmi_watchdog=hpet means the detector is
   enabled. Instead, print a warning in such case.

Changes since v1:
 * Added documentation to the function handing the nmi_watchdog
   kernel command-line argument.
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++++-
 arch/x86/kernel/watchdog_hld_hpet.c           | 22 +++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 269be339d738..89eae950fdb8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3370,7 +3370,7 @@
 			Format: [state][,regs][,debounce][,die]
 
 	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
-			Format: [panic,][nopanic,][num]
+			Format: [panic,][nopanic,][num,][hpet]
 			Valid num: 0 or 1
 			0 - turn hardlockup detector in nmi_watchdog off
 			1 - turn hardlockup detector in nmi_watchdog on
@@ -3381,6 +3381,12 @@
 			please see 'nowatchdog'.
 			This is useful when you use a panic=... timeout and
 			need the box quickly up again.
+			When hpet is specified, the NMI watchdog will be driven
+			by an HPET timer, if available in the system. Otherwise,
+			it falls back to the default implementation (perf or
+			architecture-specific). Specifying hpet has no effect
+			if the NMI watchdog is not enabled (either at build time
+			or via the command line).
 
 			These settings can be accessed at runtime via
 			the nmi_watchdog and hardlockup_panic sysctls.
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index 3effdbf29095..4413d5fb94f4 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -379,6 +379,28 @@ void hardlockup_detector_hpet_start(void)
 	enable_timer(hld_data);
 }
 
+/**
+ * hardlockup_detector_hpet_setup() - Parse command-line parameters
+ * @str:	A string containing the kernel command line
+ *
+ * Parse the nmi_watchdog parameter from the kernel command line. If
+ * selected by the user, use this implementation to detect hardlockups.
+ */
+static int __init hardlockup_detector_hpet_setup(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (parse_option_str(str, "hpet"))
+		hardlockup_use_hpet = true;
+
+	if (!nmi_watchdog_user_enabled && hardlockup_use_hpet)
+		pr_err("Selecting HPET NMI watchdog has no effect with NMI watchdog disabled\n");
+
+	return 0;
+}
+early_param("nmi_watchdog", hardlockup_detector_hpet_setup);
+
 /**
  * hardlockup_detector_hpet_init() - Initialize the hardlockup detector
  *
-- 
2.17.1

