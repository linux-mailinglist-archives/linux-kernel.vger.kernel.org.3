Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE34B595E26
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiHPOOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiHPOOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:14:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B997AC1D;
        Tue, 16 Aug 2022 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B7iCF7z/dSs3zH5fQRon2FEpe1wqapi26nHgYMm0Kq8=; b=oFJ/DrCFcck1y3NjM2VilKCRya
        4rivGyeWBfnAkTx0ni6buZwRH3Ey7dtalxx4EUdvGgG6uXSQa+I1o/ycafUAmdHQn4SMTtJ6rszow
        X8VBu61zBkWVQJKClfqvdJjRCECPSKK+qCYcCwT5OruYFmyi0xULRaX/HKWgIgDgcw3zbPAfEn5L+
        GFRLN5/E6vANaxOAlDmTWAMbcycfxmQBs7oorNdI1AMW3YoHqGbEdogNTWXPF0x10KSTXX/VXOaaX
        5XUpmYapACHkmjoLeQc6r3PcU7nmEQVgdLn4R3wZKTndjjog7s9DehQFESlJ6doIoU8MikFWoHx3V
        EieLOFbA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNxK1-002yjb-8s; Tue, 16 Aug 2022 14:13:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A0C8980120; Tue, 16 Aug 2022 16:13:32 +0200 (CEST)
Date:   Tue, 16 Aug 2022 16:13:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf/core: Fix reentry problem in
 perf_output_read_group
Message-ID: <YvumDL1qz1NjpfEC@worktop.programming.kicks-ass.net>
References: <20220816091103.257702-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816091103.257702-1-yangjihong1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:11:03PM +0800, Yang Jihong wrote:
> perf_output_read_group may respond to IPI request of other cores and invoke
> __perf_install_in_context function. As a result, hwc configuration is modified.
> As a result, the hwc configuration is modified, causing inconsistency and
> unexpected consequences.

>  read_pmevcntrn+0x1e4/0x1ec arch/arm64/kernel/perf_event.c:423
>  armv8pmu_read_evcntr arch/arm64/kernel/perf_event.c:467 [inline]
>  armv8pmu_read_hw_counter arch/arm64/kernel/perf_event.c:475 [inline]
>  armv8pmu_read_counter+0x10c/0x1f0 arch/arm64/kernel/perf_event.c:528
>  armpmu_event_update+0x9c/0x1bc drivers/perf/arm_pmu.c:247
>  armpmu_read+0x24/0x30 drivers/perf/arm_pmu.c:264
>  perf_output_read_group+0x4cc/0x71c kernel/events/core.c:6806
>  perf_output_read+0x78/0x1c4 kernel/events/core.c:6845
>  perf_output_sample+0xafc/0x1000 kernel/events/core.c:6892
>  __perf_event_output kernel/events/core.c:7273 [inline]
>  perf_event_output_forward+0xd8/0x130 kernel/events/core.c:7287
>  __perf_event_overflow+0xbc/0x20c kernel/events/core.c:8943
>  perf_swevent_overflow kernel/events/core.c:9019 [inline]
>  perf_swevent_event+0x274/0x2c0 kernel/events/core.c:9047
>  do_perf_sw_event kernel/events/core.c:9160 [inline]
>  ___perf_sw_event+0x150/0x1b4 kernel/events/core.c:9191
>  __perf_sw_event+0x58/0x7c kernel/events/core.c:9203
>  perf_sw_event include/linux/perf_event.h:1177 [inline]

> Interrupts is not disabled when perf_output_read_group reads PMU counter.

s/is/are/ due to 'interrupts' being plural

Anyway, yes, I suppose this is indeed so. That code expects to run with
IRQs disabled but in the case of software events that isn't so.

> In this case, IPI request may be received from other cores.
> As a result, PMU configuration is modified and an error occurs when
> reading PMU counter:
> 
>                    CPU0                                         CPU1
>                                                     __se_sys_perf_event_open
>                                                       perf_install_in_context
> perf_output_read_group                                  smp_call_function_single
>   for_each_sibling_event(sub, leader) {                   generic_exec_single
>     if ((sub != event) &&                                   remote_function
>         (sub->state == PERF_EVENT_STATE_ACTIVE))                    |
> <enter IPI handler: __perf_install_in_context>   <----RAISE IPI-----+
> __perf_install_in_context
>   ctx_resched
>     event_sched_out
>       armpmu_del
>         ...
>         hwc->idx = -1; // event->hwc.idx is set to -1
> ...
> <exit IPI>
>             sub->pmu->read(sub);
>               armpmu_read
>                 armv8pmu_read_counter
>                   armv8pmu_read_hw_counter
>                     int idx = event->hw.idx; // idx = -1
>                     u64 val = armv8pmu_read_evcntr(idx);
>                       u32 counter = ARMV8_IDX_TO_COUNTER(idx); // invalid counter = 30
>                       read_pmevcntrn(counter) // undefined instruction
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  kernel/events/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4e718b93442b..776fe24adcbd 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6895,6 +6895,13 @@ static void perf_output_read_group(struct perf_output_handle *handle,
>  	u64 read_format = event->attr.read_format;
>  	u64 values[6];
>  	int n = 0;
> +	unsigned long flags;
> +
> +	/*
> +	 * Disabling interrupts avoids all counter scheduling
> +	 * (context switches, timer based rotation and IPIs).
> +	 */
> +	local_irq_save(flags);
>  
>  	values[n++] = 1 + leader->nr_siblings;
>  
> @@ -6931,6 +6938,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
>  
>  		__output_copy(handle, values, n * sizeof(u64));
>  	}
> +
> +	local_irq_restore(flags);
>  }

Specifically I think it is for_each_sibling_event() itself that requires
the context to be stable. Perhaps we should add an assertion there as
well.

Something like so on top, I suppose.. Does that yield more problem
sites?

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ee8b9ecdc03b..d4d53b9ba71e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -631,7 +631,12 @@ struct pmu_event_list {
 	struct list_head	list;
 };
 
+/*
+ * Iterating the sibling list requires this list to be stable; by ensuring IRQs
+ * are disabled IPIs from perf_{install_in,remove_from}_context() are held off.
+ */
 #define for_each_sibling_event(sibling, event)			\
+	lockdep_assert_irqs_disabled();				\
 	if ((event)->group_leader == (event))			\
 		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
 

