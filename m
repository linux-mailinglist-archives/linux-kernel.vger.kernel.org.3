Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AEF47D1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbhLVMhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhLVMg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:36:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C496C061574;
        Wed, 22 Dec 2021 04:36:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2339FB81C44;
        Wed, 22 Dec 2021 12:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF05EC36AE8;
        Wed, 22 Dec 2021 12:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640176615;
        bh=qGl8dUD8CJWsNsQWAUSoBTpV2v/CDrYNgJo4cg1vapM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GY70V05Ou21b3HPsS6FkVNh1AdjRnP7ZgxsaRp9EnTrqbKW6B9XBbmPilVMw8Id+3
         jOA4LaFiz0x+5IUKkf/UKFpm1g7BbE9jl96i50PWj/2gp5OZwlWGT0647JLYsalHgx
         Y5x62AahXIlrUOTKBKR4kWp9cSTox/7kdQG1UhHsLCRVBaA5KJG07cUPHmUZ+ulktX
         yry0SJm76Oj94QSNdDDaKTz+aRAijivpXn6s2Y0e0XRhhocH0H6gAbO5kOZqDv5BLU
         UNMmCiB5J/OrnVRGVjGd78kYvhRkvmJy20QovxDNHKAfCyWa+llrkP/TxEGSEFyC1j
         ebucyUoBzhbTQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36DA340B92; Wed, 22 Dec 2021 09:36:53 -0300 (-03)
Date:   Wed, 22 Dec 2021 09:36:53 -0300
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
Subject: Re: [PATCH 2/4] tools/perf: Add new macros for mem_hops field
Message-ID: <YcMb5bUOW8BYw9fP@kernel.org>
References: <20211206091749.87585-1-kjain@linux.ibm.com>
 <20211206091749.87585-3-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206091749.87585-3-kjain@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 06, 2021 at 02:47:47PM +0530, Kajol Jain escreveu:
> Add new macros for mem_hops field which can be used to
> represent remote-node, socket and board level details.
> 
> Currently the code had macro for HOPS_0 which, corresponds
> to data coming from another core but same node.
> Add new macros for HOPS_1 to HOPS_3 to represent
> remote-node, socket and board level data.
> 
> Also add corresponding strings in the mem_hops array to
> represent mem_hop field data in perf_mem__lvl_scnprintf function
> 
> Incase mem_hops field is used, PERF_MEM_LVLNUM field also need
> to be set inorder to represent the data source. Hence printing
> data source via PERF_MEM_LVL field can be skip in that scenario.
> 
> For ex: Encodings for mem_hops fields with L2 cache:

Thanks, applied.

- Arnaldo

 
> L2                      - local L2
> L2 | REMOTE | HOPS_0    - remote core, same node L2
> L2 | REMOTE | HOPS_1    - remote node, same socket L2
> L2 | REMOTE | HOPS_2    - remote socket, same board L2
> L2 | REMOTE | HOPS_3    - remote board L2
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/include/uapi/linux/perf_event.h |  5 ++++-
>  tools/perf/util/mem-events.c          | 29 +++++++++++++++++----------
>  2 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index bd8860eeb291..4cd39aaccbe7 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -1332,7 +1332,10 @@ union perf_mem_data_src {
>  
>  /* hop level */
>  #define PERF_MEM_HOPS_0		0x01 /* remote core, same node */
> -/* 2-7 available */
> +#define PERF_MEM_HOPS_1         0x02 /* remote node, same socket */
> +#define PERF_MEM_HOPS_2         0x03 /* remote socket, same board */
> +#define PERF_MEM_HOPS_3         0x04 /* remote board */
> +/* 5-7 available */
>  #define PERF_MEM_HOPS_SHIFT	43
>  
>  #define PERF_MEM_S(a, s) \
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 3167b4628b6d..ed0ab838bcc5 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -309,6 +309,9 @@ static const char * const mem_hops[] = {
>  	 * to be set with mem_hops field.
>  	 */
>  	"core, same node",
> +	"node, same socket",
> +	"socket, same board",
> +	"board",
>  };
>  
>  int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
> @@ -316,7 +319,7 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
>  	size_t i, l = 0;
>  	u64 m =  PERF_MEM_LVL_NA;
>  	u64 hit, miss;
> -	int printed;
> +	int printed = 0;
>  
>  	if (mem_info)
>  		m  = mem_info->data_src.mem_lvl;
> @@ -335,18 +338,22 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
>  		l += 7;
>  	}
>  
> -	if (mem_info && mem_info->data_src.mem_hops)
> +	/*
> +	 * Incase mem_hops field is set, we can skip printing data source via
> +	 * PERF_MEM_LVL namespace.
> +	 */
> +	if (mem_info && mem_info->data_src.mem_hops) {
>  		l += scnprintf(out + l, sz - l, "%s ", mem_hops[mem_info->data_src.mem_hops]);
> -
> -	printed = 0;
> -	for (i = 0; m && i < ARRAY_SIZE(mem_lvl); i++, m >>= 1) {
> -		if (!(m & 0x1))
> -			continue;
> -		if (printed++) {
> -			strcat(out, " or ");
> -			l += 4;
> +	} else {
> +		for (i = 0; m && i < ARRAY_SIZE(mem_lvl); i++, m >>= 1) {
> +			if (!(m & 0x1))
> +				continue;
> +			if (printed++) {
> +				strcat(out, " or ");
> +				l += 4;
> +			}
> +			l += scnprintf(out + l, sz - l, mem_lvl[i]);
>  		}
> -		l += scnprintf(out + l, sz - l, mem_lvl[i]);
>  	}
>  
>  	if (mem_info && mem_info->data_src.mem_lvl_num) {
> -- 
> 2.27.0

-- 

- Arnaldo
