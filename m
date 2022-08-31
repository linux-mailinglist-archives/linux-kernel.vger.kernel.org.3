Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412F05A892E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiHaWrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHaWrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:47:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D2FD91D3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:47:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y29so11752094pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=ewsSFc3VBmfrXazWUAFpkrMVBqjVwKkUXHSjKQHsSWs=;
        b=VSQaT72CA47hYaCdNOl+mSf8qXr1VQ+JzjyPzPO+ilDBXcVRz67tEyPGR0rPKknvFY
         Attu6aG+y2FhdRUWJHjqEn3VSQcGVuZwSiYiagVVN2DTExketuskaklYU/xIBJ/XBqi+
         5kdzXZmkxX0phGdSUjfXV4wqjVId8q+JuVFqMIAiCTkoxWO5/Il4HSui6B+pN98H8i2t
         Ak+pPrQLm+l1+Jq60A14TOYUxqzMnWs97KOmqdikwXYoRT6tsM4E1uM/VDweIIjcq4yj
         PWn+bDhT99ALNqE9NDJYoZGMN+MuGn65Vbzd9XueHib1w1TXjO0NJLEK27ttW11vR7Nu
         FGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ewsSFc3VBmfrXazWUAFpkrMVBqjVwKkUXHSjKQHsSWs=;
        b=sKth0/fVEZ75Ck46ffAzikEiwuND2ctD6gbQD1wJYHniKfxIXt3hjAcKGGhMSfbHhn
         /qpfnyVQaMYZp887F1xyZTaDfe9niQaV8TRAP04PUPHNwlwlECaZQezs1CxShj+nE+cf
         VCri80NjdAygVBT3VXztYcgOD4jx05BZEoRlykZOlqqbFQk2/aQzQdhQlNLI+oBq7Fqo
         qOwjABI+QOEyGcuTm4tGGsf50uCOcCnUSFyxKl+eo4nG62LoTHeRxsAfDIVh26+L/jFF
         P41AFySV+yYCS0Wzu2bfX61AWkJkOMP9nrz9U4IZKX9+4ulKcAAx5p+9Odcqwdwo2Xbc
         ke6Q==
X-Gm-Message-State: ACgBeo0e4o1Bw5aaH3LN+b/R/Qz4TTWfFovvdk2sxkvoOpcVCMW6lu5w
        MNwJfnaZydlx8kuNg+R38ms=
X-Google-Smtp-Source: AA6agR4vFaDhJgcdjGFCOQ/FvcTVuG3gPZurUUnrgWtwXkZbCRhdgkojZLiSmNo4bbpE6sdTh/vIHA==
X-Received: by 2002:a62:168a:0:b0:535:ff3d:b68d with SMTP id 132-20020a62168a000000b00535ff3db68dmr28252565pfw.86.1661986036375;
        Wed, 31 Aug 2022 15:47:16 -0700 (PDT)
Received: from google.com ([2620:15c:2d4:203:4a6a:d1f4:9cf7:d0fb])
        by smtp.gmail.com with ESMTPSA id b11-20020aa78ecb000000b0053abbad37a4sm2039269pfr.123.2022.08.31.15.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 15:47:15 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Wed, 31 Aug 2022 15:47:13 -0700
From:   Namhyung Kim <namhyung@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        andreas.kogler.0x@gmail.com, atrajeev@linux.vnet.ibm.com,
        ravi.bangoria@amd.com
Subject: Re: [PATCH 3/6] perf: Use sample_flags for branch stack
Message-ID: <Yw/k8eyxJD+my0ea@google.com>
References: <20220831145514.190514-1-kan.liang@linux.intel.com>
 <20220831145514.190514-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220831145514.190514-4-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 07:55:11AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Use the new sample_flags to indicate whether the branch stack is filled
> by the PMU driver.
> 
> Remove the br_stack from the perf_sample_data_init() to minimize the number
> of cache lines touched.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/powerpc/perf/core-book3s.c | 1 +
>  arch/x86/events/core.c          | 4 +++-
>  arch/x86/events/intel/core.c    | 4 +++-
>  arch/x86/events/intel/ds.c      | 5 ++++-
>  include/linux/perf_event.h      | 4 ++--
>  kernel/events/core.c            | 4 ++--
>  6 files changed, 15 insertions(+), 7 deletions(-)

