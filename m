Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D5850FA94
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348841AbiDZKdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348808AbiDZKaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:30:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DFCEDB50;
        Tue, 26 Apr 2022 03:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gl1gHbDUo7lTz2ZfpQgLhkdMuBK7nhPRxt/EDLeMc7k=; b=MRxtqzR2ciPl+7PgV511KoXRHd
        lMdFk44jhEmKVk2PBTJf0z8HO6nNaUZGearlJu4XKgM/rvxzHgQYk1XX5ioetlZy01tFwlSxOmgjE
        PEDcBg5cNoC9OXwrIs1cvjtx7Swp/GotK04YJn57NujG3iVrBsqM0SS8Mckwi0Cr8hmP3UY9TFHUd
        MjC87to64sKQo2g4FQ3nAxDa+uuocpr8hGqO2eFlQe17A5OEQ3KWF/YpdvNLLErXL63i0nEyKUhqM
        rwHC1D+pGtbb21VGal6kVe3RUw72iC8L2nRYTy/W8fHsI+CIF3rOCXxOruIy5siWc7WI61mKAiixC
        kRg1D1yA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njI69-009XAa-Tg; Tue, 26 Apr 2022 10:07:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87D579819FC; Tue, 26 Apr 2022 12:07:07 +0200 (CEST)
Date:   Tue, 26 Apr 2022 12:07:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, irogers@google.com, yao.jin@linux.intel.com,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com, rrichter@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH 1/6] perf/amd/ibs: Add support for L3 miss filtering
Message-ID: <20220426100707.GP2731@worktop.programming.kicks-ass.net>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425044323.2830-2-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425044323.2830-2-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:13:18AM +0530, Ravi Bangoria wrote:
> IBS L3 miss filtering works by tagging an instruction on IBS counter
> overflow and generating an NMI if the tagged instruction causes an L3
> miss. Samples without an L3 miss are discarded and counter is reset
> with random value (between 1-15 for fetch pmu and 1-127 for op pmu).
> This helps in reducing sampling overhead when user is interested only
> in such samples. One of the use case of such filtered samples is to
> feed data to page-migration daemon in tiered memory systems.
> 
> Add support for L3 miss filtering in IBS driver via new pmu attribute
> "l3missonly". Example usage:
> 
>   # perf record -a -e ibs_op/l3missonly=1/ --raw-samples sleep 5
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c         | 42 ++++++++++++++++++++++---------
>  arch/x86/include/asm/perf_event.h |  3 +++
>  2 files changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 9739019d4b67..a5303d62060c 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -520,16 +520,12 @@ static void perf_ibs_read(struct perf_event *event) { }
>  
>  PMU_FORMAT_ATTR(rand_en,	"config:57");
>  PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
> +PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
> +PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
>  
> -static struct attribute *ibs_fetch_format_attrs[] = {
> -	&format_attr_rand_en.attr,
> -	NULL,
> -};
> -
> -static struct attribute *ibs_op_format_attrs[] = {
> -	NULL,	/* &format_attr_cnt_ctl.attr if IBS_CAPS_OPCNT */
> -	NULL,
> -};
> +/* size = nr attrs plus NULL at the end */
> +static struct attribute *ibs_fetch_format_attrs[3];
> +static struct attribute *ibs_op_format_attrs[3];
>  
>  static struct perf_ibs perf_ibs_fetch = {
>  	.pmu = {
> @@ -759,9 +755,9 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
>  	return ret;
>  }
>  
> -static __init void perf_event_ibs_init(void)
> +static __init void perf_ibs_fetch_prepare(void)
>  {
> -	struct attribute **attr = ibs_op_format_attrs;
> +	struct attribute **format_attrs = perf_ibs_fetch.format_attrs;
>  
>  	/*
>  	 * Some chips fail to reset the fetch count when it is written; instead
> @@ -773,11 +769,22 @@ static __init void perf_event_ibs_init(void)
>  	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
>  		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
>  
> +	*format_attrs++ = &format_attr_rand_en.attr;
> +	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
> +		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
> +		*format_attrs++ = &fetch_l3missonly.attr.attr;
> +	}
> +
>  	perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
> +}
> +
> +static __init void perf_ibs_op_prepare(void)
> +{
> +	struct attribute **format_attrs = perf_ibs_op.format_attrs;
>  
>  	if (ibs_caps & IBS_CAPS_OPCNT) {
>  		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
> -		*attr++ = &format_attr_cnt_ctl.attr;
> +		*format_attrs++ = &format_attr_cnt_ctl.attr;
>  	}
>  
>  	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
> @@ -786,7 +793,18 @@ static __init void perf_event_ibs_init(void)
>  		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
>  	}
>  
> +	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
> +		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
> +		*format_attrs++ = &op_l3missonly.attr.attr;
> +	}
> +
>  	perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
> +}

Right, so Greg told us to stop doing silly things like this and use
.is_visible, also see commits like:

  b7c9b3927337 ("perf/x86/intel: Use ->is_visible callback for default group")

There's quite a bit of that in the intel driver and some in the x86
core code too. Please have a look.
