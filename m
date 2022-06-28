Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6939E55E79B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347919AbiF1PIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347141AbiF1PIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:08:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A121FCEF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:08:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7529E1F9DB;
        Tue, 28 Jun 2022 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656428893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqoHUf6qJ1GjuunaC9qHnQqPyHbp7lVaG8PSV9GtW3M=;
        b=ZgxAKzxn5gs5syNDKkrtU/x0Sjww1GWFpgDoIzHCc/pugSwehOK2FJyD6j8ipJymJGhmZB
        FOs9jw2QhKpJNysA3DAm1NDw3k5Kpx478Uk/80YcCbOvhaqmD8O4Jk7FPC/DD0l8YyBuCK
        mp6Clyu5AvzoEbJns1zt3yg7Rkn57Lc=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BC1C82C141;
        Tue, 28 Jun 2022 15:08:12 +0000 (UTC)
Date:   Tue, 28 Jun 2022 17:08:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <YrsYqocgf6yPQzoe@alley>
References: <20220622140853.31383-1-pmladek@suse.com>
 <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <YrllOoGRqp+Cdc9/@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrllOoGRqp+Cdc9/@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-06-27 10:07:22, Michal Hocko wrote:
> On Sat 25-06-22 14:00:10, Tejun Heo wrote:
> [...]
> > tl;dr is that the worker creation code expects a newly created worker
> > kthread to sit tight until the creator finishes setting up stuff and
> > sends the initial wakeup. However, something, which wasn't identified
> > in the report (Petr, it'd be great if you can find out who did the
> > wakeup), wakes up the new kthread before the creation path is done
> > with init which causes the new kthread to try to deref a NULL pointer.
> 
> One thing that hasn't been really mentioned explicitly but it might be
> really important. 5.3.18-2-rt is the RT patchset backported to 5.3
> based SLES kernel. We do not know whether the upstream RT patchset is
> affected the same way and due to nature of the customer we cannot really
> have this tested on that kernel.
> 
> I have tried to dig that out from the crash dump but no luck
> unfortunately. I was able to find the kthread pointer on few stacks:

I tried to dig more but I am not sure if it explains the problem.

The newly created worker was woken from "sysmon" process because
it was in wake_q_sleeper queue for its own &task->sighand->siglock.
I should not cause problems if the worker was really blocked 
and waiting to this spin lock.

It looks to me that ptrace might in theory cause the problematic
wakeup.

Note that it is SUSE kernel 5.3 with backported RT patchset.


See below for more details.

Michal found this process by searching for ffff9ca77e9a8000
on process stacks.

> sysmon is 
> crash> bt ffff9ca75e6349c0
> PID: 842    TASK: ffff9ca75e6349c0  CPU: 0   COMMAND: "sysmon"
>  #0 [ffffb0f6808e7be8] __schedule at ffffffffaa94bef1
>  #1 [ffffb0f6808e7c78] preempt_schedule_common at ffffffffaa94c5d1
>  #2 [ffffb0f6808e7c80] ___preempt_schedule at ffffffffaa201bb6
>  #3 [ffffb0f6808e7cd8] rt_mutex_postunlock at ffffffffaa309f6b
>  #4 [ffffb0f6808e7ce8] rt_mutex_futex_unlock at ffffffffaa94ea7c
>  #5 [ffffb0f6808e7d30] rt_spin_unlock at ffffffffaa950ace
>  #6 [ffffb0f6808e7d38] proc_pid_status at ffffffffaa4c9ff4
>  #7 [ffffb0f6808e7dd8] proc_single_show at ffffffffaa4c3801
>  #8 [ffffb0f6808e7e10] seq_read at ffffffffaa47c1b8
>  #9 [ffffb0f6808e7e70] vfs_read at ffffffffaa455fd9
> #10 [ffffb0f6808e7ea0] ksys_read at ffffffffaa456364
> 
> so collecting /pro/status data and releasing the sighand lock.


I found the pointer to the task struct actually twice there:

