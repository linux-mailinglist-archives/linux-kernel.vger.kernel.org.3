Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ABE4AE452
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387516AbiBHW23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386201AbiBHTnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:43:45 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B357CC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:43:44 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id n23so320475pfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OMn1l57PTLxYtwc+HI0U7xszWZxDsxBNDoAjSgoqiTo=;
        b=eB1ulFLlG3MvjHSKqJMMPP76xZ5tzmritayHnxYj4pjoQSG31cYP4slT9wT97U7F0R
         tp0KYs48AvrVX4+VZj7CEwvYxNYoDtC2XN9IbBEi19IVT6jFC+dCWJWh2LhsinDz6s0Y
         WWnGw0c7L2wyr5fDrnnrYoT9AbQOeiBA1xVP2mSS6jhy8I81TidsErrdFVJ1xE013E1u
         yfS+FM+wkCjg3S5Q+FluIUilTHtzPX0I4W+T1MTf61x6x+jZTCd9E+JRKOvjiYz0RkOR
         m8V4+FLxsZc0S4V9/pF3CBOZZ3wDhIngfKi9ZRYAe3qEXvtjSm3p2Qd56MsIYlERVOvQ
         P6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OMn1l57PTLxYtwc+HI0U7xszWZxDsxBNDoAjSgoqiTo=;
        b=2Zvye8aT5ttDjsmR5xpxUykf34f3DQ/tvcWVgevfZ13x643fNf/30rfZqOX98665bZ
         7/VOLl5o75gNp+06ay9bnRbLJLJvuL6YmdcIm/izBoX/X3JiaLEQapPbtvQDpMCb0oRI
         YdQh0La/5McxYlkz1WUfLld7sDHeUVs0BhFiByhqsiSjbQn2cux8dWh5v0+jyyU91+ml
         1MDYQDKbQbg8Nf6zFDUgMZI6H39SUG80THbccRZTFsr4yfX7j7leDWfqYrX8CitWYS+d
         dkg8tS9zPiabhhgtHlQ7sHXu5WHay4xpwG7PgbXstjxItzYCJ7xpaVkJ9yrETZTA0Of+
         +azg==
X-Gm-Message-State: AOAM533MQDqLMdv4sK1WXC+qLYF52qNPM2GVWWicVXA9YhdjX3kK1sOj
        POIwa0J+pv5J2cQ3stJbAYY=
X-Google-Smtp-Source: ABdhPJxa3EJBSsbwQz/XZzLop6zZQaddVuKoxQrvRvkGQbStZq8FBYijx/2PQqDl+XAyFFBowzvwOw==
X-Received: by 2002:a05:6a00:23d5:: with SMTP id g21mr5835863pfc.78.1644349424241;
        Tue, 08 Feb 2022 11:43:44 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:43:43 -0800 (PST)
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 04/12] workqueue: Protect lockdep functions with #ifdef
Date:   Tue,  8 Feb 2022 11:43:16 -0800
Message-Id: <20220208194324.85333-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208194324.85333-1-namhyung@kernel.org>
References: <20220208194324.85333-1-namhyung@kernel.org>
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

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/workqueue.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33f1106b4f99..405e27385f74 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2279,8 +2279,11 @@ __acquires(&pool->lock)
 
 	raw_spin_unlock_irq(&pool->lock);
 
+#ifdef CONFIG_LOCKDEP
 	lock_map_acquire(&pwq->wq->lockdep_map);
 	lock_map_acquire(&lockdep_map);
+#endif
+
 	/*
 	 * Strictly speaking we should mark the invariant state without holding
 	 * any locks, that is, before these two lock_map_acquire()'s.
@@ -2310,8 +2313,11 @@ __acquires(&pool->lock)
 	 * point will only record its address.
 	 */
 	trace_workqueue_execute_end(work, worker->current_func);
+
+#ifdef CONFIG_LOCKDEP
 	lock_map_release(&lockdep_map);
 	lock_map_release(&pwq->wq->lockdep_map);
+#endif
 
 	if (unlikely(in_atomic() || lockdep_depth(current) > 0)) {
 		pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d\n"
@@ -2824,8 +2830,10 @@ void flush_workqueue(struct workqueue_struct *wq)
 	if (WARN_ON(!wq_online))
 		return;
 
+#ifdef CONFIG_LOCKDEP
 	lock_map_acquire(&wq->lockdep_map);
 	lock_map_release(&wq->lockdep_map);
+#endif
 
 	mutex_lock(&wq->mutex);
 
@@ -3052,6 +3060,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	insert_wq_barrier(pwq, barr, work, worker);
 	raw_spin_unlock_irq(&pool->lock);
 
+#ifdef CONFIG_LOCKDEP
 	/*
 	 * Force a lock recursion deadlock when using flush_work() inside a
 	 * single-threaded or rescuer equipped workqueue.
@@ -3066,6 +3075,8 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 		lock_map_acquire(&pwq->wq->lockdep_map);
 		lock_map_release(&pwq->wq->lockdep_map);
 	}
+#endif
+
 	rcu_read_unlock();
 	return true;
 already_gone:
@@ -3084,10 +3095,12 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!work->func))
 		return false;
 
+#ifdef CONFIG_LOCKDEP
 	if (!from_cancel) {
 		lock_map_acquire(&work->lockdep_map);
 		lock_map_release(&work->lockdep_map);
 	}
+#endif
 
 	if (start_flush_work(work, &barr, from_cancel)) {
 		wait_for_completion(&barr.done);
-- 
2.35.0.263.gb82422642f-goog

