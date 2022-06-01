Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B9153A5FF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353268AbiFANgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiFANgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:36:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBC96FD30;
        Wed,  1 Jun 2022 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654090566; x=1685626566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xoloNpkXjfX9GAfyDDZ6xvm9A+pcOjqX5sndCvY8+RM=;
  b=XoHDllrIKVgiRZbWyQJvkaBceDagf25p2Xi0dfEgq5H75sgEhkBEY+6B
   t7rBk579YWKV7QKhmdKdfVxUFJDuxnJvHhWfOeCohHFNmAHshL7JGVTIM
   /8ED7shQRSrx6ujYxsjfPm6yj+oOssSBvz+Y1yiMNEWYiK6HQc+Mniqb8
   tATVZFKPLWYoUcsvJrfcjPXm9xBoPkOW9pUf+zn0+WFZZ2UR56Y4MIqTV
   IM5TlEIDyKAfQvtcXxWCJUiN1586svoCtR/b8HSO0Fcf2rEVm63e93qms
   3vUHjU/TMFaGc3j8Bfy6n2imwH6L3e42mE161ivQ1ngTxivnbYnKIGs+1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="256069574"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="256069574"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 06:35:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="581584608"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jun 2022 06:35:57 -0700
Received: from [10.252.214.178] (kliang2-MOBL.ccr.corp.intel.com [10.252.214.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id AA346580514;
        Wed,  1 Jun 2022 06:35:54 -0700 (PDT)
Message-ID: <2adf5485-db22-8dde-9d32-6615e6346c6f@linux.intel.com>
Date:   Wed, 1 Jun 2022 09:35:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 3/8] perf headers: Pass "cpu" pmu name while printing
 caps
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>, acme@kernel.org
Cc:     jolsa@kernel.org, irogers@google.com, peterz@infradead.org,
        rrichter@amd.com, mingo@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, ak@linux.intel.com,
        eranian@google.com, like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
 <20220601032608.1034-4-ravi.bangoria@amd.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220601032608.1034-4-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2022 11:26 PM, Ravi Bangoria wrote:
> Avoid unnecessary conditional code to check if pmu name is NULL
> or not by passing "cpu" pmu name to the printing function.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>   tools/perf/util/header.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 53332da100e8..ee7ccd94e272 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2058,17 +2058,11 @@ static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char *cpu_pmu_caps,
>   	char *str, buf[128];
>   
>   	if (!nr_caps) {
> -		if (!pmu_name)
> -			fprintf(fp, "# cpu pmu capabilities: not available\n");
> -		else
> -			fprintf(fp, "# %s pmu capabilities: not available\n", pmu_name);
> +		fprintf(fp, "# %s pmu capabilities: not available\n", pmu_name);
>   		return;
>   	}
>   
> -	if (!pmu_name)
> -		scnprintf(buf, sizeof(buf), "# cpu pmu capabilities: ");
> -	else
> -		scnprintf(buf, sizeof(buf), "# %s pmu capabilities: ", pmu_name);
> +	scnprintf(buf, sizeof(buf), "# %s pmu capabilities: ", pmu_name);
>   
>   	delimiter = buf;
>   
> @@ -2085,7 +2079,7 @@ static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char *cpu_pmu_caps,
>   static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
>   {
>   	print_per_cpu_pmu_caps(fp, ff->ph->env.nr_cpu_pmu_caps,
> -			       ff->ph->env.cpu_pmu_caps, NULL);
> +			       ff->ph->env.cpu_pmu_caps, (char *)"cpu");
>   }
>   
>   static void print_hybrid_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
