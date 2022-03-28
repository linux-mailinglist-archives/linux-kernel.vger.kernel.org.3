Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41784E9C42
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiC1Q3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbiC1Q3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:29:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A74E606E6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:27:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98D62D6E;
        Mon, 28 Mar 2022 09:27:55 -0700 (PDT)
Received: from wubuntu (unknown [10.57.73.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D6763F73B;
        Mon, 28 Mar 2022 09:27:52 -0700 (PDT)
Date:   Mon, 28 Mar 2022 17:27:51 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        chris.hyser@oracle.com, pkondeti@codeaurora.org,
        Valentin.Schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 0/6] Add latency_nice priority
Message-ID: <20220328162751.gvfqnrxjdo2defji@wubuntu>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220322163911.3jge4unswuap3pjh@wubuntu>
 <CAKfTPtBYuEt=JuLLKFVJfzq_rNRoKPYfAnq7a2Jw=fBKMj6a3g@mail.gmail.com>
 <20220324172528.lrjiehsqrwvnwg2x@wubuntu>
 <CAKfTPtDpskXzJ4ZXt9=+NAbypZyfFMHE0w+N23CtArsA35s=UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDpskXzJ4ZXt9=+NAbypZyfFMHE0w+N23CtArsA35s=UA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/22 14:27, Vincent Guittot wrote:
> removed Dhaval's email which returns error
> 
> On Thu, 24 Mar 2022 at 18:25, Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 03/23/22 16:32, Vincent Guittot wrote:
> > > On Tue, 22 Mar 2022 at 17:39, Qais Yousef <qais.yousef@arm.com> wrote:
> > > >
> > > > Hi Vincent
> > > >
> > > > Thanks for reviving this patchset!
> > > >
> > > > On 03/11/22 17:14, Vincent Guittot wrote:
> > > > > This patchset restarts the work about adding a latency nice priority to
> > > > > describe the latency tolerance of cfs tasks.
> > > > >
> > > > > The patches [1-4] have been done by Parth:
> > > > > https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> > > > >
> > > > > I have just rebased and moved the set of latency priority outside the
> > > > > priority update. I have removed the reviewed tag because the patches
> > > > > are 2 years old.
> > > >
> > > > AFAIR the blocking issue we had then is on agreement on the interface. Has this
> > > > been resolved now? I didn't see any further discussion since then.
> > >
> > > I think that there was an agreement about using a latency nice
> > > priority in the range [-20:19] with -20 meaning sensitive to latency
> > > whereas 19 means that task doesn't care about scheduling latency.  The
> > > open point was about how to use this input in the scheduler with some
> > > behavior being opposed.
> >
> > What I remember is that the problem was to consolidate on use cases then
> > discuss interfaces.
> >
> > See https://lwn.net/Articles/820659/
> >
> >         "  Youssef said that the interface to all of this is the sticking
> >         point.  Thomas Gleixner agreed, saying that the -20..19 range "requires
> >         a crystal ball" to use properly. Zijlstra repeated his call to
> >         enumerate the use cases before getting into the interface details.
> >         Giani repeated that the interface does not look correct now, and agreed
> >         that a more comprehensive look at the use cases was needed. Things were
> >         being done backwards currently, he said.  "
> >
> 
> At LPC, everybody seemed aligned with latency_nice so I assumed that
> there was an agreement on this interface.
> Latency_nice fits well with my proposal because it's all about
> relative comparison between the running task to the others. The
> current nice priority is used to set how much cpu bandwidth a task
> will have compared to others and the latency_nice is used in a similar
> way to know which one should run compared to the others.

I think the users were happy, but not the maintainers :-)

I am still happy with it, but I just want to make sure that our use case is
something we still care about having in upstream and we'd still like to use
this interface to achieve that. I don't want it to be blocked based on
interface not suitable. So this should be taken into consideration that this is
not a replacement to at least our previous use case.

The concept of latency_nice conversion to weight is something new and I don't
think any of the other users requires it. So we need to keep the user visible
interface detached from weight which is internal implementation detail for your
use case.

> 
> > >
> > > >
> > > > >
> > > > > The patches [5-6] use latency nice priority to decide if a cfs task can
> > > > > preempt the current running task. Patch 5 gives some tests results with
> > > > > cyclictests and hackbench to highlight the benefit of latency nice
> > > > > priority for short interactive task or long intensive tasks.
> > > >
> > > > This is a new use case AFAICT. For Android, we want to do something in EAS path
> > >
> > > I don't think it's new, it's about being able to run some tasks in
> >
> > I meant new use case to latency-nice interface. I don't think we had this in
> > any of our discussions before? I don't mind it, but it'd be good to clarify if
> > it has any relation about the other use cases and what should happen to the
> > other use cases.
> 
> Several discussions happened about changing the preemption policy of
> CFS. I have Mel's example in mind with hackbench where we want to
> reduce the preemption capabilities for the threads and on the other
> side the multimedia tasks which complain about having to wait before
> being scheduled. All this is about preempting or not the others. And
> all this has been kept outside topology consideration but only for the
> local run queue

Cool. I can see its usefulness. Though I still have to convince myself that you
can affect preemption without impacting bandwidth and is not a subtler way to
modify nice.


Thanks

--
Qais Yousef
