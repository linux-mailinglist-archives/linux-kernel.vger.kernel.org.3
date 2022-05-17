Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF22552ADE3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiEQWOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiEQWOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:14:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A747245523;
        Tue, 17 May 2022 15:14:37 -0700 (PDT)
Date:   Tue, 17 May 2022 22:14:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652825676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZkW25diCjZhhJiIeWzEaepfs+AscLxtkOsxOdut4Bxk=;
        b=h5TezNhRyghH/9o4IflJ2M3p0L6N+YMUWGRO1Zdc3NAygyLs1vT/E0cbiCYWejFzw0QTjj
        ZEldu3XxINxCdi+b7OieIMXq/aXSGAtGYXFxPvZCkRHM6es/sMr+XTyHsg9dZ81TDAbh4g
        XAlPSzWyf4eNU+gUb6pQEam+Npk0JilGgQNBQx64RQoynwAD0GMlGRULrxCPfAS9r5Sm3p
        9hCQibGAIud6PKXC3Fuxc7wuiU909vUqDCYeIFtodZXqHRSnNfBwpisa03NeMClcZmK5Nv
        LL/+wv1TAPYcoTLGdQyXPvh4jCF+odJ3uvOf/Ffp1/nN4IQHLgx2EIdRVKvdpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652825676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZkW25diCjZhhJiIeWzEaepfs+AscLxtkOsxOdut4Bxk=;
        b=iz9WaRRx9zxKx0zNPcIP4BOX5W1vUenA1F6c3Ff57rBO4HJjpYBvskTeY69AdwYperIAkZ
        1/TvTIO9XjD465Cg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Fix AMD BRS period adjustment
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <165282567475.4207.12287002853279789468.tip-bot2@tip-bot2>
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

Commit-ID:     3c27b0c6ea48bc61492a138c410e262735d660ab
Gitweb:        https://git.kernel.org/tip/3c27b0c6ea48bc61492a138c410e262735d660ab
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 May 2022 21:22:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 18 May 2022 00:08:25 +02:00

perf/x86/amd: Fix AMD BRS period adjustment

There's two problems with the current amd_brs_adjust_period() code:

 - it isn't in fact AMD specific and wil always adjust the period;

 - it adjusts the period, while it should only adjust the event count,
   resulting in repoting a short period.

Fix this by using x86_pmu.limit_period, this makes it specific to the
AMD BRS case and ensures only the event count is adjusted while the
reported period is unmodified.

Fixes: ba2fe7500845 ("perf/x86/amd: Add AMD branch sampling period adjustment")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/amd/core.c   | 13 +++++++++++++
 arch/x86/events/core.c       |  7 -------
 arch/x86/events/perf_event.h | 18 ------------------
 3 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index d81eac2..3eee59c 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1255,6 +1255,18 @@ static void amd_pmu_sched_task(struct perf_event_context *ctx,
 		amd_pmu_brs_sched_task(ctx, sched_in);
 }
 
+static u64 amd_pmu_limit_period(struct perf_event *event, u64 left)
+{
+	/*
+	 * Decrease period by the depth of the BRS feature to get the last N
+	 * taken branches and approximate the desired period
+	 */
+	if (has_branch_stack(event) && left > x86_pmu.lbr_nr)
+		left -= x86_pmu.lbr_nr;
+
+	return left;
+}
+
 static __initconst const struct x86_pmu amd_pmu = {
 	.name			= "AMD",
 	.handle_irq		= amd_pmu_handle_irq,
@@ -1415,6 +1427,7 @@ static int __init amd_core_pmu_init(void)
 	if (boot_cpu_data.x86 >= 0x19 && !amd_brs_init()) {
 		x86_pmu.get_event_constraints = amd_get_event_constraints_f19h;
 		x86_pmu.sched_task = amd_pmu_sched_task;
+		x86_pmu.limit_period = amd_pmu_limit_period;
 		/*
 		 * put_event_constraints callback same as Fam17h, set above
 		 */
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b08052b..3078889 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1375,13 +1375,6 @@ int x86_perf_event_set_period(struct perf_event *event)
 		return x86_pmu.set_topdown_event_period(event);
 
 	/*
-	 * decrease period by the depth of the BRS feature to get
-	 * the last N taken branches and approximate the desired period
-	 */
-	if (has_branch_stack(event))
-		period = amd_brs_adjust_period(period);
-
-	/*
 	 * If we are way outside a reasonable range then just skip forward:
 	 */
 	if (unlikely(left <= -period)) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3b03245..21a5482 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1254,14 +1254,6 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 }
 
 void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool sched_in);
-
-static inline s64 amd_brs_adjust_period(s64 period)
-{
-	if (period > x86_pmu.lbr_nr)
-		return period - x86_pmu.lbr_nr;
-
-	return period;
-}
 #else
 static inline int amd_brs_init(void)
 {
@@ -1290,11 +1282,6 @@ static inline void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool s
 {
 }
 
-static inline s64 amd_brs_adjust_period(s64 period)
-{
-	return period;
-}
-
 static inline void amd_brs_enable_all(void)
 {
 }
@@ -1324,11 +1311,6 @@ static inline void amd_brs_enable_all(void)
 static inline void amd_brs_disable_all(void)
 {
 }
-
-static inline s64 amd_brs_adjust_period(s64 period)
-{
-	return period;
-}
 #endif /* CONFIG_CPU_SUP_AMD */
 
 static inline int is_pebs_pt(struct perf_event *event)
