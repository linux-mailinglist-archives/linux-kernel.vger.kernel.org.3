Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9AE49BD24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiAYU3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiAYU3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:29:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC95DC06173B;
        Tue, 25 Jan 2022 12:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=HuFsrsEjCeQb8F5o6wp0UCzTE2mHOFE1tAbifZs8KLw=; b=mq1rL5RHHhUx5YzffcC/GkJDtJ
        Yi5m9hTUVZ0ZaUiZBmGflnWr/8kNQJukSAUsM3n5Vugs76dEknceOhLS23X1MkhUIe+mT3RxpGRF9
        o34r4rt1gBktX5eoQuNS1DL5lkhnknLKpBBuIJAz0nVWXgsjl5hl7qvllBkvDXlRPeJx8YzKZVOxi
        +xbf4KVHU7fgZfrBAFvxM/Gui+/ky0S+0jVrE1h+A/JHrAw+RNbisH8I4t+Bl58ub7qfIsO6Bof/7
        kAmZmbTmanYRWsR5Z8/tgtRKF5mKZEhD35aWkh98h+ulDqPCMo3dM4wXKicWszORZQXRyn5INVOZU
        GzE+iEXg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCSRF-003YjS-PQ; Tue, 25 Jan 2022 20:29:14 +0000
Message-ID: <d1d154c1-dfdb-9899-8d40-4ff50de80df1@infradead.org>
Date:   Tue, 25 Jan 2022 12:29:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH][next] perf/x86/rapl: replace 0 with NULL to initialize
 pointers
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220125201403.670011-1-colin.i.king@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220125201403.670011-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/22 12:14, Colin Ian King wrote:
> Pointers should be initialized with NULL rather than zero. Fix these.
> Cleans up sparse warning:
> 
> arch/x86/events/rapl.c:540:59: warning: Using plain integer as NULL pointer


also was
Reported-by: kernel test robot <lkp@intel.com>


> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  arch/x86/events/rapl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 77e3a47af5ad..7d70690fded5 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -537,11 +537,11 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
>   * - want to use same event codes across both architectures
>   */
>  static struct perf_msr amd_rapl_msrs[] = {
> -	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
> +	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL, false, 0 },
>  	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
> -	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
> -	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
> -	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  0, false, 0 },
> +	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL, false, 0 },
> +	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   NULL, false, 0 },
> +	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
>  };
>  
>  static int rapl_cpu_offline(unsigned int cpu)

-- 
~Randy
