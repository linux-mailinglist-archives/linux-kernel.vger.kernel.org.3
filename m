Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B874EBE79
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245257AbiC3KRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbiC3KRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:17:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC83171570
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648635361; x=1680171361;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qjGy5OYxisF80QSQ2eTOoS/nKxwZlERTjlwl/7JNfBU=;
  b=bqLL+eU6kAjmMIs06scwui8pWgGaliqFBbwx1/HIjVMyCW2YaAuFWz73
   C3L7VtJXpt9yb2TMJTd6ripZ17i8pWmULgJhS6+itZi1lt7pz6Mpc43eZ
   MokohEM3jY4NQE866Sb144c4oEp/vTo8fxviKjQODwKIwj5eQpSlC0370
   3zZ4as7LwiF1rtNiJQO2NkgX1pVfZSaDLbTRSsCmDZkUJANoQHFkfFmyI
   ks8vS8HbcIgH5tz5yOr+7NJmJV3FCQHiSUKM6oC6KiVm0bVVLgmhxhJqq
   MDF2zOhs/KTixe47QKK8b5seA/sUSF/7a1Iq6ylYx+Iy+zgMm7coJHC+X
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="257086456"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="xz'?scan'208";a="257086456"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 03:16:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="xz'?scan'208";a="546804117"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 03:15:57 -0700
Date:   Wed, 30 Mar 2022 18:15:54 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     lkp@lists.01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [mm/page_alloc]  d74b7e8fef:
 BUG:spinlock_trylock_failure_on_UP_on_CPU
Message-ID: <20220330101554.GC6999@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with clang-15):

commit: d74b7e8fef5d9d1c6d7aba7b2ac898f77081a18a ("mm/page_alloc: Avoid disabling interruptions on hot paths")
https://git.kernel.org/cgit/linux/kernel/git/nsaenz/linux-rpi.git pcpdrain-sl-v3r1

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[  595.240111][    C0] BUG: spinlock trylock failure on UP on CPU#0, boot-1-aliyun-x/3533
[  595.241444][    C0]  lock: 0xffff88843ffdcc70, .magic: dead4ead, .owner: boot-1-aliyun-x/3533, .owner_cpu: 0
[  595.243114][    C0] CPU: 0 PID: 3533 Comm: boot-1-aliyun-x Not tainted 5.17.0-04447-gd74b7e8fef5d #1
[  595.244782][    C0] Call Trace:
[  595.245358][    C0]  <IRQ>
[ 595.245884][ C0] dump_stack_lvl (lib/dump_stack.c:108) 
[ 595.246661][ C0] dump_stack (lib/dump_stack.c:114) 
[ 595.247387][ C0] spin_bug (kernel/locking/spinlock_debug.c:? kernel/locking/spinlock_debug.c:77) 
[ 595.248093][ C0] do_raw_spin_trylock (include/linux/spinlock_up.h:42 kernel/locking/spinlock_debug.c:122) 
[ 595.249033][ C0] _raw_spin_trylock (include/linux/spinlock_api_smp.h:89 kernel/locking/spinlock.c:138) 
[ 595.249903][ C0] __rmqueue_pcplist (include/linux/spinlock.h:359 mm/page_alloc.c:3547) 
[ 595.250816][ C0] ? tcp_data_ready (net/ipv4/tcp_input.c:4980) 
[ 595.251730][ C0] ? tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2127) 
[ 595.252576][ C0] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 595.253620][ C0] ? zone_watermark_fast (mm/page_alloc.c:3763 mm/page_alloc.c:3876) 
[ 595.254595][ C0] get_page_from_freelist (mm/page_alloc.c:3603 mm/page_alloc.c:3631 mm/page_alloc.c:4096) 
[ 595.255550][ C0] ? validate_chain (kernel/locking/lockdep.c:3696 kernel/locking/lockdep.c:3716 kernel/locking/lockdep.c:3771) 
[ 595.256470][ C0] ? fs_reclaim_release (include/linux/sched/mm.h:190 mm/page_alloc.c:4516) 
[ 595.257434][ C0] ? prepare_alloc_pages (include/linux/mmzone.h:1194 include/linux/mmzone.h:1220 mm/page_alloc.c:5115) 
[ 595.258394][ C0] __alloc_pages (mm/page_alloc.c:?) 
[ 595.259246][ C0] ? slob_alloc (mm/slob.c:358) 
[ 595.260089][ C0] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 595.261077][ C0] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4208 kernel/locking/lockdep.c:4226 kernel/locking/lockdep.c:4294) 
[ 595.262178][ C0] slob_new_pages (mm/slob.c:202) 
[ 595.263008][ C0] slob_alloc (mm/slob.c:360) 
[ 595.263786][ C0] ? __napi_alloc_skb (net/core/skbuff.c:570) 
[ 595.264769][ C0] __kmalloc_track_caller (mm/slob.c:503 mm/slob.c:533) 
[ 595.265774][ C0] ? __napi_alloc_skb (net/core/skbuff.c:570) 
[ 595.266726][ C0] ? __napi_alloc_skb (net/core/skbuff.c:570) 
[ 595.267561][ C0] __alloc_skb (net/core/skbuff.c:354 net/core/skbuff.c:426) 
[ 595.268373][ C0] __napi_alloc_skb (net/core/skbuff.c:570) 
[ 595.269275][ C0] e1000_clean_rx_irq (include/linux/skbuff.h:3005 drivers/net/ethernet/intel/e1000/e1000_main.c:4112 drivers/net/ethernet/intel/e1000/e1000_main.c:4331 drivers/net/ethernet/intel/e1000/e1000_main.c:4383) 
[ 595.270213][ C0] ? e1000_alloc_jumbo_rx_buffers (drivers/net/ethernet/intel/e1000/e1000_main.c:4353) 
[ 595.271290][ C0] e1000_clean (drivers/net/ethernet/intel/e1000/e1000_main.c:3933 drivers/net/ethernet/intel/e1000/e1000_main.c:3801) 
[ 595.272132][ C0] ? __lock_acquire (kernel/locking/lockdep.c:?) 
[ 595.273066][ C0] __napi_poll (net/core/dev.c:6365) 
[ 595.273844][ C0] net_rx_action (net/core/dev.c:6432 net/core/dev.c:6519) 
[ 595.274692][ C0] __do_softirq (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/linux/jump_label.h:261 include/linux/jump_label.h:271 include/trace/events/irq.h:142 kernel/softirq.c:559) 
[ 595.275537][ C0] ? handle_fasteoi_irq (kernel/irq/chip.c:722) 
[ 595.276450][ C0] __irq_exit_rcu (kernel/softirq.c:640) 
[ 595.277246][ C0] irq_exit_rcu (kernel/softirq.c:651) 
[ 595.278011][ C0] common_interrupt (arch/x86/kernel/irq.c:240) 
[  595.278890][    C0]  </IRQ>
[  595.279428][    C0]  <TASK>
[ 595.279974][ C0] asm_common_interrupt (??:?) 
[ 595.280922][ C0] RIP: 0010:kcsan_setup_watchpoint (kernel/kcsan/core.c:357 kernel/kcsan/core.c:693) 
[ 595.282042][ C0] Code: 95 fb ff 48 c7 45 c8 00 00 00 00 9c 8f 45 c8 f7 45 c8 00 02 00 00 0f 85 90 00 00 00 f7 45 98 00 02 00 00 74 01 fb 48 8b 43 30 <49> 89 47 30 48 8b 43 28 49 89 47 28 48 8b 43 20 49 89 47 20 48 8b
All code
========
   0:	95                   	xchg   %eax,%ebp
   1:	fb                   	sti    
   2:	ff 48 c7             	decl   -0x39(%rax)
   5:	45 c8 00 00 00       	rex.RB enterq $0x0,$0x0
   a:	00 9c 8f 45 c8 f7 45 	add    %bl,0x45f7c845(%rdi,%rcx,4)
  11:	c8 00 02 00          	enterq $0x200,$0x0
  15:	00 0f                	add    %cl,(%rdi)
  17:	85 90 00 00 00 f7    	test   %edx,-0x9000000(%rax)
  1d:	45 98                	rex.RB cwtl 
  1f:	00 02                	add    %al,(%rdx)
  21:	00 00                	add    %al,(%rax)
  23:	74 01                	je     0x26
  25:	fb                   	sti    
  26:	48 8b 43 30          	mov    0x30(%rbx),%rax
  2a:*	49 89 47 30          	mov    %rax,0x30(%r15)		<-- trapping instruction
  2e:	48 8b 43 28          	mov    0x28(%rbx),%rax
  32:	49 89 47 28          	mov    %rax,0x28(%r15)
  36:	48 8b 43 20          	mov    0x20(%rbx),%rax
  3a:	49 89 47 20          	mov    %rax,0x20(%r15)
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	49 89 47 30          	mov    %rax,0x30(%r15)
   4:	48 8b 43 28          	mov    0x28(%rbx),%rax
   8:	49 89 47 28          	mov    %rax,0x28(%r15)
   c:	48 8b 43 20          	mov    0x20(%rbx),%rax
  10:	49 89 47 20          	mov    %rax,0x20(%r15)
  14:	48                   	rex.W
  15:	8b                   	.byte 0x8b
