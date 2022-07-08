Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20E756BF13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbiGHSVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbiGHSVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:21:22 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33D080485
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:21:21 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e16so11386665pfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=4EOv33gZFN/Naj7r2xac/i6dLKMvB/rAqCiXlJUJDrA=;
        b=mmPdLw/1cQ1hZtI8Nil5n8qYvOmv6CACDwtUweXWjW0zU0/FA7qoiiaJI4I5eJ2XQh
         uXKuzI+ZY7tHJrcGbzI0dn+vwq9TF3EhJaCFEtZd0N4A3/jp/4icUxwtdk53g9UflFpd
         4KBOufnwzhqfZ0Kz+ZvpWTxwUYRAtZ8hDPjj/cfsok/cpuQX/6TLrXDEipAE647/CAcw
         IPoRLPDSQipsO2A8eN5yjC0tBtEm0YO/h6JGwLlsvMAx2k58JziueN5MH0fIq/bRk5se
         QDC+T6agx/dVpSh98QOYCRU++BNNDz9/oZlvVumNe94yIfOnSOP0s5rV9LAYzHLGqNT3
         uXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=4EOv33gZFN/Naj7r2xac/i6dLKMvB/rAqCiXlJUJDrA=;
        b=YAxlXqAmqksGOCENQj7jO3vDxm97HWeTScFkvQsnZKmIUchnYeNgDbcktf7V4ePHN6
         kwGXEz094tE+2Kv7+60BqwtLpM1y9Mu2s2JEySiHRSfPtfbUp7zMsFc6nYvlzhXJsl7z
         zIY/ypvoyO7Ll4NPSOY/elnItGtEAu6ZPZGHeLr+qCr65nFUsLVUMmAtE0tHxFL0aUWs
         FTTAMhSgx0pvNtluXQCWbKIc9j6h62CdCNM7uAIHp7aRmGCw2B9XO3raUlcT5zBI/2uh
         fVVPcKIexxDIkhWGjUF7oYcRNjVvpkrPH6oRtbM24UPFHOFXUgkaHU9wNrD+wuk5YHr8
         fb1g==
X-Gm-Message-State: AJIora+rzaTdCRv4KrZXKIE4ZIRjRSrfOqdjXu3W41DdZk2Pm/JM8H91
        bxyAuLhPlL/45WhY5ePwKaoW5Bcv0rM+SA==
X-Google-Smtp-Source: AGRyM1tWWTNBfttOFF1DW16Nf7mp8q8PpMygOO+nGqPLtF+amuxyJjujoByGMVDH6r2XbvLixsGbfA==
X-Received: by 2002:a63:1b49:0:b0:411:c101:eda5 with SMTP id b9-20020a631b49000000b00411c101eda5mr4318323pgm.600.1657304481041;
        Fri, 08 Jul 2022 11:21:21 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id ij23-20020a170902ab5700b0016bd5da20casm13844975plb.134.2022.07.08.11.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:21:20 -0700 (PDT)
References: <20220707165014.77127-1-schspa@gmail.com>
 <20220707135329.08cf74b0@gandalf.local.home> <m2h73snqja.fsf@gmail.com>
 <20220708140000.6aa75a50@gandalf.local.home>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: fix bad task migration for rt tasks
