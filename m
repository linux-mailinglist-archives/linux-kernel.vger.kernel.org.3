Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B3E56CF67
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiGJOTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 10:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGJOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 10:19:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499BF11142;
        Sun, 10 Jul 2022 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657462750; x=1688998750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X/PHvkyBRaGSu3TADeej6Q5pzDq5ZEAdT7/eTMkll2U=;
  b=Z0eSDuAqH9VZ7SFftFkpclObkuibhYYeDtepIvl+y3s1ZAXtAaxhmqDe
   0H8wQfjGiNegXKaTrtUKP5ODgWGs62LA4A2zCdPQGWnV9ask5tm34ixIl
   B+J4jrah35XvkkMQdJNfDAX/3/mpEyzOiGYyBwSE0q6oSo1CH0L3f92Yf
   cxIDPKyhL0TEunky5sHZz6W8NTxoO4fHNrFXNqg15LeAOpa9K9jIX+D33
   FIPy0DbDjrFI0AuDC+lgltd+UQYqCn8H2IWx/iJL3ltdT++cSkUGdPuQH
   JZmzlzoGDU3H/10IFb+I/ddhIwvr/fOoNhO98D54y/JO3eQ4QgwZjGQkm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="264926201"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="xz'?yaml'?scan'208";a="264926201"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 07:19:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="xz'?yaml'?scan'208";a="569478177"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 07:19:04 -0700
Date:   Sun, 10 Jul 2022 22:19:01 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-can@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ltp@lists.linux.it
Subject: [can]  c4e54b063f:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/workqueue.c
Message-ID: <Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bn8MLYLeueJvdVUK"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bn8MLYLeueJvdVUK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: c4e54b063f42f20a6b3ad1ffa61c574e631e0216 ("can: slcan: use CAN network device driver API")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20220625
with following parameters:

	test: pty
	ucode: 0x21

test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
test-url: http://linux-test-project.github.io/


