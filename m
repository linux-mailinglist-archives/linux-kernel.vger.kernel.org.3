Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3225A3E15
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiH1OgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 10:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiH1OgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 10:36:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67A022B35;
        Sun, 28 Aug 2022 07:36:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id az27so7236592wrb.6;
        Sun, 28 Aug 2022 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc;
        bh=K0JOCpEvQd+GZuPmBflCaweEMH+nyxznMYdF4zG5P3U=;
        b=eUZRGySOHSSsdd4gJLRfBPUI/soRSYilzZkAz4N0gygpPyzO+UzA9U5HMqfiK6Z2qD
         DODOFyZCCJ25yG1hylyiRmb+YfyLxugBiJi3gJx70EusQ6an2WQYidnIgKjCE67b4RO5
         kZ3wr5D8jkAN8qC3qBCATmKtElNmFhvf7jefqxKisksNp5873JrMJaDHZyHaZfeNuZBE
         8K47f93Jt6UfATKMLVKnr4PrBNhdpRjciWlzIavgt+TfVbEinWWsCMbYsMX+5fv5Ua7i
         yRLQZbJZmjl7bS5n2065Kbwy1h0P5stc7ai068oj49L3HXQxbhftoSnKeFvAHD/VmMkt
         abhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc;
        bh=K0JOCpEvQd+GZuPmBflCaweEMH+nyxznMYdF4zG5P3U=;
        b=5PCVZTKNFHoq+vWcDAn0dos/E8cFYqb6W/UtG6Ic/NxUZkHml+Z6vbN6MuvSjRvcoC
         fOWXa6TRBr05PZeGMStwCHWuJ81cV0Qr9GYPal/74pAGunEqFBrXRSRprl7lVIrZirLX
         ARxG8mY/BpeHyANaMEIwWyNBqGaWF1ftuhr40cnqdjslKqyRP41mnkSDfM55h37rGsmj
         nAt5jERaL9optskG3coxBsW2eAxL6xVYTr8MhR6Q3YiZ5WLBrWQXXglK/WnTY5PDdPau
         tPpe+faQJQF1LC8s/i8obutNLYcWXA8pjMkMDx1tybCVLr/Wqdh9hkq/sbAp1hlqrxWe
         QlPQ==
X-Gm-Message-State: ACgBeo24NJr3deRepjLQnA9syDw5cQWGuZp9LjS2WTZPViC7UMoce5hv
        7p5GojH0Ext10lNE4mBN7NE=
X-Google-Smtp-Source: AA6agR4VEKm2/r9fcwsUdsrZ41itEOT6DaSEzS9tdNEZ1A5h76XvMR9lOKdgG2aTFfR9XEgI6qRkcw==
X-Received: by 2002:a5d:64eb:0:b0:225:74d5:7b07 with SMTP id g11-20020a5d64eb000000b0022574d57b07mr4532248wri.616.1661697364372;
        Sun, 28 Aug 2022 07:36:04 -0700 (PDT)
Received: from gmail.com ([31.46.246.46])
        by smtp.gmail.com with ESMTPSA id e18-20020adff352000000b002252d897876sm4626990wrp.32.2022.08.28.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 07:36:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 28 Aug 2022 16:35:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <Ywt9TYx6rWC5RHaV@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-08-28

   # HEAD: 11745ecfe8fea4b4a4c322967a7605d2ecbd5080 perf/x86/intel/uncore: Fix broken read_counter() for SNB IMC PMU

Misc fixes: an Arch-LBR fix, a PEBS enumeration fix, an Intel DS fix,
PEBS constraints fix on Alder Lake CPUs and an Intel uncore PMU fix.

 Thanks,

	Ingo

------------------>
Kan Liang (2):
      perf/x86/lbr: Enable the branch type for the Arch LBR by default
      perf/x86/intel: Fix pebs event constraints for ADL

Peter Zijlstra (1):
      perf/x86/core: Set pebs_capable and PMU_FL_PEBS_ALL for the Baseline

