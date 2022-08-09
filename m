Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836BF58DBBE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbiHIQTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiHIQTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:19:48 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE8E1EC42;
        Tue,  9 Aug 2022 09:19:46 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id c3so12400772vsc.6;
        Tue, 09 Aug 2022 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc;
        bh=hI1KeTVw2QSPVOaYjNQLNPYoNVxx6u2f2MGmtBinVvQ=;
        b=QHCnwbKRIOVTg/a1K8DiFchPY7rF9SNN7NJ2JUUV40N+pIs+WsfaY6/V9HtftEmoZE
         XyXtg25LJ7UbzOw6Gf0p5ONLJNJryEefmL/vbOocwoRMPs5HiNBgF3nL34xAKRbR3327
         CkwdB2zzFt6HOTL01ZiXb7YDPCRjH8yD8CGNvxzxZutH2vipQTDU5zddY5sr6Iv5TwBl
         IIamMTZ2BAoBZY4aU7BC2HVNsd2EemtITTjcyI3bhSlOIxyGTHQ/e4PeLPWKhe9YRB6z
         qwai0CmSEgaukTQISQCUUdlfWrcrOWlmNkbwKzo7X/+fyrpkEU2z7fk06AzgKM0eUVpK
         6ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=hI1KeTVw2QSPVOaYjNQLNPYoNVxx6u2f2MGmtBinVvQ=;
        b=HuLXlXjM2r0M41aUs2cR3GzxCfMPVbJTAGwXQUh2eyUuOdbeTj0hl5EqaBmFV7GbQX
         9RmagbTENLpsKY3zjIWzv09rTv/Uig8NCaU+n9zZLzxMze85SN49nNwZhr7D09v+S8L3
         qx39eB7iy++HTU+NEIM0JETfm0tZfSQFIZu9WATS9Ugdo9+60CfC27TIsNXI3deFabvW
         EMz3+P5Khd6i1xgmmkbugqV3sYjetKSVVy0RxVloum/ZNn7FVmqQwHpvJ0e9ztv/VltL
         ccd3EconX8vZ5OpIEIcjhAwCqcgRmxIkGdhz/Q6irFwYBjCq0XFlmvSj7PGrhkQvZaIC
         Z9pw==
X-Gm-Message-State: ACgBeo26uZNt5YcZYgwlbyn37syf77d7Tu1P0IOSSDIxD4SDVLJxejsO
        hj0fC49gXtD0PGthLREAvqYKFWt14L4=
X-Google-Smtp-Source: AA6agR6qMEODOupoh2J6DjwGWiYP4PJMq3KqUQSSpJof2T1em6ioJB4HUVrKo30qHg2wXnhTcDEtwA==
X-Received: by 2002:a05:6102:3d9a:b0:388:b72a:7e4 with SMTP id h26-20020a0561023d9a00b00388b72a07e4mr4304331vsv.32.1660061985885;
        Tue, 09 Aug 2022 09:19:45 -0700 (PDT)
Received: from [127.0.0.1] ([187.19.239.32])
        by smtp.gmail.com with ESMTPSA id t24-20020ab06998000000b00384cd1abe50sm11679888uaq.32.2022.08.09.09.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 09:19:45 -0700 (PDT)
Date:   Tue, 09 Aug 2022 13:19:40 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>
CC:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        quic_jinlmao@quicinc.com, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_09/13=5D_perf=3A_cs-etm=3A_Update?= =?US-ASCII?Q?_record_event_to_use_new_Trace_ID_protocol?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJ9a7Vi63XxDXtT8KD2-3=n5+de6_ZfD+X=jtPK+puM7f4koNw@mail.gmail.com>
References: <20220704081149.16797-1-mike.leach@linaro.org> <20220704081149.16797-10-mike.leach@linaro.org> <5e8981b1-1c32-7ef0-0ef9-93799a8c968b@arm.com> <CAJ9a7Vi63XxDXtT8KD2-3=n5+de6_ZfD+X=jtPK+puM7f4koNw@mail.gmail.com>
Message-ID: <0C948A97-11E6-40DF-8AAE-94E13B4E8BF2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 9, 2022 1:13:15 PM GMT-03:00, Mike Leach <mike=2Eleach@linaro=2E=
org> wrote:
>Hi James
>
>On Wed, 20 Jul 2022 at 15:41, James Clark <james=2Eclark@arm=2Ecom> wrote=
:
>>
>>
>>
>> On 04/07/2022 09:11, Mike Leach wrote:
>> > Trace IDs are now dynamically allocated=2E
>> >
>> > Previously used the static association algorithm that is no longer
>> > used=2E The 'cpu * 2 + seed' was outdated and broken for systems with=
 high