on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[  164.229702][ T3796] BUG: sleeping function called from invalid context at kernel/workqueue.c:3010
[  164.229710][ T3796] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3796, name: pty03
[  164.229715][ T3796] preempt_count: 201, expected: 0
[  164.229719][ T3796] CPU: 1 PID: 3796 Comm: pty03 Tainted: G S                5.19.0-rc3-00630-gc4e54b063f42 #1
[  164.229724][ T3796] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
[  164.229727][ T3796] Call Trace:
[  164.229729][ T3796]  <TASK>
[ 164.229732][ T3796] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 164.229742][ T3796] __might_resched.cold (kernel/sched/core.c:9822) 
[ 164.229749][ T3796] start_flush_work+0x2a/0x680 
[ 164.229756][ T3796] __flush_work+0xa1/0x140 
[ 164.229761][ T3796] ? start_flush_work+0x680/0x680 
[ 164.229766][ T3796] ? out_of_line_wait_on_bit_timeout (kernel/sched/completion.c:100) 
[ 164.229774][ T3796] ? detach_if_pending (kernel/time/timer.c:1252) 
[ 164.229779][ T3796] ? try_to_grab_pending+0x23/0x480 
[ 164.229784][ T3796] __cancel_work_timer (kernel/workqueue.c:3162) 
[ 164.229789][ T3796] ? start_flush_work+0xac/0x680 
[ 164.229794][ T3796] ? try_to_grab_pending+0x480/0x480 
[ 164.229799][ T3796] ? flush_work (kernel/workqueue.c:3074 kernel/workqueue.c:3096) 
[ 164.229803][ T3796] ? flush_rcu_work (kernel/workqueue.c:3095) 
[ 164.229807][ T3796] ? synchronize_rcu_expedited (kernel/rcu/tree.c:3835) 
[ 164.229813][ T3796] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178) 
[ 164.229817][ T3796] ? _raw_spin_lock (kernel/locking/spinlock.c:177) 
[ 164.229824][ T3796] close_candev (drivers/net/can/dev/dev.c:389) can_dev
[ 164.229835][ T3796] slc_close (drivers/net/can/slcan.c:398) slcan
[ 164.229842][ T3796] slcan_close (drivers/net/can/slcan.c:657) slcan
[ 164.229849][ T3796] tty_ldisc_hangup (drivers/tty/tty_ldisc.c:282 drivers/tty/tty_ldisc.c:701) 
[ 164.229855][ T3796] ? fasync_remove_entry (fs/fcntl.c:868) 
[ 164.229862][ T3796] __tty_hangup+0x410/0x8c0 
[ 164.229868][ T3796] tty_ioctl (drivers/tty/tty_io.c:2719) 
[ 164.229873][ T3796] ? tty_release (drivers/tty/tty_io.c:2655) 
[ 164.229877][ T3796] ? __switch_to (arch/x86/kernel/process.h:38 arch/x86/kernel/process_64.c:627) 
[ 164.229883][ T3796] ? __schedule (kernel/sched/core.c:6340) 
[ 164.229888][ T3796] ? io_schedule_timeout (kernel/sched/core.c:6340) 
[ 164.229894][ T3796] ? __fget_files (arch/x86/include/asm/atomic64_64.h:22 include/linux/atomic/atomic-arch-fallback.h:2363 include/linux/atomic/atomic-arch-fallback.h:2388 include/linux/atomic/atomic-arch-fallback.h:2404 include/linux/atomic/atomic-long.h:497 include/linux/atomic/atomic-instrumented.h:1854 fs/file.c:882 fs/file.c:913) 
[ 164.229901][ T3796] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/ioctl.c:856 fs/ioctl.c:856) 
[ 164.229907][ T3796] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 164.229913][ T3796] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  164.229918][ T3796] RIP: 0033:0x7fd1923fbcc7
[ 164.229923][ T3796] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 48 8b             	add    %cl,-0x75(%rax)
   5:	05 c9 91 0c 00       	add    $0xc91c9,%eax
   a:	64 c7 00 26 00 00 00 	movl   $0x26,%fs:(%rax)
  11:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  18:	c3                   	retq   
  19:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  20:	00 00 00 
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 99 91 0c 00 	mov    0xc9199(%rip),%rcx        # 0xc91d3
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 99 91 0c 00 	mov    0xc9199(%rip),%rcx        # 0xc91a9
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  164.229927][ T3796] RSP: 002b:00007fff0f3bfc88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  164.229934][ T3796] RAX: ffffffffffffffda RBX: 000055ed576c7700 RCX: 00007fd1923fbcc7
[  164.229938][ T3796] RDX: 0000000000000000 RSI: 0000000000005437 RDI: 000000000000000d
[  164.229940][ T3796] RBP: 000055ed576c7b20 R08: 000000000003e5d8 R09: 0000000000000004
[  164.229943][ T3796] R10: 00007fff0f3cd170 R11: 0000000000000246 R12: 000000000000000d
[  164.229946][ T3796] R13: 0000000000000006 R14: 000055ed576c76a0 R15: 0000000000000004
[  164.229951][ T3796]  </TASK>
[  165.244520][ T3796] BUG: sleeping function called from invalid context at kernel/workqueue.c:3010
[  165.244528][ T3796] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3796, name: pty03
[  165.244532][ T3796] preempt_count: 201, expected: 0
[  165.244537][ T3796] CPU: 0 PID: 3796 Comm: pty03 Tainted: G S      W         5.19.0-rc3-00630-gc4e54b063f42 #1
[  165.244543][ T3796] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
[  165.244546][ T3796] Call Trace:
[  165.244548][ T3796]  <TASK>
[ 165.244551][ T3796] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 165.244562][ T3796] __might_resched.cold (kernel/sched/core.c:9822) 
[ 165.244569][ T3796] start_flush_work+0x2a/0x680 
[ 165.244576][ T3796] __flush_work+0xa1/0x140 
[ 165.244582][ T3796] ? start_flush_work+0x680/0x680 
[ 165.244587][ T3796] ? out_of_line_wait_on_bit_timeout (kernel/sched/completion.c:100) 
[ 165.244594][ T3796] ? __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/ioctl.c:856 fs/ioctl.c:856) 
[ 165.244601][ T3796] ? detach_if_pending (kernel/time/timer.c:1252) 
[ 165.244607][ T3796] ? try_to_grab_pending+0x23/0x480 
[ 165.244612][ T3796] __cancel_work_timer (kernel/workqueue.c:3162) 
[ 165.244617][ T3796] ? start_flush_work+0xac/0x680 
[ 165.244622][ T3796] ? try_to_grab_pending+0x480/0x480 
[ 165.244627][ T3796] ? flush_work (kernel/workqueue.c:3074 kernel/workqueue.c:3096) 
[ 165.244632][ T3796] ? flush_rcu_work (kernel/workqueue.c:3095) 
[ 165.244636][ T3796] ? synchronize_rcu_expedited (kernel/rcu/tree.c:3835) 
[ 165.244641][ T3796] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178) 
[ 165.244647][ T3796] ? _raw_spin_lock (kernel/locking/spinlock.c:177) 
[ 165.244653][ T3796] close_candev (drivers/net/can/dev/dev.c:389) can_dev
[ 165.244665][ T3796] slc_close (drivers/net/can/slcan.c:398) slcan
[ 165.244672][ T3796] slcan_close (drivers/net/can/slcan.c:657) slcan
[ 165.244679][ T3796] tty_ldisc_hangup (drivers/tty/tty_ldisc.c:282 drivers/tty/tty_ldisc.c:701) 
[ 165.244685][ T3796] ? fasync_remove_entry (fs/fcntl.c:868) 
[ 165.244691][ T3796] __tty_hangup+0x410/0x8c0 
[ 165.244696][ T3796] tty_ioctl (drivers/tty/tty_io.c:2719) 
[ 165.244701][ T3796] ? tty_release (drivers/tty/tty_io.c:2655) 
[ 165.244705][ T3796] ? __switch_to (arch/x86/kernel/process.h:38 arch/x86/kernel/process_64.c:627) 
[ 165.244711][ T3796] ? __schedule (kernel/sched/core.c:6340) 
[ 165.244716][ T3796] ? io_schedule_timeout (kernel/sched/core.c:6340) 
[ 165.244721][ T3796] ? __fget_files (arch/x86/include/asm/atomic64_64.h:22 include/linux/atomic/atomic-arch-fallback.h:2363 include/linux/atomic/atomic-arch-fallback.h:2388 include/linux/atomic/atomic-arch-fallback.h:2404 include/linux/atomic/atomic-long.h:497 include/linux/atomic/atomic-instrumented.h:1854 fs/file.c:882 fs/file.c:913) 
[ 165.244727][ T3796] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/ioctl.c:856 fs/ioctl.c:856) 
[ 165.244733][ T3796] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 165.244739][ T3796] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  165.244744][ T3796] RIP: 0033:0x7fd1923fbcc7
[ 165.244749][ T3796] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 48 8b             	add    %cl,-0x75(%rax)
   5:	05 c9 91 0c 00       	add    $0xc91c9,%eax
   a:	64 c7 00 26 00 00 00 	movl   $0x26,%fs:(%rax)
  11:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  18:	c3                   	retq   
  19:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  20:	00 00 00 
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 99 91 0c 00 	mov    0xc9199(%rip),%rcx        # 0xc91d3
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 99 91 0c 00 	mov    0xc9199(%rip),%rcx        # 0xc91a9
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  165.244753][ T3796] RSP: 002b:00007fff0f3bfc88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  165.244759][ T3796] RAX: ffffffffffffffda RBX: 000055ed576c7700 RCX: 00007fd1923fbcc7
[  165.244762][ T3796] RDX: 0000000000000000 RSI: 0000000000005437 RDI: 000000000000000d
[  165.244765][ T3796] RBP: 000055ed576c7b20 R08: 000000000003edc6 R09: 0000000000000004
[  165.244768][ T3796] R10: 00007fff0f3cd170 R11: 0000000000000246 R12: 000000000000000d
[  165.244771][ T3796] R13: 0000000000000006 R14: 000055ed576c76a0 R15: 0000000000000004
[  165.244775][ T3796]  </TASK>
[  166.256559][ T3796] BUG: sleeping function called from invalid context at kernel/workqueue.c:3010
[  166.256569][ T3796] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3796, name: pty03
[  166.256574][ T3796] preempt_count: 201, expected: 0
[  166.256578][ T3796] CPU: 0 PID: 3796 Comm: pty03 Tainted: G S      W         5.19.0-rc3-00630-gc4e54b063f42 #1
[  166.256584][ T3796] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
[  166.256587][ T3796] Call Trace:
[  166.256590][ T3796]  <TASK>
[ 166.256592][ T3796] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 166.256602][ T3796] __might_resched.cold (kernel/sched/core.c:9822) 
[ 166.256609][ T3796] start_flush_work+0x2a/0x680 
[ 166.256617][ T3796] __flush_work+0xa1/0x140 
[ 166.256622][ T3796] ? start_flush_work+0x680/0x680 
[ 166.256628][ T3796] ? out_of_line_wait_on_bit_timeout (kernel/sched/completion.c:100) 
[ 166.256634][ T3796] ? __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/ioctl.c:856 fs/ioctl.c:856) 
[ 166.256642][ T3796] ? detach_if_pending (kernel/time/timer.c:1252) 
[ 166.256647][ T3796] ? try_to_grab_pending+0x23/0x480 
[ 166.256652][ T3796] __cancel_work_timer (kernel/workqueue.c:3162) 
[ 166.256657][ T3796] ? start_flush_work+0xac/0x680 
[ 166.256662][ T3796] ? try_to_grab_pending+0x480/0x480 
[ 166.256668][ T3796] ? flush_work (kernel/workqueue.c:3074 kernel/workqueue.c:3096) 
[ 166.256672][ T3796] ? flush_rcu_work (kernel/workqueue.c:3095) 
[ 166.256677][ T3796] ? synchronize_rcu_expedited (kernel/rcu/tree.c:3835) 
[ 166.256683][ T3796] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178) 
[ 166.256687][ T3796] ? _raw_spin_lock (kernel/locking/spinlock.c:177) 
[ 166.256694][ T3796] close_candev (drivers/net/can/dev/dev.c:389) can_dev
[ 166.256707][ T3796] slc_close (drivers/net/can/slcan.c:398) slcan
[ 166.256714][ T3796] slcan_close (drivers/net/can/slcan.c:657) slcan
[ 166.256721][ T3796] tty_ldisc_hangup (drivers/tty/tty_ldisc.c:282 drivers/tty/tty_ldisc.c:701) 
[ 166.256728][ T3796] ? fasync_remove_entry (fs/fcntl.c:868) 
[ 166.256734][ T3796] __tty_hangup+0x410/0x8c0 
[ 166.256741][ T3796] tty_ioctl (drivers/tty/tty_io.c:2719) 
[ 166.256746][ T3796] ? tty_release (drivers/tty/tty_io.c:2655) 
[ 166.256751][ T3796] ? __switch_to (arch/x86/kernel/process.h:38 arch/x86/kernel/process_64.c:627) 
[ 166.256756][ T3796] ? __schedule (kernel/sched/core.c:6340) 
[ 166.256761][ T3796] ? io_schedule_timeout (kernel/sched/core.c:6340) 
[ 166.256767][ T3796] ? __fget_files (arch/x86/include/asm/atomic64_64.h:22 include/linux/atomic/atomic-arch-fallback.h:2363 include/linux/atomic/atomic-arch-fallback.h:2388 include/linux/atomic/atomic-arch-fallback.h:2404 include/linux/atomic/atomic-long.h:497 include/linux/atomic/atomic-instrumented.h:1854 fs/file.c:882 fs/file.c:913) 
[ 166.256773][ T3796] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/ioctl.c:856 fs/ioctl.c:856) 
[ 166.256780][ T3796] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 166.256786][ T3796] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  166.256791][ T3796] RIP: 0033:0x7fd1923fbcc7
[ 166.256797][ T3796] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 48 8b             	add    %cl,-0x75(%rax)
   5:	05 c9 91 0c 00       	add    $0xc91c9,%eax
   a:	64 c7 00 26 00 00 00 	movl   $0x26,%fs:(%rax)
  11:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  18:	c3                   	retq   
  19:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  20:	00 00 00 
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 99 91 0c 00 	mov    0xc9199(%rip),%rcx        # 0xc91d3
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 99 91 0c 00 	mov    0xc9199(%rip),%rcx        # 0xc91a9
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  166.256802][ T3796] RSP: 002b:00007fff0f3bfc88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  166.256809][ T3796] RAX: ffffffffffffffda RBX: 000055ed576c7700 RCX: 00007fd1923fbcc7
[  166.256813][ T3796] RDX: 0000000000000000 RSI: 0000000000005437 RDI: 000000000000000d
[  166.256815][ T3796] RBP: 000055ed576c7b20 R08: 000000000003f5ac R09: 0000000000000004
[  166.256818][ T3796] R10: 00007fff0f3cd170 R11: 0000000000000246 R12: 000000000000000d
[  166.256822][ T3796] R13: 0000000000000006 R14: 000055ed576c76a0 R15: 0000000000000004
[  166.256827][ T3796]  </TASK>
[  167.261649][ T3796] BUG: sleeping function called from invalid context at kernel/workqueue.c:3010
[  167.261657][ T3796] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3796, name: pty03
[  167.261662][ T3796] preempt_count: 201, expected: 0
[  167.261666][ T3796] CPU: 2 PID: 3796 Comm: pty03 Tainted: G S      W         5.19.0-rc3-00630-gc4e54b063f42 #1
[  167.261672][ T3796] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
[  167.261675][ T3796] Call Trace:
[  167.261677][ T3796]  <TASK>
[ 167.261680][ T3796] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 167.261690][ T3796] __might_resched.cold (kernel/sched/core.c:9822) 
[ 167.261697][ T3796] start_flush_work+0x2a/0x680 
[ 167.261705][ T3796] __flush_work+0xa1/0x140 
[ 167.261711][ T3796] ? start_flush_work+0x680/0x680 
[ 167.261716][ T3796] ? out_of_line_wait_on_bit_timeout (kernel/sched/completion.c:100) 
[ 167.261724][ T3796] ? __schedule (kernel/sched/core.c:6340) 
[ 167.261729][ T3796] ? detach_if_pending (kernel/time/timer.c:1252) 
[ 167.261735][ T3796] ? try_to_grab_pending+0x23/0x480 
[ 167.261740][ T3796] __cancel_work_timer (kernel/workqueue.c:3162) 
[ 167.261745][ T3796] ? start_flush_work+0xac/0x680 
[ 167.261750][ T3796] ? try_to_grab_pending+0x480/0x480 
[ 167.261756][ T3796] ? flush_work (kernel/workqueue.c:3074 kernel/workqueue.c:3096) 
[ 167.261760][ T3796] ? flush_rcu_work (kernel/workqueue.c:3095) 
[ 167.261765][ T3796] ? synchronize_rcu_expedited (kernel/rcu/tree.c:3835) 
[ 167.261770][ T3796] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178) 
[ 167.261776][ T3796] ? _raw_spin_lock (kernel/locking/spinlock.c:177) 
[ 167.261782][ T3796] close_candev (drivers/net/can/dev/dev.c:389) can_dev
[ 167.261794][ T3796] slc_close (drivers/net/can/slcan.c:398) slcan
[ 167.261801][ T3796] slcan_close (drivers/net/can/slcan.c:657) slcan
[ 167.261809][ T3796] tty_ldisc_hangup (drivers/tty/tty_ldisc.c:282 drivers/tty/tty_ldisc.c:701) 
[ 167.261816][ T3796] ? fasync_remove_entry (fs/fcntl.c:868) 
[ 167.261823][ T3796] __tty_hangup+0x410/0x8c0 
[ 167.261830][ T3796] tty_ioctl (drivers/tty/tty_io.c:2719) 
[ 167.261835][ T3796] ? tty_release (drivers/tty/tty_io.c:2655) 
[ 167.261840][ T3796] ? __switch_to (arch/x86/kernel/process.h:38 arch/x86/kernel/process_64.c:627) 
[ 167.261846][ T3796] ? __schedule (kernel/sched/core.c:6340) 
[ 167.261852][ T3796] ? io_schedule_timeout (kernel/sched/core.c:6340) 
[ 167.261857][ T3796] ? __fget_files (arch/x86/include/asm/atomic64_64.h:22 include/linux/atomic/atomic-arch-fallback.h:2363 include/linux/atomic/atomic-arch-fallback.h:2388 include/linux/atomic/atomic-arch-fallback.h:2404 include/linux/atomic/atomic-long.h:497 include/linux/atomic/atomic-instrumented.h:1854 fs/file.c:882 fs/file.c:913) 
[ 167.261865][ T3796] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/ioctl.c:856 fs/ioctl.c:856) 
[ 167.261871][ T3796] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 167.261877][ T3796] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  167.261883][ T3796] RIP: 0033:0x7fd1923fbcc7
[ 167.261888][ T3796] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 48 8b             	add    %cl,-0x75(%rax)
   5:	05 c9 91 0c 00       	add    $0xc91c9,%eax
   a:	64 c7 00 26 00 00 00 	movl   $0x26,%fs:(%rax)
  11:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  18:	c3                   	retq   
  19:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  20:	00 00 00 
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 99 91 0c 00 	mov    0xc9199(%rip),%rcx        # 0xc91d3
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 99 91 0c 00 	mov    0xc9199(%rip),%rcx        # 0xc91a9
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  167.261893][ T3796] RSP: 002b:00007fff0f3bfc88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  167.261900][ T3796] RAX: ffffffffffffffda RBX: 000055ed576c7700 RCX: 00007fd1923fbcc7
[  167.261904][ T3796] RDX: 0000000000000000 RSI: 0000000000005437 RDI: 000000000000000d
[  167.261907][ T3796] RBP: 000055ed576c7b20 R08: 000000000003fd86 R09: 0000000000000004
[  167.261910][ T3796] R10: 00007fff0f3cd170 R11: 0000000000000246 R12: 000000000000000d
[  167.261913][ T3796] R13: 0000000000000006 R14: 000055ed576c76a0 R15: 0000000000000004
[  167.261918][ T3796]  </TASK>
[  167.718896][  T308] Flags:                           fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt tsc_deadline_timer xsave avx f16c lahf_lm cpuid_fault epb pti ssbd ibrs ibpb stibp fsgsbase smep erms xsaveopt dtherm arat pln pts md_clear flush_l1d
[  167.718915][  T308]
[  167.718952][  T308]
[  167.718961][  T308]
[  167.719897][  T308] available filesystems:
[  167.719908][  T308]
[  167.729228][  T308] 9p autofs bdev bpf btrfs cgroup cgroup2 configfs cpuset debugfs devpts devtmpfs ext3 ext4 fuse fuseblk fusectl hugetlbfs mqueue nfs nfs4 pipefs proc pstore ramfs rpc_pipefs securityfs sockfs sysfs tmpfs tracefs
[  167.729245][  T308]
[  167.729281][  T308]
[  167.729290][  T308]
[  167.731408][  T308] mounted filesystems (/proc/mounts):
[  167.731421][  T308]
[  167.732603][  T308] rootfs / rootfs rw 0 0
[  167.732616][  T308]
[  167.734793][  T308] proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
[  167.734805][  T308]
[  167.737074][  T308] sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
[  167.737087][  T308]
[  167.740630][  T308] devtmpfs /dev devtmpfs rw,nosuid,noexec,size=4096k,nr_inodes=65536,mode=755 0 0
[  167.740643][  T308]
[  167.743870][  T308] securityfs /sys/kernel/security securityfs rw,nosuid,nodev,noexec,relatime 0 0
[  167.743884][  T308]
[  167.745551][  T308] tmpfs /dev/shm tmpfs rw,nosuid,nodev 0 0
[  167.745560][  T308]
[  167.749122][  T308] devpts /dev/pts devpts rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000 0 0
[  167.749137][  T308]
[  167.752335][  T308] tmpfs /run tmpfs rw,nosuid,nodev,size=1328156k,nr_inodes=819200,mode=755 0 0
[  167.752350][  T308]
[  167.755303][  T308] tmpfs /run/lock tmpfs rw,nosuid,nodev,noexec,relatime,size=5120k 0 0
[  167.755317][  T308]
[  167.759879][  T308] cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot 0 0
[  167.759893][  T308]
[  167.762861][  T308] pstore /sys/fs/pstore pstore rw,nosuid,nodev,noexec,relatime 0 0
[  167.762875][  T308]
[  167.765829][  T308] bpf /sys/fs/bpf bpf rw,nosuid,nodev,noexec,relatime,mode=700 0 0
[  167.765844][  T308]
[  167.771116][  T308] systemd-1 /proc/sys/fs/binfmt_misc autofs rw,relatime,fd=30,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=15317 0 0
[  167.771132][  T308]
[  167.774045][  T308] hugetlbfs /dev/hugepages hugetlbfs rw,relatime,pagesize=2M 0 0
[  167.774060][  T308]
[  167.776802][  T308] mqueue /dev/mqueue mqueue rw,nosuid,nodev,noexec,relatime 0 0
[  167.776816][  T308]
[  167.778953][  T308] sunrpc /run/rpc_pipefs rpc_pipefs rw,relatime 0 0
[  167.778966][  T308]
[  167.781419][  T308] debugfs /sys/kernel/debug debugfs rw,nosuid,nodev,noexec,relatime 0 0
[  167.781429][  T308]
[  167.783722][  T308] tracefs /sys/kernel/tracing tracefs rw,nosuid,nodev,noexec,relatime 0 0
[  167.783736][  T308]
[  167.786434][  T308] fusectl /sys/fs/fuse/connections fusectl rw,nosuid,nodev,noexec,relatime 0 0
[  167.786447][  T308]
[  167.789106][  T308] configfs /sys/kernel/config configfs rw,nosuid,nodev,noexec,relatime 0 0
[  167.789117][  T308]
[  167.790149][  T308] tmp /tmp tmpfs rw,relatime 0 0
[  167.790157][  T308]
[  167.792476][  T308] /dev/sda1 /opt/rootfs btrfs rw,relatime,ssd,space_cache,subvolid=5,subvol=/ 0 0
[  167.792530][  T308]
[  167.792555][  T308]
[  167.792560][  T308]
[  167.793218][  T308] mounted filesystems (df):
[  167.793224][  T308]
[  167.795097][  T308] Filesystem     Type      Size  Used Avail Use% Mounted on
[  167.795108][  T308]
[  167.797044][  T308] devtmpfs       devtmpfs  4.0M     0  4.0M   0% /dev
[  167.797057][  T308]
[  167.799451][  T308] tmpfs          tmpfs     3.2G     0  3.2G   0% /dev/shm
[  167.799465][  T308]
[  167.801444][  T308] tmpfs          tmpfs     1.3G  616K  1.3G   1% /run
[  167.801456][  T308]
[  167.803965][  T308] tmpfs          tmpfs     5.0M     0  5.0M   0% /run/lock
[  167.803977][  T308]
[  167.806314][  T308] tmp            tmpfs     3.2G  324K  3.2G   1% /tmp
[  167.806327][  T308]
[  167.809011][  T308] /dev/sda1      btrfs     500G   32G  468G   7% /opt/rootfs
[  167.809025][  T308]


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--bn8MLYLeueJvdVUK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="config-5.19.0-rc3-00630-gc4e54b063f42"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.19.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-3) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_CC_HAS_SLS=y
# CONFIG_SLS is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_INTEL_TDX_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_VM_GET_PAGE_PROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER=y
CONFIG_PTE_MARKER_UFFD_WP=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--bn8MLYLeueJvdVUK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='ltp'
	export testcase='ltp'
	export category='functional'
	export need_memory='4G'
	export job_origin='ltp-part2.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-ivb-d05'
	export tbox_group='lkp-ivb-d05'
	export submit_id='62c94de84e912a423496b650'
	export job_file='/lkp/jobs/scheduled/lkp-ivb-d05/ltp-pty-ucode=0x21-debian-11.1-x86_64-20220510.cgz-c4e54b063f42f20a6b3ad1ffa61c574e631e0216-20220709-16948-1y95yyw-4.yaml'
	export id='a65eb4b34198a915ecbf02acb317df0527b583e6'
	export queuer_version='/zday/lkp'
	export kconfig='x86_64-rhel-8.3-func'
	export model='Ivy Bridge'
	export nr_node=1
	export nr_cpu=4
	export memory='8G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402S31P2GGN-part2'
	export hdd_partitions='/dev/disk/by-id/ata-ST1000DM003-1CH162_Z1DARLY7-part*'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402S31P2GGN-part1'
	export brand='Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz'
	export commit='c4e54b063f42f20a6b3ad1ffa61c574e631e0216'
	export netconsole_port=6679
	export ucode='0x21'
	export need_kconfig_hw='{"NET_VENDOR_REALTEK"=>"y"}
{"R8169"=>"y"}
SATA_AHCI
DRM_I915'
	export bisect_dmesg=true
	export need_kconfig='BLK_DEV_LOOP
{"CAN"=>"m"}
{"CAN_RAW"=>"m"}
{"CAN_VCAN"=>"m"}
{"MINIX_FS"=>"m"}
{"CHECKPOINT_RESTORE"=>"y"}'
	export initrds='linux_headers'
	export enqueue_time='2022-07-09 17:44:09 +0800'
	export _id='62c94de94e912a423496b652'
	export _rt='/result/ltp/pty-ucode=0x21/lkp-ivb-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='446cdfe20ee347c1bcdb51c63762e1a79d0c084d'
	export base_commit='88084a3df1672e131ddc1b4e39eeacfd39864acf'
	export branch='linux-next/master'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/ltp/pty-ucode=0x21/lkp-ivb-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/2'
	export scheduler_version='/lkp/lkp/.src-20220708-234704'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/ltp/pty-ucode=0x21/lkp-ivb-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/2
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/vmlinuz-5.19.0-rc3-00630-gc4e54b063f42
branch=linux-next/master
job=/lkp/jobs/scheduled/lkp-ivb-d05/ltp-pty-ucode=0x21-debian-11.1-x86_64-20220510.cgz-c4e54b063f42f20a6b3ad1ffa61c574e631e0216-20220709-16948-1y95yyw-4.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=c4e54b063f42f20a6b3ad1ffa61c574e631e0216
max_uptime=2100
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/linux-headers.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/ltp_20220625.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/ltp-x86_64-14c1f76-1_20220625.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220216.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.19.0-rc2-04931-g7b27d294f4a9'
	export repeat_to=6
	export stop_repeat_if_found='dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/workqueue.c'
	export kbuild_queue_analysis=1
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/vmlinuz-5.19.0-rc3-00630-gc4e54b063f42'
	export dequeue_time='2022-07-09 17:51:25 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-ivb-d05/ltp-pty-ucode=0x21-debian-11.1-x86_64-20220510.cgz-c4e54b063f42f20a6b3ad1ffa61c574e631e0216-20220709-16948-1y95yyw-4.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='pty' $LKP_SRC/tests/wrapper ltp
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='pty' $LKP_SRC/stats/wrapper ltp
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time ltp.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--bn8MLYLeueJvdVUK
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
eKoUFzswAwAAAAAEWVo=