Stephane Eranian (2):
      perf/x86/intel/ds: Fix precise store latency handling
      perf/x86/intel/uncore: Fix broken read_counter() for SNB IMC PMU


 arch/x86/events/intel/core.c       |  4 ----
 arch/x86/events/intel/ds.c         | 13 +++++++++++--
 arch/x86/events/intel/lbr.c        |  8 ++++++++
 arch/x86/events/intel/uncore_snb.c | 18 +++++++++++++++++-
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2db93498ff71..cb98a05ee743 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6291,10 +6291,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_aliases = NULL;
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.pebs_block = true;
-		x86_pmu.pebs_capable = ~0ULL;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
-		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 
@@ -6337,10 +6335,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_aliases = NULL;
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.pebs_block = true;
-		x86_pmu.pebs_capable = ~0ULL;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
-		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.lbr_pt_coexist = true;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba60427caa6d..de1f55d51784 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -291,6 +291,7 @@ static u64 load_latency_data(struct perf_event *event, u64 status)
 static u64 store_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
+	union perf_mem_data_src src;
 	u64 val;
 
 	dse.val = status;
@@ -304,7 +305,14 @@ static u64 store_latency_data(struct perf_event *event, u64 status)
 
 	val |= P(BLK, NA);
 
-	return val;
+	/*
+	 * the pebs_data_source table is only for loads
+	 * so override the mem_op to say STORE instead
+	 */
+	src.val = val;
+	src.mem_op = P(OP,STORE);
+
+	return src.val;
 }
 
 struct pebs_record_core {
@@ -822,7 +830,7 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 
 struct event_constraint intel_grt_pebs_event_constraints[] = {
 	/* Allow all events as PEBS with no flags */
-	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0xf),
+	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0x3),
 	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xf),
 	EVENT_CONSTRAINT_END
 };
@@ -2262,6 +2270,7 @@ void __init intel_ds_init(void)
 					PERF_SAMPLE_BRANCH_STACK |
 					PERF_SAMPLE_TIME;
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
+				x86_pmu.pebs_capable = ~0ULL;
 				pebs_qual = "-baseline";
 				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 4f70fb6c2c1e..47fca6a7a8bc 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1097,6 +1097,14 @@ static int intel_pmu_setup_hw_lbr_filter(struct perf_event *event)
 
 	if (static_cpu_has(X86_FEATURE_ARCH_LBR)) {
 		reg->config = mask;
+
+		/*
+		 * The Arch LBR HW can retrieve the common branch types
+		 * from the LBR_INFO. It doesn't require the high overhead
+		 * SW disassemble.
+		 * Enable the branch type by default for the Arch LBR.
+		 */
+		reg->reg |= X86_BR_TYPE_SAVE;
 		return 0;
 	}
 
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index ce440011cc4e..1ef4f7861e2e 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -841,6 +841,22 @@ int snb_pci2phy_map_init(int devid)
 	return 0;
 }
 
+static u64 snb_uncore_imc_read_counter(struct intel_uncore_box *box, struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	/*
+	 * SNB IMC counters are 32-bit and are laid out back to back
+	 * in MMIO space. Therefore we must use a 32-bit accessor function
+	 * using readq() from uncore_mmio_read_counter() causes problems
+	 * because it is reading 64-bit at a time. This is okay for the
+	 * uncore_perf_event_update() function because it drops the upper
+	 * 32-bits but not okay for plain uncore_read_counter() as invoked
+	 * in uncore_pmu_event_start().
+	 */
+	return (u64)readl(box->io_addr + hwc->event_base);
+}
+
 static struct pmu snb_uncore_imc_pmu = {
 	.task_ctx_nr	= perf_invalid_context,
 	.event_init	= snb_uncore_imc_event_init,
@@ -860,7 +876,7 @@ static struct intel_uncore_ops snb_uncore_imc_ops = {
 	.disable_event	= snb_uncore_imc_disable_event,
 	.enable_event	= snb_uncore_imc_enable_event,
 	.hw_config	= snb_uncore_imc_hw_config,
-	.read_counter	= uncore_mmio_read_counter,
+	.read_counter	= snb_uncore_imc_read_counter,
 };
 
 static struct intel_uncore_type snb_uncore_imc = {
