Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B46B598972
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345208AbiHRQ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345192AbiHRQ7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:59:47 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C883CBBA4E;
        Thu, 18 Aug 2022 09:59:39 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id u14so2166760oie.2;
        Thu, 18 Aug 2022 09:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=q7/Fq4wajEpRWsjYlv5hp9maHaZJ2PyakIzJtclDzD4=;
        b=TOf54i4QzknwmUsFPEzAad9zsCPT/sg+4uDsVqVcUIAk4WW/+VgnbAx4xhVd28QJQk
         WHaeK4fQxIE7R9GJwnKkBo/GnTO2zmijW1D3dF0OOa+kl3pmpNwY/jods/zMmWrah5H7
         2bJG0wulpu6KKCi2+s7MQwn0tFFrFxq+FBAlEN5yoF7EjPaYK/0fRC+Wna/jV2gh/GPq
         Fpseeeb44cICQAt/aN1IditH6tPaxBQ4G8O+SCerb+ISGKW6C3yrWwMlVlSeyv+bVqFr
         lGUIxdWcoDSOpumJI07lFzPdAb2hvasCDU2zkz7MdtcnnCr4mRT6JFO5WZ0D8Z8XtZjF
         TJIA==
X-Gm-Message-State: ACgBeo0kBPB29oJj1WFEav7U/3tVuqXwtUBM80ciV3uQjxNwmaUWwQXs
        hXxBAsgcj+25pCrOXQazJvwSdvEyA9fB57dwZ4E=
X-Google-Smtp-Source: AA6agR4iwsH/3Ly/RDW4D9ckyby0ca5r4L3Qy/tzmwa28TR5cN/koZwdMIxbIjeyB0wBmLJT0E/dwyKa+pYmuJsD5wA=
X-Received: by 2002:aca:6088:0:b0:343:75a6:d6a3 with SMTP id
 u130-20020aca6088000000b0034375a6d6a3mr1678269oib.92.1660841977477; Thu, 18
 Aug 2022 09:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220816221747.275828-1-namhyung@kernel.org> <20220816221747.275828-5-namhyung@kernel.org>
 <Yv4qu8xMpfzUQ/8L@krava>
In-Reply-To: <Yv4qu8xMpfzUQ/8L@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 18 Aug 2022 09:59:26 -0700
Message-ID: <CAM9d7ciQ=Vcp-wFdqB7G-t8k75uhrQiEiOHvVFX8WV4Od4LPQw@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf tools: Support reading PERF_FORMAT_LOST
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Aug 18, 2022 at 5:04 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Aug 16, 2022 at 03:17:47PM -0700, Namhyung Kim wrote:
>
> SNIP
>
> > diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> > index a7b0931d5137..7753368d70d6 100644
> > --- a/tools/perf/util/event.h
> > +++ b/tools/perf/util/event.h
> > @@ -65,7 +65,8 @@ struct stack_dump {
> >
> >  struct sample_read_value {
> >       u64 value;
> > -     u64 id;
> > +     u64 id;   /* only if PERF_FORMAT_ID */
> > +     u64 lost; /* only if PERF_FORMAT_LOST */
> >  };
>
> I was wondering why not to split this patch into smaller piece,
> but once you change this struct you break all the places

Right.. I'd like to do so but couldn't.. :)

>
> SNIP
>
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1541,7 +1541,7 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
> >  }
> >
> >  static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
> > -                          u64 val, u64 ena, u64 run)
> > +                          u64 val, u64 ena, u64 run, u64 lost)
> >  {
> >       struct perf_counts_values *count;
> >
> > @@ -1550,6 +1550,7 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
> >       count->val    = val;
> >       count->ena    = ena;
> >       count->run    = run;
> > +     count->lost   = lost;
> >
> >       perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
> >  }
> > @@ -1558,7 +1559,7 @@ static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int
> >  {
> >       u64 read_format = leader->core.attr.read_format;
> >       struct sample_read_value *v;
> > -     u64 nr, ena = 0, run = 0, i;
> > +     u64 nr, ena = 0, run = 0, lost = 0, i;
> >
> >       nr = *data++;
> >
> > @@ -1573,16 +1574,25 @@ static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int
> >
> >       v = (struct sample_read_value *) data;
> >
> > -     evsel__set_count(leader, cpu_map_idx, thread, v[0].value, ena, run);
> > +     if (read_format & PERF_FORMAT_LOST)
> > +             lost = v->lost;
> > +
> > +     evsel__set_count(leader, cpu_map_idx, thread, v[0].value, ena, run, lost);
> > +
> > +     v = next_sample_read_value(v, read_format);
>
> oneway of making this simpler here and share with other places
> could be adding something like:
>
>   for_each_group_data(v, i, nr, read_format) {
>   }
>
> but not sure how would that turn out, thoughts?

Looks good.  Let me try. :)


>
> >
> >       for (i = 1; i < nr; i++) {
> >               struct evsel *counter;
> >
> > -             counter = evlist__id2evsel(leader->evlist, v[i].id);
> > +             counter = evlist__id2evsel(leader->evlist, v->id);
> >               if (!counter)
> >                       return -EINVAL;
> >
> > -             evsel__set_count(counter, cpu_map_idx, thread, v[i].value, ena, run);
> > +             if (read_format & PERF_FORMAT_LOST)
> > +                     lost = v->lost;
> > +
> > +             evsel__set_count(counter, cpu_map_idx, thread, v->value, ena, run, lost);
> > +             v = next_sample_read_value(v, read_format);
> >       }
> >
> >       return 0;
> > @@ -2475,16 +2485,21 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> >
> >                       if (data->read.group.nr > max_group_nr)
> >                               return -EFAULT;
> > -                     sz = data->read.group.nr *
> > -                          sizeof(struct sample_read_value);
> > +
> > +                     sz = data->read.group.nr * sample_read_value_size(read_format);
> >                       OVERFLOW_CHECK(array, sz, max_size);
> > -                     data->read.group.values =
> > -                                     (struct sample_read_value *)array;
> > +                     data->read.group.values = (void *)array;
>
> nit, is this void casting needed?

Well.. the array is a pointer to u64 so the casting is needed.
But it's an unrelated change, can be dropped.

Thanks,
Namhyung


>
> >                       array = (void *)array + sz;
> >               } else {
> >                       OVERFLOW_CHECK_u64(array);
> >                       data->read.one.id = *array;
> >                       array++;
> > +
> > +                     if (read_format & PERF_FORMAT_LOST) {
> > +                             OVERFLOW_CHECK_u64(array);
> > +                             data->read.one.lost = *array;
> > +                             array++;
> > +                     }
> >               }
> >       }
> >
>
> SNIP
