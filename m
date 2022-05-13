Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE3C526C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384731AbiEMVpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384768AbiEMVpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:45:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1144927B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652478279; x=1684014279;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lT74lGiuAEz86Uzv2XsXjui8dUE6R9Dh5404oENmuFE=;
  b=WM5NIot1tSOWhUQxBkvks9XJOYbOdWG9Qsbfjeqg8MH/7jwsKhqooDms
   H4/vzqDTJJvJ0NouSoCpmrTs76CV7yrGgcPkXrDAU87IZQNI65yzlzwAb
   z0Ev6eVwcZgMtHHE0l00sh0Cvs6QByb1UKrymW2BmMphwKzYpxabZQVzi
   XItmkM8KGpXcbLlbZDfh1HMcv+CBVSuCXW9GSSZ6VoqZKTIQ/q4Aq8HM0
   4VKjKBdUUau8R7CjngBxHmw1b236Xrd5Gvzf+M4RdeLOHleaqf8CHpWhO
   RbyNn7YP15l3KdnckNWVYlnpHzrvMDJj/pXWqboElaon/HqWql014B707
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="257969424"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="257969424"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 14:44:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="896390798"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.51.158])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 14:44:37 -0700
Message-ID: <f1f50c52673aa1873b4a4d3b6b15250d4bf390f9.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/7]  Add latency_nice priority
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, joshdon@google.com,
        len.brown@intel.com
Date:   Fri, 13 May 2022 14:44:37 -0700
In-Reply-To: <20220512163534.2572-1-vincent.guittot@linaro.org>
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 18:35 +0200, Vincent Guittot wrote:
> This patchset restarts the work about adding a latency nice priority to
> describe the latency tolerance of cfs tasks.
> 
> The patches [1-4] have been done by Parth:
> https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> 
> I have just rebased and moved the set of latency priority outside the
> priority update. I have removed the reviewed tag because the patches
> are 2 years old.
> 

Vincent,

Thanks for introducing the feature again, which is much needed.  I am trying
to look at the problem again from usage point of view. And wonder if
there are ways to make the latency_nice knob easier to use.

The latency nice value here is relative.  A latency sensitive task
may not tell if setting the latency_nice to -5, or to -10 is good enough.
It depends on what other tasks are setting their latency_nice value to.
What a task does know is what it it doing and its characteristics.  
For instance for client tasks, we may have categories such as

Task Category					latency_nice_range
-------------                                   ------------------
urgent						-19 to -16
media playback					-15 to -11
interactive (e.g.pressing key)  		-10 to -6
normal						-5  to  9
background					 10  to 15
opportunistic soaker task (sched_idle class)	 16 to  20

And we could allow a task to set attribute of which task category applies
to it and the OS can set a default latency nice value in its task category.   
So a task can just declare itself what kind of task it is, and not worry about
actually setting a latency nice value which it may not know
what is appopriate. 
If needed, a task could still adjust its latency nice value within the range to
differentiate itself in a task category. And we will prevent
a task from seeting inappropriate latency nice value out of the right range.

Knowing a task characteristics will also be helpful with other
scheduling decisions, like placing a task on a more high performing
core in hetero systems.  

I think the missing piece here is a way for a task to declare 
what kind of task it is.  I think that will make things easier.

Tim

> The patches [5-7] use latency nice priority to decide if a cfs task can
> preempt the current running task. Patch 5 gives some tests results with
> cyclictests and hackbench to highlight the benefit of latency nice
> priority for short interactive task or long intensive tasks.
> 
> 
> Change since v1:
> - fix typo
> - move some codes in the right patch to make bisect happy
> - simplify and fixed how the weight is computed
> - added support of sched core patch 7
> 
> Parth Shah (4):
>   sched: Introduce latency-nice as a per-task attribute
>   sched/core: Propagate parent task's latency requirements to the child
>     task
>   sched: Allow sched_{get,set}attr to change latency_nice of the task
>   sched/core: Add permission checks for setting the latency_nice value
> 
> Vincent Guittot (3):
>   sched/fair: Take into account latency nice at wakeup
>   sched/fair: Add sched group latency support
>   sched/core: support latency nice with sched core
> 
>  include/linux/sched.h            |   3 +
>  include/uapi/linux/sched.h       |   4 +-
>  include/uapi/linux/sched/types.h |  19 ++++++
>  init/init_task.c                 |   1 +
>  kernel/sched/core.c              |  90 ++++++++++++++++++++++++++
>  kernel/sched/debug.c             |   1 +
>  kernel/sched/fair.c              | 105 ++++++++++++++++++++++++++++++-
>  kernel/sched/sched.h             |  34 ++++++++++
>  tools/include/uapi/linux/sched.h |   4 +-
>  9 files changed, 257 insertions(+), 4 deletions(-)
> 