1. Direct pointer to task struct:

   The stack of the process "sysmon" is here:

    #5 [ffffb0f6808e7d30] rt_spin_unlock+0x3e at ffffffffaa950ace
       ffffb0f6808e7d38: proc_pid_status+1636 
    #6 [ffffb0f6808e7d38] proc_pid_status+0x664 at ffffffffaa4c9ff4
       ffffb0f6808e7d40: init_user_ns     init_pid_ns      
       ffffb0f6808e7d50: 0000000000000000 0000000000000000 
        ffffb0f6808e7d60: 00003f550019fca0 ffff9ca700000000 
       ffffb0f6808e7d70: 0000000000000000 0000000000000000 
       ffffb0f6808e7d80: 0000000000000000 0000000000000000 
       ffffb0f6808e7d90: ffffffffffffffff 0000000000000000 
       ffffb0f6808e7da0: 2c93096daf3bc600 [ffff9ca77e9a8000:task_struct]
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
       ffffb0f6808e7db0: [ffff9ca7602f6408:proc_inode_cache] [ffff9ca77e934908:seq_file] 
       ffffb0f6808e7dc0: [ffff9ca71bd7ad80:pid] init_pid_ns      
       ffffb0f6808e7dd0: [ffff9ca77e934908:seq_file] proc_single_show+81 

    So, the pointer on an actively used and valid stack.

    It seems it is the *task_struct that was passed to rec_pid_status().
    Therefore, proc_pid_status is showing status of the newly created
    worker that gets woken prematurely.

    According to the assembly, it is the code:

     + proc_pid_status()
       + task_sig()
         + unlock_task_sighand()
           + spin_unlock_irqrestore(&task->sighand->siglock)
	     + rt_spin_unlock()


2. Indirect pointer to task struct:

   The process "sysmon" is interrupted in rt_mutex_postunlock().
   It looks in this kernel like:

	void rt_mutex_postunlock(struct wake_q_head *wake_q,
				 struct wake_q_head *wake_sleeper_q)
	{
		wake_up_q(wake_q);
		wake_up_q_sleeper(wake_sleeper_q);
	
		/* Pairs with preempt_disable() in rt_mutex_slowunlock() */
		preempt_enable();
	}

     Note that pointers to wake_q and wake_sleeper_q are passed as
     parameters.

     They point to the related fields in task-struct:

     crash> struct -x -o task_struct | grep wake_q
        [0x860] struct wake_q_node wake_q;
        [0x868] struct wake_q_node wake_q_sleeper;

     The relevant part of the stack of "sysmon" is:

    crash> bt -FFxs 842
    [...]
    #2 [ffffb0f6808e7c80] ___preempt_schedule+0x16 at ffffffffaa201bb6
        ffffb0f6808e7c88: [ffff9ca764ee90bd:kmalloc-4k] ffffb0f6808e7c20 
        ffffb0f6808e7c98: 0000000000027340 fair_sched_class 
        ffffb0f6808e7ca8: 0000000000000003 0000000000000000 
        ffffb0f6808e7cb8: 0000000000000000 0000000000000202 
        ffffb0f6808e7cc8: [ffff9ca77e9a8028:task_struct] ffffb0f6808e7d08 
        ffffb0f6808e7cd8: rt_mutex_postunlock+43 
     #3 [ffffb0f6808e7cd8] rt_mutex_postunlock+0x2b at ffffffffaa309f6b
        ffffb0f6808e7ce0: [ffff9ca762400000:sighand_cache] rt_mutex_futex_unlock+172 
     #4 [ffffb0f6808e7ce8] rt_mutex_futex_unlock+0xac at ffffffffaa94ea7c
        ffffb0f6808e7cf0: 0000000000000246 0000000000000001 
        ffffb0f6808e7d00: ffffb0f6808e7cf8 [ffff9ca77e9a8868:task_struct]
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        ffffb0f6808e7d10: [ffff9ca77e9a8868:task_struct] 2c93096daf3bc600 
        ffffb0f6808e7d20: [ffff9ca77e934908:seq_file] 0000000000000000 
        ffffb0f6808e7d30: rt_spin_unlock+62 

    and if we look at the task struct via the offset to wake_q_sleeper:

    crash> struct task_struct -l 0x868 ffff9ca77e9a8868 | grep -e pid
    pid = 16213, 

    So, the newly created kthread, PID 16213, was on the
    wake_q_sleeper queue related to its own &task->sighand->siglock