[  595.285406][    C0] RSP: 0000:ffffc90001a378a0 EFLAGS: 00000206
[  595.286469][    C0] RAX: 0000231c0000231a RBX: ffff88816bcc60e0 RCX: 0000000000000000
[  595.287838][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  595.289253][    C0] RBP: ffffc90001a37918 R08: 0000000000000000 R09: 0000000000292c74
[  595.290514][    C0] R10: 0001ffffffffff00 R11: 0000000000000000 R12: 0000000000000008
[  595.291885][    C0] R13: 0000000000000000 R14: ffff88816bcc60b0 R15: ffff88816bcc4798
[ 595.293348][ C0] ? __list_del_entry_valid (lib/list_debug.c:45) 
[ 595.294280][ C0] __tsan_read_write8 (kernel/kcsan/core.c:? kernel/kcsan/core.c:1014) 
[ 595.295129][ C0] __list_del_entry_valid (lib/list_debug.c:45) 
[ 595.296047][ C0] __rmqueue_pcplist (include/linux/list.h:134 include/linux/list.h:148 mm/page_alloc.c:3574) 
[ 595.296969][ C0] ? validate_chain (kernel/locking/lockdep.c:3696 kernel/locking/lockdep.c:3716 kernel/locking/lockdep.c:3771) 
[ 595.297812][ C0] get_page_from_freelist (mm/page_alloc.c:3603 mm/page_alloc.c:3631 mm/page_alloc.c:4096) 
[ 595.298786][ C0] ? __cond_resched (arch/x86/include/asm/preempt.h:103 kernel/sched/core.c:8153) 
[ 595.299605][ C0] ? prepare_alloc_pages (include/linux/mmzone.h:1194 include/linux/mmzone.h:1220 mm/page_alloc.c:5115) 
[ 595.300540][ C0] __alloc_pages (mm/page_alloc.c:?) 
[ 595.301395][ C0] ? wp_page_copy (include/linux/mmu_notifier.h:491 mm/memory.c:3125) 
[ 595.302244][ C0] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 595.303370][ C0] ? __lock_acquire (kernel/locking/lockdep.c:?) 
[ 595.304245][ C0] wp_page_copy (include/linux/gfp.h:? include/linux/gfp.h:595 include/linux/gfp.h:609 mm/memory.c:3018) 
[ 595.305098][ C0] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 595.306107][ C0] ? handle_mm_fault (include/linux/spinlock.h:? mm/memory.c:3317 mm/memory.c:4586 mm/memory.c:4704 mm/memory.c:4802) 
[ 595.307071][ C0] ? do_raw_spin_unlock (include/linux/spinlock_up.h:48 kernel/locking/spinlock_debug.c:141) 
[ 595.308065][ C0] handle_mm_fault (mm/memory.c:3318 mm/memory.c:4586 mm/memory.c:4704 mm/memory.c:4802) 
[ 595.308924][ C0] do_user_addr_fault (arch/x86/mm/fault.c:?) 
[ 595.309774][ C0] exc_page_fault (arch/x86/include/asm/irqflags.h:22 arch/x86/include/asm/irqflags.h:70 arch/x86/include/asm/irqflags.h:130 arch/x86/mm/fault.c:1492 arch/x86/mm/fault.c:1540) 
[ 595.310587][ C0] ? asm_exc_page_fault (??:?) 
[ 595.311378][ C0] asm_exc_page_fault (??:?) 
[  595.312204][    C0] RIP: 0033:0x42e32f
[ 595.312952][ C0] Code: 2e 0f 1f 84 00 00 00 00 00 66 90 53 48 89 fb 48 8b 3f 48 85 ff 74 05 e8 ff cb fe ff 8b 05 31 9c 2b 00 39 05 2f 9c 2b 00 7d 61 <c6> 03 df c6 43 01 df c6 43 02 df c6 43 03 df c6 43 04 df c6 43 05
All code
========
   0:	2e 0f 1f 84 00 00 00 	nopl   %cs:0x0(%rax,%rax,1)
   7:	00 00 
   9:	66 90                	xchg   %ax,%ax
   b:	53                   	push   %rbx
   c:	48 89 fb             	mov    %rdi,%rbx
   f:	48 8b 3f             	mov    (%rdi),%rdi
  12:	48 85 ff             	test   %rdi,%rdi
  15:	74 05                	je     0x1c
  17:	e8 ff cb fe ff       	callq  0xfffffffffffecc1b
  1c:	8b 05 31 9c 2b 00    	mov    0x2b9c31(%rip),%eax        # 0x2b9c53
  22:	39 05 2f 9c 2b 00    	cmp    %eax,0x2b9c2f(%rip)        # 0x2b9c57
  28:	7d 61                	jge    0x8b
  2a:*	c6 03 df             	movb   $0xdf,(%rbx)		<-- trapping instruction
  2d:	c6 43 01 df          	movb   $0xdf,0x1(%rbx)
  31:	c6 43 02 df          	movb   $0xdf,0x2(%rbx)
  35:	c6 43 03 df          	movb   $0xdf,0x3(%rbx)
  39:	c6 43 04 df          	movb   $0xdf,0x4(%rbx)
  3d:	c6                   	.byte 0xc6
  3e:	43                   	rex.XB
  3f:	05                   	.byte 0x5

