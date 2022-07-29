Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7365851A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiG2OgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiG2OgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:36:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C065D0F8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:36:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bn9so6245313wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=etHKF10ZT6NurWAKswk0Y5LKAfvV44h7I2ZlKpv2IkY=;
        b=CIGV/jS6m2ZmnHL+auFqxkArKwit3mmSngkTzrjDbxrw+i1rwOJGxFE3rGqaUX7NXO
         pQ/LMW/jzZKIJ0Qfo4a9x5ajBCsG1pzTc+T0moia15QzYN9XV10L2uUv53FtBP9dKVdD
         i1ds1/wUVzadZ18avEhoVzTDRHbbu5pu/MtBihMh3Wsz8YBw5bf909YoTk/Fn2o+8iJh
         cHj4XfRJ5ENVpDFcsUUQTBUepEJSqMJzADGeRHctmny5Q3FPqo2oc7NpI3771mmCkxgs
         7PsFvssvekwY+sBB+O8mSSgqScM4khrFCTAk6vOIm1zrI8qOLj20JUZ1yoE/IeqwoFwW
         Q6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=etHKF10ZT6NurWAKswk0Y5LKAfvV44h7I2ZlKpv2IkY=;
        b=x4SlT2SwidkmLaaRRSLS0FKSPxsv23Bf/XF7k2fh93YD6WWoKDLNWQ8etDfEYj1arc
         LqjslG9+SC0dKLPFQgYV2yRumG4i/1mfsO1v3XLouvS8gYZ31QU5iVEZKBC5cNN65GHt
         P8uYdnm538yYv/UF249rQf45geBjIvLtAzTcj5P+DEuA5KEwUzxt7W2qS0+aK17asnRv
         csM86/4uLvnSwiwN5AlJXDrMlvi1AVNWt9XxZgDK7B9Iod3YcGwJZ8gGQaz/dOmAbaJ3
         x51aRObLMd7Dq1C5cMN2PKf1B22TkwMb6EppQ7Cu2nhakzDJBg7Uln5Yqn6rdcx4cF5V
         MOgA==
X-Gm-Message-State: ACgBeo0VJXG2XfpyDiU9erVeza9cAbKwUu2/XJ9U3WGvAqIcKlYMfHmH
        +g4JwKe5Yf2EQfRVBgCnJSRguMiw4nlryTezs0YOAQ==
X-Google-Smtp-Source: AA6agR6j5/kHI8JOWZb3gtk/UBSzzmEXTwoimA4eLd2IH5paJPIuZNK+i2cuHZWTPeKHHr71UTrjOCuGcoFhpDg7Gi0=
X-Received: by 2002:a5d:6481:0:b0:21e:6c01:95a2 with SMTP id
 o1-20020a5d6481000000b0021e6c0195a2mr2613741wri.40.1659105364476; Fri, 29 Jul
 2022 07:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com> <20220727220832.2865794-22-irogers@google.com>
 <CA+icZUU-AmzdkWqBCWw=izbWJfpw4GP+UUaOE6SRs3tiAtmKng@mail.gmail.com> <CA+icZUUG6GajshrWUsH-KDnwYc-C19k0hZ9uNUH3b=E32e2TUA@mail.gmail.com>