--bn8MLYLeueJvdVUK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ltp
Content-Transfer-Encoding: quoted-printable

/usr/bin/mkisofs
2022-07-09 09:54:11 ./runltp -f pty
INFO: creating /lkp/benchmarks/ltp/output directory
INFO: creating /lkp/benchmarks/ltp/results directory
Checking for required user/group ids

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

/etc/os-release
PRETTY_NAME=3D"Debian GNU/Linux 11 (bullseye)"
NAME=3D"Debian GNU/Linux"
VERSION_ID=3D"11"
VERSION=3D"11 (bullseye)"
VERSION_CODENAME=3Dbullseye
ID=3Ddebian
HOME_URL=3D"https://www.debian.org/"
SUPPORT_URL=3D"https://www.debian.org/support"
BUG_REPORT_URL=3D"https://bugs.debian.org/"

uname:
Linux lkp-ivb-d05 5.19.0-rc3-00630-gc4e54b063f42 #1 SMP Fri Jul 8 15:56:58 =
CST 2022 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-ivb-d05::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/result/ltp/pty-u=
code=3D0x21/lkp-ivb-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-fun=
c/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/2 BOOT_IMAGE=3D/pkg/linux=
/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/vmlin=
uz-5.19.0-rc3-00630-gc4e54b063f42 branch=3Dlinux-next/master job=3D/lkp/job=
s/scheduled/lkp-ivb-d05/ltp-pty-ucode=3D0x21-debian-11.1-x86_64-20220510.cg=
z-c4e54b063f42f20a6b3ad1ffa61c574e631e0216-20220709-16948-1y95yyw-4.yaml us=
er=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3-func commit=3Dc4e54b063f42=
f20a6b3ad1ffa61c574e631e0216 max_uptime=3D2100 LKP_SERVER=3Dinternal-lkp-se=
rver nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.r=
cu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 s=
oftlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prom=
pt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel=
 console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnor=
