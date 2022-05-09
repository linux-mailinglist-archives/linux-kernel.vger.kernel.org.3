Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727CA51FEAF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbiEINtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiEINtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:49:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE68282007;
        Mon,  9 May 2022 06:45:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so26888604ejj.10;
        Mon, 09 May 2022 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S0MYAt5Uz0+jdQBjPszRQXCEkUP9LumEFXQicaBB5y8=;
        b=fIVIrp+CYbFPWUUPtB6IkRWYvAezF7zB2cz56pGnLEVV0YSQIrJVe+FD9kscs2zV+l
         NnW8VHzfZN1/HG29A0RwJRP6W7ZQ5d/ygzRk06xoTixSd4O2euQOJHXmFr7a7EiNRTe2
         WW6vs00GQrRxl0YJvXjDZeKaRinj5MEHYhG4yCln+R3ZtfxEJuWdZazpBPXxqTzWeLZ8
         wJTKajwqBGg9X3Ym/vWsawxok5l/io3h+RR5EwAZ0dok/rGHuX26GW/YTiPLzIlwoKxd
         4bl1juyhsk3ykaiPU2EFqfAyIhiXEmcL3ipc3E+ac3iTZYYHhmR/scqXwFk1MOnF7amL
         34Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S0MYAt5Uz0+jdQBjPszRQXCEkUP9LumEFXQicaBB5y8=;
        b=vcZgYqhnVLT6W5BuX8/jxadw3sELnTKMnvdvmYfXMa5ox8K3+VBGTX4irlfYeG3pkF
         GYEToPmthvD7yYQhIgjcKts4y42w1Dhs/q8NHkvYrMKPzHeqF/eNur0v4pTrDPQRnwBq
         R3WmOFFQNKhUi/JrO8DE+Ix4pirpA65tEusNJTW0dLKM17Ik4Wik30ruUXqnJL5jk1DT
         lJ6k/BmzPEZfzKc2BrHcgQKEEUCfBrmvUCdWUC/f7inV1dAPCoKtrYKudsPdhfIi3OQO
         WrvmuJlS5FqTjSQP7bvJvDW8m2+0kg+rI6QPkv/K4ehZsb8Bpm+66lRsJVqbMD+g9jcq
         zRwg==
X-Gm-Message-State: AOAM533A9XeXrXdfegfWoMF/zjdZ7l3Qcw2O+/+frMAeQVM61tEEOQ2d
        HStgNbxDqecAGGe+ts3EMyQ=
X-Google-Smtp-Source: ABdhPJwGhslM3KCUKIYrG5PJG5WXmMCjEGBVG4TLuh1Smqig6VeeOHWiFEES2H1Vz96XcYwP3O9SqA==
X-Received: by 2002:a17:906:478f:b0:6f3:d0b7:b254 with SMTP id cw15-20020a170906478f00b006f3d0b7b254mr14547911ejc.562.1652103909527;
        Mon, 09 May 2022 06:45:09 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id rb48-20020a170907693000b006f3ef214e10sm5109802ejc.118.2022.05.09.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 06:45:08 -0700 (PDT)
Date:   Mon, 9 May 2022 15:45:06 +0200
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Chengdong Li <brytonlee01@gmail.com>
Cc:     alexey.v.bayduraev@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, rickyman7@gmail.com, adrian.hunter@intel.com,
        irogers@google.com, german.gomez@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, likexu@tencent.com, chengdongli@tencent.com
