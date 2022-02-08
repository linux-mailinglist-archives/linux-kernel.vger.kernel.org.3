Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689864AE11D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385185AbiBHSma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356333AbiBHSmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:42:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8287C0612AA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:42:19 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id t9so81124plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IzYAh6mtxyAZ2drjtva0WxDIoe1TxiIdW6u31Cu1VZ0=;
        b=Rn7TMd/F12tHX5PTTIfciknUnwo2d7sRReHQLBHclrIbs4kzH1kmWQfBKSijxIYqNK
         9CmfuIRHZSF3joepIGkZW8ahirN3q1TzibCOEBECrLRobrWRJI8tCZ5W1dzfI8wylYQE
         d0flpx4A9y3tzSBvR49MoHK7mbPF4EtMP1QAUBDtdVigkbhe7d+V89KqIWBctTMKY8Sk
         kp8OlmWqElx4SkCpRznucWmMQMjaE+vZwDax5fDsxrwCovsgwA3z/0krvCKpIvUtWUcD
         twN6kX5t0DC0Kw8WJFwWG3HrDuXRy0m69JjLJB0SQNsZ4m9+ZClz0rLcsfIY+JxmS+EM
         4KTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IzYAh6mtxyAZ2drjtva0WxDIoe1TxiIdW6u31Cu1VZ0=;
        b=ePluCcSFRbfZjbXAgfo9oQ1i4SNEq2ROSh4YZttYrdMm1tPR+KKqq1UTgb3Zs+1wXU
         vy6SEiN5dIH82vm8pIKvOyH73MUk/3J/R0jFgYolQrdEoge2pmoZj4/wAev6DIoYEDKK
         Q7GPv95sUgJCQj4HsWLx0+iTkEKWKbVoviVxYDtvjxHDK2BV4FEoJckmCrn9mhi3NjHs
         qDt+urYBZim7BoXrlxC16EoEqyJ1u1nR12dYFrdQgkHDLv7uCl9ym7jx5cluL3SUQPmj
         tuV1gg2TURLfpf/IjPGNkZIpvL390tepxm7g9vCZQ4EG/ntlAExAiOkMjHDLHn/To+z1
         bv6Q==
X-Gm-Message-State: AOAM533vLexharKkhnATUI32EX0ObMK4vbA4szPR4P9pVJYh8VmDtjgv
        6vkCU2xcPs0X1s7qtjBXiXCc7t5TySU=
X-Google-Smtp-Source: ABdhPJyDr72d0npd7vA3/hqnRU5jkANyKzduN67CIKfYJwax2Iq8Ps0vZjn5x17osa4MIjO33IkbMw==
X-Received: by 2002:a17:902:e801:: with SMTP id u1mr5662822plg.124.1644345739249;
        Tue, 08 Feb 2022 10:42:19 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id l14sm3517027pjf.1.2022.02.08.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:42:18 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>
Subject: [PATCH 03/12] timer: Protect lockdep functions with #ifdef
Date:   Tue,  8 Feb 2022 10:41:59 -0800
Message-Id: <20220208184208.79303-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208184208.79303-1-namhyung@kernel.org>
References: <20220208184208.79303-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With upcoming lock tracepoints config, it'd define some of lockdep
functions without enabling CONFIG_LOCKDEP actually.  The existing code
assumes those functions will be removed by the preprocessor but it's
not the case anymore.  Let's protect the code with #ifdef's explicitly.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/time/timer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 85f1021ad459..4af95dbf6435 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -794,7 +794,10 @@ static void do_init_timer(struct timer_list *timer,
 	if (WARN_ON_ONCE(flags & ~TIMER_INIT_FLAGS))
 		flags &= TIMER_INIT_FLAGS;
 	timer->flags = flags | raw_smp_processor_id();
+
+#ifdef CONFIG_LOCKDEP
 	lockdep_init_map(&timer->lockdep_map, name, key, 0);
+#endif
 }
 
 /**
@@ -1409,19 +1412,22 @@ static void call_timer_fn(struct timer_list *timer,
 	struct lockdep_map lockdep_map;
 
 	lockdep_copy_map(&lockdep_map, &timer->lockdep_map);
-#endif
+
 	/*
 	 * Couple the lock chain with the lock chain at
 	 * del_timer_sync() by acquiring the lock_map around the fn()
 	 * call here and in del_timer_sync().
 	 */
 	lock_map_acquire(&lockdep_map);
+#endif
 
 	trace_timer_expire_entry(timer, baseclk);
 	fn(timer);
 	trace_timer_expire_exit(timer);
 
+#ifdef CONFIG_LOCKDEP
 	lock_map_release(&lockdep_map);
+#endif
 
 	if (count != preempt_count()) {
 		WARN_ONCE(1, "timer: %pS preempt leak: %08x -> %08x\n",
-- 
2.35.0.263.gb82422642f-goog