Code starting with the faulting instruction
===========================================
   0:	c6 03 df             	movb   $0xdf,(%rbx)
   3:	c6 43 01 df          	movb   $0xdf,0x1(%rbx)
   7:	c6 43 02 df          	movb   $0xdf,0x2(%rbx)
   b:	c6 43 03 df          	movb   $0xdf,0x3(%rbx)
   f:	c6 43 04 df          	movb   $0xdf,0x4(%rbx)
  13:	c6                   	.byte 0xc6
  14:	43                   	rex.XB
  15:	05                   	.byte 0x5


To reproduce:

        # build kernel
	cd linux
	cp config-5.17.0-04447-gd74b7e8fef5d .config
	make HOSTCC=clang-15 CC=clang-15 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=clang-15 CC=clang-15 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.17.0-04447-gd74b7e8fef5d"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.17.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 15.0.0 (git://gitmirror/llvm_project 0f6d9501cf49ce02937099350d08f20c4af86f3d)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=150000
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=150000
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=150000
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_UAPI_HEADER_TEST=y
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
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
CONFIG_ARCH_WANTS_RT_DELAYED_SIGNALS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_TIME_NS is not set
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_KCMP is not set
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_PROFILING is not set
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
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_ACRN_GUEST=y
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
# CONFIG_DMI is not set
# CONFIG_GART_IOMMU is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_PERF_EVENTS_AMD_UNCORE=y
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_OLD_INTERFACE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_X86_UMIP is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
# CONFIG_EFI is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
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

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_ISA_BUS is not set
# CONFIG_ISA_DMA_API is not set
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32 is not set
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_GENERIC_ENTRY=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
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
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_HAS_LTO_CLANG=y
CONFIG_LTO_NONE=y
# CONFIG_LTO_CLANG_FULL is not set
# CONFIG_LTO_CLANG_THIN is not set
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
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
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
CONFIG_LOCK_EVENT_COUNTS=y
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
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
# CONFIG_ZBUD is not set
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_ANON_VMA_NAME=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
# CONFIG_EISA_PCI_EISA is not set
# CONFIG_EISA_VIRTUAL_ROOT is not set
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
CONFIG_PCIE_BUS_SAFE=y
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_HOTPLUG_PCI is not set

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
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
CONFIG_I82092=y
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=y
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
CONFIG_MHI_BUS_PCI_GENERIC=y
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_CS_DSP=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
# CONFIG_GNSS_MTK_SERIAL is not set
CONFIG_GNSS_SIRF_SERIAL=y
# CONFIG_GNSS_UBX_SERIAL is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
CONFIG_MTD_PCI=y
CONFIG_MTD_PCMCIA=y
CONFIG_MTD_PCMCIA_ANONYMOUS=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_MXIC=y
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_PLATFORM=y
CONFIG_MTD_NAND_ARASAN=y

#
# Misc
#
# CONFIG_MTD_NAND_NANDSIM is not set
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=y
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_NAND_ECC_SW_BCH=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_VMWARE_BALLOON=y
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=y
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
# CONFIG_ECHO is not set
CONFIG_BCM_VK=y
# CONFIG_BCM_VK_TTY is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HABANA_AI=y
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
CONFIG_PVPANIC_PCI=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# end of SCSI device support

CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
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
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
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
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
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
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
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
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
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
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_XIPHERA=y
CONFIG_APPLICOM=y

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
CONFIG_CARDMAN_4040=y
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
# CONFIG_DEVMEM is not set
# CONFIG_NVRAM is not set
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_PCIE is not set
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
CONFIG_SVC_I3C_MASTER=y
CONFIG_MIPI_I3C_HCI=y
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_DA9062 is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L90=y

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
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_ICH=y
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_VX855=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=y
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_GPIO_MM is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=y
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD9571MWV=y
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_MADERA=y
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_MAX8925_POWER is not set
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_MT6360 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=y
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
CONFIG_SENSORS_DS620=y
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
CONFIG_I8K=y
CONFIG_SENSORS_I5K_AMB=y
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX127=y
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX6620=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_MLXREG_FAN=y
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_MR75203=y
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1266=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=y
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_DPS920AB=y
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_IR36021 is not set
CONFIG_SENSORS_IR38064=y
CONFIG_SENSORS_IR38064_REGULATOR=y
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=y
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX16601=y
# CONFIG_SENSORS_MAX20730 is not set
CONFIG_SENSORS_MAX20751=y
# CONFIG_SENSORS_MAX31785 is not set
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_MP2888=y
CONFIG_SENSORS_MP2975=y
# CONFIG_SENSORS_MP5023 is not set
CONFIG_SENSORS_PIM4328=y
# CONFIG_SENSORS_PLI1209BC is not set
CONFIG_SENSORS_PM6764TR=y
CONFIG_SENSORS_PXE1610=y
# CONFIG_SENSORS_Q54SJ108A2 is not set
CONFIG_SENSORS_STPDDC60=y
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_XDPE122=y
# CONFIG_SENSORS_XDPE122_REGULATOR is not set
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_SBTSI=y
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
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
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=y
# CONFIG_MENZ069_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=y
CONFIG_WM8350_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_RAVE_SP_WATCHDOG=y
# CONFIG_MLX_WDT is not set
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=y
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=y
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=y
# CONFIG_ITCO_VENDOR_SUPPORT is not set
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=y
# CONFIG_HPWDT_NMI_DECODING is not set
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_CPU5_WDT=y
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
CONFIG_INTEL_MEI_WDT=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SYSCON is not set
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_RAVE_SP_CORE=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_ARIZONA_LDO1=y
# CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AXP20X=y
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6358=y
# CONFIG_REGULATOR_MT6359 is not set
CONFIG_REGULATOR_MT6360=y
# CONFIG_REGULATOR_MT6397 is not set
# CONFIG_REGULATOR_PALMAS is not set
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6245 is not set
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=y
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS6586X is not set
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_REGULATOR_WM8994=y
# CONFIG_RC_CORE is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_MAXIRADIO is not set
CONFIG_RADIO_SAA7706H=y
# CONFIG_RADIO_SI4713 is not set
# CONFIG_RADIO_SI476X is not set
CONFIG_RADIO_TEA5764=y
CONFIG_RADIO_TEA5764_XTAL=y
CONFIG_RADIO_TEF6862=y
CONFIG_RADIO_WL1273=y
CONFIG_RADIO_SI470X=y
# CONFIG_I2C_SI470X is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#
CONFIG_VIDEO_ASPEED=y

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
CONFIG_VIDEO_CADENCE_CSI2TX=y

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#
# CONFIG_VIDEO_CAFE_CCIC is not set

#
# Mediatek media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# VIA media platform drivers
#
CONFIG_VIDEO_VIA_CAMERA=y

