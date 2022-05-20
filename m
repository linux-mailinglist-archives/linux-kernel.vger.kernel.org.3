Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3CD52F362
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352069AbiETSqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352929AbiETSqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:46:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FAD7C167
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653072369; x=1684608369;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lEl6XDV2Lb5+CEHDctzerJoj2UobczRglX6ZOKeaOyU=;
  b=SJ4uq5QVSqRycDtULQ9fqSAJhScGImErcYV27td41RK3kXazUGx+X5DX
   gzqLHoNEkg3x3B3lGB31m7S61yLpBHjT/PeWOVgpDd5bGXyia7I6HeFIz
   9s7lczsToK2T0UFMgmQdxEUbm/7rkP6l49xN+KebPPwdSptyR3//dHlEv
   Za7VEpTBTPezHH6O5by4SNIx4ymcGhGRyWUHplF0Ne5ds8FwzUOJ4hL5b
   4QZkk5TETmszKEoIr4KtTiQxKhxSGoWO/pioUA1sgr8/+YTXxHAE22dt1
   X9OAp6fWqE5S4WwU0d1wFEbhHdz9mbfr6o4b26P/1A+Ab0bm+NmvOF+sG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="359105425"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="359105425"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 11:46:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="701877348"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.57.48])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 11:46:08 -0700
Message-ID: <aa8746fbb27849ee34ddb0ff028d0a1ee064c506.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/7] Add latency_nice priority
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Chris Hyser <chris.hyser@oracle.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        joshdon@google.com, len.brown@intel.com
Date:   Fri, 20 May 2022 11:46:08 -0700
In-Reply-To: <9c0f9158-2d0c-dba9-1505-79ba4e642684@oracle.com>
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
         <f1f50c52673aa1873b4a4d3b6b15250d4bf390f9.camel@linux.intel.com>
         <CAKfTPtBEHyP202duKwJi+GVNTMza+L_PuK3hmUxcjKnODOuRjw@mail.gmail.com>
         <9c0f9158-2d0c-dba9-1505-79ba4e642684@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-19 at 14:14 -0400, Chris Hyser wrote:
> On 5/19/22 10:16 AM, Vincent Guittot wrote:
> > On Fri, 13 May 2022 at 23:44, Tim Chen <tim.c.chen@linux.intel.com> wrote:
> > > On Thu, 2022-05-12 at 18:35 +0200, Vincent Guittot wrote:
> > > > This patchset restarts the work about adding a latency nice priority to
> > > > describe the latency tolerance of cfs tasks.
> > > > 
> > > > The patches [1-4] have been done by Parth:
> > > > https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> > > > 
> > > > I have just rebased and moved the set of latency priority outside the
> > > > priority update. I have removed the reviewed tag because the patches
> > > > are 2 years old.
> > > > 
> > > 
> > > Vincent,
> > > 
> > > Thanks for introducing the feature again, which is much needed.  I am trying
> > > to look at the problem again from usage point of view. And wonder if
> > > there are ways to make the latency_nice knob easier to use.
> > > 
> > > The latency nice value here is relative.  A latency sensitive task
> > > may not tell if setting the latency_nice to -5, or to -10 is good enough.
> > > It depends on what other tasks are setting their latency_nice value to.
> > > What a task does know is what it it doing and its characteristics.
> > > For instance for client tasks, we may have categories such as
> > > 
> > > Task Category                                   latency_nice_range
> > > -------------                                   ------------------
> > > urgent                                          -19 to -16
> > > media playback                                  -15 to -11
> > > interactive (e.g.pressing key)                  -10 to -6
> > > normal                                          -5  to  9
> > > background                                       10  to 15
> > > opportunistic soaker task (sched_idle class)     16 to  20
> > > 
> > > And we could allow a task to set attribute of which task category applies
> > > to it and the OS can set a default latency nice value in its task category.
> > > So a task can just declare itself what kind of task it is, and not worry about
> > > actually setting a latency nice value which it may not know
> > > what is appopriate.
> > > If needed, a task could still adjust its latency nice value within the range to
> > > differentiate itself in a task category. And we will prevent
> > > a task from seeting inappropriate latency nice value out of the right range.
> > 
> > The description above make sense but I'm not sure this should be put
> > as part of the interface but more in the documentation to describe how
> > system can make use of nice_latency
> > > Knowing a task characteristics will also be helpful with other
> > > scheduling decisions, like placing a task on a more high performing
> > > core in hetero systems.
> > 
> > Ok so you would like a more general interface than an latency
> > interface but a way to set some attributes to a task so we can make
> > smarter decision
> 
> The original definition of latency nice was as a task attribute describing the latency sensitivity of the task. The fact 
> that it was mapped to 'nice' values created too much granularity and made it look more like a tuning knob than a 
> statement about the characteristics of the task as intended.
> 
> > > I think the missing piece here is a way for a task to declare
> > > what kind of task it is.  I think that will make things easier.
> 
> A classification of tasks into categories would be useful, but perhaps one level up in a user space tool or a user's 
> head (ie docs). For any of the categories you describe, there may be a number of per-task attributes beyond latency 
> sensitivity needed to capture the task characteristics you mention and ideally would be set in specific ways. Say 'nice' 
> values, oom kill, etc. And others may make sense in the future, like say NUMA sensitivity, etc.
> 
> Basically, a category can map to a bunch of desired default values for various scheduler visible task attributes.

Yes.  I think having a default value for each category will make the setting of the attributes
consistent and life of a task simpler.

Without guidance, one media playback task can set its latency_nice to be -5, 
and another interactive task doing computation and displaying results to user
set its latency_nice to be -6. We would have the interactive task running ahead of the media playback,
which is undesired.  Just letting each task set its own latency_nice value will not achieve the
desired effect.  We need guidance on what attribute value a certain task category 
should use (as in documentation that Vincent mentioned).

Or let OS set the attribute to some sensible value if it knows the task category.

> 
> Now you could also take the idea in the other direction where you set a "category value" for a task and have the kernel 
> pick the other attribute defaults like 'nice' that would typically apply to tasks in the category, but I think letting 
> user space figure stuff out and then set low level kernel task attributes primitives is cleaner.

It is cleaner for the OS to give the knob to the user and say, "set it".
But users need guidance on what knob value they should use,
or even better, they don't need to worry about setting the knob.
I think it is easy for the user to set task category correctly, but
harder to set the low level knobs.

I can see that it is easy to set the latency_nice knob incorrectly.
The absolute value of the knob doesn't matter. Only the relative values
between tasks do. So we need all the tasks to agree on what latency-nice
to use for a task category.  

Tim


> 
> -chrish

