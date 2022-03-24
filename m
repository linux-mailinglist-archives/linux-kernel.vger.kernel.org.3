Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE4D4E67BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352252AbiCXR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352267AbiCXR1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:27:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87893996B8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:25:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4CD81515;
        Thu, 24 Mar 2022 10:25:32 -0700 (PDT)
Received: from wubuntu (unknown [10.57.71.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 496133F73B;
        Thu, 24 Mar 2022 10:25:30 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:25:28 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        chris.hyser@oracle.com, pkondeti@codeaurora.org,
        Valentin.Schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 0/6] Add latency_nice priority
Message-ID: <20220324172528.lrjiehsqrwvnwg2x@wubuntu>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220322163911.3jge4unswuap3pjh@wubuntu>
 <CAKfTPtBYuEt=JuLLKFVJfzq_rNRoKPYfAnq7a2Jw=fBKMj6a3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBYuEt=JuLLKFVJfzq_rNRoKPYfAnq7a2Jw=fBKMj6a3g@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/22 16:32, Vincent Guittot wrote:
> On Tue, 22 Mar 2022 at 17:39, Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > Hi Vincent
> >
> > Thanks for reviving this patchset!
> >
> > On 03/11/22 17:14, Vincent Guittot wrote:
> > > This patchset restarts the work about adding a latency nice priority to
> > > describe the latency tolerance of cfs tasks.
> > >
> > > The patches [1-4] have been done by Parth:
> > > https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> > >
> > > I have just rebased and moved the set of latency priority outside the
> > > priority update. I have removed the reviewed tag because the patches
> > > are 2 years old.
> >
> > AFAIR the blocking issue we had then is on agreement on the interface. Has this
> > been resolved now? I didn't see any further discussion since then.
> 
> I think that there was an agreement about using a latency nice
> priority in the range [-20:19] with -20 meaning sensitive to latency
> whereas 19 means that task doesn't care about scheduling latency.  The
> open point was about how to use this input in the scheduler with some
> behavior being opposed.

What I remember is that the problem was to consolidate on use cases then
discuss interfaces.

See https://lwn.net/Articles/820659/

	"  Youssef said that the interface to all of this is the sticking
	point.  Thomas Gleixner agreed, saying that the -20..19 range "requires
	a crystal ball" to use properly. Zijlstra repeated his call to
	enumerate the use cases before getting into the interface details.
	Giani repeated that the interface does not look correct now, and agreed
	that a more comprehensive look at the use cases was needed. Things were
	being done backwards currently, he said.  "

> 
> >
> > >
> > > The patches [5-6] use latency nice priority to decide if a cfs task can
> > > preempt the current running task. Patch 5 gives some tests results with
> > > cyclictests and hackbench to highlight the benefit of latency nice
> > > priority for short interactive task or long intensive tasks.
> >
> > This is a new use case AFAICT. For Android, we want to do something in EAS path
> 
> I don't think it's new, it's about being able to run some tasks in

I meant new use case to latency-nice interface. I don't think we had this in
any of our discussions before? I don't mind it, but it'd be good to clarify if
it has any relation about the other use cases and what should happen to the
other use cases.


Thanks

--
Qais Yousef