mal rw

Gnu C                  gcc (Debian 10.2.1-6) 10.2.1 20210110
Clang                =20
Gnu make               4.3
util-linux             2.36.1
mount                  linux 2.36.1 (libmount 2.36.1: selinux, smack, btrfs=
, namespaces, assert, debug)
modutils               28
e2fsprogs              1.46.2
Linux C Library        > libc.2.31
Dynamic linker (ldd)   2.31
Procps                 3.3.17
iproute2               0.3.0
iputils                20210202
ethtool                5.9
Kbd                    loadkeys:
Sh-utils               8.32
Modules Loaded         netconsole btrfs blake2b_generic xor raid6_pq zstd_c=
ompress libcrc32c sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64=
 sg i915 intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerc=
lamp coretemp crct10dif_pclmul crc32_pclmul intel_gtt drm_buddy crc32c_inte=
l drm_display_helper usb_storage ghash_clmulni_intel ttm ahci rapl drm_kms_=
helper intel_cstate libahci syscopyarea mei_me intel_uncore sysfillrect ipm=
i_devintf sysimgblt ipmi_msghandler libata fb_sys_fops mei video drm fuse i=
p_tables

free reports:
               total        used        free      shared  buff/cache   avai=
lable
Mem:         6640764      676368     2811352        5308     3153044     27=
33840
Swap:              0           0           0

