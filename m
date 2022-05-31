Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C4F5392D1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345028AbiEaN4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244883AbiEaNzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:55:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C9BF4A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:55:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4DF151F8DD;
        Tue, 31 May 2022 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654005340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96gdteDUzSXFaiw09TQyKSUZDnPxYQyobsN4KOocFTk=;
        b=PMZMDaoh4qTi0nLBENfogSINZwWs9wqI9DUnKLBQvZamYwh0Gsz8oJWstflVQQkLfdGSxG
        UXDV1cCwBCSh5Ge4OLDY4zBEpc9Gy2nOg1yLr3HhwszIZv5UOOxc8UsfgXOy6RXzgAEd56
        +D0keGdLGQ/JbUEuUnlDD4GqqYftUKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654005340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96gdteDUzSXFaiw09TQyKSUZDnPxYQyobsN4KOocFTk=;
        b=38jtTiD6i28XAslPQXj7FGYto/UUW6DB9mMPmGIMiNxMO+qSaJm405kkSPgoTnwOtGFf6/
        f/Md3FTv6QFbx1Bw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6D9242C141;
        Tue, 31 May 2022 13:55:39 +0000 (UTC)
Date:   Tue, 31 May 2022 14:55:32 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Queue task on wakelist in the same llc if the
 wakee cpu is idle
Message-ID: <20220531135532.GA3332@suse.de>
References: <20220527090544.527411-1-dtcccc@linux.alibaba.com>
 <xhsmhleuj7zve.mognet@vschneid.remote.csb>
 <1d0eb8f4-e474-86a9-751a-7c2e1788df85@linux.alibaba.com>
 <xhsmhilpl9azq.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <xhsmhilpl9azq.mognet@vschneid.remote.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 12:50:49PM +0100, Valentin Schneider wrote:
> >> With all that in mind, I'm curious whether your patch is functionaly close
> >> to the below.
> >> 
> >> ---
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index 66c4e5922fe1..ffd43264722a 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -3836,7 +3836,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
> >>   	 * the soon-to-be-idle CPU as the current CPU is likely busy.
> >>   	 * nr_running is checked to avoid unnecessary task stacking.
> >>   	 */
> >> -	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
> >> +	if (cpu_rq(cpu)->nr_running <= 1)
> >>   		return true;
> >>   
> >>   	return false;
> >
> > It's a little different. This may bring extra IPIs when nr_running == 1 
> > and the current task on wakee cpu is not the target wakeup task (i.e., 
> > rq->curr == another_task && rq->curr != p). Then this another_task may 
> > be disturbed by IPI which is not expected. So IMO the promise by 
> > WF_ON_CPU is necessary.
> 
> You're right, actually taking a second look at that WF_ON_CPU path,
> shouldn't the existing condition be:
> 
> 	if ((wake_flags & WF_ON_CPU) && !cpu_rq(cpu)->nr_running)
> 
> ? Per the p->on_rq and p->on_cpu ordering, if we have WF_ON_CPU here then
> we must have !p->on_rq, so the deactivate has happened, thus the task
> being alone on the rq implies nr_running==0.
> 
> @Mel, do you remember why you went for <=1 here? I couldn't find any clues
> on the original posting.
> 

I don't recall exactly why I went with <= 1 there but I may not have
considered the memory ordering of on_rq and nr_running and the comment
above it is literally what I was thinking at the time. I think you're
right and that check can be !cpu_rq(cpu)->nr_running.

-- 
Mel Gorman
SUSE Labs