#
# Xilinx media platform drivers
#

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_SMS_SIANO_MDTV=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_HI556=y
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
CONFIG_VIDEO_IMX208=y
CONFIG_VIDEO_IMX214=y
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX258=y
CONFIG_VIDEO_IMX274=y
CONFIG_VIDEO_IMX290=y
CONFIG_VIDEO_IMX319=y
CONFIG_VIDEO_IMX355=y
CONFIG_VIDEO_MAX9271_LIB=y
CONFIG_VIDEO_MT9M001=y
CONFIG_VIDEO_MT9M032=y
CONFIG_VIDEO_MT9M111=y
CONFIG_VIDEO_MT9P031=y
# CONFIG_VIDEO_MT9T001 is not set
CONFIG_VIDEO_MT9T112=y
# CONFIG_VIDEO_MT9V011 is not set
CONFIG_VIDEO_MT9V032=y
CONFIG_VIDEO_MT9V111=y
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_OG01A1B is not set
CONFIG_VIDEO_OV02A10=y
# CONFIG_VIDEO_OV08D10 is not set
CONFIG_VIDEO_OV13858=y
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=y
# CONFIG_VIDEO_OV2659 is not set
CONFIG_VIDEO_OV2680=y
CONFIG_VIDEO_OV2685=y
# CONFIG_VIDEO_OV2740 is not set
CONFIG_VIDEO_OV5647=y
CONFIG_VIDEO_OV5670=y
# CONFIG_VIDEO_OV5675 is not set
CONFIG_VIDEO_OV5693=y
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV6650 is not set
CONFIG_VIDEO_OV7251=y
CONFIG_VIDEO_OV7640=y
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_OV8856=y
CONFIG_VIDEO_OV9640=y
CONFIG_VIDEO_OV9650=y
# CONFIG_VIDEO_OV9734 is not set
CONFIG_VIDEO_RDACM20=y
# CONFIG_VIDEO_RDACM21 is not set
CONFIG_VIDEO_RJ54N1=y
CONFIG_VIDEO_S5K4ECGX=y
CONFIG_VIDEO_S5K5BAF=y
CONFIG_VIDEO_S5K6A3=y
CONFIG_VIDEO_S5K6AA=y
CONFIG_VIDEO_SR030PC30=y
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_CCS is not set
CONFIG_VIDEO_ET8EK8=y
CONFIG_VIDEO_M5MOLS=y
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
CONFIG_VIDEO_AK7375=y
# CONFIG_VIDEO_DW9714 is not set
CONFIG_VIDEO_DW9768=y
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=y
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_SONY_BTF_MPX=y
CONFIG_VIDEO_TDA1997X=y
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_TLV320AIC23B=y
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_UDA1342=y
CONFIG_VIDEO_VP27SMPX=y
# CONFIG_VIDEO_WM8739 is not set
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_ADV7604=y
# CONFIG_VIDEO_ADV7604_CEC is not set
CONFIG_VIDEO_ADV7842=y
# CONFIG_VIDEO_ADV7842_CEC is not set
CONFIG_VIDEO_BT819=y
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_ML86V7667=y
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
# CONFIG_VIDEO_TC358743_CEC is not set
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_TW9910=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_ADV7170 is not set
CONFIG_VIDEO_ADV7175=y
# CONFIG_VIDEO_ADV7343 is not set
CONFIG_VIDEO_ADV7393=y
# CONFIG_VIDEO_ADV7511 is not set
CONFIG_VIDEO_AK881X=y
# CONFIG_VIDEO_SAA7127 is not set
CONFIG_VIDEO_SAA7185=y
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
CONFIG_VIDEO_UPD64083=y
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=y
CONFIG_VIDEO_M52790=y
CONFIG_VIDEO_ST_MIPID02=y
CONFIG_VIDEO_THS7303=y
# end of Miscellaneous helper chips

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_E4000 is not set
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_FC2580=y
# CONFIG_MEDIA_TUNER_IT913X is not set
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
# CONFIG_MEDIA_TUNER_MAX2165 is not set
# CONFIG_MEDIA_TUNER_MC44S803 is not set
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_QM1D1B0004=y
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_R820T=y
# CONFIG_MEDIA_TUNER_SI2157 is not set
# CONFIG_MEDIA_TUNER_SIMPLE is not set
# CONFIG_MEDIA_TUNER_TDA18212 is not set
CONFIG_MEDIA_TUNER_TDA18218=y
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
# CONFIG_MEDIA_TUNER_TDA9887 is not set
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_M88DS3103 is not set
CONFIG_DVB_MXL5XX=y
# CONFIG_DVB_STB0899 is not set
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
CONFIG_DVB_STV6110x=y
CONFIG_DVB_STV6111=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y
# CONFIG_DVB_SI2165 is not set
CONFIG_DVB_TDA18271C2DD=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
CONFIG_DVB_CX24120=y
CONFIG_DVB_CX24123=y
# CONFIG_DVB_DS3000 is not set
# CONFIG_DVB_MB86A16 is not set
# CONFIG_DVB_MT312 is not set
CONFIG_DVB_S5H1420=y
CONFIG_DVB_SI21XX=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0288=y
# CONFIG_DVB_STV0299 is not set
CONFIG_DVB_STV0900=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_TDA10071=y
# CONFIG_DVB_TDA10086 is not set
# CONFIG_DVB_TDA8083 is not set
# CONFIG_DVB_TDA8261 is not set
# CONFIG_DVB_TDA826X is not set
# CONFIG_DVB_TS2020 is not set
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_VES1X93=y
# CONFIG_DVB_ZL10036 is not set
# CONFIG_DVB_ZL10039 is not set

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=y
CONFIG_DVB_CX22700=y
# CONFIG_DVB_CX22702 is not set
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_CXD2841ER=y
# CONFIG_DVB_DIB3000MB is not set
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
CONFIG_DVB_DRXD=y
CONFIG_DVB_EC100=y
CONFIG_DVB_L64781=y
CONFIG_DVB_MT352=y
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_S5H1432=y
# CONFIG_DVB_SI2168 is not set
# CONFIG_DVB_SP887X is not set
CONFIG_DVB_STV0367=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_TDA1004X=y
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_ZL10353=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=y
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
CONFIG_DVB_VES1820=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_AU8522_DTV is not set
# CONFIG_DVB_AU8522_V4L is not set
CONFIG_DVB_BCM3510=y
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_MXL692=y
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_OR51211=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=y
# CONFIG_DVB_MB86A20S is not set
CONFIG_DVB_S921=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=y
# CONFIG_DVB_TC90522 is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=y
CONFIG_DVB_AF9033=y
CONFIG_DVB_ASCOT2E=y
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_HELENE=y
CONFIG_DVB_HORUS3A=y
# CONFIG_DVB_ISL6405 is not set
CONFIG_DVB_ISL6421=y
# CONFIG_DVB_ISL6423 is not set
# CONFIG_DVB_IX2505V is not set
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=y
CONFIG_DVB_LNBH25=y
# CONFIG_DVB_LNBH29 is not set
# CONFIG_DVB_LNBP21 is not set
# CONFIG_DVB_LNBP22 is not set
CONFIG_DVB_M88RS2000=y
# CONFIG_DVB_TDA665x is not set
CONFIG_DVB_DRX39XYJ=y

