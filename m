Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA9256BEBE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbiGHSAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbiGHSAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:00:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9711F2F6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C32DB8291C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 18:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BE1C341C0;
        Fri,  8 Jul 2022 18:00:01 +0000 (UTC)
Date:   Fri, 8 Jul 2022 14:00:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: fix bad task migration for rt tasks
Message-ID: <20220708140000.6aa75a50@gandalf.local.home>
In-Reply-To: <m2h73snqja.fsf@gmail.com>
References: <20220707165014.77127-1-schspa@gmail.com>
        <20220707135329.08cf74b0@gandalf.local.home>
        <m2h73snqja.fsf@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jul 2022 12:51:14 +0800
Schspa Shi <schspa@gmail.com> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > On Fri,  8 Jul 2022 00:50:14 +0800
> > Schspa Shi <schspa@gmail.com> wrote:
> >  
> >> Please refer to the following scenarios.  
> >
> > I'm not sure this is what is happening. Do you have a trace to 
> > back this up?
> >  
> 
> I don't have a trace. This is inferred from the exception log.
> 
> >> 
> >>            CPU0                                  CPU1
> >> ------------------------------------------------------------------
> >> push_rt_task
> >>   check is_migration_disabled(next_task)
> >>                                         task not running and
> >>                                         migration_disabled == 0
> >>   find_lock_lowest_rq(next_task, rq);
> >>     _double_lock_balance(this_rq, busiest);
> >>       raw_spin_rq_unlock(this_rq);
> >>       double_rq_lock(this_rq, busiest);
> >>         <<wait for busiest rq>>
> >>                                             <wakeup>  
> >
> > Here's the problem I have. next_task is queued on CPU0, 
> > (otherwise CPU0
> > would not be pushing it). As CPU0 is currently running 
> > push_rt_task, how
> > did next_task start running to set its migrate_disable flag?  
> 
> THe next_task wasn't queued on CPU0, it's queued on CPU1 in this
> scenarios.

Bah, I forgot that we still do pushing for other CPUs. I was thinking that
we removed that in favor of pulling. It's been a while since I worked on
this.

> 
> And it's because when task wakup, the rq argument is not the
> current running CPU rq, it's next_task's rq
> (i.e. CPU1's rq in this sample scenarios).
> 
> And you can check this with the Call trace from the crash log.
> 
>     [123671.996969] Call trace:
>     [123671.996975]  set_task_cpu+0x8c/0x108
>     [123671.996984]  push_rt_task.part.0+0x144/0x184
>     [123671.996995]  push_rt_tasks+0x28/0x3c
>     [123671.997002]  task_woken_rt+0x58/0x68
>     [123671.997009]  ttwu_do_wakeup+0x5c/0xd0
>     [123671.997019]  ttwu_do_activate+0xc0/0xd4
>     [123671.997028]  try_to_wake_up+0x244/0x288
>     [123671.997036]  wake_up_process+0x18/0x24
>     [123671.997045]  __irq_wake_thread+0x64/0x80
>     [123671.997056]  __handle_irq_event_percpu+0x110/0x124
> 
> Function ttwu_do_wakeup will lock the task's rq, not current 
> running
> cpu rq.
> 
> >
> > Even if it was woken up on another CPU and ran there, by setting
> > migrate_disable, it would not be put back to CPU0, because its
> > migrate_disable flag is set (if it is, then there's the bug).
> >  
> 
> It no needs to put it back to CPU0 for this issue, it's still on 
> CPU1.
> 

Worse things can actually happen then migrating a migrate disabled task.
What prevents next_task from being scheduled and in a running state, or
even migrated?

Hmm, that's covered in find_lock_lowest_rq().

Looks like the the migrate disable check needs to go there.

		/* if the prio of this runqueue changed, try again */
		if (double_lock_balance(rq, lowest_rq)) {
			/*
			 * We had to unlock the run queue. In
			 * the mean time, task could have
			 * migrated already or had its affinity changed.
			 * Also make sure that it wasn't scheduled on its rq.
			 */
			if (unlikely(task_rq(task) != rq ||
				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
				     task_running(rq, task) ||
				     !rt_task(task) ||
+				     is_migrate_disabled(task) ||
				     !task_on_rq_queued(task))) {

				double_unlock_balance(rq, lowest_rq);
				lowest_rq = NULL;
				break;
			}
		}

-- Steve
