Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5809159861B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245380AbiHROeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbiHROdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:33:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F2615B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:33:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id jl18so1673646plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HWbE7nxZeJfwuUY4/XEf3Ajumi8SbFWH/E//uWxRMRk=;
        b=Nsv++hAy8IrMXCMq87Hq/hpcGfzZuDbUYXdVlghQxsvD2nbwj/pVQGDWMhrSYB1F+s
         17ESjKPJtLXZvx8UlEvPxcQba7mCGCe7LXo9pH0Ey2rNib0nszA7AsuahEqdplajRGn5
         BDh/cVQ2MdxrUSnN6wstN/D3WsDUcOLwqjhvnsJxKN4jflP5Dp7P/wDa+PCFVgftVJCn
         7atFwwLD25tngmjB8eRvcnZj9e0v047mxVeTotXgl6Pgv6ESlz1vS7HH/O63Q5vYqBEP
         nvqjh6fgoyEVfXVyVhMngzfO1zvaEAinSYBBdKLLlm907jD0m8ewP7utuK3ORaRCtz7Y
         uVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HWbE7nxZeJfwuUY4/XEf3Ajumi8SbFWH/E//uWxRMRk=;
        b=YOiqV6S1m0oYu3tXzKQBaCZkxd+ZsJRuIwHLi+Tl4i8D2PoUBH0lQ+6KE5c1sl/51k
         YOQHMEyahRELxxLeWshiR3u0PYkDQ1lUw2TOnFpKrdXqKDJUQdoRcohSetzUlG35rove
         lHf0x9ftsJLJoEA/XC/RxWjFBOJiHI+g/5DW+uoVm6VvLnG5uTsuYj6qwHly9AzCO0aC
         ubnPjo7VZ/65fuat2hJESBZR/glb/V7PzyIuvvFdbim1O9KJQIcLf1t0GduLZQ1urJf3
         jKmZfmolbc6OZPhGNs2bnTANqVh1bfB6Il3LSi51BfoAhUFWdqpEw7CmyoY846vlfaO3
         VK4w==
X-Gm-Message-State: ACgBeo37AxbvIkDRRU8kn5PVOQVCCMFTy1pzHLx+MNlQ/9VLkcOmcivM
        iAcemMjgVMCMLKqSyk/hyhfbVKmHF+E=
X-Google-Smtp-Source: AA6agR4FCAIdQjEMiMPXrkeI8t5hIHNBuNjBM94q6/QZSDKUd5Xxur5uWgJjNmGXLKrVHUU99X5dpQ==
X-Received: by 2002:a17:902:7602:b0:172:a064:4a2f with SMTP id k2-20020a170902760200b00172a0644a2fmr3060577pll.56.1660833199426;
        Thu, 18 Aug 2022 07:33:19 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id r5-20020a63ce45000000b00429f6579d81sm1384444pgi.29.2022.08.18.07.33.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2022 07:33:18 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Subject: [PATCH] workqueue: Protects wq_unbound_cpumask with wq_pool_attach_mutex
Date:   Thu, 18 Aug 2022 22:33:48 +0800
Message-Id: <20220818143348.1134136-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <Yvrb3hfZuUzSpX5e@slm.duckdns.org>
References: <Yvrb3hfZuUzSpX5e@slm.duckdns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

When unbind_workers() reads wq_unbound_cpumask to set the affinity of
freshly-unbound kworkers, it only holds wq_pool_attach_mutex. This isn't
sufficient as wq_unbound_cpumask is only protected by wq_pool_mutex.

Make wq_unbound_cpumask protected with wq_pool_attach_mutex and also
remove the need of temporary saved_cpumask.

Fixes: 10a5a651e3af ("workqueue: Restrict kworker in the offline CPU pool running on housekeeping CPUs")
Reported-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6b2b66940530..eaea73e7e365 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -327,7 +327,7 @@ static struct rcuwait manager_wait = __RCUWAIT_INITIALIZER(manager_wait);
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
 
-/* PL: allowable cpus for unbound wqs and work items */
+/* PL&A: allowable cpus for unbound wqs and work items */
 static cpumask_var_t wq_unbound_cpumask;
 
 /* CPU where unbound work was last round robin scheduled from this CPU */
