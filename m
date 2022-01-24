Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234E149776C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiAXCeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:34:22 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:45193 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235700AbiAXCeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:34:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V2cE.SH_1642991657;
Received: from 30.225.24.74(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V2cE.SH_1642991657)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Jan 2022 10:34:18 +0800
Message-ID: <0d43ae1c-80b6-be52-0d0f-849aad5392e9@linux.alibaba.com>
Date:   Mon, 24 Jan 2022 10:34:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [fs/ocfs2] 32e1a3dbeb: kernel_BUG_at_fs/ocfs2/uptodate.c
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>, cgel.zte@gmail.com
Cc:     0day robot <lkp@intel.com>, Zeal Robot <zealci@zte.com.cn>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        mark@fasheh.com, jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        Minghao Chi <chi.minghao@zte.com.cn>
References: <20220123141359.GH19412@xsang-OptiPlex-9020>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220123141359.GH19412@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is NAKed as I've decribed in the original reply.
And I've sent substituted patch which can be found at:
https://lore.kernel.org/ocfs2-devel/9e3793fa-76a9-8190-a090-5655c49a7352@linux.alibaba.com/T/#t

Thanks,
Joseph

On 1/23/22 10:13 PM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 32e1a3dbeb6b569a29d843426cb163b5fd27a348 ("[PATCH] fs/ocfs2: remove redundant ret variable")
> url: https://github.com/0day-ci/linux/commits/cgel-zte-gmail-com/fs-ocfs2-remove-redundant-ret-variable/20220112-161525
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git daadb3bd0e8d3e317e36bc2c1542e86c528665e5
> patch link: https://lore.kernel.org/lkml/20220112081408.667411-1-chi.minghao@zte.com.cn
> 
> in testcase: ocfs2test
> version: ocfs2test-x86_64-d802bf7-1_20210827
> with following parameters:
> 
> 	disk: 1HDD
> 	test: test-aiostress
> 	ucode: 0x28
> 
> 
> 
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   56.620204][  T970] kernel BUG at fs/ocfs2/uptodate.c:65!
> [   56.625708][  T970] invalid opcode: 0000 [#1] SMP KASAN PTI
> [   56.631301][  T970] CPU: 2 PID: 970 Comm: aio-stress Not tainted 5.16.0-06519-g32e1a3dbeb6b #1
> [   56.639940][  T970] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
> [ 56.649465][ T970] RIP: 0010:ocfs2_metadata_cache_get_super (fs/ocfs2/uptodate.c:65 fs/ocfs2/uptodate.c:63) ocfs2
> [ 56.656764][ T970] Code: 29 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 80 3c 02 00 75 17 48 8b 43 08 48 89 ef 5b 5d e9 08 01 ae c1 <0f> 0b e8 21 e1 b8 bf eb c5 e8 1a e1 b8 bf eb e2 66 66 2e 0f 1f 84
> All code
> ========
>    0:	29 48 b8             	sub    %ecx,-0x48(%rax)
>    3:	00 00                	add    %al,(%rax)
>    5:	00 00                	add    %al,(%rax)
>    7:	00 fc                	add    %bh,%ah
>    9:	ff                   	(bad)  
>    a:	df 48 8d             	fisttps -0x73(%rax)
>    d:	7b 08                	jnp    0x17
>    f:	48 89 fa             	mov    %rdi,%rdx
>   12:	48 c1 ea 03          	shr    $0x3,%rdx
>   16:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>   1a:	75 17                	jne    0x33
>   1c:	48 8b 43 08          	mov    0x8(%rbx),%rax
>   20:	48 89 ef             	mov    %rbp,%rdi
>   23:	5b                   	pop    %rbx
>   24:	5d                   	pop    %rbp
>   25:	e9 08 01 ae c1       	jmpq   0xffffffffc1ae0132
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	e8 21 e1 b8 bf       	callq  0xffffffffbfb8e152
>   31:	eb c5                	jmp    0xfffffffffffffff8
>   33:	e8 1a e1 b8 bf       	callq  0xffffffffbfb8e152
>   38:	eb e2                	jmp    0x1c
>   3a:	66                   	data16
>   3b:	66                   	data16
>   3c:	2e                   	cs
>   3d:	0f                   	.byte 0xf
>   3e:	1f                   	(bad)  
>   3f:	84                   	.byte 0x84
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	e8 21 e1 b8 bf       	callq  0xffffffffbfb8e128
>    7:	eb c5                	jmp    0xffffffffffffffce
>    9:	e8 1a e1 b8 bf       	callq  0xffffffffbfb8e128
>    e:	eb e2                	jmp    0xfffffffffffffff2
>   10:	66                   	data16
>   11:	66                   	data16
>   12:	2e                   	cs
>   13:	0f                   	.byte 0xf
>   14:	1f                   	(bad)  
>   15:	84                   	.byte 0x84
> [   56.676290][  T970] RSP: 0018:ffffc90001b3ecd0 EFLAGS: 00010246
> [   56.682346][  T970] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
> [   56.690196][  T970] RDX: 1ffff110833fee09 RSI: ffffc90001b3ee20 RDI: ffff888419ff704c
> [   56.698067][  T970] RBP: ffff888419ff704c R08: 0000000000000001 R09: ffff888183cc8800
> [   56.705937][  T970] R10: dffffc0000000000 R11: 0000000000000000 R12: ffffc90001b3ee20
> [   56.713797][  T970] R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90001b3ee38
> [   56.721631][  T970] FS:  00007f70925db700(0000) GS:ffff8883a7300000(0000) knlGS:0000000000000000
> [   56.730464][  T970] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   56.736935][  T970] CR2: 00007f70915c8000 CR3: 0000000418668005 CR4: 00000000001706e0
> [   56.744806][  T970] Call Trace:
> [   56.747978][  T970]  <TASK>
> [ 56.750803][ T970] ocfs2_add_clusters_in_btree (fs/ocfs2/alloc.c:4785) ocfs2
> [ 56.757167][ T970] ? kasan_save_stack (mm/kasan/common.c:38) 
> [ 56.761895][ T970] ? __kasan_slab_alloc (mm/kasan/common.c:46 mm/kasan/common.c:437 mm/kasan/common.c:470) 
> [ 56.766984][ T970] ? kmem_cache_alloc (mm/slab.h:739 mm/slub.c:3230 mm/slub.c:3238 mm/slub.c:3243) 
> [ 56.771898][ T970] ? jbd2__journal_start (include/linux/slab.h:706 include/linux/jbd2.h:1603 fs/jbd2/transaction.c:481 fs/jbd2/transaction.c:508 fs/jbd2/transaction.c:490) 
> [ 56.777072][ T970] ? ocfs2_insert_extent (fs/ocfs2/alloc.c:4777) ocfs2
> [ 56.782983][ T970] ? ocfs2_direct_IO (fs/ocfs2/aops.c:2450) ocfs2
> [ 56.788537][ T970] ? generic_file_direct_write (mm/filemap.c:3678) 
> [ 56.794239][ T970] ? __generic_file_write_iter (mm/filemap.c:3838) 
> [ 56.799934][ T970] ? ocfs2_file_write_iter (fs/ocfs2/file.c:2447) ocfs2
> [ 56.806018][ T970] ? __jbd2_journal_unfile_buffer (fs/jbd2/transaction.c:235) 
> [ 56.811791][ T970] ? __x64_sys_io_submit (fs/aio.c:2056 fs/aio.c:2026 fs/aio.c:2026) 
> [ 56.816982][ T970] ? do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [ 56.821445][ T970] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113) 
> [ 56.827416][ T970] ocfs2_add_inode_data (fs/ocfs2/file.c:545) ocfs2
> [ 56.833051][ T970] ? ocfs2_truncate_file (fs/ocfs2/file.c:542) ocfs2
> [ 56.839109][ T970] ? start_this_handle (arch/x86/include/asm/atomic.h:165 arch/x86/include/asm/atomic.h:178 include/linux/atomic/atomic-instrumented.h:147 include/asm-generic/qrwlock.h:109 include/linux/rwlock_api_smp.h:224 fs/jbd2/transaction.c:465) 
> [ 56.844195][ T970] ocfs2_write_cluster+0xb16/0x13c0 ocfs2
> [ 56.850617][ T970] ? kasan_unpoison (mm/kasan/shadow.c:108 mm/kasan/shadow.c:142) 
> [ 56.855150][ T970] ? ocfs2_map_page_blocks (fs/ocfs2/aops.c:1115) ocfs2
> [ 56.861243][ T970] ? mutex_unlock (arch/x86/include/asm/atomic64_64.h:190 include/linux/atomic/atomic-long.h:449 include/linux/atomic/atomic-instrumented.h:1790 kernel/locking/mutex.c:178 kernel/locking/mutex.c:537) 
> [ 56.865722][ T970] ? jbd2_journal_get_write_access (fs/jbd2/transaction.c:1226) 
> [ 56.871678][ T970] ? __ocfs2_journal_access (fs/ocfs2/journal.c:703) ocfs2
> [ 56.877849][ T970] ? ocfs2_complete_recovery (fs/ocfs2/journal.c:638) ocfs2
> [ 56.884105][ T970] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:82 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
> [ 56.888723][ T970] ocfs2_write_begin_nolock (fs/ocfs2/aops.c:1249 fs/ocfs2/aops.c:1819) ocfs2
> [ 56.895063][ T970] ? ocfs2_size_fits_inline_data (fs/ocfs2/aops.c:1651) ocfs2
> [ 56.901458][ T970] ? ocfs2_read_inode_block_full (fs/ocfs2/inode.c:1597) ocfs2
> [ 56.907975][ T970] ? ocfs2_refresh_inode (fs/ocfs2/inode.c:1589) ocfs2
> [ 56.913877][ T970] ? __raw_callee_save___native_queued_spin_unlock (??:?) 
> [ 56.921140][ T970] ? ocfs2_inode_lock_full_nested (fs/ocfs2/dlmglue.c:2412 fs/ocfs2/dlmglue.c:2507) ocfs2
> [ 56.927847][ T970] ? ocfs2_allocate_extend_trans (fs/ocfs2/journal.c:712) ocfs2
> [ 56.934787][ T970] ? down_write_killable (kernel/locking/rwsem.c:1512) 
> [ 56.939927][ T970] ocfs2_dio_wr_get_block (fs/ocfs2/aops.c:2229) ocfs2
> [ 56.946011][ T970] ? iov_iter_get_pages (lib/iov_iter.c:1543) 
> [ 56.951063][ T970] ? ocfs2_write_end_nolock (fs/ocfs2/aops.c:2130) ocfs2
> [ 56.957409][ T970] ? iov_iter_get_pages_alloc (lib/iov_iter.c:1521) 
> [ 56.963162][ T970] ? __kasan_init_slab_obj (mm/kasan/common.c:327) 
> [ 56.968329][ T970] ? allocate_slab (mm/slub.c:376 mm/slub.c:1904 mm/slub.c:1970) 
> [ 56.972967][ T970] do_direct_IO (fs/direct-io.c:673 fs/direct-io.c:955) 
> [ 56.977446][ T970] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
> [ 56.982584][ T970] ? kasan_unpoison (mm/kasan/shadow.c:108 mm/kasan/shadow.c:142) 
> [ 56.987139][ T970] ? do_blockdev_direct_IO (fs/direct-io.c:1152) 
> [ 56.992542][ T970] do_blockdev_direct_IO (fs/direct-io.c:1270) 
> [ 56.997794][ T970] ? ocfs2_dio_end_io_write (fs/ocfs2/aops.c:2400) ocfs2
> [ 57.003931][ T970] ? do_direct_IO (fs/direct-io.c:1129) 
> [ 57.008655][ T970] ? native_queued_spin_lock_slowpath (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 arch/x86/include/asm/qspinlock.h:25 kernel/locking/qspinlock.c:352) 
> [ 57.014963][ T970] ? ocfs2_read_blocks_sync (fs/ocfs2/buffer_head_io.c:197) ocfs2
> [ 57.021110][ T970] ? .slowpath (kernel/locking/qspinlock.c:316) 
> [ 57.025060][ T970] ? truncate_pagecache_range (mm/truncate.c:625) 
> [ 57.030493][ T970] ? _raw_spin_lock (arch/x86/include/asm/paravirt.h:591 arch/x86/include/asm/qspinlock.h:51 include/asm-generic/qspinlock.h:85 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
> [ 57.035115][ T970] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
> [ 57.040278][ T970] ? ocfs2_write_end_nolock (fs/ocfs2/aops.c:2130) ocfs2
> [ 57.046615][ T970] ? filemap_fdatawait_keep_errors (mm/filemap.c:714) 
> [ 57.052455][ T970] ? __mark_inode_dirty (include/linux/spinlock.h:202 include/linux/spinlock_api_smp.h:142 include/linux/spinlock.h:389 fs/fs-writeback.c:2480) 
> [ 57.057533][ T970] ? generic_update_time (fs/inode.c:1784) 
> [ 57.062673][ T970] ocfs2_direct_IO (fs/ocfs2/aops.c:2450) ocfs2
> [ 57.068057][ T970] generic_file_direct_write (mm/filemap.c:3678) 
> [ 57.073584][ T970] __generic_file_write_iter (mm/filemap.c:3838) 
> [ 57.079089][ T970] ocfs2_file_write_iter (fs/ocfs2/file.c:2447) ocfs2
> [ 57.085018][ T970] ? ocfs2_prepare_inode_for_write+0x880/0x880 ocfs2
> [ 57.092410][ T970] ? stack_trace_save (kernel/stacktrace.c:123) 
> [ 57.097141][ T970] aio_write (fs/aio.c:1497 fs/aio.c:1578) 
> [ 57.101265][ T970] ? aio_prep_rw (fs/aio.c:1545) 
> [ 57.105713][ T970] ? kasan_save_stack (mm/kasan/common.c:41) 
> [ 57.110444][ T970] ? kasan_save_stack (mm/kasan/common.c:38) 
> [ 57.115159][ T970] ? __kasan_slab_alloc (mm/kasan/common.c:46 mm/kasan/common.c:437 mm/kasan/common.c:470) 
> [ 57.120054][ T970] ? io_submit_one (fs/aio.c:1029 fs/aio.c:1993) 
> [ 57.124673][ T970] ? __x64_sys_io_submit (fs/aio.c:2056 fs/aio.c:2026 fs/aio.c:2026) 
> [ 57.129848][ T970] ? do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [ 57.134330][ T970] ? tcp_mtu_probe (include/linux/skbuff.h:1464 net/ipv4/tcp_output.c:2393) 
> [ 57.139148][ T970] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:82 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
> [ 57.144496][ T970] ? get_random_u32 (drivers/char/random.c:2219) 
> [ 57.149150][ T970] ? __kasan_init_slab_obj (mm/kasan/common.c:327) 
> [ 57.154324][ T970] ? setup_object+0x17/0xc0 
> [ 57.159307][ T970] ? __io_submit_one+0xa7d/0x1040 
> [ 57.165233][ T970] __io_submit_one+0xa7d/0x1040 
> [ 57.170982][ T970] ? aio_poll_complete_work (fs/aio.c:1913) 
> [ 57.176587][ T970] ? kasan_unpoison (mm/kasan/shadow.c:108 mm/kasan/shadow.c:142) 
> [ 57.181138][ T970] ? __kasan_slab_alloc (mm/kasan/common.c:46 mm/kasan/common.c:437 mm/kasan/common.c:470) 
> [ 57.186018][ T970] ? __get_reqs_available (arch/x86/include/asm/atomic.h:196 include/linux/atomic/atomic-instrumented.h:504 fs/aio.c:934) 
> [ 57.191270][ T970] io_submit_one (include/linux/instrumented.h:101 include/linux/atomic/atomic-instrumented.h:176 include/linux/refcount.h:272 include/linux/refcount.h:315 include/linux/refcount.h:333 fs/aio.c:1162 fs/aio.c:2000) 
> [ 57.195803][ T970] ? exc_page_fault (arch/x86/include/asm/irqflags.h:40 arch/x86/include/asm/irqflags.h:75 arch/x86/mm/fault.c:1493 arch/x86/mm/fault.c:1541) 
> [ 57.200361][ T970] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:568) 
> [ 57.205241][ T970] ? __io_submit_one+0x1040/0x1040 
> [ 57.211282][ T970] ? __get_user_4 (arch/x86/lib/getuser.S:85) 
> [ 57.215676][ T970] __x64_sys_io_submit (fs/aio.c:2056 fs/aio.c:2026 fs/aio.c:2026) 
> [ 57.220676][ T970] ? __ia32_compat_sys_io_submit (fs/aio.c:2026) 
> [ 57.226533][ T970] ? switch_fpu_return (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 arch/x86/kernel/fpu/context.h:80 arch/x86/kernel/fpu/core.c:664) 
> [ 57.231414][ T970] ? exit_to_user_mode_prepare (arch/x86/include/asm/entry-common.h:58 kernel/entry/common.c:209) 
> [ 57.237108][ T970] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 