Subject: Re: [PATCH] perf tools: fix callstack entries and nr print message
Message-ID: <Ynka4u+jCvFefgwJ@krava>
References: <20220509114743.22668-1-chengdongli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509114743.22668-1-chengdongli@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 07:47:43PM +0800, Chengdong Li wrote:
> From: Chengdong Li <chengdongli@tencent.com>
> 
> when generating callstack information from branch_stack(Intel LBR),
> the actual number of callstack entry should be bigger than the number
> of branch_stack, for example:
> 
> 	branch_stack records:
> 		B() -> C()
> 		A() -> B()
> 	converted callstack records should be:
> 		C()
> 		B()
> 		A()
> though, the number of callstack equals
> to the number of branch stack plus 1.
> 
> This patch fix above issue in branch_stack__printf(). For example,
> 
> 	# echo 'scale=2000; 4*a(1)' > cmd
> 	# perf record --call-graph lbr bc -l < cmd
> 
> Before applying this patch, `perf script -D` output:
> 
> 	1220022677386876 0x2a40 [0xd8]: PERF_RECORD_SAMPLE(IP, 0x4002): 17990/17990: 0x40a6d6 period: 894172 addr: 0
> 	... LBR call chain: nr:8
> 	.....  0: fffffffffffffe00
> 	.....  1: 000000000040a410
> 	.....  2: 000000000040573c
> 	.....  3: 0000000000408650
> 	.....  4: 00000000004022f2
> 	.....  5: 00000000004015f5
> 	.....  6: 00007f5ed6dcb553
> 	.....  7: 0000000000401698
> 	... FP chain: nr:2
> 	.....  0: fffffffffffffe00
> 	.....  1: 000000000040a6d8
> 	... branch callstack: nr:6    # which is not consistent with LBR records.
> 	.....  0: 000000000040a410
> 	.....  1: 0000000000408650    # ditto
> 	.....  2: 00000000004022f2
> 	.....  3: 00000000004015f5
> 	.....  4: 00007f5ed6dcb553
> 	.....  5: 0000000000401698
> 	 ... thread: bc:17990
> 	 ...... dso: /usr/bin/bc
> 	bc 17990 1220022.677386:     894172 cycles:
> 			  40a410 [unknown] (/usr/bin/bc)
> 			  40573c [unknown] (/usr/bin/bc)
> 			  408650 [unknown] (/usr/bin/bc)
> 			  4022f2 [unknown] (/usr/bin/bc)
> 			  4015f5 [unknown] (/usr/bin/bc)
> 		    7f5ed6dcb553 __libc_start_main+0xf3 (/usr/lib64/libc-2.17.so)
> 			  401698 [unknown] (/usr/bin/bc)
> 
> After applied:
> 
> 	1220022677386876 0x2a40 [0xd8]: PERF_RECORD_SAMPLE(IP, 0x4002): 17990/17990: 0x40a6d6 period: 894172 addr: 0
> 	... LBR call chain: nr:8
> 	.....  0: fffffffffffffe00
> 	.....  1: 000000000040a410
> 	.....  2: 000000000040573c
> 	.....  3: 0000000000408650
> 	.....  4: 00000000004022f2
> 	.....  5: 00000000004015f5
> 	.....  6: 00007f5ed6dcb553
> 	.....  7: 0000000000401698
> 	... FP chain: nr:2
> 	.....  0: fffffffffffffe00
> 	.....  1: 000000000040a6d8
> 	... branch callstack: nr:7
> 	.....  0: 000000000040a410
> 	.....  1: 000000000040573c
> 	.....  2: 0000000000408650
> 	.....  3: 00000000004022f2
> 	.....  4: 00000000004015f5
> 	.....  5: 00007f5ed6dcb553
> 	.....  6: 0000000000401698
> 	 ... thread: bc:17990
> 	 ...... dso: /usr/bin/bc
> 	bc 17990 1220022.677386:     894172 cycles:
> 			  40a410 [unknown] (/usr/bin/bc)
> 			  40573c [unknown] (/usr/bin/bc)
> 			  408650 [unknown] (/usr/bin/bc)
> 			  4022f2 [unknown] (/usr/bin/bc)
> 			  4015f5 [unknown] (/usr/bin/bc)
> 		    7f5ed6dcb553 __libc_start_main+0xf3 (/usr/lib64/libc-2.17.so)
> 			  401698 [unknown] (/usr/bin/bc)
> 
> Signed-off-by: Chengdong Li <chengdongli@tencent.com>
> ---
>  tools/perf/util/session.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index f9a320694b85..568a1db98686 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1151,9 +1151,19 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
>  	struct branch_entry *entries = perf_sample__branch_entries(sample);
>  	uint64_t i;
>  
> -	printf("%s: nr:%" PRIu64 "\n",
> -		!callstack ? "... branch stack" : "... branch callstack",
> -		sample->branch_stack->nr);
> +	if (!callstack)
> +		printf("%s: nr:%" PRIu64 "\n", "... branch stack", sample->branch_stack->nr);
> +	else
> +		/* the reason of adding 1 to nr is because after expanding
> +		 * branch stack it generates nr + 1 callstack records. e.g.,
> +		 *         B()->C()
> +		 *         A()->B()
> +		 * the final callstack should be:
> +		 *         C()
> +		 *         B()
> +		 *         A()
> +		 */
> +		printf("%s: nr:%" PRIu64 "\n", "... branch callstack", sample->branch_stack->nr+1);

please use { }

>  
>  	for (i = 0; i < sample->branch_stack->nr; i++) {
>  		struct branch_entry *e = &entries[i];
> @@ -1169,8 +1179,12 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
>  				(unsigned)e->flags.reserved,
>  				e->flags.type ? branch_type_name(e->flags.type) : "");
>  		} else {
> -			printf("..... %2"PRIu64": %016" PRIx64 "\n",
> -				i, i > 0 ? e->from : e->to);
> +			if (i == 0)
> +				printf("..... %2"PRIu64": %016" PRIx64 "\n"
> +				       "..... %2"PRIu64": %016" PRIx64 "\n",
> +						i, e->to, i+1, e->from);
> +			else
> +				printf("..... %2"PRIu64": %016" PRIx64 "\n", i+1, e->from);

same here

thanks,
jirka
