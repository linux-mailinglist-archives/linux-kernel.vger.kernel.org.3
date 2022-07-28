Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBDE583706
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbiG1Chp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiG1Chm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:37:42 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63259550BD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658975861; x=1690511861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nHZx2yHq0jQY1QGoZzw/Odwsc6IYuQTX9cmQoQNYIWY=;
  b=JkuU6F9nrrleR7nId9gpCamBIbWDkhOFZPq/oQVYTiu/eiKJ/Iq4XDTZ
   PkaPm3SGHrMQ5kFOSkQeGj7KOsFqFsQgeoHvrW3gJgYtXcvTADkWllhcI
   WSe9s85Wlr9Q5R9UVtZ7sre02KMaHIBe1tFeDVspnZpkJvKJ4LHPZ8R1x
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jul 2022 19:37:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 19:37:40 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 19:37:40 -0700
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Jul
 2022 19:37:38 -0700
Message-ID: <3dca718f-8d58-06c2-3f90-ef34a3dc114d@quicinc.com>
Date:   Thu, 28 Jul 2022 10:37:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH] workqueue: avoid re-entry of pwq->pool->lock through
 __queue_work
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>
CC:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220727110426.19079-1-quic_yingangl@quicinc.com>
 <CAJhGHyDXL90aprU2FjF++5DunJb90MiWRcz4VzBeFmJ0xeq-VA@mail.gmail.com>
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <CAJhGHyDXL90aprU2FjF++5DunJb90MiWRcz4VzBeFmJ0xeq-VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2022 12:51 AM, Lai Jiangshan wrote:
> On Wed, Jul 27, 2022 at 7:04 PM Kassey Li <quic_yingangl@quicinc.com> wrote:
>>
>> [0:swapper/4]BUG: spinlock recursion on CPU#4, swapper/4/0
>> [0:swapper/4]lock: 0xffffff8000c0f400, .magic: dead4ead, .owner:
>> swapper/4/0, .owner_cpu: 4
>> [0:swapper/4]CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S
>> [0:swapper/4]Call trace:
>> [0:swapper/4] dump_backtrace.cfi_jt+0x0/0x8
>> [0:swapper/4] show_stack+0x1c/0x2c
>> [0:swapper/4] dump_stack_lvl+0xd8/0x16c
>> [0:swapper/4] spin_dump+0x104/0x278
>> [0:swapper/4] do_raw_spin_lock+0xec/0x15c
>> [0:swapper/4] _raw_spin_lock+0x28/0x3c
>> [0:swapper/4] __queue_work+0x1fc/0x618
>> [0:swapper/4] queue_work_on+0x64/0x134
>> [0:swapper/4] memlat_hrtimer_handler+0x28/0x3c [memlat]
>> [0:swapper/4] __run_hrtimer+0xe8/0x448
>> [0:swapper/4] hrtimer_interrupt+0x184/0x40c
>> [0:swapper/4] arch_timer_handler_virt+0x5c/0x98
>> [0:swapper/4] handle_percpu_devid_irq+0xd8/0x3e0
>> [0:swapper/4] __handle_domain_irq+0xd0/0x19c
>> [0:swapper/4] gic_handle_irq+0x6c/0x134
>> [0:swapper/4] el1_irq+0xe4/0x1c0
> 
> It seems it is an unexpected IRQ.
    thanks for your suggest, we will focus on the api usage of spin_lock 
where possible broken the irq enable/disable.
    currently, abandon this change.
> 
>> [0:swapper/4] _raw_spin_unlock_irqrestore+0x2c/0x60
>> [0:swapper/4] try_to_wake_up.llvm.14610847381734009831+0x334/0x888
>> [0:swapper/4] wake_up_process+0x1c/0x2c
>> [0:swapper/4] __queue_work+0x3e8/0x618
>> [0:swapper/4] delayed_work_timer_fn+0x24/0x34
> 
> delayed_work_timer_fn() should have been invoked with IRQ disabled
> since it is TIMER_IRQSAFE.
> 
> Could you add some code to check if it is the case if possible, please?
   the timer flags = 0x15200004, which means TIMER_IRQSAFE is set.
   #define TIMER_IRQSAFE 0x00200000

