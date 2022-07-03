Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08CA564681
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiGCJou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiGCJos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:44:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF065A5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 02:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656841479; x=1688377479;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=qo3wMlGLtqye2aRiEVHMi7AVmNE9IOlXQlL8E/yZuAs=;
  b=c7Ifh3L4BbgZDZY33ZlNFCv2j6qVHozLrJbVQW2lV0ycq6bNiH1p2GJ6
   biF6WK0LvBB4MbquB4ycjTJgzqoFIdyikxma+5KT7LIDrphdGYB3YTqor
   ehdXmouu2IXn4kPCy8yNpXSFIUd4HJp04Ni6Kq9C3mhYaNh3mPenCdP+X
   NNyF4UBjIkAwXO9OXYnP07xcNvHfwF4aHfvWlCfLAVJTXd0yhFafNCCLi
   DWqQofoHA8tXPdJ4j/T5fjFm8URHRSJ7MHMaDFMh6cgXdIIUg45txQIGg
   w4OGchOpUV/AkC3iBH+hgjUDQFlxdSm+wIm/oT2G6+VjsR12rzNh5hVFU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="284037396"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="xz'?yaml'?scan'208";a="284037396"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 02:44:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="xz'?yaml'?scan'208";a="618904403"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 02:44:33 -0700
Date:   Sun, 3 Jul 2022 17:44:30 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, lkp@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [mm/page_alloc]  2bd8eec68f:
 BUG:sleeping_function_called_from_invalid_context_at_mm/gup.c
Message-ID: <YsFk/qU+QtWun04h@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2mbpD809lbQkAB7H"
Content-Disposition: inline
In-Reply-To: <20220613125622.18628-8-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2mbpD809lbQkAB7H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: 2bd8eec68f740608db5ea58ecff06965228764cb ("[PATCH 7/7] mm/page_alloc: Replace local_lock with normal spinlock")
url: https://github.com/intel-lab-lkp/linux/commits/Mel-Gorman/Drain-remote-per-cpu-directly/20220613-230139
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
patch link: https://lore.kernel.org/lkml/20220613125622.18628-8-mgorman@techsingularity.net

in testcase: kernel-selftests
version: kernel-selftests-x86_64-a10a197d-1_20220626
with following parameters:

	sc_nr_hugepages: 2
	group: vm
	ucode: 0x500320a

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[  202.339609][T27281] BUG: sleeping function called from invalid context at mm/gup.c:1170
[  202.339615][T27281] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 27281, name: compaction_test
[  202.339617][T27281] preempt_count: 1, expected: 0
[  202.339619][T27281] 1 lock held by compaction_test/27281:
[202.339622][T27281] #0: ffff88911e087828 (&mm->mmap_lock#2){++++}-{3:3}, at: __mm_populate (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/linux/mmap_lock.h:35 include/linux/mmap_lock.h:118 mm/gup.c:1611) 
[  202.339637][T27281] CPU: 78 PID: 27281 Comm: compaction_test Tainted: G S      W         5.19.0-rc2-00007-g2bd8eec68f74 #1
[  202.339641][T27281] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
[  202.339643][T27281] Call Trace:
[  202.339645][T27281]  <TASK>
[202.339650][T27281] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[202.339657][T27281] __might_resched.cold (kernel/sched/core.c:9792) 
[202.339668][T27281] __get_user_pages (include/linux/sched.h:2059 mm/gup.c:1170) 
[202.339682][T27281] ? get_gate_page (mm/gup.c:1099) 
[202.339697][T27281] ? rwsem_down_read_slowpath (kernel/locking/rwsem.c:1487) 
[202.339709][T27281] populate_vma_page_range (mm/gup.c:1518) 
[202.339715][T27281] __mm_populate (mm/gup.c:1639) 
[202.339720][T27281] ? faultin_vma_page_range (mm/gup.c:1595) 
[202.339726][T27281] ? __up_write (arch/x86/include/asm/atomic64_64.h:172 (discriminator 23) include/linux/atomic/atomic-long.h:95 (discriminator 23) include/linux/atomic/atomic-instrumented.h:1348 (discriminator 23) kernel/locking/rwsem.c:1346 (discriminator 23)) 
[202.339736][T27281] vm_mmap_pgoff (include/linux/mm.h:2706 mm/util.c:557) 
[202.339745][T27281] ? randomize_page (mm/util.c:542) 
[202.339753][T27281] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4526) 
[202.339757][T27281] ? syscall_enter_from_user_mode (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 kernel/entry/common.c:109) 
[202.339768][T27281] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[202.339779][T27281] ? __local_bh_enable (kernel/softirq.c:357) 
[202.339785][T27281] ? __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:415 kernel/softirq.c:600) 
[202.339795][T27281] ? irqentry_exit_to_user_mode (kernel/entry/common.c:129 kernel/entry/common.c:309) 
[202.339802][T27281] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4526) 
[202.339806][T27281] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  202.339810][T27281] RIP: 0033:0x7fdb25ea1b62
[ 202.339814][T27281] Code: e4 e8 b2 4b 01 00 66 90 41 f7 c1 ff 0f 00 00 75 27 55 48 89 fd 53 89 cb 48 85 ff 74 3b 41 89 da 48 89 ef b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 5b 5d c3 0f 1f 00 48 8b 05 f9 52 0c 00 64
All code
========
   0:	e4 e8                	in     $0xe8,%al
   2:	b2 4b                	mov    $0x4b,%dl
   4:	01 00                	add    %eax,(%rax)
   6:	66 90                	xchg   %ax,%ax
   8:	41 f7 c1 ff 0f 00 00 	test   $0xfff,%r9d
   f:	75 27                	jne    0x38
  11:	55                   	push   %rbp
  12:	48 89 fd             	mov    %rdi,%rbp
  15:	53                   	push   %rbx
  16:	89 cb                	mov    %ecx,%ebx
  18:	48 85 ff             	test   %rdi,%rdi
  1b:	74 3b                	je     0x58
  1d:	41 89 da             	mov    %ebx,%r10d
  20:	48 89 ef             	mov    %rbp,%rdi
  23:	b8 09 00 00 00       	mov    $0x9,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 66                	ja     0x98
  32:	5b                   	pop    %rbx
  33:	5d                   	pop    %rbp
  34:	c3                   	retq   
  35:	0f 1f 00             	nopl   (%rax)
  38:	48 8b 05 f9 52 0c 00 	mov    0xc52f9(%rip),%rax        # 0xc5338
  3f:	64                   	fs

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 66                	ja     0x6e
   8:	5b                   	pop    %rbx
   9:	5d                   	pop    %rbp
   a:	c3                   	retq   
   b:	0f 1f 00             	nopl   (%rax)
   e:	48 8b 05 f9 52 0c 00 	mov    0xc52f9(%rip),%rax        # 0xc530e
  15:	64                   	fs
[  202.339817][T27281] RSP: 002b:00007ffc53280778 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
[  202.339820][T27281] RAX: ffffffffffffffda RBX: 0000000000002022 RCX: 00007fdb25ea1b62
[  202.339822][T27281] RDX: 0000000000000003 RSI: 0000000006400000 RDI: 0000000000000000
[  202.339823][T27281] RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
[  202.339825][T27281] R10: 0000000000002022 R11: 0000000000000246 R12: 0000000000401170
[  202.339826][T27281] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  202.339842][T27281]  </TASK>
[  202.571229][T27281] BUG: scheduling while atomic: compaction_test/27281/0x00000003
[  202.571235][T27281] no locks held by compaction_test/27281.
[  202.571236][T27281] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c crc32c_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg ast drm_vram_helper drm_ttm_helper ttm ipmi_ssif drm_kms_helper syscopyarea ahci libahci sysfillrect acpi_ipmi intel_uncore mei_me joydev ipmi_si sysimgblt ioatdma libata i2c_i801 fb_sys_fops mei ipmi_devintf i2c_smbus intel_pch_thermal lpc_ich dca wmi ipmi_msghandler acpi_pad acpi_power_meter fuse ip_tables
[  202.571302][T27281] CPU: 78 PID: 27281 Comm: compaction_test Tainted: G S      W         5.19.0-rc2-00007-g2bd8eec68f74 #1
[  202.571305][T27281] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
[  202.571307][T27281] Call Trace:
[  202.571309][T27281]  <TASK>
[202.571313][T27281] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[202.571321][T27281] __schedule_bug.cold (kernel/sched/core.c:5661) 
[202.571328][T27281] schedule_debug (arch/x86/include/asm/preempt.h:35 kernel/sched/core.c:5688) 
[202.571338][T27281] __schedule (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 kernel/sched/features.h:40 kernel/sched/core.c:6324) 
[202.571348][T27281] ? io_schedule_timeout (kernel/sched/core.c:6310) 
[202.571352][T27281] ? vm_mmap_pgoff (include/linux/mm.h:2706 mm/util.c:557) 
[202.571363][T27281] schedule (include/linux/instrumented.h:71 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:134 (discriminator 1) include/linux/thread_info.h:118 (discriminator 1) include/linux/sched.h:2196 (discriminator 1) kernel/sched/core.c:6502 (discriminator 1)) 
[202.571368][T27281] exit_to_user_mode_loop (kernel/entry/common.c:159) 
[202.571374][T27281] exit_to_user_mode_prepare (kernel/entry/common.c:201) 
[202.571377][T27281] syscall_exit_to_user_mode (kernel/entry/common.c:128 kernel/entry/common.c:296) 
[202.571383][T27281] do_syscall_64 (arch/x86/entry/common.c:87) 
[202.571387][T27281] ? __local_bh_enable (kernel/softirq.c:357) 
[202.571392][T27281] ? __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:415 kernel/softirq.c:600) 
[202.571400][T27281] ? irqentry_exit_to_user_mode (kernel/entry/common.c:129 kernel/entry/common.c:309) 
[202.571407][T27281] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4526) 
[202.571412][T27281] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  202.571416][T27281] RIP: 0033:0x7fdb25ea1b62
[ 202.571421][T27281] Code: e4 e8 b2 4b 01 00 66 90 41 f7 c1 ff 0f 00 00 75 27 55 48 89 fd 53 89 cb 48 85 ff 74 3b 41 89 da 48 89 ef b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 5b 5d c3 0f 1f 00 48 8b 05 f9 52 0c 00 64
All code
========
   0:	e4 e8                	in     $0xe8,%al
   2:	b2 4b                	mov    $0x4b,%dl
   4:	01 00                	add    %eax,(%rax)
   6:	66 90                	xchg   %ax,%ax
   8:	41 f7 c1 ff 0f 00 00 	test   $0xfff,%r9d
   f:	75 27                	jne    0x38
  11:	55                   	push   %rbp
  12:	48 89 fd             	mov    %rdi,%rbp
  15:	53                   	push   %rbx
  16:	89 cb                	mov    %ecx,%ebx
  18:	48 85 ff             	test   %rdi,%rdi
  1b:	74 3b                	je     0x58
  1d:	41 89 da             	mov    %ebx,%r10d
  20:	48 89 ef             	mov    %rbp,%rdi
  23:	b8 09 00 00 00       	mov    $0x9,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 66                	ja     0x98
  32:	5b                   	pop    %rbx
  33:	5d                   	pop    %rbp
  34:	c3                   	retq   
  35:	0f 1f 00             	nopl   (%rax)
  38:	48 8b 05 f9 52 0c 00 	mov    0xc52f9(%rip),%rax        # 0xc5338
  3f:	64                   	fs

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 66                	ja     0x6e
   8:	5b                   	pop    %rbx
   9:	5d                   	pop    %rbp
   a:	c3                   	retq   
   b:	0f 1f 00             	nopl   (%rax)
   e:	48 8b 05 f9 52 0c 00 	mov    0xc52f9(%rip),%rax        # 0xc530e
  15:	64                   	fs