In-Reply-To: <CA+icZUUG6GajshrWUsH-KDnwYc-C19k0hZ9uNUH3b=E32e2TUA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 29 Jul 2022 07:35:52 -0700
Message-ID: <CAP-5=fVG0ANhft6NL-J4TQgP63nGrUjj=cSxyw46iYLen9LqpA@mail.gmail.com>
Subject: Re: [PATCH v3 21/30] perf vendor events: Update Intel sandybridge
To:     sedat.dilek@gmail.com
Cc:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 1:48 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jul 29, 2022 at 10:41 AM Sedat Dilek <sedat.dilek@gmail.com> wrot=
e:
> >
> > On Thu, Jul 28, 2022 at 12:09 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Update to v17, the metrics are based on TMA 4.4 full.
> > >
> > > Use script at:
> > > https://github.com/intel/event-converter-for-linux-perf/blob/master/d=
ownload_and_gen.py
> > >
> > > to download and generate the latest events and metrics. Manually copy
> > > the sandybridge files into perf and update mapfile.csv.
> > >
> > > Tested on a non-sandybridge with 'perf test':
> > >  10: PMU events                                                      =
:
> > >  10.1: PMU event table sanity                                        =
: Ok
> > >  10.2: PMU event map aliases                                         =
: Ok
> > >  10.3: Parsing of PMU event table metrics                            =
: Ok
> > >  10.4: Parsing of PMU event table metrics with fake PMUs             =
: Ok
> > >
> >
> > Hi Ian,
> >
> > thanks for v3 patchset.
> >
> > I used latest perf/core Git branch from Arnaldo's tree plus some
> > custom patches (to fix binutils v2.38.90 and opennssl-v3 issues plus
> > gnu11 tools patches) and build with LLVM-14.
> >
> > When I run on my Intel SandyBridge CPU...
> >
> > $ ~/bin/perf test
> > ...
> >  10: PMU events                                                      :
> > 10.1: PMU event table sanity                                        : O=
k
> > 10.2: PMU event map aliases                                         : O=
k
> > 10.3: Parsing of PMU event table metrics                            : O=
k
> > 10.4: Parsing of PMU event table metrics with fake PMUs             : O=
k
> > ...
> >
> > First time I ran perf with option test.
> >
> > Looks that good to you?
> >
>
> Nice.
>
> $~/bin/perf test list
> ...
>  10: PMU events
> 10:1: PMU event table sanity
> 10:2: PMU event map aliases
> 10:3: Parsing of PMU event table metrics
> 10:4: Parsing of PMU event table metrics with fake PMUs
> ...
>
> $ ~/bin/perf test 10
> 10: PMU events                                                      :
> 10.1: PMU event table sanity                                        : Ok
> 10.2: PMU event map aliases                                         : Ok
> 10.3: Parsing of PMU event table metrics                            : Ok
> 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>
> New perf lessons learned.

Thanks. There are also tests that iterate and run the events/metrics
on your hardware:

$ perf test list
...
 93: perf all metricgroups test
94: perf all metrics test
...
 96: perf all PMU test
...

Test 10 is a unit test and tests 93, 94 and 96 (your numbers may vary)
are more like integration tests.

Thanks,
Ian


> -Sedat-
> >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/pmu-events/arch/x86/mapfile.csv            |  2 +-
> > >  tools/perf/pmu-events/arch/x86/sandybridge/cache.json |  2 +-
> > >  .../arch/x86/sandybridge/floating-point.json          |  2 +-
> > >  .../pmu-events/arch/x86/sandybridge/frontend.json     |  4 ++--
> > >  .../perf/pmu-events/arch/x86/sandybridge/memory.json  |  2 +-
> > >  tools/perf/pmu-events/arch/x86/sandybridge/other.json |  2 +-
> > >  .../pmu-events/arch/x86/sandybridge/pipeline.json     | 10 +++++----=
-
> > >  .../pmu-events/arch/x86/sandybridge/snb-metrics.json  | 11 +++++++++=
--
> > >  .../pmu-events/arch/x86/sandybridge/uncore-other.json |  2 +-
> > >  .../arch/x86/sandybridge/virtual-memory.json          |  2 +-
> > >  10 files changed, 23 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/=
pmu-events/arch/x86/mapfile.csv
> > > index 2f9419ee2d29..0b56c4a8a3a8 100644
> > > --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> > > +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > > @@ -19,12 +19,12 @@ GenuineIntel-6-(57|85),v9,knightslanding,core
> > >  GenuineIntel-6-AA,v1.00,meteorlake,core
> > >  GenuineIntel-6-1[AEF],v3,nehalemep,core
> > >  GenuineIntel-6-2E,v3,nehalemex,core
> > > +GenuineIntel-6-2A,v17,sandybridge,core
> > >  GenuineIntel-6-[4589]E,v24,skylake,core
> > >  GenuineIntel-6-A[56],v24,skylake,core
> > >  GenuineIntel-6-37,v13,silvermont,core
> > >  GenuineIntel-6-4D,v13,silvermont,core
> > >  GenuineIntel-6-4C,v13,silvermont,core
> > > -GenuineIntel-6-2A,v15,sandybridge,core
> > >  GenuineIntel-6-2C,v2,westmereep-dp,core
> > >  GenuineIntel-6-25,v2,westmereep-sp,core
> > >  GenuineIntel-6-2F,v2,westmereex,core
> > > diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json b/=
tools/perf/pmu-events/arch/x86/sandybridge/cache.json
> > > index 92a7269eb444..a1d622352131 100644
> > > --- a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
> > > +++ b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
> > > @@ -1876,4 +1876,4 @@
> > >          "SampleAfterValue": "100003",
> > >          "UMask": "0x10"
> > >      }
> > > -]
> > > \ No newline at end of file
> > > +]
> > > diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/floating-poin=
t.json b/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
> > > index 713878fd062b..eb2ff2cfdf6b 100644
> > > --- a/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
> > > +++ b/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
> > > @@ -135,4 +135,4 @@
> > >          "SampleAfterValue": "2000003",
> > >          "UMask": "0x1"
> > >      }
> > > -]
> > > \ No newline at end of file
> > > +]
> > > diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json=
 b/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
