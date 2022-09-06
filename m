Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD125AF2F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiIFRoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiIFRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:44:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA11029839
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:44:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bq9so3662627wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mmejXIhnispIqTZmUKcammd2NH7OYQosIOOt0JAydyA=;
        b=jYb46OsRLzHu5ur3bZaftMs/yXoKBA675Naqu1Dna673MxzBvDE0F4+5Ml9KfHk1FU
         JX902+8QwapqQgLxbKFmPivt+548g4g9p/caiqbrJ44gu7rbO0HhUFY7OfWZeb/JWBp6
         48W6ek3aEnA3MhUIkx6qywVTQrF50wLFDBJQCv6fKzGPgmww04/GRh412sqEqtsEvet6
         r9W6W1OxyKgfCAwaz0zEO9ARdQHOALw1I2qBdDDDUHd/TGVGN/55wnAkiazihLetPH8P
         jbz5k+xSUtNwF+YvVlMPvfYZ+0v9Tug6qTp2uAWaVyeZxOawdpplQfJBuI9l7eON3uNk
         t/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mmejXIhnispIqTZmUKcammd2NH7OYQosIOOt0JAydyA=;
        b=FnrjnD+/7rhtOpznT9kcrayjnkV4ZjemWLsdeKWX3dTKBiw4PrOn3TM0RM/RLsqSXU
         i/zGkpm7KQTz98/oPNYln9Uy3vJrYQpqgOr44lfROHHe4bmvN8XCIZgvsDrEWAGTck1t
         K9ZXAtpYnFlV6uLIeUu/B4uwCQoBqFVJtj56f1NmBkeFiej55NS0oVxLtidhnekQ+01E
         kohN4cQknhXBOGlzll53bsfCKMtunJBqQAgHpeaJivsYb+HbHMUodf1GnoVlBacuPjqp
         bJ4fT0QlXCg14LaIm12Py3BmrE5AHA8nTW6QNlenaQ/SMKZ9/wY9wP8IJkTMMJi81zmv
         jGfg==
X-Gm-Message-State: ACgBeo16nWP0GmNwT/L2aWLnnsysal6Wmk+4l3UH/Gucaj50mCCUisxi
        73weZbWLJMA5PGZMjr0+siXmzYpSGr6kkQZYKxSxng==
X-Google-Smtp-Source: AA6agR53WKeyMqSJhWY/+hkox4xbUh5fsIM4xda1qewXJeS+1McaAW1nq2DR6KvlRWrdlQGCnbG9al4r6+AIUvsIFMc=
X-Received: by 2002:a5d:64a8:0:b0:226:f3f3:9914 with SMTP id
 m8-20020a5d64a8000000b00226f3f39914mr15096010wrp.343.1662486238444; Tue, 06
 Sep 2022 10:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220905114209.8389-1-adrian.hunter@intel.com>
 <YxdEQkmkZjBC6wGb@krava> <60b5c9bf-4ec9-957e-17dd-aa0a50411ff9@intel.com>