Date:   Sat, 09 Jul 2022 02:19:42 +0800
In-reply-to: <20220708140000.6aa75a50@gandalf.local.home>
Message-ID: <m2ilo779f9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 08 Jul 2022 12:51:14 +0800
> Schspa Shi <schspa@gmail.com> wrote:
>
>> Steven Rostedt <rostedt@goodmis.org> writes:
>> 
>> > On Fri,  8 Jul 2022 00:50:14 +0800
>> > Schspa Shi <schspa@gmail.com> wrote:
>> >  
>> >> Please refer to the following scenarios.  
>> >
>> > I'm not sure this is what is happening. Do you have a trace to 
>> > back this up?
>> >  
>> 
>> I don't have a trace. This is inferred from the exception log.
>> 
>> >> 
>> >>            CPU0                                  CPU1
>> >> ------------------------------------------------------------------
>> >> push_rt_task
>> >>   check is_migration_disabled(next_task)
>> >>                                         task not running and
>> >>                                         migration_disabled == 0
>> >>   find_lock_lowest_rq(next_task, rq);
>> >>     _double_lock_balance(this_rq, busiest);
>> >>       raw_spin_rq_unlock(this_rq);
>> >>       double_rq_lock(this_rq, busiest);
>> >>         <<wait for busiest rq>>
>> >>                                             <wakeup>  
>> >
>> > Here's the problem I have. next_task is queued on CPU0, 
>> > (otherwise CPU0
>> > would not be pushing it). As CPU0 is currently running 
>> > push_rt_task, how
>> > did next_task start running to set its migrate_disable flag?  
>> 
>> THe next_task wasn't queued on CPU0, it's queued on CPU1 in this
>> scenarios.
>
> Bah, I forgot that we still do pushing for other CPUs. I was thinking that
> we removed that in favor of pulling. It's been a while since I worked on
> this.
>
>> 
>> And it's because when task wakup, the rq argument is not the
>> current running CPU rq, it's next_task's rq
>> (i.e. CPU1's rq in this sample scenarios).
>> 
>> And you can check this with the Call trace from the crash log.
>> 
>>     [123671.996969] Call trace:
>>     [123671.996975]  set_task_cpu+0x8c/0x108
>>     [123671.996984]  push_rt_task.part.0+0x144/0x184
>>     [123671.996995]  push_rt_tasks+0x28/0x3c
>>     [123671.997002]  task_woken_rt+0x58/0x68
>>     [123671.997009]  ttwu_do_wakeup+0x5c/0xd0
>>     [123671.997019]  ttwu_do_activate+0xc0/0xd4
>>     [123671.997028]  try_to_wake_up+0x244/0x288
>>     [123671.997036]  wake_up_process+0x18/0x24
>>     [123671.997045]  __irq_wake_thread+0x64/0x80
>>     [123671.997056]  __handle_irq_event_percpu+0x110/0x124
>> 
>> Function ttwu_do_wakeup will lock the task's rq, not current 
>> running
>> cpu rq.
>> 
>> >
>> > Even if it was woken up on another CPU and ran there, by setting
>> > migrate_disable, it would not be put back to CPU0, because its
>> > migrate_disable flag is set (if it is, then there's the bug).
>> >  
>> 
>> It no needs to put it back to CPU0 for this issue, it's still on 
>> CPU1.
>> 
>
> Worse things can actually happen then migrating a migrate disabled task.
> What prevents next_task from being scheduled and in a running state, or
> even migrated?
>
> Hmm, that's covered in find_lock_lowest_rq().
>
> Looks like the the migrate disable check needs to go there.
>
> 		/* if the prio of this runqueue changed, try again */
> 		if (double_lock_balance(rq, lowest_rq)) {
> 			/*
> 			 * We had to unlock the run queue. In
> 			 * the mean time, task could have
> 			 * migrated already or had its affinity changed.
> 			 * Also make sure that it wasn't scheduled on its rq.
> 			 */
> 			if (unlikely(task_rq(task) != rq ||
> 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
> 				     task_running(rq, task) ||
> 				     !rt_task(task) ||
> +				     is_migrate_disabled(task) ||
> 				     !task_on_rq_queued(task))) {
>

Yes, it's what I did in the V1 patch.
Link: https://lore.kernel.org/all/20220623182932.58589-1-schspa@gmail.com/

But I think it's not the best solution for this problem.
In these scenarios, we still have a chance to make the task run faster
by retrying to retry to push the currently running task on this CPU away.

There is more details on V2 patch's replay message.
Link: https://lore.kernel.org/all/CAMA88TrZ-o4W81Yfw9Wcs3ghoxwpeAKtFejtMTt78GNB0tKaSA@mail.gmail.com/#t

> 				double_unlock_balance(rq, lowest_rq);
> 				lowest_rq = NULL;
> 				break;
> 			}
> 		}
>
> -- Steve

-- 
BRs
Schspa Shi