> 
>> [0:swapper/4] call_timer_fn+0x58/0x268
>> [0:swapper/4] expire_timers+0xe0/0x1c4
> 
> Or could you do a "disass expire_timers+0xe0" in GDB?


    0xffffffc01025bf44 <+200>:   tbz     w8, #5, 0xffffffc01025bee4 
<expire_timers+104>
    0xffffffc01025bf48 <+204>:   bl      0xffffffc0118093bc 
<_raw_spin_unlock>
    0xffffffc01025bf4c <+208>:   mov     x0, x23
    0xffffffc01025bf50 <+212>:   mov     x1, x24
    0xffffffc01025bf54 <+216>:   mov     x2, x21
    0xffffffc01025bf58 <+220>:   bl      0xffffffc01025c040 <call_timer_fn>
    0xffffffc01025bf5c <+224>:   mov     x0, x20 //expire_timers+0xe0
--Type <RET> for more, q to quit, c to continue without paging--
    0xffffffc01025bf60 <+228>:   bl      0xffffffc011809230 <_raw_spin_lock>
    0xffffffc01025bf64 <+232>:   b       0xffffffc01025bf00 
<expire_timers+132>

> 
>> [0:swapper/4] __run_timers+0x16c/0x1c4
>> [0:swapper/4] run_timer_softirq+0x34/0x60
>> [0:swapper/4] efi_header_end+0x198/0x59c
>> [0:swapper/4] __irq_exit_rcu+0xdc/0xf0
>> [0:swapper/4] irq_exit+0x14/0x50
>> [0:swapper/4] __handle_domain_irq+0xd4/0x19c
>> [0:swapper/4] gic_handle_irq+0x6c/0x134
>> [0:swapper/4] el1_irq+0xe4/0x1c0
>> [0:swapper/4] cpuidle_enter_state+0x1b4/0x5dc
>> [0:swapper/4] cpuidle_enter+0x3c/0x58
>> [0:swapper/4] do_idle.llvm.6296834828977863291+0x1f4/0x2e8
>> [0:swapper/4] cpu_startup_entry+0x28/0x2c
>> [0:swapper/4] secondary_start_kernel+0x1c8/0x230
>>
>> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
>> ---
>>   kernel/workqueue.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 1ea50f6be843..f23491f373b1 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -1468,10 +1468,10 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>>                  } else {
>>                          /* meh... not running there, queue here */
>>                          raw_spin_unlock(&last_pool->lock);
>> -                       raw_spin_lock(&pwq->pool->lock);
>> +                       raw_spin_lock_irq(&pwq->pool->lock);
>>                  }
>>          } else {
>> -               raw_spin_lock(&pwq->pool->lock);
>> +               raw_spin_lock_irq(&pwq->pool->lock);
>>          }
>>
>>          /*
>> @@ -1484,7 +1484,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>>           */
>>          if (unlikely(!pwq->refcnt)) {
>>                  if (wq->flags & WQ_UNBOUND) {
>> -                       raw_spin_unlock(&pwq->pool->lock);
>> +                       raw_spin_unlock_irq(&pwq->pool->lock);
> 
> The patch is hardly correct, __queue_work() is called with irq-disabled,
> this code will enable IRQ imbalanced.
> 
>>                          cpu_relax();
>>                          goto retry;
>>                  }
>> @@ -1517,7 +1517,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>>          insert_work(pwq, work, worklist, work_flags);
>>
>>   out:
>> -       raw_spin_unlock(&pwq->pool->lock);
>> +       raw_spin_unlock_irq(&pwq->pool->lock);
>>          rcu_read_unlock();
>>   }
>>
>> --
>> 2.17.1
>>