[  202.571423][T27281] RSP: 002b:00007ffc53280778 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
[  202.571426][T27281] RAX: 00007fcc735a6000 RBX: 0000000000002022 RCX: 00007fdb25ea1b62
[  202.571428][T27281] RDX: 0000000000000003 RSI: 0000000006400000 RDI: 0000000000000000
[  202.571429][T27281] RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
[  202.571431][T27281] R10: 0000000000002022 R11: 0000000000000246 R12: 0000000000401170
[  202.571432][T27281] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  202.571446][T27281]  </TASK>
[  215.004337][ T1122]
[  228.735493][ T1122]
[  242.528575][ T1122]
[  256.379123][ T1122]
[  269.551898][  T569] BUG: sleeping function called from invalid context at mm/migrate.c:1380
[  269.551906][  T569] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 569, name: kcompactd1
[  269.551909][  T569] preempt_count: 1, expected: 0
[  269.551912][  T569] no locks held by kcompactd1/569.
[  269.551916][  T569] CPU: 72 PID: 569 Comm: kcompactd1 Tainted: G S      W         5.19.0-rc2-00007-g2bd8eec68f74 #1
[  269.551921][  T569] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
[  269.551924][  T569] Call Trace:
[  269.551926][  T569]  <TASK>
[ 269.551934][ T569] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[ 269.551945][ T569] __might_resched.cold (kernel/sched/core.c:9792) 
[ 269.551958][ T569] migrate_pages (include/linux/sched.h:2059 mm/migrate.c:1380) 
[ 269.551971][ T569] ? isolate_freepages (mm/compaction.c:1687) 
[ 269.551978][ T569] ? split_map_pages (mm/compaction.c:1711) 
[ 269.551994][ T569] ? buffer_migrate_page_norefs (mm/migrate.c:1345) 
[ 269.552002][ T569] ? isolate_migratepages (mm/compaction.c:1959) 
[ 269.552023][ T569] compact_zone (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/compaction.h:68 mm/compaction.c:2419) 
[ 269.552054][ T569] ? compaction_suitable (mm/compaction.c:2292) 
[ 269.552063][ T569] ? lock_acquire (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:5667 kernel/locking/lockdep.c:5630) 
[ 269.552069][ T569] ? finish_wait (include/linux/list.h:134 include/linux/list.h:206 kernel/sched/wait.c:407) 
[ 269.552082][ T569] proactive_compact_node (mm/compaction.c:2660 (discriminator 2)) 
[ 269.552089][ T569] ? compact_store (mm/compaction.c:2648) 
[ 269.552115][ T569] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4526) 
[ 269.552121][ T569] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 arch/x86/include/asm/irqflags.h:138 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 269.552134][ T569] kcompactd (mm/compaction.c:2011 mm/compaction.c:2031 mm/compaction.c:2978) 
[ 269.552152][ T569] ? kcompactd_do_work (mm/compaction.c:2924) 
[ 269.552161][ T569] ? prepare_to_swait_exclusive (kernel/sched/wait.c:414) 
[ 269.552174][ T569] ? __kthread_parkme (arch/x86/include/asm/bitops.h:207 (discriminator 4) include/asm-generic/bitops/instrumented-non-atomic.h:135 (discriminator 4) kernel/kthread.c:270 (discriminator 4)) 
[ 269.552178][ T569] ? schedule (arch/x86/include/asm/bitops.h:207 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:135 (discriminator 1) include/linux/thread_info.h:118 (discriminator 1) include/linux/sched.h:2196 (discriminator 1) kernel/sched/core.c:6502 (discriminator 1)) 
[ 269.552183][ T569] ? kcompactd_do_work (mm/compaction.c:2924) 
[ 269.552193][ T569] kthread (kernel/kthread.c:376) 
[ 269.552196][ T569] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 269.552206][ T569] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[  269.552235][  T569]  </TASK>
[  269.961505][  T568] BUG: scheduling while atomic: kcompactd0/568/0x00000028
[  269.961512][  T568] no locks held by kcompactd0/568.
[  269.961514][  T568] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c crc32c_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg ast drm_vram_helper drm_ttm_helper ttm ipmi_ssif drm_kms_helper syscopyarea ahci libahci sysfillrect acpi_ipmi intel_uncore mei_me joydev ipmi_si sysimgblt ioatdma libata i2c_i801 fb_sys_fops mei ipmi_devintf i2c_smbus intel_pch_thermal lpc_ich dca wmi ipmi_msghandler acpi_pad acpi_power_meter fuse ip_tables
[  269.961581][  T568] CPU: 13 PID: 568 Comm: kcompactd0 Tainted: G S      W         5.19.0-rc2-00007-g2bd8eec68f74 #1
[  269.961585][  T568] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
[  269.961587][  T568] Call Trace:
[  269.961589][  T568]  <TASK>
[ 269.961596][ T568] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[ 269.961606][ T568] __schedule_bug.cold (kernel/sched/core.c:5661) 
[ 269.961615][ T568] schedule_debug (arch/x86/include/asm/preempt.h:35 kernel/sched/core.c:5688) 
[ 269.961625][ T568] __schedule (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 kernel/sched/features.h:40 kernel/sched/core.c:6324) 
[ 269.961637][ T568] ? io_schedule_timeout (kernel/sched/core.c:6310) 
[ 269.961641][ T568] ? find_held_lock (kernel/locking/lockdep.c:5156) 
[ 269.961647][ T568] ? prepare_to_wait_event (kernel/sched/wait.c:334 (discriminator 15)) 
[ 269.961657][ T568] schedule (include/linux/instrumented.h:71 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:134 (discriminator 1) include/linux/thread_info.h:118 (discriminator 1) include/linux/sched.h:2196 (discriminator 1) kernel/sched/core.c:6502 (discriminator 1)) 
[ 269.961662][ T568] schedule_timeout (kernel/time/timer.c:1936) 
[ 269.961668][ T568] ? usleep_range_state (kernel/time/timer.c:1897) 
[ 269.961673][ T568] ? timer_migration_handler (kernel/time/timer.c:1859) 
[ 269.961682][ T568] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 arch/x86/include/asm/irqflags.h:138 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 269.961687][ T568] ? prepare_to_wait_event (kernel/sched/wait.c:334 (discriminator 15)) 
[ 269.961695][ T568] kcompactd (include/linux/freezer.h:121 include/linux/freezer.h:193 mm/compaction.c:2950) 
[ 269.961707][ T568] ? kcompactd_do_work (mm/compaction.c:2924) 
[ 269.961713][ T568] ? prepare_to_swait_exclusive (kernel/sched/wait.c:414) 
[ 269.961720][ T568] ? __kthread_parkme (arch/x86/include/asm/bitops.h:207 (discriminator 4) include/asm-generic/bitops/instrumented-non-atomic.h:135 (discriminator 4) kernel/kthread.c:270 (discriminator 4)) 
[ 269.961724][ T568] ? schedule (arch/x86/include/asm/bitops.h:207 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:135 (discriminator 1) include/linux/thread_info.h:118 (discriminator 1) include/linux/sched.h:2196 (discriminator 1) kernel/sched/core.c:6502 (discriminator 1)) 
[ 269.961727][ T568] ? kcompactd_do_work (mm/compaction.c:2924) 
[ 269.961732][ T568] kthread (kernel/kthread.c:376) 
[ 269.961735][ T568] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 269.961741][ T568] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[  269.961758][  T568]  </TASK>
[  270.347843][  T569] BUG: scheduling while atomic: kcompactd1/569/0x00000017
[  270.347849][  T569] no locks held by kcompactd1/569.
[  270.347851][  T569] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c crc32c_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg ast drm_vram_helper drm_ttm_helper ttm ipmi_ssif drm_kms_helper syscopyarea ahci libahci sysfillrect acpi_ipmi intel_uncore mei_me joydev ipmi_si sysimgblt ioatdma libata i2c_i801 fb_sys_fops mei ipmi_devintf i2c_smbus intel_pch_thermal lpc_ich dca wmi ipmi_msghandler acpi_pad acpi_power_meter fuse ip_tables
[  270.347911][  T569] CPU: 72 PID: 569 Comm: kcompactd1 Tainted: G S      W         5.19.0-rc2-00007-g2bd8eec68f74 #1
[  270.347915][  T569] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
[  270.347917][  T569] Call Trace:
[  270.347920][  T569]  <TASK>
[ 270.347926][ T569] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[ 270.347935][ T569] __schedule_bug.cold (kernel/sched/core.c:5661) 
[ 270.347944][ T569] schedule_debug (arch/x86/include/asm/preempt.h:35 kernel/sched/core.c:5688) 
[ 270.347955][ T569] __schedule (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 kernel/sched/features.h:40 kernel/sched/core.c:6324) 
[ 270.347967][ T569] ? io_schedule_timeout (kernel/sched/core.c:6310) 
[ 270.347970][ T569] ? find_held_lock (kernel/locking/lockdep.c:5156) 
[ 270.347977][ T569] ? prepare_to_wait_event (kernel/sched/wait.c:334 (discriminator 15)) 
[ 270.347987][ T569] schedule (include/linux/instrumented.h:71 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:134 (discriminator 1) include/linux/thread_info.h:118 (discriminator 1) include/linux/sched.h:2196 (discriminator 1) kernel/sched/core.c:6502 (discriminator 1)) 
[ 270.347993][ T569] schedule_timeout (kernel/time/timer.c:1936) 
[ 270.347999][ T569] ? usleep_range_state (kernel/time/timer.c:1897) 
[ 270.348004][ T569] ? timer_migration_handler (kernel/time/timer.c:1859) 
[ 270.348013][ T569] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 arch/x86/include/asm/irqflags.h:138 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 270.348018][ T569] ? prepare_to_wait_event (kernel/sched/wait.c:334 (discriminator 15)) 
[ 270.348025][ T569] kcompactd (include/linux/freezer.h:121 include/linux/freezer.h:193 mm/compaction.c:2950) 
[ 270.348040][ T569] ? kcompactd_do_work (mm/compaction.c:2924) 
[ 270.348045][ T569] ? prepare_to_swait_exclusive (kernel/sched/wait.c:414) 
[ 270.348053][ T569] ? __kthread_parkme (arch/x86/include/asm/bitops.h:207 (discriminator 4) include/asm-generic/bitops/instrumented-non-atomic.h:135 (discriminator 4) kernel/kthread.c:270 (discriminator 4)) 
[ 270.348057][ T569] ? schedule (arch/x86/include/asm/bitops.h:207 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:135 (discriminator 1) include/linux/thread_info.h:118 (discriminator 1) include/linux/sched.h:2196 (discriminator 1) kernel/sched/core.c:6502 (discriminator 1)) 
[ 270.348059][ T569] ? kcompactd_do_work (mm/compaction.c:2924) 
[ 270.348065][ T569] kthread (kernel/kthread.c:376) 
[ 270.348068][ T569] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 270.348073][ T569] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[  270.348092][  T569]  </TASK>
[  270.616627][ T1122]
[  270.768074][T27574] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
[  270.768078][T27574] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 27574, name: date
[  270.768080][T27574] preempt_count: 1, expected: 0
[  270.768082][T27574] 1 lock held by date/27574:
[270.768084][T27574] #0: ffff88820bd53228 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/linux/mmap_lock.h:35 include/linux/mmap_lock.h:137 arch/x86/mm/fault.c:1338) 
[  270.768098][T27574] CPU: 4 PID: 27574 Comm: date Tainted: G S      W         5.19.0-rc2-00007-g2bd8eec68f74 #1
[  270.768101][T27574] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
[  270.768103][T27574] Call Trace:
[  270.768104][T27574]  <TASK>
[270.768108][T27574] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[270.768113][T27574] __might_resched.cold (kernel/sched/core.c:9792) 
[270.768120][T27574] ? __pmd_alloc (mm/memory.c:5763 include/linux/mm.h:2304 include/linux/mm.h:2390 include/linux/mm.h:2426 include/asm-generic/pgalloc.h:129 mm/memory.c:5214) 
[270.768125][T27574] kmem_cache_alloc (include/linux/sched/mm.h:274 mm/slab.h:723 mm/slub.c:3128 mm/slub.c:3222 mm/slub.c:3229 mm/slub.c:3239) 
[270.768137][T27574] __pmd_alloc (mm/memory.c:5763 include/linux/mm.h:2304 include/linux/mm.h:2390 include/linux/mm.h:2426 include/asm-generic/pgalloc.h:129 mm/memory.c:5214) 
[270.768144][T27574] __handle_mm_fault (include/linux/mm.h:2254 mm/memory.c:5003) 
[270.768155][T27574] ? copy_page_range (mm/memory.c:4955) 
[270.768159][T27574] ? __lock_release (kernel/locking/lockdep.c:5341) 
[270.768172][T27574] ? lock_is_held_type (kernel/locking/lockdep.c:5406 kernel/locking/lockdep.c:5708) 
[270.768181][T27574] ? handle_mm_fault (include/linux/rcupdate.h:274 include/linux/rcupdate.h:728 include/linux/memcontrol.h:1087 include/linux/memcontrol.h:1075 mm/memory.c:5120) 
[270.768188][T27574] handle_mm_fault (mm/memory.c:5140) 
[270.768195][T27574] do_user_addr_fault (arch/x86/mm/fault.c:1397) 
[270.768206][T27574] exc_page_fault (arch/x86/include/asm/irqflags.h:29 arch/x86/include/asm/irqflags.h:70 arch/x86/include/asm/irqflags.h:130 arch/x86/mm/fault.c:1492 arch/x86/mm/fault.c:1540) 
[270.768211][T27574] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[270.768215][T27574] RIP: 0010:__clear_user (arch/x86/lib/usercopy_64.c:24) 
[ 270.768220][T27574] Code: 00 00 00 e8 a2 28 56 ff 0f 01 cb 48 89 d8 48 c1 eb 03 48 89 ef 83 e0 07 48 89 d9 48 85 c9 74 19 66 2e 0f 1f 84 00 00 00 00 00 <48> c7 07 00 00 00 00 48 83 c7 08 ff c9 75 f1 48 89 c1 85 c9 74 0a
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e8                	add    %ch,%al
   4:	a2 28 56 ff 0f 01 cb 	movabs %al,0x8948cb010fff5628
   b:	48 89 
   d:	d8 48 c1             	fmuls  -0x3f(%rax)
  10:	eb 03                	jmp    0x15
  12:	48 89 ef             	mov    %rbp,%rdi
  15:	83 e0 07             	and    $0x7,%eax
  18:	48 89 d9             	mov    %rbx,%rcx
  1b:	48 85 c9             	test   %rcx,%rcx
  1e:	74 19                	je     0x39
  20:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  27:	00 00 00 
  2a:*	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)		<-- trapping instruction
  31:	48 83 c7 08          	add    $0x8,%rdi
  35:	ff c9                	dec    %ecx
  37:	75 f1                	jne    0x2a
  39:	48 89 c1             	mov    %rax,%rcx
  3c:	85 c9                	test   %ecx,%ecx
  3e:	74 0a                	je     0x4a

