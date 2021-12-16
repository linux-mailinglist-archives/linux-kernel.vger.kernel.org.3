Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB27A477533
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbhLPPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:00:40 -0500
Received: from foss.arm.com ([217.140.110.172]:44790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238197AbhLPPAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:00:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5B081435;
        Thu, 16 Dec 2021 07:00:36 -0800 (PST)
Received: from [10.1.26.143] (e127744.cambridge.arm.com [10.1.26.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB3F93F73B;
        Thu, 16 Dec 2021 07:00:34 -0800 (PST)
Subject: Re: [PATCH v2] perf arm-spe: Synthesize SPE instruction events
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211215184605.92787-1-german.gomez@arm.com>
 <20211216111157.GA27239@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <76953319-ec86-02b9-75c3-6e62c15b7f11@arm.com>
Date:   Thu, 16 Dec 2021 15:00:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211216111157.GA27239@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

Thanks for your comments. I'll send a revised patch shortly.

Thanks,
German

On 16/12/2021 11:11, Leo Yan wrote:
> Hi German,
>
> On Wed, Dec 15, 2021 at 06:46:05PM +0000, German Gomez wrote:
>> Synthesize instruction events per every decoded ARM SPE record.
>>
>> Because Arm SPE implements a hardware-based sample period, and perf
>> implements a software-based one that gets applied on top, also add a
>> warning to make the user aware.
>>
>> Signed-off-by: German Gomez <german.gomez@arm.com>
>> ---
>> Changes since v1 [https://lore.kernel.org/all/20211117142833.226629-1-german.gomez@arm.com]
>>   - Generate events with "--itrace=i" instead of "--itrace=o".
>>   - Generate events with virt_addr, phys_addr, and data_src values.
>> ---
>>  tools/perf/util/arm-spe.c | 58 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 58 insertions(+)
>>
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index fccac06b573a..879583822c8f 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -58,6 +58,8 @@ struct arm_spe {
>>  	u8				sample_branch;
>>  	u8				sample_remote_access;
>>  	u8				sample_memory;
>> +	u8				sample_instructions;
>> +	u64				instructions_sample_period;
>>  
>>  	u64				l1d_miss_id;
>>  	u64				l1d_access_id;
>> @@ -68,6 +70,7 @@ struct arm_spe {
>>  	u64				branch_miss_id;
>>  	u64				remote_access_id;
>>  	u64				memory_id;
>> +	u64				instructions_id;
>>  
>>  	u64				kernel_start;
>>  
>> @@ -90,6 +93,7 @@ struct arm_spe_queue {
>>  	u64				time;
>>  	u64				timestamp;
>>  	struct thread			*thread;
>> +	u64				period_instructions;
>>  };
>>  
>>  static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>> @@ -202,6 +206,7 @@ static struct arm_spe_queue *arm_spe__alloc_queue(struct arm_spe *spe,
>>  	speq->pid = -1;
>>  	speq->tid = -1;
>>  	speq->cpu = -1;
>> +	speq->period_instructions = 0;
>>  
>>  	/* params set */
>>  	params.get_trace = arm_spe_get_trace;
>> @@ -351,6 +356,33 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
>>  	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>>  }
>>  
>> +static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
>> +					     u64 spe_events_id, u64 data_src)
>> +{
>> +	struct arm_spe *spe = speq->spe;
>> +	struct arm_spe_record *record = &speq->decoder->record;
>> +	union perf_event *event = speq->event_buf;
>> +	struct perf_sample sample = { .ip = 0, };
>> +
>> +	/*
>> +	 * Handles perf instruction sampling period.
>> +	 */
>> +	speq->period_instructions++;
>> +	if (speq->period_instructions < spe->instructions_sample_period)
>> +		return 0;
>> +	speq->period_instructions = 0;
>> +
>> +	arm_spe_prep_sample(spe, speq, event, &sample);
>> +
>> +	sample.id = spe_events_id;
>> +	sample.stream_id = spe_events_id;
>> +	sample.addr = record->virt_addr;
>> +	sample.phys_addr = record->phys_addr;
>> +	sample.data_src = data_src;
>> +
>> +	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>> +}
>> +
>>  #define SPE_MEM_TYPE	(ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS | \
>>  			 ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS | \
>>  			 ARM_SPE_REMOTE_ACCESS)
>> @@ -480,6 +512,12 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>>  			return err;
>>  	}
>>  
>> +	if (spe->sample_instructions) {
>> +		err = arm_spe__synth_instruction_sample(speq, spe->instructions_id, data_src);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> @@ -1107,6 +1145,26 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>>  			return err;
>>  		spe->memory_id = id;
>>  		arm_spe_set_event_name(evlist, id, "memory");
>> +		id += 1;
>> +	}
>> +
>> +	if (spe->synth_opts.instructions) {
>> +		if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS)
>> +			return -EINVAL;
> Will this break some perf commands, like "perf report" or other perf
> report commands?
>
> See the the function arm_spe_process_auxtrace_info(), it invokes [1]:
>
>     itrace_synth_opts__set_default(&spe->synth_opts, false);
>
> So synth_opts.instructions is initialized to true,
> synth_opts.period_type is set to PERF_ITRACE_DEFAULT_PERIOD_TYPE (2),
> so the perf tool will directly bail out when synth_opts.period_type is
> not equal to PERF_ITRACE_PERIOD_INSTRUCTIONS.
>
> If we only support period type PERF_ITRACE_PERIOD_INSTRUCTIONS at
> current stage, I think we use the checking like below:
>
>   if (spe->synth_opts.instructions &&
>       (spe->synth_opts.period_type == PERF_ITRACE_PERIOD_INSTRUCTIONS)) {
>
>      ...
>   }
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/arm-spe.c#n1180
>
>> +
>> +		if (spe->synth_opts.period > 1)
>> +			pr_warning("Arm SPE has a hardware-based sample period.\n"
>> +				   "More instruction events will be discarded by --itrace\n");
> Okay, Since Arm SPE is statistical profiling, so this is the right thing to
> do.
>
> Please also address Namhyung's two comments, the rest of this patch looks
> good to me.
>
> Thanks,
> Leo
>
>> +
>> +		spe->sample_instructions = true;
>> +		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
>> +		attr.sample_period = spe->synth_opts.period;
>> +		spe->instructions_sample_period = attr.sample_period;
>> +		err = arm_spe_synth_event(session, &attr, id);
>> +		if (err)
>> +			return err;
>> +		spe->instructions_id = id;
>> +		arm_spe_set_event_name(evlist, id, "instructions");
>>  	}
>>  
>>  	return 0;
>> -- 
>> 2.25.1
>>
