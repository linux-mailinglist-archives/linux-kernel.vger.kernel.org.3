Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A21258DBAF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbiHIQNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiHIQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:13:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CFC19C1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:13:28 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v2so9021063lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8j5qXDWifiXWyB9skdF/rlZDC9hZ0mNrZm/vxwLPLtk=;
        b=BrITtp0om7iKmpB3yvq68x95VaktA8eQT+QZpqZ5S6QN5xMoArZUs6t7OP3t0PTgIP
         kcZL53ho/sr1PtPTeCkyBvz+X95WRNONVOfuIQQvPj84YbyRXhnB/gTVqOQTwRE50Pgb
         F23lxPuWcgxVYMdVkO4YAaqEQ8jOqR2mwbRlsLBizU2XQiN3cfERMFtbWAs64ANHcmO5
         bnSsLkWY7kalSwUko2HmGO7I0qiXOq3jhPpRGTEGQF7JZHyla2xnAViuEvlQ8uquCuyM
         qnFUScco68QnqIP0yIFxzuTxAMsF8+qQd9niL98/LbKUxO85q3Ck0V2vHi5sTn162Vhe
         JIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8j5qXDWifiXWyB9skdF/rlZDC9hZ0mNrZm/vxwLPLtk=;
        b=XYeawGRkGk5UUTAmBaW+kFsEqDH/6V8Bpbdq31YVyCDC/55WTIm/4UCQp2X9W4FhNZ
         0ztT6XjgEVnjup2XmoiJJNoYivvE2GL8xVQYqyLL/aJsCNS8n3KkkvN/bXhZsctvhaSD
         +w8pN9R95RsH8Kuyg6vKcEIaQpQtidsp8zS/lUe63BeTX/9Xof7jhQDErbiB9TwF4N07
         ZjD112Vy1P52uW1vfiTZNhETpUZWKmlbxwkmpZqL/9BYgce23tiOzuqQYuUy1eJghSo8
         reol7RdZqIa/ZfHSy6BOlvY24mthX13wz8U01RNyNrQa8i3U31JMUc13e8kozDfzuEyQ
         KoFg==
X-Gm-Message-State: ACgBeo1s9Z0MqNvZnq9g8RcYliFakMqamKV96J32zHEcMo7jlGQ8Bqn1
        qFog2+so+/lTQVVBKLz25OP0q3I2VmthafCUeO418ZERFW1S2Q==
X-Google-Smtp-Source: AA6agR4/Iq6TdI72U9s9fsSvMjf/6hTTe1uLDoGSAz883Xm6nuBlvnTdD3AUbvBNcl0EC4ihRwuwgMXjDO/RMf8yexo=
X-Received: by 2002:a05:6512:2314:b0:48c:f43c:3a39 with SMTP id
 o20-20020a056512231400b0048cf43c3a39mr2917106lfu.419.1660061606534; Tue, 09
 Aug 2022 09:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220704081149.16797-1-mike.leach@linaro.org> <20220704081149.16797-10-mike.leach@linaro.org>
 <5e8981b1-1c32-7ef0-0ef9-93799a8c968b@arm.com>
In-Reply-To: <5e8981b1-1c32-7ef0-0ef9-93799a8c968b@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 9 Aug 2022 17:13:15 +0100
Message-ID: <CAJ9a7Vi63XxDXtT8KD2-3=n5+de6_ZfD+X=jtPK+puM7f4koNw@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] perf: cs-etm: Update record event to use new
 Trace ID protocol
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        quic_jinlmao@quicinc.com, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