Looks like you need to update AMD LBR code in amd_pmu_v2_handle_irq().

Thanks,
Namhyung

> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 13919eb96931..1ad1efdb33f9 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2297,6 +2297,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
>  			cpuhw = this_cpu_ptr(&cpu_hw_events);
>  			power_pmu_bhrb_read(event, cpuhw);
>  			data.br_stack = &cpuhw->bhrb_stack;
> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
>  		}
>  
>  		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index f969410d0c90..bb34a28fa71b 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1714,8 +1714,10 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>  
>  		perf_sample_data_init(&data, 0, event->hw.last_period);
>  
> -		if (has_branch_stack(event))
> +		if (has_branch_stack(event)) {
>  			data.br_stack = &cpuc->lbr_stack;
> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
> +		}
>  
>  		if (perf_event_overflow(event, &data, regs))
>  			x86_pmu_stop(event, 0);
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 4fce2bdbbf87..36f95894dd1c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3004,8 +3004,10 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  
>  		perf_sample_data_init(&data, 0, event->hw.last_period);
>  
> -		if (has_branch_stack(event))
> +		if (has_branch_stack(event)) {
>  			data.br_stack = &cpuc->lbr_stack;
> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
> +		}
>  
>  		if (perf_event_overflow(event, &data, regs))
>  			x86_pmu_stop(event, 0);
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 3af24c4891fb..d5f3007af59d 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1645,8 +1645,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>  		data->sample_flags |= PERF_SAMPLE_TIME;
>  	}
>  
> -	if (has_branch_stack(event))
> +	if (has_branch_stack(event)) {
>  		data->br_stack = &cpuc->lbr_stack;
> +		data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
> +	}
>  }
>  
>  static void adaptive_pebs_save_regs(struct pt_regs *regs,
> @@ -1796,6 +1798,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>  		if (has_branch_stack(event)) {
>  			intel_pmu_store_pebs_lbrs(lbr);
>  			data->br_stack = &cpuc->lbr_stack;
> +			data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
>  		}
>  	}
>  
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index b0ebbb1377b9..2aec1765b3d5 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1010,7 +1010,6 @@ struct perf_sample_data {
>  	u64				sample_flags;
>  	u64				addr;
>  	struct perf_raw_record		*raw;
> -	struct perf_branch_stack	*br_stack;
>  	u64				period;
>  	union perf_sample_weight	weight;
>  	u64				txn;
> @@ -1020,6 +1019,8 @@ struct perf_sample_data {
>  	 * The other fields, optionally {set,used} by
>  	 * perf_{prepare,output}_sample().
>  	 */
> +	struct perf_branch_stack	*br_stack;
> +
>  	u64				type;
>  	u64				ip;
>  	struct {
> @@ -1060,7 +1061,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
>  	data->sample_flags = 0;
>  	data->addr = addr;
>  	data->raw  = NULL;
> -	data->br_stack = NULL;
>  	data->period = period;
>  	data->weight.full = 0;
>  	data->data_src.val = PERF_MEM_NA;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c9b9cb79231a..104c0c9f4e6f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7052,7 +7052,7 @@ void perf_output_sample(struct perf_output_handle *handle,
>  	}
>  
>  	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> -		if (data->br_stack) {
> +		if (data->sample_flags & PERF_SAMPLE_BRANCH_STACK) {
>  			size_t size;
>  
>  			size = data->br_stack->nr
> @@ -7358,7 +7358,7 @@ void perf_prepare_sample(struct perf_event_header *header,
>  
>  	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
>  		int size = sizeof(u64); /* nr */
> -		if (data->br_stack) {
> +		if (data->sample_flags & PERF_SAMPLE_BRANCH_STACK) {
>  			if (perf_sample_save_hw_index(event))
>  				size += sizeof(u64);
>  
> -- 
> 2.35.1
> 
> 
