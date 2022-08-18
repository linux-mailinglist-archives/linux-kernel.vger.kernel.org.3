Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE655986C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343912AbiHRPAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbiHRPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:00:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A2357890
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:00:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h24so2035615wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UYjHY1acINgL9m9sUZH1KoEEKDAQudNgC+8E9iR494E=;
        b=VPZ5VId64ZyCGoL16RvVHPOvKXcIeR2L1XXakxXJNuZ7IxWTe5wKRfHrsed2GNe7YJ
         x9BhzMTcFs/HgjFymb5+42uEk2aNp0H7+3IJTohAu5UK78w6JzKq54KXt49wUcqu8nT3
         6+BPczQQRlmM1pLg7GeQsb48VegIqKVAvM90/HpmdwHek5LllTeXtnp2Zg50z4UxZrul
         ojPZCG3c2ThOXMjKXX6Jyxs20sAkt/qc+iRhLpBmK2sBYDL5b/PnLb2k+s8oz0AYJrv9
         lMM1xg+aBmy3OBgQBGxXedl+PrGuUN+2nlPrYaSPPsdZJEzo8busnqIicnr/DkMaiFbN
         6KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UYjHY1acINgL9m9sUZH1KoEEKDAQudNgC+8E9iR494E=;
        b=G3neXa6mDy9o+yOM1wSENEfiuK4wbkzT+KmKNmYHxv8/mkYUEOyiDblhfRpzy7Tli+
         fOmSpjrZNtjxoO+xTML0KtgRpw2a1hKhqKRXgWg2wPMK4ivxy/QsOPHoJNMuNgHpBBNG
         hHLa6pQtKJnwJSQq1FOrF5vjavlHgNzbQwJttzvnTeslKsnvQUqiPrs9n+7drggd2x/O
         aJbew1BV+EYaOV1Vs6WXmWAo8uYMHy7OCiAhPQUdqrLWmM3mPO0Qxq9awZSwBNOypg6i
         qp3tHll7WEGs9M3Tfwvt+/iBnfqsoPkV/0ueMkMR1zGAzcid1jf0hsnMfc3srn1Tbbdv
         uBgA==
X-Gm-Message-State: ACgBeo0agOjHHfdyIpjRREPXsNlDDbRXt3fpPkZN6pgle/aQAz+cWlW7
        H1YCQKu7QiJ4kj8J2iEMwaYDOFEQQgRC02bT9YGaRQ==
X-Google-Smtp-Source: AA6agR6+bvZZrHOIwJzUSQEqkUk4syxjsSUxRRkrDUIpaUWwNf0LMbTP4UKbRfPhv8GAF+8s9OwIEjWUSAJxmbspxqY=
X-Received: by 2002:a5d:6789:0:b0:225:2787:d44f with SMTP id
 v9-20020a5d6789000000b002252787d44fmr1771228wru.343.1660834815588; Thu, 18
 Aug 2022 08:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220817134324.702278-1-tcwzxx@gmail.com> <CAP-5=fVrpsid2_Ku=5hHeFSQ5Q1zE--5qszWw38ZVciq9Rxd5A@mail.gmail.com>
 <CAHkAAVrhD4Z4=NtwD-sA-vwpQTj=sHB5V7Kr0KNFNSVsu+-DnQ@mail.gmail.com>
In-Reply-To: <CAHkAAVrhD4Z4=NtwD-sA-vwpQTj=sHB5V7Kr0KNFNSVsu+-DnQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 18 Aug 2022 08:00:03 -0700
Message-ID: <CAP-5=fUfpmLPfAP1NZ+O5UTWYrAvzhsepvCkYpj3UE9Q5e6=mg@mail.gmail.com>
Subject: Re: [PATCH] perf tool: add skip_not_exec_file_map_events option
To:     lika you <tcwzxx@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 17, 2022 at 8:24 PM lika you <tcwzxx@gmail.com> wrote:
>
> I'm so sorry for forgetting to reply to all. Here is the reply again.
>
> Thanks for the reply.
>
> The background is we have two types of tasks running on the same host.The high
> priority one which is CPU overhead and the low priority which is IO overhead.
> The high priority task has mmap many files as shared memory. The low priority
> task may load multi TB data from SSD at once time which will cause the high
> priority task file page cache to be swapped out. So we mmap all files with the
> PROT_EXEC flag to prevent hot page cache to be swapped out. That cause
> too many executable memory regions without symbols on it.
>
> The trick is implementate here.
> https://github.com/torvalds/linux/blob/master/mm/vmscan.c#L2572
>
> Thanks again

Thanks. So you are making data pages executable for the sake of
getting "better chances to stay in memory under moderate memory
pressure." Having lots of executable pages in your program isn't
great, I'm reminded of efforts to stop stacks from being executable.
This also feels like a case where madvise should be being used, for
example, the MADV_WILLNEED option. Given this, I'm not sure supporting
this case in the perf tool makes sense.

