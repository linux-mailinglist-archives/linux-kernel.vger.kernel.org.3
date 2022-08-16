Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5064B595E98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbiHPOy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbiHPOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:54:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ACA55A178;
        Tue, 16 Aug 2022 07:54:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 996701042;
        Tue, 16 Aug 2022 07:54:24 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.44.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27CA83F66F;
        Tue, 16 Aug 2022 07:54:22 -0700 (PDT)
Date:   Tue, 16 Aug 2022 15:54:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>, rostedt@goodmis.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf/core: Fix reentry problem in
 perf_output_read_group
Message-ID: <Yvuvm7Onw3pmB9Z6@FVFF77S0Q05N>
References: <20220816091103.257702-1-yangjihong1@huawei.com>
 <YvumDL1qz1NjpfEC@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvumDL1qz1NjpfEC@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:13:32PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 16, 2022 at 05:11:03PM +0800, Yang Jihong wrote:
> > perf_output_read_group may respond to IPI request of other cores and invoke
> > __perf_install_in_context function. As a result, hwc configuration is modified.
> > As a result, the hwc configuration is modified, causing inconsistency and
> > unexpected consequences.
> 
> >  read_pmevcntrn+0x1e4/0x1ec arch/arm64/kernel/perf_event.c:423
> >  armv8pmu_read_evcntr arch/arm64/kernel/perf_event.c:467 [inline]
> >  armv8pmu_read_hw_counter arch/arm64/kernel/perf_event.c:475 [inline]
> >  armv8pmu_read_counter+0x10c/0x1f0 arch/arm64/kernel/perf_event.c:528
> >  armpmu_event_update+0x9c/0x1bc drivers/perf/arm_pmu.c:247
> >  armpmu_read+0x24/0x30 drivers/perf/arm_pmu.c:264
> >  perf_output_read_group+0x4cc/0x71c kernel/events/core.c:6806
> >  perf_output_read+0x78/0x1c4 kernel/events/core.c:6845
> >  perf_output_sample+0xafc/0x1000 kernel/events/core.c:6892
> >  __perf_event_output kernel/events/core.c:7273 [inline]
> >  perf_event_output_forward+0xd8/0x130 kernel/events/core.c:7287
> >  __perf_event_overflow+0xbc/0x20c kernel/events/core.c:8943
> >  perf_swevent_overflow kernel/events/core.c:9019 [inline]
> >  perf_swevent_event+0x274/0x2c0 kernel/events/core.c:9047
> >  do_perf_sw_event kernel/events/core.c:9160 [inline]
> >  ___perf_sw_event+0x150/0x1b4 kernel/events/core.c:9191
> >  __perf_sw_event+0x58/0x7c kernel/events/core.c:9203
> >  perf_sw_event include/linux/perf_event.h:1177 [inline]
> 
> > Interrupts is not disabled when perf_output_read_group reads PMU counter.
> 
> s/is/are/ due to 'interrupts' being plural
> 
> Anyway, yes, I suppose this is indeed so. That code expects to run with
> IRQs disabled but in the case of software events that isn't so.
> 
> > In this case, IPI request may be received from other cores.
> > As a result, PMU configuration is modified and an error occurs when
> > reading PMU counter:
> > 
> >                    CPU0                                         CPU1
> >                                                     __se_sys_perf_event_open
> >                                                       perf_install_in_context
> > perf_output_read_group                                  smp_call_function_single
> >   for_each_sibling_event(sub, leader) {                   generic_exec_single
> >     if ((sub != event) &&                                   remote_function
> >         (sub->state == PERF_EVENT_STATE_ACTIVE))                    |
> > <enter IPI handler: __perf_install_in_context>   <----RAISE IPI-----+
> > __perf_install_in_context
> >   ctx_resched
> >     event_sched_out
> >       armpmu_del
> >         ...
> >         hwc->idx = -1; // event->hwc.idx is set to -1
> > ...
> > <exit IPI>
> >             sub->pmu->read(sub);
> >               armpmu_read
> >                 armv8pmu_read_counter
> >                   armv8pmu_read_hw_counter
> >                     int idx = event->hw.idx; // idx = -1
> >                     u64 val = armv8pmu_read_evcntr(idx);
> >                       u32 counter = ARMV8_IDX_TO_COUNTER(idx); // invalid counter = 30
> >                       read_pmevcntrn(counter) // undefined instruction
> > 
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> > ---
> >  kernel/events/core.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 4e718b93442b..776fe24adcbd 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6895,6 +6895,13 @@ static void perf_output_read_group(struct perf_output_handle *handle,
> >  	u64 read_format = event->attr.read_format;
> >  	u64 values[6];
> >  	int n = 0;
> > +	unsigned long flags;
> > +
> > +	/*
> > +	 * Disabling interrupts avoids all counter scheduling
> > +	 * (context switches, timer based rotation and IPIs).
> > +	 */
> > +	local_irq_save(flags);
> >  
> >  	values[n++] = 1 + leader->nr_siblings;
> >  
> > @@ -6931,6 +6938,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
> >  
> >  		__output_copy(handle, values, n * sizeof(u64));
> >  	}
> > +
> > +	local_irq_restore(flags);
> >  }
> 
> Specifically I think it is for_each_sibling_event() itself that requires
> the context to be stable. Perhaps we should add an assertion there as
> well.
> 
> Something like so on top, I suppose.. Does that yield more problem
> sites?
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index ee8b9ecdc03b..d4d53b9ba71e 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -631,7 +631,12 @@ struct pmu_event_list {
>  	struct list_head	list;
>  };
>  
> +/*
> + * Iterating the sibling list requires this list to be stable; by ensuring IRQs
> + * are disabled IPIs from perf_{install_in,remove_from}_context() are held off.
> + */
>  #define for_each_sibling_event(sibling, event)			\
> +	lockdep_assert_irqs_disabled();				\
>  	if ((event)->group_leader == (event))			\
>  		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
>  