> > > index fa22f9463b66..e2c82e43a2de 100644
> > > --- a/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
> > > +++ b/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
> > > @@ -176,7 +176,7 @@
> > >          "CounterMask": "1",
> > >          "EventCode": "0x79",
> > >          "EventName": "IDQ.MS_CYCLES",
> > > -        "PublicDescription": "This event counts cycles during which =
the microcode sequencer assisted the front-end in delivering uops.  Microco=
de assists are used for complex instructions or scenarios that can't be han=
dled by the standard decoder.  Using other instructions, if possible, will =
usually improve performance.  See the Intel 64 and IA-32 Architectures Opti=
mization Reference Manual for more information.",
> > > +        "PublicDescription": "This event counts cycles during which =
the microcode sequencer assisted the front-end in delivering uops.  Microco=
de assists are used for complex instructions or scenarios that can't be han=
dled by the standard decoder.  Using other instructions, if possible, will =
usually improve performance.  See the Intel(R) 64 and IA-32 Architectures O=
ptimization Reference Manual for more information.",
> > >          "SampleAfterValue": "2000003",
> > >          "UMask": "0x30"
> > >      },
> > > @@ -311,4 +311,4 @@
> > >          "SampleAfterValue": "2000003",
> > >          "UMask": "0x1"
> > >      }
> > > -]
> > > \ No newline at end of file
> > > +]
> > > diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/memory.json b=
/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
> > > index 931892d34076..3c283ca309f3 100644
> > > --- a/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
> > > +++ b/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
> > > @@ -442,4 +442,4 @@
> > >          "SampleAfterValue": "100003",
> > >          "UMask": "0x1"
> > >      }
> > > -]
> > > \ No newline at end of file
> > > +]
> > > diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/other.json b/=
tools/perf/pmu-events/arch/x86/sandybridge/other.json
> > > index e251f535ec09..2f873ab14156 100644
> > > --- a/tools/perf/pmu-events/arch/x86/sandybridge/other.json
> > > +++ b/tools/perf/pmu-events/arch/x86/sandybridge/other.json
> > > @@ -55,4 +55,4 @@
> > >          "SampleAfterValue": "2000003",
> > >          "UMask": "0x1"
> > >      }
> > > -]
> > > \ No newline at end of file
> > > +]
> > > diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json=
 b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> > > index b9a3f194a00a..2c3b6c92aa6b 100644