cpuinfo:
Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   36 bits physical, 48 bits virtual
CPU(s):                          4
On-line CPU(s) list:             0-3
Thread(s) per core:              2
Core(s) per socket:              2
Socket(s):                       1
NUMA node(s):                    1
Vendor ID:                       GenuineIntel
CPU family:                      6
Model:                           58
Model name:                      Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz
Stepping:                        9
CPU MHz:                         3292.508
CPU max MHz:                     3300.0000
CPU min MHz:                     1600.0000
BogoMIPS:                        6585.01
L1d cache:                       64 KiB
L1i cache:                       64 KiB
L2 cache:                        512 KiB
L3 cache:                        3 MiB
NUMA node0 CPU(s):               0-3
Vulnerability Itlb multihit:     KVM: Mitigation: VMX unsupported
Vulnerability L1tf:              Mitigation; PTE Inversion
Vulnerability Mds:               Mitigation; Clear CPU buffers; SMT vulnera=
ble
Vulnerability Meltdown:          Mitigation; PTI
Vulnerability Mmio stale data:   Not affected
Vulnerability Spec store bypass: Mitigation; Speculative Store Bypass disab=
led via prctl
Vulnerability Spectre v1:        Mitigation; usercopy/swapgs barriers and _=
_user pointer sanitization
Vulnerability Spectre v2:        Mitigation; Retpolines, IBPB conditional, =
IBRS_FW, STIBP conditional, RSB filling
Vulnerability Srbds:             Not affected
Vulnerability Tsx async abort:   Not affected
Flags:                           fpu vme de pse tsc msr pae mce cx8 apic se=
p mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm p=
be syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl es=
t tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt tsc_deadline_timer xsa=
ve avx f16c lahf_lm cpuid_fault epb pti ssbd ibrs ibpb stibp fsgsbase smep =
erms xsaveopt dtherm arat pln pts md_clear flush_l1d

