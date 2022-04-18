Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3736C505B16
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbiDRPeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344955AbiDRPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:32:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4909B1CFCC;
        Mon, 18 Apr 2022 07:45:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFFABB80EE2;
        Mon, 18 Apr 2022 14:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685AAC385A1;
        Mon, 18 Apr 2022 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650293111;
        bh=bwDtdOcxFEg3of0+KlnHrcTKor1wUFoYgoCQfH/aBoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T58AVRL98CdvNCIg4SIQNxARSuTxoq84rZ9dqodI3o/q/u+13DDV4DGUXg0gA4PX7
         cxI7JhL4ieRtecI6IdK+UKwhxwAXYSxw5lrDaZv+Nc1GPC9wMGqt6c1r7Cq+HNcU+w
         bej50tKUC4fKf+EmXCjFzqoBSnr4AiDr0NbDVGE3HxapPEzxL5uXqlbuIzWvBmAERP
         8X1aTvnWsirrINOqnWdQS1SeTd2apsP4HwHfKBmBrnXyQ6RbzGtq7qLQ8Hfm0uaY9i
         7ugV/w1EhM3O6xt2FqQbhWs6PVPrNoa024siTNhPdDEnljbc2RtngfAwtXKsmhHi2F
         PuLj7NSxGLEiQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EF68240407; Mon, 18 Apr 2022 11:45:07 -0300 (-03)
Date:   Mon, 18 Apr 2022 11:45:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf mem: Print memory operation type
Message-ID: <Yl15c78idxjn3sKb@kernel.org>
References: <20220417124524.901148-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417124524.901148-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 17, 2022 at 08:45:24PM +0800, Leo Yan escreveu:
> The memory operation types are not only for load and store, for easier
> reviewing the memory operation type, this patch prints out it.
> 
> Before:
>   ls 14753 [011]  3678.072400:          1      l1d-miss:         88000182 L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
>   ls 14753 [011]  3678.072400:          1    l1d-access:         88000182 L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
>   ls 14753 [011]  3678.072400:          1    tlb-access:         88000182 L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
>   ls 14753 [011]  3678.072400:          1        memory:         88000182 L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
> 
> After:
> 
>   ls 14753 [011]  3678.072400:          1      l1d-miss:         88000182 |OP LOAD|LVL L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
>   ls 14753 [011]  3678.072400:          1    l1d-access:         88000182 |OP LOAD|LVL L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
>   ls 14753 [011]  3678.072400:          1    tlb-access:         88000182 |OP LOAD|LVL L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
>   ls 14753 [011]  3678.072400:          1        memory:         88000182 |OP LOAD|LVL L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])

Thanks, applied to perf/core.

- Arnaldo

 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/mem-events.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index e5e405185498..f8f234251f92 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -314,6 +314,30 @@ static const char * const mem_hops[] = {
>  	"board",
>  };
>  
> +static int perf_mem__op_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
> +{
> +	u64 op = PERF_MEM_LOCK_NA;
> +	int l;
> +
> +	if (mem_info)
> +		op = mem_info->data_src.mem_op;
> +
> +	if (op & PERF_MEM_OP_NA)
> +		l = scnprintf(out, sz, "N/A");
> +	else if (op & PERF_MEM_OP_LOAD)
> +		l = scnprintf(out, sz, "LOAD");
> +	else if (op & PERF_MEM_OP_STORE)
> +		l = scnprintf(out, sz, "STORE");
> +	else if (op & PERF_MEM_OP_PFETCH)
> +		l = scnprintf(out, sz, "PFETCH");
> +	else if (op & PERF_MEM_OP_EXEC)
> +		l = scnprintf(out, sz, "EXEC");
> +	else
> +		l = scnprintf(out, sz, "No");
> +
> +	return l;
> +}
> +
>  int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
>  {
>  	size_t i, l = 0;
> @@ -466,7 +490,10 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, struct mem_info *mem_in
>  {
>  	int i = 0;
>  
> -	i += perf_mem__lvl_scnprintf(out, sz, mem_info);
> +	i += scnprintf(out, sz, "|OP ");
> +	i += perf_mem__op_scnprintf(out + i, sz - i, mem_info);
> +	i += scnprintf(out + i, sz - i, "|LVL ");
> +	i += perf_mem__lvl_scnprintf(out + i, sz, mem_info);
>  	i += scnprintf(out + i, sz - i, "|SNP ");
>  	i += perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
>  	i += scnprintf(out + i, sz - i, "|TLB ");
> -- 
> 2.25.1

-- 

- Arnaldo
