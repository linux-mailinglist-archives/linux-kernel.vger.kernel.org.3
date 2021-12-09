Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D661146F3A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhLITLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhLITLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:11:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD58C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:07:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1241B8261F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 19:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F8CC004DD;
        Thu,  9 Dec 2021 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639076858;
        bh=A/SmYbPVcd+4ldpmBIrQSJNFHd6P9tSef72Gf8g4imE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+YtGskQuovzrw0wnCu4AUlygwqhrzruY4XlGp0Pr2I8inQ+LmHkpYgwRwpwKZpTe
         pUoosyHWm9aA6HH1MxIwvsEPm78L9Fn+WzwceaGSzG1Y5ow9tEJ+eD85kZvQA67SFe
         V6KxznoqwYbDfsTrBsko3JpJ5tg0RCBXJKjg62XgP1b8RNpIrjm+b/6I7QTWlcM8LV
         zomRkZGOQ/S5ChDccuXzoyXc+WUhJ8rKv+eBSpIoPGBroaLtGIvHKz8eFehM33tqNb
         aTrFt4UpcPCOdCQAUXNpytyxA3yW5ueMTv+7mUBdmXO2vWdaCg2m+cUNDx6EjPJCp/
         EJDtY4PTekYMw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E2031405D8; Thu,  9 Dec 2021 16:07:35 -0300 (-03)
Date:   Thu, 9 Dec 2021 16:07:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2] perf tools: Add SPE total latency as
 PERF_SAMPLE_WEIGHT
Message-ID: <YbJT9z/F5FjdyXdh@kernel.org>
References: <20211201220855.1260688-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201220855.1260688-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 01, 2021 at 02:08:55PM -0800, Namhyung Kim escreveu:
> Use total latency info in the SPE counter packet as sample weight so
> that we can see it in local_weight and (global) weight sort keys.
> 
> Maybe we can use PERF_SAMPLE_WEIGHT_STRUCT to support ins_lat as well
> but I'm not sure which latency it matches.  So just adding total
> latency first.

Thanks, applied.

- Arnaldo

 
> Cc: German Gomez <german.gomez@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
>  tools/perf/util/arm-spe.c                         | 5 ++++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 3fc528c9270c..5e390a1a79ab 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -179,6 +179,8 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>  				decoder->record.phys_addr = ip;
>  			break;
>  		case ARM_SPE_COUNTER:
> +			if (idx == SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT)
> +				decoder->record.latency = payload;
>  			break;
>  		case ARM_SPE_CONTEXT:
>  			decoder->record.context_id = payload;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 46a8556a9e95..69b31084d6be 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -33,6 +33,7 @@ struct arm_spe_record {
>  	enum arm_spe_sample_type type;
>  	int err;
>  	u32 op;
> +	u32 latency;
>  	u64 from_ip;
>  	u64 to_ip;
>  	u64 timestamp;
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 4748bcfe61de..82c08f2a60d0 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -317,6 +317,7 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
>  	sample.addr = record->virt_addr;
>  	sample.phys_addr = record->phys_addr;
>  	sample.data_src = data_src;
> +	sample.weight = record->latency;
>  
>  	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
> @@ -334,6 +335,7 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
>  	sample.id = spe_events_id;
>  	sample.stream_id = spe_events_id;
>  	sample.addr = record->to_ip;
> +	sample.weight = record->latency;
>  
>  	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
> @@ -980,7 +982,8 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  	attr.type = PERF_TYPE_HARDWARE;
>  	attr.sample_type = evsel->core.attr.sample_type & PERF_SAMPLE_MASK;
>  	attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
> -			    PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC;
> +			    PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC |
> +			    PERF_SAMPLE_WEIGHT;
>  	if (spe->timeless_decoding)
>  		attr.sample_type &= ~(u64)PERF_SAMPLE_TIME;
>  	else
> -- 
> 2.34.0.384.gca35af8252-goog

-- 

- Arnaldo