Code starting with the faulting instruction
===========================================
   0:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
   7:	48 83 c7 08          	add    $0x8,%rdi
   b:	ff c9                	dec    %ecx
   d:	75 f1                	jne    0x0
   f:	48 89 c1             	mov    %rax,%rcx
  12:	85 c9                	test   %ecx,%ecx
  14:	74 0a                	je     0x20
[  270.768223][T27574] RSP: 0018:ffffc900350dfb28 EFLAGS: 00050202
[  270.768226][T27574] RAX: 0000000000000000 RBX: 00000000000001a4 RCX: 00000000000001a4
[  270.768227][T27574] RDX: 0000000000000000 RSI: ffff88820bd53228 RDI: 00005649441d92e0
[  270.768229][T27574] RBP: 00005649441d92e0 R08: ffff88a0589ec810 R09: ffffffff85f06fa7
[  270.768231][T27574] R10: fffffbfff0be0df4 R11: 0000000000000001 R12: 0000000000000000
[  270.768232][T27574] R13: 000000000001c498 R14: 00005649441d92e0 R15: 000000000001c2e0
[270.768249][T27574] ? __clear_user (arch/x86/include/asm/smap.h:39 arch/x86/lib/usercopy_64.c:23) 
[270.768252][T27574] load_elf_binary (fs/binfmt_elf.c:143 fs/binfmt_elf.c:1244) 
[270.768279][T27574] ? load_elf_interp+0xa80/0xa80 
[270.768285][T27574] ? search_binary_handler (fs/exec.c:1728) 
[270.768297][T27574] search_binary_handler (fs/exec.c:1728) 
[270.768302][T27574] ? bprm_change_interp (fs/exec.c:1707) 
[270.768310][T27574] ? exec_binprm (include/linux/rcupdate.h:274 include/linux/rcupdate.h:728 fs/exec.c:1761) 
[270.768317][T27574] exec_binprm (fs/exec.c:1770) 
[270.768325][T27574] bprm_execve (fs/exec.c:1920) 
[270.768330][T27574] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1806) 
[270.768336][T27574] do_execveat_common+0x4c7/0x680 
[270.768344][T27574] ? getname_flags (fs/namei.c:205) 
[270.768350][T27574] __x64_sys_execve (fs/exec.c:2088) 
[270.768356][T27574] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[270.768361][T27574] ? do_user_addr_fault (arch/x86/mm/fault.c:1422) 
[270.768367][T27574] ? irqentry_exit_to_user_mode (kernel/entry/common.c:129 kernel/entry/common.c:309) 
[270.768374][T27574] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4526) 
[270.768379][T27574] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  270.768384][T27574] RIP: 0033:0x7f1a7a7936c7
[ 270.768390][T27574] Code: Unable to access opcode bytes at RIP 0x7f1a7a79369d.

Code starting with the faulting instruction
===========================================
[  270.768392][T27574] RSP: 002b:00007ffe741919f8 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  270.768394][T27574] RAX: ffffffffffffffda RBX: 00005643b084c428 RCX: 00007f1a7a7936c7
[  270.768396][T27574] RDX: 00005643b084ff48 RSI: 00005643b084c428 RDI: 00005643b0850208
[  270.768397][T27574] RBP: 00005643b079246e R08: 00005643b0792470 R09: 00005643b079247b
[  270.768398][T27574] R10: 000000000000006e R11: 0000000000000246 R12: 00005643b084ff48
[  270.768400][T27574] R13: 0000000000000002 R14: 00005643b084ff48 R15: 00005643b0850208
[  270.768415][T27574]  </TASK>
[  270.768815][T27574] BUG: scheduling while atomic: date/27574/0x00000002
[  270.768818][T27574] no locks held by date/27574.
[  270.768819][T27574] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c crc32c_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg ast drm_vram_helper drm_ttm_helper ttm ipmi_ssif drm_kms_helper syscopyarea ahci libahci sysfillrect acpi_ipmi intel_uncore mei_me joydev ipmi_si sysimgblt ioatdma libata i2c_i801 fb_sys_fops mei ipmi_devintf i2c_smbus intel_pch_thermal lpc_ich dca wmi ipmi_msghandler acpi_pad acpi_power_meter fuse ip_tables
[  270.768871][T27574] CPU: 4 PID: 27574 Comm: date Tainted: G S      W         5.19.0-rc2-00007-g2bd8eec68f74 #1
[  270.768874][T27574] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
[  270.768876][T27574] Call Trace:
[  270.768878][T27574]  <TASK>
[270.768881][T27574] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[270.768886][T27574] __schedule_bug.cold (kernel/sched/core.c:5661) 
[270.768892][T27574] schedule_debug (arch/x86/include/asm/preempt.h:35 kernel/sched/core.c:5688) 
[270.768900][T27574] __schedule (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 kernel/sched/features.h:40 kernel/sched/core.c:6324) 
[270.768907][T27574] ? rwlock_bug+0xc0/0xc0 
[270.768913][T27574] ? io_schedule_timeout (kernel/sched/core.c:6310) 
[270.768919][T27574] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4526) 
[270.768923][T27574] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 arch/x86/include/asm/irqflags.h:138 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[270.768931][T27574] do_task_dead (kernel/sched/core.c:6447 (discriminator 4)) 
[270.768938][T27574] do_exit (include/trace/events/sched.h:333 kernel/exit.c:786) 
[270.768948][T27574] do_group_exit (kernel/exit.c:906) 
[270.768955][T27574] get_signal (kernel/signal.c:2857) 
[270.768965][T27574] ? search_binary_handler (fs/exec.c:1707) 
[270.768976][T27574] ? ptrace_signal (kernel/signal.c:2627) 
[270.768980][T27574] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4526) 
[270.768984][T27574] ? kasan_quarantine_put (arch/x86/include/asm/irqflags.h:45 (discriminator 1) arch/x86/include/asm/irqflags.h:80 (discriminator 1) arch/x86/include/asm/irqflags.h:138 (discriminator 1) mm/kasan/quarantine.c:242 (discriminator 1)) 
[270.768988][T27574] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:50 (discriminator 22)) 
[270.768998][T27574] arch_do_signal_or_restart (arch/x86/kernel/signal.c:869) 
[270.769004][T27574] ? get_sigframe_size (arch/x86/kernel/signal.c:866) 
[270.769009][T27574] ? do_execveat_common+0x1c0/0x680 
[270.769022][T27574] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4526) 
[270.769029][T27574] exit_to_user_mode_loop (kernel/entry/common.c:168) 
[270.769035][T27574] exit_to_user_mode_prepare (kernel/entry/common.c:201) 
[270.769039][T27574] syscall_exit_to_user_mode (kernel/entry/common.c:128 kernel/entry/common.c:296) 
[270.769044][T27574] do_syscall_64 (arch/x86/entry/common.c:87) 
[270.769050][T27574] ? do_user_addr_fault (arch/x86/mm/fault.c:1422) 
[270.769057][T27574] ? irqentry_exit_to_user_mode (kernel/entry/common.c:129 kernel/entry/common.c:309) 
[270.769064][T27574] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4526) 
[270.769069][T27574] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  270.769073][T27574] RIP: 0033:0x7f1a7a7936c7
[ 270.769076][T27574] Code: Unable to access opcode bytes at RIP 0x7f1a7a79369d.

Code starting with the faulting instruction
===========================================
[  270.769077][T27574] RSP: 002b:00007ffe741919f8 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  270.769080][T27574] RAX: fffffffffffffff2 RBX: 00005643b084c428 RCX: 00007f1a7a7936c7
[  270.769082][T27574] RDX: 00005643b084ff48 RSI: 00005643b084c428 RDI: 00005643b0850208
[  270.769083][T27574] RBP: 00005643b079246e R08: 00005643b0792470 R09: 00005643b079247b
[  270.769084][T27574] R10: 000000000000006e R11: 0000000000000246 R12: 00005643b084ff48
[  270.769086][T27574] R13: 0000000000000002 R14: 00005643b084ff48 R15: 00005643b0850208
[  270.769100][T27574]  </TASK>
[  271.701080][ T1124] Segmentation fault
[  271.701094][ T1124]
[  284.402869][ T1122]


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



--2mbpD809lbQkAB7H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="config-5.19.0-rc2-00007-g2bd8eec68f74"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.19.0-rc2 Kernel Configuration
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
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
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

--2mbpD809lbQkAB7H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export job_origin='kernel-selftests-vm.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-csl-2sp9'
	export tbox_group='lkp-csl-2sp9'
	export submit_id='62be72df16d9d1f1eba55ba6'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp9/kernel-selftests-vm-2-ucode=0x500320a-debian-11.1-x86_64-20220510.cgz-2bd8eec68f740608db5ea58ecff06965228764cb-20220701-61931-1kf84f4-5.yaml'
	export id='736eaeeed2428aa1da1706f017e66af129c17f29'
	export queuer_version='/zday/lkp'
	export kconfig='x86_64-rhel-8.3-kselftests'
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
	export commit='2bd8eec68f740608db5ea58ecff06965228764cb'
	export ucode='0x500320a'
	export need_kconfig_hw='{"I40E"=>"y"}