#
# Common Interface (EN50221) controller drivers
#
# CONFIG_DVB_CXD2099 is not set
CONFIG_DVB_SP2=y
# end of Customise DVB Frontends
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_SIS=y
# CONFIG_AGP_VIA is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
CONFIG_FB_CYBER2000=y
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=y
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=y
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=y
# CONFIG_FB_LE80578 is not set
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=y
CONFIG_FB_MATROX_MAVEN=y
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
# CONFIG_FB_SIS is not set
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
CONFIG_FB_3DFX_ACCEL=y
CONFIG_FB_3DFX_I2C=y
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
CONFIG_FB_SM712=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_AAT2870=y
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_DRIVERS is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
CONFIG_SND_PCMCIA=y
# CONFIG_SND_VXPOCKET is not set
CONFIG_SND_PDAUDIOCF=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=y
# CONFIG_SND_SOC_ADI is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
CONFIG_SND_SOC_AMD_RENOIR=y
# CONFIG_SND_SOC_AMD_RENOIR_MACH is not set
CONFIG_SND_SOC_AMD_ACP5x=y
# CONFIG_SND_SOC_AMD_ACP6x is not set
CONFIG_SND_AMD_ACP_CONFIG=y
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_BCM63XX_I2S_WHISTLER=y
CONFIG_SND_DESIGNWARE_I2S=y
CONFIG_SND_DESIGNWARE_PCM=y

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
CONFIG_SND_SOC_FSL_SPDIF=y
CONFIG_SND_SOC_FSL_ESAI=y
CONFIG_SND_SOC_FSL_MICFIL=y
# CONFIG_SND_SOC_FSL_XCVR is not set
CONFIG_SND_SOC_FSL_RPMSG=y
CONFIG_SND_SOC_IMX_AUDMUX=y
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
# CONFIG_SND_SOC_IMG is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
# CONFIG_SND_SOC_INTEL_AVS is not set
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_MTK_BTCVSD=y
CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI_DEV=y
CONFIG_SND_SOC_SOF_PCI=y
# CONFIG_SND_SOC_SOF_ACPI is not set
CONFIG_SND_SOC_SOF_DEBUG_PROBES=y
CONFIG_SND_SOC_SOF_CLIENT=y
CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT=y
CONFIG_SND_SOC_SOF_FORCE_PROBE_WORKQUEUE=y
CONFIG_SND_SOC_SOF_NOCODEC=y
CONFIG_SND_SOC_SOF_NOCODEC_SUPPORT=y
# CONFIG_SND_SOC_SOF_STRICT_ABI_CHECKS is not set
# CONFIG_SND_SOC_SOF_DEBUG is not set
CONFIG_SND_SOC_SOF=y
CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=y
# CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=y
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=y
CONFIG_SND_SOC_SOF_INTEL_COMMON=y
CONFIG_SND_SOC_SOF_MERRIFIELD=y
# CONFIG_SND_SOC_SOF_APOLLOLAKE is not set
# CONFIG_SND_SOC_SOF_GEMINILAKE is not set
CONFIG_SND_SOC_SOF_INTEL_CNL=y
# CONFIG_SND_SOC_SOF_CANNONLAKE is not set
# CONFIG_SND_SOC_SOF_COFFEELAKE is not set
CONFIG_SND_SOC_SOF_COMETLAKE=y
CONFIG_SND_SOC_SOF_INTEL_ICL=y
# CONFIG_SND_SOC_SOF_ICELAKE is not set
CONFIG_SND_SOC_SOF_JASPERLAKE=y
CONFIG_SND_SOC_SOF_INTEL_TGL=y
CONFIG_SND_SOC_SOF_TIGERLAKE=y
# CONFIG_SND_SOC_SOF_ELKHARTLAKE is not set
CONFIG_SND_SOC_SOF_ALDERLAKE=y
CONFIG_SND_SOC_SOF_HDA_COMMON=y
CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=y
CONFIG_SND_SOC_SOF_HDA_PROBES=y
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=y
CONFIG_SND_SOC_SOF_XTENSA=y

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
CONFIG_SND_SOC_XILINX_SPDIF=y
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_WM_ADSP=y
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1372=y
CONFIG_SND_SOC_ADAU1372_I2C=y
CONFIG_SND_SOC_ADAU1701=y
# CONFIG_SND_SOC_ADAU1761_I2C is not set
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
CONFIG_SND_SOC_ADAU7118_I2C=y
CONFIG_SND_SOC_AK4118=y
CONFIG_SND_SOC_AK4375=y
# CONFIG_SND_SOC_AK4458 is not set
CONFIG_SND_SOC_AK4554=y
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK5386=y
CONFIG_SND_SOC_AK5558=y
CONFIG_SND_SOC_ALC5623=y
# CONFIG_SND_SOC_AW8738 is not set
CONFIG_SND_SOC_BD28623=y
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CS35L32=y
# CONFIG_SND_SOC_CS35L33 is not set
CONFIG_SND_SOC_CS35L34=y
CONFIG_SND_SOC_CS35L35=y
# CONFIG_SND_SOC_CS35L36 is not set
CONFIG_SND_SOC_CS35L41_LIB=y
CONFIG_SND_SOC_CS35L41=y
CONFIG_SND_SOC_CS35L41_I2C=y
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
CONFIG_SND_SOC_CS4234=y
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=y
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=y
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_CX2072X=y
# CONFIG_SND_SOC_DA7213 is not set
# CONFIG_SND_SOC_DMIC is not set
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES7241=y
# CONFIG_SND_SOC_ES8316 is not set
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_ICS43432=y
CONFIG_SND_SOC_INNO_RK3036=y
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98357A=y
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX9867=y
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98520=y
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX98373_I2C=y
# CONFIG_SND_SOC_MAX98390 is not set
CONFIG_SND_SOC_MAX9860=y
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
CONFIG_SND_SOC_PCM1681=y
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
# CONFIG_SND_SOC_PCM179X_I2C is not set
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
# CONFIG_SND_SOC_PCM5102A is not set
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RT5616=y
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5640=y
CONFIG_SND_SOC_RT5659=y
CONFIG_SND_SOC_RT9120=y
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
# CONFIG_SND_SOC_SIMPLE_MUX is not set
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2518=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_I2C=y
CONFIG_SND_SOC_SSM4567=y
CONFIG_SND_SOC_STA32X=y
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_STI_SAS=y
# CONFIG_SND_SOC_TAS2552 is not set
CONFIG_SND_SOC_TAS2562=y
CONFIG_SND_SOC_TAS2764=y
CONFIG_SND_SOC_TAS2770=y
# CONFIG_SND_SOC_TAS5086 is not set
CONFIG_SND_SOC_TAS571X=y
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS5805M is not set
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=y
# CONFIG_SND_SOC_TFA989X is not set
# CONFIG_SND_SOC_TLV320ADC3XXX is not set
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TLV320AIC3X_I2C=y
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=y
# CONFIG_SND_SOC_TSCS42XX is not set
CONFIG_SND_SOC_TSCS454=y
# CONFIG_SND_SOC_UDA1334 is not set
CONFIG_SND_SOC_WM8510=y
CONFIG_SND_SOC_WM8523=y
# CONFIG_SND_SOC_WM8524 is not set
CONFIG_SND_SOC_WM8580=y
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
CONFIG_SND_SOC_WM8737=y
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=y
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
CONFIG_SND_SOC_WM8960=y
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8974=y
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8985=y
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_MT6351=y
CONFIG_SND_SOC_MT6358=y
# CONFIG_SND_SOC_MT6660 is not set
CONFIG_SND_SOC_NAU8315=y
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8821 is not set
CONFIG_SND_SOC_NAU8822=y
CONFIG_SND_SOC_NAU8824=y
# CONFIG_SND_SOC_TPA6130A2 is not set
CONFIG_SND_SOC_LPASS_MACRO_COMMON=y
CONFIG_SND_SOC_LPASS_WSA_MACRO=y
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
CONFIG_SND_SOC_LPASS_RX_MACRO=y
CONFIG_SND_SOC_LPASS_TX_MACRO=y
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
# CONFIG_SND_X86 is not set
# CONFIG_SND_VIRTIO is not set
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PLAYSTATION is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=y
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_MMC_RICOH_MMC=y
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SDRICOH_CS is not set
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=y
CONFIG_MMC_TOSHIBA_PCI=y
# CONFIG_MMC_MTK is not set
CONFIG_MMC_SDHCI_XENON=y
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_MT6323=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_MENF21BMC is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_RT8515=y
CONFIG_LEDS_SGM3140=y

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=y
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IDXD_BUS=y
CONFIG_INTEL_IDXD_COMPAT=y
CONFIG_INTEL_IOATDMA=y
CONFIG_PLX_DMA=y
# CONFIG_AMD_PTDMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
CONFIG_DW_DMAC_PCI=y
CONFIG_DW_EDMA=y
CONFIG_DW_EDMA_PCIE=y
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=y
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

