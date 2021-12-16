Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C6D476F94
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhLPLMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:12:00 -0500
Received: from foss.arm.com ([217.140.110.172]:42122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231372AbhLPLL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:11:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B14291474;
        Thu, 16 Dec 2021 03:11:57 -0800 (PST)
Received: from [10.57.5.180] (unknown [10.57.5.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8237F3F774;
        Thu, 16 Dec 2021 03:11:55 -0800 (PST)
Subject: Re: [PATCH v2] perf arm-spe: Synthesize SPE instruction events
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org
References: <20211215184605.92787-1-german.gomez@arm.com>
 <CAM9d7ch1eotRphCwFi_ryQdWD8DPNsZUN+aW7kaxovWtmCJcMQ@mail.gmail.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <3df80677-1894-54c3-6383-94902c6e9ee8@arm.com>
Date:   Thu, 16 Dec 2021 11:11:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7ch1eotRphCwFi_ryQdWD8DPNsZUN+aW7kaxovWtmCJcMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung, thanks for your comments.

On 16/12/2021 01:18, Namhyung Kim wrote:
> Hello,
>
> On Wed, Dec 15, 2021 at 10:46 AM German Gomez <german.gomez@arm.com> wrote:
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
>>         u8                              sample_branch;
>>         u8                              sample_remote_access;
>>         u8                              sample_memory;
>> +       u8                              sample_instructions;
>> +       u64                             instructions_sample_period;
>>
>>         u64                             l1d_miss_id;
>>         u64                             l1d_access_id;
>> @@ -68,6 +70,7 @@ struct arm_spe {
>>         u64                             branch_miss_id;
>>         u64                             remote_access_id;
>>         u64                             memory_id;
>> +       u64                             instructions_id;
>>
>>         u64                             kernel_start;
>>
>> @@ -90,6 +93,7 @@ struct arm_spe_queue {
>>         u64                             time;
>>         u64                             timestamp;
>>         struct thread                   *thread;
>> +       u64                             period_instructions;
>>  };
>>
>>  static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>> @@ -202,6 +206,7 @@ static struct arm_spe_queue *arm_spe__alloc_queue(struct arm_spe *spe,
>>         speq->pid = -1;
>>         speq->tid = -1;
>>         speq->cpu = -1;
>> +       speq->period_instructions = 0;
>>
>>         /* params set */
>>         params.get_trace = arm_spe_get_trace;
>> @@ -351,6 +356,33 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
>>         return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>>  }
>>
>> +static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
>> +                                            u64 spe_events_id, u64 data_src)
>> +{
>> +       struct arm_spe *spe = speq->spe;
>> +       struct arm_spe_record *record = &speq->decoder->record;
>> +       union perf_event *event = speq->event_buf;
>> +       struct perf_sample sample = { .ip = 0, };
>> +
>> +       /*
>> +        * Handles perf instruction sampling period.
>> +        */
>> +       speq->period_instructions++;
>> +       if (speq->period_instructions < spe->instructions_sample_period)
>> +               return 0;
>> +       speq->period_instructions = 0;
>> +
>> +       arm_spe_prep_sample(spe, speq, event, &sample);
>> +
>> +       sample.id = spe_events_id;
>> +       sample.stream_id = spe_events_id;
>> +       sample.addr = record->virt_addr;
>> +       sample.phys_addr = record->phys_addr;
>> +       sample.data_src = data_src;
> I think it should set sample.period to spe->instructions_sample_period.

Ack!

>
> Also it can set sample.weight but I think we lost my patch

I forgot to apply your latency patch first. I will add it.

Thanks,
German

>
>   https://lore.kernel.org/r/20211201220855.1260688-1-namhyung@kernel.org
>
> Arnaldo, can you please take a look?
>
>> +
>> +       return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>> +}
>> +
>>  #define SPE_MEM_TYPE   (ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS | \
>>                          ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS | \
>>                          ARM_SPE_REMOTE_ACCESS)
>> @@ -480,6 +512,12 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>>                         return err;
>>         }
>>
>> +       if (spe->sample_instructions) {
>> +               err = arm_spe__synth_instruction_sample(speq, spe->instructions_id, data_src);
>> +               if (err)
>> +                       return err;
>> +       }
>> +
>>         return 0;
>>  }
>>
>> @@ -1107,6 +1145,26 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>>                         return err;
>>                 spe->memory_id = id;
>>                 arm_spe_set_event_name(evlist, id, "memory");
>> +               id += 1;
>> +       }
>> +
>> +       if (spe->synth_opts.instructions) {
>> +               if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS)
>> +                       return -EINVAL;
>> +
>> +               if (spe->synth_opts.period > 1)
>> +                       pr_warning("Arm SPE has a hardware-based sample period.\n"
>> +                                  "More instruction events will be discarded by --itrace\n");
>> +
>> +               spe->sample_instructions = true;
>> +               attr.config = PERF_COUNT_HW_INSTRUCTIONS;
>> +               attr.sample_period = spe->synth_opts.period;
>> +               spe->instructions_sample_period = attr.sample_period;
>> +               err = arm_spe_synth_event(session, &attr, id);
>> +               if (err)
>> +                       return err;
>> +               spe->instructions_id = id;
>> +               arm_spe_set_event_name(evlist, id, "instructions");
> Yeah, I think it's a better name than "all". :)
>
> Thanks,
> Namhyung
>
>
>>         }
>>
>>         return 0;
>> --
>> 2.25.1
>>
