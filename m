Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C5F522D89
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbiEKHnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243037AbiEKHnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:43:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285136CF5C;
        Wed, 11 May 2022 00:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652255015; x=1683791015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/5VJ1YvJmkQmRDjgppLi3zE6xrLgD7i0RdleleuK6ao=;
  b=MGvK35cyDywZR7VYZ+Z4Rli5EbUSWBFWOjDUWvlT158xqRrya3LAEYnA
   +bClM2YA+ZO0kfI4FNSh9rfpoJpDCUVit3vCqcl80XKBBBFPfEtpsKkiV
   Y97QR1vV3wOwS1eJYfc8C7suHfBH4/DQZ+lhc1M/lc/5DyehsrRkzGZld
   Zf45LAMOZNiAUM/fDEca36NDuqVml6ZnE9UN5d5ExIG2BVNoUSnukV5E0
   yINfOK/3yZyHhockKhcgIWimVtF2U5alImq9PbUiRqIgm8CHGM5NCj+bU
   S1HI7a0gvg+UjcQLB+9EDX6TYzq9qFxo/IMm1xO2WbyxqrLoWS0/Xqivy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="251671618"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="251671618"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:43:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="739101444"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.249.171.178]) ([10.249.171.178])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:43:26 -0700
Message-ID: <35c5833b-6974-e40d-f4b3-a3b36d11d06c@linux.intel.com>
Date:   Wed, 11 May 2022 15:43:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/7] perf jevents: Modify match field
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Felix Fietkau <nbd@nbd.name>,
        Qi Liu <liuqi115@huawei.com>, Like Xu <likexu@tencent.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>
References: <20220511070133.710721-1-irogers@google.com>
 <20220511070133.710721-5-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220511070133.710721-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2022 3:01 PM, Ian Rogers wrote:
> The match_field function looks for json values to append to the event
> string. As the C code processes these in order the output order matches
> that in the json dictionary. Python json readers read the entire
> dictionary and lose the ordering. To make the python and C output
> comparable makee the C code first read the extra fields then append them

The "makee" should be a typo.

