Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82D5AE48C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbiIFJl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbiIFJlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:41:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95804753BF;
        Tue,  6 Sep 2022 02:41:36 -0700 (PDT)
Date:   Tue, 06 Sep 2022 09:41:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662457294;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jqvlJ33wBfmd0wCdx8OKf+IHaKkLmft9PZ+7Vfolfvk=;
        b=KxX290Hg6mV1JscoK3S3TIavZO1n8YKkrPxiVVjj86xDtRobg6V6W5DCXZuAGOyeVo46en
        KMb1FOcCfOo0brYNS7SKxdKTg+cT2l4cU+pK3oyXx/i9fVX3421LtpzdOCstJuLhHiRvcQ
        VVcKwXnDyXnLPXRoxdrNAIkA3yXHZHrndI6Gp4STrHPDbmLAPpATKm9xq8s9Qt8pXiFF5Z
        nrLDiqlLA0YI14mBz9yXVfGN/B753uJptMlBbME9KfJYz+uSBmquxpQDuA6/aVlhSnpCnA
        37unwHUyn9mA9AbqaH5T4ZmbftA6+jX2O629UC2j8NqXFwP7BvX7pXlRc531pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662457294;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jqvlJ33wBfmd0wCdx8OKf+IHaKkLmft9PZ+7Vfolfvk=;
        b=9/9Zr6LLcAppA6UDuBR3TctokhAgi4+aIDI1iRvNCLd7IWKg/kbyG8v33FLCR1+r0di7PT
        aOdZMXQF8xXMDhCw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pebs: Fix PEBS timestamps overwritten
Cc:     Andreas Kogler <andreas.kogler.0x@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220901130959.1285717-3-kan.liang@linux.intel.com>
References: <20220901130959.1285717-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166245729337.401.1370931544780957482.tip-bot2@tip-bot2>
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

Commit-ID:     47a3aeb39e8dc099ae431cd8b46bdf218f5511b2
Gitweb:        https://git.kernel.org/tip/47a3aeb39e8dc099ae431cd8b46bdf218f5511b2
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 01 Sep 2022 06:09:55 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Sep 2022 11:33:01 +02:00

perf/x86/intel/pebs: Fix PEBS timestamps overwritten

The PEBS TSC-based timestamps do not appear correctly in the final
perf.data output file from perf record.

The data->time field setup by PEBS in the setup_pebs_fixed_sample_data()
is later overwritten by perf_events generic code in
perf_prepare_sample(). There is an ordering problem.

Set the sample flags when the data->time is updated by PEBS.
The data->time field will not be overwritten anymore.

Reported-by: Andreas Kogler <andreas.kogler.0x@gmail.com>
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220901130959.1285717-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba60427..cdd857b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1635,8 +1635,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 * We can only do this for the default trace clock.
 	 */
 	if (x86_pmu.intel_cap.pebs_format >= 3 &&
-		event->attr.use_clockid == 0)
+		event->attr.use_clockid == 0) {
 		data->time = native_sched_clock_from_tsc(pebs->tsc);
+		data->sample_flags |= PERF_SAMPLE_TIME;
+	}
 
 	if (has_branch_stack(event))
 		data->br_stack = &cpuc->lbr_stack;
@@ -1697,8 +1699,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	perf_sample_data_init(data, 0, event->hw.last_period);
 	data->period = event->hw.last_period;
 
-	if (event->attr.use_clockid == 0)
+	if (event->attr.use_clockid == 0) {
 		data->time = native_sched_clock_from_tsc(basic->tsc);
+		data->sample_flags |= PERF_SAMPLE_TIME;
+	}
 
 	/*
 	 * We must however always use iregs for the unwinder to stay sane; the
