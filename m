Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1272759A3FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351612AbiHSRyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351434AbiHSRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:53:26 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288DE9F750;
        Fri, 19 Aug 2022 10:29:04 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id i5so2026903uat.6;
        Fri, 19 Aug 2022 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc;
        bh=mfrYa4ZKrUxx0QbFnM9sLgVno+jJEtT0xLw8EOHoA5I=;
        b=PfMAnEzp+aD/499e5nhuh2ZgTeObV+mZqei9PGX0Q8F5jWAfSyHl+WZUphM2xYTi+C
         zUjcvDzxn75Rv6aEq5d5X69W9GAZQNuuyjwYTTgRWlaWHtqP1gLDfywjIUdey5gEUBp4
         xlmk8PvThAi3harxMnOm7Pd8CoKOrxAG3U5e+sKLLvqJozqifycSrThXGhlhHVQYS07M
         Lu18mx61YP8rCFHOH26uCGi4imN/J6FlQfF1hmKpi8jacHekFjgaQ4ag1I8ueROOPjO/
         6SrFVxrc6y63fmqniRVJNq3kSIBE8u+3ZknRnALOhwqFNBBYhnRldLKp4s8ZZwoYW2Jl
         Lm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=mfrYa4ZKrUxx0QbFnM9sLgVno+jJEtT0xLw8EOHoA5I=;
        b=W5MDssXHiUOLFPa6BOH6vbXUsjf0uNsLn+EPzDJzAEcQdNKxGeL64zwIjy6aT9TyRl
         6iq+ws0WJJeSEQ8rvdstYCUCpy3ubVhnTSz9BN15SZ84sYi3kpUnonc/U7TZnUAiZugP
         oOXNY9+et7qudCO8i2ehMg3uK/7RnFKjclbYQA+oF+HDl/3NLBHF+TQSCASEipGmD3Ky
         0g15F5vG6Krc2JY0YkmegXU9XSOLqMZv0T4WnNP9LsDo4XLPJLxqsgZX9UdtF6OUMErx
         m/BScyZ+YHKuSELaKwwMHsn5ydqwU9GG9r4WsmwUVvYTA/s0bI4dHO7Pqgc0ugfrGcqz
         71Og==
X-Gm-Message-State: ACgBeo3gztnsRc/PLIYHUYMAADZjTbnWeunfq1ih82NVhC/UOyrDwfCT
        VbZgia5xPEYEP5jx/6EpKI0=
X-Google-Smtp-Source: AA6agR4KacLRL9tOtrGs3oCH3TXIdhPwB4IRqzMHW68GUcaIvytInllnOuIQev2Sb5nS24m4NEJgBg==
X-Received: by 2002:ab0:2697:0:b0:39a:c3ab:8060 with SMTP id t23-20020ab02697000000b0039ac3ab8060mr3055838uao.4.1660930143146;
        Fri, 19 Aug 2022 10:29:03 -0700 (PDT)
Received: from [127.0.0.1] ([187.19.239.32])
        by smtp.gmail.com with ESMTPSA id z190-20020a1fc9c7000000b003777cf035a4sm2887616vkf.33.2022.08.19.10.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 10:29:02 -0700 (PDT)
Date:   Fri, 19 Aug 2022 14:28:56 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_4/6=5D_perf_cpumap=3A_Fix_?= =?US-ASCII?Q?alignment_for_masks_in_event_encoding?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP-5=fWi5KaV40jcC1ZGfTAJ+bc52ueMvd0yREUHxSYk7y1MNw@mail.gmail.com>
References: <20220614143353.1559597-1-irogers@google.com> <20220614143353.1559597-5-irogers@google.com> <Yv60COAP90TEiWkx@kernel.org> <Yv+zK8UxUAP83zkp@kernel.org> <CAP-5=fWi5KaV40jcC1ZGfTAJ+bc52ueMvd0yREUHxSYk7y1MNw@mail.gmail.com>
Message-ID: <4381FF21-053E-4089-A030-F9CD84C87AD5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 19, 2022 2:09:09 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom>=
 wrote:
