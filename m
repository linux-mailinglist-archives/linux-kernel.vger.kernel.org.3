Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D93528533
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbiEPNWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiEPNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:22:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D87D27CDA;
        Mon, 16 May 2022 06:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFDA161300;
        Mon, 16 May 2022 13:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D08C385B8;
        Mon, 16 May 2022 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652707323;
        bh=rJUa9Z2ztgeXMpnrq0kYK0VeLhOi4oFlO/D1bnHvnHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TqB+7EnFlYfugsZ70Yc80l4qYQfY1LYlTcBF2STzQsMyL6Et1HhCGmmfbbRAolYfs
         gn6xKNclbyqLA8Ts6jFv328bYVTVcYhw7I8FRLwvLlpN2wx0KaxrWRtjFLgRpaSSY+
         eIyVQiXouVZDLW9PKfYYz8AKDLAJ9l1rpj7drQIBKLskACBBA7AFldBWrZk0m1tPgZ
         I3cKnaZA3Way1vmXjRrI36X3lblUWvSetWPgM7zUNDcHeveGoycS41OmFpbJ9fR3JB
         Z/ZZpvp4QP5+C0Uo4moid5kAU5krSnXQ+e8prEaCKUIG6Ne22jH38BwN2YFG1S6Lgg
         5te0JIt+gmgSQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F30F8400B1; Mon, 16 May 2022 10:22:00 -0300 (-03)
Date:   Mon, 16 May 2022 10:22:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, irogers@google.com,
        yao.jin@linux.intel.com, james.clark@arm.com, leo.yan@linaro.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, eranian@google.com,
        like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2 5/8] perf record ibs: Warn about sampling period skew
Message-ID: <YoJP+JqI2M1i647y@kernel.org>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
 <20220509044914.1473-6-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509044914.1473-6-ravi.bangoria@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 09, 2022 at 10:19:11AM +0530, Ravi Bangoria escreveu:
> Samples without an L3 miss are discarded and counter is reset with
> random value (between 1-15 for fetch pmu and 1-127 for op pmu) when
> IBS L3 miss filtering is enabled. This causes a sampling period skew
> but there is no way to reconstruct aggregated sampling period. So
> print a warning at perf record if user sets l3missonly=1.
> 
> Ex:
>   # perf record -c 10000 -C 0 -e ibs_op/l3missonly=1/
>   WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled
>   and tagged operation does not cause L3 Miss. This causes sampling period skew.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/arch/x86/util/evsel.c | 34 ++++++++++++++++++++++++++++++++
>  tools/perf/util/evsel.c          |  7 +++++++
>  tools/perf/util/evsel.h          |  1 +
>  3 files changed, 42 insertions(+)
> 
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index ac2899a25b7a..6399faa70a88 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -4,6 +4,8 @@
>  #include "util/evsel.h"
>  #include "util/env.h"
>  #include "linux/string.h"
> +#include "util/pmu.h"
> +#include "util/debug.h"
>  
>  void arch_evsel__set_sample_weight(struct evsel *evsel)
>  {
> @@ -29,3 +31,35 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
>  
>  	free(env.cpuid);
>  }
> +
> +static void ibs_l3miss_warn(void)
> +{
> +	pr_warning(
> +"WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled\n"
> +"and tagged operation does not cause L3 Miss. This causes sampling period skew.\n");
> +}
> +
> +void arch_evsel__warn_ambiguity(struct evsel *evsel, struct perf_event_attr *attr)
> +{
> +	struct perf_env *env = evsel__env(evsel);
> +	struct perf_pmu *evsel_pmu = evsel__find_pmu(evsel);
> +	struct perf_pmu *ibs_fetch_pmu = perf_pmu__find("ibs_fetch");
> +	struct perf_pmu *ibs_op_pmu = perf_pmu__find("ibs_op");
> +	static int warned_once;

Please check first if the warning was emitted (warned_once is true)
before calling all the find routines above.

> +	if (warned_once || !perf_env__cpuid(env) || !env->cpuid ||
> +	    !strstarts(env->cpuid, "AuthenticAMD") || !evsel_pmu)
> +		return;
> +
> +	if (ibs_fetch_pmu && ibs_fetch_pmu->type == evsel_pmu->type) {
> +		if (attr->config & (1ULL << 59)) {
> +			ibs_l3miss_warn();
> +			warned_once = 1;
> +		}
> +	} else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
> +		if (attr->config & (1ULL << 16)) {
> +			ibs_l3miss_warn();
> +			warned_once = 1;
> +		}
> +	}
> +}
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2a1729e7aee4..4f8b72d4a521 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1064,6 +1064,11 @@ void __weak arch_evsel__fixup_new_cycles(struct perf_event_attr *attr __maybe_un
>  {
>  }
>  
> +void __weak arch_evsel__warn_ambiguity(struct evsel *evsel __maybe_unused,
> +				       struct perf_event_attr *attr __maybe_unused)
> +{
> +}
> +
>  static void evsel__set_default_freq_period(struct record_opts *opts,
>  					   struct perf_event_attr *attr)
>  {
> @@ -1339,6 +1344,8 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	 */
>  	if (evsel__is_dummy_event(evsel))
>  		evsel__reset_sample_bit(evsel, BRANCH_STACK);
> +
> +	arch_evsel__warn_ambiguity(evsel, attr);

Wouldn't this be better as a single arch__post_evsel_config() function that
could do arch specific fixups or emit such warnings _after_ (thus the
"post") the common code evsel__config() does its thing?

>  }
>  
>  int evsel__set_filter(struct evsel *evsel, const char *filter)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 041b42d33bf5..195ae30ec45b 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -281,6 +281,7 @@ void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
>  
>  void arch_evsel__set_sample_weight(struct evsel *evsel);
>  void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr);
> +void arch_evsel__warn_ambiguity(struct evsel *evsel, struct perf_event_attr *attr);
>  
>  int evsel__set_filter(struct evsel *evsel, const char *filter);
>  int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
> -- 
> 2.27.0

-- 

- Arnaldo
