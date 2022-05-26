Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD5C5351A6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiEZPtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiEZPtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:49:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85810DE310;
        Thu, 26 May 2022 08:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18588B82109;
        Thu, 26 May 2022 15:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8041EC385A9;
        Thu, 26 May 2022 15:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653580145;
        bh=c5IkqlHU0NdBzlSqhZtOY3kiyXBH/LiueJx5QwzX2zI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Igx8A/GRfxCbczJ7vUfDIg8X9fmUGbKz3MUEm84Z3qDjc7wqtZvwcA/1s7TJYyvml
         vjlBOvM3EZ89RjAqQ8EBMOSC3wBKeIDG1Wo9r+PteIUYZSb1/ZTnt/VSbwIEAk4Sjd
         9wZ17NwJvnVShT9NWD0scosvvxkt7twjJKYE1eozaR6RA5Eo1iTN8IOjuRfXVpoEE0
         UeCwqJUvPkBZfWaZpQnoQog8ApNSxkncVYK24zc5E4RoinXHtVEi20ididQCi83Bxs
         xCNU4xFDtvCQk2/7ZX/VrgBPN3wpFYLB9Qis9ogxwdXS91HPj5SnLss2KGRRx6Q6cf
         RDyxHHClp+6sA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 639814036D; Thu, 26 May 2022 12:49:03 -0300 (-03)
Date:   Thu, 26 May 2022 12:49:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     irogers@google.com, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v4 3/5] perf/x86/ibs: Add new IBS register bits into
 header
Message-ID: <Yo+hbx9c/9FoaiJN@kernel.org>
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
 <20220523033945.1612-4-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523033945.1612-4-ravi.bangoria@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 23, 2022 at 09:09:43AM +0530, Ravi Bangoria escreveu:
> IBS support has been enhanced with two new features in upcoming uarch:
> 1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
> has been introduced in IBS registers to exploit these features. Define
> these new bits into arch/x86/ header.

You mentioned the kernel bits were already applied and this was a tools
only series, this one slipped into :-)

- Arnaldo
 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Acked-by: Ian Rogers <irogers@google.com>
> ---
>  arch/x86/include/asm/amd-ibs.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
> index aabdbb5ab920..f3eb098d63d4 100644
> --- a/arch/x86/include/asm/amd-ibs.h
> +++ b/arch/x86/include/asm/amd-ibs.h
> @@ -29,7 +29,10 @@ union ibs_fetch_ctl {
>  			rand_en:1,	/* 57: random tagging enable */
>  			fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
>  					 *      (needs IbsFetchComp) */
> -			reserved:5;	/* 59-63: reserved */
> +			l3_miss_only:1,	/* 59: Collect L3 miss samples only */
> +			fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
> +			fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
> +			reserved:2;	/* 62-63: reserved */
>  	};
>  };
>  
> @@ -38,14 +41,14 @@ union ibs_op_ctl {
>  	__u64 val;
>  	struct {
>  		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
> -			reserved0:1,	/* 16: reserved */
> +			l3_miss_only:1,	/* 16: Collect L3 miss samples only */
>  			op_en:1,	/* 17: op sampling enable */
>  			op_val:1,	/* 18: op sample valid */
>  			cnt_ctl:1,	/* 19: periodic op counter control */
>  			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
> -			reserved1:5,	/* 27-31: reserved */
> +			reserved0:5,	/* 27-31: reserved */
>  			opcurcnt:27,	/* 32-58: periodic op counter current count */
> -			reserved2:5;	/* 59-63: reserved */
> +			reserved1:5;	/* 59-63: reserved */
>  	};
>  };
>  
> @@ -71,11 +74,12 @@ union ibs_op_data {
>  union ibs_op_data2 {
>  	__u64 val;
>  	struct {
> -		__u64	data_src:3,	/* 0-2: data source */
> +		__u64	data_src_lo:3,	/* 0-2: data source low */
>  			reserved0:1,	/* 3: reserved */
>  			rmt_node:1,	/* 4: destination node */
>  			cache_hit_st:1,	/* 5: cache hit state */
> -			reserved1:57;	/* 5-63: reserved */
> +			data_src_hi:2,	/* 6-7: data source high */
> +			reserved1:56;	/* 8-63: reserved */
>  	};
>  };
>  
> -- 
> 2.31.1

-- 

- Arnaldo