>On Fri, Aug 19, 2022 at 8:58 AM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> Em Thu, Aug 18, 2022 at 06:50:00PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
>> > Em Tue, Jun 14, 2022 at 07:33:51AM -0700, Ian Rogers escreveu:
>> > > A mask encoding of a cpu map is laid out as:
>> > >   u16 nr
>> > >   u16 long_size
>> > >   unsigned long mask[];
>> > > However, the mask may be 8-byte aligned meaning there is a 4-byte p=
ad
>> > > after long_size=2E This means 32-bit and 64-bit builds see the mask=
 as
>> > > being at different offsets=2E On top of this the structure is in th=
e byte
>> > > data[] encoded as:
>> > >   u16 type
>> > >   char data[]
>> > > This means the mask's struct isn't the required 4 or 8 byte aligned=
, but
>> > > is offset by 2=2E Consequently the long reads and writes are causin=
g
>> > > undefined behavior as the alignment is broken=2E
>> > >
>> > > Fix the mask struct by creating explicit 32 and 64-bit variants, us=
e a
>> > > union to avoid data[] and casts; the struct must be packed so the
>> > > layout matches the existing perf=2Edata layout=2E Taking an address=
 of a
>> > > member of a packed struct breaks alignment so pass the packed
>> > > perf_record_cpu_map_data to functions, so they can access variables=
 with
>> > > the right alignment=2E
>> > >
>> > > As the 64-bit version has 4 bytes of padding, optimizing writing to=
 only