CONFIG_DCA=y
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
# CONFIG_KS0108 is not set
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_HT16K33 is not set
CONFIG_LCD2S=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=y
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI_CORE=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=y
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_IGD=y
CONFIG_VFIO_MDEV=y
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=y
CONFIG_COMEDI_8255_PCI=y
CONFIG_COMEDI_ADDI_WATCHDOG=y
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
CONFIG_COMEDI_ADDI_APCI_1500=y
CONFIG_COMEDI_ADDI_APCI_1516=y
CONFIG_COMEDI_ADDI_APCI_1564=y
CONFIG_COMEDI_ADDI_APCI_16XX=y
# CONFIG_COMEDI_ADDI_APCI_2032 is not set
CONFIG_COMEDI_ADDI_APCI_2200=y
# CONFIG_COMEDI_ADDI_APCI_3120 is not set
CONFIG_COMEDI_ADDI_APCI_3501=y
# CONFIG_COMEDI_ADDI_APCI_3XXX is not set
CONFIG_COMEDI_ADL_PCI6208=y
# CONFIG_COMEDI_ADL_PCI7X3X is not set
CONFIG_COMEDI_ADL_PCI8164=y
CONFIG_COMEDI_ADL_PCI9111=y
CONFIG_COMEDI_ADL_PCI9118=y
# CONFIG_COMEDI_ADV_PCI1710 is not set
CONFIG_COMEDI_ADV_PCI1720=y
CONFIG_COMEDI_ADV_PCI1723=y
# CONFIG_COMEDI_ADV_PCI1724 is not set
CONFIG_COMEDI_ADV_PCI1760=y
CONFIG_COMEDI_ADV_PCI_DIO=y
# CONFIG_COMEDI_AMPLC_DIO200_PCI is not set
# CONFIG_COMEDI_AMPLC_PC236_PCI is not set
CONFIG_COMEDI_AMPLC_PC263_PCI=y
CONFIG_COMEDI_AMPLC_PCI224=y
# CONFIG_COMEDI_AMPLC_PCI230 is not set
CONFIG_COMEDI_CONTEC_PCI_DIO=y
CONFIG_COMEDI_DAS08_PCI=y
CONFIG_COMEDI_DT3000=y
# CONFIG_COMEDI_DYNA_PCI10XX is not set
# CONFIG_COMEDI_GSC_HPDI is not set
# CONFIG_COMEDI_MF6X4 is not set
CONFIG_COMEDI_ICP_MULTI=y
CONFIG_COMEDI_DAQBOARD2000=y
CONFIG_COMEDI_JR3_PCI=y
CONFIG_COMEDI_KE_COUNTER=y
# CONFIG_COMEDI_CB_PCIDAS64 is not set
CONFIG_COMEDI_CB_PCIDAS=y
# CONFIG_COMEDI_CB_PCIDDA is not set
# CONFIG_COMEDI_CB_PCIMDAS is not set
# CONFIG_COMEDI_CB_PCIMDDA is not set
CONFIG_COMEDI_ME4000=y
CONFIG_COMEDI_ME_DAQ=y
CONFIG_COMEDI_NI_6527=y
# CONFIG_COMEDI_NI_65XX is not set
CONFIG_COMEDI_NI_660X=y
CONFIG_COMEDI_NI_670X=y
CONFIG_COMEDI_NI_LABPC_PCI=y
# CONFIG_COMEDI_NI_PCIDIO is not set
CONFIG_COMEDI_NI_PCIMIO=y
# CONFIG_COMEDI_RTD520 is not set
CONFIG_COMEDI_S626=y
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_NI_TIOCMD=y
# CONFIG_COMEDI_PCMCIA_DRIVERS is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
# CONFIG_COMEDI_KCOMEDILIB is not set
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_TF103C_DOCK is not set
CONFIG_MERAKI_MX100=y
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_IBM_RTL=y
# CONFIG_SENSORS_HDAPS is not set
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=y
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# CONFIG_INTEL_VSEC is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_BARCO_P50_GPIO=y
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_X86_ANDROID_TABLETS is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CROS_EC is not set
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
CONFIG_MLXREG_IO=y
CONFIG_MLXREG_LC=y
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_PALMAS is not set
CONFIG_COMMON_CLK_PWM=y
CONFIG_XILINX_VCU=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
CONFIG_IOMMU_DEFAULT_DMA_STRICT=y
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
# CONFIG_AMD_IOMMU is not set
# CONFIG_INTEL_IOMMU is not set
# CONFIG_IRQ_REMAP is not set
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_NS is not set
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
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

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=y
# CONFIG_VME_TSI148 is not set
# CONFIG_VME_FAKE is not set

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_DWC=y
# CONFIG_PWM_LP3943 is not set
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_RAVE_SP_EEPROM=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_FPGA_MGR_ALTERA_CVP=y
CONFIG_FPGA_BRIDGE=y
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
CONFIG_FPGA_DFL_FME_MGR=y
# CONFIG_FPGA_DFL_FME_BRIDGE is not set
# CONFIG_FPGA_DFL_FME_REGION is not set
# CONFIG_FPGA_DFL_AFU is not set
CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=y
CONFIG_FPGA_DFL_PCI=y
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
CONFIG_INTERRUPT_CNT=y
CONFIG_INTEL_QEP=y
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
CONFIG_MOST_SND=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_KEY_NOTIFICATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_NETWORK is not set
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_PATH is not set
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
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
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM3=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
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
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=m
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_REF_TRACKER=y
# end of Library routines

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
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_GDB_SCRIPTS=y
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
CONFIG_FRAME_POINTER=y
CONFIG_STACK_VALIDATION=y
CONFIG_VMLINUX_MAP=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
CONFIG_KCSAN=y
CONFIG_CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE=y
# CONFIG_KCSAN_VERBOSE is not set
# CONFIG_KCSAN_SELFTEST is not set
CONFIG_KCSAN_EARLY_ENABLE=y
CONFIG_KCSAN_NUM_WATCHPOINTS=64
CONFIG_KCSAN_UDELAY_TASK=80
CONFIG_KCSAN_UDELAY_INTERRUPT=20
CONFIG_KCSAN_DELAY_RANDOMIZE=y
CONFIG_KCSAN_SKIP_WATCH=4000
CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE=y
# CONFIG_KCSAN_INTERRUPT_WATCHER is not set
CONFIG_KCSAN_REPORT_ONCE_IN_MS=3000
# CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN is not set
# CONFIG_KCSAN_STRICT is not set
# CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY is not set
CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y
# CONFIG_KCSAN_IGNORE_ATOMICS is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Networking Debugging
#
CONFIG_NET_DEV_REFCNT_TRACKER=y
CONFIG_NET_NS_REFCNT_TRACKER=y
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y

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
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_RCU_STRICT_GRACE_PERIOD is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
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
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
# CONFIG_TIMERLAT_TRACER is not set
CONFIG_MMIOTRACE=y
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_PROFILE_ALL_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_OBJTOOL=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
CONFIG_FTRACE_RECORD_RECURSION=y
CONFIG_FTRACE_RECORD_RECURSION_SIZE=128
CONFIG_RING_BUFFER_RECORD_RECURSION=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
# CONFIG_SAMPLE_FTRACE_DIRECT is not set
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
CONFIG_SAMPLE_KOBJECT=y
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
# CONFIG_SAMPLE_CONFIGFS is not set
CONFIG_SAMPLE_HIDRAW=y
CONFIG_SAMPLE_LANDLOCK=y
CONFIG_SAMPLE_PIDFD=y
# CONFIG_SAMPLE_SECCOMP is not set
# CONFIG_SAMPLE_TIMER is not set
# CONFIG_SAMPLE_UHID is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_ANDROID_BINDERFS is not set
# CONFIG_SAMPLE_VFS is not set
# CONFIG_SAMPLE_INTEL_MEI is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_SAMPLE_WATCH_QUEUE=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
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
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb-180'
	export tbox_group='vm-snb'
	export branch='linux-devel/devel-hourly-20220328-182204'
	export commit='d74b7e8fef5d9d1c6d7aba7b2ac898f77081a18a'
	export kconfig='x86_64-randconfig-a012-20220328'
	export nr_vm=160
	export submit_id='62428930c3f83839e7787668'
	export job_file='/lkp/jobs/scheduled/vm-snb-180/boot-1-aliyun-x86_64-20190626.cgz-d74b7e8fef5d9d1c6d7aba7b2ac898f77081a18a-20220329-14823-1iq9f24-1.yaml'
	export id='afe913dc49ec08a88166849f47de82bcd9158f46'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=128M initramfs_async=0 page_owner=on'
	export rootfs='aliyun-x86_64-20190626.cgz'
	export compiler='clang-15'
	export enqueue_time='2022-03-29 12:21:05 +0800'
	export _id='624291a4c3f83839e7787669'
	export _rt='/result/boot/1/vm-snb/aliyun-x86_64-20190626.cgz/x86_64-randconfig-a012-20220328/clang-15/d74b7e8fef5d9d1c6d7aba7b2ac898f77081a18a'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb/aliyun-x86_64-20190626.cgz/x86_64-randconfig-a012-20220328/clang-15/d74b7e8fef5d9d1c6d7aba7b2ac898f77081a18a/3'
	export scheduler_version='/lkp/lkp/.src-20220329-091050'
	export arch='x86_64'
	export max_uptime=600
	export initrd='/osimage/aliyun/aliyun-x86_64-20190626.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/aliyun-x86_64-20190626.cgz/x86_64-randconfig-a012-20220328/clang-15/d74b7e8fef5d9d1c6d7aba7b2ac898f77081a18a/3
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20220328/clang-15/d74b7e8fef5d9d1c6d7aba7b2ac898f77081a18a/vmlinuz-5.17.0-04447-gd74b7e8fef5d
branch=linux-devel/devel-hourly-20220328-182204
job=/lkp/jobs/scheduled/vm-snb-180/boot-1-aliyun-x86_64-20190626.cgz-d74b7e8fef5d9d1c6d7aba7b2ac898f77081a18a-20220329-14823-1iq9f24-1.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a012-20220328
commit=d74b7e8fef5d9d1c6d7aba7b2ac898f77081a18a
vmalloc=128M initramfs_async=0 page_owner=on
max_uptime=600
LKP_SERVER=internal-lkp-server
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
	export modules_initrd='/pkg/linux/x86_64-randconfig-a012-20220328/clang-15/d74b7e8fef5d9d1c6d7aba7b2ac898f77081a18a/modules.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-randconfig-a012-20220328/clang-15/d74b7e8fef5d9d1c6d7aba7b2ac898f77081a18a/vmlinuz-5.17.0-04447-gd74b7e8fef5d'
	export dequeue_time='2022-03-29 12:58:44 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-180/boot-1-aliyun-x86_64-20190626.cgz-d74b7e8fef5d9d1c6d7aba7b2ac898f77081a18a-20220329-14823-1iq9f24-1.cgz'

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

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--m51xatjYGsM+13rf
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--m51xatjYGsM+13rf--