I had a go with v6.0-rc1 and Vince's perf fuzzer immediately triggered a bunch
of cases (dump below).

I had thought holding the context mutex protected some of these cases, even
with IRQs unmasked?

Thanks,
Mark.

[   18.147366] ------------[ cut here ]------------
[   18.148607] WARNING: CPU: 0 PID: 178 at kernel/events/core.c:13093 inherit_task_group.isra.0+0x1a4/0x1f0
[   18.151045] Modules linked in:
[   18.151869] CPU: 0 PID: 178 Comm: perf_fuzzer Not tainted 6.0.0-rc1-00001-g4e565501874a #1
[   18.154013] Hardware name: linux,dummy-virt (DT)
[   18.155223] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   18.157035] pc : inherit_task_group.isra.0+0x1a4/0x1f0
[   18.158378] lr : inherit_task_group.isra.0+0x58/0x1f0
[   18.159687] sp : ffff80000b77bab0
[   18.160571] x29: ffff80000b77bab0 x28: ffff000005850000 x27: ffff80000b77bb7c
[   18.162416] x26: ffff00000523dc38 x25: 0000000000000001 x24: ffff000005850560
[   18.164268] x23: ffff000003bd7800 x22: ffff80000b77bb7c x21: ffff00000523ca40
[   18.166086] x20: 0000000000000001 x19: ffff000005850000 x18: 0000000000000014
[   18.167889] x17: 000000001e973189 x16: 00000000c6c83604 x15: 0000000047ac8812
[   18.169750] x14: 0000000000000028 x13: 0000000000003a6e x12: 0000000000000362
[   18.171576] x11: 0000000000000362 x10: 00000000000000ff x9 : 00000000ffffffff
[   18.173441] x8 : ffff80000a910718 x7 : 0000000000000000 x6 : 0000000000000001
[   18.175254] x5 : 00000000787896dd x4 : 000000000000dba2 x3 : ffff000005238000
[   18.177089] x2 : ffff800075e1a000 x1 : ffff000005238000 x0 : 0000000100000000
[   18.178921] Call trace:
[   18.179584]  inherit_task_group.isra.0+0x1a4/0x1f0
[   18.180859]  perf_event_init_task+0x12c/0x320
[   18.181996]  copy_process+0x63c/0x1964
[   18.182985]  kernel_clone+0x9c/0x4a4
[   18.183946]  __do_sys_clone+0x70/0xac
[   18.184935]  __arm64_sys_clone+0x24/0x30
[   18.185973]  invoke_syscall+0x48/0x114
[   18.186972]  el0_svc_common.constprop.0+0x60/0x11c
[   18.188230]  do_el0_svc+0x30/0xc0
[   18.189106]  el0_svc+0x48/0xc0
[   18.189921]  el0t_64_sync_handler+0x120/0x15c
[   18.191069]  el0t_64_sync+0x18c/0x190
[   18.192045] irq event stamp: 12510
[   18.192960] hardirqs last  enabled at (12509): [<ffff8000091efb18>] _raw_spin_unlock_irqrestore+0x88/0x94
[   18.195414] hardirqs last disabled at (12510): [<ffff8000091e3084>] el1_dbg+0x24/0x90
[   18.197449] softirqs last  enabled at (12494): [<ffff800008016e98>] put_cpu_fpsimd_context+0x28/0x70
[   18.199812] softirqs last disabled at (12492): [<ffff800008016e14>] get_cpu_fpsimd_context+0x0/0x5c
[   18.202161] ---[ end trace 0000000000000000 ]---



