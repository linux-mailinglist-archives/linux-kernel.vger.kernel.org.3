Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECAA4876C5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347226AbiAGLty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbiAGLtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:49:53 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800F7C061245;
        Fri,  7 Jan 2022 03:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=DBw/yxgkvw2Kf7vhLp4FcogOKyh2cchQam1f9G18PGg=; b=kOuwZ
        rWvV2p2OgeZwCFNQJQPxkmu8WhWcubSfQ8KVtEvseu4O+GGl9oAREjqYzlyyst3Kh90lU9rLaHXnS
        4/KUhbupU/eCvM/D2g3rcsAniIW6Sn3PIP668vEKtGe/4TGOjKiXJdbjUXh5TWChfDggeqqwcK6Nb
        qr9S7qR1R42trU2lSwn9O2j+IeWufNwyowxUmbFgZDJohdoPrluKl0/x9nAdv4r9Y1dM2f8QzFRQJ
        rCB7MogGTsyUrIpzr/53asHuCoH5GEf/mPgI0qbejILaMULHipUO6tW0vtaq93GxtXWJELaxUk0By
        QzPReYW1OI7TQGTNXdnVfVbDTcPug==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1n5nki-0006Nq-5S; Fri, 07 Jan 2022 11:49:48 +0000
Date:   Fri, 7 Jan 2022 11:49:46 +0000
From:   John Keeping <john@metanate.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RT] BUG in sched/cpupri.c
Message-ID: <Ydgo2lENzywieaZL@donbot>
References: <Yb3vXx3DcqVOi+EA@donbot>
 <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com>
 <87zgou6iq1.mognet@arm.com>
 <20211221164528.3c84543f.john@metanate.com>
 <31a47e99-6de3-76ec-62ad-9c98d092ead5@arm.com>
 <87r1a4775a.mognet@arm.com>
 <f2d50e78-dc7b-6851-f12e-d702fbfea826@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2d50e78-dc7b-6851-f12e-d702fbfea826@arm.com>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 11:46:45AM +0100, Dietmar Eggemann wrote:
> On 22/12/2021 20:48, Valentin Schneider wrote:
> >  /*
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index ef8228d19382..8f3e3a1367b6 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1890,6 +1890,16 @@ static int push_rt_task(struct rq *rq, bool pull)
> >  	if (!next_task)
> >  		return 0;
> >  
> > +	/*
> > +	 * It's possible that the next_task slipped in of higher priority than
> > +	 * current, or current has *just* changed priority.  If that's the case
> > +	 * just reschedule current.
> > +	 */
> > +	if (unlikely(next_task->prio < rq->curr->prio)) {
> > +		resched_curr(rq);
> > +		return 0;
> > +	}
> 
> IMHO, that's the bit which prevents the BUG.
> 
> But this would also prevent the case in which rq->curr is an RT task
> with lower prio than next_task.
> 
> Also `rq->curr = migration/X` goes still though which is somehow fine
> since find_lowest_rq() bails out for if (task->nr_cpus_allowed == 1).
> 
> And DL tasks (like sugov:X go through and they can have
> task->nr_cpus_allowed > 1 (arm64 slow-switching boards with shared
> freuency domains with schedutil). cpupri_find_fitness()->convert_prio()
> can handle  task_pri, p->prio = -1 (CPUPRI_INVALID) although its somehow
> by coincidence.
> 
> So maybe something like this:

Do you mean to replace just the one hunk from Valentin's patch with the
change below (keeping the rest), or are you saying that only the change
below is needed?

> @ -1898,6 +1898,11 @@ static int push_rt_task(struct rq *rq, bool pull)
>                 if (!pull || rq->push_busy)
>                         return 0;
> 
> +               if (rq->curr->sched_class != &rt_sched_class) {
> +                       resched_curr(rq);
> +                       return 0;
> +               }
> +
>                 cpu = find_lowest_rq(rq->curr);
> 
> [...]