@@ -3933,7 +3933,8 @@ static void apply_wqattrs_cleanup(struct apply_wqattrs_ctx *ctx)
 /* allocate the attrs and pwqs for later installation */
 static struct apply_wqattrs_ctx *
 apply_wqattrs_prepare(struct workqueue_struct *wq,
-		      const struct workqueue_attrs *attrs)
+		      const struct workqueue_attrs *attrs,
+		      const cpumask_var_t unbound_cpumask)
 {
 	struct apply_wqattrs_ctx *ctx;
 	struct workqueue_attrs *new_attrs, *tmp_attrs;
@@ -3949,14 +3950,15 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 		goto out_free;
 
 	/*
-	 * Calculate the attrs of the default pwq.
+	 * Calculate the attrs of the default pwq with unbound_cpumask
+	 * which is wq_unbound_cpumask or to set to wq_unbound_cpumask.
 	 * If the user configured cpumask doesn't overlap with the
 	 * wq_unbound_cpumask, we fallback to the wq_unbound_cpumask.
 	 */
 	copy_workqueue_attrs(new_attrs, attrs);
-	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, wq_unbound_cpumask);
+	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, unbound_cpumask);
 	if (unlikely(cpumask_empty(new_attrs->cpumask)))
-		cpumask_copy(new_attrs->cpumask, wq_unbound_cpumask);
+		cpumask_copy(new_attrs->cpumask, unbound_cpumask);
 
 	/*
 	 * We may create multiple pwqs with differing cpumasks.  Make a
@@ -4053,7 +4055,7 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 		wq->flags &= ~__WQ_ORDERED;
 	}
 
-	ctx = apply_wqattrs_prepare(wq, attrs);
+	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -5311,7 +5313,7 @@ void thaw_workqueues(void)
 }
 #endif /* CONFIG_FREEZER */
 
-static int workqueue_apply_unbound_cpumask(void)
+static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 {
 	LIST_HEAD(ctxs);
 	int ret = 0;
@@ -5327,7 +5329,7 @@ static int workqueue_apply_unbound_cpumask(void)
 		if (wq->flags & __WQ_ORDERED)
 			continue;
 
-		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs);
+		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs, unbound_cpumask);
 		if (!ctx) {
 			ret = -ENOMEM;
 			break;
@@ -5342,6 +5344,11 @@ static int workqueue_apply_unbound_cpumask(void)
 		apply_wqattrs_cleanup(ctx);
 	}
 
+	if (!ret) {
+		mutex_lock(&wq_pool_attach_mutex);
+		cpumask_copy(wq_unbound_cpumask, unbound_cpumask);
+		mutex_unlock(&wq_pool_attach_mutex);
+	}
 	return ret;
 }
 
@@ -5360,7 +5367,6 @@ static int workqueue_apply_unbound_cpumask(void)
 int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 {
 	int ret = -EINVAL;
-	cpumask_var_t saved_cpumask;
 
 	/*
 	 * Not excluding isolated cpus on purpose.
@@ -5374,23 +5380,8 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 			goto out_unlock;
 		}
 
-		if (!zalloc_cpumask_var(&saved_cpumask, GFP_KERNEL)) {
-			ret = -ENOMEM;
-			goto out_unlock;
-		}
-
-		/* save the old wq_unbound_cpumask. */
-		cpumask_copy(saved_cpumask, wq_unbound_cpumask);
-
-		/* update wq_unbound_cpumask at first and apply it to wqs. */
-		cpumask_copy(wq_unbound_cpumask, cpumask);
-		ret = workqueue_apply_unbound_cpumask();
-
-		/* restore the wq_unbound_cpumask when failed. */
-		if (ret < 0)
-			cpumask_copy(wq_unbound_cpumask, saved_cpumask);
+		ret = workqueue_apply_unbound_cpumask(cpumask);
 
-		free_cpumask_var(saved_cpumask);
 out_unlock:
 		apply_wqattrs_unlock();
 	}
-- 
2.19.1.6.gb485710b