SATA_AHCI'
	export need_kconfig=\{\"GUP_BENCHMARK\"\=\>\"y,\ v4.15-rc1,\ \<\=\ v5.10\"\}'
'\{\"GUP_TEST\"\=\>\"y,\ v5.11-rc1\"\}
	export initrds='linux_headers
linux_selftests'
	export enqueue_time='2022-07-01 12:06:56 +0800'
	export _id='62be72e016d9d1f1eba55ba8'
	export _rt='/result/kernel-selftests/vm-2-ucode=0x500320a/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='1a6275a1cb4dbe083f467378dcf99f9410fadc42'
	export base_commit='03c765b0e3b4cb5063276b086c76f7a612856a9a'
	export branch='linux-review/Mel-Gorman/Drain-remote-per-cpu-directly/20220613-230139'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/kernel-selftests/vm-2-ucode=0x500320a/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/3'
	export scheduler_version='/lkp/lkp/.src-20220630-123532'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/vm-2-ucode=0x500320a/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/vmlinuz-5.19.0-rc2-00007-g2bd8eec68f74
branch=linux-review/Mel-Gorman/Drain-remote-per-cpu-directly/20220613-230139
job=/lkp/jobs/scheduled/lkp-csl-2sp9/kernel-selftests-vm-2-ucode=0x500320a-debian-11.1-x86_64-20220510.cgz-2bd8eec68f740608db5ea58ecff06965228764cb-20220701-61931-1kf84f4-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=2bd8eec68f740608db5ea58ecff06965228764cb
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/kernel-selftests_20220628.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/kernel-selftests-x86_64-a10a197d-1_20220626.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220216.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.19.0-rc2-block-02825-g6fdbf155565b'
	export repeat_to=8
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.BUG:sleeping_function_called_from_invalid_context_at_mm/migrate.c'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/vmlinuz-5.19.0-rc2-00007-g2bd8eec68f74'
	export dequeue_time='2022-07-01 12:12:19 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp9/kernel-selftests-vm-2-ucode=0x500320a-debian-11.1-x86_64-20220510.cgz-2bd8eec68f740608db5ea58ecff06965228764cb-20220701-61931-1kf84f4-5.cgz'

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

	run_setup sc_nr_hugepages=2 $LKP_SRC/setup/sysctl

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='vm' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='vm' $LKP_SRC/stats/wrapper kernel-selftests
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

--2mbpD809lbQkAB7H
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AARZWg==

--2mbpD809lbQkAB7H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8=
=2E3-kselftests-2bd8eec68f740608db5ea58ecff06965228764cb
2022-07-01 04:14:01 ln -sf /usr/bin/clang
2022-07-01 04:14:01 ln -sf /usr/bin/llc
2022-07-01 04:14:01 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
LKP WARN miss config CONFIG_MEM_SOFT_DIRTY=3D of vm/config
2022-07-01 04:14:01 make -C vm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-2bd8eec68f740608db5ea58ecff06965228764cb/tools/testing/selftests/vm'
/bin/sh ./check_config.sh gcc
make --no-builtin-rules ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-2bd8eec68f740608db5ea58ecff06965228764cb'
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/unifdef
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/termbits-common.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/linux/fsl_mc.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/rkisp1-config.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/counter.h
  HDRINST usr/include/linux/sev-guest.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/cfm_bridge.h
  HDRINST usr/include/linux/misc/bcm_vk.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/amt.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/ioam6.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/iio/buffer.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/mctp.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/landlock.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/nl80211-vnd-intel.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/nfnetlink_hook.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/cxl_mem.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/virtio_i2c.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/pfrut.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/rpmsg_types.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/acrn.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/virtio_bt.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/comedi.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/wwan.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/ioam6_iptunnel.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/spi/spi.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/virtio_snd.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/virtio_pcidev.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/map_to_14segment.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/cachefiles.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/surface_aggregator/dtx.h
  HDRINST usr/include/linux/surface_aggregator/cdev.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/ioprio.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/virtio_scmi.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/ccs.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/kfd_sysfs.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/vduse.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/f2fs.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/vdpa.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/virtio_gpio.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/cifs/cifs_netlink.h
  HDRINST usr/include/linux/ioam6_genl.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/irdma-abi.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_mpi3mr.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/intel/avs/tokens.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/snd_ar_tokens.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/sgx.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/amd_hsmp.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-2bd8eec68f740608db5ea58ecff06965228764cb'
gcc -Wall -I ../../../../usr/include   -no-pie    madv_populate.c vm_util.c=
 -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8e=
ec68f740608db5ea58ecff06965228764cb/tools/testing/selftests/vm/madv_populate
gcc -Wall -I ../../../../usr/include   -no-pie    soft-dirty.c vm_util.c -l=
rt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec6=
8f740608db5ea58ecff06965228764cb/tools/testing/selftests/vm/soft-dirty
gcc -Wall -I ../../../../usr/include   -no-pie    split_huge_page_test.c vm=
_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-2bd8eec68f740608db5ea58ecff06965228764cb/tools/testing/selftests/vm/split=
_huge_page_test
gcc -Wall -I ../../../../usr/include   -no-pie    compaction_test.c -lrt -l=
pthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f740=
608db5ea58ecff06965228764cb/tools/testing/selftests/vm/compaction_test
gcc -Wall -I ../../../../usr/include   -no-pie    gup_test.c -lrt -lpthread=
 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f740608db5e=
a58ecff06965228764cb/tools/testing/selftests/vm/gup_test
gcc -Wall -I ../../../../usr/include   -no-pie    hmm-tests.c -lrt -lpthrea=
d -lhugetlbfs -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec=
68f740608db5ea58ecff06965228764cb/tools/testing/selftests/vm/hmm-tests
gcc -Wall -I ../../../../usr/include   -no-pie    hugetlb-madvise.c -lrt -l=
pthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f740=
608db5ea58ecff06965228764cb/tools/testing/selftests/vm/hugetlb-madvise
gcc -Wall -I ../../../../usr/include   -no-pie    hugepage-mmap.c -lrt -lpt=
hread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f74060=
8db5ea58ecff06965228764cb/tools/testing/selftests/vm/hugepage-mmap
gcc -Wall -I ../../../../usr/include   -no-pie    hugepage-mremap.c -lrt -l=
pthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f740=
608db5ea58ecff06965228764cb/tools/testing/selftests/vm/hugepage-mremap
gcc -Wall -I ../../../../usr/include   -no-pie    hugepage-shm.c -lrt -lpth=
read -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f740608=
db5ea58ecff06965228764cb/tools/testing/selftests/vm/hugepage-shm
gcc -Wall -I ../../../../usr/include   -no-pie    hugepage-vmemmap.c -lrt -=
lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f74=
0608db5ea58ecff06965228764cb/tools/testing/selftests/vm/hugepage-vmemmap
gcc -Wall -I ../../../../usr/include   -no-pie    khugepaged.c -lrt -lpthre=
ad -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f740608db=
5ea58ecff06965228764cb/tools/testing/selftests/vm/khugepaged
gcc -Wall -I ../../../../usr/include   -no-pie    map_fixed_noreplace.c -lr=
t -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68=
f740608db5ea58ecff06965228764cb/tools/testing/selftests/vm/map_fixed_norepl=
ace
gcc -Wall -I ../../../../usr/include   -no-pie    map_hugetlb.c -lrt -lpthr=
ead -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f740608d=
b5ea58ecff06965228764cb/tools/testing/selftests/vm/map_hugetlb
gcc -Wall -I ../../../../usr/include   -no-pie    map_populate.c -lrt -lpth=
read -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f740608=
db5ea58ecff06965228764cb/tools/testing/selftests/vm/map_populate
gcc -Wall -I ../../../../usr/include   -no-pie    memfd_secret.c -lrt -lpth=
read -lcap -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f=
740608db5ea58ecff06965228764cb/tools/testing/selftests/vm/memfd_secret
gcc -Wall -I ../../../../usr/include   -no-pie    migration.c -lrt -lpthrea=
d -lnuma -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f74=
0608db5ea58ecff06965228764cb/tools/testing/selftests/vm/migration
gcc -Wall -I ../../../../usr/include   -no-pie    mlock-random-test.c -lrt =
-lpthread -lcap -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8e=
ec68f740608db5ea58ecff06965228764cb/tools/testing/selftests/vm/mlock-random=
-test
gcc -Wall -I ../../../../usr/include   -no-pie    mlock2-tests.c -lrt -lpth=
read -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f740608=
db5ea58ecff06965228764cb/tools/testing/selftests/vm/mlock2-tests
gcc -Wall -I ../../../../usr/include   -no-pie    mrelease_test.c -lrt -lpt=
hread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f74060=
8db5ea58ecff06965228764cb/tools/testing/selftests/vm/mrelease_test
gcc -Wall -I ../../../../usr/include   -no-pie    mremap_dontunmap.c -lrt -=
lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f74=
0608db5ea58ecff06965228764cb/tools/testing/selftests/vm/mremap_dontunmap
gcc -Wall -I ../../../../usr/include   -no-pie    mremap_test.c -lrt -lpthr=
ead -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f740608d=
b5ea58ecff06965228764cb/tools/testing/selftests/vm/mremap_test
gcc -Wall -I ../../../../usr/include   -no-pie    on-fault-limit.c -lrt -lp=
thread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f7406=
08db5ea58ecff06965228764cb/tools/testing/selftests/vm/on-fault-limit
gcc -Wall -I ../../../../usr/include   -no-pie    thuge-gen.c -lrt -lpthrea=
d -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f740608db5=
ea58ecff06965228764cb/tools/testing/selftests/vm/thuge-gen
gcc -Wall -I ../../../../usr/include   -no-pie    transhuge-stress.c -lrt -=
lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f74=
0608db5ea58ecff06965228764cb/tools/testing/selftests/vm/transhuge-stress
gcc -Wall -I ../../../../usr/include   -no-pie    userfaultfd.c -lrt -lpthr=
ead -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f740608d=
b5ea58ecff06965228764cb/tools/testing/selftests/vm/userfaultfd
gcc -Wall -I ../../../../usr/include   -no-pie    ksm_tests.c -lrt -lpthrea=
d -lnuma -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f74=
0608db5ea58ecff06965228764cb/tools/testing/selftests/vm/ksm_tests
gcc -Wall -I ../../../../usr/include   -no-pie -m32 -mxsave  protection_key=
s.c -lrt -lpthread -lrt -ldl -lm -o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kselftests-2bd8eec68f740608db5ea58ecff06965228764cb/tools/testing/selftest=
s/vm/protection_keys_32
gcc -Wall -I ../../../../usr/include   -no-pie -m64 -mxsave  protection_key=
s.c -lrt -lpthread -lrt -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kse=
lftests-2bd8eec68f740608db5ea58ecff06965228764cb/tools/testing/selftests/vm=
/protection_keys_64
gcc -Wall -I ../../../../usr/include   -no-pie    va_128TBswitch.c -lrt -lp=
thread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f7406=
08db5ea58ecff06965228764cb/tools/testing/selftests/vm/va_128TBswitch
gcc -Wall -I ../../../../usr/include   -no-pie    virtual_address_range.c -=
lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec=
68f740608db5ea58ecff06965228764cb/tools/testing/selftests/vm/virtual_addres=
s_range
gcc -Wall -I ../../../../usr/include   -no-pie    write_to_hugetlbfs.c -lrt=
 -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-2bd8eec68f=
740608db5ea58ecff06965228764cb/tools/testing/selftests/vm/write_to_hugetlbfs
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-2bd8eec68f740608db5ea58ecff06965228764cb/tools/testing/selftests/vm'
2022-07-01 04:15:02 make run_tests -C vm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-2bd8eec68f740608db5ea58ecff06965228764cb/tools/testing/selftests/vm'
make --no-builtin-rules ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-2bd8eec68f740608db5ea58ecff06965228764cb'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-2bd8eec68f740608db5ea58ecff06965228764cb'
TAP version 13
1..4
# selftests: vm: madv_populate
# TAP version 13
# 1..21
# # [RUN] test_prot_read
# ok 1 MADV_POPULATE_READ with PROT_READ
# ok 2 MADV_POPULATE_WRITE with PROT_READ
# # [RUN] test_prot_write
# ok 3 MADV_POPULATE_READ with PROT_WRITE
# ok 4 MADV_POPULATE_WRITE with PROT_WRITE
# # [RUN] test_holes
# ok 5 MADV_POPULATE_READ with holes in the middle
# ok 6 MADV_POPULATE_WRITE with holes in the middle
# ok 7 MADV_POPULATE_READ with holes at the end
# ok 8 MADV_POPULATE_WRITE with holes at the end
# ok 9 MADV_POPULATE_READ with holes at the beginning
# ok 10 MADV_POPULATE_WRITE with holes at the beginning
# # [RUN] test_populate_read
# ok 11 range initially not populated
# ok 12 MADV_POPULATE_READ
# ok 13 range is populated
# # [RUN] test_populate_write
# ok 14 range initially not populated
# ok 15 MADV_POPULATE_WRITE
# ok 16 range is populated
# # [RUN] test_softdirty
# ok 17 range is not softdirty
# ok 18 MADV_POPULATE_READ
# ok 19 range is not softdirty
# ok 20 MADV_POPULATE_WRITE
# not ok 21 range is softdirty
# Bail out! 1 out of 21 tests failed
# # Totals: pass:20 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: vm: madv_populate # exit=3D1
# selftests: vm: soft-dirty
# TAP version 13
# 1..5
# # dirty bit was 0, but should be 1 (i=3D0)
# not ok 1 Test test_simple
# not ok 2 Test test_vma_reuse dirty bit of allocated page
# not ok 3 Test test_vma_reuse dirty bit of reused address page
# ok 4 Test test_hugepage huge page allocation
# # dirty bit was 0, but should be 1 (i=3D0)
# not ok 5 Test test_hugepage huge page dirty bit
# # Totals: pass:1 fail:4 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: vm: soft-dirty
# selftests: vm: split_huge_page_test
# Split huge pages successful
# Split PTE-mapped huge pages successful
# Please enable pr_debug in split_huge_pages_in_file() if you need more inf=
o.
# file-backed THP split test done, please check dmesg for more information
ok 3 selftests: vm: split_huge_page_test
# selftests: vm: run_vmtests.sh
# arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64 sparc64 x86_64
# -----------------------
# running ./hugepage-mmap
# -----------------------
# Returned address is 0x7f4229c00000
# First hex is 0
# First hex is 3020100
# [PASS]
# ----------------------
# running ./hugepage-shm
# ----------------------
# shmid: 0x0
# shmaddr: 0x7f5673200000
# Starting the writes:
# .........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E....................................
# Starting the Check...Done.
# [PASS]
# ---------------------
# running ./map_hugetlb
# ---------------------
# Default size hugepages
# Mapping 256 Mbytes
# Returned address is 0x7f2a9d400000
# First hex is 0
# First hex is 3020100
# [PASS]
# --------------------------------------------
# running ./hugepage-mremap ./huge/huge_mremap
# --------------------------------------------
# Map haddr: Returned address is 0x7eaa40000000
# Map daddr: Returned address is 0x7daa40000000
# Map vaddr: Returned address is 0x7faa40000000
# Address returned by mmap() =3D 0x7fe21617f000
# Mremap: Returned address is 0x7faa40000000
# First hex is 0
# First hex is 3020100
# [PASS]
# --------------------------
# running ./hugepage-vmemmap
# --------------------------
# Returned address is 0x7fbff2400000 whose pfn is 1097e00
# [PASS]
# ---------------------------------------------
# running ./hugetlb-madvise ./huge/madvise-test
# ---------------------------------------------
# [PASS]
# NOTE: The above hugetlb tests provide minimal coverage.  Use
#       https://github.com/libhugetlbfs/libhugetlbfs.git for
#       hugetlb regression testing.
# -----------------------------
# running ./map_fixed_noreplace
# -----------------------------
# mmap() @ 0x7f7717053000-0x7f7717058000 p=3D0x7f7717053000 result=3DSuccess
# unmap() successful
# mmap() @ 0x7f7717054000-0x7f7717057000 p=3D0x7f7717054000 result=3DSuccess
# mmap() @ 0x7f7717053000-0x7f7717058000 p=3D0xffffffffffffffff result=3DFi=
le exists
# mmap() @ 0x7f7717055000-0x7f7717056000 p=3D0xffffffffffffffff result=3DFi=
le exists
# mmap() @ 0x7f7717056000-0x7f7717058000 p=3D0xffffffffffffffff result=3DFi=
le exists
# mmap() @ 0x7f7717053000-0x7f7717055000 p=3D0xffffffffffffffff result=3DFi=
le exists
# mmap() @ 0x7f7717053000-0x7f7717054000 p=3D0x7f7717053000 result=3DSuccess
# mmap() @ 0x7f7717057000-0x7f7717058000 p=3D0x7f7717057000 result=3DSuccess
# unmap() successful
# OK
# [PASS]
# ---------------------
# running ./gup_test -u
# ---------------------
# GUP_FAST_BENCHMARK: Time: get:11907 put:368 us
# [PASS]
# ---------------------
# running ./gup_test -a
# ---------------------
# PIN_FAST_BENCHMARK: Time: get:12968 put:112 us
# [PASS]
# -----------------------------------------
# running ./gup_test -ct -F 0x1 0 19 0x1000
# -----------------------------------------
# DUMP_USER_PAGES_TEST: done
# [PASS]
# --------------------------------
# running ./userfaultfd anon 20 16
# --------------------------------
# nr_pages: 5104, nr_pages_per_cpu: 58
# bounces: 15, mode: rnd racing ver poll, userfaults: 2595 missing (117+106=
+119+104+89+83+100+84+75+77+70+72+71+62+64+54+57+41+66+59+51+48+34+38+38+37=
+35+36+40+49+40+35+22+25+33+37+29+22+31+27+32+25+17+15+19+24+13+13+24+13+13=
+17+15+12+9+3+9+6+5+8+5+4+4+3+4+1+1+1+1+0+1+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+=08) 8538 wp (220+222+198+193+192+206+182+181+167+183+172+174+157+173+16=
2+176+170+174+147+142+146+141+151+146+129+140+137+134+143+122+140+119+128+1=
24+118+108+110+122+100+109+103+109+104+114+95+96+92+95+86+92+78+72+74+72+83=
+74+62+67+63+57+55+47+52+49+47+47+36+43+36+35+28+29+26+18+22+13+19+17+11+15=
+14+7+9+8+4+3+2+0+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 105 missing (26+25+9+10+9=
+12+2+3+3+4+1+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+=08) 6688 wp (162+149+152+135+130+113+131+117+123+120+98+=
119+112+101+84+103+99+94+95+106+88+102+103+102+82+111+78+94+81+71+88+88+84+=
76+77+96+82+89+74+78+76+64+97+75+78+84+78+60+88+73+77+69+66+65+60+70+64+67+=
54+49+54+61+53+52+56+57+53+46+51+49+44+56+52+50+40+42+46+33+32+34+35+35+31+=
32+29+19+27+18+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 2743 missing (145+136+133+12=
1+113+111+93+93+91+92+75+68+79+67+72+59+54+65+54+53+55+49+34+52+39+48+37+33=
+40+38+43+34+29+33+22+20+31+31+20+21+26+20+21+14+14+21+16+13+9+11+14+7+9+10=
+8+5+6+4+6+2+8+1+1+3+0+2+4+3+2+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=08) 8=
696 wp (264+240+222+221+222+201+212+208+195+178+176+181+168+162+151+173+171=
+153+150+155+154+141+158+136+134+131+140+145+140+128+117+120+128+111+117+12=
5+112+108+112+111+100+115+104+87+90+89+93+94+102+81+79+77+82+72+68+60+68+73=
+54+63+49+61+49+46+37+41+38+36+36+31+28+28+29+21+16+15+20+17+14+13+13+9+6+5=
+7+6+2+1+=08)=20
# bounces: 12, mode: ver poll, userfaults: 253 missing (39+19+21+10+18+7+14=
+8+6+8+8+3+6+4+4+6+3+1+3+2+6+5+4+2+3+1+2+2+2+2+2+0+0+3+0+0+3+1+1+1+0+1+1+3+=
0+0+1+1+3+0+1+2+1+2+1+0+1+0+0+1+0+0+0+0+3+0+0+0+0+0+0+1+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+=08) 11084 wp (319+305+297+287+275+257+254+236+238+216+222+201=
+199+212+201+203+196+180+184+172+160+176+161+161+159+159+170+153+144+166+15=
8+146+146+132+135+138+123+131+125+119+108+119+131+121+116+109+119+113+115+1=
00+95+94+84+82+87+87+104+76+88+76+81+64+77+68+66+65+65+66+60+60+51+54+50+54=
+53+57+39+53+39+36+47+41+37+35+37+31+31+27+=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 2602 missing (127+132+113=
+102+116+82+78+78+68+70+76+78+71+73+69+61+54+54+46+44+58+44+45+50+36+39+41+=
32+43+43+32+45+29+33+34+35+28+26+31+14+19+23+21+12+15+27+16+18+15+18+6+9+9+=
10+12+2+7+7+7+4+6+2+4+2+0+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=08=
) 8539 wp (248+218+224+220+204+195+195+189+192+181+177+155+170+152+151+157+=
162+160+160+147+147+152+160+135+142+142+134+147+127+133+125+116+128+121+112=
+106+112+107+120+114+108+106+103+99+106+75+94+76+94+79+87+84+69+68+66+69+71=
+62+66+56+51+51+48+45+38+45+44+38+32+31+30+32+22+19+19+20+13+14+10+12+10+9+=
8+6+6+3+5+3+=08)=20
# bounces: 10, mode: racing poll, userfaults: 101 missing (32+15+22+9+8+5+2=
+3+0+0+1+1+1+1+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+=08) 6982 wp (177+158+153+154+128+135+125+120+129+126+109+121+=
109+127+119+120+102+97+105+108+109+108+95+109+100+99+88+79+100+86+81+90+92+=
65+85+90+75+80+87+87+73+81+70+80+82+73+77+88+71+78+79+73+79+70+66+65+58+60+=
58+56+76+74+61+42+52+48+49+55+49+47+46+47+46+57+43+37+32+33+27+39+35+41+34+=
26+34+31+30+27+=08)=20
# bounces: 9, mode: rnd poll, userfaults: 4131 missing (289+270+261+240+248=
+228+241+234+226+233+222+218+215+204+188+209+203+202+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=08) 11179 wp (441+440+441+430+4=
14+434+417+397+404+407+392+381+390+406+391+381+369+388+125+115+118+121+109+=
105+115+108+106+89+102+98+92+87+80+90+93+82+80+80+68+82+72+56+69+75+71+68+6=
1+65+58+58+58+55+52+42+51+49+52+45+40+45+42+40+36+40+32+33+32+28+27+29+27+2=
2+21+23+16+16+15+12+9+14+12+9+4+10+11+4+4+1+=08)=20
# bounces: 8, mode: poll, userfaults: 265 missing (33+28+31+14+11+11+12+9+9=
+12+8+6+6+6+4+2+2+4+4+3+3+1+1+1+2+0+2+3+1+4+1+3+0+2+3+2+2+1+2+2+2+1+1+0+2+0=
+0+1+0+1+1+0+0+1+0+0+0+0+1+1+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+1+0+0+0+0+0+0+0+=
0+0+0+0+0+=08) 10753 wp (320+292+252+271+273+251+243+221+235+222+204+206+20=
2+206+187+181+188+170+173+164+168+167+179+172+158+172+161+155+156+143+143+1=
36+137+128+126+139+130+118+114+118+113+116+109+119+123+94+115+98+104+87+97+=
92+97+91+79+81+86+75+80+78+71+70+78+64+66+73+69+71+67+53+49+47+50+54+49+48+=
42+37+46+44+38+37+39+41+46+27+34+28+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 2914 missing (182+154+=
149+140+130+101+108+104+113+86+80+87+85+82+66+77+70+62+65+65+44+52+43+40+40=
+42+49+41+36+29+37+32+32+25+20+25+30+25+18+32+19+24+21+19+12+8+12+16+14+7+5=
+5+7+9+7+5+5+3+4+3+0+4+2+2+1+0+2+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
=08) 8991 wp (267+265+259+259+240+237+222+204+197+223+184+209+206+190+188+1=
64+168+173+157+169+159+141+155+147+134+145+137+140+135+139+122+107+133+135+=
119+142+119+125+106+100+113+90+83+96+95+101+83+65+80+76+87+67+61+72+70+55+6=
8+67+60+55+49+42+49+56+32+39+31+28+21+22+27+22+24+16+26+19+21+16+17+10+12+1=
4+8+9+6+5+4+1+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 114 missing (27+26+21+7+4+=
5+5+5+4+4+2+2+0+1+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+=08) 6981 wp (166+154+148+154+141+139+134+120+119+144+113+1=
32+109+103+136+123+106+89+106+120+108+78+88+107+83+85+101+86+80+64+94+86+11=
7+81+105+82+64+78+77+92+72+83+93+69+69+80+84+80+93+75+65+80+80+65+87+58+71+=
61+65+61+56+72+72+60+60+43+48+67+46+33+40+40+33+43+41+35+50+24+36+41+44+45+=
31+23+33+28+15+19+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 2897 missing (176+160+141+137=
+118+113+101+85+120+89+87+73+77+83+63+63+58+76+63+48+57+48+44+41+46+49+48+3=
5+32+32+31+40+31+23+31+31+25+29+20+27+23+26+19+16+15+11+18+12+13+8+10+11+5+=
7+5+9+6+5+6+4+2+1+3+4+2+2+2+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=08) =
8879 wp (267+250+265+249+255+224+235+227+192+215+200+183+161+170+175+168+16=
9+178+150+162+157+161+148+148+148+143+139+125+136+133+132+109+119+131+112+9=
8+109+108+94+116+100+97+101+101+92+87+87+87+81+84+85+83+68+75+74+66+63+67+5=
2+50+57+57+44+40+37+36+35+25+28+21+35+14+23+23+14+16+13+13+12+13+12+9+8+10+=
10+5+6+2+=08)=20
# bounces: 4, mode: ver read, userfaults: 277 missing (51+32+19+21+14+7+8+1=
1+5+5+7+6+2+5+2+6+3+2+2+5+1+4+0+2+3+4+2+2+3+6+1+1+2+2+4+2+2+0+2+0+4+0+3+0+2=
+0+1+0+0+0+2+0+1+0+0+1+1+0+0+1+1+2+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+1+0+0+0+=
0+0+0+0+0+0+=08) 11299 wp (340+328+327+308+292+268+270+226+225+200+226+217+=
217+194+222+184+215+202+194+180+194+189+166+171+163+162+158+144+158+140+147=
+151+161+126+143+136+140+126+139+125+137+103+103+139+84+124+86+101+119+100+=
128+87+72+95+75+93+71+105+82+82+76+91+73+56+80+59+62+71+62+62+59+49+45+43+4=
4+52+51+35+56+42+33+38+39+48+34+31+23+25+=08)=20
# bounces: 3, mode: rnd racing read, userfaults: 2922 missing (155+158+150+=
128+121+114+102+114+105+88+86+89+88+77+69+75+68+71+53+54+53+66+48+47+46+41+=
42+32+34+39+31+40+32+33+30+23+27+22+32+24+23+23+20+12+16+14+13+11+10+9+8+3+=
10+4+8+5+7+2+6+1+2+3+0+1+1+3+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
=08) 8900 wp (288+249+253+240+248+240+219+207+180+206+191+199+168+190+170+1=
82+185+154+157+158+156+137+153+152+137+135+148+161+135+117+148+130+117+112+=
122+105+122+102+105+115+110+104+99+112+102+91+89+81+96+78+94+78+71+76+63+67=
+57+49+63+60+45+43+39+34+35+27+23+40+24+23+19+20+28+20+16+20+14+20+9+15+14+=
11+7+5+3+6+3+4+=08)=20
# bounces: 2, mode: racing read, userfaults: 116 missing (22+30+13+10+12+6+=
6+7+3+1+2+2+2+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+=08) 6779 wp (165+183+141+146+125+132+103+120+137+113+136+101=
+141+117+117+105+108+117+111+119+111+87+82+104+63+91+86+90+83+87+84+65+96+9=
7+103+71+94+69+82+85+69+66+53+76+87+83+73+57+83+75+59+69+58+56+73+71+75+47+=
70+58+55+55+69+56+52+51+74+56+40+42+51+50+41+26+39+44+32+35+30+32+38+26+34+=
17+26+31+31+21+=08)=20
# bounces: 1, mode: rnd read, userfaults: 2955 missing (165+165+144+142+135=
+145+120+105+90+93+96+87+81+73+71+68+69+61+57+55+60+42+52+52+50+41+40+37+34=
+40+32+45+36+29+24+21+29+23+20+16+17+22+19+17+16+10+23+12+12+8+9+9+5+4+7+2+=
4+6+4+1+2+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=08) 9019 w=
p (272+282+269+243+258+214+222+215+199+211+179+186+195+192+182+174+170+191+=
168+175+167+185+149+171+146+148+134+140+136+130+128+126+117+134+133+109+95+=
112+103+114+99+94+112+90+89+81+82+82+81+66+86+80+72+69+73+70+62+47+55+49+55=
+58+40+29+39+41+20+26+36+24+27+23+26+26+15+15+14+10+22+10+11+12+4+6+5+5+5+2=
+=08)=20
# bounces: 0, mode: read, userfaults: 231 missing (24+23+14+10+10+7+6+5+3+5=
+7+3+8+4+7+4+0+7+4+6+4+3+4+2+3+1+0+3+2+2+1+2+4+2+1+2+0+4+0+2+3+5+2+2+1+0+2+=
1+0+1+1+0+0+2+0+2+1+1+2+0+0+0+1+3+0+0+0+0+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+1+0+0+=08) 10557 wp (348+317+306+283+267+254+250+241+233+214+217+206+194+2=
23+210+193+170+183+184+168+182+153+189+156+159+162+162+140+166+143+153+130+=
126+127+142+126+128+130+139+120+116+129+99+91+81+88+92+107+83+103+100+93+96=
+85+64+75+70+75+63+78+62+57+55+54+39+63+65+54+59+50+45+58+44+46+41+32+37+31=
+32+30+39+36+33+25+36+22+19+11+=08)=20
# testing uffd-wp with pagemap (pgsize=3D4096): done
# testing uffd-wp with pagemap (pgsize=3D2097152): done
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 5104 missing (5104+=08)=
 5104 wp (5104+=08)=20
