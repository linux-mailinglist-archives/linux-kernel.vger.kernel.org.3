Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0154DC947
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiCQOxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiCQOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:52:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4F2202154
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:51:35 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:51:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647528693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5HsTkt5LkSywMg+8wsxDE5BciSbvoa8Lt+0obFJ8iQ0=;
        b=2k0JxQf9gCasFKRv7xTAJs4apry1MVVEHsIPwzthCr0V7zFHLXjtpHaUkDU8WphQ5PzZYV
        OlPbhZME5wnEcvWxDHaG7HFGn6vEiKK/STmIkgEKs8Pi22I+p6X4ml+VtboXYUTZx6Xn0q
        C+1pNmdOHsL2VFpI0r9SV8RS0RXKUnvak7kcfEHfMwUL+g7/R1c06oZnOAQPaYflTavEjP
        bOwWm0Bxii7GTpN6qhTpFsSLOI0Itiq8sInEE+aiiGdcsM4ixvXDBAMuDI5gRxRRbI9LDS
        rKofDwS7Vy6LqDIMF4tGtl06euMG3M0iucQFCChPX/VZpO1M13quXlVUDAr+Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647528693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5HsTkt5LkSywMg+8wsxDE5BciSbvoa8Lt+0obFJ8iQ0=;
        b=DrV1L4MngTzgpyz/CibEPaIzYAokEGyMlPgKXq0EekDap9Ey9FcBQOV7ohtwY1lE+HFqpY
        WcMOHdXu6JU7D4Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH] sched: Teach the forced-newidle balancer about CPU affinity
 limitation.
Message-ID: <YjNK9El+3fzGmswf@linutronix.de>
References: <20220308161455.036e9933@gandalf.local.home>
 <20220315174606.02959816@gandalf.local.home>
 <YjIKQBIbJR/kRR+N@linutronix.de>
 <YjIN4C8EFIOOR+o4@linutronix.de>
 <20220316203524.GK8939@worktop.programming.kicks-ass.net>
 <YjMk4b3vbR4vJqfO@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjMk4b3vbR4vJqfO@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

try_steal_cookie() looks at task_struct::cpus_mask to decide if the
task could be moved to `this' CPU. It ignores that the task might be in
a migration disabled section while not on the CPU. In this case the task
must not be moved otherwise per-CPU assumption are broken.

Use is_cpu_allowed(), as suggested by Peter Zijlstra, to decide if the a
task can be moved.

Fixes: d2dfa17bc7de6 ("sched: Trivial forced-newidle balancer")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a44414946de3d..421ace2e007de 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5923,7 +5923,7 @@ static bool try_steal_cookie(int this, int that)
 		if (p == src->core_pick || p == src->curr)
 			goto next;
 
-		if (!cpumask_test_cpu(this, &p->cpus_mask))
+		if (!is_cpu_allowed(p, this))
 			goto next;
 
 		if (p->core_occupation > dst->idle->core_occupation)
-- 
2.35.1

