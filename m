Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA07151F3AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 07:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiEIFFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiEIFD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:03:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24AC140C5E
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 21:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652072371; x=1683608371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QowfcDwX1Qu6eNkdT00DPdit0NoLxgLoaz5qS9tATYc=;
  b=JOWZwi+otpbvb+5egXjJjYLWXoFKsFaCk39h3TwGpGRpXrDKzG+/mygo
   z9dZ2L1MB49b5MQCMZ2QWp8rivEyeCJxG6n8FxyX2GstdPUjZZN9TtJa3
   tmzEtU5gWFoDnPiy14P9AEcOEe+LEarrtDTG3KpIXGkcVzBiksWNHDBvA
   AwhXF/zssmfph+/gY8wtgMRDiubWDMm/ANoobuxcO5swfkhcbL+G3mUiV
   Qs0DCpPYdUhr70eWcUyIj61rL0Q/dTMo7ff9iiluoKUhEILfdb1MWdtSq
   IbU+cNjx4jvlPJAcw/MdbicONgAZ4htYAR5my4gc4Z5qtIjf4618bSj92
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="256469142"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="256469142"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 21:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="737989613"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2022 21:58:40 -0700
Date:   Mon, 9 May 2022 12:58:39 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org, rui.zhang@intel.com, len.brown@intel.com,
        tim.c.chen@intel.com
Subject: Re: [PATCH] x86/tsc: Add option to force HW timer based recalibration
Message-ID: <20220509045839.GA40730@shbuild999.sh.intel.com>
References: <20220508144733.91343-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508144733.91343-1-feng.tang@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, just spotted some typos, here is the updated version


From ee8e3d772c623d27d79c43da5a76fb6252175aba Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Sun, 8 May 2022 20:22:12 +0800
Subject: [PATCH] x86/tsc: Add option to force HW timer based recalibration

Currently when HW provides the tsc freq info through MSR or CPUID(0x15),
the info will be taken as the 'best guess', and kernel will set the
X86_FEATURE_TSC_KNOWN_FREQ flag and skip the HW timer based recalibration,
which works pretty well.

And there is still very few corner case that the freq info is not
accurate enough with small deviation from the actual value, like on
a product with early buggy version of firmware or on some
pre-production hardware.

Add an option 'recalibrate' for 'tsc' kernel parameter to force the
tsc freq recalibration with HPET/PM_TIMER, and warn if the deviation
from previous value is more than about 500 PPM.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 arch/x86/kernel/tsc.c                         | 34 ++++++++++++++++---
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..1e06196a591e 100644
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
+			could be wrong, and need a double check through HW timer.
 
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


Thanks,
Feng

On Sun, May 08, 2022 at 10:47:33PM +0800, Feng Tang wrote:
> Currently when HW provides the tsc freq info through MSR or CPUID(0x15),
> the info will be taken as the 'best guess', and kernel will set the
> X86_FEATURE_TSC_KNOWN_FREQ flag and skip the HW timer based recalibration,
> which works pretty well.
> 
> And there is still very few corner case that the freq info is not
> accurate enough will small deviation from the actual value, like on
> a product with early version (fix needed) of firmware or some
> pre-production hardware.
> 
> Add an option 'recalibrate' for 'tsc' kernel parameter to force the
> tsc freq recalibration with HPET/PM_TIMER, and warn if the deviation
> from previous value is more than about 500 PPM.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++
>  arch/x86/kernel/tsc.c                         | 35 ++++++++++++++++---
>  2 files changed, 36 insertions(+), 4 deletions(-)