>> > core counts (>46)=2E as it did not scale and was broken for larger
>> > core counts=2E
>> >
>> > Trace ID is  as unknown in AUXINFO record, and the ID / CPU associati=
on
>> > will now be sent in PERF_RECORD_AUX_OUTPUT_HW_ID record=2E
>> >
>> > Remove legacy Trace ID allocation algorithm=2E
>> >
>> > Signed-off-by: Mike Leach <mike=2Eleach@linaro=2Eorg>
>> > ---
>> >  include/linux/coresight-pmu=2Eh       | 19 +++++++------------
>> >  tools/include/linux/coresight-pmu=2Eh | 19 +++++++------------
>>
>> I usually see mentions that these header updates need to be separate co=
mmits
>> because they are merged through different trees=2E
>>
>> >  tools/perf/arch/arm/util/cs-etm=2Ec   | 21 ++++++++++++---------
>> >  3 files changed, 26 insertions(+), 33 deletions(-)
>> >
>> > diff --git a/include/linux/coresight-pmu=2Eh b/include/linux/coresigh=
t-pmu=2Eh
>> > index 4ac5c081af93=2E=2E9f7ee380266b 100644
>> > --- a/include/linux/coresight-pmu=2Eh
>> > +++ b/include/linux/coresight-pmu=2Eh
>> > @@ -8,7 +8,13 @@
>> >  #define _LINUX_CORESIGHT_PMU_H
>> >
>> >  #define CORESIGHT_ETM_PMU_NAME "cs_etm"
>> > -#define CORESIGHT_ETM_PMU_SEED  0x10
>> > +
>> > +/*
>> > + * Metadata now contains an unused trace ID - IDs are transmitted us=
ing a
>> > + * PERF_RECORD_AUX_OUTPUT_HW_ID record=2E
>> > + * Value architecturally defined as reserved in CoreSight=2E
>> > + */
>> > +#define CS_UNUSED_TRACE_ID 0x7F
>> >
>> >  /*
>> >   * Below are the definition of bit offsets for perf option, and work=
s as
>> > @@ -32,15 +38,4 @@
>> >  #define ETM4_CFG_BIT_RETSTK  12
>> >  #define ETM4_CFG_BIT_VMID_OPT        15
>> >
>> > -static inline int coresight_get_trace_id(int cpu)
>> > -{
>> > -     /*
>> > -      * A trace ID of value 0 is invalid, so let's start at some
>> > -      * random value that fits in 7 bits and go from there=2E  Since
>> > -      * the common convention is to have data trace IDs be I(N) + 1,
>> > -      * set instruction trace IDs as a function of the CPU number=2E
>> > -      */
>> > -     return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
>> > -}
>> > -
>> >  #endif
>> > diff --git a/tools/include/linux/coresight-pmu=2Eh b/tools/include/li=
nux/coresight-pmu=2Eh
>> > index 6c2fd6cc5a98=2E=2E31d007fab3a6 100644
>> > --- a/tools/include/linux/coresight-pmu=2Eh
>> > +++ b/tools/include/linux/coresight-pmu=2Eh
>> > @@ -8,7 +8,13 @@
>> >  #define _LINUX_CORESIGHT_PMU_H
>> >
>> >  #define CORESIGHT_ETM_PMU_NAME "cs_etm"
>> > -#define CORESIGHT_ETM_PMU_SEED  0x10
>> > +
>> > +/*
>> > + * Metadata now contains an unused trace ID - IDs are transmitted us=
ing a
>> > + * PERF_RECORD_AUX_OUTPUT_HW_ID record=2E
>> > + * Value architecturally defined as reserved in CoreSight=2E
>> > + */
>> > +#define CS_UNUSED_TRACE_ID 0x7F
>> >
>>
>> minor nit: this isn't used in the kernel so only needs to be defined on=
 the
>> tools side=2E
>>
>
>Unfortunately if the two versions of coresight-pmu=2Eh are different,
>the build process for perf throws out a warning=2E So they have to be
>identical=2E

