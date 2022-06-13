Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3481E548244
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbiFMI3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbiFMI3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:29:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546F61EC59;
        Mon, 13 Jun 2022 01:29:08 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:29:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655108946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cEKSZ1swQ/Gu8D7Xk1TujJIwZwZ9EOaDg44+JHOBF8g=;
        b=jJbp61Y8yjQUpSVdMVgY0SgsLxaGLipHC8Pk5Kvkdx7mBi5aj3zXwpmg6eErgPkvekPOv8
        XlKxyTALvg258wkSRYlB4KtdbFNlW7XbMf/1Uj2Z6IyoH2tWvVfyf/wDYcR5ALjNFvPocA
        JRHgUp15oaAsrhflJkKfmb4gbjDMvYU4HIe5GEqE1MpNxJ+sKfp1D1o2/IEEITuGwNMFRo
        7rbL+yoJxtpD/IevzBCLXOhOKaIO8xR0lr7FzP9ymktELetBczxGllQlFeX++Y/ugkT/zN
        37ayAfH/YYd1aQXjuCDegB7j2mZq2rrdklefYOvNKYmYz8/HSfAdzP4spua/Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655108947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cEKSZ1swQ/Gu8D7Xk1TujJIwZwZ9EOaDg44+JHOBF8g=;
        b=yUtwqMrvk/lxcYK96WNaSKYIOQEPdGIvOClvGwD78b3pvfwhy0Sd7XtiRwNrSGXIuaBiNq
        Le00LU4/EyYyIWAQ==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Use dynamic events array
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C21eea0cb6de9d14f78d52d1d62637ae02bc900f5=2E16529?=
 =?utf-8?q?54372=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C21eea0cb6de9d14f78d52d1d62637ae02bc900f5=2E165295?=
 =?utf-8?q?4372=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165510894582.4207.10613005207377030215.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     39621c5808f5dda75d03dc4b2d4d2b13a5a1c34b
Gitweb:        https://git.kernel.org/tip/39621c5808f5dda75d03dc4b2d4d2b13a5a1c34b
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 19 May 2022 15:33:30 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:15:13 +02:00

perf/x86/amd/uncore: Use dynamic events array

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, the number of available counters for a given
uncore PMU may not be fixed across families and models
and has to be determined at runtime.

The per-cpu uncore PMU data currently uses a fixed-sized
array for event information. Make it dynamic based on the
number of available counters.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/21eea0cb6de9d14f78d52d1d62637ae02bc900f5.1652954372.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 38 ++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 0d04414..8dfcf93 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -21,7 +21,6 @@
 #define NUM_COUNTERS_NB		4
 #define NUM_COUNTERS_L2		4
 #define NUM_COUNTERS_L3		6
-#define MAX_COUNTERS		6
 
 #define RDPMC_BASE_NB		6
 #define RDPMC_BASE_LLC		10
@@ -46,7 +45,7 @@ struct amd_uncore {
 	u32 msr_base;
 	cpumask_t *active_mask;
 	struct pmu *pmu;
-	struct perf_event *events[MAX_COUNTERS];
+	struct perf_event **events;
 	struct hlist_node node;
 };
 
@@ -370,11 +369,19 @@ static struct amd_uncore *amd_uncore_alloc(unsigned int cpu)
 			cpu_to_node(cpu));
 }
 
+static inline struct perf_event **
+amd_uncore_events_alloc(unsigned int num, unsigned int cpu)
+{
+	return kzalloc_node(sizeof(struct perf_event *) * num, GFP_KERNEL,
+			    cpu_to_node(cpu));
+}
+
 static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 {
-	struct amd_uncore *uncore_nb = NULL, *uncore_llc;
+	struct amd_uncore *uncore_nb = NULL, *uncore_llc = NULL;
 
 	if (amd_uncore_nb) {
+		*per_cpu_ptr(amd_uncore_nb, cpu) = NULL;
 		uncore_nb = amd_uncore_alloc(cpu);
 		if (!uncore_nb)
 			goto fail;
@@ -384,11 +391,15 @@ static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 		uncore_nb->msr_base = MSR_F15H_NB_PERF_CTL;
 		uncore_nb->active_mask = &amd_nb_active_mask;
 		uncore_nb->pmu = &amd_nb_pmu;
+		uncore_nb->events = amd_uncore_events_alloc(num_counters_nb, cpu);
+		if (!uncore_nb->events)
+			goto fail;
 		uncore_nb->id = -1;
 		*per_cpu_ptr(amd_uncore_nb, cpu) = uncore_nb;
 	}
 
 	if (amd_uncore_llc) {
+		*per_cpu_ptr(amd_uncore_llc, cpu) = NULL;
 		uncore_llc = amd_uncore_alloc(cpu);
 		if (!uncore_llc)
 			goto fail;
@@ -398,6 +409,9 @@ static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 		uncore_llc->msr_base = MSR_F16H_L2I_PERF_CTL;
 		uncore_llc->active_mask = &amd_llc_active_mask;
 		uncore_llc->pmu = &amd_llc_pmu;
+		uncore_llc->events = amd_uncore_events_alloc(num_counters_llc, cpu);
+		if (!uncore_llc->events)
+			goto fail;
 		uncore_llc->id = -1;
 		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore_llc;
 	}
@@ -405,9 +419,16 @@ static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 	return 0;
 
 fail:
-	if (amd_uncore_nb)
-		*per_cpu_ptr(amd_uncore_nb, cpu) = NULL;
-	kfree(uncore_nb);
+	if (uncore_nb) {
+		kfree(uncore_nb->events);
+		kfree(uncore_nb);
+	}
+
+	if (uncore_llc) {
+		kfree(uncore_llc->events);
+		kfree(uncore_llc);
+	}
+
 	return -ENOMEM;
 }
 
@@ -540,8 +561,11 @@ static void uncore_dead(unsigned int cpu, struct amd_uncore * __percpu *uncores)
 	if (cpu == uncore->cpu)
 		cpumask_clear_cpu(cpu, uncore->active_mask);
 
-	if (!--uncore->refcnt)
+	if (!--uncore->refcnt) {
+		kfree(uncore->events);
 		kfree(uncore);
+	}
+
 	*per_cpu_ptr(uncores, cpu) = NULL;
 }
 
