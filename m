Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BB74D5182
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245438AbiCJS20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbiCJS2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:28:25 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DED15879D;
        Thu, 10 Mar 2022 10:27:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g17so10969977lfh.2;
        Thu, 10 Mar 2022 10:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P6oWdxh9V+xLTQuoPpvAfo4h7fMG+CWSaFZ8smjaHug=;
        b=Jvll4mGLapG3jwa2+jNblG4oFFQDzO5VVEnNYfdbeNdQV5j7iauHT0iRQ1lxw8NHu5
         mivegElAAw2khUuTLjcZk2fWnj9nU8OJ0GMculAsFETExAPBnPPyDdMmAKwOcCwnaln4
         QD2TNkwgAnAIjwUpAyNuWED6rlyyflj4Y/Ewdz6DfAnE7353zP3rqqWRvoQSOprsjkY8
         f6kllS78dQdXEHzG51WCueQFWMWFCsjsbjyuOPImiuVp2Nkf6RrE3p8OfRQxxMeFt/SM
         EmcUAaNI79qkbZjI2kSKB1RCCoT/PfosASo7Fz/WHeC/3x4WPZ6eANIwZ+B4X6ca6Jsi
         kZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P6oWdxh9V+xLTQuoPpvAfo4h7fMG+CWSaFZ8smjaHug=;
        b=ZmXrEfVlalPXjXR+NCZb3SUUK2mTiLsyzjal7qwhu33pG8BkRYkKgW/c3M9BlsDAsD
         1das0HeWFnXjVJuYcxdHfM3BqZfoS5JejvAOXhW45rkHdxYznFt45x4MEfNFsR/aMZ7N
         qSF07RTGiHc3R5mWqAUwjn9ARKt+wn1nS6DfVrTFvo/ZZ2K190+HWf1rZjmX7YsxoT/S
         KSAfwLf/dwDwkT/PobQPjfHwcq+dABZsyY0SyXkvROuXzXTFEOgQiMVAoJ3pDWTu29ZL
         E0voOCNojlbQiRfh2pE9MM+tC5TKCHlN3aX8M2OiScKayJIypY9piin5Utdk9fCrxjR4
         JYAg==
X-Gm-Message-State: AOAM531cjfGKwSN1EODgOH6z4otsTpYk058fYzpq4ohR2HMJYZatnhxB
        uXIpEojq0JpNMtkmpv1UiDs=
X-Google-Smtp-Source: ABdhPJyzdEEm0fhrVQgGGALV/Oh0tMWxpJRM1wQEILjLYiSbYAxD/LTMYOk7pKzAEPhNvLeIHawb4Q==
X-Received: by 2002:a05:6512:c13:b0:448:62ce:2dff with SMTP id z19-20020a0565120c1300b0044862ce2dffmr2351443lfu.141.1646936842222;
        Thu, 10 Mar 2022 10:27:22 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id a15-20020ac2520f000000b00445bcfca45fsm1110941lfl.248.2022.03.10.10.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:27:21 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 10 Mar 2022 19:27:19 +0100
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, urezki@gmail.com, bigeasy@linutronix.de,
        juri.lelli@redhat.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Message-ID: <YipDBx137UdsieWV@pc638.lan>
References: <20220309081523.348450-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309081523.348450-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When RCU_BOOST is enabled, the boost kthreads will boosting readers
> who are blocking a given grace period, if the current reader tasks
> have a higher priority than boost kthreads(the boost kthreads priority
> not always 1, if the kthread_prio is set), boosting is useless, skip
> current task and select next task to boosting, reduce the time for a
> given grace period.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  v1->v2:
>  rename label 'end' to 'skip_boost'.
>  add 'boost_exp_tasks' pointer to point 'rnp->exp_tasks'
>  do the similar thing as normal grace period.
> 
>  kernel/rcu/tree.h        |  2 ++
>  kernel/rcu/tree_plugin.h | 31 +++++++++++++++++++++++--------
>  2 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index b8d07bf92d29..862ca09b56c7 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -103,6 +103,8 @@ struct rcu_node {
>  				/*  queued on this rcu_node structure that */
>  				/*  are blocking the current grace period, */
>  				/*  there can be no such task. */
> +	struct list_head *boost_exp_tasks;
> +
>  	struct rt_mutex boost_mtx;
>  				/* Used only for the priority-boosting */
>  				/*  side effect, not as a lock. */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c3d212bc5338..22bf5a8040f5 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -12,6 +12,7 @@
>   */
>  
>  #include "../locking/rtmutex_common.h"
> +#include <linux/sched/deadline.h>
>  
>  static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>  {
> @@ -535,6 +536,8 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  			drop_boost_mutex = rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t;
>  			if (&t->rcu_node_entry == rnp->boost_tasks)
>  				WRITE_ONCE(rnp->boost_tasks, np);
> +			if (&t->rcu_node_entry == rnp->boost_exp_tasks)
> +				WRITE_ONCE(rnp->boost_exp_tasks, np);
>  		}
>  
>  		/*
> @@ -1022,7 +1025,7 @@ static int rcu_boost(struct rcu_node *rnp)
>  	struct task_struct *t;
>  	struct list_head *tb;
>  
> -	if (READ_ONCE(rnp->exp_tasks) == NULL &&
> +	if (READ_ONCE(rnp->boost_exp_tasks) == NULL &&
>  	    READ_ONCE(rnp->boost_tasks) == NULL)
>  		return 0;  /* Nothing left to boost. */
>  
> @@ -1032,7 +1035,7 @@ static int rcu_boost(struct rcu_node *rnp)
>  	 * Recheck under the lock: all tasks in need of boosting
>  	 * might exit their RCU read-side critical sections on their own.
>  	 */
> -	if (rnp->exp_tasks == NULL && rnp->boost_tasks == NULL) {
> +	if (rnp->boost_exp_tasks == NULL && rnp->boost_tasks == NULL) {
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  		return 0;
>  	}
> @@ -1043,8 +1046,8 @@ static int rcu_boost(struct rcu_node *rnp)
>  	 * expedited grace period must boost all blocked tasks, including
>  	 * those blocking the pre-existing normal grace period.
>  	 */
> -	if (rnp->exp_tasks != NULL)
> -		tb = rnp->exp_tasks;
> +	if (rnp->boost_exp_tasks != NULL)
> +		tb = rnp->boost_exp_tasks;
>  	else
>  		tb = rnp->boost_tasks;
>  
> @@ -1065,14 +1068,24 @@ static int rcu_boost(struct rcu_node *rnp)
>  	 * section.
>  	 */
>  	t = container_of(tb, struct task_struct, rcu_node_entry);
> +	if (dl_task(t) || t->prio <= current->prio) {
This is a bit confusing to me. We know that "current" has SCHED_FIFO
class. In this scenario if "t->prio" has lower value(higher priority)
the task falls into all real-time categories anyway and is either:
  - SCHED_FIFO
  - SCHED_RR
  - SCHED_DEADLINE

Checking whether the task is dl_task() sounds like unnecessary there.
Am i missing something? Could you please comment on it?

Thanks!

--
Vlad Rezki
