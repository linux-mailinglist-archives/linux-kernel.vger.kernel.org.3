Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871B7547AEC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiFLQAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 12:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiFLQAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 12:00:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8106A48E75;
        Sun, 12 Jun 2022 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655049613; x=1686585613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hfsdRtvOv5RuaMM7eDuUtvAYpDCpQAZpjp8R6vHoXYU=;
  b=KQAcgS1213TBtDkU30kDSw7gBUbdip7QwlpJ2eZ5JIq3F5sULUGSU6jD
   zTHps1U2XU/vUCU4WtcLFqYMf/Q3JeNEaDAg6VTDmJFxfrUraxIhOEl1S
   SfsEpovFf/p9A6bjORVL3SaGTBfae5Qz7WFPeLLCjXEvwkF084ZjuW4Nr
   MU7Hou1K8hTWQEar+HHxZ0T9i+do4OqyxN8ke927KFpNTTQYyObD72SOH
   PDZAx7tT4O0UQ+aJtzbmK9bB5dXbcuEftEOOx2L4B4hQJ+oKyzHSmmX72
   orhGVn7z+2aLfJzMGz7NE8isvv8Y1dE/amf2vNEpXe/igc5/iJZE2DCpp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="339755539"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="xz'?yaml'?scan'208";a="339755539"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 09:00:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="xz'?yaml'?scan'208";a="639229928"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 09:00:09 -0700
Date:   Mon, 13 Jun 2022 00:00:06 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: [cpuidle,intel_idle]  32d4fd5751:
 WARNING:at_kernel/rcu/tree.c:#rcu_eqs_exit
