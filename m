Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B12598E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbiHRUiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiHRUiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:38:17 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8C2B7F;
        Thu, 18 Aug 2022 13:38:15 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q74so1956357iod.9;
        Thu, 18 Aug 2022 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=5C03hGFfPweBw7v9LLb6tB/2S6yszkQhimy1MXVo+hA=;
        b=Z1Ph+dffaptDYRPrrIeaMxtxNPKuIj4YaTFXG0RlfbEF5I7Qj5hyT9fDRYLq2oniaO
         n5Nxnjvng/+oFoxtDM3iCcomjKqYz8hJrR1cmk2Iz6ONM7R2Tze7cjgf1dmH4q1WTn+F
         CtD7aVQv3cFq35w2rc8GqbZyS/LU9YZHRc/bcpPp3HDSyABjWi7xkqTSEjEupE6KQRbP
         fSTSLbyq1WFqlo/wLz32fG+SzBWsmIPf+uy6a2jxo/2iQicaSWRQ6judiIAjEwzUFpm9
         /yyT7ZxmqbHmOgJgtlpzbloQtE6DVcIO8wyGF2rd3+T5XheWqPYVjIuBP4EQX3+8d7m9
         H/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=5C03hGFfPweBw7v9LLb6tB/2S6yszkQhimy1MXVo+hA=;
        b=HYqzpTZqF+Haph1cYJFIS6UPvcovx9B5/sUybiuXp7CnReygd9gnv1rUy0Az/i2Xl6
         DQRya4O/Ehf+9pw8GFbHwB1Pvv08gMK17WLA3XE4NLX0aGZrusUvcynje7pEoQZajyCX
         JMAz9lOF3wx59flAQa52tyw/GHFvq66jgY/eD3VvC9jh96P3z6JAM7xPzligAETvoLfP
         grgBXipM9tmO+IdtZaKvHlHDOVoBOO1cRKW/8SE5+6VaRDUWYSkzZ3lsPja6c0BtTQBw
         i+KWZtjTPvyzfg3yw+CoLSOi/lptlJy6fX0sHMfxHW7SctkGw444Fe2sGXhxML94A6Ly
         DoMw==
X-Gm-Message-State: ACgBeo0rJpMuoK3QA4dvUsvdEkxgzoGhQ4k0zSdC/tQplC/g4enXJXeF
        hDqZfahezNxFjUb0B6rFIUoJD0FbEJxEu1xq
X-Google-Smtp-Source: AA6agR6C4eLhSx4J3m33McfqUoDxeJkIqwE4UlFaUqzOwmvCESdNC6+hREcaQF7rApQ5AUdKke2ZcA==
X-Received: by 2002:a05:6638:460e:b0:346:8509:8ea0 with SMTP id bw14-20020a056638460e00b0034685098ea0mr2107854jab.306.1660855094323;
        Thu, 18 Aug 2022 13:38:14 -0700 (PDT)
Received: from schspadeiMac.local (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id b8-20020a026f48000000b003436da41c78sm963872jae.76.2022.08.18.13.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:38:13 -0700 (PDT)
References: <20220711172314.603717-1-schspa@gmail.com>
 <Yv5okqzH92iPytgl@linutronix.de>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH] irq_work: wakeup irq_workd when queued first
 rt_lazy work
Date:   Fri, 19 Aug 2022 03:56:29 +0800
In-reply-to: <Yv5okqzH92iPytgl@linutronix.de>
Message-ID: <m21qtdqocv.fsf@gmail.com>
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


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-07-12 01:23:15 [+0800], Schspa Shi wrote:
>> I want to know if this difference is by design.
>
> Yes. type1 (LAZY) does not need immediate action but can't be scheduled
> regularly like a workqueue.
>
>> If this is by design, we have a problem that the irq_work of type2
>> will not execute as quickly as expected, it may be delayed by the
>> irq_work of type1.
>> 
>> Please consider the following scenarios:
>> 
>> If the CPU queued a type1 irq_work A, and then a type2 irq_work B.
>> But we won't make B executed quickly, because we won't issue the IPI
>> interrupt to wakeup irq_workd (the llist_add call will return false).
>
> But those two are different lists. So adding type1 to list1 does not
> affect type2 with list2
>

