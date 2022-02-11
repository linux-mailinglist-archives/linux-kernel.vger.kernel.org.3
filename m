Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316634B313D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 00:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354111AbiBKXZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 18:25:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbiBKXZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:25:48 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B4CCEC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 15:25:46 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id r14so10440538qtt.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 15:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AkaXQoFxwn0/khOSjRC2q3Y3fd34t3tph8KPfwo641c=;
        b=kNIaWXtSWTlAKI4hyHfp71KohkJdUf6IaAdX6DwGGbvKE236cH1SM1djQE2J/eCRxs
         EVB/jm950qdH9v/7uwe2N8v4+NUOOuHkhmhNYHwwK0AFhhxXYwthKzqFop+YrrpkBsdy
         ubLW2ER2PE5AgLkFXRZHrnkuC4KygOcqov0CY79LaeOrtC6ku5Gl5//RaOLac0Aq6IoP
         PP3NtvwdnNZH50tdgfMydPqWZdWamhkSIVXWrF2J+m1LLibas5oeyDFRPJrSvDSLzb4o
         6KPpNVsBpKVnZgEDkTFaId5yjokqJGZyH3GMIFcowebfAVaANBSyb+4/q4+HmIxsjSkZ
         AS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AkaXQoFxwn0/khOSjRC2q3Y3fd34t3tph8KPfwo641c=;
        b=QJfaTpcW04mEvlwdXzVmbZhvM3PEQ+SdOPAKMLUuix++vlFBQ1K3B3BwG69QEbHcXg
         4CCoGhHiGncN0bKLs88nXG6FNprv1vmojT3haMIibhPKC+Sw/GG7/g+vrdig58mEcrFc
         12cVD4DB7ZHMA7Smp9FzlJZ9Ckzr9k0bEw2Xr2YNTc7JHi4OTqsDOrXIpNY81U86KA4l
         8Hjjs0Sqw+nrarhFkxaQgMmNmZJsk9r5jaYE0rgQVZmK5scxLfoW65wqJfg7oogAijj/
         9IG3IzTS6tyqrUnKfAcbjPV3n46F9art9mnmwuas9Cd8YxxOTtQAuZlis9Zv9pDPQt+P
         EzOg==
X-Gm-Message-State: AOAM531rtXNMYaizKc5zZd7MOXzlegvSF+kwzeju5gcYSo3LBDtWuNpy
        nFajmwoXSFby9r3zwA1nops=
X-Google-Smtp-Source: ABdhPJyFzcgELy84WYMZSmBiAa4X1NysnkXTwSCk03WUFieOG7ESblv56MD4loBUme2IiU6yGc9r0Q==
X-Received: by 2002:ac8:5753:: with SMTP id 19mr2846723qtx.667.1644621944862;
        Fri, 11 Feb 2022 15:25:44 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id bi11sm11594029qkb.18.2022.02.11.15.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 15:25:44 -0800 (PST)
Date:   Fri, 11 Feb 2022 15:23:30 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Qi Liu <liuqi115@huawei.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/49] perf: replace bitmap_weight with bitmap_empty
 where appropriate
Message-ID: <Ygbv8p5Q/X3NJXqf@yury-laptop>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-13-yury.norov@gmail.com>
 <2b67edce-c45e-c602-6e79-d1e148d57eca@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b67edce-c45e-c602-6e79-d1e148d57eca@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 06:27:56PM +0100, Christophe JAILLET wrote:
> Le 10/02/2022 à 23:48, Yury Norov a écrit :
> > In some places, drivers/perf code calls bitmap_weight() to check if any
> > bit of a given bitmap is set. It's better to use bitmap_empty() in that
> > case because bitmap_empty() stops traversing the bitmap as soon as it
> > finds first set bit, while bitmap_weight() counts all bits unconditionally.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >   drivers/perf/arm-cci.c                   | 2 +-
> >   drivers/perf/arm_pmu.c                   | 4 ++--
> >   drivers/perf/hisilicon/hisi_uncore_pmu.c | 2 +-
> >   drivers/perf/xgene_pmu.c                 | 2 +-
> >   4 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> > index 54aca3a62814..96e09fa40909 100644
> > --- a/drivers/perf/arm-cci.c
> > +++ b/drivers/perf/arm-cci.c
> > @@ -1096,7 +1096,7 @@ static void cci_pmu_enable(struct pmu *pmu)
> >   {
> >   	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
> >   	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
> > -	int enabled = bitmap_weight(hw_events->used_mask, cci_pmu->num_cntrs);
> > +	bool enabled = !bitmap_empty(hw_events->used_mask, cci_pmu->num_cntrs);
> >   	unsigned long flags;
> >   	if (!enabled)
> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index 295cc7952d0e..a31b302b0ade 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -524,7 +524,7 @@ static void armpmu_enable(struct pmu *pmu)
> >   {
> >   	struct arm_pmu *armpmu = to_arm_pmu(pmu);
> >   	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
> > -	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
> > +	bool enabled = !bitmap_empty(hw_events->used_mask, armpmu->num_events);
> >   	/* For task-bound events we may be called on other CPUs */
> >   	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
> > @@ -785,7 +785,7 @@ static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
> >   {
> >   	struct arm_pmu *armpmu = container_of(b, struct arm_pmu, cpu_pm_nb);
> >   	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
> > -	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
> > +	bool enabled = !bitmap_empty(hw_events->used_mask, armpmu->num_events);
> >   	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
> >   		return NOTIFY_DONE;
> > diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > index a738aeab5c04..358e4e284a62 100644
> > --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > @@ -393,7 +393,7 @@ EXPORT_SYMBOL_GPL(hisi_uncore_pmu_read);
> >   void hisi_uncore_pmu_enable(struct pmu *pmu)
> >   {
> >   	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
> > -	int enabled = bitmap_weight(hisi_pmu->pmu_events.used_mask,
> > +	bool enabled = !bitmap_empty(hisi_pmu->pmu_events.used_mask,
> >   				    hisi_pmu->num_counters);
> >   	if (!enabled)
> > diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> > index 5283608dc055..0c32dffc7ede 100644
> > --- a/drivers/perf/xgene_pmu.c
> > +++ b/drivers/perf/xgene_pmu.c
> > @@ -867,7 +867,7 @@ static void xgene_perf_pmu_enable(struct pmu *pmu)
> >   {
> >   	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(pmu);
> >   	struct xgene_pmu *xgene_pmu = pmu_dev->parent;
> > -	int enabled = bitmap_weight(pmu_dev->cntr_assign_mask,
> > +	bool enabled = !bitmap_empty(pmu_dev->cntr_assign_mask,
> >   			pmu_dev->max_counters);
> 
> Would it make sense to call it 'disabled', remove the "!"...
> 
> >   	if (!enabled)
> ... and 'if (disabled)' here?

People like positive names (as I do):
        $ git grep bool | grep "= \!" | grep -v "= \!\!" | wc -l
        334

And probably authors chose positive name in this case for a reason.

Replacing 'enabled' with 'disabled' just to avoid negation will add
absolutely nothing to performance, neither to readability. But noise
level of this and other patches will increase - just for nothing.

For me it sounds like total negative commitment.

Thanks,
Yury
