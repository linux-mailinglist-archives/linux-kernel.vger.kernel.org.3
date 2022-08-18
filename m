Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E23597C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243100AbiHRDYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbiHRDYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:24:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962BC459B4;
        Wed, 17 Aug 2022 20:24:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j8so884896ejx.9;
        Wed, 17 Aug 2022 20:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=i/5FTk4ehPe1FyyuKCLJg6XVHxq2SQ4ha+cI9T3mg3w=;
        b=jVG/JT9/Bfyk2QC9r5gleNQHdiyhi6j2Uauh5fO6b9jw+f5ZqtDm409tS9fEBivFPJ
         Q/Dv0QHfIR8eVYym2anf107mTjSGI3hH+oNJsUrvgXTHJX6MAzKL+LPpt0gz8mewr/d2
         FzFIytXdXdVe6SduANzt2SxgX2yly8dfZoHzp7vtVcRGNQqxGn5i7TyQ9DZilvoLYOVk
         BfYV7eOoL2F6+4IhRjpx38G+xLAQOkuuob8xFI2+d3fmBw03yG2+JqoyQ76WHxu8XOxZ
         lUb+xzhUfMtFEitHhr6lgJU9VjfoG5S/qp/7gJjxDmYiwWEboKSFB4/vVmOreOUgytos
         OVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=i/5FTk4ehPe1FyyuKCLJg6XVHxq2SQ4ha+cI9T3mg3w=;
        b=TQ0SvaJs5v6/OtbhgHjBT30Hpc0WXlbVl8IO9PdcOVpMaeNRHXoMbZx4UdaZ2vVAv+
         GmZtP2T7JKbkdsI58S8mPeOCIwEnbTYpk9XlFAY57Zd5zht89v1DD4i6RNWK0byKluqX
         A6Ouzcydo2GtLWFIVPPVP+LkivksX7QTUCWkaFPj9ORyXpbdWOe4WEIwZ9IX+AQAlYp+
         FDaZQLMLuRLODIIot801iqVlaaIa8GacK0V25WwmLYSOVrlLDqVT6dTriTC9U7hjeUvy
         t3DQ+3grljI9K1f0W4/v0PeamgTJYXZ8juzN144nWFjoevL8E+4oLE0g5uYacrbJo6tS
         +usA==
X-Gm-Message-State: ACgBeo3SswwSwzweRkRqaKIRdQrmwEzf8hUk0B1DrrsCazg2nD6pipZz
        5GiyI8GIlhmO+dxdJCM50aWeuEu+NJe3ngK2JgK99zK7mOKQqO4PljY=
X-Google-Smtp-Source: AA6agR68ydPdGsAqXnYedHMznYevETK9SfkWZm7T/ZT1QyiE/ByPwlplDYMxsyn7W/r9ug1xRmGXd15ItRs6cckeceM=
X-Received: by 2002:a17:907:1b1c:b0:72f:9aac:ee41 with SMTP id
 mp28-20020a1709071b1c00b0072f9aacee41mr613895ejc.56.1660793043202; Wed, 17
 Aug 2022 20:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220817134324.702278-1-tcwzxx@gmail.com> <CAP-5=fVrpsid2_Ku=5hHeFSQ5Q1zE--5qszWw38ZVciq9Rxd5A@mail.gmail.com>
In-Reply-To: <CAP-5=fVrpsid2_Ku=5hHeFSQ5Q1zE--5qszWw38ZVciq9Rxd5A@mail.gmail.com>
From:   lika you <tcwzxx@gmail.com>
Date:   Thu, 18 Aug 2022 11:26:00 +0800
Message-ID: <CAHkAAVrhD4Z4=NtwD-sA-vwpQTj=sHB5V7Kr0KNFNSVsu+-DnQ@mail.gmail.com>
Subject: Re: [PATCH] perf tool: add skip_not_exec_file_map_events option
To:     Ian Rogers <irogers@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm so sorry for forgetting to reply to all. Here is the reply again.

Thanks for the reply.

The background is we have two types of tasks running on the same host.The high
priority one which is CPU overhead and the low priority which is IO overhead.
The high priority task has mmap many files as shared memory. The low priority
task may load multi TB data from SSD at once time which will cause the high
priority task file page cache to be swapped out. So we mmap all files with the
PROT_EXEC flag to prevent hot page cache to be swapped out. That cause
too many executable memory regions without symbols on it.

