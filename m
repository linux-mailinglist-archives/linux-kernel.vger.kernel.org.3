Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070FF53A5FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353167AbiFANfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiFANfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:35:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC686FD17;
        Wed,  1 Jun 2022 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654090537; x=1685626537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=71xucqdUK6+qbZ/sT8v7fMak4I9EIHy4PWO4VMcNY1k=;
  b=Dg2lSsAogotn7+0y7Ow2wpE7BH9+ZzGCIqWAp5NMjY1MqQOEpmyjnFwb
   R8OaGuAUO3xxCqWTCJKc/HTf6vWIkIslxbaLBcmodGDLxTukd7kHC0InU
   +NUEkdOTDkcxnZb1qXpMF66d5UrfLcBjUsb5xau+JapHc+RZuhJtajxnM
   BeM8LkphOg1n5qL/Xc8wTJhtdeiaRpx1rkCuJ+MOGHVzN5jJTFexjOB4l
   3wiZJ9NUUbYtNYM8iCwMUPuXQTVJPTJRDomizFMUetgUibWMKlI0stOyU
   NGgZ/kCy9I6QqqAI0TBTaIAFOGTm7yDVhi8KHoCaFuV8zORmzxMwTqBpl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="361964736"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="361964736"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 06:35:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="720783952"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jun 2022 06:35:36 -0700
Received: from [10.252.214.178] (kliang2-MOBL.ccr.corp.intel.com [10.252.214.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 843CB580514;
        Wed,  1 Jun 2022 06:35:33 -0700 (PDT)
Message-ID: <47584a6b-20b9-9a3d-3125-d9fe848cea54@linux.intel.com>
Date:   Wed, 1 Jun 2022 09:35:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/8] perf tool: Parse pmu caps sysfs only once
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
 <20220601032608.1034-3-ravi.bangoria@amd.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220601032608.1034-3-ravi.bangoria@amd.com>
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
> In addition to returning nr_caps, cache it locally in struct perf_pmu.
> Similarly, cache status of whether caps sysfs has already been parsed
> or not. These will help to avoid parsing sysfs every time the function
> gets called.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>   tools/perf/util/pmu.c | 15 +++++++++++----
>   tools/perf/util/pmu.h |  2 ++
>   2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 9a1c7e63e663..0112e1c36418 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1890,7 +1890,11 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>   	const char *sysfs = sysfs__mountpoint();
>   	DIR *caps_dir;
>   	struct dirent *evt_ent;
> -	int nr_caps = 0;
> +
> +	if (pmu->caps_initialized)
> +		return pmu->nr_caps;
> +
> +	pmu->nr_caps = 0;
>   
>   	if (!sysfs)
>   		return -1;
> @@ -1898,8 +1902,10 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>   	snprintf(caps_path, PATH_MAX,
>   		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
>   
> -	if (stat(caps_path, &st) < 0)
> +	if (stat(caps_path, &st) < 0) {
> +		pmu->caps_initialized = true;
>   		return 0;	/* no error if caps does not exist */
> +	}
>   
>   	caps_dir = opendir(caps_path);
>   	if (!caps_dir)
> @@ -1926,13 +1932,14 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>   			continue;
>   		}
>   
> -		nr_caps++;
> +		pmu->nr_caps++;
>   		fclose(file);
>   	}
>   
>   	closedir(caps_dir);
>   
> -	return nr_caps;
> +	pmu->caps_initialized = true;
> +	return pmu->nr_caps;
>   }
>   
>   void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 541889fa9f9c..4b45fd8da5a3 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -46,6 +46,8 @@ struct perf_pmu {
>   	struct perf_cpu_map *cpus;
>   	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
>   	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
> +	bool caps_initialized;
> +	u32 nr_caps;

If they are just used for the cache purpose, I don't think we need to 
add the variables in the struct perf_pmu.

A static variable should be good enough. See sysctl__nmi_watchdog_enabled().

Thanks,
Kan

>   	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
>   	struct list_head list;    /* ELEM */
>   	struct list_head hybrid_list;