In-Reply-To: <60b5c9bf-4ec9-957e-17dd-aa0a50411ff9@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 6 Sep 2022 10:43:45 -0700
Message-ID: <CAP-5=fW3MLdzA01gWRx7yH-b=J4oqUTj9KMtrB0ZDpb0wucZ4A@mail.gmail.com>
Subject: Re: [PATCH V2] libperf evlist: Fix per-thread mmaps for
 multi-threaded targets
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 7:04 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 6/09/22 15:59, Jiri Olsa wrote:
> > On Mon, Sep 05, 2022 at 02:42:09PM +0300, Adrian Hunter wrote:
> >
> > SNIP
> >
> >> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> >> index e6c98a6e3908..6b1bafe267a4 100644
> >> --- a/tools/lib/perf/evlist.c
> >> +++ b/tools/lib/perf/evlist.c
> >> @@ -486,6 +486,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
> >>                      if (ops->idx)
> >>                              ops->idx(evlist, evsel, mp, idx);
> >>
> >> +                    pr_debug("idx %d: mmapping fd %d\n", idx, *output);
> >>                      if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
> >>                              return -1;
> >>
> >> @@ -494,6 +495,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
> >>                      if (!idx)
> >>                              perf_evlist__set_mmap_first(evlist, map, overwrite);
> >>              } else {
> >> +                    pr_debug("idx %d: set output fd %d -> %d\n", idx, fd, *output);
> >>                      if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
> >>                              return -1;
> >>
> >> @@ -519,6 +521,48 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
> >>      return 0;
> >>  }
> >>
> >> +static int
> >> +mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
> >> +            struct perf_mmap_param *mp)
> >> +{
> >> +    int nr_threads = perf_thread_map__nr(evlist->threads);
> >> +    int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
> >> +    int cpu, thread, idx = 0;
> >> +    int nr_mmaps = 0;
> >> +
> >> +    pr_debug("%s: nr cpu values (may include -1) %d nr threads %d\n",
> >> +             __func__, nr_cpus, nr_threads);
> >
> > -1 as cpu value is only for 'empty' perf_cpu_map, right?
>
> The cpu map is a map of valid 3rd arguments to perf_event_open, so -1
> means all CPUs which is per-thread by necessity.
>
> >
> >> +
> >> +    /* per-thread mmaps */
> >> +    for (thread = 0; thread < nr_threads; thread++, idx++) {
> >> +            int output = -1;
> >> +            int output_overwrite = -1;
> >> +
> >> +            if (mmap_per_evsel(evlist, ops, idx, mp, 0, thread, &output,
> >> +                               &output_overwrite, &nr_mmaps))
> >> +                    goto out_unmap;
> >> +    }
> >> +
> >> +    /* system-wide mmaps i.e. per-cpu */
> >> +    for (cpu = 1; cpu < nr_cpus; cpu++, idx++) {
> >> +            int output = -1;
> >> +            int output_overwrite = -1;
> >> +
> >> +            if (mmap_per_evsel(evlist, ops, idx, mp, cpu, 0, &output,
> >> +                               &output_overwrite, &nr_mmaps))
> >> +                    goto out_unmap;
> >> +    }
> >
> > will this loop be executed? we are in here because all_cpus is empty, right?
>
> Yes it is executed.  I put back the code that was there before ae4f8ae16a07
> ("libperf evlist: Allow mixing per-thread and per-cpu mmaps"), which uses
> perf_cpu_map__empty() which only checks the first entry is -1:
>
> bool perf_cpu_map__empty(const struct perf_cpu_map *map)
> {
>         return map ? map->map[0].cpu == -1 : true;
> }
>
> But there can be more CPUs in the map, so perf_cpu_map__empty()
> returns true for the per-thread case, as desired, even if there
> are also system-wide CPUs.
>
> I guess perf_cpu_map__empty() needs renaming.

Let me nitpick :-) -1 means any CPU, as per the perf_event_open man
page, all CPUs would be a CPU map with every CPU on the system in it -
all CPUs can have some ambiguity in whether it includes offline CPUs,
which isn't true for any. I've not sent out a patch to clean up the
libperf CPU map code as I'd like to propose we start a libperf2 (with
LPC coming up it'd be a good place to discuss this, there's also the
office hours on Thursday). What I hope for libperf2 is that we can
make its license the same as libbpf, so the code can be more widely
included in projects. As such it wouldn't be valid to copy paste
libperf's CPU map into libperf2, but a larger clean up and refactor
could be put into libperf2 with libperf and perf depending upon it.
There are other areas that'd benefit from cleanup such as how a dash
is handled by parse events. It makes sense (imo) for this all to
become libperf2 work, and once we're happy with libperf2 we can
replace libperf completely.

Thanks,
Ian

> >
> > thanks,
> > jirka
> >
> >> +
> >> +    if (nr_mmaps != evlist->nr_mmaps)
> >> +            pr_err("Miscounted nr_mmaps %d vs %d\n", nr_mmaps, evlist->nr_mmaps);
> >> +
> >> +    return 0;
> >> +
> >> +out_unmap:
> >> +    perf_evlist__munmap(evlist);
> >> +    return -1;
> >> +}
> >
> > SNIP
>
