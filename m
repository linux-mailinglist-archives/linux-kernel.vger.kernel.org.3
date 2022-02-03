Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535A44A8666
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351341AbiBCOdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351235AbiBCOdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C130DC06173E;
        Thu,  3 Feb 2022 06:33:28 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OiE4AVMMkxmpsjpPgre3O1OgfrSaY22S3SgzrFR/ozk=;
        b=TACrKoXpbQQtHBwW6OfEYeZK8CUsWINfPxdieIeBhuLsBncWkfDyAhhyPd/urWz3Tx4dXM
        0i39/5pgGc5DZwi5AXFP2FHAbdN1PF/07yQVTcMjxs8kR7MVvBpcpwncmbkjeHTj09LD3l
        SEXeculII51izGWqaCClcs8abF++ywukuJZb+XmPlTtMhk3a2tsZ5gvXZXbQrdFOQZKySv
        dfRITiItPQzeTSbDLP6drwcnSfr597Yg9i6N3KtwZl2SG+eKKIqXOhawfLjqCoDNeWpMsV
        riXvq9CYvPP9ZYDdNy4hckR0GAAbVeV+D1mDaGrSvx2gV6KgD1Wt2NwRr4y8LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OiE4AVMMkxmpsjpPgre3O1OgfrSaY22S3SgzrFR/ozk=;
        b=aSynJxIzLga/8UHsCfjctOyWMwWVrqBJvIiIXE42Npw3WcCFfnffQLh7qQvC9aTelmta/j
        1ieKJ1aKXUYn5yDw==
From:   "tip-bot2 for Wei Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] KVM: x86: use the KVM side max supported fixed counter
Cc:     Wei Wang <wei.w.wang@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1643750603-100733-2-git-send-email-kan.liang@linux.intel.com>
References: <1643750603-100733-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164389880600.16921.12233954881307976266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0144ba0c5bd3176647bb4d49a697d231610c78b7
Gitweb:        https://git.kernel.org/tip/0144ba0c5bd3176647bb4d49a697d231610c78b7
Author:        Wei Wang <wei.w.wang@intel.com>
AuthorDate:    Tue, 01 Feb 2022 13:23:22 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:44 +01:00

KVM: x86: use the KVM side max supported fixed counter

KVM vPMU doesn't support to emulate all the fixed counters that the
host PMU driver has supported, e.g. the fixed counter 3 used by
Topdown metrics hasn't been supported by KVM so far.

Rename MAX_FIXED_COUNTERS to KVM_PMC_MAX_FIXED to have a more
straightforward naming convention as INTEL_PMC_MAX_FIXED used by the
host PMU driver, and fix vPMU to use the KVM side KVM_PMC_MAX_FIXED
for the virtual fixed counter emulation, instead of the host side
INTEL_PMC_MAX_FIXED.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1643750603-100733-2-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/include/asm/kvm_host.h | 3 ++-
 arch/x86/kvm/cpuid.c            | 3 ++-
 arch/x86/kvm/pmu.h              | 2 --
 arch/x86/kvm/vmx/pmu_intel.c    | 4 ++--
 arch/x86/kvm/x86.c              | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6e7c545..7d8f9e9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -498,6 +498,7 @@ struct kvm_pmc {
 	bool intr;
 };
 
+#define KVM_PMC_MAX_FIXED	3
 struct kvm_pmu {
 	unsigned nr_arch_gp_counters;
 	unsigned nr_arch_fixed_counters;
@@ -511,7 +512,7 @@ struct kvm_pmu {
 	u64 reserved_bits;
 	u8 version;
 	struct kvm_pmc gp_counters[INTEL_PMC_MAX_GENERIC];
-	struct kvm_pmc fixed_counters[INTEL_PMC_MAX_FIXED];
+	struct kvm_pmc fixed_counters[KVM_PMC_MAX_FIXED];
 	struct irq_work irq_work;
 	DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
 	DECLARE_BITMAP(all_valid_pmc_idx, X86_PMC_IDX_MAX);
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 28be02a..b4ebf62 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -875,7 +875,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		eax.split.bit_width = cap.bit_width_gp;
 		eax.split.mask_length = cap.events_mask_len;
 
-		edx.split.num_counters_fixed = min(cap.num_counters_fixed, MAX_FIXED_COUNTERS);
+		edx.split.num_counters_fixed =
+			min(cap.num_counters_fixed, KVM_PMC_MAX_FIXED);
 		edx.split.bit_width_fixed = cap.bit_width_fixed;
 		if (cap.version)
 			edx.split.anythread_deprecated = 1;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 7a7b8d5..9e66fba 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -15,8 +15,6 @@
 #define VMWARE_BACKDOOR_PMC_REAL_TIME		0x10001
 #define VMWARE_BACKDOOR_PMC_APPARENT_TIME	0x10002
 
-#define MAX_FIXED_COUNTERS	3
-
 struct kvm_event_hw_type_mapping {
 	u8 eventsel;
 	u8 unit_mask;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 466d18f..9b26596 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -565,7 +565,7 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 		pmu->gp_counters[i].current_config = 0;
 	}
 
-	for (i = 0; i < INTEL_PMC_MAX_FIXED; i++) {
+	for (i = 0; i < KVM_PMC_MAX_FIXED; i++) {
 		pmu->fixed_counters[i].type = KVM_PMC_FIXED;
 		pmu->fixed_counters[i].vcpu = vcpu;
 		pmu->fixed_counters[i].idx = i + INTEL_PMC_IDX_FIXED;
@@ -591,7 +591,7 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 		pmc->counter = pmc->eventsel = 0;
 	}
 
-	for (i = 0; i < INTEL_PMC_MAX_FIXED; i++) {
+	for (i = 0; i < KVM_PMC_MAX_FIXED; i++) {
 		pmc = &pmu->fixed_counters[i];
 
 		pmc_stop_counter(pmc);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 197209f..d3fb2bc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6514,7 +6514,7 @@ static void kvm_init_msr_list(void)
 	u32 dummy[2];
 	unsigned i;
 
-	BUILD_BUG_ON_MSG(INTEL_PMC_MAX_FIXED != 4,
+	BUILD_BUG_ON_MSG(KVM_PMC_MAX_FIXED != 3,
 			 "Please update the fixed PMCs in msrs_to_saved_all[]");
 
 	perf_get_x86_pmu_capability(&x86_pmu);
