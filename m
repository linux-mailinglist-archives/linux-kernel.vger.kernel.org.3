Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F094E9AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiC1PT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiC1PTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:19:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678CBBE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KEVI2o2rD3UrOqh8lKO7UOSKAG4YSuE1N9F0wquI240=; b=mz45GIU7h6D1zDQqv44USen4y7
        1qk54CAqNW4WZR5nvOAZ8KkEZakRLvdGNFZbIrOL7BbpZ8T9XtEb+GU09DoZ6BruPGL2Cs8I+VjY1
        G5AG8/ZP+4CP8np0srofJFvphmHhkwgfQcn4sC6Nms/GAo1nyXEnGH4gTaHDCbsv7/wPoXtsA99m9
        EGSaC76FPR7vHNgxDooM6qSMCl8qoPsgaIJP990Sos7zTMcUn7410oQ847bzhbH0pajF9inD46ZDm
        qY8rBUX5DgrGtyQXjegO7h4GQ4WPWCGQXWgCLT5XRAFqeNcu54GXjX01dqw97DOCgKH4gsH9tZu77
        fab2JmdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYr7t-005TZZ-UY; Mon, 28 Mar 2022 15:17:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29A19300237;
        Mon, 28 Mar 2022 17:17:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01BEE323C8DAB; Mon, 28 Mar 2022 17:17:46 +0200 (CEST)
Date:   Mon, 28 Mar 2022 17:17:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [External] Re: [PATCH] sched/fair: fix broken bandwidth control
 with nohz_full
Message-ID: <YkHRmv/OcABIB0wP@hirez.programming.kicks-ass.net>
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
 <20220328132047.GD8939@worktop.programming.kicks-ass.net>
 <c0465b27-328a-1288-fb50-d4c6321c8b4d@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0465b27-328a-1288-fb50-d4c6321c8b4d@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 09:50:05PM +0800, Chengming Zhou wrote:
> On 2022/3/28 21:20, Peter Zijlstra wrote:
> > On Mon, Mar 28, 2022 at 07:07:51PM +0800, Chengming Zhou wrote:
> >> With nohz_full enabled on cpu, the scheduler_tick() will be stopped
> >> when only one CFS task left on rq.
> >>
> >> scheduler_tick()
> >>   task_tick_fair()
> >>     entity_tick()
> >>       update_curr()
> >>         account_cfs_rq_runtime(cfs_rq, delta_exec) --> stopped
> >>
> >> So that running task can't account its runtime periodically, but
> >> the cfs_bandwidth hrtimer still __refill_cfs_bandwidth_runtime()
> >> periodically. Later in one period, the task would account very
> >> big delta_exec, which cause the cfs_rq to be throttled for a
> >> long time.
> >>
> >> There are two solutions for the problem, the first is that we
> >> can check in sched_can_stop_tick() if current task's cfs_rq
> >> have runtime_enabled, in which case we don't stop tick. But
> >> it will make nohz_full almost useless in cloud environment
> >> that every container has the cpu bandwidth control setting.
> > 
> > How is NOHZ_FULL useful in that environment to begin with? If you set
> > bandwidth crap, the expectation is that there is overcommit, which more
> > or less assumes lots of scheduling, presumably VMs or somesuch crud.
> > 
> > So how does NOHZ_FULL make sense?
> 
> Yes, we have scheduled some VMs in cgroups on the host, which
> enabled NOHZ_FULL to reduce the interference of tick to vcpu task
> if it's the only task running on cpu.
> 
> This problem will however throttle it wrongly, even if it hasn't
> used up its quota.
> 
> Do you suggest that we shouldn't stop tick when the current task's
> cfs_rq has runtime_enabled ?

I'm not suggesting anything just yet as I'm not sure I understand things
well enough. I'm just wondering if NOHZ_FULL makes sense for you since
NOHZ_FULL makes system entry/exit so much more expensive.

NOHZ_FULL is for use-cases that 'never' intend to go into the kernel,
your use-case actively relies on going into the kernel. Hence the
confusion.
