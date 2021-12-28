Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB664805D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 04:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhL1DOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 22:14:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234588AbhL1DOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 22:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640661269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NeCbNOBji4rPFI3COQOy5BBccZaCYqmF8SDZH/7UsfI=;
        b=Dsll23iaYG7AlJTM/Xv7R5CsFhjm3p4EswMN9tp1LPAKMYbY4AV5EsvGPa5aP2nvipxtOC
        jADq58Lzc9p9rmT4r7oFGOxggw569VsXepcvSfL8MtxB8jUIGRZkYDhlHzPsBOK4wldRRP
        JmwO+j+LGOa64mobd7YYG5KKhDoZNjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-N8BJkEcKNRq3D_bfoL7Slw-1; Mon, 27 Dec 2021 22:14:25 -0500
X-MC-Unique: N8BJkEcKNRq3D_bfoL7Slw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FAB11802508;
        Tue, 28 Dec 2021 03:14:24 +0000 (UTC)
Received: from [10.22.8.97] (unknown [10.22.8.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA7B2E2EC;
        Tue, 28 Dec 2021 03:14:23 +0000 (UTC)
Message-ID: <6396f046-b292-1a73-8339-d32b611d9b7f@redhat.com>
Date:   Mon, 27 Dec 2021 22:14:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (4)
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+03464269af631f4a4bdf@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com
References: <000000000000ef8cbb05d3bf84cd@google.com>
 <20211225005253.1962-1-hdanton@sina.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211225005253.1962-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/24/21 19:52, Hillf Danton wrote:
> On Wed, 22 Dec 2021 09:33:26 -0800
>> syzbot found the following issue on:
>>
>> HEAD commit:    9eaa88c7036e Merge tag 'libata-5.16-rc6' of git://git.kern..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=142d4143b00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3bdfd29b408d1b6
>> dashboard link: https://syzkaller.appspot.com/bug?extid=03464269af631f4a4bdf
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b1537db00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125de549b00000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+03464269af631f4a4bdf@syzkaller.appspotmail.com
>>
>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> 	(detected by 0, t=10502 jiffies, g=5509, q=170)
>> rcu: All QSes seen, last rcu_preempt kthread activity 8642 (4295000735-4294992093), jiffies_till_next_fqs=1, root ->qsmask 0x0
>> rcu: rcu_preempt kthread starved for 8643 jiffies! g5509 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
>> rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
>> rcu: RCU grace-period kthread stack dump:
>> task:rcu_preempt     state:R  running task     stack:28208 pid:   14 ppid:     2 flags:0x00004000
>> Call Trace:
>>   <TASK>
>>   context_switch kernel/sched/core.c:4972 [inline]
>>   context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
>>   __schedule+0xa9a/0x4940 kernel/sched/core.c:6253 kernel/sched/core.c:6253
>>   schedule+0xd2/0x260 kernel/sched/core.c:6326 kernel/sched/core.c:6326
>>   schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1881 kernel/time/timer.c:1881
>>   rcu_gp_fqs_loop+0x186/0x810 kernel/rcu/tree.c:1955 kernel/rcu/tree.c:1955
>>   rcu_gp_kthread+0x1de/0x320 kernel/rcu/tree.c:2128 kernel/rcu/tree.c:2128
>>   kthread+0x405/0x4f0 kernel/kthread.c:327 kernel/kthread.c:327
>>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295 arch/x86/entry/entry_64.S:295
>>   </TASK>
>> rcu: Stack dump where RCU GP kthread last ran:
>> NMI backtrace for cpu 0
>> CPU: 0 PID: 3672 Comm: syz-executor549 Not tainted 5.16.0-rc5-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>   <IRQ>
>>   __dump_stack lib/dump_stack.c:88 [inline]
>>   __dump_stack lib/dump_stack.c:88 [inline] lib/dump_stack.c:106
>>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106 lib/dump_stack.c:106
>>   nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111 lib/nmi_backtrace.c:111
>>   nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62 lib/nmi_backtrace.c:62
>>   trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
>>   trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline] kernel/rcu/tree_stall.h:481
>>   rcu_check_gp_kthread_starvation.cold+0x1fb/0x200 kernel/rcu/tree_stall.h:481 kernel/rcu/tree_stall.h:481
>>   print_other_cpu_stall kernel/rcu/tree_stall.h:586 [inline]
>>   check_cpu_stall kernel/rcu/tree_stall.h:729 [inline]
>>   rcu_pending kernel/rcu/tree.c:3878 [inline]
>>   print_other_cpu_stall kernel/rcu/tree_stall.h:586 [inline] kernel/rcu/tree.c:2597
>>   check_cpu_stall kernel/rcu/tree_stall.h:729 [inline] kernel/rcu/tree.c:2597
>>   rcu_pending kernel/rcu/tree.c:3878 [inline] kernel/rcu/tree.c:2597
>>   rcu_sched_clock_irq+0x2125/0x2200 kernel/rcu/tree.c:2597 kernel/rcu/tree.c:2597
>>   update_process_times+0x16d/0x200 kernel/time/timer.c:1785 kernel/time/timer.c:1785
>>   tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226 kernel/time/tick-sched.c:226
>>   tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1428 kernel/time/tick-sched.c:1428
>>   __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
>>   __run_hrtimer kernel/time/hrtimer.c:1685 [inline] kernel/time/hrtimer.c:1749
>>   __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1749 kernel/time/hrtimer.c:1749
>>   hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811 kernel/time/hrtimer.c:1811
>>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
>>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline] arch/x86/kernel/apic/apic.c:1103
>>   __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103 arch/x86/kernel/apic/apic.c:1103
>>   sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097 arch/x86/kernel/apic/apic.c:1097
>>   </IRQ>
>>   <TASK>
>>   asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638 arch/x86/include/asm/idtentry.h:638
>> RIP: 0010:owner_on_cpu kernel/locking/rwsem.c:667 [inline]
> The lock acquirer was spinning long enough to make RCU stall, and the
> question is, if this is not reproducible, how was the report triggered?
> Anything that syzbot is special in this case?
>
> Thanks
> 		Hillf

The test was running on a CONFIG_PREEMPT kernel. So if the syzkaller 
kthread is running at a higher priority than the rcu_preempt kthread, it 
is possible for the rcu_preempt kthread to be starved of cpu time. The 
rwsem optimistic spinning code will relinquish the cpu if there is a 
higher priority thread running. Since rcu_preempt kthread did not seem 
to be able to get the cpu, I suspect that it is probably caused by the 
syzkaller thread having a higher priority.

Cheers,
Longman