Message-ID: <20220612160006.GB35020@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: 32d4fd5751eadbe1823a37eb38df85ec5c8e6207 ("cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: kernel-selftests
version: kernel-selftests-x86_64-cef46213-1_20220609
with following parameters:

	group: resctrl
	ucode: 0x500320a

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[ 29.104402][ T0] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:864 rcu_eqs_exit+0x4b/0xc0 
[   29.104417][    T0]
[   29.104418][    T0] =============================
[   29.104419][    T0] WARNING: suspicious RCU usage
[   29.104421][    T0] 5.19.0-rc1-00001-g32d4fd5751ea #1 Not tainted
[   29.104424][    T0] -----------------------------
[   29.104425][    T0] include/trace/events/lock.h:24 suspicious rcu_dereference_check() usage!
[   29.104428][    T0]
[   29.104428][    T0] other info that might help us debug this:
[   29.104428][    T0]
[   29.104430][    T0]
[   29.104430][    T0] rcu_scheduler_active = 2, debug_locks = 1
[   29.104432][    T0] RCU used illegally from extended quiescent state!
[   29.104433][    T0] no locks held by swapper/0/0.
[   29.104435][    T0]
[   29.104435][    T0] stack backtrace:
[   29.104436][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc1-00001-g32d4fd5751ea #1
[   29.104439][    T0] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
[   29.104441][    T0] Call Trace:
[   29.104443][    T0]  <TASK>
[ 29.104449][ T0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[ 29.104457][ T0] lock_acquire.cold (include/trace/events/lock.h:24 kernel/locking/lockdep.c:5636) 
[ 29.104465][ T0] ? rcu_read_unlock (include/linux/rcupdate.h:724 (discriminator 5)) 
[ 29.104480][ T0] ? check_prev_add (kernel/locking/lockdep.c:3785) 
[ 29.104483][ T0] ? console_trylock_spinning (kernel/printk/printk.c:2000) 
[ 29.104490][ T0] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 29.104495][ T0] ? down_trylock (kernel/locking/semaphore.c:140) 
[ 29.104499][ T0] down_trylock (kernel/locking/semaphore.c:140) 
[ 29.104501][ T0] ? console_trylock_spinning (kernel/printk/printk.c:2000) 
[ 29.104505][ T0] __down_trylock_console_sem (kernel/printk/printk.c:273) 
[ 29.104509][ T0] console_trylock (kernel/printk/printk.c:2728) 
[ 29.104512][ T0] console_trylock_spinning (kernel/printk/printk.c:2000) 
[ 29.104517][ T0] vprintk_emit (kernel/printk/printk.c:2400) 
[ 29.104520][ T0] ? __irq_work_queue_local (kernel/irq_work.c:101 (discriminator 1)) 
[ 29.104528][ T0] ? rcu_eqs_exit+0x4b/0xc0 
[ 29.104533][ T0] _printk (kernel/printk/printk.c:2417) 
[ 29.104537][ T0] ? record_print_text.cold (kernel/printk/printk.c:2417) 
[ 29.104540][ T0] ? rcu_eqs_exit+0x4b/0xc0 
[ 29.104545][ T0] ? _printk (kernel/printk/printk.c:2417) 
[ 29.104548][ T0] ? record_print_text.cold (kernel/printk/printk.c:2417) 
[ 29.104557][ T0] ? rcu_eqs_exit+0x4b/0xc0 
[ 29.104561][ T0] __warn (kernel/panic.c:616) 
[ 29.104569][ T0] ? rcu_eqs_exit+0x4b/0xc0 
[ 29.104574][ T0] report_bug (lib/bug.c:200) 
[ 29.104585][ T0] handle_bug (arch/x86/kernel/traps.c:316) 
[ 29.104588][ T0] exc_invalid_op (arch/x86/kernel/traps.c:336 (discriminator 1)) 
[ 29.104592][ T0] asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 29.104596][ T0] RIP: rcu_eqs_exit+0x4b/0xc0 
[ 29.104600][ T0] Code: 1d 32 68 43 7c 48 8b 83 40 01 00 00 48 85 c0 74 1d 48 83 c0 01 48 89 83 40 01 00 00 5b 5d c3 65 8b 05 75 ca 43 7c 85 c0 74 cc <0f> 0b eb c8 e8 6c ff ff ff 48 8d ab 50 01 00 00 be 04 00 00 00 48
All code
========
   0:	1d 32 68 43 7c       	sbb    $0x7c436832,%eax
   5:	48 8b 83 40 01 00 00 	mov    0x140(%rbx),%rax
   c:	48 85 c0             	test   %rax,%rax
   f:	74 1d                	je     0x2e
  11:	48 83 c0 01          	add    $0x1,%rax
  15:	48 89 83 40 01 00 00 	mov    %rax,0x140(%rbx)
  1c:	5b                   	pop    %rbx
  1d:	5d                   	pop    %rbp
  1e:	c3                   	retq   
  1f:	65 8b 05 75 ca 43 7c 	mov    %gs:0x7c43ca75(%rip),%eax        # 0x7c43ca9b
  26:	85 c0                	test   %eax,%eax
  28:	74 cc                	je     0xfffffffffffffff6
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb c8                	jmp    0xfffffffffffffff6
  2e:	e8 6c ff ff ff       	callq  0xffffffffffffff9f
  33:	48 8d ab 50 01 00 00 	lea    0x150(%rbx),%rbp
  3a:	be 04 00 00 00       	mov    $0x4,%esi
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb c8                	jmp    0xffffffffffffffcc
   4:	e8 6c ff ff ff       	callq  0xffffffffffffff75
   9:	48 8d ab 50 01 00 00 	lea    0x150(%rbx),%rbp
  10:	be 04 00 00 00       	mov    $0x4,%esi
  15:	48                   	rex.W
[   29.104603][    T0] RSP: 0000:ffffffff85207da0 EFLAGS: 00010002
[   29.104607][    T0] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff825face9
[   29.104609][    T0] RDX: 1ffffffff0b823e0 RSI: 0000000000000008 RDI: ffffffff852387c0
[   29.104611][    T0] RBP: ffffffff85c11e40 R08: 0000000000000000 R09: ffffffff852387c7
[   29.104612][    T0] R10: fffffbfff0a470f8 R11: 0000000000000001 R12: 0000000000000001
[   29.104614][    T0] R13: ffffe8ec26c031ec R14: ffffffff85c11ec0 R15: ffffe8ec26c031e8
[ 29.104623][ T0] ? mwait_idle_with_hints (include/linux/instrumented.h:71 include/asm-generic/bitops/instrumented-non-atomic.h:134 include/linux/thread_info.h:118 include/linux/sched/idle.h:88 arch/x86/include/asm/mwait.h:120) 
[ 29.104635][ T0] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:239) 
[ 29.104648][ T0] cpuidle_enter (drivers/cpuidle/cpuidle.c:353) 
[ 29.104653][ T0] cpuidle_idle_call (kernel/sched/idle.c:155 kernel/sched/idle.c:236) 
[ 29.104659][ T0] ? arch_cpu_idle_exit+0xc0/0xc0 
[ 29.104664][ T0] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4526) 
[ 29.104667][ T0] ? tick_nohz_idle_enter (arch/x86/include/asm/irqflags.h:45 (discriminator 3) arch/x86/include/asm/irqflags.h:80 (discriminator 3) kernel/time/tick-sched.c:1163 (discriminator 3)) 
[ 29.104671][ T0] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:50 (discriminator 22)) 
[ 29.104676][ T0] ? tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sync.c:58) 
[ 29.104685][ T0] do_idle (kernel/sched/idle.c:303) 
[ 29.104690][ T0] cpu_startup_entry (kernel/sched/idle.c:399 (discriminator 1)) 
[ 29.104694][ T0] rest_init (include/linux/rcupdate.h:696 init/main.c:697) 
[ 29.104698][ T0] arch_call_rest_init+0xf/0x15 
[ 29.104704][ T0] start_kernel (init/main.c:1139) 
[ 29.104709][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358) 
[   29.104728][    T0]  </TASK>
[   29.104730][    T0]
[   29.104731][    T0] =============================
[   29.104732][    T0] WARNING: suspicious RCU usage
[   29.104732][    T0] 5.19.0-rc1-00001-g32d4fd5751ea #1 Not tainted
[   29.104734][    T0] -----------------------------
[   29.104734][    T0] include/trace/events/lock.h:69 suspicious rcu_dereference_check() usage!
[   29.104736][    T0]
[   29.104736][    T0] other info that might help us debug this:
[   29.104736][    T0]
[   29.104737][    T0]
[   29.104737][    T0] rcu_scheduler_active = 2, debug_locks = 1
[   29.104738][    T0] RCU used illegally from extended quiescent state!
[   29.104739][    T0] 1 lock held by swapper/0/0:
[ 29.104740][ T0] #0: ffffffff85778a98 ((console_sem).lock){....}-{2:2}, at: down_trylock (kernel/locking/semaphore.c:140) 
[   29.104748][    T0]
[   29.104748][    T0] stack backtrace:
[   29.104749][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc1-00001-g32d4fd5751ea #1
[   29.104751][    T0] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
[   29.104752][    T0] Call Trace:
[   29.104753][    T0]  <TASK>
[ 29.104756][ T0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[ 29.104760][ T0] ? down_trylock (kernel/locking/semaphore.c:145) 
[ 29.104761][ T0] lock_release.cold (include/trace/events/lock.h:69 kernel/locking/lockdep.c:5676) 
[ 29.104766][ T0] _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194) 
[ 29.104770][ T0] down_trylock (kernel/locking/semaphore.c:145) 
[ 29.104772][ T0] ? console_trylock_spinning (kernel/printk/printk.c:2000) 
[ 29.104775][ T0] __down_trylock_console_sem (kernel/printk/printk.c:273) 
[ 29.104779][ T0] console_trylock (kernel/printk/printk.c:2728) 
[ 29.104782][ T0] console_trylock_spinning (kernel/printk/printk.c:2000) 
[ 29.104787][ T0] vprintk_emit (kernel/printk/printk.c:2400) 
[ 29.104790][ T0] ? __irq_work_queue_local (kernel/irq_work.c:101 (discriminator 1)) 
[ 29.104796][ T0] ? rcu_eqs_exit+0x4b/0xc0 
[ 29.104800][ T0] _printk (kernel/printk/printk.c:2417) 
[ 29.104804][ T0] ? record_print_text.cold (kernel/printk/printk.c:2417) 
[ 29.104806][ T0] ? rcu_eqs_exit+0x4b/0xc0 
[ 29.104811][ T0] ? _printk (kernel/printk/printk.c:2417) 
[ 29.104815][ T0] ? record_print_text.cold (kernel/printk/printk.c:2417) 
[ 29.104825][ T0] ? rcu_eqs_exit+0x4b/0xc0 
[ 29.104829][ T0] __warn (kernel/panic.c:616) 
[ 29.104833][ T0] ? rcu_eqs_exit+0x4b/0xc0 
[ 29.104838][ T0] report_bug (lib/bug.c:200) 
[ 29.104847][ T0] handle_bug (arch/x86/kernel/traps.c:316) 
[ 29.104850][ T0] exc_invalid_op (arch/x86/kernel/traps.c:336 (discriminator 1)) 
[ 29.104854][ T0] asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 29.104856][ T0] RIP: rcu_eqs_exit+0x4b/0xc0 
[ 29.104859][ T0] Code: 1d 32 68 43 7c 48 8b 83 40 01 00 00 48 85 c0 74 1d 48 83 c0 01 48 89 83 40 01 00 00 5b 5d c3 65 8b 05 75 ca 43 7c 85 c0 74 cc <0f> 0b eb c8 e8 6c ff ff ff 48 8d ab 50 01 00 00 be 04 00 00 00 48
All code
========
   0:	1d 32 68 43 7c       	sbb    $0x7c436832,%eax
   5:	48 8b 83 40 01 00 00 	mov    0x140(%rbx),%rax
   c:	48 85 c0             	test   %rax,%rax
   f:	74 1d                	je     0x2e
  11:	48 83 c0 01          	add    $0x1,%rax
  15:	48 89 83 40 01 00 00 	mov    %rax,0x140(%rbx)
  1c:	5b                   	pop    %rbx
  1d:	5d                   	pop    %rbp
  1e:	c3                   	retq   
  1f:	65 8b 05 75 ca 43 7c 	mov    %gs:0x7c43ca75(%rip),%eax        # 0x7c43ca9b
  26:	85 c0                	test   %eax,%eax
  28:	74 cc                	je     0xfffffffffffffff6
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb c8                	jmp    0xfffffffffffffff6
  2e:	e8 6c ff ff ff       	callq  0xffffffffffffff9f
  33:	48 8d ab 50 01 00 00 	lea    0x150(%rbx),%rbp
  3a:	be 04 00 00 00       	mov    $0x4,%esi
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb c8                	jmp    0xffffffffffffffcc
   4:	e8 6c ff ff ff       	callq  0xffffffffffffff75
   9:	48 8d ab 50 01 00 00 	lea    0x150(%rbx),%rbp
  10:	be 04 00 00 00       	mov    $0x4,%esi
  15:	48                   	rex.W
