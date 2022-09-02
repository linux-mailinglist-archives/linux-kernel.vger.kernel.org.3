Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842825AAE22
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiIBMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiIBMJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:09:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC6BFDE;
        Fri,  2 Sep 2022 05:09:49 -0700 (PDT)
Date:   Fri, 02 Sep 2022 12:09:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662120588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02MAJ9GGXgA4rfYS26irJ9R97DAuMRaA2eJ/zOjxpDE=;
        b=u66o6p3/srIl9b7NgibhhwxPptqI+yVX7oAJvQrJ3RQ5plTERI3ydcvWL1wvoTZi7FQPQ3
        SAYZh75rODkxSbS/5D8wbSXLD+V3uBWX2MJEVMlqYSG2xfteoxpmLdM2FpztTNyPwi36kx
        DA90o9tJdHGMKMSzguWf+dA1NHUEjiUXW+UM2p7/bzvT0vGD4kSxa9fVo2UibSx7TgpI/H
        Qgq/5ItKymFhh7YA2XSf6OFBIneo0iMEvgrKe/QR7ZsVgCyWLmdL5pc43N9Hx/DO8w9tEd
        dDAcDy5ANcrm5FqIggPvQ0dOlxZiRcrHk78EX0jJjDOo911P1/sovqXU07gryg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662120588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02MAJ9GGXgA4rfYS26irJ9R97DAuMRaA2eJ/zOjxpDE=;
        b=yHwM/I4Q/Lkyf6PLYZbHP9/n0DccDBLCIgnH5qIbXDe0Wy6tP/nz48u0zDx3i37QKvlEkc
        p4eKnBYThsRT7TDw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix unchecked MSR access error for
 Alder Lake N
Cc:     Jianfeng Gao <jianfeng.gao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220831142702.153110-1-kan.liang@linux.intel.com>
References: <20220831142702.153110-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166212058680.401.6710443216035389202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     24919fdea6f8b31d7cdf32ac291bc5dd0b023878
Gitweb:        https://git.kernel.org/tip/24919fdea6f8b31d7cdf32ac291bc5dd0b023878
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 31 Aug 2022 07:27:02 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 01 Sep 2022 11:19:41 +02:00

perf/x86/intel: Fix unchecked MSR access error for Alder Lake N

For some Alder Lake N machine, the below unchecked MSR access error may be
triggered.

[ 0.088017] rcu: Hierarchical SRCU implementation.
[ 0.088017] unchecked MSR access error: WRMSR to 0x38f (tried to write
0x0001000f0000003f) at rIP: 0xffffffffb5684de8 (native_write_msr+0x8/0x30)
[ 0.088017] Call Trace:
[ 0.088017] <TASK>
[ 0.088017] __intel_pmu_enable_all.constprop.46+0x4a/0xa0

The Alder Lake N only has e-cores. The X86_FEATURE_HYBRID_CPU flag is
not set. The perf cannot retrieve the correct CPU type via
get_this_hybrid_cpu_type(). The model specific get_hybrid_cpu_type() is
hardcode to p-core. The wrong CPU type is given to the PMU of the
Alder Lake N.

Since Alder Lake N isn't in fact a hybrid CPU, remove ALDERLAKE_N from
the rest of {ALDER,RAPTOP}LAKE and create a non-hybrid PMU setup.

The differences between Gracemont and the previous Tremont are,
- Number of GP counters
- Load and store latency Events
- PEBS event_constraints
- Instruction Latency support
- Data source encoding
- Memory access latency encoding

Fixes: c2a960f7c574 ("perf/x86: Add new Alder Lake and Raptor Lake support")
Reported-by: Jianfeng Gao <jianfeng.gao@intel.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220831142702.153110-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 40 ++++++++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c   |  9 ++++++--
 arch/x86/events/perf_event.h |  2 ++-
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cb98a05..e8eb936 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2102,6 +2102,15 @@ static struct extra_reg intel_tnt_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+EVENT_ATTR_STR(mem-loads,	mem_ld_grt,	"event=0xd0,umask=0x5,ldlat=3");
+EVENT_ATTR_STR(mem-stores,	mem_st_grt,	"event=0xd0,umask=0x6");
+
+static struct attribute *grt_mem_attrs[] = {
+	EVENT_PTR(mem_ld_grt),
+	EVENT_PTR(mem_st_grt),
+	NULL
+};
+
 static struct extra_reg intel_grt_extra_regs[] __read_mostly = {
 	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
 	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffffffffull, RSP_0),
@@ -5974,6 +5983,36 @@ __init int intel_pmu_init(void)
 		name = "Tremont";
 		break;
 
+	case INTEL_FAM6_ALDERLAKE_N:
+		x86_pmu.mid_ack = true;
+		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
+		       sizeof(hw_cache_event_ids));
+		memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
+		       sizeof(hw_cache_extra_regs));
+		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
+
+		x86_pmu.event_constraints = intel_slm_event_constraints;
+		x86_pmu.pebs_constraints = intel_grt_pebs_event_constraints;
+		x86_pmu.extra_regs = intel_grt_extra_regs;
+
+		x86_pmu.pebs_aliases = NULL;
+		x86_pmu.pebs_prec_dist = true;
+		x86_pmu.pebs_block = true;
+		x86_pmu.lbr_pt_coexist = true;
+		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
+
+		intel_pmu_pebs_data_source_grt();
+		x86_pmu.pebs_latency_data = adl_latency_data_small;
+		x86_pmu.get_event_constraints = tnt_get_event_constraints;
+		x86_pmu.limit_period = spr_limit_period;
+		td_attr = tnt_events_attrs;
+		mem_attr = grt_mem_attrs;
+		extra_attr = nhm_format_attr;
+		pr_cont("Gracemont events, ");
+		name = "gracemont";
+		break;
+
 	case INTEL_FAM6_WESTMERE:
 	case INTEL_FAM6_WESTMERE_EP:
 	case INTEL_FAM6_WESTMERE_EX:
@@ -6316,7 +6355,6 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 		/*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index de1f55d..ac973c6 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -110,13 +110,18 @@ void __init intel_pmu_pebs_data_source_skl(bool pmem)
 	__intel_pmu_pebs_data_source_skl(pmem, pebs_data_source);
 }
 
-static void __init intel_pmu_pebs_data_source_grt(u64 *data_source)
+static void __init __intel_pmu_pebs_data_source_grt(u64 *data_source)
 {
 	data_source[0x05] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOP, HIT);
 	data_source[0x06] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOP, HITM);
 	data_source[0x08] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOPX, FWD);
 }
 
+void __init intel_pmu_pebs_data_source_grt(void)
+{
+	__intel_pmu_pebs_data_source_grt(pebs_data_source);
+}
+
 void __init intel_pmu_pebs_data_source_adl(void)
 {
 	u64 *data_source;
@@ -127,7 +132,7 @@ void __init intel_pmu_pebs_data_source_adl(void)
 
 	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX].pebs_data_source;
 	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
-	intel_pmu_pebs_data_source_grt(data_source);
+	__intel_pmu_pebs_data_source_grt(data_source);
 }
 
 static u64 precise_store_data(u64 status)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ba3d24a..266143a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1516,6 +1516,8 @@ void intel_pmu_pebs_data_source_skl(bool pmem);
 
 void intel_pmu_pebs_data_source_adl(void);
 
+void intel_pmu_pebs_data_source_grt(void);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
