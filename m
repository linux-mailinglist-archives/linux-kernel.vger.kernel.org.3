Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0567E598E49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbiHRUn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345709AbiHRUnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:43:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566712CDD1;
        Thu, 18 Aug 2022 13:43:21 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h78so1958093iof.13;
        Thu, 18 Aug 2022 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=Pb/0puRABpUW62QjSfeNH6tso7Fn8tM36cxd7xZb+JQ=;
        b=DJZoqteL6JOl+iiUfH0blpRMWAhm1hi4xguIF2/vEWAYuh3pdCkeOKGjWDA9RcKCzR
         Z3SfxwkGjiY8ZTWMuqXCBcPKZnsQT0LvhNZseqKE1kBOUBVIq8fR9GBSLDlayVOR6vrj
         uHsYB82V2vL8KDIEv8ZBR5Yh57vJO6uAqPMn/uzvhdv+g4bVYyVHDZ61CnHMW7TbkN5S
         1Ro58rsDI8RjerEg/nmMeQeujy3+xR69U1t2bephfop2owxGopoQTMTxWxWVe4gjSfOV
         8QDhnqUcKom4Ob6fNKcQlHCjke7Qbi4mJXxhi3nMETE/d1wE7Ersf0MzszlkdbWN3nFx
         Q00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=Pb/0puRABpUW62QjSfeNH6tso7Fn8tM36cxd7xZb+JQ=;
        b=Vn1GVXByt9qIM003L8IdYTPFESoVu+xlQxH0NiEYH0qCz2nUM5STkySeoOSgrPEQvv
         kN+F30b/4MAoRFZ7An4rhtjwIdeekDu0O0MALvkvBCWFe2KAoebcSLoBgpEYs817bZda
         dC5y2SqxFIO+beQKQazprzAVIODtO6up2r+uukVkoUyOrY3rAR7ahrLf5zZVMgjRZf9Z
         n/aG7jbA2NBmZhhwfgGwJno2lRT37shLC6X5JoIsaaIwpzAx9EhM6E4ROdMZpJCLEwDl
         fGyO3nRTmqsqJejm7Vqfa+bbgecW6bmumVYlOKNly6wGbvyQ/VLB1YvluplUPEBznD7h
         Cjqg==
X-Gm-Message-State: ACgBeo3D2EKRBlos93d1xMq/J32RFCuJovBZNQ7CtJLMVz5Lb9I9hL/s
        WR4JBE0kseRcRB+cikPH8OFXy8qYil+T42eT
X-Google-Smtp-Source: AA6agR7/t59ExXW/gcRD74RX5VaCSPAOZLPKSfnrCgMIeGLwxNBkEYzGIhc2uKIsJ7NLCy+50gvnPw==
X-Received: by 2002:a02:ccba:0:b0:343:7379:d92d with SMTP id t26-20020a02ccba000000b003437379d92dmr2070345jap.246.1660855400264;
        Thu, 18 Aug 2022 13:43:20 -0700 (PDT)
Received: from schspadeiMac.local (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id m6-20020a02a146000000b003316f4b9b26sm959620jah.131.2022.08.18.13.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:43:19 -0700 (PDT)
References: <20220711172314.603717-1-schspa@gmail.com>
 <Yv5okqzH92iPytgl@linutronix.de> <m21qtdqocv.fsf@gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH] irq_work: wakeup irq_workd when queued first
 rt_lazy work
Date:   Fri, 19 Aug 2022 04:42:29 +0800
In-reply-to: <m21qtdqocv.fsf@gmail.com>
Message-ID: <m2tu69p9jx.fsf@gmail.com>
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


Schspa Shi <schspa@gmail.com> writes:

> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>
>> On 2022-07-12 01:23:15 [+0800], Schspa Shi wrote:
>>> I want to know if this difference is by design.
>>
>> Yes. type1 (LAZY) does not need immediate action but can't be scheduled
>> regularly like a workqueue.
>>
>>> If this is by design, we have a problem that the irq_work of type2
>>> will not execute as quickly as expected, it may be delayed by the
>>> irq_work of type1.
>>> 
>>> Please consider the following scenarios:
>>> 
>>> If the CPU queued a type1 irq_work A, and then a type2 irq_work B.
>>> But we won't make B executed quickly, because we won't issue the IPI
>>> interrupt to wakeup irq_workd (the llist_add call will return false).
>>
>> But those two are different lists. So adding type1 to list1 does not
>> affect type2 with list2
>>
>
> No, this will be added to same list (lazy_list).
> All irq work without IRQ_WORK_HARD_IRQ flags will be added to lazy_list.
> Maybe my description of type2 is not clear, type2 irq work means neither
> the IRQ_WORK_LAZY flag nor the IRQ_WORK_HARD_IRQ flag is set.
>
>>> This PATCH will issue the IPI_IRQ_WORK to make B execute quickly.
>>> 
>>> One thing that needs to be optimized is that we now have
>>> lazy_list.node.llist and lazy_work_raised which need to be granted
>>> to be atomicity, disabled the local CPU IRQ to make this atomic.
>>> There should be a better way to make these two variants to be atomically
>>> and I can go in deep if this little problem is not by design, and need
>>> to be fixed.
>>> 
>>> If these two types of irq_work should be the same with the priority.
>>> maybe we should change.
>>> 
>>> if (!lazy_work || tick_nohz_tick_stopped()) {
>>> 	arch_irq_work_raise();
>>> }
>>> 
>>> to
>>> 
>>> if (!(lazy_work || rt_lazy_work) || tick_nohz_tick_stopped()) {
>>> 	arch_irq_work_raise();
>>> }
>>
>> but we wait for the timer for the lazy-work. RT has more LAZY items
>> compared to !RT. So if there is an error then it should be visible
>> there, too.
>>
>
> As type 2 work and type 1 work will be added to lazy_list, type 2 work
> can be delayed and have same priority as type 1.
>
>> Is there a problem with this? Adding (as you call it) type1 item does
>> not affect type2 items. They will will processed asap.
>>
>
> I noticed this because there is a BUG before the patch
> b4c6f86ec2f6 ("irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT")
> applied, which makes the task hang on when the CPU hotplug.
>
> On some RT branches, lazy_work will be queued to ksoftirq via commit
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/kernel/irq_work.c?h=linux-5.10.y-rt&id=c1ecdc62c514c2d541490026c312ec614ebd35aa
> c1ecdc62c5 ("irqwork: push most work into softirq context")
>
> Which makes the irq_work won't be executed due to we don't call arch_irq_work_raise();
> and raise_softirq(TIMER_SOFTIRQ); won't be executed by this case too.
>
> If there is no timer exists on the current CPU, it will hang forever.
>
> Log as fellowing.
>
> [32987.846092] INFO: task core_ctl:749 blocked for more than 120 seconds.
> [32987.846106]       Tainted: G           O      5.10.59-rt52-g19228cd9c280-dirty #24
> [32987.846117] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [32987.846125] task:core_ctl        state:D stack:    0 pid:  749 ppid:     2 flags:0x00000028
> [32987.846149] Call trace:
> [32987.846155]  __switch_to+0x164/0x17c
> [32987.846175]  __schedule+0x4cc/0x5c0
> [32987.846190]  schedule+0x7c/0xcc
> [32987.846205]  schedule_timeout+0x34/0xdc
> [32987.846338]  do_wait_for_common+0xa0/0x12c
> [32987.846360]  wait_for_common+0x44/0x68
> [32987.846376]  wait_for_completion+0x18/0x24
> [32987.846391]  __cpuhp_kick_ap+0x58/0x68
> [32987.846408]  cpuhp_kick_ap+0x38/0x94
> [32987.846423]  _cpu_down+0xbc/0x1f8
> [32987.846443]  cpu_down_maps_locked+0x20/0x34
> [32987.846461]  cpu_device_down+0x24/0x40
> [32987.846477]  cpu_subsys_offline+0x10/0x1c
> [32987.846496]  device_offline+0x6c/0xbc
> [32987.846514]  remove_cpu+0x24/0x40
> [32987.846530]  do_core_ctl+0x44/0x88 [cpuhp_qos]
> [32987.846563]  try_core_ctl+0x90/0xb0 [cpuhp_qos]
> [32987.846587]  kthread+0x114/0x124
> [32987.846604]  ret_from_fork+0x10/0x30
>

Add missing logs to make this hang issues clear.

[32987.953814] NMI backtrace for cpu 3
[32987.953829] CPU: 3 PID: 30 Comm: cpuhp/3 Tainted: G           O      5.10.59-rt52-g19228cd9c280-dirty #24
[32987.953849] Hardware name: Horizon Robotics Journey 5 DVB (DT)
[32987.953859] pstate: 60c00009 (nZCv daif +PAN +UAO -TCO BTYPE=--)
[32987.953876] pc : irq_work_sync+0x8/0x1c
[32987.953900] lr : cpufreq_dbs_governor_stop+0x50/0x7c
[32987.953923] sp : ffff80001280bd20
[32987.953930] pmr_save: 000000e0
[32987.953937] x29: ffff80001280bd20 x28: 0000000000000000 
[32987.953960] x27: 0000000000000000 x26: 0000000000000000 
[32987.953980] x25: 0000000000000000 x24: 0000000000000001 
[32987.953999] x23: ffff800011403000 x22: ffff000183bf1800 
[32987.954019] x21: ffff80001155e8e0 x20: 0000000000000080 
[32987.954040] x19: ffff00018aafd400 x18: 0000000000000000 
[32987.954059] x17: 0000000000000000 x16: 0000000000000000 
[32987.954079] x15: 000000000000000a x14: 000000000000001e 
[32987.954098] x13: ffff800012e2703c x12: ffffffffffffffff 
[32987.954118] x11: ffffffffffffffff x10: 0000000000000a20 
[32987.954138] x9 : ffff80001280bab0 x8 : ffff000180274480 
[32987.954158] x7 : 00000000ffffffff x6 : ffff800012e255da 
[32987.954177] x5 : ffff80001280bd00 x4 : 0000000000000000 
[32987.954196] x3 : ffff80001280bd00 x2 : 0000000000000000 
[32987.954216] x1 : 0000000000000023 x0 : ffff00018aafd448 
[32987.954235] Call trace:
[32987.954243]  irq_work_sync+0x8/0x1c
[32987.954263]  cpufreq_stop_governor+0x6c/0x80
[32987.954282]  cpufreq_offline+0xc4/0x1ec
[32987.954300]  cpuhp_cpufreq_offline+0x10/0x20
[32987.954317]  cpuhp_invoke_callback+0xc0/0x1b0
[32987.954334]  cpuhp_thread_fun+0x124/0x170
[32987.954350]  smpboot_thread_fn+0x1e8/0x1ec
[32987.954367]  kthread+0x114/0x124
[32987.954384]  ret_from_fork+0x10/0x30

>
> Please notice this patch is only used to explain the problem, don't
> try to compile it.
>
>> Sebastian


-- 
BRs
Schspa Shi