[   18.209950] ------------[ cut here ]------------
[   18.211148] WARNING: CPU: 0 PID: 178 at kernel/events/core.c:2231 pmu_filter_match+0x114/0x140
[   18.213400] Modules linked in:
[   18.214217] CPU: 0 PID: 178 Comm: perf_fuzzer Tainted: G        W          6.0.0-rc1-00001-g4e565501874a #1
[   18.216754] Hardware name: linux,dummy-virt (DT)
[   18.217970] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   18.219790] pc : pmu_filter_match+0x114/0x140
[   18.220930] lr : perf_iterate_sb+0x208/0x2f0
[   18.222039] sp : ffff80000b77baa0
[   18.222900] x29: ffff80000b77baa0 x28: 0000000000000001 x27: ffff000005256fe0
[   18.224735] x26: 000000000000000d x25: ffff000005290c00 x24: ffff800009d92008
[   18.226568] x23: ffff80000b77bb60 x22: ffff800008266444 x21: ffff80000a4e8568
[   18.228448] x20: ffff000005851020 x19: 0000000000000001 x18: 0000000000000001
[   18.230292] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   18.232173] x14: 0000000000000000 x13: 005d746e6576655f x12: 0000000000000015
[   18.234039] x11: 0000000000000015 x10: 0000000000020015 x9 : 00000000549748ff
[   18.235901] x8 : ffff80000a910718 x7 : 0000000000000000 x6 : 0000000000000002
[   18.237782] x5 : 00000000dd815a73 x4 : 00000000afc1b98a x3 : ffff00007fbd4040
[   18.239626] x2 : ffff800075e1a000 x1 : ffff000005238000 x0 : 0000000100000001
[   18.241487] Call trace:
[   18.242140]  pmu_filter_match+0x114/0x140
[   18.243193]  perf_iterate_sb+0x208/0x2f0
[   18.244236]  perf_event_mmap+0x394/0x5ac
[   18.245256]  mmap_region+0x210/0x540
[   18.246191]  do_mmap+0x3a8/0x51c
[   18.247035]  vm_mmap_pgoff+0xf0/0x180
[   18.247997]  ksys_mmap_pgoff+0x1b4/0x210
[   18.249047]  __arm64_sys_mmap+0x34/0x50
[   18.250068]  invoke_syscall+0x48/0x114
[   18.251069]  el0_svc_common.constprop.0+0x60/0x11c
[   18.252362]  do_el0_svc+0x30/0xc0
[   18.253242]  el0_svc+0x48/0xc0
[   18.254072]  el0t_64_sync_handler+0x120/0x15c
[   18.255224]  el0t_64_sync+0x18c/0x190
[   18.256196] irq event stamp: 13192
[   18.257098] hardirqs last  enabled at (13191): [<ffff8000091efb18>] _raw_spin_unlock_irqrestore+0x88/0x94
[   18.259590] hardirqs last disabled at (13192): [<ffff8000091e3084>] el1_dbg+0x24/0x90
[   18.261634] softirqs last  enabled at (13152): [<ffff8000080104f8>] __do_softirq+0x448/0x5bc
[   18.263835] softirqs last disabled at (13143): [<ffff8000080a6dec>] __irq_exit_rcu+0x18c/0x1a0
[   18.266074] ---[ end trace 0000000000000000 ]---



