Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A094B2BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352151AbiBKR2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:28:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352122AbiBKR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:28:08 -0500
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E1B2BF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:28:07 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id IZi8niEgMeHnVIZi8nZeqD; Fri, 11 Feb 2022 18:28:05 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 11 Feb 2022 18:28:05 +0100
X-ME-IP: 90.126.236.122
Message-ID: <2b67edce-c45e-c602-6e79-d1e148d57eca@wanadoo.fr>
Date:   Fri, 11 Feb 2022 18:27:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 12/49] perf: replace bitmap_weight with bitmap_empty where
 appropriate
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Qi Liu <liuqi115@huawei.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-13-yury.norov@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220210224933.379149-13-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/02/2022 à 23:48, Yury Norov a écrit :
> In some places, drivers/perf code calls bitmap_weight() to check if any
> bit of a given bitmap is set. It's better to use bitmap_empty() in that
> case because bitmap_empty() stops traversing the bitmap as soon as it
> finds first set bit, while bitmap_weight() counts all bits unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>   drivers/perf/arm-cci.c                   | 2 +-
>   drivers/perf/arm_pmu.c                   | 4 ++--
>   drivers/perf/hisilicon/hisi_uncore_pmu.c | 2 +-
>   drivers/perf/xgene_pmu.c                 | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> index 54aca3a62814..96e09fa40909 100644
> --- a/drivers/perf/arm-cci.c
> +++ b/drivers/perf/arm-cci.c
> @@ -1096,7 +1096,7 @@ static void cci_pmu_enable(struct pmu *pmu)
>   {
>   	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
>   	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
> -	int enabled = bitmap_weight(hw_events->used_mask, cci_pmu->num_cntrs);
> +	bool enabled = !bitmap_empty(hw_events->used_mask, cci_pmu->num_cntrs);
>   	unsigned long flags;
>   
>   	if (!enabled)
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 295cc7952d0e..a31b302b0ade 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -524,7 +524,7 @@ static void armpmu_enable(struct pmu *pmu)
>   {
>   	struct arm_pmu *armpmu = to_arm_pmu(pmu);
>   	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
> -	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
> +	bool enabled = !bitmap_empty(hw_events->used_mask, armpmu->num_events);
>   
>   	/* For task-bound events we may be called on other CPUs */
>   	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
> @@ -785,7 +785,7 @@ static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
>   {
>   	struct arm_pmu *armpmu = container_of(b, struct arm_pmu, cpu_pm_nb);
>   	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
> -	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
> +	bool enabled = !bitmap_empty(hw_events->used_mask, armpmu->num_events);
>   
>   	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
>   		return NOTIFY_DONE;
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index a738aeab5c04..358e4e284a62 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -393,7 +393,7 @@ EXPORT_SYMBOL_GPL(hisi_uncore_pmu_read);
>   void hisi_uncore_pmu_enable(struct pmu *pmu)
>   {
>   	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
> -	int enabled = bitmap_weight(hisi_pmu->pmu_events.used_mask,
> +	bool enabled = !bitmap_empty(hisi_pmu->pmu_events.used_mask,
>   				    hisi_pmu->num_counters);
>   
>   	if (!enabled)
> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> index 5283608dc055..0c32dffc7ede 100644
> --- a/drivers/perf/xgene_pmu.c
> +++ b/drivers/perf/xgene_pmu.c
> @@ -867,7 +867,7 @@ static void xgene_perf_pmu_enable(struct pmu *pmu)
>   {
>   	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(pmu);
>   	struct xgene_pmu *xgene_pmu = pmu_dev->parent;
> -	int enabled = bitmap_weight(pmu_dev->cntr_assign_mask,
> +	bool enabled = !bitmap_empty(pmu_dev->cntr_assign_mask,
>   			pmu_dev->max_counters);

Would it make sense to call it 'disabled', remove the "!"...

>   
>   	if (!enabled)
... and 'if (disabled)' here?

Just my 2c,

CJ
