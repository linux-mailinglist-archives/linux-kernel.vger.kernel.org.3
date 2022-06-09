Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCD95456C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbiFIVzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiFIVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:55:09 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8594416085B;
        Thu,  9 Jun 2022 14:55:07 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y69so19682252oia.7;
        Thu, 09 Jun 2022 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQrKWWesUkB3fWG+8MpJ7+BZHbgJ6rOJ+xH2t3Vud5Y=;
        b=kYLuPAJJeljxNhu38lRmbvQtDupw/fxcWqAq3Yr2mPXg4FdrRpPiwhtpuunX1DrZcZ
         5ghyRqx8xiAzwNziMsh44ew7iOpnNRurW4U0Had9k54mRc5AGXwKevQOmWiVyRP9Efeu
         SYIFvtCw0RdSsQC3B8J9LU5OSpEyuzmb7/imAQiVRyR9nV7hGjdpjEkeKTbVH2kGLHNi
         n/Dpf57TTbD4Rbl09qt30BrNKvKW1e2Qq5Txu8oBwo2bI/ZtNJF0iU/pAaUTAsJsPdlu
         9zX6fZ+KdwXOs2sT2juRZMjmMY/UtcJlkqyVsjirHVGRXscyIYEUbIA/Xy1U8iTPN2Sm
         iOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQrKWWesUkB3fWG+8MpJ7+BZHbgJ6rOJ+xH2t3Vud5Y=;
        b=kgbf+lG3NBmLBpHObEZbnxpjapiyyobK9SuCv73flUqcT3jyUby8MgYPjSLkp8WxUE
         7/o1DAeUVuK8/PcjVgTRdeXoH+pfMvj/wMRNSDdKhEWNU2f/l14t2jIaLotbWCds8n1Q
         HWoxd7cQGPKhadfH0+TzcpLfjH7uBzJ4wlcXP6ZztVLhcg3FIQSBr7zYURx9J4RY5Q4w
         pOiLj18NlJRRGNvZ3XgR1A9oDVLSJ6R9qNX7hNZuo1TnXn/tnYUKA2SFH1QcbPHn1V6X
         cj1ZYnfV+lWrlZlJ+w1xydmSpvQD9DvgiC/IRBELkW+/MZN4Lu5i2UcyJmH0fZfMfjez
         7U1w==
X-Gm-Message-State: AOAM5323mbuAXEsdRo+Dh40oF605bX8b3ek6woodsPJR7Fku8sbK12d4
        K3+Drcp1cgI8qhPIydhlUHIug7/wJOXLD47+/BQ=
X-Google-Smtp-Source: ABdhPJxlYhS47r6a6dc8w5eZ0iuL/yg98VzNNKi9SyC8ZdO1ZisWfyzy+oovUVItwvZsE/jDiBtbswwmuZb8+c4sXIQ=
X-Received: by 2002:a05:6808:16ac:b0:2f9:52e5:da90 with SMTP id
 bb44-20020a05680816ac00b002f952e5da90mr2966663oib.5.1654811705887; Thu, 09
 Jun 2022 14:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220609145314.2064632-1-zhengjun.xing@linux.intel.com>
 <20220609145314.2064632-5-zhengjun.xing@linux.intel.com> <8358dc65-88d8-1550-96bd-9e66477c4bd5@linux.intel.com>