Doubts:

Everything should be good when the kthread was really blocked and waiting for
&task->sighand->siglock.

Is there any other reason why the kthread could end up on the
wake_q_sleeper queue even when it did not take &task->sighand->siglock
directly?

    + RT specifix hacks to avoid priority inversion of processes?
    + ptrace?

Or is it possible that the following code takes task->sighand->siglock
on RT kernel?

	static int kthread(void *_create)
	{
	[...]
		/* OK, tell user we're spawned, wait for stop or wakeup */
		__set_current_state(TASK_UNINTERRUPTIBLE);
		create->result = current;
		/*
		 * Thread is going to call schedule(), do not preempt it,
		 * or the creator may spend more time in wait_task_inactive().
		 */
		preempt_disable();
		complete(done);
		schedule_preempt_disabled();
	[...]
	}

Some more info:

The last running times are:

crash> ps -l
[115147050548884] [RU]  PID: 16127  TASK: ffff9ca77e9abb00  CPU: 0   COMMAND: "kworker/0:0H"
[115147050481426] [IN]  PID: 1829   TASK: ffff9ca71f581d80  CPU: 0   COMMAND: "vReqJob"
[115147050467716] [IN]  PID: 704    TASK: ffff9ca7624e0ec0  CPU: 0   COMMAND: "irq/127-eth0-Tx"
[115147050456263] [RU]  PID: 16213  TASK: ffff9ca77e9a8000  CPU: 1   COMMAND: "kworker/0:2H"
[115147050394683] [IN]  PID: 2035   TASK: ffff9ca71e252c40  CPU: 1   COMMAND: "vReqJob"
[115147050370507] [IN]  PID: 2146   TASK: ffff9ca71dcc6740  CPU: 1   COMMAND: "vReqJob"
[115147050363317] [RU]  PID: 842    TASK: ffff9ca75e6349c0  CPU: 0   COMMAND: "sysmon"
[115147050334723] [IN]  PID: 1875   TASK: ffff9ca71f6c1d80  CPU: 1   COMMAND: "vReqJob"
[115147050287774] [IN]  PID: 705    TASK: ffff9ca7624e0000  CPU: 1   COMMAND: "irq/128-eth0-Tx"
[115147050279924] [RU]  PID: 2      TASK: ffff9ca700381d80  CPU: 0   COMMAND: "kthreadd"

I am not sure what vRegJob tasks do. The new worker was scheduled on
CPU1 right after vReqJob. PID 2035. In theory, the process might
have triggered the rescheduling as well. But I do not see it:

crash> bt 2035
PID: 2035   TASK: ffff9ca71e252c40  CPU: 1   COMMAND: "vReqJob"
 #0 [ffffb0f68300fbb0] __schedule at ffffffffaa94bef1
 #1 [ffffb0f68300fc40] schedule at ffffffffaa94c4e6
 #2 [ffffb0f68300fc50] futex_wait_queue_me at ffffffffaa33e2c0
 #3 [ffffb0f68300fc88] futex_wait at ffffffffaa33f199
 #4 [ffffb0f68300fd98] do_futex at ffffffffaa341062
 #5 [ffffb0f68300fe70] __x64_sys_futex at ffffffffaa341a7e
 #6 [ffffb0f68300fee0] do_syscall_64 at ffffffffaa2025f0
 #7 [ffffb0f68300ff50] entry_SYSCALL_64_after_hwframe at ffffffffaaa0008c
    RIP: 00007f7317e0487d  RSP: 00007f7208777cd0  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 00007f72f00209d0  RCX: 00007f7317e0487d
    RDX: 0000000000000000  RSI: 0000000000000080  RDI: 00007f72f00209fc
    RBP: 0000000000000000   R8: 0000000000000000   R9: 00007f72f800eef0
    R10: 0000000000000000  R11: 0000000000000246  R12: 00007f72f0020998
    R13: 000000001df92377  R14: 0000000000000000  R15: 00007f72f00209fc
    ORIG_RAX: 00000000000000ca  CS: 0033  SS: 002b

