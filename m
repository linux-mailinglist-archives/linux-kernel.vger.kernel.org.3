Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7544781B9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhLQAld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhLQAld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:41:33 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2485C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:41:32 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id t11so1058067qtw.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=akMYCHPrueJ4DBnQZkWH8nHV28OygtVi7uRo8K7sLug=;
        b=uzdUk1Tsh2ULATjoxxkQvIW2FlOX/1FrXLl0BtyqFq14wM4N5Rk2AJPthDRFVY0kia
         QF+Y/zPyFNI3gpXh5nb9TLPrpAjRF9bpxvJJMCYK4tvfRkOEFmG/6vECQgGkbW8koxDr
         FUd63Z+k9ceTw5w/kzuLMPcK3BKzYSNt/CMPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=akMYCHPrueJ4DBnQZkWH8nHV28OygtVi7uRo8K7sLug=;
        b=eXN+4/Fe97b2GIerg2uvakXDNaNqLi+c5s2xXZ2PIkucAfgl73qNZE0t2roPwiQcPF
         XNHY2f6C7pV8+eY6y80VPrQunqQTd0GT4EuFUpCPefOSWTTWc97dm8oQXUTGwa/cJKn0
         BsrMg4QUWpXqJ3BmcxTYZp6DSiNDvzI3oXfgS5THiJ8uAPTp7HqxhOINS5s99JR338aE
         c/61JHKSOTrpzpzB8I4ML3cv5q7mzdMF3cUkB6hge3nkPgkZ3tT10k4unmDSR2JnpYnV
         WcpoDDo9Jqw7Ba914Kg3u3mZcczjUqJSvc4oHY6HtFAu/eQYf5/zCNFgMB/qtA9Hg38S
         /N8A==
X-Gm-Message-State: AOAM531xenkU3U84Ihe4ZgxUo69/DTL4xP7z3T8sSgAiDYZOVFjmS5zi
        U3Pqq7Qvky/pzXycyvUZ5BQ+jQ==
X-Google-Smtp-Source: ABdhPJxqmMvBB00X7elmOAgVUIW/43ZuKFgtMaN+E+CNyCoZ0mPm+Y9SQwCYP/qhCbmc5toSZqeIrg==
X-Received: by 2002:a05:622a:d0:: with SMTP id p16mr459000qtw.573.1639701691927;
        Thu, 16 Dec 2021 16:41:31 -0800 (PST)
Received: from localhost ([2620:0:1004:5:8721:cbe2:b536:17d0])
        by smtp.gmail.com with ESMTPSA id j21sm3765942qkk.27.2021.12.16.16.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:41:31 -0800 (PST)
Date:   Thu, 16 Dec 2021 19:41:31 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Josh Don <joshdon@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "AubreyLi@google.com" <aubrey.intel@gmail.com>,
        aubrey.li@linux.intel.com, Aaron Lu <aaron.lwe@gmail.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Don Hiatt <dhiatt@digitalocean.com>, ricardo.neri@intel.com,
        vincent.guittot@linaro.org
Cc:     joelaf@google.com
Subject: [RFC] High latency with core scheduling
Message-ID: <Ybvcu5RIwV+Vko09@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On ChromeOS, we see really high scheduling latency when there is a heavy
workload running outside and inside a CGroup. The load inside Cgroup is
tagged for core scheduling and happen to be vCPU threads.  Because of this
various folks are complaining.

One of the issues we see is that the core rbtree is static when nothing in
the tree goes to sleep or wakes up. This can cause the same task in the core
rbtree to be repeatedly picked in pick_task().

The below diff seems to improve the situation, could you please take a look?
If it seems sane, we can go ahead and make it a formal patch to at least fix
one of the known issues.

The patch is simple, just remove the currently running task from the core rb
tree as its vruntime is not really static. Add it back on preemption.

note: This is against a 5.4 kernel, but the code is about the same and its RFC.
note: The issue does not seem to happen without CGroups involved so perhaps
      something is wonky in cfs_prio_less() still. Peter?

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c023a9a0c4ae..3c588ad05ab6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -200,7 +200,7 @@ static inline void dump_scrb(struct rb_node *root, int lvl, char *buf, int size)
 	dump_scrb(root->rb_right, lvl+1, buf, size);
 }
 
-static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
+void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
 	struct rb_node *parent, **node;
 	struct task_struct *node_task;
@@ -212,6 +212,9 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 	if (!p->core_cookie)
 		return;
 
+	if (sched_core_enqueued(p))
+		return;
+
 	node = &rq->core_tree.rb_node;
 	parent = *node;
 
@@ -232,7 +235,7 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 	rb_insert_color(&p->core_node, &rq->core_tree);
 }
 
-static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
+void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
@@ -4745,6 +4748,18 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 		return class_pick;
 
 	cookie_pick = sched_core_find(rq, cookie);
+
+	/*
+	 * Currently running process might not be in the runqueue if fair class.
+	 * If it is of the same cookie as cookie_pick and has more priority,
+	 * then select it.
+	 */
+	if (rq != this_rq() && !is_task_rq_idle(cookie_pick) && !is_task_rq_idle(rq->curr) &&
+		cookie_pick->core_cookie == rq->curr->core_cookie &&
+		prio_less(cookie_pick, rq->curr, in_fi)) {
+		cookie_pick = rq->curr;
+	}
+
 	/*
 	 * If class > max && class > cookie, it is the highest priority task on
 	 * the core (so far) and it must be selected, otherwise we must go with
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 86cc67dd38e9..820c5cf4ecc1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1936,15 +1936,33 @@ struct sched_class {
 #endif
 };
 
+void sched_core_enqueue(struct rq *rq, struct task_struct *p);
+void sched_core_dequeue(struct rq *rq, struct task_struct *p);
+
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->curr != prev);
 	prev->sched_class->put_prev_task(rq, prev);
+#ifdef CONFIG_SCHED_CORE
+	if (sched_core_enabled(rq) && READ_ONCE(prev->state) != TASK_DEAD && prev->core_cookie && prev->on_rq) {
+		sched_core_enqueue(rq, prev);
+	}
+#endif
 }
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
 	next->sched_class->set_next_task(rq, next, false);
+#ifdef CONFIG_SCHED_CORE
+	/*
+	 * This task is going to run next and its vruntime will change.
+	 * Remove it from core rbtree so as to not confuse the ordering
+	 * in the rbtree when its vrun changes.
+	 */
+	if (sched_core_enabled(rq) && next->core_cookie && next->on_rq) {
+		sched_core_dequeue(rq, next);
+	}
+#endif
 }
 
 #ifdef CONFIG_SMP
