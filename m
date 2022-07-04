Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B65A5656FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiGDNXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiGDNWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:22:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAB8F38;
        Mon,  4 Jul 2022 06:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656940932; x=1688476932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7X6+4WgQpVWZhi7AvLXyGHGEV5/74ETt1pwl0e7qxc0=;
  b=YLev8Epj0tP1oTI++MstrC/2aCGw2a3XXDcLrAfRXnIi7i8uzPyamTDN
   wr73ebfbxd6ymUWDqyUXxt92qy8o4cOtVdCWHBylKk/zZvgYXQOpOy4Io
   bo2cS4/uH0zReoLqIpr5FfecbqLWBeHWE82J7WPI5zraIgBJd0LkxVQsM
   8g5idhF2B1J2NGbzqJuhn9AVeZBbPRPP6T3GgAKs9KAsuN72PXAtBXAUZ
   752d9grqM4FKL4tVoBkipbaJsePJEK77n1x4fiyLGhv/ttEtZedQ/tnYz
   mvA4Zd2RozTq7QXcJHUMMgthtNBkEXkC2+SbS2g+e9HKPK1M8GPZ+eSLC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="280682586"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="280682586"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 06:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="919360662"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jul 2022 06:22:10 -0700
Received: from [10.252.212.27] (kliang2-MOBL.ccr.corp.intel.com [10.252.212.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1DDB3580AF2;
        Mon,  4 Jul 2022 06:22:08 -0700 (PDT)
Message-ID: <9fde1c3a-3fdb-b2b7-7448-8de608853bd2@linux.intel.com>
Date:   Mon, 4 Jul 2022 09:22:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] perf record: Fix "--per-thread" option for hybrid
 machines
Content-Language: en-US
To:     zhengjun.xing@linux.intel.com, acme@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20220702023536.2661899-1-zhengjun.xing@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220702023536.2661899-1-zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/2022 10:35 PM, zhengjun.xing@linux.intel.com wrote:
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> 
> Commit b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems to
> collect metadata records") adds a dummy event on hybrid systems to fix the
> symbol "unknown" issue when the workload is created in a P-core but runs
> on an E-core. When "--per-thread" is enabled, the nr_cpus is reduced to 1,
>   adding a dummy event is useless for this issue, and it will also cause

A dummy event is required since a mmap event may be loaded at runtime on 
any CPU. Thanks Adrian to point it out.

Thanks,
Kan

> "failed to mmap with 22 (Invalid argument)". This patch stops adding dummy
> events when the option "--per-thread" is enabled, then the option can work
> on hybrid machines.
> 
> Before:
> 
>   # ./perf record -e cycles:u --per-thread  sleep 1
>   failed to mmap with 22 (Invalid argument)
> 
> After:
> 
>   # ./perf record -e cycles:u --per-thread  sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.002 MB perf.data (6 samples) ]
> 
> Fixes: b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems to collect metadata records")
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>   tools/perf/builtin-record.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e1edd4e98358..44ea2dd424fe 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1223,7 +1223,7 @@ static int record__open(struct record *rec)
>   	 * of waiting or event synthesis.
>   	 */
>   	if (opts->initial_delay || target__has_cpu(&opts->target) ||
> -	    perf_pmu__has_hybrid()) {
> +	    (perf_pmu__has_hybrid() && !opts->target.per_thread)) {
>   		pos = evlist__get_tracking_event(evlist);
>   		if (!evsel__is_dummy_event(pos)) {
>   			/* Set up dummy event. */