[   18.358197] ------------[ cut here ]------------
[   18.359440] WARNING: CPU: 0 PID: 178 at kernel/events/core.c:5489 _perf_ioctl+0x86c/0xd10
[   18.361546] Modules linked in:
[   18.362350] CPU: 0 PID: 178 Comm: perf_fuzzer Tainted: G        W          6.0.0-rc1-00001-g4e565501874a #1
[   18.364816] Hardware name: linux,dummy-virt (DT)
[   18.366007] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   18.367774] pc : _perf_ioctl+0x86c/0xd10
[   18.368798] lr : _perf_ioctl+0xe0/0xd10
[   18.369788] sp : ffff80000b77bc60
[   18.370644] x29: ffff80000b77bc60 x28: ffff000005238000 x27: 0000000000000000
[   18.372474] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[   18.374279] x23: 0000000000000003 x22: ffff80000a453000 x21: ffff000005850ac0
[   18.376090] x20: 0000000000000001 x19: ffff80000826cef0 x18: 0000000000000000
[   18.377891] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   18.379695] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000362
[   18.381560] x11: 0000000000000362 x10: 0000000000003fff x9 : 00000000ffffffff
[   18.383423] x8 : ffff80000a910718 x7 : 0000000000000000 x6 : 0000000000000001
[   18.385276] x5 : 00000000787896dd x4 : 000000000000dba2 x3 : ffff000005238000
[   18.387148] x2 : ffff800075e1a000 x1 : ffff000005238000 x0 : 0000000100000000
[   18.388989] Call trace:
[   18.389651]  _perf_ioctl+0x86c/0xd10
[   18.390583]  perf_ioctl+0x54/0x80
[   18.391440]  __arm64_sys_ioctl+0xb0/0xf4
[   18.392461]  invoke_syscall+0x48/0x114
[   18.393431]  el0_svc_common.constprop.0+0x60/0x11c
[   18.394666]  do_el0_svc+0x30/0xc0
[   18.395530]  el0_svc+0x48/0xc0
[   18.396343]  el0t_64_sync_handler+0x120/0x15c
[   18.397464]  el0t_64_sync+0x18c/0x190
[   18.398411] irq event stamp: 15728
[   18.399297] hardirqs last  enabled at (15727): [<ffff800008029df0>] el0_svc_common.constprop.0+0x3c/0x11c
[   18.401720] hardirqs last disabled at (15728): [<ffff8000091e3084>] el1_dbg+0x24/0x90
[   18.403708] softirqs last  enabled at (15670): [<ffff800008016e98>] put_cpu_fpsimd_context+0x28/0x70
[   18.406031] softirqs last disabled at (15668): [<ffff800008016e14>] get_cpu_fpsimd_context+0x0/0x5c
[   18.408336] ---[ end trace 0000000000000000 ]---



