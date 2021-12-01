Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E80C4653B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351749AbhLARPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:15:46 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:47072 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351542AbhLARPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:15:21 -0500
Received: by mail-lf1-f50.google.com with SMTP id b1so64502350lfs.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6IfQaOcJ/fH2q47G9mTBeJcFONRdMwvYX52Dc3i4J4=;
        b=vASwe1HXy5GmVzceffqVaG4is0vaxhDVILO8FUSeW0nI1RSYOECgmRWRWKkEyq6uS8
         aRZxOJE+AcD1ZpweVvdvOVLLhnZw2FrWuOtqEstHRNLvp78rzfgJ/xl+L5wWrbIbse6/
         QpW/fv8ve1L8Z/1QQyYqWSGCB+uIcZiVd2iC5lQZPFCTN6Iz6qnBlvi7/G9d8vuv7lz1
         ejIRK/pEJ65sTIaKr/74jnbV9em3ZvQbUrZy1aohIpTzaEQhmmRSIdbXv3MDHEV9dyT5
         tX93l4CL7U7Gfd/I0Q/LdW4TrKJDCi3X/Cv9KKR+QsRlaMRoqQ320YFR6IGCEQ5b0EAC
         Gh8Q==
X-Gm-Message-State: AOAM5329zWlcgqE6brdK26khHABSWz5mLkNJSmpyTtqw9JGU5t0JrE1u
        ZM4auVhv4F+Vcm8FM4+QP3Q1CfU/QTIeROK1CZI=
X-Google-Smtp-Source: ABdhPJx1fyBel2blhToDUW5M4pmOyPneY6AYGGEN7b8kKOvaaTF/2hWKHfCz2QZNpgd/9LrjtbJfNTkaTNENkRTi5XM=
X-Received: by 2002:a05:6512:b8c:: with SMTP id b12mr6843885lfv.99.1638378718279;
 Wed, 01 Dec 2021 09:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20211201003908.1200945-1-namhyung@kernel.org> <20211201050836.GB2678859@leoy-ThinkPad-X240s>
In-Reply-To: <20211201050836.GB2678859@leoy-ThinkPad-X240s>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 1 Dec 2021 09:11:47 -0800
Message-ID: <CAM9d7cgMdkApk_WO3LdNyM6+Z041bkj2B4DqN8PLXWMMpTawAw@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Add SPE total latency as PERF_SAMPLE_WEIGHT
To:     Leo Yan <leo.yan@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Tue, Nov 30, 2021 at 9:08 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Namhyung,
>
> On Tue, Nov 30, 2021 at 04:39:08PM -0800, Namhyung Kim wrote:
> > Use total latency info in the SPE counter packet as sample weight so
> > that we can see it in local_weight and (global) weight sort keys.
> >
> > Maybe we can use PERF_SAMPLE_WEIGHT_STRUCT to support ins_lat as well
> > but I'm not sure which latency it matches.  So just adding total
> > latency first.
> >
> > Cc: German Gomez <german.gomez@arm.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
> >  tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
> >  tools/perf/util/arm-spe.c                         | 4 +++-
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > index 3fc528c9270c..5e390a1a79ab 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > @@ -179,6 +179,8 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
> >                               decoder->record.phys_addr = ip;
> >                       break;
> >               case ARM_SPE_COUNTER:
> > +                     if (idx == SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT)
> > +                             decoder->record.latency = payload;
> >                       break;
> >               case ARM_SPE_CONTEXT:
> >                       decoder->record.context_id = payload;
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > index 46a8556a9e95..69b31084d6be 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > @@ -33,6 +33,7 @@ struct arm_spe_record {
> >       enum arm_spe_sample_type type;
> >       int err;
> >       u32 op;
> > +     u32 latency;
> >       u64 from_ip;
> >       u64 to_ip;
> >       u64 timestamp;
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index 4748bcfe61de..a756325c72a7 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -317,6 +317,7 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
> >       sample.addr = record->virt_addr;
> >       sample.phys_addr = record->phys_addr;
> >       sample.data_src = data_src;
> > +     sample.weight = record->latency;
>
> The latency can be used for branch operations as well, it's good to
> assign latency for branch samples in the function
> arm_spe__synth_branch_sample().

Yep, I'll update.

>
> With adding latency for branch sample, the change would be good for me:
>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks for your review!
Namhyung


>
> >       return arm_spe_deliver_synth_event(spe, speq, event, &sample);
> >  }
> > @@ -980,7 +981,8 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
> >       attr.type = PERF_TYPE_HARDWARE;
> >       attr.sample_type = evsel->core.attr.sample_type & PERF_SAMPLE_MASK;
> >       attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
> > -                         PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC;
> > +                         PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC |
> > +                         PERF_SAMPLE_WEIGHT;
> >       if (spe->timeless_decoding)
> >               attr.sample_type &= ~(u64)PERF_SAMPLE_TIME;
> >       else
> > --
> > 2.34.0.rc2.393.gf8c9666880-goog
> >
