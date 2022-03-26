Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19014E7F5A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 07:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiCZGYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 02:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiCZGYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 02:24:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E369143C7E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 23:23:13 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id pv16so19175454ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 23:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=37O0AYItxghfYWnKQlivNC6Xp9Toxjb2BI+nsltZzhQ=;
        b=CwUrdrvAuRf7f33Y/4O2+rR/vmPAan2Zmp0E93oVa45QdykqpaP7aWEjmCFIV8CsYB
         qeFbEh4tJXJflAcQFfKZ/3Z7dfPX7PGWShXxatZaNl8wkMal0830Z5nbbBXRoKwK6eD6
         NinlvYWoQVsbgM5wEG4AIBbkQ4m+LGNJXK4RI2E8t4hien/rt6Inqa6kiR2YiuGF/HoP
         kawb9Z5QBGfxzJOGupveCi0STAsQYFf9CvqWxjWrkuf9OQj/QueLzUnFq02WtKzw1jg+
         wHoiiSS8TbjX9lotffc/iO4jGdMlYSIdHYe4Gj9kWkPV4G0I7FI081IH6xIMIIJfm5RW
         OrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=37O0AYItxghfYWnKQlivNC6Xp9Toxjb2BI+nsltZzhQ=;
        b=o6c0oEMJKuK1RKXQPNwMWdqO9zmy3LWHvxAOufpf/M8aNsI95y6CABgDRxlPUvWpsi
         7RqV82xCmzVbGEbiqc00LbBYoe/AksSlaHRowugXw2s/baphyKp6h61ad7uyx/irUgoK
         ylZIykMA2hdS/DAUxxFjBIejWwC36AvbAKetMJOD0Pdd5EwLJB2Oo1H1jU4ZZ8A2WLwR
         SVdON8jQYHjeKLoFeGlDz2gxC7Mc1K/7pXm1B2Jly+YAXM1+IAfuSbN+ZmP2xxR2RMYq
         K5JGy+Nuzjd+Q2GeOxN0elnoj0CpTxDp1tnYG7IdE+F9o0jD0aT6qqYhZGZUc3dBKqJV
         GEQA==
X-Gm-Message-State: AOAM532HfI/SSV5HQUdYKOvlxHmSzcSKUyfKcmka1/HlNqn5St14xxvf
        ohtYtfC/yTB83mKSNsZcQBfLiw==
X-Google-Smtp-Source: ABdhPJyeJVE+VuyNNDf/Dr02K0PzUGNnNvbj4gDDnLaT8JRbsjQK4M7tbtuLGeuODzu/Ar5XlsHwuQ==
X-Received: by 2002:a17:906:b052:b0:6ce:88a5:e42a with SMTP id bj18-20020a170906b05200b006ce88a5e42amr16105124ejb.237.1648275791887;
        Fri, 25 Mar 2022 23:23:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906144b00b006cf61dfb03esm3121673ejc.62.2022.03.25.23.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 23:23:11 -0700 (PDT)
Date:   Sat, 26 Mar 2022 14:23:03 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        acme@kernel.org, benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 4/4] perf mem: Support HITM for when mem_lvl_num is any
Message-ID: <20220326062303.GC20556@leoy-ThinkPad-X240s>
References: <20220324183323.31414-1-alisaidi@amazon.com>
 <20220324183323.31414-5-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324183323.31414-5-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 06:33:23PM +0000, Ali Saidi wrote:
> For loads that hit in a the LLC snoop filter and are fulfilled from a
> higher level cache on arm64 Neoverse cores, it's not usually clear what
> the true level of the cache the data came from (i.e. a transfer from a
> core could come from it's L1 or L2). Instead of making an assumption of
> where the line came from, add support for incrementing HITM if the
> source is CACHE_ANY.
> 
> Since other architectures don't seem to populate the mem_lvl_num field
> here there shouldn't be a change in functionality.
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> Tested-by: German Gomez <german.gomez@arm.com>
> Reviewed-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/util/mem-events.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index e5e405185498..084977cfebef 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -539,6 +539,15 @@ do {				\
>  					stats->ld_llchit++;
>  			}
>  
> +			/*
> +			 * A hit in another cores cache must mean a llc snoop
> +			 * filter hit
> +			 */
> +			if (lnum == P(LVLNUM, ANY_CACHE)) {
> +				if (snoop & P(SNOOP, HITM))
> +					HITM_INC(lcl_hitm);
> +			}

This might break the memory profiling result for x86, see file
arch/x86/events/intel/ds.c:

  97 void __init intel_pmu_pebs_data_source_skl(bool pmem)
  98 {
  99         u64 pmem_or_l4 = pmem ? LEVEL(PMEM) : LEVEL(L4);
  ...
 105         pebs_data_source[0x0d] = OP_LH | LEVEL(ANY_CACHE) | REM | P(SNOOP, HITM);
 106 }

Which means that it's possible that it's a remote access and the cache
level is ANY_CACHE, it's good to add checking for bit
PERF_MEM_REMOTE_REMOTE:

	u64 remote = data_src->mem_remote;

	/*
	 * A hit in another cores cache must mean a llc snoop
	 * filter hit
	 */
	if (lnum == P(LVLNUM, ANY_CACHE) && remote != P(REMOTE, REMOTE)) {
	        if (snoop & P(SNOOP, HITM))
	                HITM_INC(lcl_hitm);
	}

Appreciate German's reviewing and testing, and sorry I jumped in very
late.

Thanks,
Leo

> +
>  			if (lvl & P(LVL, LOC_RAM) || lnum == P(LVLNUM, RAM)) {
>  				stats->lcl_dram++;
>  				if (snoop & P(SNOOP, HIT))
> -- 
> 2.32.0
> 
