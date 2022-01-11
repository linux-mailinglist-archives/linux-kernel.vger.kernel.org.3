Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43C748A46F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243070AbiAKAcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:32:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37112 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242941AbiAKAcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:32:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9C33614D0;
        Tue, 11 Jan 2022 00:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0192C36AE9;
        Tue, 11 Jan 2022 00:31:59 +0000 (UTC)
Date:   Mon, 10 Jan 2022 19:31:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -next, v2] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <20220110193158.31e1eaea@gandalf.local.home>
In-Reply-To: <Ydy3N577YD0JJr2N@hirez.programming.kicks-ass.net>
References: <20220110012354.144394-1-xiujianfeng@huawei.com>
        <Ydy3N577YD0JJr2N@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 23:46:15 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jan 10, 2022 at 09:23:54AM +0800, Xiu Jianfeng wrote:
> > Make use of struct_size() helper instead of an open-coded calculation.
> > There is no functional change in this patch.
> > 
> > Link: https://github.com/KSPP/linux/issues/160
> > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > ---
> >  kernel/sched/fair.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 095b0aa378df..af933a7f9e5d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -2437,9 +2437,8 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
> >  	int i;
> >  
> >  	if (unlikely(!deref_curr_numa_group(p))) {
> > -		unsigned int size = sizeof(struct numa_group) +
> > -				    NR_NUMA_HINT_FAULT_STATS *
> > -				    nr_node_ids * sizeof(unsigned long);
> > +		unsigned int size = struct_size(grp, faults,
> > +						NR_NUMA_HINT_FAULT_STATS * nr_node_ids);  
> 
> Again, why?! The old code was perfectly readable, this, not so much.

Because it is unsafe, and there is an effort to get rid of all open coded
struct_size() code. Linus has told me to do the same with my code.

  https://lore.kernel.org/all/CAHk-=wiGWjxs7EVUpccZEi6esvjpHJdgHQ=vtUeJ5crL62hx9A@mail.gmail.com/

And to be honest, the new change is a lot easier to read than the original
code.

struct_size() lets you know the field "faults" and the number of elements.
You don't need to know the size of "faults". Whereas the original code,
how is that readable? From that code, how do you know what the
sizeof(unsigned long) is for?

-- Steve