> to the event in an order not determined by their order in the file.
> 
> Modify the pmu-events test so that test expectations match the new
> order.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/pmu-events/jevents.c | 82 ++++++++++++++++++++-------------
>   tools/perf/tests/pmu-events.c   | 24 +++++-----
>   2 files changed, 62 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index e1f7c7afd435..cee61c4ed59e 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -207,21 +207,6 @@ static struct msrmap {
>   	{ NULL, NULL }
>   };
>   
> -static struct field {
> -	const char *field;
> -	const char *kernel;
> -} fields[] = {
> -	{ "UMask",	"umask=" },
> -	{ "CounterMask", "cmask=" },
> -	{ "Invert",	"inv=" },
> -	{ "AnyThread",	"any=" },
> -	{ "EdgeDetect",	"edge=" },
> -	{ "SampleAfterValue", "period=" },
> -	{ "FCMask",	"fc_mask=" },
> -	{ "PortMask",	"ch_mask=" },
> -	{ NULL, NULL }
> -};
> -
>   static void cut_comma(char *map, jsmntok_t *newval)
>   {
>   	int i;
> @@ -233,21 +218,6 @@ static void cut_comma(char *map, jsmntok_t *newval)
>   	}
>   }
>   
> -static int match_field(char *map, jsmntok_t *field, int nz,
> -		       char **event, jsmntok_t *val)
> -{
> -	struct field *f;
> -	jsmntok_t newval = *val;
> -
> -	for (f = fields; f->field; f++)
> -		if (json_streq(map, field, f->field) && nz) {
> -			cut_comma(map, &newval);
> -			addfield(map, event, ",", f->kernel, &newval);
> -			return 1;
> -		}
> -	return 0;
> -}
> -
>   static struct msrmap *lookup_msr(char *map, jsmntok_t *val)
>   {
>   	jsmntok_t newval = *val;
> @@ -581,6 +551,14 @@ static int json_events(const char *fn,
>   		jsmntok_t *precise = NULL;
>   		jsmntok_t *obj = tok++;
>   		bool configcode_present = false;
> +		char *umask = NULL;
> +		char *cmask = NULL;
> +		char *inv = NULL;
> +		char *any = NULL;
> +		char *edge = NULL;
> +		char *period = NULL;
> +		char *fc_mask = NULL;
> +		char *ch_mask = NULL;
>   
>   		EXPECT(obj->type == JSMN_OBJECT, obj, "expected object");
>   		for (j = 0; j < obj->size; j += 2) {
> @@ -596,8 +574,23 @@ static int json_events(const char *fn,
>   			       "Expected string value");
>   
>   			nz = !json_streq(map, val, "0");
> -			if (match_field(map, field, nz, &event, val)) {
> -				/* ok */
> +			/* match_field */
> +			if (json_streq(map, field, "UMask") && nz) {
> +				addfield(map, &umask, "", "umask=", val);
> +			} else if (json_streq(map, field, "CounterMask") && nz) {
> +				addfield(map, &cmask, "", "cmask=", val);
> +			} else if (json_streq(map, field, "Invert") && nz) {
> +				addfield(map, &inv, "", "inv=", val);
> +			} else if (json_streq(map, field, "AnyThread") && nz) {
> +				addfield(map, &any, "", "any=", val);
> +			} else if (json_streq(map, field, "EdgeDetect") && nz) {
> +				addfield(map, &edge, "", "edge=", val);
> +			} else if (json_streq(map, field, "SampleAfterValue") && nz) {
> +				addfield(map, &period, "", "period=", val);
> +			} else if (json_streq(map, field, "FCMask") && nz) {
> +				addfield(map, &fc_mask, "", "fc_mask=", val);
> +			} else if (json_streq(map, field, "PortMask") && nz) {
> +				addfield(map, &ch_mask, "", "ch_mask=", val);
>   			} else if (json_streq(map, field, "EventCode")) {
>   				char *code = NULL;
>   				addfield(map, &code, "", "", val);
> @@ -690,6 +683,23 @@ static int json_events(const char *fn,
>   		else
>   			snprintf(buf, sizeof buf, "event=%#llx", eventcode);
>   		addfield(map, &event, ",", buf, NULL);
> +		if (any)
> +			addfield(map, &event, ",", any, NULL);
> +		if (ch_mask)
> +			addfield(map, &event, ",", ch_mask, NULL);
> +		if (cmask)
> +			addfield(map, &event, ",", cmask, NULL);
> +		if (edge)
> +			addfield(map, &event, ",", edge, NULL);
> +		if (fc_mask)
> +			addfield(map, &event, ",", fc_mask, NULL);
> +		if (inv)
> +			addfield(map, &event, ",", inv, NULL);
> +		if (period)
> +			addfield(map, &event, ",", period, NULL);
> +		if (umask)
> +			addfield(map, &event, ",", umask, NULL);
> +
>   		if (je.desc && extra_desc)
>   			addfield(map, &je.desc, " ", extra_desc, NULL);
>   		if (je.long_desc && extra_desc)
> @@ -718,6 +728,14 @@ static int json_events(const char *fn,
>   		je.event = real_event(je.name, event);
>   		err = func(data, &je);
>   free_strings:
> +		free(umask);
> +		free(cmask);
> +		free(inv);
> +		free(any);
> +		free(edge);
> +		free(period);
> +		free(fc_mask);
> +		free(ch_mask);
>   		free(event);
>   		free(je.desc);
>   		free(je.name);
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index b74c6ef59e51..f13368569d8b 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -63,33 +63,33 @@ static const struct perf_pmu_test_event bp_l2_btb_correct = {
>   static const struct perf_pmu_test_event segment_reg_loads_any = {
>   	.event = {
>   		.name = "segment_reg_loads.any",
> -		.event = "umask=0x80,period=200000,event=0x6",
> +		.event = "event=0x6,period=200000,umask=0x80",
>   		.desc = "Number of segment register loads",
>   		.topic = "other",
>   	},
> -	.alias_str = "umask=0x80,period=0x30d40,event=0x6",
> +	.alias_str = "event=0x6,period=0x30d40,umask=0x80",
>   	.alias_long_desc = "Number of segment register loads",
>   };
>   
>   static const struct perf_pmu_test_event dispatch_blocked_any = {
>   	.event = {
>   		.name = "dispatch_blocked.any",
> -		.event = "umask=0x20,period=200000,event=0x9",
> +		.event = "event=0x9,period=200000,umask=0x20",
>   		.desc = "Memory cluster signals to block micro-op dispatch for any reason",
>   		.topic = "other",
>   	},
> -	.alias_str = "umask=0x20,period=0x30d40,event=0x9",
> +	.alias_str = "event=0x9,period=0x30d40,umask=0x20",
>   	.alias_long_desc = "Memory cluster signals to block micro-op dispatch for any reason",
>   };
>   
>   static const struct perf_pmu_test_event eist_trans = {
>   	.event = {
>   		.name = "eist_trans",
> -		.event = "umask=0x0,period=200000,event=0x3a",
> +		.event = "event=0x3a,period=200000,umask=0x0",
>   		.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
>   		.topic = "other",
>   	},
> -	.alias_str = "umask=0,period=0x30d40,event=0x3a",
> +	.alias_str = "event=0x3a,period=0x30d40,umask=0",
>   	.alias_long_desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
>   };
>   
> @@ -132,13 +132,13 @@ static const struct perf_pmu_test_event uncore_hisi_ddrc_flux_wcmd = {
>   static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
>   	.event = {
>   		.name = "unc_cbo_xsnp_response.miss_eviction",
> -		.event = "umask=0x81,event=0x22",
> +		.event = "event=0x22,umask=0x81",
>   		.desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core. Unit: uncore_cbox ",
>   		.topic = "uncore",
>   		.long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
>   		.pmu = "uncore_cbox",
>   	},
> -	.alias_str = "umask=0x81,event=0x22",
> +	.alias_str = "event=0x22,umask=0x81",
>   	.alias_long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
>   	.matching_pmu = "uncore_cbox_0",
>   };
> @@ -146,13 +146,13 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
>   static const struct perf_pmu_test_event uncore_hyphen = {
>   	.event = {
>   		.name = "event-hyphen",
> -		.event = "umask=0x00,event=0xe0",
> +		.event = "event=0xe0,umask=0x00",
>   		.desc = "UNC_CBO_HYPHEN. Unit: uncore_cbox ",
>   		.topic = "uncore",
>   		.long_desc = "UNC_CBO_HYPHEN",
>   		.pmu = "uncore_cbox",
>   	},
> -	.alias_str = "umask=0,event=0xe0",
> +	.alias_str = "event=0xe0,umask=0",
>   	.alias_long_desc = "UNC_CBO_HYPHEN",
>   	.matching_pmu = "uncore_cbox_0",
>   };
> @@ -160,13 +160,13 @@ static const struct perf_pmu_test_event uncore_hyphen = {
>   static const struct perf_pmu_test_event uncore_two_hyph = {
>   	.event = {
>   		.name = "event-two-hyph",
> -		.event = "umask=0x00,event=0xc0",
> +		.event = "event=0xc0,umask=0x00",
>   		.desc = "UNC_CBO_TWO_HYPH. Unit: uncore_cbox ",
>   		.topic = "uncore",
>   		.long_desc = "UNC_CBO_TWO_HYPH",
>   		.pmu = "uncore_cbox",
>   	},
> -	.alias_str = "umask=0,event=0xc0",
> +	.alias_str = "event=0xc0,umask=0",
>   	.alias_long_desc = "UNC_CBO_TWO_HYPH",
>   	.matching_pmu = "uncore_cbox_0",
>   };

-- 
Zhengjun Xing
