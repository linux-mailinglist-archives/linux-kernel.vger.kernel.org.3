Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A553654E519
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377730AbiFPOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiFPOkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:40:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863A845784
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655390412; x=1686926412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6Ru5QawfiihtQC83tInxzrQfzQ8s3TFasls5hcGWHhk=;
  b=HccOol7mhPN5JHLCn7SXfxJ3sYfQOc4co13+e77Ae4srhwHgparvX6bT
   kymKZrMSa09v1Iv4JDZsSg2mcgU/8uUsdue+XBhA5pyvMR2xXL+cqQ/AM
   5mOIyYAmm2tMHD2BSprD6V2IuCDjSxK0XYWc8mnYbFVT5DYrmD1KHm6kl
   RgLU5PLLXqq0216hvS7XNi0hReQ1VJ3l5PKvucqLTtTVFOlDE6gAF1twf
   s1aajwscqf6K5AxhpwL04gfvp6R0KXgWqd4JTF/bzPjr8OjQsDeVDXF51
   hmXnVE5sDbiK37N9Dd1tTqUKT/E6mG2Wtt2y6+eAFEqDmMRYvSHLWqDrF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="340917803"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="340917803"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 07:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="687845577"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2022 07:40:08 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org, rui.zhang@intel.com, len.brown@intel.com,
        tim.c.chen@intel.com, Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3] x86/tsc: Add option to force frequency recalibration with HW timer
Date:   Thu, 16 Jun 2022 22:40:07 +0800
Message-Id: <20220616144007.81994-1-feng.tang@intel.com>
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

  since v2:
    * revise the option description in kernel-parameters.txt
    * rebase against v5.19-rc2

  since v1:
    * refine commit log to state clearly the problem and intention
      of the patch by copying Thomas' words

 .../admin-guide/kernel-parameters.txt         |  4 +++
 arch/x86/kernel/tsc.c                         | 34 ++++++++++++++++---
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8090130b544b..1bb54d562a01 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6135,6 +6135,10 @@
 			in situations with strict latency requirements (where
 			interruptions from clocksource watchdog are not
 			acceptable).
+			[x86] recalibrate: force to do frequency recalibration
+			with a HW timer (HPET or PM timer) for systems whose
+			TSC frequency comes from HW or FW through MSR or CPUID(0x15),
+			and warn if the difference is more than 500 ppm.
 
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

