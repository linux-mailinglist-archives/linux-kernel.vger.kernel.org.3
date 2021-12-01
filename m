Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8552C464641
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346650AbhLAFMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbhLAFMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:12:02 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:08:42 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y8so16753972plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jRW4qABXyX4vH6Ha6BJJsmxFUkRbOvvDZkeTVBPDye0=;
        b=C62DPLuUiX2Wl1g8HeM3bB7wBEULtP5eq9y9SuEyLHr4euacCL3aYwA7MBtpYI5us+
         QOuYHfMXTIbaw8RROVLTmXThdhdW0YaXmJLHS/GvMC1m05dSwPI4piELY9o12bKtCwcQ
         hdmLA3RdlbRnwu39s3o2D/cl0UpRwWEo/5K/i6OeRwJaqEcs9zxlZRqKxgCFG6NDWOfn
         G+3B+vIMKPodZQSxuHVcS2iSeowLweHNi7VAoO7H4D5/TbZnvVHgGQzMUHhFl4qzxrPw
         N7+e1TOneugk0GD5DrT0cpQcSqHYttR7kjeyyfjvaMshCdCBB2ObsEkhpo1UKl9pIJGE
         bnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jRW4qABXyX4vH6Ha6BJJsmxFUkRbOvvDZkeTVBPDye0=;
        b=xc/uv4FCjmwxiWwBKTJce9GWTMfPpg/R3UOkyB6PGBxJh71fr17qLC9eRrjAAjTcnq
         e0CosWtL91s/BnrIvL9zXoF3dmdqqsGKF40SKz6E+FRXCeNCP5xEW+UXFodfDKQ7jprW
         28iFo3jHo86T3qa2O0wBXauJeyWSOWWrF7D5Savg5tXLn91LTEKMiEOEG2BWzFYM9W5b
         3NEdlwXJljGVR0AYvx5lR1n376rfZaVzoX8q13A9BSHiDFktIicpWIIsFLneGwzCwWid
         Cjq1slhJlolrDCx3breZJTW5uQqzmzYejgKqCE6+HKfhi/Ip0teVRlxbtgdz/U/i5Qxv
         jfKw==
X-Gm-Message-State: AOAM533dxvMSqZWsWU0s9h08+8pmSiO48aAK6TZ6bO0w9+2jKmGkztPE
        3etUv6w2twjwSS0Ra7Gid+FjQw==
X-Google-Smtp-Source: ABdhPJzb3Rm6yxF1rG/twFVbSU3/FJ8wr2sFXl/8g7eL9Pu7Cb1LTf8FDTdI78jJ6dJKOrlR8RoQ3Q==
X-Received: by 2002:a17:90a:880a:: with SMTP id s10mr4594906pjn.214.1638335322025;
        Tue, 30 Nov 2021 21:08:42 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([66.23.193.248])
        by smtp.gmail.com with ESMTPSA id n71sm23087146pfd.50.2021.11.30.21.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 21:08:41 -0800 (PST)
Date:   Wed, 1 Dec 2021 13:08:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Clark <James.Clark@arm.com>
Subject: Re: [PATCH] perf tools: Add SPE total latency as PERF_SAMPLE_WEIGHT
Message-ID: <20211201050836.GB2678859@leoy-ThinkPad-X240s>
References: <20211201003908.1200945-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201003908.1200945-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Tue, Nov 30, 2021 at 04:39:08PM -0800, Namhyung Kim wrote:
> Use total latency info in the SPE counter packet as sample weight so
> that we can see it in local_weight and (global) weight sort keys.
> 
> Maybe we can use PERF_SAMPLE_WEIGHT_STRUCT to support ins_lat as well
> but I'm not sure which latency it matches.  So just adding total
> latency first.
> 
> Cc: German Gomez <german.gomez@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
>  tools/perf/util/arm-spe.c                         | 4 +++-
>  3 files changed, 6 insertions(+), 1 deletion(-)
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
> index 4748bcfe61de..a756325c72a7 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -317,6 +317,7 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
>  	sample.addr = record->virt_addr;
>  	sample.phys_addr = record->phys_addr;
>  	sample.data_src = data_src;
> +	sample.weight = record->latency;

The latency can be used for branch operations as well, it's good to
assign latency for branch samples in the function
arm_spe__synth_branch_sample().

With adding latency for branch sample, the change would be good for me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

>  	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
> @@ -980,7 +981,8 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
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
> 2.34.0.rc2.393.gf8c9666880-goog
> 