The trick is implementate here.
https://github.com/torvalds/linux/blob/master/mm/vmscan.c#L2572

Thanks again

On Thu, 18 Aug 2022 at 02:13, Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Aug 17, 2022 at 6:43 AM tcwzxx <tcwzxx@gmail.com> wrote:
> >
> > When generate the flame graph, the perf-script subcommand will
> > process all mmap event and add them to the rbtree. The 240,000
> > mmap region takes about 5 minutes, which is not useful for flame
> > graph. So add the skip-not-exec-file-map-events option to skip
> > not PROT_EXEC flag memory regions.
> >
> > Signed-off-by: tcwzxx <tcwzxx@gmail.com>
>
> Could you provide more context? A reproduction?
>
> When we synthesize mmap events we drop non-executable pages:
> https://github.com/torvalds/linux/blob/master/tools/perf/util/synthetic-events.c#L466
>
> Similarly in the kernel for the "dummy" event:
> https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L8258
>
> Thanks,
> Ian
>
> > ---
> >  tools/perf/builtin-report.c | 2 ++
> >  tools/perf/builtin-script.c | 3 +++
> >  tools/perf/util/machine.c   | 3 +++
> >  tools/perf/util/map.c       | 5 +++++
> >  tools/perf/util/map.h       | 2 ++
> >  5 files changed, 15 insertions(+)
> >
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 91ed41cc7d88..c28eb9450a66 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -1364,6 +1364,8 @@ int cmd_report(int argc, const char **argv)
> >                     "Disable raw trace ordering"),
> >         OPT_BOOLEAN(0, "skip-empty", &report.skip_empty,
> >                     "Do not display empty (or dummy) events in the output"),
> > +       OPT_BOOLEAN(0, "skip-not-exec-file-map_events", &skip_not_exec_file_map_events,
> > +                   "skip not exec map events"),
> >         OPT_END()
> >         };
> >         struct perf_data data = {
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 13580a9c50b8..e3f4e5e654c9 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -32,6 +32,7 @@
> >  #include "util/time-utils.h"
> >  #include "util/path.h"
> >  #include "util/event.h"
> > +#include "util/map.h"
> >  #include "ui/ui.h"
> >  #include "print_binary.h"
> >  #include "archinsn.h"
> > @@ -3936,6 +3937,8 @@ int cmd_script(int argc, const char **argv)
> >                     "Guest code can be found in hypervisor process"),
> >         OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
> >                     "Enable LBR callgraph stitching approach"),
> > +       OPT_BOOLEAN(0, "skip-not-exec-map_events", &skip_not_exec_file_map_events,
> > +                   "skip not exec map events"),
> >         OPTS_EVSWITCH(&script.evswitch),
> >         OPT_END()
> >         };
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 2a16cae28407..21dde9f9935c 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -1904,6 +1904,9 @@ int machine__process_mmap2_event(struct machine *machine,
> >         if (thread == NULL)
> >                 goto out_problem;
> >
> > +       if (skip_not_exec_file_map_events && !(event->mmap2.prot & PROT_EXEC))
> > +               goto out_problem;
> > +
> >         map = map__new(machine, event->mmap2.start,
> >                         event->mmap2.len, event->mmap2.pgoff,
> >                         &dso_id, event->mmap2.prot,
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index e0aa4a254583..2b51ca012c91 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -16,6 +16,8 @@
> >  #include "thread.h"
> >  #include "vdso.h"
> >
> > +bool skip_not_exec_file_map_events;
> > +
> >  static inline int is_android_lib(const char *filename)
> >  {
> >         return strstarts(filename, "/data/app-lib/") ||
> > @@ -168,6 +170,9 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> >                 if (dso == NULL)
> >                         goto out_delete;
> >
> > +               if (skip_not_exec_file_map_events && dso__type(dso, machine) == DSO__TYPE_UNKNOWN)
> > +                       goto out_delete;
> > +
> >                 map__init(map, start, start + len, pgoff, dso);
> >
> >                 if (anon || no_dso) {
> > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > index 3dcfe06db6b3..67b0e0f9f0ae 100644
> > --- a/tools/perf/util/map.h
> > +++ b/tools/perf/util/map.h
> > @@ -11,6 +11,8 @@
> >  #include <stdbool.h>
> >  #include <linux/types.h>
> >
> > +extern bool skip_not_exec_file_map_events;
> > +
> >  struct dso;
> >  struct maps;
> >  struct machine;
> > --
> > 2.34.1
> >
