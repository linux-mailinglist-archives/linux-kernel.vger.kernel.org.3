Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4084CE190
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 01:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiCEAgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 19:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiCEAgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:36:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E49E259F5E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 16:35:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1953CB82C6D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 00:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604A8C340E9;
        Sat,  5 Mar 2022 00:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646440555;
        bh=mwjsS+YMGajXXQMaUkaiH/3MXku41Jx+TRuzkQ6Y6Jg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e8ct/L1e1A16OfW/iQ8Zgh+spt2H9t+3S0zaHsjY0h00LqO852i10s5evccJvhiLF
         UONEs4TjVYWKHIagAmMk1b5Sh97NXXUgx8gKFFLTGu56sjbSKAJ4uD0Kf2+1Aj4fE6
         9f3S2dNGVFnHOvAZ89DsE/iV3Wl33YhneVHDRfnw=
Date:   Fri, 4 Mar 2022 16:35:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch v4] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Message-Id: <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
In-Reply-To: <YiI+a9gTr/UBCf0X@fuller.cnet>
References: <YhUI1wUtV8yguijO@fuller.cnet>
        <YhUKRzEKxMvlGQ5n@fuller.cnet>
        <YiI+a9gTr/UBCf0X@fuller.cnet>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 13:29:31 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:

>  
> On systems that run FIFO:1 applications that busy loop 
> on isolated CPUs, executing tasks on such CPUs under
> lower priority is undesired (since that will either
> hang the system, or cause longer interruption to the
> FIFO task due to execution of lower priority task 
> with very small sched slices).
> 
> Commit d479960e44f27e0e52ba31b21740b703c538027c ("mm: disable LRU 
> pagevec during the migration temporarily") relies on 
> queueing work items on all online CPUs to ensure visibility
> of lru_disable_count.
> 
> However, its possible to use synchronize_rcu which will provide the same
> guarantees (see comment this patch modifies on lru_cache_disable).
> 
> Fixes:
> 
> ...
>
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -831,8 +831,7 @@ inline void __lru_add_drain_all(bool force_all_cpus)
>  	for_each_online_cpu(cpu) {
>  		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
>  
> -		if (force_all_cpus ||
> -		    pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
> +		if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||

Please changelog this alteration?

>  		    data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
>  		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
>  		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
> @@ -876,15 +875,21 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
>  void lru_cache_disable(void)
>  {
>  	atomic_inc(&lru_disable_count);
> -#ifdef CONFIG_SMP
>  	/*
> -	 * lru_add_drain_all in the force mode will schedule draining on
> -	 * all online CPUs so any calls of lru_cache_disabled wrapped by
> -	 * local_lock or preemption disabled would be ordered by that.
> -	 * The atomic operation doesn't need to have stronger ordering
> -	 * requirements because that is enforced by the scheduling
> -	 * guarantees.
> +	 * Readers of lru_disable_count are protected by either disabling
> +	 * preemption or rcu_read_lock:
> +	 *
> +	 * preempt_disable, local_irq_disable  [bh_lru_lock()]
> +	 * rcu_read_lock		       [rt_spin_lock CONFIG_PREEMPT_RT]
> +	 * preempt_disable		       [local_lock !CONFIG_PREEMPT_RT]
> +	 *
> +	 * Since v5.1 kernel, synchronize_rcu() is guaranteed to wait on
> +	 * preempt_disable() regions of code. So any CPU which sees
> +	 * lru_disable_count = 0 will have exited the critical
> +	 * section when synchronize_rcu() returns.
>  	 */
> +	synchronize_rcu();
> +#ifdef CONFIG_SMP
>  	__lru_add_drain_all(true);
>  #else
>  	lru_add_and_bh_lrus_drain();