> > > --- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> > > +++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> > > @@ -609,7 +609,7 @@
> > >          "UMask": "0x3"
> > >      },
> > >      {
> > > -        "BriefDescription": "Number of occurences waiting for the ch=
eckpoints in Resource Allocation Table (RAT) to be recovered after Nuke due=
 to all other cases except JEClear (e.g. whenever a ucode assist is needed =
like SSE exception, memory disambiguation, etc...).",
> > > +        "BriefDescription": "Number of occurrences waiting for the c=
heckpoints in Resource Allocation Table (RAT) to be recovered after Nuke du=
e to all other cases except JEClear (e.g. whenever a ucode assist is needed=
 like SSE exception, memory disambiguation, etc...).",
> > >          "Counter": "0,1,2,3",
> > >          "CounterHTOff": "0,1,2,3,4,5,6,7",
> > >          "CounterMask": "1",
> > > @@ -652,7 +652,7 @@
> > >          "CounterHTOff": "0,1,2,3,4,5,6,7",
> > >          "EventCode": "0x03",
> > >          "EventName": "LD_BLOCKS.STORE_FORWARD",
> > > -        "PublicDescription": "This event counts loads that followed =
a store to the same address, where the data could not be forwarded inside t=
he pipeline from the store to the load.  The most common reason why store f=
orwarding would be blocked is when a load's address range overlaps with a p=
receeding smaller uncompleted store.  See the table of not supported store =
forwards in the Intel 64 and IA-32 Architectures Optimization Reference Man=
ual.  The penalty for blocked store forwarding is that the load must wait f=
or the store to complete before it can be issued.",
> > > +        "PublicDescription": "This event counts loads that followed =
a store to the same address, where the data could not be forwarded inside t=
he pipeline from the store to the load.  The most common reason why store f=
orwarding would be blocked is when a load's address range overlaps with a p=
receeding smaller uncompleted store.  See the table of not supported store =
forwards in the Intel(R) 64 and IA-32 Architectures Optimization Reference =
Manual.  The penalty for blocked store forwarding is that the load must wai=
t for the store to complete before it can be issued.",
> > >          "SampleAfterValue": "100003",
> > >          "UMask": "0x2"
> > >      },
> > > @@ -778,7 +778,7 @@
> > >          "CounterMask": "1",
> > >          "EventCode": "0x59",
> > >          "EventName": "PARTIAL_RAT_STALLS.FLAGS_MERGE_UOP_CYCLES",
> > > -        "PublicDescription": "This event counts the number of cycles=
 spent executing performance-sensitive flags-merging uops. For example, shi=
ft CL (merge_arith_flags). For more details, See the Intel 64 and IA-32 Arc=
hitectures Optimization Reference Manual.",
> > > +        "PublicDescription": "This event counts the number of cycles=
 spent executing performance-sensitive flags-merging uops. For example, shi=
ft CL (merge_arith_flags). For more details, See the Intel(R) 64 and IA-32 =
Architectures Optimization Reference Manual.",
> > >          "SampleAfterValue": "2000003",
> > >          "UMask": "0x20"
> > >      },
> > > @@ -797,7 +797,7 @@
> > >          "CounterHTOff": "0,1,2,3,4,5,6,7",
> > >          "EventCode": "0x59",
> > >          "EventName": "PARTIAL_RAT_STALLS.SLOW_LEA_WINDOW",
> > > -        "PublicDescription": "This event counts the number of cycles=
 with at least one slow LEA uop being allocated. A uop is generally conside=
red as slow LEA if it has three sources (for example, two sources and immed=
iate) regardless of whether it is a result of LEA instruction or not. Examp=
les of the slow LEA uop are or uops with base, index, and offset source ope=
rands using base and index reqisters, where base is EBR/RBP/R13, using RIP =
relative or 16-bit addressing modes. See the Intel 64 and IA-32 Architectur=
es Optimization Reference Manual for more details about slow LEA instructio=
ns.",
> > > +        "PublicDescription": "This event counts the number of cycles=
 with at least one slow LEA uop being allocated. A uop is generally conside=
