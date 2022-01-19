Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E7B4934D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351700AbiASGIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:08:43 -0500
Received: from out0.migadu.com ([94.23.1.103]:12602 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234904AbiASGIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:08:42 -0500
Subject: Re: [md] 0c031fd37f: kernel_BUG_at_drivers/md/raid#.c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1642572517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6T8GZmJWuNBKoM+YkKXRWQeOivaO7dkyAHkwgLZefKM=;
        b=dlQdfoDJaxDye7v5jmqBKvvDu6HuxlVRKxeauoEqDwtGNXGI2aHOED0x4vzAVOjQu0GUxs
        XcltCYC2NM6Rs9OxYtM6/BsgAdmihkZNf9XMp9R3L3rqWtoXB1nWRa6hd5TbmYTV0PlXPc
        233K+t/veaQcuhBDkSmtb3MMrNc/BBo=
To:     kernel test robot <oliver.sang@intel.com>, Xiao Ni <xni@redhat.com>
Cc:     Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com
References: <20220119055501.GD27703@xsang-OptiPlex-9020>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <239e47c0-ec0a-87a6-657e-3095408e3208@linux.dev>
Date:   Wed, 19 Jan 2022 14:08:31 +0800
MIME-Version: 1.0
In-Reply-To: <20220119055501.GD27703@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/22 1:55 PM, kernel test robot wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 0c031fd37f69deb0cd8c43bbfcfccd62ebd7e952 ("md: Move alloc/free acct bioset in to personality")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

AFAIK, that commit doesn't change raid10 code.

> in testcase: mdadm-selftests
> version: mdadm-selftests-x86_64-5f41845-1_20220116
> with following parameters:
>
> 	disk: 1HDD
> 	test_prefix: 18
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
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [  116.534267][ T1574] kernel BUG at drivers/md/raid10.c:928!

It points to "BUG_ON(force && !conf->barrier)", which I suspect it is 
caused by

commit c9aa889b035fca4598ae985a0f0c76ebbb547ad2
Author: Vishal Verma <vverma@digitalocean.com>
Date:   Tue Dec 21 20:06:21 2021 +0000

     md: raid10 add nowait support

     This adds nowait support to the RAID10 driver. Very similar to
     raid1 driver changes. It makes RAID10 driver return with EAGAIN
     for situations where it could wait for eg:

       - Waiting for the barrier,
       - Reshape operation,
       - Discard operation.

     wait_barrier() and regular_request_wait() fn are modified to return 
bool
     to support error for wait barriers. They returns true in case of wait
     or if wait is not required and returns false if wait was required
     but not performed to support nowait.

     Reviewed-by: Jens Axboe <axboe@kernel.dk>
     Signed-off-by: Vishal Verma <vverma@digitalocean.com>
     Signed-off-by: Song Liu <song@kernel.org>

> [  116.539866][ T1574] invalid opcode: 0000 [#1] SMP KASAN PTI
> [  116.545453][ T1574] CPU: 2 PID: 1574 Comm: md126_resync Not tainted 5.16.0-rc3-00104-g0c031fd37f69 #1
> [  116.554700][ T1574] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
> [ 116.564232][ T1574] RIP: 0010:raise_barrier (drivers/md/raid10.c:928 (discriminator 3)) raid10
> [ 116.570273][ T1574] Code: 07 83 c0 03 38 d0 7c 04 84 d2 75 63 8b 8b ec 00 00 00 85 c9 74 14 48 8d ab dc 00 00 00 48 89 ef e8 0d 8d f1 c2 e9 1e fd ff ff <0f> 0b 4c 89 e7 e8 be 2e 1e c1 e9 61 fe ff ff 48 8b 7c 24 08 e8 af
> All code
> ========
>     0:	07                   	(bad)
>     1:	83 c0 03             	add    $0x3,%eax
>     4:	38 d0                	cmp    %dl,%al
>     6:	7c 04                	jl     0xc
>     8:	84 d2                	test   %dl,%dl
>     a:	75 63                	jne    0x6f
>     c:	8b 8b ec 00 00 00    	mov    0xec(%rbx),%ecx
>    12:	85 c9                	test   %ecx,%ecx
>    14:	74 14                	je     0x2a
>    16:	48 8d ab dc 00 00 00 	lea    0xdc(%rbx),%rbp
>    1d:	48 89 ef             	mov    %rbp,%rdi
>    20:	e8 0d 8d f1 c2       	callq  0xffffffffc2f18d32
>    25:	e9 1e fd ff ff       	jmpq   0xfffffffffffffd48
>    2a:*	0f 0b                	ud2    		<-- trapping instruction
>    2c:	4c 89 e7             	mov    %r12,%rdi
>    2f:	e8 be 2e 1e c1       	callq  0xffffffffc11e2ef2
>    34:	e9 61 fe ff ff       	jmpq   0xfffffffffffffe9a
>    39:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
>    3e:	e8                   	.byte 0xe8
>    3f:	af                   	scas   %es:(%rdi),%eax
>
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	4c 89 e7             	mov    %r12,%rdi
>     5:	e8 be 2e 1e c1       	callq  0xffffffffc11e2ec8
>     a:	e9 61 fe ff ff       	jmpq   0xfffffffffffffe70
>     f:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
>    14:	e8                   	.byte 0xe8
>    15:	af                   	scas   %es:(%rdi),%eax
> [  116.589800][ T1574] RSP: 0018:ffffc900037e7808 EFLAGS: 00010246
> [  116.595830][ T1574] RAX: 0000000000000007 RBX: ffff88840ba6b800 RCX: 0000000000000000
> [  116.603708][ T1574] RDX: 0000000000000000 RSI: ffff88840ba6b8ec RDI: ffff88840ba6b800
> [  116.611577][ T1574] RBP: ffff8884180f0000 R08: 0000000000000001 R09: ffffed10360e2304
> [  116.619439][ T1574] R10: ffff8881b071181f R11: ffffed10360e2303 R12: dffffc0000000000
> [  116.627316][ T1574] R13: 0000000000000001 R14: 0000000000000003 R15: dffffc0000000000
> [  116.635186][ T1574] FS:  0000000000000000(0000) GS:ffff8883a9500000(0000) knlGS:0000000000000000
> [  116.644009][ T1574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  116.650491][ T1574] CR2: 000055d240e17038 CR3: 000000041de14004 CR4: 00000000001706e0
> [  116.658360][ T1574] Call Trace:
> [  116.661531][ T1574]  <TASK>
> [ 116.664339][ T1574] ? mempool_init_node (mm/mempool.c:190)
> [ 116.669315][ T1574] ? raid10_end_read_request (drivers/md/raid10.c:927) raid10
> [ 116.675624][ T1574] ? memset (mm/kasan/shadow.c:44)
> [ 116.679610][ T1574] ? bio_reset (arch/x86/include/asm/atomic.h:41 include/linux/atomic/atomic-instrumented.h:42 block/bio.c:307)
> [ 116.683746][ T1574] ? raid10_alloc_init_r10buf (drivers/md/raid10.c:3164) raid10
> [ 116.690141][ T1574] raid10_sync_request (include/linux/instrumented.h:86 include/linux/atomic/atomic-instrumented.h:41 drivers/md/raid10.c:3453) raid10
> [ 116.696097][ T1574] ? raid10_run (drivers/md/raid10.c:3246) raid10
> [ 116.701443][ T1574] ? queue_work_on (kernel/workqueue.c:1548)
> [ 116.705914][ T1574] md_do_sync.cold (drivers/md/md.c:8943)
> [ 116.710619][ T1574] ? ret_from_fork (arch/x86/entry/entry_64.S:301)
> [ 116.715101][ T1574] ? md_seq_show (drivers/md/md.c:8691)
> [ 116.719745][ T1574] ? newidle_balance (kernel/sched/fair.c:10129 kernel/sched/fair.c:10140 kernel/sched/fair.c:10902)
> [ 116.724575][ T1574] ? dequeue_entity (kernel/sched/fair.c:4379)
> [ 116.729313][ T1574] ? __x64_sys_rt_sigpending (kernel/signal.c:4055)
> [ 116.734835][ T1574] ? __switch_to (arch/x86/include/asm/bitops.h:55 include/asm-generic/bitops/instrumented-atomic.h:29 include/linux/thread_info.h:89 arch/x86/include/asm/fpu/sched.h:65 arch/x86/kernel/process_64.c:622)
> [ 116.739314][ T1574] ? __switch_to_asm (arch/x86/entry/entry_64.S:254)
> [ 116.743969][ T1574] md_thread (drivers/md/md.c:7900)
> [ 116.748096][ T1574] ? bb_store (drivers/md/md.c:7884)
> [ 116.752141][ T1574] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161)
> [ 116.757835][ T1574] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161)
> [ 116.763538][ T1574] ? __kthread_parkme (arch/x86/include/asm/bitops.h:207 (discriminator 4) include/asm-generic/bitops/instrumented-non-atomic.h:135 (discriminator 4) kernel/kthread.c:249 (discriminator 4))
> [ 116.768358][ T1574] ? schedule (arch/x86/include/asm/bitops.h:207 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:135 (discriminator 1) include/linux/thread_info.h:118 (discriminator 1) include/linux/sched.h:2120 (discriminator 1) kernel/sched/core.c:6328 (discriminator 1))
> [ 116.772482][ T1574] ? bb_store (drivers/md/md.c:7884)
> [ 116.776514][ T1574] kthread (kernel/kthread.c:327)
> [ 116.780446][ T1574] ? set_kthread_struct (kernel/kthread.c:272)
> [ 116.785535][ T1574] ret_from_fork (arch/x86/entry/entry_64.S:301)
> [  116.789833][ T1574]  </TASK>
> [  116.792745][ T1574] Modules linked in: multipath loop raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid10 raid1 raid0 netconsole btrfs ipmi_devintf ipmi_msghandler blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr intel_rapl_common sd_mod t10_pi sg x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel i915 intel_gtt rapl ttm intel_cstate drm_kms_helper ahci syscopyarea sysfillrect libahci sysimgblt fb_sys_fops mei_me intel_uncore drm libata mxm_wmi mei video wmi acpi_pad ip_tables
> [  116.845910][ T1574] ---[ end trace ae936c3b92a0bada ]---
> [ 116.851474][ T1574] RIP: 0010:raise_barrier (drivers/md/raid10.c:928 (discriminator 3)) raid10
> [ 116.857548][ T1574] Code: 07 83 c0 03 38 d0 7c 04 84 d2 75 63 8b 8b ec 00 00 00 85 c9 74 14 48 8d ab dc 00 00 00 48 89 ef e8 0d 8d f1 c2 e9 1e fd ff ff <0f> 0b 4c 89 e7 e8 be 2e 1e c1 e9 61 fe ff ff 48 8b 7c 24 08 e8 af
> All code
> ========
>     0:	07                   	(bad)
>     1:	83 c0 03             	add    $0x3,%eax
>     4:	38 d0                	cmp    %dl,%al
>     6:	7c 04                	jl     0xc
>     8:	84 d2                	test   %dl,%dl
>     a:	75 63                	jne    0x6f
>     c:	8b 8b ec 00 00 00    	mov    0xec(%rbx),%ecx
>    12:	85 c9                	test   %ecx,%ecx
>    14:	74 14                	je     0x2a
>    16:	48 8d ab dc 00 00 00 	lea    0xdc(%rbx),%rbp
>    1d:	48 89 ef             	mov    %rbp,%rdi
>    20:	e8 0d 8d f1 c2       	callq  0xffffffffc2f18d32
>    25:	e9 1e fd ff ff       	jmpq   0xfffffffffffffd48
>    2a:*	0f 0b                	ud2    		<-- trapping instruction
>    2c:	4c 89 e7             	mov    %r12,%rdi
>    2f:	e8 be 2e 1e c1       	callq  0xffffffffc11e2ef2
>    34:	e9 61 fe ff ff       	jmpq   0xfffffffffffffe9a
>    39:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
>    3e:	e8                   	.byte 0xe8
>    3f:	af                   	scas   %es:(%rdi),%eax
>
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	4c 89 e7             	mov    %r12,%rdi
>     5:	e8 be 2e 1e c1       	callq  0xffffffffc11e2ec8
>     a:	e9 61 fe ff ff       	jmpq   0xfffffffffffffe70
>     f:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
>    14:	e8                   	.byte 0xe8
>    15:	af                   	scas   %es:(%rdi),%eax
>
>
> To reproduce:
>
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
>
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.

Thanks,
Guoqing
