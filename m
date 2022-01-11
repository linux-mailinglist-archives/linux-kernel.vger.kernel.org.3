Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB7448A79E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347381AbiAKGKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:10:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43426 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiAKGKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:10:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C93614DA;
        Tue, 11 Jan 2022 06:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363AAC36AE3;
        Tue, 11 Jan 2022 06:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641881445;
        bh=DlepzLtuiXS+0Srxpq7GBNhmUS0k3bLfNqdW4/R+J3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R393luxky7sAWijXFVqKIZm+JfzXvNiGmocW79t0QOtIIw3qVpYuTAc9FuIOhPooU
         lNqp/qba8qBCHGFJnujK530s8zujoqrHsL1ohTuje464Mr1UaNplXyc5TPnX6uPbOv
         AM7MbjsBAteJNgPtuPsbawvci659JMbTFQJLWTXUfR1LjC3dpSYKabq691I5+rf9jE
         IT+KaAA7W6Vp8tB0FCZqCDgezAZEszbrfTPzU2eAiD2wW7WScLYGgM9TegMqBbIk0d
         hI0rzsjWriK9feZ/u2WLADmMkFNOoRAfiqT44fI5gMh33QPe79cNH+RmTQwWbWid99
         37dmWCT4a0huQ==
Date:   Tue, 11 Jan 2022 00:17:08 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -next, v2] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <20220111061708.GA55910@embeddedor>
References: <20220110012354.144394-1-xiujianfeng@huawei.com>
 <Ydy3N577YD0JJr2N@hirez.programming.kicks-ass.net>
 <20220110193158.31e1eaea@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110193158.31e1eaea@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 07:31:58PM -0500, Steven Rostedt wrote:
> On Mon, 10 Jan 2022 23:46:15 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Jan 10, 2022 at 09:23:54AM +0800, Xiu Jianfeng wrote:
> > > Make use of struct_size() helper instead of an open-coded calculation.
> > > There is no functional change in this patch.
> > > 
> > > Link: https://github.com/KSPP/linux/issues/160
> > > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > > ---
> > >  kernel/sched/fair.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 095b0aa378df..af933a7f9e5d 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -2437,9 +2437,8 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
> > >  	int i;
> > >  
> > >  	if (unlikely(!deref_curr_numa_group(p))) {
> > > -		unsigned int size = sizeof(struct numa_group) +
> > > -				    NR_NUMA_HINT_FAULT_STATS *
> > > -				    nr_node_ids * sizeof(unsigned long);
> > > +		unsigned int size = struct_size(grp, faults,
> > > +						NR_NUMA_HINT_FAULT_STATS * nr_node_ids);  
> > 
> > Again, why?! The old code was perfectly readable, this, not so much.
> 
> Because it is unsafe, and there is an effort to get rid of all open coded
> struct_size() code. Linus has told me to do the same with my code.
> 
>   https://lore.kernel.org/all/CAHk-=wiGWjxs7EVUpccZEi6esvjpHJdgHQ=vtUeJ5crL62hx9A@mail.gmail.com/
> 
> And to be honest, the new change is a lot easier to read than the original
> code.

I agree.

Also, I was taking a look at the thread above and noticed the sparse
warning doesn't go away. However, the change is correct. :)

gustavo@beefy:~/git/linux$ grep 'using sizeof on a flexible structure' next-20220110.out | grep kernel/trace/trace.c
kernel/trace/trace.c:1009:17: warning: using sizeof on a flexible structure
kernel/trace/trace.c:2660:17: warning: using sizeof on a flexible structure
kernel/trace/trace.c:2770:51: warning: using sizeof on a flexible structure
kernel/trace/trace.c:3358:16: warning: using sizeof on a flexible structure
kernel/trace/trace.c:3418:16: warning: using sizeof on a flexible structure
kernel/trace/trace.c:7082:16: warning: using sizeof on a flexible structure
kernel/trace/trace.c:7160:16: warning: using sizeof on a flexible structure
gustavo@beefy:~/git/linux$ grep -nw struct_size kernel/trace/trace.c
2770:			int max_len = PAGE_SIZE - struct_size(entry, array, 1);

Thanks
--
Gustavo

> 
> struct_size() lets you know the field "faults" and the number of elements.
> You don't need to know the size of "faults". Whereas the original code,
> how is that readable? From that code, how do you know what the
> sizeof(unsigned long) is for?
> 
> -- Steve