No, this will be added to same list (lazy_list).
All irq work without IRQ_WORK_HARD_IRQ flags will be added to lazy_list.
Maybe my description of type2 is not clear, type2 irq work means neither
the IRQ_WORK_LAZY flag nor the IRQ_WORK_HARD_IRQ flag is set.

>> This PATCH will issue the IPI_IRQ_WORK to make B execute quickly.
>> 
>> One thing that needs to be optimized is that we now have
>> lazy_list.node.llist and lazy_work_raised which need to be granted
>> to be atomicity, disabled the local CPU IRQ to make this atomic.
>> There should be a better way to make these two variants to be atomically
>> and I can go in deep if this little problem is not by design, and need
>> to be fixed.
>> 
>> If these two types of irq_work should be the same with the priority.
>> maybe we should change.
>> 
>> if (!lazy_work || tick_nohz_tick_stopped()) {
>> 	arch_irq_work_raise();
>> }
>> 
>> to
>> 
>> if (!(lazy_work || rt_lazy_work) || tick_nohz_tick_stopped()) {
>> 	arch_irq_work_raise();
>> }
>
> but we wait for the timer for the lazy-work. RT has more LAZY items
> compared to !RT. So if there is an error then it should be visible
> there, too.
>

As type 2 work and type 1 work will be added to lazy_list, type 2 work
can be delayed and have same priority as type 1.

> Is there a problem with this? Adding (as you call it) type1 item does
> not affect type2 items. They will will processed asap.
>

I noticed this because there is a BUG before the patch
b4c6f86ec2f6 ("irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT")
applied, which makes the task hang on when the CPU hotplug.

On some RT branches, lazy_work will be queued to ksoftirq via commit
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/kernel/irq_work.c?h=linux-5.10.y-rt&id=c1ecdc62c514c2d541490026c312ec614ebd35aa
c1ecdc62c5 ("irqwork: push most work into softirq context")

Which makes the irq_work won't be executed due to we don't call arch_irq_work_raise();
and raise_softirq(TIMER_SOFTIRQ); won't be executed by this case too.

If there is no timer exists on the current CPU, it will hang forever.

Log as fellowing.

[32987.846092] INFO: task core_ctl:749 blocked for more than 120 seconds.
[32987.846106]       Tainted: G           O      5.10.59-rt52-g19228cd9c280-dirty #24
[32987.846117] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[32987.846125] task:core_ctl        state:D stack:    0 pid:  749 ppid:     2 flags:0x00000028
[32987.846149] Call trace:
[32987.846155]  __switch_to+0x164/0x17c
[32987.846175]  __schedule+0x4cc/0x5c0
[32987.846190]  schedule+0x7c/0xcc
[32987.846205]  schedule_timeout+0x34/0xdc
[32987.846338]  do_wait_for_common+0xa0/0x12c
[32987.846360]  wait_for_common+0x44/0x68
[32987.846376]  wait_for_completion+0x18/0x24
[32987.846391]  __cpuhp_kick_ap+0x58/0x68
[32987.846408]  cpuhp_kick_ap+0x38/0x94
[32987.846423]  _cpu_down+0xbc/0x1f8
[32987.846443]  cpu_down_maps_locked+0x20/0x34
[32987.846461]  cpu_device_down+0x24/0x40
[32987.846477]  cpu_subsys_offline+0x10/0x1c
[32987.846496]  device_offline+0x6c/0xbc
[32987.846514]  remove_cpu+0x24/0x40
[32987.846530]  do_core_ctl+0x44/0x88 [cpuhp_qos]
[32987.846563]  try_core_ctl+0x90/0xb0 [cpuhp_qos]
[32987.846587]  kthread+0x114/0x124
[32987.846604]  ret_from_fork+0x10/0x30


Please notice this patch is only used to explain the problem, don't
try to compile it.

> Sebastian

-- 
BRs
Schspa Shi
