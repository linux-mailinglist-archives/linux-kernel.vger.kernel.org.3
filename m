Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F9C5704B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiGKNx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiGKNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:53:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A20B6392C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KCysq4rIc3V+HabhmuRWm/KRrKmTWkEH77lnoa+T7RU=; b=ekDBXtBa6voeGbJmmrgsnnpD2h
        +xfj1dHAqrBLA+weftZC9xSI+szm9pDzmeOS4IYaIqfPmRoOlyyX8zAj4cqojchLSGKsatPOly7OX
        S5XB8SHGTnnePd7/NOx1pPb0uu2YJ21vEpbT6C0uv5yDmPSyQ17BVlxIGNishq00bS8JUjhB5UiVO
        gX7+p97EPvgB8uO6KYTwYksaoU6hHVF5YK23zkoweSTsObVXnrqQDltDt0hT9trY+yQaoTXR3gJdY
        UwfYB3MglJrAANt5ApGL9M35svKan+8dpgPDAkayTweVusWY+mVfxMR/INfygUEJ7p4PP9Ecryb6W
        xOxHnqcg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAtqf-0060Nx-DG; Mon, 11 Jul 2022 13:53:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78E0B300110;
        Mon, 11 Jul 2022 15:53:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C05120D271D1; Mon, 11 Jul 2022 15:53:14 +0200 (CEST)
Date:   Mon, 11 Jul 2022 15:53:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH 3/8] sched/fair: remove redundant
 cpu_cgrp_subsys->fork()
Message-ID: <YswrSi46s+XLD18R@hirez.programming.kicks-ass.net>
References: <20220709151353.32883-1-zhouchengming@bytedance.com>
 <20220709151353.32883-4-zhouchengming@bytedance.com>
 <YsvSpyrJxNv7jsQz@hirez.programming.kicks-ass.net>
 <a41b3436-6875-d3aa-a110-6c438c97126e@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a41b3436-6875-d3aa-a110-6c438c97126e@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 09:02:07PM +0800, Chengming Zhou wrote:
> On 2022/7/11 15:35, Peter Zijlstra wrote:
> > On Sat, Jul 09, 2022 at 11:13:48PM +0800, Chengming Zhou wrote:
> >> We use cpu_cgrp_subsys->fork() to set task group for the new fair task
> >> in cgroup_post_fork().
> >>
> >> Since commit b1e8206582f9 ("sched: Fix yet more sched_fork() races")
> >> has already set task group for the new fair task in sched_cgroup_fork(),
> >> so cpu_cgrp_subsys->fork() can be removed.
> >>
> >>   cgroup_can_fork()	--> pin parent's sched_task_group
> >>   sched_cgroup_fork()
> >>     __set_task_cpu	--> set task group
> >>   cgroup_post_fork()
> >>     ss->fork() := cpu_cgroup_fork()	--> set again
> >>
> >> After this patch's change, task_change_group_fair() only need to
> >> care about task cgroup migration, make the code much simplier.
> > 
> > This:
> > 
> >> This patch also move the task se depth setting to set_task_rq(), which
> >> will set correct depth for the new task se in sched_cgroup_fork().
> >>
> >> The se depth setting in attach_entity_cfs_rq() is removed since
> >> set_task_rq() is a better place to do this when task moves across
> >> CPUs/groups.
> > 
> > really should have been it's own patch. And this actually scares me. Did
> > you test with priority inheritance bumping the task to FIFO while things
> > change?
> > 
> > This has nothing to do with fork().
> 
> Ok, will put this in another patch, so this patch still need this line:
> 
>   p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
> 
> in set_task_rq() to set depth for new forked task.

That would suggest you ordered your patches wrong.

> I didn't test with "priority inheritance bumping the task to FIFO" case,
> do you mean the rt_mutex_setprio() bump a fair task to FIFO?
> 
> Sorry, I don't get how removing depth setting in attach_entity_cfs_rq()
> affect that. Could you explain more so I can test it?

Well, if you look at the commit that introduced that code:

  eb7a59b2c888 ("sched/fair: Reset se-depth when task switched to FAIR")

then it's clear that the original problem was the task temporarily not
being in the fair class. The most common way for that to be so is
through PI.

