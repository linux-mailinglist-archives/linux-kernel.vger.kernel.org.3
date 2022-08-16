Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A767B596502
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbiHPVzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbiHPVyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:54:53 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DC272B74;
        Tue, 16 Aug 2022 14:54:52 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id q184so13548435oif.1;
        Tue, 16 Aug 2022 14:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NbyY30wk4/hRxv9SXwy8afuP/Bj8vzrftl2+aChgimI=;
        b=6W94G8/uBhNIxU/hkTF/VheLoUFvtxGuSpJJ3UZF/3/CeAckvm2AqmcJMPFv92cyQv
         0Lan34RYdoPksx4f4ep+jb0lKIpT77vtBHbZ2Fpjqe9NMVBlzU9QefXBtc0gsUMZrgxv
         CYJtoPR8IvHdt3RhXqM8nwEYnNkTKqCEKpIV3hDU33ER8FO68Nyb7RrFTnHECzmgI7Ce
         HeqXRBXOXIHqjrUktoKqVchm5g98GCMgRBQvVz/PlCX6vNJebu1p+uDRXy4rfy0JXuRs
         1s5nX87N8sf1rbwDFANh1UFTQ2SZTG32C5t7QiF6GCCEjwO8aIMVmbNd7WEiMlaOb7an
         M5pw==
X-Gm-Message-State: ACgBeo28uSmGij47lwjTkBvvMMz+unzB+KvVR9+bM2aDgCowvSr6QupE
        mheT99BmiL6N0RRKAeL9xuDTTEzB8Y9Ndj6WdrbKLLb7
X-Google-Smtp-Source: AA6agR7qfwtYAWlDCrVetAm+hSfUgGZcjQDCNu+Z/S1jxlq+C3eCH4sKLFV+Zpp1bVaWvPkGrsGw+D5oiyAayMuMGzU=
X-Received: by 2002:aca:ba86:0:b0:33a:c6f7:3001 with SMTP id
 k128-20020acaba86000000b0033ac6f73001mr253357oif.5.1660686891447; Tue, 16 Aug
 2022 14:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220815190106.1293082-1-namhyung@kernel.org> <20220815190106.1293082-3-namhyung@kernel.org>
 <YvuZWAzsBVo/l9sf@krava>
In-Reply-To: <YvuZWAzsBVo/l9sf@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 16 Aug 2022 14:54:40 -0700
Message-ID: <CAM9d7cjE+EFoUpxgj0WOn70W9cZwchtuqEJtY_BoOy3rrE6zrA@mail.gmail.com>
Subject: Re: [PATCH 2/4] tools lib perf: Handle read format in perf_evsel__read()
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Tue, Aug 16, 2022 at 6:19 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Aug 15, 2022 at 12:01:04PM -0700, Namhyung Kim wrote:
> > The perf_counts_values should be increased to read the new lost data.
> > Also adjust values after read according the read format.
> >
> > This supports PERF_FORMAT_GROUP which has a different data format but
> > it's only available for leader events.  Currently it doesn't have an API
> > to read sibling (member) events in the group.  But users may read the
> > sibling event directly.
> >
> > Also reading from mmap would be disabled when the read format has ID or
> > LOST bit as it's not exposed via mmap.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/lib/perf/evsel.c              | 72 +++++++++++++++++++++++++++++
> >  tools/lib/perf/include/perf/event.h |  3 +-
> >  tools/lib/perf/include/perf/evsel.h |  4 +-
> >  3 files changed, 77 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > index 952f3520d5c2..fc23670231cb 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -305,6 +305,9 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
> >       if (read_format & PERF_FORMAT_ID)
> >               entry += sizeof(u64);
> >
> > +     if (read_format & PERF_FORMAT_LOST)
> > +             entry += sizeof(u64);
> > +
> >       if (read_format & PERF_FORMAT_GROUP) {
> >               nr = evsel->nr_members;
> >               size += sizeof(u64);
> > @@ -314,24 +317,93 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
> >       return size;
> >  }
> >
> > +/* This only reads values for the leader */
> > +static int perf_evsel__read_group(struct perf_evsel *evsel, int cpu_map_idx,
> > +                               int thread, struct perf_counts_values *count)
> > +{
> > +     size_t size = perf_evsel__read_size(evsel);
> > +     int *fd = FD(evsel, cpu_map_idx, thread);
> > +     u64 read_format = evsel->attr.read_format;
> > +     u64 *data;
> > +     int idx = 1;
> > +
> > +     if (fd == NULL || *fd < 0)
> > +             return -EINVAL;
> > +
> > +     data = calloc(1, size);
> > +     if (data == NULL)
> > +             return -ENOMEM;
> > +
> > +     if (readn(*fd, data, size) <= 0) {
> > +             free(data);
> > +             return -errno;
> > +     }
>
> could you please put in here some comment that this is intentionaly
> reading only the leader or better yet rename the function? I was lost
> before I got to read the changelog ;-)

Sure, actually it has a comment above the function signature.
Maybe we can add an API to read whole group counters
but it could be a follow up.

>
> > +
> > +     if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
> > +             count->ena = data[idx++];
> > +     if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
> > +             count->run = data[idx++];
> > +
> > +     /* value is always available */
> > +     count->val = data[idx++];
> > +     if (read_format & PERF_FORMAT_ID)
> > +             count->id = data[idx++];
> > +     if (read_format & PERF_FORMAT_LOST)
> > +             count->lost = data[idx++];
> > +
> > +     free(data);
> > +     return 0;
> > +}
> > +
> > +/*
> > + * The perf read format is very flexible.  It needs to set the proper
> > + * values according to the read format.
> > + */
> > +static void perf_evsel__adjust_values(struct perf_evsel *evsel,
> > +                                   struct perf_counts_values *count)
> > +{
> > +     u64 read_format = evsel->attr.read_format;
> > +
> > +     if (!(read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)) {
> > +             memmove(&count->values[2], &count->values[1], 24);
> > +             count->ena = 0;
> > +     }
> > +
> > +     if (!(read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)) {
> > +             memmove(&count->values[3], &count->values[2], 16);
> > +             count->run = 0;
> > +     }
> > +
> > +     if (!(read_format & PERF_FORMAT_ID)) {
> > +             memmove(&count->values[4], &count->values[3], 8);
> > +             count->id = 0;
> > +     }
> > +}
>
>
> could we do this the same way we read group counters.. like make read
> into local buffer and initialize perf_counts_values values based on
> format, something like:
>
>         readn(fd, data ...
>
>         if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
>                 count->ena = data[idx++];
>         if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
>                 count->run = data[idx++];
>
>         /* value is always available */
>         count->val = data[idx++];
>         if (read_format & PERF_FORMAT_ID)
>                 count->id = data[idx++];
>         if (read_format & PERF_FORMAT_LOST)
>                 count->lost = data[idx++];

Sure.

>
>
> and perhaps we should cancel that perf_counts_values's union and keep
> only 'val/ena/run...' fields?

I'd like to have them and use it for reading the lost count soon.

Thanks,
Namhyung
