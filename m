Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0193E57BD43
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbiGTRzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiGTRy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A786D6249D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658339696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsljpx5tQYboF5VldKkSEi+SbopMz0UZBpL6h+XO8gs=;
        b=NHIqrfsO0Q2Ep0guFWUPJti9PyILf1MmNntDqfHTmi9BMWg4RRh1WtSBnyr848Efb6Fky8
        2EFD2//uiexmLc3W2KTxGI0QAU0cu0wV2wAcP2Qhd3JsiY30SsUZUJ0hoU0qGX3UOCc3pQ
        FF+PFQT4WTzUy1sQu5y1ChdXu6GbrR0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-33phez4DOQia0Y4TSSYSeQ-1; Wed, 20 Jul 2022 13:54:51 -0400
X-MC-Unique: 33phez4DOQia0Y4TSSYSeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6962F29ABA0A;
        Wed, 20 Jul 2022 17:54:51 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F7881121314;
        Wed, 20 Jul 2022 17:54:51 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 40CE5416CD79; Wed, 20 Jul 2022 14:54:32 -0300 (-03)
Date:   Wed, 20 Jul 2022 14:54:32 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] workqueue: Unbind workers before sending them to
 exit()
Message-ID: <YthBWNEYpaVnLfet@fuller.cnet>
References: <20220719165743.3409313-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719165743.3409313-1-vschneid@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 05:57:43PM +0100, Valentin Schneider wrote:
> It has been reported that isolated CPUs can suffer from interference due to
> per-CPU kworkers waking up just to die.
> 
> A surge of workqueue activity (sleeping workfn's exacerbate this) during
> initial setup can cause extra per-CPU kworkers to be spawned. Then, a
> latency-sensitive task can be running merrily on an isolated CPU only to be
> interrupted sometime later by a kworker marked for death (cf.
> IDLE_WORKER_TIMEOUT, 5 minutes after last kworker activity).
> 
> Affine kworkers to the wq_unbound_cpumask (which doesn't contain isolated
> CPUs, cf. HK_TYPE_WQ) before waking them up after marking them with
> WORKER_DIE.
> 
> This follows the logic of CPU hot-unplug, which has been packaged into
> helpers for the occasion.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/workqueue.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 1ea50f6be843..0f1a25ea4924 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1972,6 +1972,18 @@ static struct worker *create_worker(struct worker_pool *pool)
>  	return NULL;
>  }
>  
> +static void unbind_worker(struct worker *worker)
> +{
> +	kthread_set_per_cpu(worker->task, -1);
> +	WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
> +}
> +
> +static void rebind_worker(struct worker *worker, struct worker_pool *pool)
> +{
> +	kthread_set_per_cpu(worker->task, pool->cpu);
> +	WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
> +}
> +
>  /**
>   * destroy_worker - destroy a workqueue worker
>   * @worker: worker to be destroyed
> @@ -1999,6 +2011,16 @@ static void destroy_worker(struct worker *worker)
>  
>  	list_del_init(&worker->entry);
>  	worker->flags |= WORKER_DIE;
> +
> +	/*
> +	 * We're sending that thread off to die, so any CPU would do. This is
> +	 * especially relevant for pcpu kworkers affined to an isolated CPU:
> +	 * we'd rather not interrupt an isolated CPU just for a kworker to
> +	 * do_exit().
> +	 */
> +	if (!(worker->flags & WORKER_UNBOUND))
> +		unbind_worker(worker);
> +
>  	wake_up_process(worker->task);
>  }
>  
> @@ -4999,10 +5021,8 @@ static void unbind_workers(int cpu)
>  
>  		raw_spin_unlock_irq(&pool->lock);
>  
> -		for_each_pool_worker(worker, pool) {
> -			kthread_set_per_cpu(worker->task, -1);
> -			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
> -		}
> +		for_each_pool_worker(worker, pool)
> +			unbind_worker(worker);
>  
>  		mutex_unlock(&wq_pool_attach_mutex);
>  	}
> @@ -5027,11 +5047,8 @@ static void rebind_workers(struct worker_pool *pool)
>  	 * of all workers first and then clear UNBOUND.  As we're called
>  	 * from CPU_ONLINE, the following shouldn't fail.
>  	 */
> -	for_each_pool_worker(worker, pool) {
> -		kthread_set_per_cpu(worker->task, pool->cpu);
> -		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> -						  pool->attrs->cpumask) < 0);
> -	}
> +	for_each_pool_worker(worker, pool)
> +		rebind_worker(worker, pool);
>  
>  	raw_spin_lock_irq(&pool->lock);
>  
> -- 
> 2.31.1
> 
> 

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>