>> > > write the 32-bit version=2E
>> > >
>> > > Signed-off-by: Ian Rogers <irogers@google=2Ecom>
>> > > ---
>> > >  tools/lib/perf/include/perf/event=2Eh | 36 +++++++++++--
>> > >  tools/perf/tests/cpumap=2Ec           | 19 ++++---
>> > >  tools/perf/util/cpumap=2Ec            | 80 +++++++++++++++++++++++=
------
>> > >  tools/perf/util/cpumap=2Eh            |  4 +-
>> > >  tools/perf/util/session=2Ec           | 30 +++++------
>> > >  tools/perf/util/synthetic-events=2Ec  | 34 +++++++-----
>> > >  6 files changed, 143 insertions(+), 60 deletions(-)
>> > >
>> > > diff --git a/tools/lib/perf/include/perf/event=2Eh b/tools/lib/perf=
/include/perf/event=2Eh
>> > > index e7758707cadd=2E=2Ed2d32589758a 100644
>> > > --- a/tools/lib/perf/include/perf/event=2Eh
>> > > +++ b/tools/lib/perf/include/perf/event=2Eh
>> > > @@ -6,6 +6,7 @@
>> > >  #include <linux/types=2Eh>
>> > >  #include <linux/limits=2Eh>
>> > >  #include <linux/bpf=2Eh>
>> > > +#include <linux/compiler=2Eh>
>> > >  #include <sys/types=2Eh> /* pid_t */
>> > >
>> > >  #define event_contains(obj, mem) ((obj)=2Eheader=2Esize > offsetof=
(typeof(obj), mem))
>> > > @@ -153,20 +154,47 @@ enum {
>> > >     PERF_CPU_MAP__MASK =3D 1,
>> > >  };
>> > >
>> > > +/*
>> > > + * Array encoding of a perf_cpu_map where nr is the number of entr=
ies in cpu[]
>> > > + * and each entry is a value for a CPU in the map=2E
>> > > + */
>> > >  struct cpu_map_entries {
>> > >     __u16                    nr;
>> > >     __u16                    cpu[];
>> > >  };
>> > >
>> > > -struct perf_record_record_cpu_map {
>> > > +/* Bitmap encoding of a perf_cpu_map where bitmap entries are 32-b=
it=2E */
>> > > +struct perf_record_mask_cpu_map32 {
>> > > +   /* Number of mask values=2E */
>> > >     __u16                    nr;
>> > > +   /* Constant 4=2E */
>> > >     __u16                    long_size;
>> > > -   unsigned long            mask[];
>> > > +   /* Bitmap data=2E */
>> > > +   __u32                    mask[];
>> > >  };
>> > >
>> > > -struct perf_record_cpu_map_data {
>> > > +/* Bitmap encoding of a perf_cpu_map where bitmap entries are 64-b=
it=2E */
>> > > +struct perf_record_mask_cpu_map64 {
>> > > +   /* Number of mask values=2E */
>> > > +   __u16                    nr;
>> > > +   /* Constant 8=2E */
>> > > +   __u16                    long_size;
>> > > +   /* Legacy padding=2E */
>> > > +   char                     __pad[4];
>> > > +   /* Bitmap data=2E */
>> > > +   __u64                    mask[];
>> > > +};
>> > > +
>> > > +struct __packed perf_record_cpu_map_data {
>> >
>> > In various places I'm getting this:
>> >
>> > [perfbuilder@five x-riscv]$ export BUILD_TARBALL=3Dhttp://192=2E168=
=2E86=2E14/perf/perf-6=2E0=2E0-rc1=2Etar=2Exz
>> > [perfbuilder@five x-riscv]$ time dm =2E
>> >    1     5=2E47 ubuntu:22=2E04-x-riscv64        : FAIL gcc version 11=
=2E2=2E0 (Ubuntu 11=2E2=2E0-16ubuntu1)
>> >     In file included from mmap=2Ec:10:
>> >     /git/perf-6=2E0=2E0-rc1/tools/lib/perf/include/perf/event=2Eh:190=
:34: error: packed attribute causes inefficient alignment for 'type' [-Werr=
or=3Dattributes]
>> >       190 |         __u16                    type;
>> >           |                                  ^~~~
>> >     cc1: all warnings being treated as errors
>> >     In file included from util/event=2Eh:12,
>> >                      from builtin-diff=2Ec:12:
>> >     /git/perf-6=2E0=2E0-rc1/tools/lib/perf/include/perf/event=2Eh:190=
:34: error: packed attribute causes inefficient alignment for 'type' [-Werr=
or=3Dattributes]
>> >       190 |         __u16                    type;
>> >           |                                  ^~~~
>> >     In file included from util/events_stats=2Eh:6,
>> >                      from util/evlist=2Eh:12,
>> >                      from builtin-evlist=2Ec:11:
>> >     /git/perf-6=2E0=2E0-rc1/tools/lib/perf/include/perf/event=2Eh:190=
:34: error: packed attribute causes inefficient alignment for 'type' [-Werr=
or=3Dattributes]
>> >       190 |         __u16                    type;
>> >           |                                  ^~~~
>> >
>> > So probably we need to disable this -Werror=3Dattributes in some
>> > architectures?
>>
>> Slapped this there:
>>
>> #pragma GCC diagnostic push
>> #pragma GCC diagnostic ignored "-Wpacked"
>> #pragma GCC diagnostic ignored "-Wattributes"
>>
>> struct __packed perf_record_cpu_map_data {
>>         __u16                    type;
>>         union {
>>                 /* Used when type =3D=3D PERF_CPU_MAP__CPUS=2E */
>>                 struct cpu_map_entries cpus_data;
>>                 /* Used when type =3D=3D PERF_CPU_MAP__MASK and long_si=
ze =3D=3D 4=2E */
>>                 struct perf_record_mask_cpu_map32 mask32_data;
>>                 /* Used when type =3D=3D PERF_CPU_MAP__MASK and long_si=
ze =3D=3D 8=2E */
>>                 struct perf_record_mask_cpu_map64 mask64_data;
>>         };
>> };
>>
>> #pragma GCC diagnostic pop
>
>Perhaps we should also carry a comment like:
>perf_record_cpu_map_data is packed as unfortunately an earlier version
>had unaligned data and we wish to retain file format compatibility=2E


Thanks, I'll add it=2E

- Arnaldo=20
