Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5524B2310
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348882AbiBKKZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:25:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbiBKKZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:25:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62289E5A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:25:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04150106F;
        Fri, 11 Feb 2022 02:25:40 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C2803F73B;
        Fri, 11 Feb 2022 02:25:34 -0800 (PST)
Date:   Fri, 11 Feb 2022 10:25:23 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yury Norov <yury.norov@gmail.com>, Will Deacon <will@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Qi Liu <liuqi115@huawei.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/49] perf: replace bitmap_weight with bitmap_empty
 where appropriate
Message-ID: <YgY5k0tNy7zztpMk@FVFF77S0Q05N>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-13-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224933.379149-13-yury.norov@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

On Thu, Feb 10, 2022 at 02:48:56PM -0800, Yury Norov wrote:
> In some places, drivers/perf code calls bitmap_weight() to check if any
> bit of a given bitmap is set. It's better to use bitmap_empty() in that
> case because bitmap_empty() stops traversing the bitmap as soon as it
> finds first set bit, while bitmap_weight() counts all bits unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

This looks like a nice semantic cleanup to me, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

How are you expecting to queue all of this? Should Will and I pick this patch?

Thanks,
Mark.

> ---
>  drivers/perf/arm-cci.c                   | 2 +-
>  drivers/perf/arm_pmu.c                   | 4 ++--
>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 2 +-
>  drivers/perf/xgene_pmu.c                 | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> index 54aca3a62814..96e09fa40909 100644
> --- a/drivers/perf/arm-cci.c
> +++ b/drivers/perf/arm-cci.c
> @@ -1096,7 +1096,7 @@ static void cci_pmu_enable(struct pmu *pmu)
>  {
>  	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
>  	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
> -	int enabled = bitmap_weight(hw_events->used_mask, cci_pmu->num_cntrs);
> +	bool enabled = !bitmap_empty(hw_events->used_mask, cci_pmu->num_cntrs);
>  	unsigned long flags;
>  
>  	if (!enabled)
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 295cc7952d0e..a31b302b0ade 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -524,7 +524,7 @@ static void armpmu_enable(struct pmu *pmu)
>  {
>  	struct arm_pmu *armpmu = to_arm_pmu(pmu);
>  	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
> -	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
> +	bool enabled = !bitmap_empty(hw_events->used_mask, armpmu->num_events);
>  
>  	/* For task-bound events we may be called on other CPUs */
>  	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
> @@ -785,7 +785,7 @@ static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
>  {
>  	struct arm_pmu *armpmu = container_of(b, struct arm_pmu, cpu_pm_nb);
>  	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
> -	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
> +	bool enabled = !bitmap_empty(hw_events->used_mask, armpmu->num_events);
>  
>  	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
>  		return NOTIFY_DONE;
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index a738aeab5c04..358e4e284a62 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -393,7 +393,7 @@ EXPORT_SYMBOL_GPL(hisi_uncore_pmu_read);
>  void hisi_uncore_pmu_enable(struct pmu *pmu)
>  {
>  	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
> -	int enabled = bitmap_weight(hisi_pmu->pmu_events.used_mask,
> +	bool enabled = !bitmap_empty(hisi_pmu->pmu_events.used_mask,
>  				    hisi_pmu->num_counters);
>  
>  	if (!enabled)
> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> index 5283608dc055..0c32dffc7ede 100644
> --- a/drivers/perf/xgene_pmu.c
> +++ b/drivers/perf/xgene_pmu.c
> @@ -867,7 +867,7 @@ static void xgene_perf_pmu_enable(struct pmu *pmu)
>  {
>  	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(pmu);
>  	struct xgene_pmu *xgene_pmu = pmu_dev->parent;
> -	int enabled = bitmap_weight(pmu_dev->cntr_assign_mask,
> +	bool enabled = !bitmap_empty(pmu_dev->cntr_assign_mask,
>  			pmu_dev->max_counters);
>  
>  	if (!enabled)
> -- 
> 2.32.0
> 