[   29.104861][    T0] RSP: 0000:ffffffff85207da0 EFLAGS: 00010002
[   29.104863][    T0] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff825face9
[   29.104865][    T0] RDX: 1ffffffff0b823e0 RSI: 0000000000000008 RDI: ffffffff852387c0
[   29.104866][    T0] RBP: ffffffff85c11e40 R08: 0000000000000000 R09: ffffffff852387c7
[   29.104867][    T0] R10: fffffbfff0a470f8 R11: 0000000000000001 R12: 0000000000000001
[   29.104868][    T0] R13: ffffe8ec26c031ec R14: ffffffff85c11ec0 R15: ffffe8ec26c031e8
[ 29.104878][ T0] ? mwait_idle_with_hints (include/linux/instrumented.h:71 include/asm-generic/bitops/instrumented-non-atomic.h:134 include/linux/thread_info.h:118 include/linux/sched/idle.h:88 arch/x86/include/asm/mwait.h:120) 
[ 29.104888][ T0] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:239) 
[ 29.104897][ T0] cpuidle_enter (drivers/cpuidle/cpuidle.c:353) 
[ 29.104903][ T0] cpuidle_idle_call (kernel/sched/idle.c:155 kernel/sched/idle.c:236) 
[ 29.104907][ T0] ? arch_cpu_idle_exit+0xc0/0xc0 
[ 29.104912][ T0] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4526) 
[ 29.104915][ T0] ? tick_nohz_idle_enter (arch/x86/include/asm/irqflags.h:45 (discriminator 3) arch/x86/include/asm/irqflags.h:80 (discriminator 3) kernel/time/tick-sched.c:1163 (discriminator 3)) 
[ 29.104917][ T0] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:50 (discriminator 22)) 
[ 29.104919][ T0] ? tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sync.c:58) 
[ 29.104926][ T0] do_idle (kernel/sched/idle.c:303) 
[ 29.104931][ T0] cpu_startup_entry (kernel/sched/idle.c:399 (discriminator 1)) 
[ 29.104935][ T0] rest_init (include/linux/rcupdate.h:696 init/main.c:697) 
[ 29.104939][ T0] arch_call_rest_init+0xf/0x15 
[ 29.104941][ T0] start_kernel (init/main.c:1139) 
[ 29.104947][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358) 
[   29.104964][    T0]  </TASK>
[   29.105350][    T0]
[   29.105350][    T0] =============================
[   29.105350][    T0] WARNING: suspicious RCU usage
[   29.105350][    T0] 5.19.0-rc1-00001-g32d4fd5751ea #1 Not tainted
[   29.105350][    T0] -----------------------------
[   29.105350][    T0] include/linux/rcupdate.h:696 rcu_read_lock() used illegally while idle!
[   29.105350][    T0]
[   29.105350][    T0] other info that might help us debug this:
[   29.105350][    T0]
[   29.105350][    T0]
[   29.105350][    T0] rcu_scheduler_active = 2, debug_locks = 1
[   29.105350][    T0] RCU used illegally from extended quiescent state!
[   29.105350][    T0] 4 locks held by swapper/0/0:
[ 29.105350][ T0] #0: ffffffff85778a20 (console_lock){+.+.}-{0:0}, at: console_trylock_spinning (kernel/printk/printk.c:2000) 
[ 29.105350][ T0] #1: ffffffff853f8380 (console_owner){....}-{0:0}, at: __console_emit_next_record (kernel/printk/printk.c:2909 (discriminator 3)) 
[ 29.105350][ T0] #2: ffffffff85ca5098 (printing_lock){+.+.}-{2:2}, at: vt_console_print (drivers/tty/vt/vt.c:3090) 
[ 29.105350][ T0] #3: ffffffff85789b40 (rcu_read_lock){....}-{1:2}, at: atomic_notifier_call_chain (kernel/notifier.c:221) 
[   29.105350][    T0]
[   29.105350][    T0] stack backtrace:
[   29.105350][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc1-00001-g32d4fd5751ea #1
[   29.105350][    T0] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
[   29.105350][    T0] Call Trace:
[   29.105350][    T0]  <TASK>
[ 29.105350][ T0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[ 29.105350][ T0] atomic_notifier_call_chain (include/linux/rcupdate.h:696 kernel/notifier.c:224) 
[ 29.105350][ T0] vt_console_print (drivers/tty/vt/vt.c:3137) 
[ 29.105350][ T0] ? __lock_acquire (kernel/locking/lockdep.c:4973) 
[ 29.105350][ T0] ? lf (drivers/tty/vt/vt.c:3079) 
[ 29.105350][ T0] ? rwlock_bug+0xc0/0xc0 
[ 29.105350][ T0] ? __console_emit_next_record (kernel/printk/printk.c:1938 (discriminator 3) kernel/printk/printk.c:2910 (discriminator 3)) 
[ 29.105350][ T0] __console_emit_next_record (kernel/printk/printk.c:2075 kernel/printk/printk.c:2916) 
[ 29.105350][ T0] ? record_print_text.cold (kernel/printk/printk.c:2417) 
[ 29.105350][ T0] ? devkmsg_read (kernel/printk/printk.c:2856) 
[ 29.105350][ T0] ? __lock_acquire (kernel/locking/lockdep.c:5053) 
[ 29.105350][ T0] ? lock_acquire (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:5667 kernel/locking/lockdep.c:5630) 
[ 29.105350][ T0] console_flush_all (kernel/printk/printk.c:2950 kernel/printk/printk.c:3007) 
[ 29.105350][ T0] console_unlock (kernel/printk/printk.c:3074) 
[ 29.105350][ T0] ? wake_up_klogd (kernel/printk/printk.c:3046) 
[ 29.105350][ T0] ? kmsg_dump_register (kernel/printk/printk.c:4043) 
[ 29.105350][ T0] ? __down_trylock_console_sem (kernel/printk/printk.c:279) 
[ 29.105350][ T0] vprintk_emit (kernel/printk/printk.c:2401) 
[ 29.105350][ T0] ? __irq_work_queue_local (kernel/irq_work.c:101 (discriminator 1)) 
[ 29.105350][ T0] ? rcu_eqs_exit+0x4b/0xc0 
[ 29.105350][ T0] _printk (kernel/printk/printk.c:2417) 
[ 29.105350][ T0] ? record_print_text.cold (kernel/printk/printk.c:2417) 
[ 29.105350][ T0] ? rcu_eqs_exit+0x4b/0xc0 
[ 29.105350][ T0] ? _printk (kernel/printk/printk.c:2417) 
[ 29.105350][ T0] ? record_print_text.cold (kernel/printk/printk.c:2417) 
[ 29.105350][ T0] ? rcu_eqs_exit+0x4b/0xc0 
[ 29.105350][ T0] __warn (kernel/panic.c:616) 
[ 29.105350][ T0] ? rcu_eqs_exit+0x4b/0xc0 
[ 29.105350][ T0] report_bug (lib/bug.c:200) 
[ 29.105350][ T0] handle_bug (arch/x86/kernel/traps.c:316) 
[ 29.105350][ T0] exc_invalid_op (arch/x86/kernel/traps.c:336 (discriminator 1)) 
[ 29.105350][ T0] asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 29.105350][ T0] RIP: rcu_eqs_exit+0x4b/0xc0 
[ 29.105350][ T0] Code: 1d 32 68 43 7c 48 8b 83 40 01 00 00 48 85 c0 74 1d 48 83 c0 01 48 89 83 40 01 00 00 5b 5d c3 65 8b 05 75 ca 43 7c 85 c0 74 cc <0f> 0b eb c8 e8 6c ff ff ff 48 8d ab 50 01 00 00 be 04 00 00 00 48
All code
========
   0:	1d 32 68 43 7c       	sbb    $0x7c436832,%eax
   5:	48 8b 83 40 01 00 00 	mov    0x140(%rbx),%rax
   c:	48 85 c0             	test   %rax,%rax
   f:	74 1d                	je     0x2e
  11:	48 83 c0 01          	add    $0x1,%rax
  15:	48 89 83 40 01 00 00 	mov    %rax,0x140(%rbx)
  1c:	5b                   	pop    %rbx
  1d:	5d                   	pop    %rbp
  1e:	c3                   	retq   
  1f:	65 8b 05 75 ca 43 7c 	mov    %gs:0x7c43ca75(%rip),%eax        # 0x7c43ca9b
  26:	85 c0                	test   %eax,%eax
  28:	74 cc                	je     0xfffffffffffffff6
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb c8                	jmp    0xfffffffffffffff6
  2e:	e8 6c ff ff ff       	callq  0xffffffffffffff9f
  33:	48 8d ab 50 01 00 00 	lea    0x150(%rbx),%rbp
  3a:	be 04 00 00 00       	mov    $0x4,%esi
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb c8                	jmp    0xffffffffffffffcc
   4:	e8 6c ff ff ff       	callq  0xffffffffffffff75
   9:	48 8d ab 50 01 00 00 	lea    0x150(%rbx),%rbp
  10:	be 04 00 00 00       	mov    $0x4,%esi
  15:	48                   	rex.W
[   29.105350][    T0] RSP: 0000:ffffffff85207da0 EFLAGS: 00010002
[   29.105350][    T0] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff825face9
[   29.105350][    T0] RDX: 1ffffffff0b823e0 RSI: 0000000000000008 RDI: ffffffff852387c0
[   29.105350][    T0] RBP: ffffffff85c11e40 R08: 0000000000000000 R09: ffffffff852387c7
[   29.105350][    T0] R10: fffffbfff0a470f8 R11: 0000000000000001 R12: 0000000000000001
[   29.105350][    T0] R13: ffffe8ec26c031ec R14: ffffffff85c11ec0 R15: ffffe8ec26c031e8
[ 29.105350][ T0] ? mwait_idle_with_hints (include/linux/instrumented.h:71 include/asm-generic/bitops/instrumented-non-atomic.h:134 include/linux/thread_info.h:118 include/linux/sched/idle.h:88 arch/x86/include/asm/mwait.h:120) 
[ 29.105350][ T0] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:239) 
[ 29.105350][ T0] cpuidle_enter (drivers/cpuidle/cpuidle.c:353) 
[ 29.105350][ T0] cpuidle_idle_call (kernel/sched/idle.c:155 kernel/sched/idle.c:236) 
[ 29.105350][ T0] ? arch_cpu_idle_exit+0xc0/0xc0 
[ 29.105350][ T0] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4526) 
[ 29.105350][ T0] ? tick_nohz_idle_enter (arch/x86/include/asm/irqflags.h:45 (discriminator 3) arch/x86/include/asm/irqflags.h:80 (discriminator 3) kernel/time/tick-sched.c:1163 (discriminator 3)) 
[ 29.105350][ T0] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:50 (discriminator 22)) 
[ 29.105350][ T0] ? tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sync.c:58) 
[ 29.105350][ T0] do_idle (kernel/sched/idle.c:303) 
[ 29.105350][ T0] cpu_startup_entry (kernel/sched/idle.c:399 (discriminator 1)) 
[ 29.105350][ T0] rest_init (include/linux/rcupdate.h:696 init/main.c:697) 
[ 29.105350][ T0] arch_call_rest_init+0xf/0x15 
[ 29.105350][ T0] start_kernel (init/main.c:1139) 
[ 29.105350][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358) 
[   29.105350][    T0]  </TASK>
[   29.105350][    T0]
[   29.105350][    T0] =============================


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



