Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369745A91D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiIAINb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiIAIMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:12:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9D812BF68;
        Thu,  1 Sep 2022 01:12:50 -0700 (PDT)
Date:   Thu, 01 Sep 2022 08:12:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662019968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BVVJWB+FdqmDQoz/2lQCiYMksJ7j4lLlKdXX3EHfCo=;
        b=lfg1gfkssnPaAi9G9e1uNdGgGU0d0795MNqKqOPT2ziVW/VYLR/oBVGag/PKVn2IYZaru7
        5ihxLxS1Kt1VbGY06kMb3ohnAiWdb1A/wIvZbh6VIyL2Xq1YYakroy6grH89rs2JMhY8iJ
        iBJGoyCP+kv9xjch1ZLW7GGCZ56LugU6w9hww5q8v6bam2Tf/PLkTub1okJrZ6IDrdRQiR
        ejbOfNxNyWmWYMArp0xiP3lVzvC+R2IbwSmScRXiR9nInWBhEXFQaU29AZLRCBBbpo4WO2
        +s74Z0NxJOwYzTyUBwnk69JMX9PbK+lTQWcYQI/P1xw6KRbSfwkTlnPepBh2xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662019968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BVVJWB+FdqmDQoz/2lQCiYMksJ7j4lLlKdXX3EHfCo=;
        b=haRTJ1tVQPCiPfFTdtUZM1p9rWBDSvV/OaRxHraHQFllKNTeD/bcLVFHYjN6q3AFGMnEzC
        29qdt6z3NEc9LvAQ==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ian Rogers <irogers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829124719.675715-8-elver@google.com>
References: <20220829124719.675715-8-elver@google.com>
MIME-Version: 1.0
Message-ID: <166201996690.401.10832809672722007197.tip-bot2@tip-bot2>
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

Commit-ID:     9caf87be118f4639537404eeb67dd444a3716e9a
Gitweb:        https://git.kernel.org/tip/9caf87be118f4639537404eeb67dd444a3716e9a
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 29 Aug 2022 14:47:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 Aug 2022 10:56:22 +02:00

perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable

Due to being a __weak function, hw_breakpoint_weight() will cause the
compiler to always emit a call to it. This generates unnecessarily bad
code (register spills etc.) for no good reason; in fact it appears in
profiles of `perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512`:

    ...
    0.70%  [kernel]       [k] hw_breakpoint_weight
    ...

While a small percentage, no architecture defines its own
hw_breakpoint_weight() nor are there users outside hw_breakpoint.c,
which makes the fact it is currently __weak a poor choice.

Change hw_breakpoint_weight()'s definition to follow a similar protocol
to hw_breakpoint_slots(), such that if <asm/hw_breakpoint.h> defines
hw_breakpoint_weight(), we'll use it instead.

The result is that it is inlined and no longer shows up in profiles.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20220829124719.675715-8-elver@google.com
---
 include/linux/hw_breakpoint.h | 1 -
 kernel/events/hw_breakpoint.c | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index a3fb846..f319bd2 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -80,7 +80,6 @@ extern int dbg_reserve_bp_slot(struct perf_event *bp);
 extern int dbg_release_bp_slot(struct perf_event *bp);
 extern int reserve_bp_slot(struct perf_event *bp);
 extern void release_bp_slot(struct perf_event *bp);
-int hw_breakpoint_weight(struct perf_event *bp);
 int arch_reserve_bp_slot(struct perf_event *bp);
 void arch_release_bp_slot(struct perf_event *bp);
 void arch_unregister_hw_breakpoint(struct perf_event *bp);
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 9fb66d3..9c9bf17 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -124,10 +124,12 @@ err:
 }
 #endif
 
-__weak int hw_breakpoint_weight(struct perf_event *bp)
+#ifndef hw_breakpoint_weight
+static inline int hw_breakpoint_weight(struct perf_event *bp)
 {
 	return 1;
 }
+#endif
 
 static inline enum bp_type_idx find_slot_idx(u64 bp_type)
 {