red as slow LEA if it has three sources (for example, two sources and immed=
iate) regardless of whether it is a result of LEA instruction or not. Examp=
les of the slow LEA uop are or uops with base, index, and offset source ope=
rands using base and index reqisters, where base is EBR/RBP/R13, using RIP =
relative or 16-bit addressing modes. See the Intel(R) 64 and IA-32 Architec=
tures Optimization Reference Manual for more details about slow LEA instruc=
tions.",
> > >          "SampleAfterValue": "2000003",
> > >          "UMask": "0x40"
> > >      },
> > > @@ -1209,4 +1209,4 @@
> > >          "SampleAfterValue": "2000003",
> > >          "UMask": "0x1"
> > >      }
> > > -]
> > > \ No newline at end of file
> > > +]
> > > diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.j=
son b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> > > index c8e7050d9c26..ae7ed267b2a2 100644
> > > --- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> > > @@ -124,7 +124,7 @@
> > >          "MetricName": "FLOPc_SMT"
> > >      },
> > >      {
> > > -        "BriefDescription": "Instruction-Level-Parallelism (average =
number of uops executed when there is at least 1 uop executed)",
> > > +        "BriefDescription": "Instruction-Level-Parallelism (average =
number of uops executed when there is execution) per-core",
> > >          "MetricExpr": "UOPS_DISPATCHED.THREAD / (( cpu@UOPS_DISPATCH=
ED.CORE\\,cmask\\=3D1@ / 2 ) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cma=
sk\\=3D1@)",
> > >          "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
> > >          "MetricName": "ILP"
> > > @@ -141,6 +141,12 @@
> > >          "MetricGroup": "Summary;TmaL1",
> > >          "MetricName": "Instructions"
> > >      },
> > > +    {
> > > +        "BriefDescription": "Average number of Uops retired in cycle=
s where at least one uop has retired.",
> > > +        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.=
RETIRE_SLOTS\\,cmask\\=3D1@",
> > > +        "MetricGroup": "Pipeline;Ret",
> > > +        "MetricName": "Retire"
> > > +    },
> > >      {
> > >          "BriefDescription": "Fraction of Uops delivered by the DSB (=
aka Decoded ICache; or Uop Cache)",
> > >          "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + I=
DQ.MITE_UOPS + IDQ.MS_UOPS ) )",
> > > @@ -163,7 +169,8 @@
> > >          "BriefDescription": "Giga Floating Point Operations Per Seco=
nd",
> > >          "MetricExpr": "( ( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE +=
 FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBL=
E + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) +=
 8 * SIMD_FP_256.PACKED_SINGLE ) / 1000000000 ) / duration_time",
> > >          "MetricGroup": "Cor;Flops;HPC",
> > > -        "MetricName": "GFLOPs"
> > > +        "MetricName": "GFLOPs",
> > > +        "PublicDescription": "Giga Floating Point Operations Per Sec=
ond. Aggregate across all supported options of: FP precisions, scalar and v=
ector instructions, vector-width and AMX engine."
> > >      },
> > >      {
> > >          "BriefDescription": "Average Frequency Utilization relative =
nominal frequency",
> > > diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.=
json b/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
> > > index 6278068908cf..88f1e326205f 100644
> > > --- a/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
> > > +++ b/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
> > > @@ -82,10 +82,10 @@
> > >      {
> > >          "BriefDescription": "This 48-bit fixed counter counts the UC=
LK cycles.",
> > >          "Counter": "Fixed",
> > > +        "EventCode": "0xff",
> > >          "EventName": "UNC_CLOCK.SOCKET",
> > >          "PerPkg": "1",
> > >          "PublicDescription": "This 48-bit fixed counter counts the U=
CLK cycles.",
> > > -        "UMask": "0x01",
> > >          "Unit": "ARB"
> > >      }
> > >  ]
> > > diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memor=
y.json b/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
> > > index 4dd136d00a10..98362abba1a7 100644
> > > --- a/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
> > > +++ b/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
> > > @@ -146,4 +146,4 @@
> > >          "SampleAfterValue": "100007",
> > >          "UMask": "0x20"
> > >      }
> > > -]
> > > \ No newline at end of file
> > > +]
> > > --
> > > 2.37.1.359.gd136c6c3e2-goog
> > >
