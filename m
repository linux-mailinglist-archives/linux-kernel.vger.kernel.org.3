Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C925158B42C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 09:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiHFHTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 03:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHFHTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 03:19:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D258D;
        Sat,  6 Aug 2022 00:19:41 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M0DMY63QDz1HBYp;
        Sat,  6 Aug 2022 15:18:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 6 Aug 2022 15:19:38 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 6 Aug 2022 15:19:37 +0800
Subject: Re: [PATCH v4 0/2] rcu: Display registers of self-detected stall as
 far as possible
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     <paulmck@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>
References: <20220804023420.1663-1-thunder.leizhen@huawei.com>
 <20220804180958.GQ2125313@paulmck-ThinkPad-P17-Gen-1>
 <5da6eaf0-6570-caff-4eec-79d73b4f5062@huawei.com>
Message-ID: <9472ddc7-3be1-b0d1-aa15-527f9e365a4c@huawei.com>
Date:   Sat, 6 Aug 2022 15:19:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5da6eaf0-6570-caff-4eec-79d73b4f5062@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/5 16:09, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/8/5 2:09, Paul E. McKenney wrote:
>> On Thu, Aug 04, 2022 at 10:34:18AM +0800, Zhen Lei wrote:
>>> v3 --> v4:
>>> 1. To avoid undo/redo, merge patch 1-2 in v3 into one.
>>>
>>> v2 --> v3:
>>> 1. Patch 1 Add trigger_single_cpu_backtrace(cpu) in synchronize_rcu_expedited_wait()
>>>    Subsequently, we can see that all callers of dump_cpu_task() try
>>>    trigger_single_cpu_backtrace() first. Then I do the cleanup in Patch 2.
>>> 2. Patch 3, as Paul E. McKenney's suggestion, push the code into dump_cpu_task().
>>>
>>> For newcomers:
>>> Currently, dump_cpu_task() is mainly used by RCU, in order to dump the
>>> stack traces of the current task of the specified CPU when a rcu stall
>>> is detected.
>>>
>>> For architectures that do not support NMI interrupts, registers is not
>>> printed when rcu stall is self-detected. This patch series improve it.
>>
>> Thank you!  I have queued both for further testing and review.  I had
>> to rebase them to the -rcu tree's "dev" branch.  There was one trivial
>> conflict, but could you please check the resulting commits, both for
>> my wordsmithing and to make sure that your changes still work in your
>> environment?  (I do not have access to that sort of hardware.)

I tested it on x86, arm64, and arm32 platforms, and all the results are
as expected.

x86:
[   54.750801] rcu: INFO: rcu_preempt self-detected stall on CPU
[   54.754289] rcu:     0-....: (4998 ticks this GP) idle=9e5c/1/0x4000000000000000 softirq=855/855 fqs=1219
[   54.755307]  (t=5005 jiffies g=1 q=36 ncpus=8)
[   54.755311] CPU: 0 PID: 379 Comm: test0 Not tainted 5.19.0-rc3-00108-g0aa4c0b532b6 #1
[   54.755313] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
[   54.755321] RIP: 0010:pvclock_clocksource_read+0x12/0xc0
[   54.755328] Code: b6 47 1d 8b 17 39 ca 75 f1 22 05 79 9e a3 01 c3 0f 1f 84 00 00 00 00 00 55 53 48 83 ec 08 8b 17 89 d6 83 e6 fe 0f ae e8 0f 31 <48> c1 e2 20 48 8b 5f 10 0f b6 6f 1d 48 09 c2 48 89 d0 0f be 57 1c
[   54.755330] RSP: 0018:ffff936040547eb0 EFLAGS: 00000206
[   54.755332] RAX: 0000000088921016 RBX: 0000000c9957cfbb RCX: 0000000000000000
[   54.755333] RDX: 0000000000000026 RSI: 0000000000000006 RDI: ffffffffa46de000
[   54.755335] RBP: 0000000000000000 R08: 0000001336358637 R09: ffff936040547ea0
[   54.755336] R10: ffffffffa3e55dc0 R11: ffffffffa46ee4a1 R12: 0000000000003e42
[   54.755338] R13: ffffffffa4727d40 R14: ffffffffa28b0270 R15: 0000000000000000
[   54.755339] FS:  0000000000000000(0000) GS:ffff8e0cefc00000(0000) knlGS:0000000000000000
[   54.755343] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.755344] CR2: 0000563a3b1bae40 CR3: 0000000104378000 CR4: 00000000000006f0
[   54.755345] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   54.755346] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   54.755347] Call Trace:
[   54.755356]  <TASK>
[   54.755358]  kvm_clock_read+0x14/0x30
[   54.755361]  ktime_get+0x39/0x90
[   54.755368]  test_task+0x3f/0x60
[   54.755373]  kthread+0xe3/0x110
[   54.755376]  ? kthread_complete_and_exit+0x20/0x20
[   54.755378]  ret_from_fork+0x22/0x30
[   54.755385]  </TASK>