available filesystems:
9p autofs bdev bpf btrfs cgroup cgroup2 configfs cpuset debugfs devpts devt=
mpfs ext3 ext4 fuse fuseblk fusectl hugetlbfs mqueue nfs nfs4 pipefs proc p=
store ramfs rpc_pipefs securityfs sockfs sysfs tmpfs tracefs

mounted filesystems (/proc/mounts):
rootfs / rootfs rw 0 0
proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
devtmpfs /dev devtmpfs rw,nosuid,noexec,size=3D4096k,nr_inodes=3D65536,mode=
=3D755 0 0
securityfs /sys/kernel/security securityfs rw,nosuid,nodev,noexec,relatime =
0 0
tmpfs /dev/shm tmpfs rw,nosuid,nodev 0 0
devpts /dev/pts devpts rw,nosuid,noexec,relatime,gid=3D5,mode=3D620,ptmxmod=
e=3D000 0 0
tmpfs /run tmpfs rw,nosuid,nodev,size=3D1328156k,nr_inodes=3D819200,mode=3D=
755 0 0
tmpfs /run/lock tmpfs rw,nosuid,nodev,noexec,relatime,size=3D5120k 0 0
cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate,m=
emory_recursiveprot 0 0
pstore /sys/fs/pstore pstore rw,nosuid,nodev,noexec,relatime 0 0
bpf /sys/fs/bpf bpf rw,nosuid,nodev,noexec,relatime,mode=3D700 0 0
systemd-1 /proc/sys/fs/binfmt_misc autofs rw,relatime,fd=3D30,pgrp=3D1,time=
out=3D0,minproto=3D5,maxproto=3D5,direct,pipe_ino=3D15317 0 0
hugetlbfs /dev/hugepages hugetlbfs rw,relatime,pagesize=3D2M 0 0
mqueue /dev/mqueue mqueue rw,nosuid,nodev,noexec,relatime 0 0
sunrpc /run/rpc_pipefs rpc_pipefs rw,relatime 0 0
debugfs /sys/kernel/debug debugfs rw,nosuid,nodev,noexec,relatime 0 0
tracefs /sys/kernel/tracing tracefs rw,nosuid,nodev,noexec,relatime 0 0
fusectl /sys/fs/fuse/connections fusectl rw,nosuid,nodev,noexec,relatime 0 0
configfs /sys/kernel/config configfs rw,nosuid,nodev,noexec,relatime 0 0
tmp /tmp tmpfs rw,relatime 0 0
/dev/sda1 /opt/rootfs btrfs rw,relatime,ssd,space_cache,subvolid=3D5,subvol=
=3D/ 0 0

mounted filesystems (df):
Filesystem     Type      Size  Used Avail Use% Mounted on
devtmpfs       devtmpfs  4.0M     0  4.0M   0% /dev
tmpfs          tmpfs     3.2G     0  3.2G   0% /dev/shm
tmpfs          tmpfs     1.3G  616K  1.3G   1% /run
tmpfs          tmpfs     5.0M     0  5.0M   0% /run/lock
tmp            tmpfs     3.2G  324K  3.2G   1% /tmp
/dev/sda1      btrfs     500G   32G  468G   7% /opt/rootfs

AppArmor disabled

SELinux mode: unknown
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 3610     -n 3610 -=
p -f /tmp/ltp-tKqXTCPdaX/alltests -l /lkp/benchmarks/ltp/results/LTP_RUN_ON=
-2022_07_09-09h_54m_11s.log  -C /lkp/benchmarks/ltp/output/LTP_RUN_ON-2022_=
07_09-09h_54m_11s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_ON-2022_07_0=
9-09h_54m_11s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2022_07_09-09h_54m_11s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2022_07_09-09h_5=
4m_11s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2022_07_09-09h_54=
m_11s.tconf
Running tests.......
<<<test_start>>>
tag=3Dpty01 stime=3D1657360452
cmdline=3D"pty01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       1  TPASS  :  test1
pty01       2  TPASS  :  test2
pty01       3  TPASS  :  test3
pty01       4  TPASS  :  test4
pty01       5  TPASS  :  test5
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D10 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dpty02 stime=3D1657360462
cmdline=3D"pty02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
pty02.c:53: TINFO: Calling FIONREAD, this will hang in n_tty_ioctl() if the=
 bug is present...
