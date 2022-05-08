Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2529851EE54
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 16:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiEHOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiEHOv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 10:51:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E6D3892
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652021257; x=1683557257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IkB3YEGaIW6CZc5VB7ZoE/b6r44WTNaOr46lfe86DL0=;
  b=LR8a7YUbNXAtFCb3aDyrqm8YHWEBBKOcAd7aAtG9Pk8lXc/fpN1dpDyt
   x881Br88J5zPwcD9RLGevtIkMj2vLGEvc0Z9sx6xULfPGs/wJ3Co4gvSx
   95AtRjUqt9QZycXry2pdZXAHZ02J3uShz9j4QJBzQoOmG5k21TXGDnQpX
   0c3QSZxI+aXvi/Ub8taT0doBtOHXet8DYNjgcxw1Vz0sySgA9z10aNrCd
   AjP3emrgLfe9Y7Mbpg8t0j3WnM89oklidi3q1dAsU4jg3LPTnO/kdxmBo
   z8pZO58PPnumKVXCLwwy1CWoA6U+ws1cZDusbTD5EArBRb/oz4s9bP+OH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="268986340"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="268986340"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 07:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="590730397"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by orsmga008.jf.intel.com with ESMTP; 08 May 2022 07:47:34 -0700
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
Subject: [PATCH] x86/tsc: Add option to force HW timer based recalibration
Date:   Sun,  8 May 2022 22:47:33 +0800
Message-Id: <20220508144733.91343-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when HW provides the tsc freq info through MSR or CPUID(0x15),
the info will be taken as the 'best guess', and kernel will set the
X86_FEATURE_TSC_KNOWN_FREQ flag and skip the HW timer based recalibration,
which works pretty well.

And there is still very few corner case that the freq info is not
accurate enough will small deviation from the actual value, like on
a product with early version (fix needed) of firmware or some
pre-production hardware.

Add an option 'recalibrate' for 'tsc' kernel parameter to force the
tsc freq recalibration with HPET/PM_TIMER, and warn if the deviation
from previous value is more than about 500 PPM.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 arch/x86/kernel/tsc.c                         | 35 ++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..a5880f25e1bb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5981,6 +5981,11 @@
 			in situations with strict latency requirements (where
 			interruptions from clocksource watchdog are not
 			acceptable).
+			[x86] recalibrate: force to do freq recalibration with
+			a HW timer (HPET or PM_TIMER). When HW provides tsc freq
+			info through MSR or CPUID(0x15), kernel will take it as
+			the 'best guess', but there is corner case that the info
+			could be wrong, and need a double chck through HW timer.
 
 	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
 			value instead. Useful when the early TSC frequency discovery
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..186a793fdf3a 100644
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
@@ -1383,6 +1406,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 		(unsigned long)tsc_khz / 1000,
 		(unsigned long)tsc_khz % 1000);
 
+
 	/* Inform the TSC deadline clockevent devices about the recalibration */
 	lapic_update_tsc_freq();
 
@@ -1407,8 +1431,10 @@ static int __init init_tsc_clocksource(void)
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
@@ -1421,9 +1447,10 @@ static int __init init_tsc_clocksource(void)
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