--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.19.0-rc1-00001-g32d4fd5751ea"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.19.0-rc1 Kernel Configuration
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
# CONFIG_WATCH_QUEUE is not set
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
CONFIG_IRQ_SIM=y
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
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
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
CONFIG_EXPERT=y
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
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

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
CONFIG_X86_CPU_RESCTRL=y
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
# CONFIG_PROCESSOR_SELECT is not set
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
CONFIG_X86_SGX=y
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
# CONFIG_SUSPEND_SKIP_SYNC is not set
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
# CONFIG_DPM_WATCHDOG is not set
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
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
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
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
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
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_X86_SGX_KVM is not set
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
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
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
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y

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
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
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
CONFIG_UNINLINE_SPIN_UNLOCK=y
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
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
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
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_VM_GET_PAGE_PROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
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
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER=y
CONFIG_PTE_MARKER_UFFD_WP=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
# CONFIG_DAMON_SYSFS is not set
CONFIG_DAMON_DBGFS=y
# CONFIG_DAMON_RECLAIM is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
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
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
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
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
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
CONFIG_NFT_FLOW_OFFLOAD=m
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
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
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
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
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
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
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
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_FQ_PIE is not set
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
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
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

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
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
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
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
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
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
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
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
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
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
# CONFIG_SCSI_DEBUG is not set
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
# CONFIG_PATA_PLATFORM is not set
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
# CONFIG_MD_MULTIPATH is not set
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
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_AMT=m
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
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
# CONFIG_PCS_XPCS is not set
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
# CONFIG_MAC80211_HWSIM is not set
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
CONFIG_NETDEVSIM=m
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
# CONFIG_INPUT_MISC is not set
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
# CONFIG_TTY_PRINTK is not set
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
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
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
CONFIG_I2C_SMBUS=m
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
CONFIG_I2C_I801=m
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
CONFIG_GPIO_SYSFS=y
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
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
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
CONFIG_LPC_ICH=m
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
CONFIG_IR_SHARP_DECODER=m
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
CONFIG_RC_LOOPBACK=m
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
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
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
CONFIG_DRM_GEM_SHMEM_HELPER=y

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

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
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
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_LIB_RANDOM=y
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
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
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
# CONFIG_INFINIBAND is not set
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
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
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
CONFIG_IRQ_BYPASS_MANAGER=y
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
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set

