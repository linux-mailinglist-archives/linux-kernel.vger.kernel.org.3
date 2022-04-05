Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1104F2CE5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354406AbiDEKOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbiDEIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D89E0B0;
        Tue,  5 Apr 2022 01:29:04 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t5QdTcexKGrFnIIKbz3EEw5sTtf8rB6xiflkyqxuIHk=;
        b=Wy9liIW7wnl+I6GcQobqp2b2oSSXTUr1/XF4+y7sY9NjCS2Ytl7MtP7/O7iBawmSsX3CZ2
        wBSXmImKvSWgWBzSN0qfyxr1GLNKxQTYpJwxuBMrPZSHN6GOlJOZAcBu4y1jjqg2/+VHqI
        nlZ5r8m+b/09hIecvAa8DMYqR4P2yyKk0gzYMoW5Kvr9wHn5MUM6PrD5St5RF08XILyyio
        Aecsqgg4kjxRJKUOsrujmERUaYN3NncQkmHdKwmOWLbrNyxGMP6Xao+dQa7nKUGM+eHJjL
        t1eXmPIiPHbgf2YEZGhedOhzMt8P+Ym6/FP5SkArhYQfKfHIwB25ObrI4ivViw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t5QdTcexKGrFnIIKbz3EEw5sTtf8rB6xiflkyqxuIHk=;
        b=L6rKuAa+JZSI45qKzsCxiKc5e1aIOdl0oQ2NXa9O9MfzlbyS2ek1M4YrZp+kHNY+Kx0QOc
        yJrJ0637ehAKoxBg==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Always set cpuctx cgrp when enable cgroup event
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220329154523.86438-5-zhouchengming@bytedance.com>
References: <20220329154523.86438-5-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <164914734200.389.12009651583412320175.tip-bot2@tip-bot2>
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

Commit-ID:     e19cd0b6fa5938c51d7b928010d584f0de93913a
Gitweb:        https://git.kernel.org/tip/e19cd0b6fa5938c51d7b928010d584f0de93913a
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Tue, 29 Mar 2022 23:45:23 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:45 +02:00

perf/core: Always set cpuctx cgrp when enable cgroup event

When enable a cgroup event, cpuctx->cgrp setting is conditional
on the current task cgrp matching the event's cgroup, so have to
do it for every new event. It brings complexity but no advantage.

To keep it simple, this patch would always set cpuctx->cgrp
when enable the first cgroup event, and reset to NULL when disable
the last cgroup event.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220329154523.86438-5-zhouchengming@bytedance.com
---
 kernel/events/core.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index bdeb41f..23bb197 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -967,22 +967,10 @@ perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ct
 	 */
 	cpuctx = container_of(ctx, struct perf_cpu_context, ctx);
 
-	/*
-	 * Since setting cpuctx->cgrp is conditional on the current @cgrp
-	 * matching the event's cgroup, we must do this for every new event,
-	 * because if the first would mismatch, the second would not try again
-	 * and we would leave cpuctx->cgrp unset.
-	 */
-	if (ctx->is_active && !cpuctx->cgrp) {
-		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
-
-		if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
-			cpuctx->cgrp = cgrp;
-	}
-
 	if (ctx->nr_cgroups++)
 		return;
 
+	cpuctx->cgrp = perf_cgroup_from_task(current, ctx);
 	list_add(&cpuctx->cgrp_cpuctx_entry,
 			per_cpu_ptr(&cgrp_cpuctx_list, event->cpu));
 }
@@ -1004,9 +992,7 @@ perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *c
 	if (--ctx->nr_cgroups)
 		return;
 
-	if (ctx->is_active && cpuctx->cgrp)
-		cpuctx->cgrp = NULL;
-
+	cpuctx->cgrp = NULL;
 	list_del(&cpuctx->cgrp_cpuctx_entry);
 }
 