# [PASS]
# ------------------------------------
# running ./userfaultfd hugetlb 256 32
# ------------------------------------
# nr_pages: 88, nr_pages_per_cpu: 1
# bounces: 31, mode: rnd racing ver poll, userfaults: 82 missing (15+16+17+=
12+7+7+5+2+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+=08) 2255 wp (74+58+67+58+69+62+53+53+46+39+36+47+53+5=
4+40+35+51+44+42+46+41+33+40+37+35+36+33+34+37+30+29+34+35+33+30+29+24+21+2=
2+24+21+23+25+24+23+23+19+21+19+18+19+17+16+22+20+19+22+13+17+17+15+15+11+9=
+8+9+8+9+14+11+10+8+9+7+3+10+8+3+6+1+5+3+2+2+1+3+2+1+=08)=20
# bounces: 30, mode: racing ver poll, userfaults: 83 missing (13+4+6+4+5+7+=
8+2+4+0+6+4+2+0+3+0+1+0+1+0+2+1+1+0+0+4+3+1+0+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+=08) 3080 wp (106+95+89+95+85+80+77+79+70+75+72+67+63+65+63+5=
8+62+55+58+51+46+49+44+51+52+42+48+47+45+41+39+37+41+36+41+37+36+39+30+31+3=
2+28+35+31+29+32+27+28+21+21+24+26+21+17+20+21+21+23+22+19+15+21+22+17+17+1=
6+16+16+13+15+13+11+11+9+10+8+9+8+7+7+6+5+4+1+2+3+2+1+=08)=20
# bounces: 29, mode: rnd ver poll, userfaults: 86 missing (20+18+17+12+7+7+=
5+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+=08) 2542 wp (67+78+73+57+62+66+57+53+51+57+41+49+49+48+54+49=
+52+48+44+40+42+47+45+40+36+33+45+41+35+36+34+31+36+34+41+36+31+29+29+35+31=
+25+29+27+28+30+25+19+26+21+20+25+23+23+21+19+16+20+22+19+18+19+14+13+12+13=
+15+11+11+12+8+7+12+9+9+5+10+5+7+4+8+5+6+4+2+2+0+1+=08)=20
# bounces: 28, mode: ver poll, userfaults: 84 missing (9+19+6+1+5+6+3+3+3+2=
+2+3+3+1+3+2+3+1+0+2+1+1+1+0+0+0+1+0+1+1+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+=08) 2811 wp (96+96+91+86+73+83+70+70+78+72+65+63+62+60+66+50+51+60+=
48+47+55+48+46+47+47+41+38+45+40+41+41+43+44+34+35+35+32+35+28+27+27+24+27+=
29+28+32+25+22+23+22+20+20+23+19+17+21+20+15+14+16+16+12+9+11+13+7+10+11+5+=
10+7+8+9+6+8+3+2+6+5+3+4+0+4+3+1+3+1+1+=08)=20
# bounces: 27, mode: rnd racing poll, userfaults: 81 missing (22+16+13+10+8=
+7+1+2+2+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+=08) 2596 wp (72+82+77+77+65+63+65+58+58+47+55+54+49+56+52=
+47+48+45+44+48+42+42+42+44+38+38+46+44+45+41+33+38+33+40+39+32+30+31+35+27=
+27+28+27+26+28+29+29+25+23+25+21+18+20+22+25+20+21+21+18+22+15+16+17+8+16+=
11+11+9+9+9+4+10+8+11+10+0+7+4+5+3+5+5+4+0+0+2+0+0+=08)=20
# bounces: 26, mode: racing poll, userfaults: 85 missing (10+14+4+7+10+5+3+=
2+1+2+3+1+2+4+2+2+0+1+0+1+1+0+2+0+1+2+1+0+0+1+1+0+1+0+0+0+0+0+0+0+1+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+=08) 2850 wp (96+93+90+86+82+77+71+77+67+64+60+66+58+60+57+56+5=
3+58+52+49+51+44+48+49+48+40+42+38+45+40+35+35+39+40+38+38+33+31+29+32+31+3=
3+28+27+28+27+26+25+21+26+25+24+20+20+17+16+17+18+16+17+10+16+10+15+8+13+14=
+10+12+10+10+9+7+11+8+8+9+6+6+6+6+5+3+3+2+2+1+1+=08)=20
# bounces: 25, mode: rnd poll, userfaults: 84 missing (22+20+14+13+8+5+2+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+=08) 2574 wp (87+73+72+76+64+58+52+49+52+49+54+49+50+50+57+56+51+=
45+44+43+43+44+44+43+40+37+34+44+41+39+41+34+31+35+39+34+28+28+25+30+27+27+=
29+32+26+27+23+24+29+22+24+23+16+22+14+16+18+21+14+21+19+12+20+14+12+16+14+=
12+14+11+13+10+11+8+7+10+10+7+8+7+6+3+4+2+1+1+2+0+=08)=20
# bounces: 24, mode: poll, userfaults: 86 missing (13+13+7+5+7+2+2+3+4+2+3+=
5+5+0+2+2+0+0+1+2+2+0+0+0+1+0+1+0+0+0+0+1+0+2+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+=08) 3098 wp (101+96+86+94+81+72+82+74+75+69+77+67+64+67+64+56+62+64+55=
+62+55+50+52+56+55+48+49+47+47+41+38+38+43+41+38+33+38+38+40+35+37+36+31+25=
+29+27+31+26+26+27+23+21+23+23+19+16+17+17+20+14+15+15+17+19+18+16+13+11+13=
+13+10+12+9+9+10+8+6+8+9+7+6+4+3+2+4+1+1+1+=08)=20
# bounces: 23, mode: rnd racing ver read, userfaults: 84 missing (21+19+11+=
12+9+6+6+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+=08) 2430 wp (71+52+51+76+43+40+60+36+49+40+64+54+63+4=
1+52+42+55+32+49+45+46+45+34+44+47+41+42+43+48+43+39+32+30+38+33+27+28+37+1=
5+28+31+27+33+28+30+27+27+25+17+17+22+25+14+15+23+13+17+18+12+22+17+19+16+1=
9+15+13+12+16+16+14+4+6+6+9+3+10+7+3+5+7+5+5+2+2+1+0+0+0+=08)=20
# bounces: 22, mode: racing ver read, userfaults: 86 missing (13+9+6+8+5+3+=
5+6+1+3+5+4+1+5+4+1+3+2+1+0+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+=08) 3061 wp (109+91+103+86+83+79+85+92+76+75+73+67+69+73+62+=
66+61+65+58+53+61+59+52+55+46+41+38+41+43+41+36+42+36+44+31+35+25+19+34+26+=
27+34+26+30+28+21+28+25+27+20+25+19+19+29+18+17+21+16+25+23+20+18+14+19+13+=
13+16+11+12+15+13+9+8+9+8+8+8+6+2+5+6+4+5+3+2+2+2+1+=08)=20
# bounces: 21, mode: rnd ver read, userfaults: 81 missing (18+16+15+11+7+8+=
4+1+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+=08) 2494 wp (74+81+71+73+67+64+33+43+60+32+55+26+53+38+50+49=
+49+32+49+47+30+53+41+46+46+32+46+48+39+39+38+36+29+32+37+31+42+33+33+39+32=
+37+21+27+20+15+26+22+22+27+27+23+21+21+21+23+21+10+13+17+22+20+15+12+9+13+=
14+16+8+11+11+7+6+13+10+4+2+6+9+3+5+4+5+2+1+2+1+1+=08)=20
# bounces: 20, mode: ver read, userfaults: 87 missing (15+13+5+3+7+4+4+4+3+=
3+3+1+3+2+1+2+1+2+4+2+2+1+0+1+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+=08) 2963 wp (93+93+91+88+87+81+72+77+80+77+75+61+55+65+55+65+57+60=
+54+48+56+54+54+50+48+50+41+40+44+44+45+37+35+38+39+38+27+28+34+34+28+33+32=
+27+27+28+23+21+23+23+26+20+22+24+22+21+17+17+18+19+20+14+15+15+16+11+6+12+=
9+14+12+9+7+6+7+4+6+4+6+7+4+6+3+3+1+2+2+1+=08)=20
# bounces: 19, mode: rnd racing read, userfaults: 84 missing (21+17+14+12+9=
+8+2+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+=08) 2423 wp (71+59+80+74+64+47+42+47+56+40+43+35+51+43+58=
+41+45+43+40+47+44+46+48+34+40+27+50+35+40+23+25+38+28+32+32+35+16+32+27+31=
+23+29+28+29+36+27+17+27+19+26+17+20+24+29+21+18+23+19+17+15+25+15+16+3+16+=
10+14+15+17+13+11+15+10+10+5+5+8+5+4+8+7+3+6+3+3+1+1+1+=08)=20
# bounces: 18, mode: racing read, userfaults: 88 missing (7+15+7+7+5+8+2+4+=
4+2+1+7+2+2+3+4+1+3+1+1+0+0+1+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+=08) 3113 wp (85+99+92+84+77+77+78+86+77+70+69+71+67+73+71+63+68+=
60+61+61+61+52+56+53+46+40+45+51+42+41+44+43+41+40+39+35+39+31+32+29+37+23+=
30+30+29+27+24+36+29+29+28+26+27+19+21+23+20+21+24+16+11+10+17+15+13+18+14+=
9+10+15+13+11+9+8+12+9+6+8+6+8+6+4+4+3+1+3+1+1+=08)=20
# bounces: 17, mode: rnd read, userfaults: 81 missing (19+17+15+8+10+6+3+2+=
1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+=08) 2350 wp (77+66+48+69+62+64+61+59+53+51+47+48+20+58+40+29+39+=
43+41+37+39+36+33+49+40+37+45+44+34+30+28+40+32+27+33+26+33+32+29+31+30+34+=
34+21+22+17+26+17+22+26+16+18+22+17+18+20+17+17+22+18+11+14+15+14+13+8+14+1=
0+6+3+9+9+13+7+9+8+7+4+7+3+7+3+3+5+2+0+1+1+=08)=20
# bounces: 16, mode: read, userfaults: 87 missing (16+10+7+6+3+6+1+3+4+2+2+=
1+4+5+2+1+2+1+1+2+2+2+1+0+0+0+0+2+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+=08) 3134 wp (104+93+91+93+85+74+76+73+76+73+79+67+66+70+65+59+59+63+59=
+51+41+48+60+50+57+51+43+47+42+49+50+39+46+38+40+43+39+35+33+40+32+30+24+30=
+27+30+30+28+32+29+23+25+31+23+22+17+22+16+22+18+18+15+17+13+13+17+17+14+11=
+13+8+11+11+8+9+11+9+6+6+4+6+4+5+4+2+1+2+1+=08)=20
# bounces: 15, mode: rnd racing ver poll, userfaults: 81 missing (19+16+14+=
14+8+4+5+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+=08) 2323 wp (63+74+72+56+49+62+63+43+50+41+45+49+49+5=
1+44+49+40+49+41+45+43+40+38+40+42+37+42+34+34+37+35+34+31+37+30+31+20+29+2=
5+26+24+28+25+25+26+24+21+22+20+23+22+25+17+20+17+17+20+16+15+16+16+10+8+11=
+9+14+8+12+9+4+6+6+7+8+4+6+2+3+6+7+4+5+6+3+1+3+1+1+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 85 missing (9+6+13+10+8+0=
+5+5+7+1+1+2+1+2+0+1+3+2+1+1+2+1+1+0+0+0+1+0+0+0+0+1+0+0+0+1+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+=08) 3194 wp (94+100+89+96+90+83+81+79+82+73+70+69+69+65+64+=
60+64+63+59+58+63+57+52+50+47+50+51+47+46+48+46+43+44+39+39+40+37+34+34+27+=
32+34+27+27+34+29+31+25+31+27+28+25+22+24+24+23+22+24+22+16+21+21+18+16+17+=
16+13+11+11+9+11+10+11+11+9+8+7+10+3+6+7+4+3+5+3+1+2+1+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 85 missing (22+14+16+11+10+7=
+3+2+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+=08) 2503 wp (79+75+61+70+66+62+60+54+45+52+50+49+55+47+49+5=
0+49+46+43+44+45+39+48+38+36+39+35+39+38+31+33+36+37+32+34+28+28+33+27+29+2=
9+37+30+30+23+29+20+24+22+23+22+21+21+20+18+19+17+19+16+14+14+17+12+14+17+1=
5+14+9+10+8+11+10+8+10+9+4+8+6+6+7+6+5+3+4+3+4+3+1+=08)=20
# bounces: 12, mode: ver poll, userfaults: 83 missing (11+12+7+2+8+2+2+4+5+=
5+2+3+1+1+1+3+0+4+2+0+1+2+1+2+0+0+1+0+0+0+0+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+=08) 2963 wp (87+88+84+80+80+81+72+80+73+68+64+64+67+68+58+57+55+58=
+54+48+57+55+53+50+54+46+42+43+40+39+40+34+42+35+36+32+36+30+31+27+28+28+28=
+28+28+28+24+26+29+26+27+23+24+15+26+20+18+18+20+22+20+17+17+19+19+11+12+14=
+12+14+11+14+11+15+12+10+11+4+6+2+4+4+5+2+2+1+0+0+=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 82 missing (19+14+17+9+7+=
5+5+3+3+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+=08) 2529 wp (78+79+60+70+70+55+65+52+53+54+47+41+52+56+51+=
53+49+51+52+42+49+44+43+45+38+37+44+45+43+39+39+30+35+34+30+31+33+31+25+34+=
30+34+21+28+27+22+31+22+24+29+20+22+20+16+21+22+23+16+22+14+12+14+9+12+16+1=
0+9+11+11+7+5+6+9+9+7+7+4+6+4+2+3+1+2+4+4+1+0+1+=08)=20
# bounces: 10, mode: racing poll, userfaults: 81 missing (13+3+3+7+5+5+4+3+=
5+2+6+1+4+2+2+2+0+1+0+0+2+0+1+0+4+0+1+1+0+2+0+0+0+1+0+1+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+=08) 2978 wp (93+86+87+82+79+73+77+72+68+70+68+68+66+62+58+62+55+=
60+52+59+53+53+46+49+47+45+45+46+45+46+43+41+38+37+37+35+40+34+35+33+30+31+=
27+25+27+26+26+28+24+30+23+20+23+22+18+21+14+23+19+21+14+20+15+14+15+16+15+=
11+12+9+12+10+11+9+9+9+7+8+7+7+7+4+4+4+2+2+1+1+=08)=20
# bounces: 9, mode: rnd poll, userfaults: 86 missing (44+42+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+=08) 2177 wp (87+90+50+56+49+49+51+45+48+44+45+47+46+45+47+40+41+41+=
38+42+44+35+44+42+37+32+29+34+35+31+38+30+27+30+29+23+27+25+26+26+19+25+23+=
24+25+26+22+18+21+16+22+17+18+17+17+16+12+18+12+15+10+12+12+13+8+8+4+9+6+7+=
11+5+4+3+4+4+3+3+3+3+3+3+2+1+3+3+1+1+=08)=20
# bounces: 8, mode: poll, userfaults: 80 missing (14+13+8+3+4+4+1+3+4+2+0+1=
+4+0+2+1+2+2+1+1+0+4+1+0+2+0+0+0+1+0+0+1+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+=08) 2937 wp (95+92+87+75+79+70+69+71+72+70+65+63+59+53+61+59+53+52+53+5=
2+51+59+51+46+52+45+42+42+40+40+36+40+36+42+38+32+34+30+36+36+29+30+31+28+2=
7+29+25+28+24+26+27+29+29+23+20+21+21+26+22+17+19+16+14+18+11+15+10+16+13+1=
3+12+11+10+9+9+4+7+9+7+7+6+2+1+3+2+0+2+1+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 83 missing (22+16+15+9=
+9+7+4+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+=08) 2373 wp (76+74+61+65+67+20+44+30+46+52+48+38+47+17+=
62+59+47+52+46+52+53+39+41+42+45+37+39+46+39+43+36+28+29+29+27+15+35+30+34+=
41+27+33+27+21+26+24+27+23+27+28+23+13+19+20+18+15+21+22+20+8+6+17+10+15+15=
+10+8+8+11+10+10+13+5+6+3+11+10+7+10+3+1+1+1+5+1+3+0+0+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 77 missing (13+9+9+4+3+4+5=
+5+4+5+3+3+1+0+1+0+1+0+1+1+2+0+3+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+=08) 3020 wp (94+89+81+89+85+84+82+67+82+79+62+62+73+64+65+68+=
65+63+52+59+65+59+60+49+47+55+56+45+47+44+44+40+43+38+32+32+34+31+32+31+27+=
23+34+29+21+26+23+25+21+26+25+17+22+16+20+20+18+18+23+14+16+12+20+15+17+13+=
13+11+9+14+11+9+12+5+10+6+2+4+4+4+2+2+4+3+2+1+1+1+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 84 missing (22+16+14+15+9+5+3=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+=08) 2397 wp (84+73+67+27+70+47+44+25+50+61+58+54+54+47+54+15+=
53+32+44+47+53+34+44+37+52+41+44+29+40+47+39+35+36+35+29+38+37+30+36+25+21+=
21+29+26+31+26+27+18+26+25+16+25+17+16+14+22+15+24+16+21+16+9+6+13+12+14+12=
+14+14+9+12+12+5+3+7+1+0+6+5+5+3+5+3+3+1+2+1+1+=08)=20
# bounces: 4, mode: ver read, userfaults: 85 missing (13+11+10+8+9+5+8+3+2+=
2+1+2+1+1+1+1+1+2+3+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+=08) 2906 wp (91+95+85+83+79+82+87+80+72+63+63+64+64+65+51+57+56+55=
+62+54+46+46+46+39+45+42+41+41+37+39+43+34+38+39+35+32+30+31+39+37+29+33+27=
+31+27+29+26+30+26+28+21+20+23+23+18+20+13+21+8+14+18+14+14+16+14+16+16+17+=
15+13+7+9+10+9+10+8+8+5+6+7+5+2+4+2+2+3+1+0+=08)=20
# bounces: 3, mode: rnd racing read, userfaults: 84 missing (22+14+15+11+10=
+6+6+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+=08) 2434 wp (81+87+52+66+66+39+35+38+62+59+50+51+54+39+40=
+52+34+49+43+35+52+44+48+45+45+37+47+44+20+36+26+34+32+27+39+28+32+30+28+31=
+32+24+33+27+30+26+24+28+20+28+20+19+24+19+21+21+24+17+19+18+18+9+16+17+15+=
14+12+5+7+11+3+3+6+6+7+7+10+7+7+5+5+2+4+2+0+1+2+2+=08)=20
# bounces: 2, mode: racing read, userfaults: 73 missing (11+7+9+3+3+3+5+3+3=
+6+7+1+3+2+1+0+0+1+3+1+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+=08) 3129 wp (99+93+90+89+87+87+81+77+79+78+71+69+75+63+72+63+64+5=
6+58+57+58+66+54+52+52+50+45+47+38+32+36+36+37+39+38+37+39+32+31+32+34+30+2=
6+36+32+26+26+33+21+28+25+24+25+25+22+18+19+26+18+19+19+14+14+14+17+13+18+1=
5+15+15+12+9+9+8+8+7+8+8+8+6+5+4+5+3+1+1+0+1+=08)=20
# bounces: 1, mode: rnd read, userfaults: 83 missing (21+18+10+10+7+9+6+2+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+=08) 2555 wp (49+75+74+37+66+75+46+46+29+59+40+56+40+48+55+56+49+4=
2+57+57+42+54+50+49+47+44+48+44+28+44+33+40+39+41+33+36+29+39+31+29+24+29+3=
0+32+25+28+25+29+21+22+24+22+22+17+24+22+19+20+19+21+15+18+11+12+16+10+15+1=
0+16+9+12+12+9+8+4+8+6+7+8+5+2+3+1+2+3+1+0+1+=08)=20
# bounces: 0, mode: read, userfaults: 87 missing (15+8+9+7+5+4+6+2+3+5+6+4+=
0+2+0+2+2+0+0+1+3+0+2+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+=08) 3489 wp (111+106+101+99+91+98+82+84+97+84+92+95+88+77+73+74+75+75+77=
+79+73+75+63+75+64+53+62+55+48+48+46+55+43+42+41+32+41+27+34+30+34+21+26+21=
+22+34+29+23+24+25+22+18+24+20+23+20+18+20+17+13+21+18+19+16+16+14+10+10+13=
+14+14+8+9+12+10+10+7+8+8+6+3+5+6+5+2+3+2+1+=08)=20
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 88 missing (88+=08) 88 =
wp (88+=08)=20
# [PASS]
# ---------------------------------
# running ./userfaultfd shmem 20 16
# ---------------------------------
# nr_pages: 5104, nr_pages_per_cpu: 58
# bounces: 15, mode: rnd racing ver poll, userfaults: 2747 missing (152+129=
+140+118+106+103+99+88+85+90+76+71+68+62+69+56+63+65+58+50+50+48+55+53+40+4=
7+36+28+37+34+32+26+34+27+32+28+21+19+32+28+30+14+20+23+20+25+15+17+7+16+19=
+18+8+5+13+8+5+3+5+6+3+6+3+2+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+=08) 8945 wp (252+246+234+227+231+199+204+210+198+191+187+185+187+189+165=
+185+166+162+158+167+159+162+148+144+150+135+145+141+138+131+135+134+131+12=
5+125+125+130+126+110+104+105+112+106+102+101+96+97+90+90+80+75+75+72+73+69=
+72+67+67+60+58+59+48+52+48+44+37+32+34+29+28+21+19+21+23+17+19+16+13+12+12=
+13+8+8+7+7+4+5+1+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 105 missing (32+17+12+10+=
11+6+2+6+2+2+0+3+2+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+=08) 22490 wp (410+416+374+388+371+409+383+368+369+369+3=
61+352+355+362+340+331+332+339+323+324+309+329+299+319+294+291+322+286+287+=
283+280+275+277+258+266+266+270+277+249+261+275+248+249+253+236+261+248+238=
+255+264+232+213+240+231+231+234+239+226+194+200+198+190+188+202+176+184+19=
9+198+161+179+174+164+193+176+176+177+167+169+170+142+162+156+146+140+142+1=
35+153+132+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 2760 missing (138+123+131+10=
7+97+105+97+92+83+91+71+79+81+69+68+65+60+67+48+60+52+56+56+51+48+41+46+38+=
39+37+35+32+34+38+35+33+29+29+25+21+18+19+17+18+20+17+14+15+10+14+8+8+11+11=
+9+10+8+6+7+2+3+3+2+2+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=08) =
9027 wp (247+256+242+223+236+223+211+205+205+187+195+188+173+180+176+168+16=
9+167+174+162+152+157+151+152+144+150+143+144+142+138+142+132+127+121+128+1=
20+115+114+111+114+115+108+107+104+95+104+93+94+93+84+86+88+74+79+67+64+68+=
61+65+62+60+48+40+41+43+37+35+38+30+24+22+26+25+22+21+17+18+16+10+11+11+8+1=
0+5+6+4+3+1+=08)=20
# bounces: 12, mode: ver poll, userfaults: 262 missing (41+35+32+20+13+12+7=
+11+9+3+7+7+5+3+4+4+3+4+3+3+2+0+2+3+3+2+1+1+0+0+0+2+0+1+2+2+1+2+2+1+0+1+0+0=
+0+0+0+0+0+1+0+0+1+1+0+0+1+1+0+0+1+0+0+1+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+=08) 17180 wp (418+402+391+380+391+364+354+345+337+341+337+32=
6+312+318+299+302+295+291+279+289+283+279+274+257+257+252+258+246+245+243+2=
35+222+237+224+218+221+223+195+198+209+192+199+196+184+176+181+168+172+166+=
168+150+146+156+164+145+141+136+127+127+128+119+107+130+113+112+112+100+90+=
107+95+99+93+94+75+80+76+86+79+80+65+69+70+65+68+57+63+53+54+=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 2776 missing (141+136+123=
+107+109+99+100+83+98+75+76+85+72+73+70+66+62+63+57+63+46+52+48+45+42+40+57=
+43+39+42+48+32+29+33+28+28+26+27+23+24+23+18+19+18+15+19+11+15+16+13+17+11=
+8+7+10+8+9+8+7+1+2+2+4+0+3+0+2+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
=08) 9022 wp (255+244+230+243+222+221+207+210+194+211+194+193+192+178+181+1=
74+181+168+175+160+165+159+156+154+144+154+132+139+138+132+129+137+130+123+=
121+129+115+116+112+111+109+113+103+97+100+90+96+89+85+87+77+83+80+71+68+71=
+67+63+63+56+45+48+45+47+42+39+29+34+27+29+27+23+22+20+14+20+15+18+15+13+11=
+11+7+6+7+5+4+2+=08)=20
# bounces: 10, mode: racing poll, userfaults: 97 missing (25+15+12+8+7+8+10=
+0+4+3+4+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+=08) 21541 wp (398+385+391+366+382+345+376+351+354+344+329+332=
+340+347+329+320+339+330+326+305+293+297+282+312+301+296+292+267+264+267+27=
4+272+267+268+265+253+274+244+257+230+243+259+241+270+244+243+228+253+243+2=
31+218+204+201+218+193+219+205+202+215+174+195+205+184+170+192+171+156+156+=
162+160+162+187+156+167+150+162+157+129+178+171+146+159+164+151+147+161+141=
+134+=08)=20
# bounces: 9, mode: rnd poll, userfaults: 2811 missing (151+144+119+118+117=
+104+108+89+89+95+75+79+82+78+65+75+67+51+61+61+52+53+42+51+37+50+43+38+41+=
38+36+37+32+22+31+34+36+24+24+18+23+12+14+24+18+14+12+11+11+8+14+14+11+11+1=
0+7+3+5+6+3+5+3+0+3+2+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=08) 89=
97 wp (278+262+246+232+213+218+213+204+205+191+199+188+182+177+178+166+166+=
172+151+151+159+165+168+152+151+140+139+144+133+140+137+132+132+132+115+119=
+120+115+118+113+108+118+106+93+93+97+97+86+90+89+83+79+76+68+66+68+70+59+5=
7+58+45+46+42+43+42+39+30+23+26+24+25+26+23+22+21+20+17+19+13+14+12+14+12+6=
+7+5+1+3+=08)=20
# bounces: 8, mode: poll, userfaults: 276 missing (39+43+23+21+12+14+12+9+5=
+6+10+7+3+3+5+4+3+4+2+0+3+2+1+4+2+0+2+2+3+3+2+3+0+2+3+3+1+0+1+0+2+0+1+0+0+1=
+0+2+1+0+1+1+1+0+0+2+0+0+0+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+1+0+=08) 16651 wp (434+425+407+402+396+372+343+344+320+314+309+307+31=
3+308+281+290+288+278+287+272+262+254+245+249+233+247+237+235+231+215+219+2=
22+213+225+211+193+194+196+190+198+185+176+188+171+186+172+168+158+151+157+=
161+142+145+139+142+143+146+138+119+123+110+112+117+107+112+105+117+108+100=
+93+92+90+88+95+79+69+76+79+66+72+72+74+67+62+60+63+54+43+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 3120 missing (167+141+=
152+149+126+131+120+121+102+100+93+87+83+87+85+90+80+72+62+66+66+65+69+49+5=
2+55+44+35+49+53+37+44+28+33+37+26+28+24+21+27+17+14+17+15+13+15+19+8+5+10+=
11+4+3+4+3+0+5+0+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+=08) 9225 wp (286+289+279+254+265+252+236+214+215+228+208+219+205+208+211=
+188+187+173+185+174+167+172+162+174+166+169+158+160+147+134+156+136+147+12=
3+113+126+111+115+102+101+98+108+100+96+85+85+86+84+79+65+73+66+65+60+59+55=
+49+50+41+38+39+29+26+29+32+29+22+30+15+21+19+26+16+13+15+15+9+20+8+13+9+11=
+4+4+3+5+4+2+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 204 missing (49+40+27+23+1=
7+9+12+6+4+3+5+2+3+2+1+0+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+0+0+=08) 34782 wp (651+629+629+665+616+548+593+559+580+583+5=
90+537+579+543+522+542+528+541+537+529+515+521+513+476+516+484+465+480+457+=
461+449+469+444+438+431+444+430+402+375+412+413+379+372+400+372+408+364+384=
+397+352+353+361+356+355+362+330+308+300+290+339+299+291+271+283+269+278+30=
3+296+272+261+250+287+242+247+286+241+235+216+219+198+206+216+207+208+232+2=
01+186+204+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 3059 missing (149+160+142+152=
+124+122+110+110+112+99+91+99+94+75+79+76+64+67+62+59+57+73+54+51+56+46+50+=
37+40+42+42+41+36+45+29+35+36+23+25+18+21+23+14+16+14+13+14+9+8+7+8+2+6+5+5=
+4+3+3+1+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=08) 931=
7 wp (297+271+255+243+258+238+234+224+203+219+216+220+194+213+195+194+187+1=
86+190+183+175+161+169+162+153+171+147+151+147+138+141+139+121+124+128+124+=
120+123+114+113+110+107+99+98+101+89+95+93+86+78+72+69+76+64+62+62+47+59+49=
+35+46+37+29+35+29+26+34+22+30+21+20+24+18+21+16+13+15+14+11+6+13+12+7+5+5+=
6+6+4+=08)=20
# bounces: 4, mode: ver read, userfaults: 266 missing (34+32+27+19+13+12+8+=
9+12+8+7+5+4+7+3+7+4+6+2+2+4+4+0+2+0+2+4+0+1+1+1+1+1+2+2+1+0+0+1+1+2+2+1+0+=
0+2+0+0+0+0+0+1+0+1+0+0+1+0+0+0+2+1+1+1+0+0+0+0+1+0+0+0+0+0+0+0+1+0+0+0+0+0=
+0+0+0+0+0+0+=08) 21799 wp (556+536+507+518+489+482+458+470+452+448+430+400=
+414+394+404+385+404+377+378+380+362+351+331+337+356+338+335+318+309+309+29=
0+304+305+261+287+271+272+279+266+255+234+246+235+215+244+210+226+218+229+2=
07+213+203+198+182+182+172+179+169+162+172+149+153+141+157+146+136+121+132+=
92+110+102+106+97+104+89+81+79+97+84+90+80+80+67+52+52+42+21+25+=08)=20
# bounces: 3, mode: rnd racing read, userfaults: 3100 missing (171+158+141+=
139+116+105+130+116+110+118+86+89+78+98+85+70+89+80+73+65+70+72+58+48+57+48=
+49+42+44+36+34+35+30+37+38+22+26+23+22+18+17+20+24+21+13+9+11+11+8+7+6+7+7=
+3+4+2+2+0+1+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=08)=
 9191 wp (266+273+264+264+259+249+233+226+213+219+230+203+214+193+196+205+1=
75+185+171+182+174+171+167+171+158+170+147+154+145+154+142+137+137+121+119+=
135+114+118+116+109+104+102+98+98+102+92+94+83+76+65+56+68+63+64+51+47+54+3=
8+42+39+28+28+29+30+26+32+29+25+27+22+21+18+15+17+17+16+14+15+13+8+10+9+9+8=
+2+6+1+1+=08)=20
# bounces: 2, mode: racing read, userfaults: 151 missing (38+23+18+13+11+6+=
11+4+7+7+6+3+2+1+1+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=
0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0=
+0+0+0+0+0+0+0+=08) 37150 wp (682+623+647+657+629+616+639+606+605+616+616+5=
97+616+563+543+582+585+588+573+562+545+524+544+524+468+512+545+498+476+501+=
500+473+504+454+469+458+463+435+454+429+444+417+413+438+416+412+378+400+373=
+361+375+370+419+413+391+376+339+315+349+313+316+321+305+328+316+313+290+27=
6+310+285+289+283+320+281+268+278+260+239+242+266+247+207+200+234+209+210+2=
22+202+=08)=20
# bounces: 1, mode: rnd read, userfaults: 3088 missing (161+145+147+146+121=
+122+102+111+115+114+98+85+84+85+90+69+82+78+64+66+51+59+53+55+50+62+55+50+=
45+39+29+33+26+32+51+32+26+35+20+23+20+27+17+15+20+11+5+10+8+6+7+7+10+4+2+1=
+1+6+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+0+=08) 9218 =
wp (297+287+268+249+265+229+253+239+200+207+213+211+206+194+183+200+182+184=
+192+172+178+164+175+165+162+162+149+148+143+140+149+149+139+130+121+119+11=
8+121+106+113+106+94+93+92+85+94+91+81+80+69+69+62+57+63+58+53+51+47+47+36+=
33+37+34+34+32+28+31+24+23+26+19+16+19+20+20+19+12+12+11+13+8+10+7+5+4+5+4+=
2+=08)=20
# bounces: 0, mode: read, userfaults: 271 missing (25+23+19+20+7+9+12+5+5+3=
+7+6+4+2+3+8+2+3+4+6+5+2+3+5+3+3+1+4+2+4+1+4+3+3+3+2+1+1+4+3+3+3+4+0+1+3+4+=
2+1+2+1+1+1+0+1+2+0+0+1+0+1+2+2+0+1+0+0+1+0+1+0+0+1+0+0+0+0+0+1+1+0+0+0+0+0=
+0+0+0+=08) 21823 wp (585+558+584+564+523+483+481+467+490+454+441+449+446+4=
01+401+397+385+385+368+379+353+352+373+367+346+325+337+316+305+324+322+302+=
297+279+306+266+278+249+253+266+223+258+247+239+218+231+223+213+201+183+199=
+187+201+179+170+173+182+157+172+160+137+141+140+124+114+117+116+112+115+96=
+105+95+98+84+83+79+93+58+59+65+81+68+50+31+29+26+15+19+=08)=20
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 5104 missing (5104+=08)=
 5104 wp (5104+=08)=20
