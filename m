Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650D252355B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244587AbiEKOZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbiEKOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:25:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D06A40A3B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fzXxRG6OXG8jw/YQezAyrq7G35GCWfwkvISstTTxtus=; b=BdcmOLm2rz344t6tbIbh6CFOC8
        AvsfNgbdPXnGb5G9LrIlEaTB17d8qe9Y21KRpRS0ER9wTdMjrs/EOKmspYoQXKiJ66mcQaxyYL8+B
        LFAyt53fU1q2GR6wZmSyAjC4w9gtoFbuvvwkHuZ44b3Ik5o41uuua7Nrt5cUYunu8mcSVIz/Y3uUP
        nhUvO9PlZigtTlQVTOpvIeV5ak5psuqVw2stonZVGkVmqrWsW/qejQgVUM5kqXa1C9v3yHeK1L95u
        r6XEeDmRNUkz5sFv5nKfo4W0Kmq01GBwdU0hYhWXfg1YKoVgyoSYYUGgNzhfje5KZFCQhaFpUh2d3
        /eGXE/3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nonH5-00DBu4-1R; Wed, 11 May 2022 14:25:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3454430047E;
        Wed, 11 May 2022 16:25:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1E5D920236A42; Wed, 11 May 2022 16:25:09 +0200 (CEST)
Message-ID: <20220511142345.084235472@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 11 May 2022 16:20:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH 1/5] perf/x86/amd: Fix AMD BRS period adjustment
References: <20220511142037.353492804@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 arch/x86/events/amd/core.c   |   13 +++++++++++++
 arch/x86/events/core.c       |    7 -------
 arch/x86/events/perf_event.h |   18 ------------------
 3 files changed, 13 insertions(+), 25 deletions(-)

--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1258,6 +1258,18 @@ static void amd_pmu_sched_task(struct pe
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
@@ -1418,6 +1430,7 @@ static int __init amd_core_pmu_init(void
 	if (boot_cpu_data.x86 >= 0x19 && !amd_brs_init()) {
 		x86_pmu.get_event_constraints = amd_get_event_constraints_f19h;
 		x86_pmu.sched_task = amd_pmu_sched_task;
+		x86_pmu.limit_period = amd_pmu_limit_period;
 		/*
 		 * put_event_constraints callback same as Fam17h, set above
 		 */
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1375,13 +1375,6 @@ int x86_perf_event_set_period(struct per
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
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1254,14 +1254,6 @@ static inline void amd_pmu_brs_del(struc
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
@@ -1290,11 +1282,6 @@ static inline void amd_pmu_brs_sched_tas
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
@@ -1324,11 +1311,6 @@ static inline void amd_brs_enable_all(vo
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


