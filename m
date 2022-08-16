Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5159608A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbiHPQpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiHPQph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:45:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 306FA4DF13;
        Tue, 16 Aug 2022 09:45:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA354106F;
        Tue, 16 Aug 2022 09:45:36 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.44.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 383BE3F67D;
        Tue, 16 Aug 2022 09:45:34 -0700 (PDT)
Date:   Tue, 16 Aug 2022 17:45:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>, rostedt@goodmis.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf/core: Fix reentry problem in
 perf_output_read_group
Message-ID: <YvvJq2f/7eFVcnNy@FVFF77S0Q05N>
References: <20220816091103.257702-1-yangjihong1@huawei.com>
 <YvumDL1qz1NjpfEC@worktop.programming.kicks-ass.net>
 <Yvuvm7Onw3pmB9Z6@FVFF77S0Q05N>
 <Yvu4TyFmeOd/rJ8t@worktop.programming.kicks-ass.net>
 <YvvIWmDBWdIUCMZj@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvvIWmDBWdIUCMZj@FVFF77S0Q05N>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:39:54PM +0100, Mark Rutland wrote:
> On Tue, Aug 16, 2022 at 05:31:27PM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 16, 2022 at 03:54:19PM +0100, Mark Rutland wrote:
> > > > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > > > index ee8b9ecdc03b..d4d53b9ba71e 100644
> > > > --- a/include/linux/perf_event.h
> > > > +++ b/include/linux/perf_event.h
> > > > @@ -631,7 +631,12 @@ struct pmu_event_list {
> > > >  	struct list_head	list;
> > > >  };
> > > >  
> > > > +/*
> > > > + * Iterating the sibling list requires this list to be stable; by ensuring IRQs
> > > > + * are disabled IPIs from perf_{install_in,remove_from}_context() are held off.
> > > > + */
> > > >  #define for_each_sibling_event(sibling, event)			\
> > > > +	lockdep_assert_irqs_disabled();				\
> > > >  	if ((event)->group_leader == (event))			\
> > > >  		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
> > > >  
> > > 
> > > I had a go with v6.0-rc1 and Vince's perf fuzzer immediately triggered a bunch
> > > of cases (dump below).
> > > 
> > > I had thought holding the context mutex protected some of these cases, even
> > > with IRQs unmasked?
> > 
> > Ah yes.. duh. How's this then?
> > 
> > 
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index ee8b9ecdc03b..4d9cf508c510 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -631,7 +631,21 @@ struct pmu_event_list {
> >  	struct list_head	list;
> >  };
> >  
> > +#ifdef CONFIG_LOCKDEP
> > +#define LOCKDEP_ASSERT_EVENT_CTX(event)				\
> > +	WARN_ON_ONCE(__lockdep_enabled &&			\
> > +		     (this_cpu_read(hardirqs_enabled) ||	\
> > +		      lockdep_is_held(&(event)->ctx->mutex) != LOCK_STATE_HELD))
> 
> Uh, should that `||` be `&&`, or am I missing the plot?
> 
> This'll warn if IRQs are enabled regardless of whether the mutex is held.

With `&&` I see:

[   25.194796] ------------[ cut here ]------------
[   25.196017] WARNING: CPU: 0 PID: 177 at kernel/events/core.c:2231 pmu_filter_match+0x12c/0x154
[   25.198140] Modules linked in:
[   25.198933] CPU: 0 PID: 177 Comm: perf_fuzzer Not tainted 6.0.0-rc1-00002-g2dee3ea2f881 #9
[   25.200945] Hardware name: linux,dummy-virt (DT)
[   25.202083] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   25.203799] pc : pmu_filter_match+0x12c/0x154
[   25.204881] lr : pmu_filter_match+0x124/0x154
[   25.205964] sp : ffff80000b753a90
[   25.206807] x29: ffff80000b753a90 x28: 0000000001200000 x27: 0000000000000000
[   25.208557] x26: ffff00000523ca40 x25: ffff80000a90bbd0 x24: 0000000000000000
[   25.210316] x23: ffff800009d92008 x22: ffff8000082669a0 x21: ffff80000b753b58
[   25.212065] x20: ffff000005890560 x19: 0000000000000001 x18: 0000000000000001
[   25.213819] x17: 00000000c3d5f54b x16: 000000006eb75123 x15: 00000000000000dc
[   25.215574] x14: 0000000001200011 x13: 0000000060000000 x12: 0000000000000015
[   25.217325] x11: 0000000000000015 x10: 000007ffffffffff x9 : 00000000ffffffff
[   25.219091] x8 : ffff80000a910718 x7 : 0000000000000000 x6 : 0000000000000001
[   25.220847] x5 : 00000000c3affd79 x4 : 0000000000000000 x3 : ffff000003b15800
[   25.222605] x2 : 0000000000000001 x1 : 00000000000000c0 x0 : 0000000000000000
[   25.224361] Call trace:
[   25.224987]  pmu_filter_match+0x12c/0x154
[   25.225987]  perf_iterate_ctx+0x110/0x11c
[   25.226997]  perf_iterate_sb+0x258/0x2f0
[   25.227971]  perf_event_fork+0x74/0xc0
[   25.228910]  copy_process+0x1484/0x1964
[   25.229869]  kernel_clone+0x9c/0x4a4
[   25.230780]  __do_sys_clone+0x70/0xac
[   25.231699]  __arm64_sys_clone+0x24/0x30
[   25.232679]  invoke_syscall+0x48/0x114
[   25.233615]  el0_svc_common.constprop.0+0x60/0x11c
[   25.234817]  do_el0_svc+0x30/0xc0
[   25.235659]  el0_svc+0x48/0xc0
[   25.236438]  el0t_64_sync_handler+0x120/0x15c
[   25.237523]  el0t_64_sync+0x18c/0x190
[   25.238448] irq event stamp: 13502
[   25.239301] hardirqs last  enabled at (13501): [<ffff8000091f0d68>] _raw_spin_unlock_irqrestore+0x88/0x94
[   25.241627] hardirqs last disabled at (13502): [<ffff8000091e42d4>] el1_dbg+0x24/0x90
[   25.243550] softirqs last  enabled at (13340): [<ffff800008016e98>] put_cpu_fpsimd_context+0x28/0x70
[   25.245773] softirqs last disabled at (13338): [<ffff800008016e14>] get_cpu_fpsimd_context+0x0/0x5c
[   25.247989] ---[ end trace 0000000000000000 ]---

Thanks,
Mark.
