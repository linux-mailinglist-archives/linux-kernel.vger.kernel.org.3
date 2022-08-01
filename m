Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F846586AF7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiHAMj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiHAMjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA377E002;
        Mon,  1 Aug 2022 05:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFE906102A;
        Mon,  1 Aug 2022 12:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE70C43142;
        Mon,  1 Aug 2022 12:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659356279;
        bh=fwQmGYNAwnwhmTNS6sohSMaV1Xzon+6Fu2cbg6wDZdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gj2vL+hWAQcyAOIPJ422UhRsPi++CbwD9SLnTploLfWmwSuUSq5hWQAET7Jll5zGS
         KZE7IfkxppcrHgDenW4WAyK2Uh69jPPcrTNVdu1+QBM3eJRm7Pcf6717Wneqd/zi2u
         t1f3VkVa9+qp6orCRk4Na6GGrRWeaI1iO0mfhVo53i4APrGAndJX78vcZqPuBF/GFT
         mbBPqAfx0292gWntUJNBZyl9ErXrv2Nfo+xH5NTYgypd2eGiy7IoGxzQsrsbxCuqJk
         u3OXjskuRwgEC1Fb5U8ZqkymqOXnixNLCFPiUYbA3fjkAFVQQrZG/h0zjyR3cIvizg
         J3R9UFRSluLAg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B0F5B40736; Mon,  1 Aug 2022 09:17:55 -0300 (-03)
Date:   Mon, 1 Aug 2022 09:17:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 1/3] perf: Align user space counter reading with code
Message-ID: <YufEc1i32OOa+6u8@kernel.org>
References: <20220719223946.176299-1-irogers@google.com>
 <20220719223946.176299-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719223946.176299-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 19, 2022 at 03:39:44PM -0700, Ian Rogers escreveu:
> Align the user space counter reading documentation with the code in
> perf_mmap__read_self. Previously the documentation was based on the perf
> rdpmc test, but now general purpose code is provided by libperf.

