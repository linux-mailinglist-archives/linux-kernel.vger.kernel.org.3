Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671785A79D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiHaJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiHaJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:12:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B77CB8F18
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uSatyxHdW1ZXfYFNwFtYi5+/SAgt+jyK+CISFYC7NXk=; b=FsaGAMuF1FEc8EkDql9g5qBFCr
        DCoYGoYDW1KxEGvp/+ua2EEAB/vwYA7cWRmQ10+Uyq6zv6xPih7LdQHfVdX9IQGzqt8HqpeJSGMDE
        MDwvKTYnEszfqJ7q1WhTXDzK6TNU2m6wFJA8wPylQAf99CL4NynYETH756UoN63IbKXoNXdlhgqBS
        v2Wf+HL760jmlEbHyMAgbKhKIME7UmwA1SmPyjfc9Bc/lA0SN+/115kANLjPPBENfdHRzRbrF6R0s
        BkyhrzJFKswhVhKq82DqgJZRIxmAlLs5W0HINaTbD+b1os1qJ2h9UBAIUC3RDQRWM71DXZ6rPIBDm
        TLpHidwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTJlp-0087Es-Ra; Wed, 31 Aug 2022 09:12:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEE36300137;
        Wed, 31 Aug 2022 11:12:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8389120A3C652; Wed, 31 Aug 2022 11:12:23 +0200 (CEST)
Date:   Wed, 31 Aug 2022 11:12:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v6 2/5] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Message-ID: <Yw8l9zhKxgUM0ulc@hirez.programming.kicks-ass.net>
References: <20220826010119.1265764-1-longman@redhat.com>
 <20220826010119.1265764-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826010119.1265764-3-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:01:16PM -0400, Waiman Long wrote:


>  void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
>  {
> -	struct cpumask *user_mask = p->user_cpus_ptr;
> -	unsigned long flags;
> -
>  	/*
> -	 * Try to restore the old affinity mask. If this fails, then
> -	 * we free the mask explicitly to avoid it being inherited across
> -	 * a subsequent fork().
> +	 * Try to restore the old affinity mask with __sched_setaffinity().
> +	 * Cpuset masking will be done there too.
>  	 */
> -	if (!user_mask || !__sched_setaffinity(p, user_mask))
> -		return;
> -
> -	raw_spin_lock_irqsave(&p->pi_lock, flags);
> -	user_mask = clear_user_cpus_ptr(p);
> -	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> -
> -	kfree(user_mask);
> +	__sched_setaffinity(p, task_user_cpus(p), false);
>  }

We have an issue with __sched_setaffinity() failing here. I'm not sure
ignoring the failure is the right thing -- but I'm also not enturely
sure what is.

>  void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
> @@ -8081,10 +8046,11 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
>  #endif
>  
>  static int
> -__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
> +__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save_mask)
>  {
>  	int retval;
>  	cpumask_var_t cpus_allowed, new_mask;
> +	struct cpumask *user_mask = NULL;
>  
>  	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
>  		return -ENOMEM;
> @@ -8100,8 +8066,22 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
>  	retval = dl_task_check_affinity(p, new_mask);
>  	if (retval)
>  		goto out_free_new_mask;
> +
> +	/*
> +	 * Save the user requested mask internally now and then update
> +	 * user_cpus_ptr later after making sure this call will be
> +	 * successful, i.e. retval == 0.
> +	 */
> +	if (save_mask) {
> +		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> +		if (!user_mask) {
> +			retval = -ENOMEM;
> +			goto out_free_new_mask;
> +		}
> +		cpumask_copy(user_mask, mask);
> +	}
>  again:
> -	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
> +	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
>  	if (retval)
>  		goto out_free_new_mask;
>  
> @@ -8115,7 +8095,16 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
>  		goto again;
>  	}
>  
> +	if (save_mask) {
> +		unsigned long flags;
> +
> +		/* Use pi_lock to synchronize changes to user_cpus_ptr */
> +		raw_spin_lock_irqsave(&p->pi_lock, flags);
> +		swap(p->user_cpus_ptr, user_mask);
> +		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> +	}
>  out_free_new_mask:
> +	kfree(user_mask);
>  	free_cpumask_var(new_mask);
>  out_free_cpus_allowed:
>  	free_cpumask_var(cpus_allowed);

I'm confused as to why it's put in this function and not in the one
caller that actually sets the new @save_mask true, here:

> @@ -8158,7 +8147,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>  	if (retval)
>  		goto out_put_task;
>  
> -	retval = __sched_setaffinity(p, in_mask);
> +	retval = __sched_setaffinity(p, in_mask, true);
>  out_put_task:
>  	put_task_struct(p);
>  	return retval;