James is right, don't worry about the warning, kernel stuff can't go via t=
he perf-tools tree=2E

- Arnaldo

>
>Thanks
>
>Mike
>
>> >  /*
>> >   * Below are the definition of bit offsets for perf option, and work=
s as
>> > @@ -34,15 +40,4 @@
>> >  #define ETM4_CFG_BIT_RETSTK  12
>> >  #define ETM4_CFG_BIT_VMID_OPT        15
>> >
>> > -static inline int coresight_get_trace_id(int cpu)
>> > -{
>> > -     /*
>> > -      * A trace ID of value 0 is invalid, so let's start at some
>> > -      * random value that fits in 7 bits and go from there=2E  Since
>> > -      * the common convention is to have data trace IDs be I(N) + 1,
>> > -      * set instruction trace IDs as a function of the CPU number=2E
>> > -      */
>> > -     return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
>> > -}
>> > -
>> >  #endif
>> > diff --git a/tools/perf/arch/arm/util/cs-etm=2Ec b/tools/perf/arch/ar=
m/util/cs-etm=2Ec
>> > index 1b54638d53b0=2E=2E2d68e6a722ed 100644
>> > --- a/tools/perf/arch/arm/util/cs-etm=2Ec
>> > +++ b/tools/perf/arch/arm/util/cs-etm=2Ec
>> > @@ -421,13 +421,16 @@ static int cs_etm_recording_options(struct auxt=
race_record *itr,
>> >       evlist__to_front(evlist, cs_etm_evsel);
>> >
>> >       /*
>> > -      * In the case of per-cpu mmaps, we need the CPU on the
>> > -      * AUX event=2E  We also need the contextID in order to be noti=
fied
>> > +      * get the CPU on the sample - need it to associate trace ID in=
 the
>> > +      * AUX_OUTPUT_HW_ID event, and the AUX event for per-cpu mmaps=
=2E
>> > +      */
>> > +     evsel__set_sample_bit(cs_etm_evsel, CPU);
>> > +
>> > +     /*
>> > +      * Also the case of per-cpu mmaps, need the contextID in order =
to be notified
>> >        * when a context switch happened=2E
>> >        */
>> >       if (!perf_cpu_map__empty(cpus)) {
>> > -             evsel__set_sample_bit(cs_etm_evsel, CPU);
>> > -
>> >               err =3D cs_etm_set_option(itr, cs_etm_evsel,
>> >                                       BIT(ETM_OPT_CTXTID) | BIT(ETM_O=
PT_TS));
>> >               if (err)
>> > @@ -633,8 +636,9 @@ static void cs_etm_save_etmv4_header(__u64 data[]=
, struct auxtrace_record *itr,
>> >
>> >       /* Get trace configuration register */
>> >       data[CS_ETMV4_TRCCONFIGR] =3D cs_etmv4_get_config(itr);
>> > -     /* Get traceID from the framework */
>> > -     data[CS_ETMV4_TRCTRACEIDR] =3D coresight_get_trace_id(cpu);
>> > +     /* traceID set to unused */
>> > +     data[CS_ETMV4_TRCTRACEIDR] =3D CS_UNUSED_TRACE_ID;
>> > +
>> >       /* Get read-only information from sysFS */
>> >       data[CS_ETMV4_TRCIDR0] =3D cs_etm_get_ro(cs_etm_pmu, cpu,
>> >                                              metadata_etmv4_ro[CS_ETM=
V4_TRCIDR0]);
>> > @@ -681,9 +685,8 @@ static void cs_etm_get_metadata(int cpu, u32 *off=
set,
>> >               magic =3D __perf_cs_etmv3_magic;
>> >               /* Get configuration register */
>> >               info->priv[*offset + CS_ETM_ETMCR] =3D cs_etm_get_confi=
g(itr);
>> > -             /* Get traceID from the framework */
>> > -             info->priv[*offset + CS_ETM_ETMTRACEIDR] =3D
>> > -                                             coresight_get_trace_id(=
cpu);
>> > +             /* traceID set to unused */
>> > +             info->priv[*offset + CS_ETM_ETMTRACEIDR] =3D CS_UNUSED_=
TRACE_ID;
>> >               /* Get read-only information from sysFS */
>> >               info->priv[*offset + CS_ETM_ETMCCER] =3D
>> >                       cs_etm_get_ro(cs_etm_pmu, cpu,
>
>
>