[   18.492991] ------------[ cut here ]------------
[   18.494251] WARNING: CPU: 0 PID: 178 at drivers/perf/arm_pmu.c:406 validate_group+0x1d4/0x230
[   18.496469] Modules linked in:
[   18.497287] CPU: 0 PID: 178 Comm: perf_fuzzer Tainted: G        W          6.0.0-rc1-00001-g4e565501874a #1
[   18.499773] Hardware name: linux,dummy-virt (DT)
[   18.500991] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   18.502766] pc : validate_group+0x1d4/0x230
[   18.503850] lr : validate_group+0xa4/0x230
[   18.504922] sp : ffff80000b77ba10
[   18.505785] x29: ffff80000b77ba10 x28: ffff0000058510f8 x27: ffff80000826a31c
[   18.507602] x26: ffff80000826a2c8 x25: 0000000000000000 x24: ffff80000b77bd68
[   18.509438] x23: 0000000040000000 x22: ffff000003b15800 x21: ffff000005851020
[   18.511265] x20: ffff000005850ac0 x19: 0000000000000001 x18: 0000000000000000
[   18.513080] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000006d6df8
[   18.514914] x14: 0000000000000000 x13: 0000000000000000 x12: 000000000000036d
[   18.516756] x11: 000000000000036d x10: 000000000004036d x9 : 0000000000000000
[   18.518571] x8 : ffff000003b15800 x7 : 0000000000000000 x6 : 0000000000000001
[   18.520394] x5 : 0000000000000007 x4 : ffff80000b77bb40 x3 : ffff80000b77bb40
[   18.522218] x2 : ffff800075e1a000 x1 : ffff000005238000 x0 : 0000000100000000
[   18.524049] Call trace:
[   18.524701]  validate_group+0x1d4/0x230
[   18.525694]  armpmu_event_init+0xe8/0x160
[   18.526730]  perf_try_init_event+0x9c/0x10c
[   18.527813]  perf_event_alloc+0x548/0xf20
[   18.528872]  __do_sys_perf_event_open+0x19c/0x11b4
[   18.530128]  __arm64_sys_perf_event_open+0x2c/0x40
[   18.531380]  invoke_syscall+0x48/0x114
[   18.532383]  el0_svc_common.constprop.0+0x60/0x11c
[   18.533624]  do_el0_svc+0x30/0xc0
[   18.534505]  el0_svc+0x48/0xc0
[   18.535322]  el0t_64_sync_handler+0x120/0x15c
[   18.536456]  el0t_64_sync+0x18c/0x190
[   18.537414] irq event stamp: 21796
[   18.538298] hardirqs last  enabled at (21795): [<ffff800008029df0>] el0_svc_common.constprop.0+0x3c/0x11c
[   18.540744] hardirqs last disabled at (21796): [<ffff8000091e3084>] el1_dbg+0x24/0x90
[   18.542739] softirqs last  enabled at (21660): [<ffff8000080104f8>] __do_softirq+0x448/0x5bc
[   18.544894] softirqs last disabled at (21655): [<ffff8000080a6dec>] __irq_exit_rcu+0x18c/0x1a0
[   18.547096] ---[ end trace 0000000000000000 ]---