Peter, can you merge this so as not to make Linus raise eyebrows with me
processing things outside tools/perf/ when asking him to pull perf
userspace?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/uapi/linux/perf_event.h       | 35 +++++++++++++++++----------
>  tools/include/uapi/linux/perf_event.h | 35 +++++++++++++++++----------
>  2 files changed, 44 insertions(+), 26 deletions(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index d37629dbad72..6826dabb7e03 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -538,9 +538,13 @@ struct perf_event_mmap_page {
>  	 *
>  	 *     if (pc->cap_usr_time && enabled != running) {
>  	 *       cyc = rdtsc();
> -	 *       time_offset = pc->time_offset;
>  	 *       time_mult   = pc->time_mult;
>  	 *       time_shift  = pc->time_shift;
> +	 *       time_offset = pc->time_offset;
> +	 *       if (pc->cap_user_time_short) {
> +	 *         time_cycles = pc->time_cycles;
> +	 *         time_mask = pc->time_mask;
> +	 *       }
>  	 *     }
>  	 *
>  	 *     index = pc->index;
> @@ -548,6 +552,9 @@ struct perf_event_mmap_page {
>  	 *     if (pc->cap_user_rdpmc && index) {
>  	 *       width = pc->pmc_width;
>  	 *       pmc = rdpmc(index - 1);
> +	 *       pmc <<= 64 - width;
> +	 *       pmc >>= 64 - width;
> +	 *       count += pmc;
>  	 *     }
>  	 *
>  	 *     barrier();
> @@ -590,25 +597,27 @@ struct perf_event_mmap_page {
>  	 * If cap_usr_time the below fields can be used to compute the time
>  	 * delta since time_enabled (in ns) using rdtsc or similar.
>  	 *
> -	 *   u64 quot, rem;
> -	 *   u64 delta;
> -	 *
> -	 *   quot = (cyc >> time_shift);
> -	 *   rem = cyc & (((u64)1 << time_shift) - 1);
> -	 *   delta = time_offset + quot * time_mult +
> -	 *              ((rem * time_mult) >> time_shift);
> +	 *   cyc = time_cycles + ((cyc - time_cycles) & time_mask);
> +	 *   delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
>  	 *
>  	 * Where time_offset,time_mult,time_shift and cyc are read in the
> -	 * seqcount loop described above. This delta can then be added to
> -	 * enabled and possible running (if index), improving the scaling:
> +	 * seqcount loop described above. mul_u64_u32_shr will compute:
> +	 *
> +	 *   (u64)(((unsigned __int128)cyc * time_mult) >> time_shift)
> +	 *
> +	 * This delta can then be added to enabled and possible running (if
> +	 * index) to improve the scaling. Due to event multiplexing, running
> +	 * may be zero and so care is needed to avoid division by zero.
>  	 *
>  	 *   enabled += delta;
>  	 *   if (index)
>  	 *     running += delta;
>  	 *
> -	 *   quot = count / running;
> -	 *   rem  = count % running;
> -	 *   count = quot * enabled + (rem * enabled) / running;
> +	 *   if (running != 0) {
> +	 *     quot = count / running;
> +	 *     rem  = count % running;
> +	 *     count = quot * enabled + (rem * enabled) / running;
> +	 *   }
>  	 */
>  	__u16	time_shift;
>  	__u32	time_mult;
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index d37629dbad72..6826dabb7e03 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -538,9 +538,13 @@ struct perf_event_mmap_page {
>  	 *
>  	 *     if (pc->cap_usr_time && enabled != running) {
>  	 *       cyc = rdtsc();
> -	 *       time_offset = pc->time_offset;
>  	 *       time_mult   = pc->time_mult;
>  	 *       time_shift  = pc->time_shift;
> +	 *       time_offset = pc->time_offset;
> +	 *       if (pc->cap_user_time_short) {
> +	 *         time_cycles = pc->time_cycles;
> +	 *         time_mask = pc->time_mask;
> +	 *       }
>  	 *     }
>  	 *
>  	 *     index = pc->index;
> @@ -548,6 +552,9 @@ struct perf_event_mmap_page {
>  	 *     if (pc->cap_user_rdpmc && index) {
>  	 *       width = pc->pmc_width;
>  	 *       pmc = rdpmc(index - 1);
> +	 *       pmc <<= 64 - width;
> +	 *       pmc >>= 64 - width;
> +	 *       count += pmc;
>  	 *     }
>  	 *
>  	 *     barrier();
> @@ -590,25 +597,27 @@ struct perf_event_mmap_page {
>  	 * If cap_usr_time the below fields can be used to compute the time
>  	 * delta since time_enabled (in ns) using rdtsc or similar.
>  	 *
> -	 *   u64 quot, rem;
> -	 *   u64 delta;
> -	 *
> -	 *   quot = (cyc >> time_shift);
> -	 *   rem = cyc & (((u64)1 << time_shift) - 1);
> -	 *   delta = time_offset + quot * time_mult +
> -	 *              ((rem * time_mult) >> time_shift);
> +	 *   cyc = time_cycles + ((cyc - time_cycles) & time_mask);
> +	 *   delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
>  	 *
>  	 * Where time_offset,time_mult,time_shift and cyc are read in the
> -	 * seqcount loop described above. This delta can then be added to
> -	 * enabled and possible running (if index), improving the scaling:
> +	 * seqcount loop described above. mul_u64_u32_shr will compute:
> +	 *
> +	 *   (u64)(((unsigned __int128)cyc * time_mult) >> time_shift)
> +	 *
> +	 * This delta can then be added to enabled and possible running (if
> +	 * index) to improve the scaling. Due to event multiplexing, running
> +	 * may be zero and so care is needed to avoid division by zero.
>  	 *
>  	 *   enabled += delta;
>  	 *   if (index)
>  	 *     running += delta;
>  	 *
> -	 *   quot = count / running;
> -	 *   rem  = count % running;
> -	 *   count = quot * enabled + (rem * enabled) / running;
> +	 *   if (running != 0) {
> +	 *     quot = count / running;
> +	 *     rem  = count % running;
> +	 *     count = quot * enabled + (rem * enabled) / running;
> +	 *   }
>  	 */
>  	__u16	time_shift;
>  	__u32	time_mult;
> -- 
> 2.37.0.170.g444d1eabd0-goog

-- 

- Arnaldo
