Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3514F4E76CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376341AbiCYPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377315AbiCYPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:14:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86529F53;
        Fri, 25 Mar 2022 08:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648221091; x=1679757091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9uyMwR8DOJr4uAYvr5QXiUFJVCNv0WP45q4Cbd6UBCI=;
  b=lnzE7v4HEnj9dFlMWQT8e4xtvbFFMuQhQwKQ/ihVG75C2sM/vFhzUUoC
   lGFebkpPiSmfj/s760XPdq7ctMmt2TbLRBnTx6CvVLehK9N+MLXyFHPoR
   3rWag+J1OHEFCsfCPxUpOCHXkg/dIjr6OPzODOs4PiABGQFg8vavpHm9l
   B3twk9/T2OBaaf6RHqgEC9U487leD/3W1VhGmPxBlXxjfE5AOTIHL/raY
   QUbGLlC/jk3MpfLCGk5j5JUVZ+6TM/rfm3U4e+lxZdeDuRCUvoV/m9ocf
   +SgHp1ezqGDgcnV11ERTDmYv7wPrm8fdo6hAxb6VilcCW++9G0PrIi5HK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="283522801"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="283522801"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 08:11:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="545111184"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2022 08:11:31 -0700
Received: from [10.209.4.108] (kliang2-MOBL.ccr.corp.intel.com [10.209.4.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D20755807D2;
        Fri, 25 Mar 2022 08:11:29 -0700 (PDT)
Message-ID: <a1d1389f-b1f3-cd34-ccef-0657fc1fa4f4@linux.intel.com>
Date:   Fri, 25 Mar 2022 11:11:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/5] perf/core: Don't need event_filter_match in
 merge_sched_in()
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220325035318.42168-1-zhouchengming@bytedance.com>
 <20220325035318.42168-4-zhouchengming@bytedance.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220325035318.42168-4-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2022 11:53 PM, Chengming Zhou wrote:
> There is one obselete comment in perf_cgroup_switch(), since
> we don't use event_filter_match() when event_sched_out().
> 
> Then found we needn't to use event_filter_match() in
> merge_sched_in() too. Because now we use the perf_event groups
> RB-tree to get the exact matched perf_events, don't need to
> go through the event_filter_match() to check if matched again.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>   kernel/events/core.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index dd985c77bc37..225d408deb1a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -856,7 +856,8 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
>   			cpu_ctx_sched_out(cpuctx, EVENT_ALL);
>   			/*
>   			 * must not be done before ctxswout due
> -			 * to event_filter_match() in event_sched_out()
> +			 * to update_cgrp_time_from_cpuctx() in
> +			 * ctx_sched_out()
>   			 */
>   			cpuctx->cgrp = NULL;
>   		}
> @@ -3804,9 +3805,6 @@ static int merge_sched_in(struct perf_event *event, void *data)
>   	if (event->state <= PERF_EVENT_STATE_OFF)
>   		return 0;
>   
> -	if (!event_filter_match(event))
> -		return 0;
> -

Both X86 and Arm implemented PMU specific filter_match callback for the 
hybrid system. I think the check is still required at least for the 
hybrid system.


Thanks,
Kan
>   	if (group_can_go_on(event, cpuctx, *can_add_hw)) {
>   		if (!group_sched_in(event, cpuctx, ctx))
>   			list_add_tail(&event->active_list, get_event_list(event));
