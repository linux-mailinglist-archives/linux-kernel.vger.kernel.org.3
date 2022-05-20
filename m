Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8397B52ED82
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349991AbiETNuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349978AbiETNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:50:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CBE16D5C9;
        Fri, 20 May 2022 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653054604; x=1684590604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R0FZFm98x7vByR/MevvkcSjMX2gdUTL9MU/jNdFMe+k=;
  b=gVH4R873X0+TjjxGIX0kO1eufZubX5zexuOPHbUPZcqCFvRpkQOgpXuO
   eI95LWC10aweuxULnip1rFU9EK6d13p82LOb0eFsrvyxCLQniDHhCT0ZS
   3OrcHS0IQLaXDt002Bk+DksOOTHSX/zm6rXlUDsYhKcwQwpz4zxPjGDGU
   KUvKBLfy+9UeEvaA12a75E1FEhCrpGo1kQIN0HM5KX0yIlUdkF0FpD23D
   Tq2vuo2nYbEx+K3QUK9zBLVHlotWRdjONuahgmASevPzIYHy+7c8NBMVZ
   0L7LbZF6YB9ZQkhkA6DI9xc9uZ77+ibfk+NVEvRijfqkfvTGALUvH1uDJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="335667212"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="335667212"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="743504252"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 20 May 2022 06:49:46 -0700
Received: from [10.252.213.172] (kliang2-MOBL.ccr.corp.intel.com [10.252.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 06DCB58090D;
        Fri, 20 May 2022 06:49:44 -0700 (PDT)
Message-ID: <afee14e7-8585-c7cf-ba10-be1a54a5d2f4@linux.intel.com>
Date:   Fri, 20 May 2022 09:49:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] x86/events/intel/ds: Enable large PEBS for
 PERF_SAMPLE_WEIGHT_TYPE
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220519151913.80545-1-likexu@tencent.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220519151913.80545-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/2022 11:19 AM, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> All the information required by the PERF_SAMPLE_WEIGHT is
> available in the pebs record. Thus large PEBS could be enabled
> for PERF_SAMPLE_WEIGHT sample type to save PMIs overhead until
> other non-compatible flags such as PERF_SAMPLE_DATA_PAGE_SIZE
> (due to lack of munmap tracking) stop it.
> 
> To cover new weight extension, add PERF_SAMPLE_WEIGHT_TYPE
> to the guardian LARGE_PEBS_FLAGS.
> 
> Tested it with:
> 
> $ perf mem record -c 1000 workload
> Before: Captured and wrote 0.126 MB perf.data (958 samples) [958 PMIs]
> After: Captured and wrote 0.313 MB perf.data (4859 samples) [3 PMIs]
> 
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Reported-by: Yongchao Duan <yongduan@tencent.com>
> Signed-off-by: Like Xu <likexu@tencent.com>


Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
> v1: https://lore.kernel.org/lkml/20220519104509.51847-1-likexu@tencent.com/
> v1 -> v2 Changelog:
> - Use the PERF_SAMPLE_WEIGHT_TYPE instead (Kan);
> 
>   arch/x86/events/perf_event.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 21a5482bcf84..1ca6200ca135 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -136,7 +136,8 @@ struct amd_nb {
>   	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
>   	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
>   	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
> -	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE)
> +	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE | \
> +	PERF_SAMPLE_WEIGHT_TYPE)
>   
>   #define PEBS_GP_REGS			\
>   	((1ULL << PERF_REG_X86_AX)    | \