> On Thu, 18 Aug 2022 at 02:13, Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Aug 17, 2022 at 6:43 AM tcwzxx <tcwzxx@gmail.com> wrote:
> > >
> > > When generate the flame graph, the perf-script subcommand will
> > > process all mmap event and add them to the rbtree. The 240,000
> > > mmap region takes about 5 minutes, which is not useful for flame
> > > graph. So add the skip-not-exec-file-map-events option to skip
> > > not PROT_EXEC flag memory regions.
> > >
> > > Signed-off-by: tcwzxx <tcwzxx@gmail.com>
> >
> > Could you provide more context? A reproduction?
> >
> > When we synthesize mmap events we drop non-executable pages:
> > https://github.com/torvalds/linux/blob/master/tools/perf/util/synthetic-events.c#L466
> >
> > Similarly in the kernel for the "dummy" event:
> > https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L8258
> >
> > Thanks,
> > Ian
> >
> > > ---
> > >  tools/perf/builtin-report.c | 2 ++
> > >  tools/perf/builtin-script.c | 3 +++
> > >  tools/perf/util/machine.c   | 3 +++
> > >  tools/perf/util/map.c       | 5 +++++
> > >  tools/perf/util/map.h       | 2 ++
> > >  5 files changed, 15 insertions(+)
> > >
> > > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > > index 91ed41cc7d88..c28eb9450a66 100644
> > > --- a/tools/perf/builtin-report.c
> > > +++ b/tools/perf/builtin-report.c
> > > @@ -1364,6 +1364,8 @@ int cmd_report(int argc, const char **argv)
> > >                     "Disable raw trace ordering"),
> > >         OPT_BOOLEAN(0, "skip-empty", &report.skip_empty,
> > >                     "Do not display empty (or dummy) events in the output"),
> > > +       OPT_BOOLEAN(0, "skip-not-exec-file-map_events", &skip_not_exec_file_map_events,
> > > +                   "skip not exec map events"),
> > >         OPT_END()
> > >         };
> > >         struct perf_data data = {
> > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > > index 13580a9c50b8..e3f4e5e654c9 100644
> > > --- a/tools/perf/builtin-script.c
> > > +++ b/tools/perf/builtin-script.c
> > > @@ -32,6 +32,7 @@
> > >  #include "util/time-utils.h"
> > >  #include "util/path.h"
> > >  #include "util/event.h"
> > > +#include "util/map.h"
> > >  #include "ui/ui.h"
> > >  #include "print_binary.h"
> > >  #include "archinsn.h"
> > > @@ -3936,6 +3937,8 @@ int cmd_script(int argc, const char **argv)
> > >                     "Guest code can be found in hypervisor process"),
> > >         OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
> > >                     "Enable LBR callgraph stitching approach"),
> > > +       OPT_BOOLEAN(0, "skip-not-exec-map_events", &skip_not_exec_file_map_events,
> > > +                   "skip not exec map events"),
> > >         OPTS_EVSWITCH(&script.evswitch),
> > >         OPT_END()
> > >         };
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index 2a16cae28407..21dde9f9935c 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -1904,6 +1904,9 @@ int machine__process_mmap2_event(struct machine *machine,
> > >         if (thread == NULL)
> > >                 goto out_problem;
> > >
> > > +       if (skip_not_exec_file_map_events && !(event->mmap2.prot & PROT_EXEC))
> > > +               goto out_problem;

Do you mean to drop all executable pages with the flag here or just
those with the DSO__TYPE_UNKNOWN (as below)? It reads that all
executable pages will be dropped.

Thanks,
Ian

> > > +
> > >         map = map__new(machine, event->mmap2.start,
> > >                         event->mmap2.len, event->mmap2.pgoff,
> > >                         &dso_id, event->mmap2.prot,
> > > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > > index e0aa4a254583..2b51ca012c91 100644
> > > --- a/tools/perf/util/map.c
> > > +++ b/tools/perf/util/map.c
> > > @@ -16,6 +16,8 @@
> > >  #include "thread.h"
> > >  #include "vdso.h"
> > >
> > > +bool skip_not_exec_file_map_events;
> > > +
> > >  static inline int is_android_lib(const char *filename)
> > >  {
> > >         return strstarts(filename, "/data/app-lib/") ||
> > > @@ -168,6 +170,9 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> > >                 if (dso == NULL)
> > >                         goto out_delete;
> > >
> > > +               if (skip_not_exec_file_map_events && dso__type(dso, machine) == DSO__TYPE_UNKNOWN)
> > > +                       goto out_delete;
> > > +
> > >                 map__init(map, start, start + len, pgoff, dso);
> > >
> > >                 if (anon || no_dso) {
> > > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > > index 3dcfe06db6b3..67b0e0f9f0ae 100644
> > > --- a/tools/perf/util/map.h
> > > +++ b/tools/perf/util/map.h
> > > @@ -11,6 +11,8 @@
> > >  #include <stdbool.h>
> > >  #include <linux/types.h>
> > >
> > > +extern bool skip_not_exec_file_map_events;
> > > +
> > >  struct dso;
> > >  struct maps;
> > >  struct machine;
> > > --
> > > 2.34.1
> > >