In-Reply-To: <8358dc65-88d8-1550-96bd-9e66477c4bd5@linux.intel.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 9 Jun 2022 14:54:54 -0700
Message-ID: <CAM9d7ch9MR6H3soO17+F9M0hMRYX9b6Tf2oKmKTd60SHxycXLA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] perf x86 evlist: Add default hybrid events for
 perf stat
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, alexander.shishkin@intel.com,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 9, 2022 at 9:01 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 6/9/2022 10:53 AM, zhengjun.xing@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > Provide a new solution to replace the reverted commit ac2dc29edd21
> > ("perf stat: Add default hybrid events").
> >
> > For the default software attrs, nothing is changed.
> > For the default hardware attrs, create a new evsel for each hybrid pmu.
> >
> > With the new solution, adding a new default attr will not require the
> > special support for the hybrid platform anymore.
> >
> > Also, the "--detailed" is supported on the hybrid platform
> >
> > With the patch,
> >
> > ./perf stat -a -ddd sleep 1
> >
> >   Performance counter stats for 'system wide':
> >
> >         32,231.06 msec cpu-clock                 #   32.056 CPUs utilized
> >               529      context-switches          #   16.413 /sec
> >                32      cpu-migrations            #    0.993 /sec
> >                69      page-faults               #    2.141 /sec
> >       176,754,151      cpu_core/cycles/          #    5.484 M/sec          (41.65%)
> >       161,695,280      cpu_atom/cycles/          #    5.017 M/sec          (49.92%)
> >        48,595,992      cpu_core/instructions/    #    1.508 M/sec          (49.98%)
> >        32,363,337      cpu_atom/instructions/    #    1.004 M/sec          (58.26%)
> >        10,088,639      cpu_core/branches/        #  313.010 K/sec          (58.31%)
> >         6,390,582      cpu_atom/branches/        #  198.274 K/sec          (58.26%)
> >           846,201      cpu_core/branch-misses/   #   26.254 K/sec          (66.65%)
> >           676,477      cpu_atom/branch-misses/   #   20.988 K/sec          (58.27%)
> >        14,290,070      cpu_core/L1-dcache-loads/ #  443.363 K/sec          (66.66%)
> >         9,983,532      cpu_atom/L1-dcache-loads/ #  309.749 K/sec          (58.27%)
> >           740,725      cpu_core/L1-dcache-load-misses/ #   22.982 K/sec    (66.66%)
> >   <not supported>      cpu_atom/L1-dcache-load-misses/
> >           480,441      cpu_core/LLC-loads/       #   14.906 K/sec          (66.67%)
> >           326,570      cpu_atom/LLC-loads/       #   10.132 K/sec          (58.27%)
> >               329      cpu_core/LLC-load-misses/ #   10.208 /sec           (66.68%)
> >                 0      cpu_atom/LLC-load-misses/ #    0.000 /sec           (58.32%)
> >   <not supported>      cpu_core/L1-icache-loads/
> >        21,982,491      cpu_atom/L1-icache-loads/ #  682.028 K/sec          (58.43%)
> >         4,493,189      cpu_core/L1-icache-load-misses/ #  139.406 K/sec    (33.34%)
> >         4,711,404      cpu_atom/L1-icache-load-misses/ #  146.176 K/sec    (50.08%)
> >        13,713,090      cpu_core/dTLB-loads/      #  425.462 K/sec          (33.34%)
> >         9,384,727      cpu_atom/dTLB-loads/      #  291.170 K/sec          (50.08%)
> >           157,387      cpu_core/dTLB-load-misses/ #    4.883 K/sec         (33.33%)
> >           108,328      cpu_atom/dTLB-load-misses/ #    3.361 K/sec         (50.08%)
> >   <not supported>      cpu_core/iTLB-loads/
> >   <not supported>      cpu_atom/iTLB-loads/
> >            37,655      cpu_core/iTLB-load-misses/ #    1.168 K/sec         (33.32%)
> >            61,661      cpu_atom/iTLB-load-misses/ #    1.913 K/sec         (50.03%)
> >   <not supported>      cpu_core/L1-dcache-prefetches/
> >   <not supported>      cpu_atom/L1-dcache-prefetches/
> >   <not supported>      cpu_core/L1-dcache-prefetch-misses/
> >   <not supported>      cpu_atom/L1-dcache-prefetch-misses/
> >
> >         1.005466919 seconds time elapsed
> >
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > ---
> > Change log:
> >    v2:
> >      * The index of all new evsel will be updated when adding to the evlist,
> >        just set 0 idx for the new evsel.
> >
> >   tools/perf/arch/x86/util/evlist.c | 52 ++++++++++++++++++++++++++++++-
> >   tools/perf/util/evlist.c          |  2 +-
> >   tools/perf/util/evlist.h          |  2 ++
> >   3 files changed, 54 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> > index 777bdf182a58..fd3500fd4b69 100644
> > --- a/tools/perf/arch/x86/util/evlist.c
> > +++ b/tools/perf/arch/x86/util/evlist.c
> > @@ -4,16 +4,66 @@
> >   #include "util/evlist.h"
> >   #include "util/parse-events.h"
> >   #include "topdown.h"
> > +#include "util/event.h"
> > +#include "util/pmu-hybrid.h"
> >
> >   #define TOPDOWN_L1_EVENTS   "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
> >   #define TOPDOWN_L2_EVENTS   "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
> >
> > +static int ___evlist__add_default_attrs(struct evlist *evlist,
> > +                                     struct perf_event_attr *attrs,
> > +                                     size_t nr_attrs)
> > +{
> > +     struct perf_cpu_map *cpus;
> > +     struct evsel *evsel, *n;
> > +     struct perf_pmu *pmu;
> > +     LIST_HEAD(head);
> > +     size_t i = 0;
> > +
> > +     for (i = 0; i < nr_attrs; i++)
> > +             event_attr_init(attrs + i);
> > +
> > +     if (!perf_pmu__has_hybrid())
> > +             return evlist__add_attrs(evlist, attrs, nr_attrs);
> > +
> > +     for (i = 0; i < nr_attrs; i++) {
> > +             if (attrs[i].type == PERF_TYPE_SOFTWARE) {
> > +                     evsel = evsel__new_idx(attrs + i, evlist->core.nr_entries);
>
> Although the idx will be updated later, the value doesn't matter.
> I think it should be better to use 0, rather than
> evlist->core.nr_entries. Because it's a new evsel and hasn't been added
> into the evlist yet.

You can just use evsel__new() which does the same.

Thanks,
Namhyung