arm64:
[   27.235111] rcu: INFO: rcu_preempt self-detected stall on CPU
[   27.236915] rcu:     0-....: (1249 ticks this GP) idle=cac4/1/0x4000000000000000 softirq=1434/1434 fqs=625
[   27.237475]  (t=1251 jiffies g=3421 q=18 ncpus=4)
[   27.238994] CPU: 0 PID: 356 Comm: test0 Not tainted 5.19.0-rc3-00107-gbf5cb0bc4689 #1
[   27.239467] Hardware name: linux,dummy-virt (DT)
[   27.240038] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   27.240358] pc : arch_counter_read+0x18/0x24
[   27.241439] lr : arch_counter_read+0x18/0x24
[   27.241645] sp : ffff800008e53df0
[   27.241786] x29: ffff800008e53df0 x28: 0000000000000000 x27: 0000000000000000
[   27.242256] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[   27.242586] x23: 0000000000001f40 x22: ffffd62939e61df0 x21: 00000006556b8c60
[   27.243115] x20: 00000000000028ae x19: ffffd6293aad7300 x18: ffffffffffffffff
[   27.243396] x17: 0000000000000001 x16: 0000000000000000 x15: ffffd6293aabad8e
[   27.243671] x14: ffffffffffffffff x13: ffffd6293aabad85 x12: fffffffffffc4627
[   27.243947] x11: ffffd6293a772c98 x10: 0000000000000a60 x9 : 0000000000000fa0
[   27.244256] x8 : ffffd6293a772c50 x7 : ffff800008e53c40 x6 : 00000000767b62ab
[   27.244541] x5 : 01ffffffffffffff x4 : 0000000000000000 x3 : 0000000000000017
[   27.244813] x2 : 00000000000028ae x1 : ffff800008e53df0 x0 : 0000000076804ac1
[   27.245247] Call trace:
[   27.245457]  arch_counter_read+0x18/0x24
[   27.245845]  ktime_get+0x48/0xa0
[   27.246012]  test_task+0x6c/0xec
[   27.246151]  kthread+0x10c/0x110
[   27.246282]  ret_from_fork+0x10/0x20


arm32
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:    0-....: (499 ticks this GP) idle=c734/1/0x40000002 softirq=161/161 fqs=249
        (t=500 jiffies g=-899 q=16 ncpus=4)
CPU: 0 PID: 70 Comm: test0 Not tainted 5.19.0-rc3+ #1
Hardware name: ARM-Versatile Express
PC is at ktime_get+0x4c/0xe8
LR is at ktime_get+0x4c/0xe8
pc : [<8019b4fc>]    lr : [<8019b4fc>]    psr: 60000013
sp : c8a71f28  ip : 00000001  fp : 00000001
r10: f8ecbe00  r9 : 431bde82  r8 : d7b634db
r7 : 00000a0a  r6 : e2be6498  r5 : 00000001  r4 : 80ca8700
r3 : ffffffff  r2 : ff3a2de2  r1 : 00000000  r0 : 00c5d21d
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 627f806a  DAC: 00000051
 ktime_get from test_task+0x44/0x110
 test_task from kthread+0xd8/0xf4
 kthread from ret_from_fork+0x14/0x2c
Exception stack(0xc8a71fb0 to 0xc8a71ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000


> 
> Your description is much clearer than mine, thanks. I will test it
> tomorrow, the international network speed is too slow during the day.
> 
>>
>> In the future, could you please send your patches against the -rcu
>> tree's "dev" branch?
> 
> Okay, no problem. I'll do it next time.
> 
>>
>> 							Thanx, Paul
>>
>>> v2:
>>> https://lkml.org/lkml/2022/7/27/1800
>>>
>>> Zhen Lei (2):
>>>   sched/debug: Try trigger_single_cpu_backtrace(cpu) in dump_cpu_task()
>>>   sched/debug: Show the registers of 'current' in dump_cpu_task()
>>>
>>>  kernel/rcu/tree_stall.h |  8 +++-----
>>>  kernel/sched/core.c     | 14 ++++++++++++++
>>>  kernel/smp.c            |  3 +--
>>>  3 files changed, 18 insertions(+), 7 deletions(-)
>>>
>>> -- 
>>> 2.25.1
>>>
>> .
>>
> 

-- 
Regards,
  Zhen Lei