pty02.c:59: TPASS: Got to the end without hanging

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dpty03 stime=3D1657360462
cmdline=3D"pty03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1526: TINFO: Timeout per run is 0h 01m 00s
pty03.c:108: TINFO: Creating PTY with SLIP line discipline
pty03.c:91: TCONF: You don't appear to have the SLIP TTY line discipline: E=
INVAL (22)
pty03.c:108: TINFO: Creating PTY with Async PPP line discipline
pty03.c:91: TCONF: You don't appear to have the Async PPP TTY line discipli=
ne: EINVAL (22)
pty03.c:108: TINFO: Creating PTY with AX25/KISS line discipline
pty03.c:91: TCONF: You don't appear to have the AX25/KISS TTY line discipli=
ne: EINVAL (22)
pty03.c:108: TINFO: Creating PTY with HDLC line discipline
=2E./../../include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period end=
ed
=2E./../../include/tst_fuzzy_sync.h:307: TINFO: loop =3D 20, delay_bias =3D=
 0
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =
=3D -141396416ns, avg_dev =3D 777680064ns, dev_ratio =3D 5.50 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =
=3D 70827ns, avg_dev =3D  5757ns, dev_ratio =3D 0.08 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =
=3D 17106ns, avg_dev =3D  2979ns, dev_ratio =3D 0.17 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =
=3D -141342672ns, avg_dev =3D 777680064ns, dev_ratio =3D 5.50 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =
=3D 28207  , avg_dev =3D  2785  , dev_ratio =3D 0.10 }
=2E./../../include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < =
0.10, introducing randomness
=2E./../../include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-15744, 247=
13]
=2E./../../include/tst_fuzzy_sync.h:307: TINFO: loop =3D 22780, delay_bias =
=3D 0
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =
=3D   115ns, avg_dev =3D    11ns, dev_ratio =3D 0.10 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =
=3D 45949ns, avg_dev =3D  1544ns, dev_ratio =3D 0.03 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =
=3D 29273ns, avg_dev =3D   829ns, dev_ratio =3D 0.03 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =
=3D 16791ns, avg_dev =3D  1600ns, dev_ratio =3D 0.10 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =
=3D  9031  , avg_dev =3D   858  , dev_ratio =3D 0.09 }
=2E./../../include/tst_fuzzy_sync.h:648: TINFO: Exceeded execution time, re=
questing exit
pty03.c:134: TPASS: Did not crash with HDLC TTY discipline
pty03.c:108: TINFO: Creating PTY with Sync PPP line discipline
pty03.c:91: TCONF: You don't appear to have the Sync PPP TTY line disciplin=
e: EINVAL (22)
pty03.c:108: TINFO: Creating PTY with SLCAN line discipline
=2E./../../include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period end=
ed
=2E./../../include/tst_fuzzy_sync.h:307: TINFO: loop =3D 20, delay_bias =3D=
 0
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =
=3D -5270ns, avg_dev =3D 30093ns, dev_ratio =3D 5.71 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =
=3D 15293584ns, avg_dev =3D 1043149ns, dev_ratio =3D 0.07 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =
=3D 29486ns, avg_dev =3D  3837ns, dev_ratio =3D 0.13 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =
=3D 15258827ns, avg_dev =3D 1057365ns, dev_ratio =3D 0.07 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =
=3D 8127728  , avg_dev =3D 555831  , dev_ratio =3D 0.07 }
=2E./../../include/tst_fuzzy_sync.h:648: TINFO: Exceeded execution time, re=
questing exit
pty03.c:134: TPASS: Did not crash with SLCAN TTY discipline
pty03.c:108: TINFO: Creating PTY with PPS line discipline
=2E./../../include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period end=
ed
=2E./../../include/tst_fuzzy_sync.h:307: TINFO: loop =3D 20, delay_bias =3D=
 0
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =
=3D    18ns, avg_dev =3D    35ns, dev_ratio =3D 1.91 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =
=3D 938154ns, avg_dev =3D 909163ns, dev_ratio =3D 0.97 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =
=3D 20101ns, avg_dev =3D  2237ns, dev_ratio =3D 0.11 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =
=3D 918071ns, avg_dev =3D 907540ns, dev_ratio =3D 0.99 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =
=3D 475400  , avg_dev =3D 470323  , dev_ratio =3D 0.99 }
=2E./../../include/tst_fuzzy_sync.h:648: TINFO: Exceeded execution time, re=
questing exit
pty03.c:134: TPASS: Did not crash with PPS TTY discipline
pty03.c:108: TINFO: Creating PTY with CAIF line discipline
pty03.c:91: TCONF: You don't appear to have the CAIF TTY line discipline: E=
INVAL (22)
pty03.c:108: TINFO: Creating PTY with GSM line discipline
=2E./../../include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period end=
ed
=2E./../../include/tst_fuzzy_sync.h:307: TINFO: loop =3D 20, delay_bias =3D=
 0
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =
=3D -10985ns, avg_dev =3D 55274ns, dev_ratio =3D 5.03 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =
=3D 12140890ns, avg_dev =3D 1596046ns, dev_ratio =3D 0.13 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =
=3D 20469ns, avg_dev =3D   672ns, dev_ratio =3D 0.03 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =
=3D 12109435ns, avg_dev =3D 1624900ns, dev_ratio =3D 0.13 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =
=3D 6425814  , avg_dev =3D 828658  , dev_ratio =3D 0.13 }
=2E./../../include/tst_fuzzy_sync.h:648: TINFO: Exceeded execution time, re=
questing exit
pty03.c:134: TPASS: Did not crash with GSM TTY discipline

Summary:
passed   4
failed   0
broken   0
skipped  5
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D120 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D11420 cstime=3D6789
<<<test_end>>>
<<<test_start>>>
tag=3Dpty04 stime=3D1657360582
cmdline=3D"pty04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
pty04.c:130: TINFO: PTS path is /dev/pts/0
pty04.c:105: TCONF: You don't appear to have the N_SLIP TTY line discipline=
: EINVAL (22)
pty04.c:130: TINFO: PTS path is /dev/pts/1
pty04.c:251: TINFO: Netdev is slcan0
pty04.c:260: TINFO: Netdev MTU is 16 (we set 16)
pty04.c:277: TINFO: Bound netdev 1880 to socket 8
tst_buffers.c:55: TINFO: Test is using guarded buffers
pty04.c:390: TINFO: Reading from socket 8
tst_buffers.c:55: TINFO: Test is using guarded buffers
pty04.c:214: TPASS: Wrote PTY N_SLCAN 6 (1)
pty04.c:223: TPASS: Wrote PTY N_SLCAN 6 (2)
pty04.c:396: TPASS: Read netdev N_SLCAN 8 (1)
pty04.c:402: TPASS: Read netdev N_SLCAN 8 (2)
pty04.c:408: TPASS: Write netdev N_SLCAN 8
pty04.c:229: TPASS: Read PTY N_SLCAN 6
pty04.c:419: TPASS: Data transmission on netdev interrupted by hangup
pty04.c:447: TINFO: Sent hangup ioctl to PTS
pty04.c:449: TINFO: Sent hangup ioctl to PTM
pty04.c:240: TPASS: Transmission on PTY interrupted by hangup

Summary:
passed   8
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dpty05 stime=3D1657360584
cmdline=3D"pty05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_taint.c:116: TCONF: Ignoring already set kernel warning taint
tst_test.c:1526: TINFO: Timeout per run is 0h 03m 00s
=2E./../../include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period end=
ed
=2E./../../include/tst_fuzzy_sync.h:307: TINFO: loop =3D 1024, delay_bias =
=3D 0
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =
=3D   -33ns, avg_dev =3D    29ns, dev_ratio =3D 0.87 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =
=3D 11187ns, avg_dev =3D   231ns, dev_ratio =3D 0.02 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =
=3D  2589ns, avg_dev =3D    74ns, dev_ratio =3D 0.03 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =
=3D  8564ns, avg_dev =3D   246ns, dev_ratio =3D 0.03 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =
=3D  4389  , avg_dev =3D   132  , dev_ratio =3D 0.03 }
=2E./../../include/tst_fuzzy_sync.h:654: TINFO: Exceeded execution loops, r=
equesting exit
pty05.c:84: TPASS: Nothing bad happened, probably

