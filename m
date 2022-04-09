Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC01F4FA9C4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242793AbiDIRK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiDIRKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:10:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CB9EC7D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:08:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11888ED1;
        Sat,  9 Apr 2022 10:08:46 -0700 (PDT)
Received: from wubuntu (unknown [10.57.74.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B5A03F5A1;
        Sat,  9 Apr 2022 10:08:43 -0700 (PDT)
Date:   Sat, 9 Apr 2022 18:08:41 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, Valentin.Schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, Wei Wang <wvw@google.com>
Subject: Re: [PATCH 0/6] Add latency_nice priority
Message-ID: <20220409170841.upcimeak2ch3aj35@wubuntu>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <7a7e1e21-df3d-4623-d9cd-51f5272919d5@arm.com>
 <CAKfTPtC36OLqrQ57bnGDi93N+3Ozk5cX-+KHHTWHkwCGp=z4gA@mail.gmail.com>
 <20220401121525.flngciwjtkn3mwlv@airbuntu>
 <CAKfTPtD7YntSV+fJkdwZxX0iO52hL0SxZ9G5hZTBSyZf6hMYRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtD7YntSV+fJkdwZxX0iO52hL0SxZ9G5hZTBSyZf6hMYRQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/22 10:46, Vincent Guittot wrote:
> On Fri, 1 Apr 2022 at 14:15, Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > +CC Wei
> >
> > On 03/28/22 14:56, Vincent Guittot wrote:
> > > Hi Dietmar,
> > >
> > >
> > > On Mon, 28 Mar 2022 at 11:24, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > > >
> > > > On 11/03/2022 17:14, Vincent Guittot wrote:
> > > > > This patchset restarts the work about adding a latency nice priority to
> > > > > describe the latency tolerance of cfs tasks.
> > > > >
> > > > > The patches [1-4] have been done by Parth:
> > > > > https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> > > > >
> > > > > I have just rebased and moved the set of latency priority outside the
> > > > > priority update. I have removed the reviewed tag because the patches
> > > > > are 2 years old.
> > > > >
> > > > > The patches [5-6] use latency nice priority to decide if a cfs task can
> > > > > preempt the current running task. Patch 5 gives some tests results with
> > > > > cyclictests and hackbench to highlight the benefit of latency nice
> > > > > priority for short interactive task or long intensive tasks.
> > > >
> > > > The Android specific `latency_nice` (in Android `latency_sensitive`
> > > > [latency_nice < 0]) use case `Skip energy aware task placement` favors
> > > > an idle CPU over the EAS search path for a `latency_sensitive` task.
> > > >
> > > > https://lkml.kernel.org/r/2aa4b838-c298-ec7d-08f3-caa50cc87dc2@arm.com
> > > >
> > > > This is Android proprietary code similar to what we have in
> > > > find_idlest_group_cpu() in mainline.
> > > > We talked to the Android folks last week and IMHO they are not convinced
> > > > that they can switch this to the proposed `latency_nice->tweak
> > > > preemption` use case.
> > >
> > > Thanks for discussing this with Android folks. It's not always easy to
> > > change the behavior of a product and I would be interested to discuss
> > > this with them. Sometimes you need a PoC to get convinced
> >
> > I think it's good to clarify for me at least here whether you intend this as
> > a replacement for disable EAS and revert to CAS or you see this as an
> > additional thing? As I understood from the discussion we had on the cover
> > letter, this is an additional improvement and not intended to replace any of
> > the previous use cases we brought up before.
> 
> This is not a replacement but an additional way to improve latency.
> The only thing that could happen is that this feature provides
> enhancement that makes the policy of disabling EAS and revert to CAS
> becoming less or no more interesting.

(Sorry for delayed response, in holiday)

Okay thanks for clarifying.

One other corner case to consider if you're working on next version is what
should happen when there are multiple tasks of the same priority on the rq. RT
scheduler will push/pull tasks to ensure the task will get to run ASAP if
there's another cpu at lower priority is available. Seems a lot of complexity
to add to CFS, but at the same time if 2 important tasks require low latency
are on the same rq, one of them will suffer without introducing the ability to
migrate one of them where it can get to run sooner.

--
Qais Yousef
