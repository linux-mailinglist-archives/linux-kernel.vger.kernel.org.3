Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E803C52229C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348191AbiEJRcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348253AbiEJRb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:31:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292D8CD92
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48C7DB81CC6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3D9C385A6;
        Tue, 10 May 2022 17:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652203665;
        bh=VL4kUUVILrJUOX+tH3h8eEBpzV7YwpyyhcS9uhyC7xE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=da3oknQNQoiangJsDXelQ3cLquPcJiRFSpbjHctcWb5YE1WrimB/OjNDJRAXNVqBj
         bfFtY1kpnOFJgJGiW+u1IkhzhEXMLwzwMeEPuE6jFUOZ8D00tPbv8eCG/J0Lvd1pE2
         YbKK0SQLjkFDduswkEqL/vbGSR5gP8WhW2VN6DrCAmGSNHhYQlm5+1FrC1Qub0bizN
         t2igdQ2tZXscFh73u4Zd1j+fmxnwPPZkM20sQg4LI9UecEKn04wwqTDfrdzoiMIoTo
         qqhQrSwdM5tlSlctpQ7L/gKxrH7veWAQLaMEqy5l5BMaVk2korn9MM2LIhoXb+4LOA
         1l0CqJoTDEtwA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DE44B400B1; Tue, 10 May 2022 14:27:41 -0300 (-03)
Date:   Tue, 10 May 2022 14:27:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 09/23] perf auxtrace: Record whether an auxtrace mmap
 is needed
Message-ID: <YnqgjdB+U3Oluv54@kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-10-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506122601.367589-10-adrian.hunter@intel.com>
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

Em Fri, May 06, 2022 at 03:25:47PM +0300, Adrian Hunter escreveu:
> Add a flag needs_auxtrace_mmap to record whether an auxtrace mmap is
> needed, in preparation for correctly determining whether or not an
> auxtrace mmap is needed.

Thanks, applied.

- Arnaldo

> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c    | 1 +
>  tools/perf/arch/arm64/util/arm-spe.c | 1 +
>  tools/perf/arch/s390/util/auxtrace.c | 1 +
>  tools/perf/arch/x86/util/intel-bts.c | 1 +
>  tools/perf/arch/x86/util/intel-pt.c  | 1 +
>  tools/perf/util/evsel.h              | 1 +
>  6 files changed, 6 insertions(+)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 11c71aa219f7..1b54638d53b0 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -319,6 +319,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  			}
>  			evsel->core.attr.freq = 0;
>  			evsel->core.attr.sample_period = 1;
> +			evsel->needs_auxtrace_mmap = true;
>  			cs_etm_evsel = evsel;
>  			opts->full_auxtrace = true;
>  		}
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index e8b577d33e53..6f4db2ac5420 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -160,6 +160,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  			}
>  			evsel->core.attr.freq = 0;
>  			evsel->core.attr.sample_period = arm_spe_pmu->default_config->sample_period;
> +			evsel->needs_auxtrace_mmap = true;
>  			arm_spe_evsel = evsel;
>  			opts->full_auxtrace = true;
>  		}
> diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
> index 0db5c58c98e8..5068baa3e092 100644
> --- a/tools/perf/arch/s390/util/auxtrace.c
> +++ b/tools/perf/arch/s390/util/auxtrace.c
> @@ -98,6 +98,7 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>  	evlist__for_each_entry(evlist, pos) {
>  		if (pos->core.attr.config == PERF_EVENT_CPUM_SF_DIAG) {
>  			diagnose = 1;
> +			pos->needs_auxtrace_mmap = true;
>  			break;
>  		}
>  	}
> diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> index d68a0f48e41e..bcccfbade5c6 100644
> --- a/tools/perf/arch/x86/util/intel-bts.c
> +++ b/tools/perf/arch/x86/util/intel-bts.c
> @@ -129,6 +129,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
>  			}
>  			evsel->core.attr.freq = 0;
>  			evsel->core.attr.sample_period = 1;
> +			evsel->needs_auxtrace_mmap = true;
>  			intel_bts_evsel = evsel;
>  			opts->full_auxtrace = true;
>  		}
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 38ec2666ec12..2eaac4638aab 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -649,6 +649,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  			evsel->core.attr.freq = 0;
>  			evsel->core.attr.sample_period = 1;
>  			evsel->no_aux_samples = true;
> +			evsel->needs_auxtrace_mmap = true;
>  			intel_pt_evsel = evsel;
>  			opts->full_auxtrace = true;
>  		}
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 45d674812239..544fbed98df1 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -124,6 +124,7 @@ struct evsel {
>  	bool			merged_stat;
>  	bool			reset_group;
>  	bool			errored;
> +	bool			needs_auxtrace_mmap;
>  	struct hashmap		*per_pkg_mask;
>  	int			err;
>  	struct {
> -- 
> 2.25.1

-- 

- Arnaldo
