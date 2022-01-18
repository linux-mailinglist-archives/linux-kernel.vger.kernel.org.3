Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA1F492482
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbiARLR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:17:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35002 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiARLRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:17:52 -0500
Date:   Tue, 18 Jan 2022 11:17:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfrXWhTqq4VdqkxIOX4OWK5M0SEfSm9r3tdl3xzX/YM=;
        b=P6TMfyzrpAEtTct+Mpv8jBWCevggksH6vqpGvitVOeAenHNFGHT8YcuNR01d4e4OJWOnSz
        KIMJgz3NYqVBuXMQ3u2Jic01GO+2EALSEHdEqmUWlpPEWwNi8ixmzGm0F0cHS6rZRfUO8M
        A1tSK91xRWIdCViKfXesd7SMqi42RQsOyTopFnYLKkgDl3hUC/CZVVmvuKYVyCElbrdoou
        5y21MRlfQ8WeZzAdh059HfsjFCUklwnZZdkLj8X25bD6/64hez+AhFlsHl3tOUzkVoquvK
        wk2EUI1nS+OriNwsO1dmqYGn/ARVn5NsIe3fV3sAM+LG9Gh7xcmO4AHz9IF6wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfrXWhTqq4VdqkxIOX4OWK5M0SEfSm9r3tdl3xzX/YM=;
        b=MPnGAXXb7R+Cazfj8oQJzac726Dwneg+yNpAVgGSSk+semF31sg12TpAp+upPx1GuEILEy
        0QFq1lii6U9/53BQ==
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/lbr: Add static_branch for LBR INFO flags
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1641315077-96661-2-git-send-email-peterz@infradead.org>
References: <1641315077-96661-2-git-send-email-peterz@infradead.org>
MIME-Version: 1.0
Message-ID: <164250467074.16921.6846544154752218817.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     6b19788ddc5937831ffd27525a1b793953fd2d2b
Gitweb:        https://git.kernel.org/tip/6b19788ddc5937831ffd27525a1b793953fd2d2b
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Tue, 04 Jan 2022 08:51:17 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:09:49 +01:00

perf/x86/intel/lbr: Add static_branch for LBR INFO flags

Using static_branch to replace the LBR INFO flags to optimize the LBR
INFO parsing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/1641315077-96661-2-git-send-email-peterz@infradead.org
---
 arch/x86/events/intel/lbr.c | 51 ++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index b7228a1..f8fd255 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -893,37 +893,40 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 	cpuc->lbr_stack.hw_idx = tos;
 }
 
+static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
+static DEFINE_STATIC_KEY_FALSE(x86_lbr_cycles);
+static DEFINE_STATIC_KEY_FALSE(x86_lbr_type);
+
 static __always_inline int get_lbr_br_type(u64 info)
 {
-	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) || !x86_pmu.lbr_br_type)
-		return 0;
+	int type = 0;
 
-	return (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
+	if (static_branch_likely(&x86_lbr_type))
+		type = (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
+
+	return type;
 }
 
 static __always_inline bool get_lbr_mispred(u64 info)
 {
-	if (static_cpu_has(X86_FEATURE_ARCH_LBR) && !x86_pmu.lbr_mispred)
-		return 0;
+	bool mispred = 0;
 
-	return !!(info & LBR_INFO_MISPRED);
-}
-
-static __always_inline bool get_lbr_predicted(u64 info)
-{
-	if (static_cpu_has(X86_FEATURE_ARCH_LBR) && !x86_pmu.lbr_mispred)
-		return 0;
+	if (static_branch_likely(&x86_lbr_mispred))
+		mispred = !!(info & LBR_INFO_MISPRED);
 
-	return !(info & LBR_INFO_MISPRED);
+	return mispred;
 }
 
 static __always_inline u16 get_lbr_cycles(u64 info)
 {
+	u16 cycles = info & LBR_INFO_CYCLES;
+
 	if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
-	    !(x86_pmu.lbr_timed_lbr && info & LBR_INFO_CYC_CNT_VALID))
-		return 0;
+	    (!static_branch_likely(&x86_lbr_cycles) ||
+	     !(info & LBR_INFO_CYC_CNT_VALID)))
+		cycles = 0;
 
-	return info & LBR_INFO_CYCLES;
+	return cycles;
 }
 
 static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
@@ -951,7 +954,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->from		= from;
 		e->to		= to;
 		e->mispred	= get_lbr_mispred(info);
-		e->predicted	= get_lbr_predicted(info);
+		e->predicted	= !e->mispred;
 		e->in_tx	= !!(info & LBR_INFO_IN_TX);
 		e->abort	= !!(info & LBR_INFO_ABORT);
 		e->cycles	= get_lbr_cycles(info);
@@ -1718,6 +1721,14 @@ void intel_pmu_lbr_init(void)
 		x86_pmu.lbr_to_cycles = 1;
 		break;
 	}
+
+	if (x86_pmu.lbr_has_info) {
+		/*
+		 * Only used in combination with baseline pebs.
+		 */
+		static_branch_enable(&x86_lbr_mispred);
+		static_branch_enable(&x86_lbr_cycles);
+	}
 }
 
 /*
@@ -1779,6 +1790,12 @@ void __init intel_pmu_arch_lbr_init(void)
 	x86_pmu.lbr_br_type = ecx.split.lbr_br_type;
 	x86_pmu.lbr_nr = lbr_nr;
 
+	if (x86_pmu.lbr_mispred)
+		static_branch_enable(&x86_lbr_mispred);
+	if (x86_pmu.lbr_timed_lbr)
+		static_branch_enable(&x86_lbr_cycles);
+	if (x86_pmu.lbr_br_type)
+		static_branch_enable(&x86_lbr_type);
 
 	arch_lbr_xsave = is_arch_lbr_xsave_available();
 	if (arch_lbr_xsave) {
