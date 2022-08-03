Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C409758860B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiHCDkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHCDkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:40:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF221A058
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 20:40:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y15so15222969plp.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 20:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7xVJF7vR0wX/5mAROXvNNoi/mKcsTfV49jK3gwUNAMk=;
        b=TextKI8CwMWIRF1ypuDvqpcgxaJua8ZPD05iRC2mUjiernXyc/EPTKjKBnzLEpPWEf
         LH8dHk3yA7lk1lRrQX1wMRr7jwzcMmA31zWvZ0J1hzAp9PFjLoAVxoF6gxclwM37is/U
         pyTxb2VSkImHi32ZtgjuJNX+dApET4GhNFdwzkFjuU5WKCtKVFlV78PwTEQ88dOQvhr9
         HiKqWvg5PkCGXWcDTPqEPkuofbdCji7zVWhXZbwmT5ymYSSAVxFEw+TzawIXnbO57FHb
         CrVpAZLOmrbfRDYZNILtDYkrygmJOuIkvK9BhtFtA12W/QjM06VL1krqbAD9EULRc/a2
         TYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7xVJF7vR0wX/5mAROXvNNoi/mKcsTfV49jK3gwUNAMk=;
        b=0/rV1N8jsXut4i4RJX2LwPT4oR8J8FPSP0r1yElYODUdKJxuyCDCNnQ1ttAEttXvO+
         HEVDa8S0lnP0hOB6dxpG2pYGhthglfNaLlWsyc6PlkSBuzihE2mbuoEqCtdZI4AvZXad
         y4OAUK69OZ4vcxpSwvrr7Lv6rUCs54Zcle1giJ/gG2HknhTrnESTO24HIxrqF/rMqdyB
         rhfRdGjL8JJ+LtDkX8d8UyWnVZdaTh/gWZYUSB6d/k7Js3Poflvs0loI9WXbmRayNk6G
         rFpTDj4ZWf8APZRd1JYmh7Sj9VydxmOXLgWK90dQdOuOYfuxSkxLrOOzfkVuAY/p4aAo
         MqBw==
X-Gm-Message-State: ACgBeo1OvzlwQY8ObnVsl/OPor99IJzpkTkus2fNoxhjP7UJ5mUzptFx
        OZSWvzUFQ2sz0pP8nmETfu8=
X-Google-Smtp-Source: AA6agR4XNG4CFu/JA4SzvJWK1JNKM0UXiGBUJ30/FJFKqFIXBBY6SGivlOdwcKGPqaPf1tpG3mkerw==
X-Received: by 2002:a17:902:eb8a:b0:16d:c75a:c40b with SMTP id q10-20020a170902eb8a00b0016dc75ac40bmr24930956plg.102.1659498033620;
        Tue, 02 Aug 2022 20:40:33 -0700 (PDT)
Received: from [30.46.241.238] ([47.246.98.190])
        by smtp.gmail.com with ESMTPSA id g19-20020a170902d1d300b0016be5f24aaesm499996plb.163.2022.08.02.20.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 20:40:33 -0700 (PDT)
Message-ID: <c13c3fb4-4936-a5fd-cd28-1136d07d5f54@gmail.com>
Date:   Wed, 3 Aug 2022 11:40:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v3 1/3] workqueue: Hold wq_pool_mutex while affining
 tasks to wq_unbound_cpumask
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <20220802084146.3922640-1-vschneid@redhat.com>
 <20220802084146.3922640-2-vschneid@redhat.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
In-Reply-To: <20220802084146.3922640-2-vschneid@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/2 16:41, Valentin Schneider wrote:
> When unbind_workers() reads wq_unbound_cpumask to set the affinity of
> freshly-unbound kworkers, it only holds wq_pool_attach_mutex. This isn't
> sufficient as wq_unbound_cpumask is only protected by wq_pool_mutex.
> 
> This is made more obvious as of recent commit
> 
>    46a4d679ef88 ("workqueue: Avoid a false warning in unbind_workers()")
> 
> e.g.
> 
> unbind_workers()                             workqueue_set_unbound_cpumask()
>    kthread_set_per_cpu(p, -1);
>    if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
> 					       cpumask_copy(wq_unbound_cpumask, cpumask);
>      WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
> 
> Make workqueue_offline_cpu() invoke unbind_workers() with wq_pool_mutex
> held.

I would prefer to protect wq_unbound_cpumask with wq_pool_attach_mutex.

 From df7b4672db4dfd3e480b1873b9d346e8a7dfc69f Mon Sep 17 00:00:00 2001
From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Date: Wed, 3 Aug 2022 10:52:04 +0800
Subject: [PATCH] workqueue: Protects wq_unbound_cpumask with
  wq_pool_attach_mutex

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