On Wed, 20 Jul 2022 at 15:41, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 04/07/2022 09:11, Mike Leach wrote:
> > Trace IDs are now dynamically allocated.
> >
> > Previously used the static association algorithm that is no longer
> > used. The 'cpu * 2 + seed' was outdated and broken for systems with high
> > core counts (>46). as it did not scale and was broken for larger
> > core counts.
> >
> > Trace ID is  as unknown in AUXINFO record, and the ID / CPU association
> > will now be sent in PERF_RECORD_AUX_OUTPUT_HW_ID record.
> >
> > Remove legacy Trace ID allocation algorithm.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >  include/linux/coresight-pmu.h       | 19 +++++++------------
> >  tools/include/linux/coresight-pmu.h | 19 +++++++------------
>
> I usually see mentions that these header updates need to be separate commits
> because they are merged through different trees.
>
> >  tools/perf/arch/arm/util/cs-etm.c   | 21 ++++++++++++---------
> >  3 files changed, 26 insertions(+), 33 deletions(-)
> >
> > diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> > index 4ac5c081af93..9f7ee380266b 100644
> > --- a/include/linux/coresight-pmu.h
> > +++ b/include/linux/coresight-pmu.h
> > @@ -8,7 +8,13 @@
> >  #define _LINUX_CORESIGHT_PMU_H
> >
> >  #define CORESIGHT_ETM_PMU_NAME "cs_etm"
> > -#define CORESIGHT_ETM_PMU_SEED  0x10
> > +
> > +/*
> > + * Metadata now contains an unused trace ID - IDs are transmitted using a
> > + * PERF_RECORD_AUX_OUTPUT_HW_ID record.
> > + * Value architecturally defined as reserved in CoreSight.
> > + */
> > +#define CS_UNUSED_TRACE_ID 0x7F
> >
> >  /*
> >   * Below are the definition of bit offsets for perf option, and works as
> > @@ -32,15 +38,4 @@
> >  #define ETM4_CFG_BIT_RETSTK  12
> >  #define ETM4_CFG_BIT_VMID_OPT        15
> >
> > -static inline int coresight_get_trace_id(int cpu)
> > -{
> > -     /*
> > -      * A trace ID of value 0 is invalid, so let's start at some
> > -      * random value that fits in 7 bits and go from there.  Since
> > -      * the common convention is to have data trace IDs be I(N) + 1,
> > -      * set instruction trace IDs as a function of the CPU number.
> > -      */
> > -     return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
> > -}
> > -
> >  #endif
> > diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> > index 6c2fd6cc5a98..31d007fab3a6 100644
> > --- a/tools/include/linux/coresight-pmu.h
> > +++ b/tools/include/linux/coresight-pmu.h
> > @@ -8,7 +8,13 @@
> >  #define _LINUX_CORESIGHT_PMU_H
> >
> >  #define CORESIGHT_ETM_PMU_NAME "cs_etm"
> > -#define CORESIGHT_ETM_PMU_SEED  0x10
> > +
> > +/*
> > + * Metadata now contains an unused trace ID - IDs are transmitted using a
> > + * PERF_RECORD_AUX_OUTPUT_HW_ID record.
> > + * Value architecturally defined as reserved in CoreSight.
> > + */
> > +#define CS_UNUSED_TRACE_ID 0x7F
> >
>
> minor nit: this isn't used in the kernel so only needs to be defined on the
> tools side.
>

Unfortunately if the two versions of coresight-pmu.h are different,
the build process for perf throws out a warning. So they have to be
identical.

Thanks

Mike

> >  /*
> >   * Below are the definition of bit offsets for perf option, and works as
> > @@ -34,15 +40,4 @@
> >  #define ETM4_CFG_BIT_RETSTK  12
> >  #define ETM4_CFG_BIT_VMID_OPT        15
> >
> > -static inline int coresight_get_trace_id(int cpu)
> > -{
> > -     /*
> > -      * A trace ID of value 0 is invalid, so let's start at some
> > -      * random value that fits in 7 bits and go from there.  Since
> > -      * the common convention is to have data trace IDs be I(N) + 1,
> > -      * set instruction trace IDs as a function of the CPU number.
> > -      */
> > -     return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
> > -}
> > -
> >  #endif
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > index 1b54638d53b0..2d68e6a722ed 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -421,13 +421,16 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
> >       evlist__to_front(evlist, cs_etm_evsel);
> >
> >       /*
> > -      * In the case of per-cpu mmaps, we need the CPU on the
> > -      * AUX event.  We also need the contextID in order to be notified
> > +      * get the CPU on the sample - need it to associate trace ID in the
> > +      * AUX_OUTPUT_HW_ID event, and the AUX event for per-cpu mmaps.
> > +      */
> > +     evsel__set_sample_bit(cs_etm_evsel, CPU);
> > +
> > +     /*
> > +      * Also the case of per-cpu mmaps, need the contextID in order to be notified
> >        * when a context switch happened.
> >        */
> >       if (!perf_cpu_map__empty(cpus)) {
> > -             evsel__set_sample_bit(cs_etm_evsel, CPU);
> > -
> >               err = cs_etm_set_option(itr, cs_etm_evsel,
> >                                       BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_TS));
> >               if (err)
> > @@ -633,8 +636,9 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
> >
> >       /* Get trace configuration register */
> >       data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
> > -     /* Get traceID from the framework */
> > -     data[CS_ETMV4_TRCTRACEIDR] = coresight_get_trace_id(cpu);
> > +     /* traceID set to unused */
> > +     data[CS_ETMV4_TRCTRACEIDR] = CS_UNUSED_TRACE_ID;
> > +
> >       /* Get read-only information from sysFS */
> >       data[CS_ETMV4_TRCIDR0] = cs_etm_get_ro(cs_etm_pmu, cpu,
> >                                              metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
> > @@ -681,9 +685,8 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
> >               magic = __perf_cs_etmv3_magic;
> >               /* Get configuration register */
> >               info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
> > -             /* Get traceID from the framework */
> > -             info->priv[*offset + CS_ETM_ETMTRACEIDR] =
> > -                                             coresight_get_trace_id(cpu);
> > +             /* traceID set to unused */
> > +             info->priv[*offset + CS_ETM_ETMTRACEIDR] = CS_UNUSED_TRACE_ID;
> >               /* Get read-only information from sysFS */
> >               info->priv[*offset + CS_ETM_ETMCCER] =
> >                       cs_etm_get_ro(cs_etm_pmu, cpu,



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
