Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308F747D214
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbhLVMlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:41:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36424 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245195AbhLVMlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1300561844;
        Wed, 22 Dec 2021 12:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F08C36AE5;
        Wed, 22 Dec 2021 12:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640176883;
        bh=C+xfOCVJ4pREcm2vRALjvsvHcgdWEthAsNXkbnYp6s4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6CGQ8Ip80Aq/o+RnyQiz7PZnj8cq2MRDmBKrW5I47gkyyvO2zPq3NTlWX9V1M/O+
         tN6c7NBTggIOxs/bd4mrmZy8Fg12FD/GGn0bWTlhsh6ItPugI4Ecy56MKsKPpZm17L
         qcy08Zcd203UQ/yphHxUT/UqgQWR1q/UEBtNjkBbbjsuBmn8F2hMoELbEeLGD5jAGc
         RKUzb5qF8zEl4jBf6njdEUmRw9uSQuXvx5zZfsJmhDNu3JBqFqkEa11SPH14zk3hOJ
         bK0ExDXHYTgJqJBS7/fHUKrlPYBGGQEawfpOWaW29G01Qz/aS5mHpdoAJrJsNv9uXI
         U+BthusFVza6w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9AC6740B92; Wed, 22 Dec 2021 09:41:21 -0300 (-03)
Date:   Wed, 22 Dec 2021 09:41:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        ak@linux.intel.com, linux-perf-users@vger.kernel.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, yao.jin@linux.intel.com, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        kan.liang@linux.intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, paulus@samba.org
Subject: Re: [PATCH 4/4] powerpc/perf: Add data source encodings for power10
 platform
Message-ID: <YcMc8fnIsbHxbX6i@kernel.org>
References: <20211206091749.87585-1-kjain@linux.ibm.com>
 <20211206091749.87585-5-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206091749.87585-5-kjain@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 06, 2021 at 02:47:49PM +0530, Kajol Jain escreveu:
> The code represent memory/cache level data based on PERF_MEM_LVL_*
> namespace, which is in the process of deprication in the favour of
> newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_,HOPS_} fields.
> Add data source encodings to represent cache/memory data based on
> newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_,HOPS_} fields.

Thanks, applied.

- Arnaldo

 
> Add data source encodings to represent data coming from local
> memory/Remote memory/distant memory and remote/distant cache hits.
> 
> Inorder to represent data coming from OpenCAPI cache/memory, we use
> LVLNUM "PMEM" field which is used to present persistent memory accesses.
> 
> Result in power10 system with patch changes:
> 
> localhost:# ./perf mem report --sort="mem,sym,dso" --stdio
>  # Overhead       Samples  Memory access             Symbol                      Shared Object
>  # ........  ............  ........................  ..........................  ................
>  #
>     29.46%          2331  L1 or L1 hit              [.] __random                                     libc-2.28.so
>     23.11%          2121  L1 or L1 hit              [.] producer_populate_cache                      producer_consumer
>     18.56%          1758  L1 or L1 hit              [.] __random_r                                   libc-2.28.so
>     15.64%          1559  L2 or L2 hit              [.] __random                                     libc-2.28.so
>     .....
>     0.09%              5  Remote socket, same board Any cache hit             [.] __random         libc-2.28.so
>     0.07%              4  Remote socket, same board Any cache hit             [.] __random         libc-2.28.so
>     .....
> 
> Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  arch/powerpc/perf/isa207-common.c | 54 ++++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
> index 6c6bc8b7d887..4037ea652522 100644
> --- a/arch/powerpc/perf/isa207-common.c
> +++ b/arch/powerpc/perf/isa207-common.c
> @@ -229,13 +229,28 @@ static inline u64 isa207_find_source(u64 idx, u32 sub_idx)
>  		ret = PH(LVL, L3) | LEVEL(L3) | P(SNOOP, HIT);
>  		break;
>  	case 4:
> -		if (sub_idx <= 1)
> -			ret = PH(LVL, LOC_RAM);
> -		else if (sub_idx > 1 && sub_idx <= 2)
> -			ret = PH(LVL, REM_RAM1);
> -		else
> -			ret = PH(LVL, REM_RAM2);
> -		ret |= P(SNOOP, HIT);
> +		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
> +			ret = P(SNOOP, HIT);
> +
> +			if (sub_idx == 1)
> +				ret |= PH(LVL, LOC_RAM) | LEVEL(RAM);
> +			else if (sub_idx == 2 || sub_idx == 3)
> +				ret |= P(LVL, HIT) | LEVEL(PMEM);
> +			else if (sub_idx == 4)
> +				ret |= PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
> +			else if (sub_idx == 5 || sub_idx == 7)
> +				ret |= P(LVL, HIT) | LEVEL(PMEM) | REM;
> +			else if (sub_idx == 6)
> +				ret |= PH(LVL, REM_RAM2) | REM | LEVEL(RAM) | P(HOPS, 3);
> +		} else {
> +			if (sub_idx <= 1)
> +				ret = PH(LVL, LOC_RAM);
> +			else if (sub_idx > 1 && sub_idx <= 2)
> +				ret = PH(LVL, REM_RAM1);
> +			else
> +				ret = PH(LVL, REM_RAM2);
> +			ret |= P(SNOOP, HIT);
> +		}
>  		break;
>  	case 5:
>  		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
> @@ -261,11 +276,26 @@ static inline u64 isa207_find_source(u64 idx, u32 sub_idx)
>  		}
>  		break;
>  	case 6:
> -		ret = PH(LVL, REM_CCE2);
> -		if ((sub_idx == 0) || (sub_idx == 2))
> -			ret |= P(SNOOP, HIT);
> -		else if ((sub_idx == 1) || (sub_idx == 3))
> -			ret |= P(SNOOP, HITM);
> +		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
> +			if (sub_idx == 0)
> +				ret = PH(LVL, REM_CCE1) | LEVEL(ANY_CACHE) | REM |
> +					P(SNOOP, HIT) | P(HOPS, 2);
> +			else if (sub_idx == 1)
> +				ret = PH(LVL, REM_CCE1) | LEVEL(ANY_CACHE) | REM |
> +					P(SNOOP, HITM) | P(HOPS, 2);
> +			else if (sub_idx == 2)
> +				ret = PH(LVL, REM_CCE2) | LEVEL(ANY_CACHE) | REM |
> +					P(SNOOP, HIT) | P(HOPS, 3);
> +			else if (sub_idx == 3)
> +				ret = PH(LVL, REM_CCE2) | LEVEL(ANY_CACHE) | REM |
> +					P(SNOOP, HITM) | P(HOPS, 3);
> +		} else {
> +			ret = PH(LVL, REM_CCE2);
> +			if (sub_idx == 0 || sub_idx == 2)
> +				ret |= P(SNOOP, HIT);
> +			else if (sub_idx == 1 || sub_idx == 3)
> +				ret |= P(SNOOP, HITM);
> +		}
>  		break;
>  	case 7:
>  		ret = PM(LVL, L1);
> -- 
> 2.27.0

-- 

- Arnaldo