#
# VME Device Drivers
#
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
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
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
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
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
# CONFIG_XFS_ONLINE_REPAIR is not set
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
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
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
CONFIG_NETFS_SUPPORT=m
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
CONFIG_PROC_CPU_RESCTRL=y
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
# CONFIG_MINIX_FS is not set
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
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
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
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
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
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
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
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_IMA_DISABLE_HTABLE is not set
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
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
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
CONFIG_PRIME_NUMBERS=m
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
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
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
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
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
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
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
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20
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
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
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
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
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
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
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
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
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
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='kernel-selftests-resctrl.yaml'
	export queue='validate'
	export testbox='lkp-csl-2sp9'
	export commit='32d4fd5751eadbe1823a37eb38df85ec5c8e6207'
	export branch='linus/master'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export name='/cephfs/tmp/d20220611-81739-1egtr4m/kernel-selftests-resctrl.yaml'
	export tbox_group='lkp-csl-2sp9'
	export submit_id='62a50c25319ce72f58eea028'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp9/kernel-selftests-resctrl-ucode=0x500320a-debian-11.1-x86_64-20220510.cgz-32d4fd5751eadbe1823a37eb38df85ec5c8e6207-20220612-12120-jkfy22-11.yaml'
	export id='655eb9f225948dc6abc822a92095dfc1b17d0c0e'
	export queuer_version='/zday/lkp'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=88
	export memory='128G'
	export nr_hdd_partitions=4
	export nr_ssd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC13Q1RD-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part1'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part2'
	export brand='Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz'
	export ucode='0x500320a'
	export need_kconfig_hw='{"I40E"=>"y"}
