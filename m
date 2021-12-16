Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73C9476760
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhLPBTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:19:07 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:44822 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhLPBTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:19:07 -0500
Received: by mail-lj1-f182.google.com with SMTP id 13so35872768ljj.11;
        Wed, 15 Dec 2021 17:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZKUn3GCBDz2WpYjOXh7PtPogJCr66ag+GjS2ceVRcg=;
        b=s3nw8yGh71XjV7Bv/D1I7Y57D4xyApq0GboGiTOVAVscfCHoq5OqmMW3S08UiKXjtL
         a4o0HDqrN+4ybOD2fFbDPL7Ba7KD24jJ0htOEun4RX7JMdL/B7ukJb4AUKhvhxka/eOG
         6psp1POWoiQOy2JByvix/n9WMzVj0KxAe0KKI2k05eux4t51Dc8WqEFoUa+b5quAmVU3
         cVea990apie7l48lUYIt81UPL/psu6dRye4In0Xnj5VxXJLkW5D1j5NiKbiaf958Dt5s
         yo3PAMiq2yq/hWoC3YvDgsI2HYVGYWjWBkSOJgQRtnHHdsTDIpa/pl7HjVSWbULdhqK8
         7mDw==
X-Gm-Message-State: AOAM533iZa2+klxK2lyOoFqS5X7Sgym2lTcurazWEq90SqlNTlJFKTVk
        Z/ANvjHmvnmeBtoVy18BUT6Wr77D9cf6gx/r+s0=
X-Google-Smtp-Source: ABdhPJyAZS7YytXVOSC49P1V1k0PMVprK59J8sBgkcMw95YIgHWtwjydy/ft8xsQVeG/2oqWXh36kBYP7t28bPRxJY4=
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr12273119ljp.204.1639617545518;
 Wed, 15 Dec 2021 17:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20211215184605.92787-1-german.gomez@arm.com>
In-Reply-To: <20211215184605.92787-1-german.gomez@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Dec 2021 17:18:54 -0800
Message-ID: <CAM9d7ch1eotRphCwFi_ryQdWD8DPNsZUN+aW7kaxovWtmCJcMQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf arm-spe: Synthesize SPE instruction events
To:     German Gomez <german.gomez@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 15, 2021 at 10:46 AM German Gomez <german.gomez@arm.com> wrote:
>
> Synthesize instruction events per every decoded ARM SPE record.
>
> Because Arm SPE implements a hardware-based sample period, and perf
> implements a software-based one that gets applied on top, also add a
> warning to make the user aware.
>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
> Changes since v1 [https://lore.kernel.org/all/20211117142833.226629-1-german.gomez@arm.com]
>   - Generate events with "--itrace=i" instead of "--itrace=o".
>   - Generate events with virt_addr, phys_addr, and data_src values.
> ---
>  tools/perf/util/arm-spe.c | 58 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index fccac06b573a..879583822c8f 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -58,6 +58,8 @@ struct arm_spe {
>         u8                              sample_branch;
>         u8                              sample_remote_access;
>         u8                              sample_memory;
> +       u8                              sample_instructions;
> +       u64                             instructions_sample_period;
>
>         u64                             l1d_miss_id;
>         u64                             l1d_access_id;
> @@ -68,6 +70,7 @@ struct arm_spe {
>         u64                             branch_miss_id;
>         u64                             remote_access_id;
>         u64                             memory_id;
> +       u64                             instructions_id;
>
>         u64                             kernel_start;
>
> @@ -90,6 +93,7 @@ struct arm_spe_queue {
>         u64                             time;
>         u64                             timestamp;
>         struct thread                   *thread;
> +       u64                             period_instructions;
>  };
>
>  static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
> @@ -202,6 +206,7 @@ static struct arm_spe_queue *arm_spe__alloc_queue(struct arm_spe *spe,
>         speq->pid = -1;
>         speq->tid = -1;
>         speq->cpu = -1;
> +       speq->period_instructions = 0;
>
>         /* params set */
>         params.get_trace = arm_spe_get_trace;
> @@ -351,6 +356,33 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
>         return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
>
> +static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
> +                                            u64 spe_events_id, u64 data_src)
> +{
> +       struct arm_spe *spe = speq->spe;
> +       struct arm_spe_record *record = &speq->decoder->record;
> +       union perf_event *event = speq->event_buf;
> +       struct perf_sample sample = { .ip = 0, };
> +
> +       /*
> +        * Handles perf instruction sampling period.
> +        */
> +       speq->period_instructions++;
> +       if (speq->period_instructions < spe->instructions_sample_period)
> +               return 0;
> +       speq->period_instructions = 0;
> +
> +       arm_spe_prep_sample(spe, speq, event, &sample);
> +
> +       sample.id = spe_events_id;
> +       sample.stream_id = spe_events_id;
> +       sample.addr = record->virt_addr;
> +       sample.phys_addr = record->phys_addr;
> +       sample.data_src = data_src;

I think it should set sample.period to spe->instructions_sample_period.

Also it can set sample.weight but I think we lost my patch

  https://lore.kernel.org/r/20211201220855.1260688-1-namhyung@kernel.org

Arnaldo, can you please take a look?

> +
> +       return arm_spe_deliver_synth_event(spe, speq, event, &sample);
> +}
> +
>  #define SPE_MEM_TYPE   (ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS | \
>                          ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS | \
>                          ARM_SPE_REMOTE_ACCESS)
> @@ -480,6 +512,12 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>                         return err;
>         }
>
> +       if (spe->sample_instructions) {
> +               err = arm_spe__synth_instruction_sample(speq, spe->instructions_id, data_src);
> +               if (err)
> +                       return err;
> +       }
> +
>         return 0;
>  }
>
> @@ -1107,6 +1145,26 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>                         return err;
>                 spe->memory_id = id;
>                 arm_spe_set_event_name(evlist, id, "memory");
> +               id += 1;
> +       }
> +
> +       if (spe->synth_opts.instructions) {
> +               if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS)
> +                       return -EINVAL;
> +
> +               if (spe->synth_opts.period > 1)
> +                       pr_warning("Arm SPE has a hardware-based sample period.\n"
> +                                  "More instruction events will be discarded by --itrace\n");
> +
> +               spe->sample_instructions = true;
> +               attr.config = PERF_COUNT_HW_INSTRUCTIONS;
> +               attr.sample_period = spe->synth_opts.period;
> +               spe->instructions_sample_period = attr.sample_period;
> +               err = arm_spe_synth_event(session, &attr, id);
> +               if (err)
> +                       return err;
> +               spe->instructions_id = id;
> +               arm_spe_set_event_name(evlist, id, "instructions");

Yeah, I think it's a better name than "all". :)

Thanks,
Namhyung


>         }
>
>         return 0;
> --
> 2.25.1
>
