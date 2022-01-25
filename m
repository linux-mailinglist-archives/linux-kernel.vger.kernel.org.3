Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6BC49BD6C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiAYUtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:49:03 -0500
Received: from foss.arm.com ([217.140.110.172]:41624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232969AbiAYUsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:48:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F3F31FB;
        Tue, 25 Jan 2022 12:48:09 -0800 (PST)
Received: from [10.57.88.59] (unknown [10.57.88.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C551E3F7D8;
        Tue, 25 Jan 2022 12:48:05 -0800 (PST)
Subject: Re: [PATCH 1/2] perf arm-spe: Add arm_spe_record to synthesized
 sample
To:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     benh@kernel.crashing.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
References: <20220125192016.20538-1-alisaidi@amazon.com>
 <20220125192016.20538-2-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <5ca990a5-eedd-0edb-26d3-b5e16c36ac34@arm.com>
Date:   Tue, 25 Jan 2022 20:47:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220125192016.20538-2-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali,

On 25/01/2022 19:20, Ali Saidi wrote:
> Providing the arm_spe_record as raw data to the synthesized SPE samples
> allows perf scripts to read and separately process the data in ways
> existing perf tools don't support and mirrors functionality available
> for PEBS.
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> ---
>  tools/perf/util/arm-spe.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index d2b64e3f588b..a7499cde6fc0 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -336,6 +336,8 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
>  	sample.phys_addr = record->phys_addr;
>  	sample.data_src = data_src;
>  	sample.weight = record->latency;
> +	sample.raw_size = sizeof(*record);
> +	sample.raw_data = record;

Have you tried this with perf-inject? I think it would need the PERF_SAMPLE_RAW bit in the sample_type,

Although I quickly looked over the perf inject code and it looks like it's expecting some type of padding:

  // synthetic-events.c
  if (type & PERF_SAMPLE_RAW) {
    result += sizeof(u32);
    result += sample->raw_size;
  }

I'm seeing some comments in utils/event.h related to this on the intel events.

>  
>  	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
> @@ -354,6 +356,8 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
>  	sample.stream_id = spe_events_id;
>  	sample.addr = record->to_ip;
>  	sample.weight = record->latency;
> +	sample.raw_size = sizeof(*record);
> +	sample.raw_data = record;
>  
>  	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
> @@ -383,6 +387,8 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
>  	sample.data_src = data_src;
>  	sample.period = spe->instructions_sample_period;
>  	sample.weight = record->latency;
> +	sample.raw_size = sizeof(*record);
> +	sample.raw_data = record;
>  
>  	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