SATA_AHCI'
	export need_kconfig=\{\"X86_CPU_RESCTRL\"\=\>\"y\"\}'
'\{\"PROC_CPU_RESCTRL\"\=\>\"y\"\}
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export initrds='linux_headers
linux_selftests'
	export enqueue_time='2022-06-12 05:41:57 +0800'
	export compiler='gcc-11'
	export _id='62a50c26319ce72f58eea02e'
	export _rt='/result/kernel-selftests/resctrl-ucode=0x500320a/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/kernel-selftests/resctrl-ucode=0x500320a/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/8'
	export scheduler_version='/lkp/lkp/.src-20220609-105305'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/resctrl-ucode=0x500320a/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/8
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/vmlinuz-5.19.0-rc1-00001-g32d4fd5751ea
branch=linus/master
job=/lkp/jobs/scheduled/lkp-csl-2sp9/kernel-selftests-resctrl-ucode=0x500320a-debian-11.1-x86_64-20220510.cgz-32d4fd5751eadbe1823a37eb38df85ec5c8e6207-20220612-12120-jkfy22-11.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=32d4fd5751eadbe1823a37eb38df85ec5c8e6207
erst_disable
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/kernel-selftests_20220609.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/kernel-selftests-x86_64-cef46213-1_20220609.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220216.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.19.0-rc1-mm-unstable-damon-wt-ath-05930-gbe7d66b30a77'
	export repeat_to=14
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export stop_repeat_if_found='dmesg.include/linux/rcupdate.h:#rcu_read_unlock()used_illegally_while_idle'
	export kbuild_queue_analysis=1
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/vmlinuz-5.19.0-rc1-00001-g32d4fd5751ea'
	export dequeue_time='2022-06-12 05:54:48 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp9/kernel-selftests-resctrl-ucode=0x500320a-debian-11.1-x86_64-20220510.cgz-32d4fd5751eadbe1823a37eb38df85ec5c8e6207-20220612-12120-jkfy22-11.cgz'

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

	run_test group='resctrl' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='resctrl' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--3lcZGd9BuhuYXNfi
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
ojUAAZKaAsySEeEzNhOxxGf7AgAAAAAEWVo=

--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-32d4fd5751eadbe1823a37eb38df85ec5c8e6207
2022-06-11 21:56:35 ln -sf /usr/bin/clang
2022-06-11 21:56:35 ln -sf /usr/bin/llc
2022-06-11 21:56:35 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2022-06-11 21:56:37 resctrl/resctrl_tests
TAP version 13
# Pass: Check kernel supports resctrl filesystem
# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
# resctrl filesystem not mounted
# dmesg: [   34.928402] resctrl: MB allocation detected
# dmesg: [   34.928412] resctrl: L3 monitoring detected
1..4
# Starting MBM BW change ...
# Mounting resctrl to "/sys/fs/resctrl"
# Mounting resctrl to "/sys/fs/resctrl"
TAP version 13
# Pass: Check kernel supports resctrl filesystem
# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
# resctrl filesystem not mounted
# dmesg: [   34.928402] resctrl: MB allocation detected
# dmesg: [   34.928412] resctrl: L3 monitoring detected
1..4
# Starting MBM BW change ...
# Mounting resctrl to "/sys/fs/resctrl"
# Mounting resctrl to "/sys/fs/resctrl"
# Benchmark PID: 2005
# Writing benchmark parameters to resctrl FS
# Checking for pass/fail
# Pass: Check MBM diff within 5%
# avg_diff_per: 3%
# Span (MB): 250
# avg_bw_imc: 13243
# avg_bw_resc: 13698
ok 1 MBM: bw change
# Starting MBA Schemata change ...
# Mounting resctrl to "/sys/fs/resctrl"
# Mounting resctrl to "/sys/fs/resctrl"
Failed to open cache level: No such file or directory
TAP version 13
# Pass: Check kernel supports resctrl filesystem
# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
# resctrl filesystem not mounted
# dmesg: [   34.928402] resctrl: MB allocation detected
# dmesg: [   34.928412] resctrl: L3 monitoring detected
1..4
# Starting MBM BW change ...
# Mounting resctrl to "/sys/fs/resctrl"
# Mounting resctrl to "/sys/fs/resctrl"
# Benchmark PID: 2005
# Writing benchmark parameters to resctrl FS
# Checking for pass/fail
# Pass: Check MBM diff within 5%
# avg_diff_per: 3%
# Span (MB): 250
# avg_bw_imc: 13243
# avg_bw_resc: 13698
ok 1 MBM: bw change
# Starting MBA Schemata change ...
# Mounting resctrl to "/sys/fs/resctrl"
# Mounting resctrl to "/sys/fs/resctrl"
# Benchmark PID: 2025
# Writing benchmark parameters to resctrl FS
# Write schema "MB:0=100" to resctrl FS
# Write schema "MB:0=90" to resctrl FS
# Write schema "MB:0=80" to resctrl FS
# Write schema "MB:0=70" to resctrl FS
# Write schema "MB:0=60" to resctrl FS
# Write schema "MB:0=50" to resctrl FS
# Write schema "MB:0=40" to resctrl FS
# Write schema "MB:0=30" to resctrl FS
# Write schema "MB:0=20" to resctrl FS
# Write schema "MB:0=10" to resctrl FS
# Results are displayed in (MB)
# Pass: Check MBA diff within 5% for schemata 100
# avg_diff_per: 3%
# avg_bw_imc: 12969
# avg_bw_resc: 13379
# Pass: Check MBA diff within 5% for schemata 90
# avg_diff_per: 3%
# avg_bw_imc: 9574
# avg_bw_resc: 9956
# Pass: Check MBA diff within 5% for schemata 80
# avg_diff_per: 4%
# avg_bw_imc: 9622
# avg_bw_resc: 10064
# Pass: Check MBA diff within 5% for schemata 70
# avg_diff_per: 4%
# avg_bw_imc: 9657
# avg_bw_resc: 10064
# Pass: Check MBA diff within 5% for schemata 60
# avg_diff_per: 4%
# avg_bw_imc: 8304
# avg_bw_resc: 8647
# Pass: Check MBA diff within 5% for schemata 50
# avg_diff_per: 3%
# avg_bw_imc: 7326
# avg_bw_resc: 7612
# Pass: Check MBA diff within 5% for schemata 40
# avg_diff_per: 4%
# avg_bw_imc: 7123
# avg_bw_resc: 7413
# Pass: Check MBA diff within 5% for schemata 30
# avg_diff_per: 2%
# avg_bw_imc: 3982
# avg_bw_resc: 4096
# Pass: Check MBA diff within 5% for schemata 20
# avg_diff_per: 2%
# avg_bw_imc: 2864
# avg_bw_resc: 2935
# Pass: Check MBA diff within 5% for schemata 10
# avg_diff_per: 1%
# avg_bw_imc: 1902
# avg_bw_resc: 1931
# Pass: Check schemata change using MBA
ok 2 MBA: schemata change
# Starting CMT test ...
# Mounting resctrl to "/sys/fs/resctrl"
# Mounting resctrl to "/sys/fs/resctrl"
not ok 3 CMT: test
# Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.
# Starting CAT test ...
ok 4 # SKIP Hardware does not support CAT or CAT is disabled
# Totals: pass:2 fail:1 xfail:0 xpass:0 skip:1 error:0

--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! /cephfs/tmp/d20220610-31605-1tk7x0y/kernel-selftests-resctrl.yaml:
suite: kernel-selftests
testcase: kernel-selftests
category: functional
need_memory: 2G
need_cpu: 2
kernel-selftests:
  group: resctrl
kernel_cmdline: erst_disable
job_origin: kernel-selftests-resctrl.yaml
queue: bisect
testbox: lkp-csl-2sp9
commit: 32d4fd5751eadbe1823a37eb38df85ec5c8e6207
branch: internal-eywa/master
kconfig: x86_64-rhel-8.3-kselftests
name: "/cephfs/tmp/d20220610-31605-1tk7x0y/kernel-selftests-resctrl.yaml"
tbox_group: lkp-csl-2sp9
submit_id: 62a37baaf3633fb4237fd045
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp9/kernel-selftests-resctrl-ucode=0x500320a-debian-11.1-x86_64-20220510.cgz-32d4fd5751eadbe1823a37eb38df85ec5c8e6207-20220611-46115-ov9xdq-0.yaml"
id: 7d1c4936c3d89b2e1625bbbeb3f69cf33ef3a80c
queuer_version: "/zday/lkp"
:#! hosts/lkp-csl-2sp9:
model: Cascade Lake
nr_node: 2
nr_cpu: 88
memory: 128G
nr_hdd_partitions: 4
nr_ssd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC13Q1RD-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part1"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part2"
brand: Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz
:#! include/category/functional:
kmsg:
heartbeat:
meminfo:
:#! include/testbox/lkp-csl-2sp9:
ucode: '0x500320a'
need_kconfig_hw:
- I40E: y
- SATA_AHCI
:#! include/kernel-selftests:
need_kconfig:
- X86_CPU_RESCTRL: y
- PROC_CPU_RESCTRL: y
rootfs: debian-11.1-x86_64-20220510.cgz
initrds:
- linux_headers
- linux_selftests
enqueue_time: 2022-06-11 01:13:15.018608558 +08:00
compiler: gcc-11
_id: 62a37baaf3633fb4237fd045
_rt: "/result/kernel-selftests/resctrl-ucode=0x500320a/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207"
:#! schedule options:
user: lkp
LKP_SERVER: internal-lkp-server
result_root: "/result/kernel-selftests/resctrl-ucode=0x500320a/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/0"
scheduler_version: "/lkp/lkp/.src-20220609-105305"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/resctrl-ucode=0x500320a/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/vmlinuz-5.19.0-rc1-00001-g32d4fd5751ea
- branch=internal-eywa/master
- job=/lkp/jobs/scheduled/lkp-csl-2sp9/kernel-selftests-resctrl-ucode=0x500320a-debian-11.1-x86_64-20220510.cgz-32d4fd5751eadbe1823a37eb38df85ec5c8e6207-20220611-46115-ov9xdq-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=32d4fd5751eadbe1823a37eb38df85ec5c8e6207
- erst_disable
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/kernel-selftests_20220609.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/kernel-selftests-x86_64-cef46213-1_20220609.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220216.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /cephfs/db/releases/20220609185001/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.19.0-rc1-mm-unstable-damon-wt-ath-05060-ga9ec10553d0f
:#! queue options:
queue_cmdline_keys:
- branch
- commit
schedule_notify_address:
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/32d4fd5751eadbe1823a37eb38df85ec5c8e6207/vmlinuz-5.19.0-rc1-00001-g32d4fd5751ea"
dequeue_time: 2022-06-11 01:43:12.925010970 +08:00
:#! /cephfs/db/releases/20220610194609/lkp-src/include/site/inn:
job_state: finished
loadavg: 1.60 0.70 0.26 1/830 2274
start_time: '1654883126'
end_time: '1654883185'
version: "/lkp/lkp/.src-20220609-105345:5e682c40d:4d062c16a"

--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

ln -sf /usr/bin/clang
ln -sf /usr/bin/llc
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -C resctrl
resctrl/resctrl_tests

--3lcZGd9BuhuYXNfi--