Summary:
passed   1
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D38 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D3792 cstime=3D3272
<<<test_end>>>
<<<test_start>>>
tag=3Dpty06 stime=3D1657360622
cmdline=3D"pty06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_taint.c:116: TCONF: Ignoring already set kernel warning taint
tst_test.c:1526: TINFO: Timeout per run is 0h 03m 00s
=2E./../../include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period end=
ed
=2E./../../include/tst_fuzzy_sync.h:307: TINFO: loop =3D 1024, delay_bias =
=3D 0
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =
=3D   106ns, avg_dev =3D    40ns, dev_ratio =3D 0.37 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =
=3D 507568ns, avg_dev =3D 88762ns, dev_ratio =3D 0.17 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =
=3D 1166134ns, avg_dev =3D 76299ns, dev_ratio =3D 0.07 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =
=3D -658460ns, avg_dev =3D 30231ns, dev_ratio =3D 0.05 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =
=3D 337678  , avg_dev =3D  8272  , dev_ratio =3D 0.02 }
=2E./../../include/tst_fuzzy_sync.h:648: TINFO: Exceeded execution time, re=
questing exit
pty06.c:75: TPASS: Did not crash with VT_DISALLOCATE

Summary:
passed   1
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D150 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D7945 cstime=3D6352
<<<test_end>>>
<<<test_start>>>
tag=3Dpty07 stime=3D1657360772
cmdline=3D"pty07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_taint.c:116: TCONF: Ignoring already set kernel warning taint
tst_test.c:1526: TINFO: Timeout per run is 0h 03m 00s
pty07.c:92: TINFO: Saving active console 1
=2E./../../include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period end=
ed
=2E./../../include/tst_fuzzy_sync.h:307: TINFO: loop =3D 1024, delay_bias =
=3D 0
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =
=3D    63ns, avg_dev =3D    65ns, dev_ratio =3D 1.03 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =
=3D 7138489ns, avg_dev =3D 6364336ns, dev_ratio =3D 0.89 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =
=3D 14932303ns, avg_dev =3D 9341556ns, dev_ratio =3D 0.63 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =
=3D -7793750ns, avg_dev =3D 4372816ns, dev_ratio =3D 0.56 }
=2E./../../include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =
=3D 3950443  , avg_dev =3D 2261165  , dev_ratio =3D 0.57 }
=2E./../../include/tst_fuzzy_sync.h:648: TINFO: Exceeded execution time, re=
questing exit
pty07.c:76: TPASS: Did not crash with VT_RESIZE
pty07.c:105: TINFO: Restoring active console

Summary:
passed   1
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D151 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D12885 cstime=3D4738
<<<test_end>>>
<<<test_start>>>
tag=3Dptem01 stime=3D1657360923
cmdline=3D"ptem01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
ptem01      1  TPASS  :  test1
ptem01      2  TPASS  :  test2
ptem01      3  TPASS  :  test3
ptem01      4  TPASS  :  test4
ptem01      5  TPASS  :  test5
ptem01      6  TPASS  :  test6
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dhangup01 stime=3D1657360923
cmdline=3D"hangup01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
hangup01    1  TPASS  :  child process exited with status 0
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: 20220527-61-g9fb28002b

       ###############################################################

            Done executing testcases.
            LTP Version:  20220527-61-g9fb28002b
       ###############################################################


--bn8MLYLeueJvdVUK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/ltp-part2.yaml:
suite: ltp
testcase: ltp
category: functional
need_memory: 4G
ltp:
  test: pty
job_origin: ltp-part2.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-ivb-d05
tbox_group: lkp-ivb-d05
submit_id: 62c7e0a8c0b3434e6ac7cc62
job_file: "/lkp/jobs/scheduled/lkp-ivb-d05/ltp-pty-ucode=0x21-debian-11.1-x86_64-20220510.cgz-c4e54b063f42f20a6b3ad1ffa61c574e631e0216-20220708-85610-1ar96k4-0.yaml"
id: 5d6b8a721a721478404994526b6e5a6be2df9f62
queuer_version: "/zday/lkp"
kconfig: x86_64-rhel-8.3-func
:#! hosts/lkp-ivb-d05:
model: Ivy Bridge
nr_node: 1
nr_cpu: 4
memory: 8G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402S31P2GGN-part2"
hdd_partitions: "/dev/disk/by-id/ata-ST1000DM003-1CH162_Z1DARLY7-part*"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402S31P2GGN-part1"
brand: Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz
:#! include/category/functional:
kmsg:
heartbeat:
meminfo:
:#! include/queue/cyclic:
commit: c4e54b063f42f20a6b3ad1ffa61c574e631e0216
:#! include/testbox/lkp-ivb-d05:
netconsole_port: 6679
ucode: '0x21'
need_kconfig_hw:
- NET_VENDOR_REALTEK: y
- R8169: y
- SATA_AHCI
- DRM_I915
bisect_dmesg: true
:#! include/ltp:
need_kconfig:
- BLK_DEV_LOOP
- CAN: m
- CAN_RAW: m
- CAN_VCAN: m
- MINIX_FS: m
- CHECKPOINT_RESTORE: y
initrds:
- linux_headers
enqueue_time: 2022-07-08 15:45:44.926173007 +08:00
_id: 62c7e0a8c0b3434e6ac7cc62
_rt: "/result/ltp/pty-ucode=0x21/lkp-ivb-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216"
:#! schedule options:
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 446cdfe20ee347c1bcdb51c63762e1a79d0c084d
base_commit: 88084a3df1672e131ddc1b4e39eeacfd39864acf
branch: linux-devel/devel-hourly-20220705-081417
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/ltp/pty-ucode=0x21/lkp-ivb-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/0"
scheduler_version: "/lkp/lkp/.src-20220708-122136"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/ltp/pty-ucode=0x21/lkp-ivb-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/vmlinuz-5.19.0-rc3-00630-gc4e54b063f42
- branch=linux-devel/devel-hourly-20220705-081417
- job=/lkp/jobs/scheduled/lkp-ivb-d05/ltp-pty-ucode=0x21-debian-11.1-x86_64-20220510.cgz-c4e54b063f42f20a6b3ad1ffa61c574e631e0216-20220708-85610-1ar96k4-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=c4e54b063f42f20a6b3ad1ffa61c574e631e0216
- max_uptime=2100
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/linux-headers.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/ltp_20220625.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/ltp-x86_64-14c1f76-1_20220625.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220216.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /cephfs/db/releases/20220704203309/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.19.0-rc5-01383-g016b87dd335c
schedule_notify_address:
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/c4e54b063f42f20a6b3ad1ffa61c574e631e0216/vmlinuz-5.19.0-rc3-00630-gc4e54b063f42"
dequeue_time: 2022-07-08 16:16:32.002620336 +08:00
:#! /cephfs/db/releases/20220708114728/lkp-src/include/site/inn:
job_state: finished
loadavg: 16.96 12.08 5.64 1/222 17615
start_time: '1657268395'
end_time: '1657268869'
version: "/lkp/lkp/.src-20220708-122214:5c8ed71e9:8e6e21b68"

--bn8MLYLeueJvdVUK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

./runltp -f pty

--bn8MLYLeueJvdVUK--
