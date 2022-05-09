Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42CD52001E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbiEIOpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbiEIOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:45:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86826100C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652107274; x=1683643274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IoNYgQ9+2TWr1CG3IwWU1odmmZECThRNzB9JDQNsjZ0=;
  b=D5opDfzBvTbyiDS5PBI5GQAB1dngXcFj2e42HmSCl+Ki1TqIwv0CCDrv
   i+uS53yTpnQUBirGqloRrgKfeKli0SbeEBEztftcDnhdcS1GSQQp/7xzZ
   YizaLH+Roh+yF6iwF4ud8NM3LO43rKMY+/CkUCYAW/sx/PmF7KnOcTYqU
   4zPVtGlRnxVnwdPKjnLgKm1H7mKVZkBso2prk1WHiWOQ0XJU0EymyWTAC
   V/tYiFCuXftgVMJUDMjs64bHcS50oJrV1OQK4jTtD8FbykUliPn+yhvIl
   au4B51fCu5TCyc8N35nK65QaxFpYzOJ90JHdjQP9cOPdkSSP+ObO+6YwP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249606053"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="249606053"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 07:41:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="565100229"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by orsmga007.jf.intel.com with ESMTP; 09 May 2022 07:41:10 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org, rui.zhang@intel.com, len.brown@intel.com,
        tim.c.chen@intel.com, Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2] x86/tsc: Add option to force frequency recalibration with HW timer
Date:   Mon,  9 May 2022 22:41:10 +0800
Message-Id: <20220509144110.9242-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel assumes that the TSC frequency which is provided by the
hardware / firmware via MSRs or CPUID(0x15) is correct after applying
a few basic consistency checks. This disables the TSC recalibration
against HPET or PM timer.

As a result there is no mechanism to validate that frequency in cases
where a firmware or hardware defect is suspected.

Add an option 'recalibrate' for 'tsc' kernel parameter to force the
tsc freq recalibration with HPET or PM timer, and warn if the deviation
from previous value is more than about 500 PPM. There is no functional
change to existing work flow.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:

  since v1:
    * refine commit log to state clearly the problem and intention
      of the patch with Thomas' words

 .../admin-guide/kernel-parameters.txt         |  4 +++
 arch/x86/kernel/tsc.c                         | 34 ++++++++++++++++---
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..35f35e287346 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5981,6 +5981,10 @@
 			in situations with strict latency requirements (where
 			interruptions from clocksource watchdog are not
 			acceptable).
+			[x86] recalibrate: force to do frequency recalibration
+			with a HW timer (HPET or PM timer), which provides a way
+			to validate the frequency info provided by HW or FW
+			through MSR or CPUID(0x15).
 
 	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
 			value instead. Useful when the early TSC frequency discovery
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..5cf62a58754a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -48,6 +48,8 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);
 
 int tsc_clocksource_reliable;
 
+static int __read_mostly tsc_force_recalibrate;
+
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
@@ -303,6 +305,8 @@ static int __init tsc_setup(char *str)
 		mark_tsc_unstable("boot parameter");
 	if (!strcmp(str, "nowatchdog"))
 		no_tsc_watchdog = 1;
+	if (!strcmp(str, "recalibrate"))
+		tsc_force_recalibrate = 1;
 	return 1;
 }
 
@@ -1374,6 +1378,25 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	else
 		freq = calc_pmtimer_ref(delta, ref_start, ref_stop);
 
+	/* Will hit this only if tsc_force_recalibrate has been set */
+	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
+
+		/* Warn if the deviation exceeds 500 ppm */
+		if (abs(tsc_khz - freq) > (tsc_khz >> 11)) {
+			pr_warn("Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!\n");
+			pr_info("Previous calibrated TSC freq:\t %lu.%03lu MHz\n",
+				(unsigned long)tsc_khz / 1000,
+				(unsigned long)tsc_khz % 1000);
+		}
+
+		pr_info("TSC freq recalibrated by [%s]:\t %lu.%03lu MHz\n",
+			hpet ? "HPET" : "PM_TIMER",
+			(unsigned long)freq / 1000,
+			(unsigned long)freq % 1000);
+
+		return;
+	}
+
 	/* Make sure we're within 1% */
 	if (abs(tsc_khz - freq) > tsc_khz/100)
 		goto out;
@@ -1407,8 +1430,10 @@ static int __init init_tsc_clocksource(void)
 	if (!boot_cpu_has(X86_FEATURE_TSC) || !tsc_khz)
 		return 0;
 
-	if (tsc_unstable)
-		goto unreg;
+	if (tsc_unstable) {
+		clocksource_unregister(&clocksource_tsc_early);
+		return 0;
+	}
 
 	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
 		clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
@@ -1421,9 +1446,10 @@ static int __init init_tsc_clocksource(void)
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
-unreg:
 		clocksource_unregister(&clocksource_tsc_early);
-		return 0;
+
+		if (!tsc_force_recalibrate)
+			return 0;
 	}
 
 	schedule_delayed_work(&tsc_irqwork, 0);
-- 
2.27.0