# testing minor faults: userfaults: 5104 minor (5104+=08)
# [PASS]
# -------------------------
# running ./compaction_test
# -------------------------
# No of huge pages allocated =3D 30086
#
not ok 4 selftests: vm: run_vmtests.sh # TIMEOUT 45 seconds
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-2bd8eec68f740608db5ea58ecff06965228764cb/tools/testing/selftests/vm'

--2mbpD809lbQkAB7H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/kernel-selftests-vm.yaml:
suite: kernel-selftests
testcase: kernel-selftests
category: functional
sysctl:
  sc_nr_hugepages: 2
kernel-selftests:
  group: vm
job_origin: kernel-selftests-vm.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-csl-2sp9
tbox_group: lkp-csl-2sp9
submit_id: 62bddfa47b1f29524f41bc5c
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp9/kernel-selftests-vm-2-ucode=0x500320a-debian-11.1-x86_64-20220510.cgz-2bd8eec68f740608db5ea58ecff06965228764cb-20220701-86607-1qoq1pa-0.yaml"
id: b8f4bdbaa4bc7d5492955e2dfd0ccc12fff85a4a
queuer_version: "/zday/lkp"
kconfig: x86_64-rhel-8.3-kselftests
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
:#! include/queue/cyclic:
commit: 2bd8eec68f740608db5ea58ecff06965228764cb
:#! include/testbox/lkp-csl-2sp9:
ucode: '0x500320a'
need_kconfig_hw:
- I40E: y
- SATA_AHCI
:#! include/kernel-selftests:
need_kconfig:
- GUP_BENCHMARK: y, v4.15-rc1, <= v5.10
- GUP_TEST: y, v5.11-rc1
initrds:
- linux_headers
- linux_selftests
enqueue_time: 2022-07-01 01:38:44.733045850 +08:00
_id: 62bddfa47b1f29524f41bc5c
_rt: "/result/kernel-selftests/vm-2-ucode=0x500320a/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb"
:#! schedule options:
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 1a6275a1cb4dbe083f467378dcf99f9410fadc42
base_commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
branch: linux-devel/devel-hourly-20220628-154003
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/kernel-selftests/vm-2-ucode=0x500320a/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/0"
scheduler_version: "/lkp/lkp/.src-20220630-123532"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/vm-2-ucode=0x500320a/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/vmlinuz-5.19.0-rc2-00007-g2bd8eec68f74
- branch=linux-devel/devel-hourly-20220628-154003
- job=/lkp/jobs/scheduled/lkp-csl-2sp9/kernel-selftests-vm-2-ucode=0x500320a-debian-11.1-x86_64-20220510.cgz-2bd8eec68f740608db5ea58ecff06965228764cb-20220701-86607-1qoq1pa-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=2bd8eec68f740608db5ea58ecff06965228764cb
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/kernel-selftests_20220628.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/kernel-selftests-x86_64-a10a197d-1_20220626.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220216.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /cephfs/db/releases/20220628123551/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.19.0-rc2-00001-gfccaa7773346
schedule_notify_address:
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/2bd8eec68f740608db5ea58ecff06965228764cb/vmlinuz-5.19.0-rc2-00007-g2bd8eec68f74"
dequeue_time: 2022-07-01 03:03:01.989743048 +08:00
:#! /cephfs/db/releases/20220630204322/lkp-src/include/site/inn:
job_state: finished
loadavg: 25.15 11.09 4.19 2/836 27423
start_time: '1656615919'
end_time: '1656616047'
version: "/lkp/lkp/.src-20220630-123614:2bc66ad67:99f8469fd"

--2mbpD809lbQkAB7H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

echo '2' > '/proc/sys/vm/nr_hugepages'
ln -sf /usr/bin/clang
ln -sf /usr/bin/llc
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -C vm
make run_tests -C vm

--2mbpD809lbQkAB7H--
