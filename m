Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739E058D19F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbiHIBBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiHIBB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:01:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685611AF30;
        Mon,  8 Aug 2022 18:01:24 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M1vpv460qzYrl8;
        Tue,  9 Aug 2022 08:59:19 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 09:01:22 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 09:01:21 +0800
Subject: Re: [PATCH v2] perf/core: Fix syzkaller reported issue "Internal
 error in read_pmevcntrn"
To:     <rostedt@goodmis.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20220805011454.111356-1-yangjihong1@huawei.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <53292a67-fb5b-020d-e98f-c7e3dae5648f@huawei.com>
Date:   Tue, 9 Aug 2022 09:01:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220805011454.111356-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

PING.

Regards,
Yang
.

On 2022/8/5 9:14, Yang Jihong wrote:
> syzkaller report a issue:
> Internal error: Oops - undefined instruction: 0 [#1] SMP
> Modules linked in:
> CPU: 1 PID: 15523 Comm: syz-executor.3 Not tainted 5.10.0 #6
> Hardware name: linux,dummy-virt (DT)
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
> pc : read_pmevcntrn+0x1e4/0x1ec arch/arm64/kernel/perf_event.c:423
> lr : read_pmevcntrn+0x1e4/0x1ec arch/arm64/kernel/perf_event.c:423
> sp : ffffa000174d6ee0
> x29: ffffa000174d6ee0 x28: ffffedbca6b17a40
> x27: ffffa000174d7310 x26: ffff4b3ec102e398
> x25: 00000000ffffffff x24: 00000000ffffffff
> x23: ffff4b3ed8afb000 x22: ffff4b3ed8afb160
> x21: ffff4b3ed8afb184 x20: ffffedbca46aa3e0
> x19: ffffedbca2a524bc x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000
> x15: 0000000020000100 x14: 0000000000000000
> x13: 0000000000000000 x12: ffff8967db15f63d
> x11: 1fffe967db15f63c x10: ffff8967db15f63c
> x9 : ffffedbca2a5273c x8 : ffff4b3ed8afb1e7
> x7 : 0000000000000001 x6 : ffff8967db15f63c
> x5 : ffff4b3f08b89400 x4 : 0000000000000000
> x3 : ffffedbca2a00000 x2 : ffffedbca4690000
> x1 : ffff4b3f08b89400 x0 : 0000000000000000
> Call trace:
>   read_pmevcntrn+0x1e4/0x1ec arch/arm64/kernel/perf_event.c:423
>   armv8pmu_read_evcntr arch/arm64/kernel/perf_event.c:467 [inline]
>   armv8pmu_read_hw_counter arch/arm64/kernel/perf_event.c:475 [inline]
>   armv8pmu_read_counter+0x10c/0x1f0 arch/arm64/kernel/perf_event.c:528
>   armpmu_event_update+0x9c/0x1bc drivers/perf/arm_pmu.c:247
>   armpmu_read+0x24/0x30 drivers/perf/arm_pmu.c:264
>   perf_output_read_group+0x4cc/0x71c kernel/events/core.c:6806
>   perf_output_read+0x78/0x1c4 kernel/events/core.c:6845
>   perf_output_sample+0xafc/0x1000 kernel/events/core.c:6892
>   __perf_event_output kernel/events/core.c:7273 [inline]
>   perf_event_output_forward+0xd8/0x130 kernel/events/core.c:7287
>   __perf_event_overflow+0xbc/0x20c kernel/events/core.c:8943
>   perf_swevent_overflow kernel/events/core.c:9019 [inline]
>   perf_swevent_event+0x274/0x2c0 kernel/events/core.c:9047
>   do_perf_sw_event kernel/events/core.c:9160 [inline]
>   ___perf_sw_event+0x150/0x1b4 kernel/events/core.c:9191
>   __perf_sw_event+0x58/0x7c kernel/events/core.c:9203
>   perf_sw_event include/linux/perf_event.h:1177 [inline]
>   mm_account_fault mm/memory.c:4707 [inline]
>   handle_mm_fault+0x364/0x3f0 mm/memory.c:4758
>   __do_page_fault arch/arm64/mm/fault.c:438 [inline]
>   do_page_fault+0x334/0x8f0 arch/arm64/mm/fault.c:537
>   do_translation_fault+0x188/0x1e0 arch/arm64/mm/fault.c:619
>   do_mem_abort+0x68/0x120 arch/arm64/mm/fault.c:743
>   el1_abort+0xc0/0x150 arch/arm64/kernel/entry-common.c:119
>   el1_sync_handler+0x118/0x150 arch/arm64/kernel/entry-common.c:202
>   el1_sync+0x74/0x100 arch/arm64/kernel/entry.S:665
>   __arch_clear_user+0x20/0xa0 arch/arm64/lib/clear_user.S:25
>   read_iter_zero+0x90/0x16c drivers/char/mem.c:718
>   call_read_iter include/linux/fs.h:1954 [inline]
>   do_iter_readv_writev+0x394/0x414 fs/read_write.c:735
>   do_iter_read+0x1b0/0x280 fs/read_write.c:798
>   vfs_readv+0xf0/0x150 fs/read_write.c:918
>   do_readv+0x108/0x270 fs/read_write.c:955
>   __do_sys_readv fs/read_write.c:1046 [inline]
>   __se_sys_readv fs/read_write.c:1043 [inline]
>   __arm64_sys_readv+0x54/0x64 fs/read_write.c:1043
>   __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
>   invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
>   el0_svc_common.constprop.0+0xf4/0x414 arch/arm64/kernel/syscall.c:155
>   do_el0_svc+0x50/0x11c arch/arm64/kernel/syscall.c:217
>   el0_svc+0x20/0x30 arch/arm64/kernel/entry-common.c:353
>   el0_sync_handler+0xe4/0x1e0 arch/arm64/kernel/entry-common.c:369
>   el0_sync+0x148/0x180 arch/arm64/kernel/entry.S:683
> Code: 940c387b d53be813 17ffff9c 940c3878 (d53bebd3)
> ---[ end trace 6aab9f4b33ebf0aa ]---
> ----------------
> Code disassembly (best guess):
>     0:	940c387b 	bl	0x30e1ec
>     4:	d53be813 	mrs	x19, pmevcntr0_el0
>     8:	17ffff9c 	b	0xfffffffffffffe78
>     c:	940c3878 	bl	0x30e1ec
> * 10:	d53bebd3 	mrs	x19, pmevcntr30_el0 <-- trapping instruction
> 
> Interrupts is not disabled when perf_output_read_group reads PMU counter.
> In this case, IPI request may be received from other cores.
> As a result, PMU configuration is modified and an error occurs when
> reading PMU counter:
> 
>                     CPU0                                         CPU1
>                                                      __se_sys_perf_event_open
>                                                        perf_install_in_context
> perf_output_read_group                                  smp_call_function_single
>    for_each_sibling_event(sub, leader) {                   generic_exec_single
>      if ((sub != event) &&                                   remote_function
>          (sub->state == PERF_EVENT_STATE_ACTIVE))                    |
> <enter IPI handler: __perf_install_in_context>   <----RAISE IPI-----+
> __perf_install_in_context
>    ctx_resched
>      event_sched_out
>        armpmu_del
>          ...
>          hwc->idx = -1; // event->hwc.idx is set to -1
> ...
> <exit IPI>
>              sub->pmu->read(sub);
>                armpmu_read
>                  armv8pmu_read_counter
>                    armv8pmu_read_hw_counter
>                      int idx = event->hw.idx; // idx = -1
>                      u64 val = armv8pmu_read_evcntr(idx);
>                        u32 counter = ARMV8_IDX_TO_COUNTER(idx); // invalid counter = 30
>                        read_pmevcntrn(counter) // undefined instruction
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v1:
>    - Adapt patch to mainline branch to solve compilation problem.
> 
>   kernel/events/core.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4e718b93442b..776fe24adcbd 100644
> --- a/kernel/events/core.c
> i+++ b/kernel/events/core.c
> @@ -6895,6 +6895,13 @@ static void perf_output_read_group(struct perf_output_handle *handle,
>   	u64 read_format = event->attr.read_format;
>   	u64 values[6];
>   	int n = 0;
> +	unsigned long flags;
> +
> +	/*
> +	 * Disabling interrupts avoids all counter scheduling
> +	 * (context switches, timer based rotation and IPIs).
> +	 */
> +	local_irq_save(flags);
>   
>   	values[n++] = 1 + leader->nr_siblings;
>   
> @@ -6931,6 +6938,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
>   
>   		__output_copy(handle, values, n * sizeof(u64));
>   	}
> +
> +	local_irq_restore(flags);
>   }
>   
>   #define PERF_FORMAT_TOTAL_TIMES (PERF_FORMAT_TOTAL_TIME_ENABLED|\
> 