[   18.711228] ------------[ cut here ]------------
[   18.712603] WARNING: CPU: 0 PID: 178 at kernel/events/core.c:12334 __do_sys_perf_event_open+0xf58/0x11b4
[   18.715111] Modules linked in:
[   18.715964] CPU: 0 PID: 178 Comm: perf_fuzzer Tainted: G        W          6.0.0-rc1-00001-g4e565501874a #1
[   18.718527] Hardware name: linux,dummy-virt (DT)
[   18.719765] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   18.721623] pc : __do_sys_perf_event_open+0xf58/0x11b4
[   18.722989] lr : __do_sys_perf_event_open+0xf4c/0x11b4
[   18.724377] sp : ffff80000b77bcc0
[   18.725267] x29: ffff80000b77bcc0 x28: 0000000000000001 x27: ffff00000535ec00
[   18.727147] x26: 0000000000000000 x25: ffff000005850ac0 x24: 0000000000000009
[   18.729056] x23: ffff000003bd7a00 x22: 0000000000000001 x21: ffff000003bd7000
[   18.730962] x20: ffff000005855b60 x19: ffff000005238000 x18: 0000000000000000
[   18.732940] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000006d6df8
[   18.734852] x14: 0000000000000028 x13: 0000000000003cbc x12: 0000000000000375
[   18.736751] x11: 0000000000000375 x10: 0000000000040375 x9 : 00000000a56c6ee1
[   18.738648] x8 : ffff80000a910718 x7 : 0000000000000000 x6 : 0000000000000003
[   18.740569] x5 : 000000000d6385d2 x4 : 0000000000000000 x3 : 0000000000000000
[   18.742469] x2 : ffff000005238000 x1 : 0000000100000000 x0 : 0000000000000000
[   18.744380] Call trace:
[   18.745046]  __do_sys_perf_event_open+0xf58/0x11b4
[   18.746333]  __arm64_sys_perf_event_open+0x2c/0x40
[   18.747611]  invoke_syscall+0x48/0x114
[   18.748651]  el0_svc_common.constprop.0+0x60/0x11c
[   18.749931]  do_el0_svc+0x30/0xc0
[   18.750829]  el0_svc+0x48/0xc0
[   18.751660]  el0t_64_sync_handler+0x120/0x15c
[   18.752911]  el0t_64_sync+0x18c/0x190
[   18.753918] irq event stamp: 40164
[   18.754855] hardirqs last  enabled at (40163): [<ffff8000091efb18>] _raw_spin_unlock_irqrestore+0x88/0x94
[   18.757413] hardirqs last disabled at (40164): [<ffff8000091e3084>] el1_dbg+0x24/0x90
[   18.759523] softirqs last  enabled at (40130): [<ffff8000080104f8>] __do_softirq+0x448/0x5bc
[   18.761786] softirqs last disabled at (40101): [<ffff8000080a6dec>] __irq_exit_rcu+0x18c/0x1a0
[   18.764057] ---[ end trace 0000000000000000 ]---



[   18.770418] ------------[ cut here ]------------
[   18.771683] WARNING: CPU: 0 PID: 178 at kernel/events/core.c:12407 __do_sys_perf_event_open+0x1168/0x11b4
[   18.774261] Modules linked in:
[   18.775108] CPU: 0 PID: 178 Comm: perf_fuzzer Tainted: G        W          6.0.0-rc1-00001-g4e565501874a #1
[   18.777700] Hardware name: linux,dummy-virt (DT)
[   18.778950] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   18.780833] pc : __do_sys_perf_event_open+0x1168/0x11b4
[   18.782245] lr : __do_sys_perf_event_open+0x115c/0x11b4
[   18.783652] sp : ffff80000b77bcc0
[   18.784568] x29: ffff80000b77bcc0 x28: 0000000000000001 x27: ffff00000535ec00
[   18.786489] x26: 0000000000000000 x25: ffff000005850ac0 x24: 0000000000000009
[   18.788397] x23: ffff000003bd7a00 x22: 0000000000000001 x21: ffff000003bd7000
[   18.790260] x20: ffff000005855b60 x19: ffff000005238000 x18: 0000000000000000
[   18.792149] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000006d6df8
[   18.794065] x14: 0000000000000028 x13: 0000000000003cff x12: 0000000000000375
[   18.796000] x11: 0000000000000375 x10: 0000000000040375 x9 : 00000000a56c6ee1
[   18.797913] x8 : ffff80000a910718 x7 : 0000000000000000 x6 : 0000000000000003
[   18.799814] x5 : 0000000000000000 x4 : 0000000000000003 x3 : 0000000000000000
[   18.801735] x2 : ffff000005238000 x1 : 0000000100000000 x0 : 0000000000000000
[   18.803626] Call trace:
[   18.804321]  __do_sys_perf_event_open+0x1168/0x11b4
[   18.805635]  __arm64_sys_perf_event_open+0x2c/0x40
[   18.806918]  invoke_syscall+0x48/0x114
[   18.807958]  el0_svc_common.constprop.0+0x60/0x11c
[   18.809271]  do_el0_svc+0x30/0xc0
[   18.810183]  el0_svc+0x48/0xc0
[   18.811020]  el0t_64_sync_handler+0x120/0x15c
[   18.812223]  el0t_64_sync+0x18c/0x190
[   18.813227] irq event stamp: 40198
[   18.814156] hardirqs last  enabled at (40197): [<ffff800008192e5c>] generic_exec_single+0xf8/0x150
[   18.816540] hardirqs last disabled at (40198): [<ffff8000091e3084>] el1_dbg+0x24/0x90
[   18.818617] softirqs last  enabled at (40188): [<ffff8000080104f8>] __do_softirq+0x448/0x5bc
[   18.820868] softirqs last disabled at (40167): [<ffff8000080a6dec>] __irq_exit_rcu+0x18c/0x1a0
[   18.823164] ---[ end trace 0000000000000000 ]---



