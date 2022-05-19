Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D556E52D5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbiESO0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239718AbiESO0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:26:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6714D8CCE1;
        Thu, 19 May 2022 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652970404; x=1684506404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vrvSpCTHwXUKlmp7hYVYANHROdiTM5iBEhCiatmkrqc=;
  b=VYquGtHcwnP0Ln1gTsYP+v4Vk08bwLhnL8Ij+nYQ/VCxBTyk7jJ342OH
   Z9hSO9e4cwzvrhACY11MgUV0dXAwcqV6KXqEsGYToLrdcNcKqMIpTudfO
   nAnl903r+Wrgt6UgtHGt1c68y7nFi12LSfDE5kHd7AUISKhLgm2TSBcmS
   sCoOdgt5av0ZVm3B2/KnMSSoV5LXT9YNjt4goPCRgZF6ZLUcMTjHnITxu
   XPGD9Mui9PiNP0jGLirU4QYYQ7mb5u75apolYdf0HZdXJLVwlLU4TzjD4
   FaN5vAzjDEwMEgN4lKAK/SiSylq6qKF2wMjRwUrQbdzRBx8Jk4NsvBupX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272350943"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="272350943"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 07:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="606510939"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 19 May 2022 07:26:43 -0700
Received: from [10.252.213.148] (kliang2-MOBL.ccr.corp.intel.com [10.252.213.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 50C1E5802E4;
        Thu, 19 May 2022 07:26:42 -0700 (PDT)
Message-ID: <67ef14e6-e7ef-5071-3351-7a264c46f172@linux.intel.com>
Date:   Thu, 19 May 2022 10:26:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] x86/events/intel/ds: Enable large PEBS for
 PERF_SAMPLE_WEIGHT type
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
References: <20220519104509.51847-1-likexu@tencent.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220519104509.51847-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/2022 6:45 AM, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Large PEBS could be enabled for the generic PERF_SAMPLE_WEIGHT sample

I think all the information required by the PERF_SAMPLE_WEIGHT is 
available in the pebs record. It should be OK to enable it for the large 
PEBS.

Can you please use the PERF_SAMPLE_WEIGHT_TYPE instead? It includes the 
new weight extension.

Thanks,
Kan

> type until other non-compatible flags such as PERF_SAMPLE_DATA_PAGE_SIZE
> (due to lack of munmap tracking) finally stop it.
> 
> Add PERF_SAMPLE_WEIGHT to LARGE_PEBS_FLAGS to save PMIs overhead.
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
> ---
>   arch/x86/events/perf_event.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 21a5482bcf84..1ed0970d67e6 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -136,7 +136,8 @@ struct amd_nb {
>   	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
>   	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
>   	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
> -	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE)
> +	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE | \
> +	PERF_SAMPLE_WEIGHT)
>   
>   #define PEBS_GP_REGS			\
>   	((1ULL << PERF_REG_X86_AX)    | \