From the stack, I do not think that it is related:

 #3 [ffffb0f68300fc88] futex_wait+0xd9 at ffffffffaa33f199
    ffffb0f68300fc90: 00007f72f00209fc ffffffff00000000 
    ffffb0f68300fca0: ffff9ca77e4eec00 0000000000000001 
    ffffb0f68300fcb0: 4063c3da32ce9400 ffffb0f68300fe68 
    ffffb0f68300fcc0: ffffb0f68300fe40 ffffb0f68300fe68 
    ffffb0f68300fcd0: ffffb0f68300fe40 [ffff9ca762a0ec00:sock_inode_cache] 
    ffffb0f68300fce0: 0000000000004000 ___sys_sendmsg+153 
    ffffb0f68300fcf0: 0000000000000064 ffffb0f68300fcf8 
    ffffb0f68300fd00: ffffb0f68300fcf8 ffff9ca77e4eec38 
    ffffb0f68300fd10: ffffb0f682befd08 [ffff9ca71e252c40:task_struct] 
    ffffb0f68300fd20: ffff9ca77e4eec08 [ffff9ca764b2b400:mm_struct] 
    ffffb0f68300fd30: 00007f72f0020000 00000000000009fc 
    ffffb0f68300fd40: 0000000000000000 0000000000000000 
    ffffb0f68300fd50: 0000000000000000 00000000ffffffff 
    ffffb0f68300fd60: 4063c3da32ce9400 0000000000000000 
    ffffb0f68300fd70: 0000000000000000 0000000000000000 
    ffffb0f68300fd80: 0000000000000000 00007f72f800eef0 
    ffffb0f68300fd90: 00007f72f00209fc do_futex+322     
 #4 [ffffb0f68300fd98] do_futex+0x142 at ffffffffaa341062
    ffffb0f68300fda0: __switch_to_asm+52 __switch_to_asm+64 
    ffffb0f68300fdb0: __switch_to_asm+52 __switch_to_asm+64 
    ffffb0f68300fdc0: __switch_to_asm+52 __switch_to_asm+64 
    ffffb0f68300fdd0: __switch_to_asm+52 __switch_to_asm+64 
    ffffb0f68300fde0: audit_filter_rules.constprop.22+583 [ffff9ca7632b1e40:cred_jar] 
    ffffb0f68300fdf0: __switch_to_asm+52 [ffff9ca71e252c40:task_struct] 
    ffffb0f68300fe00: __switch_to_asm+52 0000000132ce9400 
    ffffb0f68300fe10: ffffb0f68300fe6c ffffb0f68300fe60 
    ffffb0f68300fe20: 0000000000004000 0000000000000000 
    ffffb0f68300fe30: auditd_test_task+56 4063c3da32ce9400 
    ffffb0f68300fe40: 0000000000000080 0000000000000000 
    ffffb0f68300fe50: 00007f72f00209fc 0000000000000000 
    ffffb0f68300fe60: 00007f72f800eef0 0000000000000000 
    ffffb0f68300fe70: __x64_sys_futex+94 
 #5 [ffffb0f68300fe70] __x64_sys_futex+0x5e at ffffffffaa341a7e
    ffffb0f68300fe78: 00007f72ffffffff 0000000000000000 
    ffffb0f68300fe88: auditd_test_task+56 [ffff9ca71e246400:kmalloc-1k] 
    ffffb0f68300fe98: 00000000000000ca __audit_syscall_entry+235 
    ffffb0f68300fea8: 4063c3da32ce9400 00000000000000ca 
    ffffb0f68300feb8: ffffb0f68300ff58 00000000000000ca 
    ffffb0f68300fec8: 0000000000000000 0000000000000000 
    ffffb0f68300fed8: 0000000000000000 do_syscall_64+128 


Best Regards,
Petr
