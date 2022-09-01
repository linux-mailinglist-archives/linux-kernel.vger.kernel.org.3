Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82F5A9F69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiIASuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiIASuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:50:00 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEB119022;
        Thu,  1 Sep 2022 11:49:54 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so32939976fac.4;
        Thu, 01 Sep 2022 11:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=02zIkLKKQCAhCdhXLnpsQRYEkcXZcq641lv7SqG6wRU=;
        b=IwnEsvelFUid7cePoGjgaMkIh28XpCEIK9erqOK+7HgBH6TA/DYSecGZm+TsHBIJVp
         wek1eofSCrs+V9yVE0QMNCzdCZNcF3yD84in6RIT+yz0DmB/zXuPEOWEeKf4205HjnFB
         qNS8iuRJlZOPKBTMymcPIYJ4zIxnKJsRwMnhJ0pKVQ0du06Yi5AZiiWjQY2SIrROw+DC
         Rux6955xgavZs2V3jMmMxAff9XshzcUy6Ww8qIeuQ0dsxblZn6x1yrRcYF6wlvT8agFs
         y9+A1BV9nab/p+OTyKajzvv3mkSwDNYDmdP8Z4Dfq5AJWJpACH2kYDysJ6mxB3Dq65ap
         pbnw==
X-Gm-Message-State: ACgBeo2WZBte/qAhSSWA5bHteYSTHWuP3XH4v0U9g8itTuUgwU0ZD/Ah
        u1URn2rvBTMse00b5rO7Vh7q9/bfy+1jzxSTQj8=
X-Google-Smtp-Source: AA6agR7vXXx8Jt03ZV7ouYcpaSbwKN/lC98y4haXdAcKuPYVd2A8fIFvIoQrj3rd/agDrEUy5w/6yGFL/aT9Mknvh7E=
X-Received: by 2002:a05:6808:302a:b0:345:ec04:8f11 with SMTP id
 ay42-20020a056808302a00b00345ec048f11mr262037oib.5.1662058194212; Thu, 01 Sep
 2022 11:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220831210352.145753-1-namhyung@kernel.org> <20220831210352.145753-4-namhyung@kernel.org>
 <86ca3041-3327-622c-1c23-67fc6af412f6@intel.com>
In-Reply-To: <86ca3041-3327-622c-1c23-67fc6af412f6@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Sep 2022 11:49:43 -0700
Message-ID: <CAM9d7cj3zdjohSYYr8r9ArGbs_damkAz7FARDFAW9O0j0RAzNA@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf record: Read and inject LOST_SAMPLES events
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, Sep 1, 2022 at 4:23 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 1/09/22 00:03, Namhyung Kim wrote:
> > When there are lost samples, it can read the number of PERF_FORMAT_LOST and
> > convert it to PERF_RECORD_LOST_SAMPLES and write to the data file at the end.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-record.c | 60 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index bce8c941d558..cb9881543a07 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -10,6 +10,7 @@
> >
> >  #include "util/build-id.h"
> >  #include <subcmd/parse-options.h>
> > +#include <internal/xyarray.h>
> >  #include "util/parse-events.h"
> >  #include "util/config.h"
> >
> > @@ -1852,6 +1853,64 @@ record__switch_output(struct record *rec, bool at_exit)
> >       return fd;
> >  }
> >
> > +static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
> > +                                     struct perf_record_lost_samples *lost,
> > +                                     int size, int cpu_idx, int thread_idx)
> > +{
> > +     struct perf_counts_values count;
> > +     struct perf_sample_id *sid;
> > +     struct perf_sample sample = {};
> > +
> > +     if (perf_evsel__read(&evsel->core, cpu_idx, thread_idx, &count) < 0) {
> > +             pr_err("read LOST count failed\n");
> > +             return;
> > +     }
> > +
> > +     if (count.lost == 0)
> > +             return;
> > +
> > +     lost->lost = count.lost;
> > +     if (evsel->core.ids) {
> > +             sid = xyarray__entry(evsel->core.sample_id, cpu_idx, thread_idx);
> > +             sample.id = sid->id;
> > +     }
> > +
> > +     perf_event__synthesize_id_sample((void *)(lost + 1),
> > +                                      evsel->core.attr.sample_type, &sample);
>
> The ID sample size can vary with sample_type and is not necessarily the same as
> machine->id_hdr_size.
>
> The following might be more robust:
>
>         id_hdr_size = perf_event__synthesize_id_sample((void *)(lost + 1), evsel->core.attr.sample_type, &sample);
>         lost->header.size = sizeof(*lost) + id_hdr_size;

Will change.

Thanks for your review!
Namhyung


>
> > +     record__write(rec, NULL, lost, size);
> > +}
> > +
> > +static void record__read_lost_samples(struct record *rec)
> > +{
> > +     struct perf_session *session = rec->session;
> > +     struct machine *machine = &session->machines.host;
> > +     struct perf_record_lost_samples *lost;
> > +     struct evsel *evsel;
> > +     int size = sizeof(*lost) + machine->id_hdr_size;
>
>   -     int size = sizeof(*lost) + machine->id_hdr_size;
>
> > +
> > +     lost = zalloc(size);
>
>         lost = zalloc(PERF_SAMPLE_MAX_SIZE);
>
>
> > +     lost->header.type = PERF_RECORD_LOST_SAMPLES;
> > +     lost->header.size = size;
>
>   -     lost->header.size = size;
>
> > +
> > +     evlist__for_each_entry(session->evlist, evsel) {
> > +             struct xyarray *xy = evsel->core.sample_id;
> > +
> > +             if (xyarray__max_x(evsel->core.fd) != xyarray__max_x(xy) ||
> > +                 xyarray__max_y(evsel->core.fd) != xyarray__max_y(xy)) {
> > +                     pr_debug("Unmatched FD vs. sample ID: skip reading LOST count\n");
> > +                     continue;
> > +             }
> > +
> > +             for (int x = 0; x < xyarray__max_x(xy); x++) {
> > +                     for (int y = 0; y < xyarray__max_y(xy); y++) {
> > +                             __record__read_lost_samples(rec, evsel, lost,
> > +                                                         size, x, y);
> > +                     }
> > +             }
> > +     }
> > +
> > +}
> > +
> >  static volatile int workload_exec_errno;
> >
> >  /*
> > @@ -2710,6 +2769,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >       if (rec->off_cpu)
> >               rec->bytes_written += off_cpu_write(rec->session);
> >
> > +     record__read_lost_samples(rec);
> >       record__synthesize(rec, true);
> >       /* this will be recalculated during process_buildids() */
> >       rec->samples = 0;
>