[   18.829887] ------------[ cut here ]------------
[   18.831087] WARNING: CPU: 0 PID: 178 at kernel/events/core.c:12428 __do_sys_perf_event_open+0x10cc/0x11b4
[   18.833648] Modules linked in:
[   18.834491] CPU: 0 PID: 178 Comm: perf_fuzzer Tainted: G        W          6.0.0-rc1-00001-g4e565501874a #1
[   18.837081] Hardware name: linux,dummy-virt (DT)
[   18.838334] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   18.840187] pc : __do_sys_perf_event_open+0x10cc/0x11b4
[   18.841618] lr : __do_sys_perf_event_open+0x10c0/0x11b4
[   18.843023] sp : ffff80000b77bcc0
[   18.843939] x29: ffff80000b77bcc0 x28: 0000000000000001 x27: ffff00000535ec00
[   18.845859] x26: 0000000000000000 x25: ffff000005850ac0 x24: 0000000000000009
[   18.847768] x23: ffff000003bd7a00 x22: 0000000000000001 x21: ffff000003bd7000
[   18.849690] x20: ffff000005855b60 x19: ffff000005238000 x18: 0000000000000000
[   18.851570] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   18.853483] x14: 0000000003696f8a x13: 0000000000000000 x12: 0000000000000375
[   18.855370] x11: 0000000000000375 x10: 0000000000040375 x9 : 00000000a56c6ee1
[   18.857281] x8 : ffff80000a910718 x7 : 0000000000000000 x6 : 0000000000000003
[   18.859180] x5 : 0000000000000000 x4 : 0000000000000003 x3 : 0000000000000000
[   18.861091] x2 : ffff000005238000 x1 : 0000000100000000 x0 : 0000000000000000
[   18.863016] Call trace:
[   18.863700]  __do_sys_perf_event_open+0x10cc/0x11b4
[   18.865036]  __arm64_sys_perf_event_open+0x2c/0x40
[   18.866342]  invoke_syscall+0x48/0x114
[   18.867356]  el0_svc_common.constprop.0+0x60/0x11c
[   18.868653]  do_el0_svc+0x30/0xc0
[   18.869561]  el0_svc+0x48/0xc0
[   18.870394]  el0t_64_sync_handler+0x120/0x15c
[   18.871570]  el0t_64_sync+0x18c/0x190
[   18.872591] irq event stamp: 40244
[   18.873508] hardirqs last  enabled at (40243): [<ffff8000091ef63c>] _raw_spin_unlock_irq+0x3c/0x74
[   18.875879] hardirqs last disabled at (40244): [<ffff8000091e3084>] el1_dbg+0x24/0x90
[   18.877988] softirqs last  enabled at (40230): [<ffff8000080104f8>] __do_softirq+0x448/0x5bc
[   18.880258] softirqs last disabled at (40201): [<ffff8000080a6dec>] __irq_exit_rcu+0x18c/0x1a0
[   18.882551] ---[ end trace 0000000000000000 ]---
