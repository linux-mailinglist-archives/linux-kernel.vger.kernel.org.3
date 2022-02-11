Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989AB4B2C56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiBKSCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:02:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352442AbiBKSCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:02:02 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CB62C9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:02:01 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id d188so12365276iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WuU98BQWJ3JvxA0l3dqFEtp2hO3xbYQYBGFwDoum9mA=;
        b=IQQa84bdtaXRSdyR/rpKt0SgnPXBqmxmJhh+I01uwaxqxWu4ojcAKkL5xNw2hhBGl0
         SqAcTIwGJOKoKuNltCzgv257aZj9Vr99QBpN7fDwSCfVrlHje/fQNIOKoT2Oaziq8EXi
         hkg4zp1Ee8VavOB4GljXvcV5lpnMc4zLiaQNUHF7HdGtilmw7DZd+3t0qKZgd5a2HdpH
         BakB8fh/e/dFXB9ddZuAAmTUp44pbvrS24H8kEGWZ/eS+JxRgohZIyxGzmv6OnwEinWq
         gyu2ZbJDXNO8o/ygp6HsRMRkWmTYq9HG8fLk2PoQbf5hE34N7V6vcspEXm8Qk3ExjvaJ
         +tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WuU98BQWJ3JvxA0l3dqFEtp2hO3xbYQYBGFwDoum9mA=;
        b=Nsr8XBnyqBenJvbkWRzEKj79v3ah3qCFFC/SGYeV87lR1HMy44wNYqPxske30pdPHv
         Bl7wDYUT75PX393XF5gFu+b4jd9ltIFEUWuz/T5b29BlerA23s+HvoBWNctapEKY6ZQe
         5x31C0RNUl15p3QhMe/QS+yYKC48NkLxoyigKBAeGU2LjOhr5uJxKoQ5hmaeoOHeOFFx
         C97ymDoa4Ua9Xwk/OTmCU3ST1o2xt4xJNwiwJunhDNJxQ+j4owl6DUJwtXAMujPHzcWo
         UB609unNdg4B6luLaASuHdmrY4fEahBn5yIVkANzN0pvcApGIVlWXaCgXaEw02IlRif/
         1+4g==
X-Gm-Message-State: AOAM532epJvmlA4QcqeBDx4JrQ7I4bvJdUJTuu4Fd7+IlCgiPn8PD7L1
        Kq6G4opxqy2PYYERw06ttHE=
X-Google-Smtp-Source: ABdhPJxJmxFpXOYmnUs8JwVDIPbLVn5DtmHoImtfp1nRCsmQ3PoW8zuCBCZu/2oyU1rR5Wa33NzJlQ==
X-Received: by 2002:a6b:ef06:: with SMTP id k6mr1445483ioh.70.1644602520515;
        Fri, 11 Feb 2022 10:02:00 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id m1sm13808221ilu.87.2022.02.11.10.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 10:02:00 -0800 (PST)
Date:   Fri, 11 Feb 2022 09:59:49 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <YgakFfT4qczOdSfP@yury-laptop>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-13-yury.norov@gmail.com>
 <YgY5k0tNy7zztpMk@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgY5k0tNy7zztpMk@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 10:25:23AM +0000, Mark Rutland wrote:
> Hi Yury,
> 
> On Thu, Feb 10, 2022 at 02:48:56PM -0800, Yury Norov wrote:
> > In some places, drivers/perf code calls bitmap_weight() to check if any
> > bit of a given bitmap is set. It's better to use bitmap_empty() in that
> > case because bitmap_empty() stops traversing the bitmap as soon as it
> > finds first set bit, while bitmap_weight() counts all bits unconditionally.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> 
> This looks like a nice semantic cleanup to me, so FWIW:

Thanks :)
 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> How are you expecting to queue all of this?

I expect maintainers of corresponding subsystems will pick most of the
material. For the rest, I have my own bitmap branch.

> Should Will and I pick this patch?

Yes please.

> Thanks,
> Mark.
> 
> > ---
> >  drivers/perf/arm-cci.c                   | 2 +-
> >  drivers/perf/arm_pmu.c                   | 4 ++--
> >  drivers/perf/hisilicon/hisi_uncore_pmu.c | 2 +-
> >  drivers/perf/xgene_pmu.c                 | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> > index 54aca3a62814..96e09fa40909 100644
> > --- a/drivers/perf/arm-cci.c
> > +++ b/drivers/perf/arm-cci.c
> > @@ -1096,7 +1096,7 @@ static void cci_pmu_enable(struct pmu *pmu)
> >  {
> >  	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
> >  	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
> > -	int enabled = bitmap_weight(hw_events->used_mask, cci_pmu->num_cntrs);
> > +	bool enabled = !bitmap_empty(hw_events->used_mask, cci_pmu->num_cntrs);
> >  	unsigned long flags;
> >  
> >  	if (!enabled)
> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index 295cc7952d0e..a31b302b0ade 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -524,7 +524,7 @@ static void armpmu_enable(struct pmu *pmu)
> >  {
> >  	struct arm_pmu *armpmu = to_arm_pmu(pmu);
> >  	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
> > -	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
> > +	bool enabled = !bitmap_empty(hw_events->used_mask, armpmu->num_events);
> >  
> >  	/* For task-bound events we may be called on other CPUs */
> >  	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
> > @@ -785,7 +785,7 @@ static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
> >  {
> >  	struct arm_pmu *armpmu = container_of(b, struct arm_pmu, cpu_pm_nb);
> >  	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
> > -	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
> > +	bool enabled = !bitmap_empty(hw_events->used_mask, armpmu->num_events);
> >  
> >  	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
> >  		return NOTIFY_DONE;
> > diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > index a738aeab5c04..358e4e284a62 100644
> > --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > @@ -393,7 +393,7 @@ EXPORT_SYMBOL_GPL(hisi_uncore_pmu_read);
> >  void hisi_uncore_pmu_enable(struct pmu *pmu)
> >  {
> >  	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
> > -	int enabled = bitmap_weight(hisi_pmu->pmu_events.used_mask,
> > +	bool enabled = !bitmap_empty(hisi_pmu->pmu_events.used_mask,
> >  				    hisi_pmu->num_counters);
> >  
> >  	if (!enabled)
> > diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> > index 5283608dc055..0c32dffc7ede 100644
> > --- a/drivers/perf/xgene_pmu.c
> > +++ b/drivers/perf/xgene_pmu.c
> > @@ -867,7 +867,7 @@ static void xgene_perf_pmu_enable(struct pmu *pmu)
> >  {
> >  	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(pmu);
> >  	struct xgene_pmu *xgene_pmu = pmu_dev->parent;
> > -	int enabled = bitmap_weight(pmu_dev->cntr_assign_mask,
> > +	bool enabled = !bitmap_empty(pmu_dev->cntr_assign_mask,
> >  			pmu_dev->max_counters);
> >  
> >  	if (!enabled)
> > -- 
> > 2.32.0
> > 
