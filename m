Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59E597585
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiHQSNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiHQSNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:13:40 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D24F32B84
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 11:13:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j26so4800207wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AoLCAbLDO5OKQ45Upb5zhSD4FC4CobRiXEeHndZfFHs=;
        b=ox6h+dfiVDke1t4uuzgyltlICgBnQ1/58MJNplaIGdEIyNts7Uk1lgald0iUw2nMfC
         yP86/49AcLMoqg8tkR2T6acPQkCZqStjiM2+ckIhZO1NRDnRhw4cGlzS1ExCl54Wwdlt
         o46oE8XvStO596NsNAi5MQcK78HTIXfOLy1NbqeXh4MVdEf61SpOlyyltPgLV95LXFxR
         Krn3dUNXhi+ojdC4FiGokAAVVXKawpyzEUWYoJDOSsu+RyH/4Bzwa4aCBW+cQpjgqM4k
         sAiMiRBb5tVg+etFVxFLBr+IIkkSHYPsgiA/0D95iEsuBkGC3dpVXyQh7QMJWS/huZ/1
         0sTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AoLCAbLDO5OKQ45Upb5zhSD4FC4CobRiXEeHndZfFHs=;
        b=LMWdsNGzWJV2MmrxeWiK9PBJZ9Npup5LbkPRmECBrOgiHgZG8to7SGQCiPaQqQUPZ8
         GpSh5DeflYHUO4SknU6IIyBfPBw0GquDtNspfHx7IEWCMP6lZ7EIcgR9LFFkXDced781
         OezGOl/QXbqOmgjULAcrhsS5glDRDZ3sdOvv1mTYMfMY2nE8IFAYRiWn6iBlKiiWCTcP
         lVgYJgPaRBQotuqkCLN5B+xdaUOxcPMdJ5TQL5yXpQWlMMe+DrEgAMl7vF0/BP2JnaG/
         PpuxTd48JM3v+UgDy7SoHqeR8nqyMfA9Uv8BAQme12mWsl8iGDDU/45q+cmkbwv3Uax7
         7f7A==
X-Gm-Message-State: ACgBeo0VzsoM4g/8CZW6NA2PlaG4aYQFrAxvWAeG2p39eClB3KZBw1pM
        K24zinl8b/eH4Ke5vgdla0NB+h7QYpmWQ93ptzBzKg==
X-Google-Smtp-Source: AA6agR4RQoJMtBDJGpJeKlnU6pxN+BsYEcPmRSHJ/eyjmjIXSq9zHCKdu25c0jH2OgNF9mr3rEmMZNkydhBo/OdebjI=
X-Received: by 2002:a7b:cb44:0:b0:3a4:e8c7:59a2 with SMTP id
 v4-20020a7bcb44000000b003a4e8c759a2mr2892114wmj.67.1660760015775; Wed, 17 Aug
 2022 11:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220817134324.702278-1-tcwzxx@gmail.com>
In-Reply-To: <20220817134324.702278-1-tcwzxx@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 17 Aug 2022 11:13:23 -0700
Message-ID: <CAP-5=fVrpsid2_Ku=5hHeFSQ5Q1zE--5qszWw38ZVciq9Rxd5A@mail.gmail.com>
Subject: Re: [PATCH] perf tool: add skip_not_exec_file_map_events option
To:     tcwzxx <tcwzxx@gmail.com>
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

On Wed, Aug 17, 2022 at 6:43 AM tcwzxx <tcwzxx@gmail.com> wrote:
>
> When generate the flame graph, the perf-script subcommand will
> process all mmap event and add them to the rbtree. The 240,000
> mmap region takes about 5 minutes, which is not useful for flame
> graph. So add the skip-not-exec-file-map-events option to skip
> not PROT_EXEC flag memory regions.
>
> Signed-off-by: tcwzxx <tcwzxx@gmail.com>

Could you provide more context? A reproduction?

When we synthesize mmap events we drop non-executable pages:
https://github.com/torvalds/linux/blob/master/tools/perf/util/synthetic-events.c#L466

Similarly in the kernel for the "dummy" event:
https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L8258

Thanks,
Ian

> ---
>  tools/perf/builtin-report.c | 2 ++
>  tools/perf/builtin-script.c | 3 +++
>  tools/perf/util/machine.c   | 3 +++
>  tools/perf/util/map.c       | 5 +++++
>  tools/perf/util/map.h       | 2 ++
>  5 files changed, 15 insertions(+)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 91ed41cc7d88..c28eb9450a66 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1364,6 +1364,8 @@ int cmd_report(int argc, const char **argv)
>                     "Disable raw trace ordering"),
>         OPT_BOOLEAN(0, "skip-empty", &report.skip_empty,
>                     "Do not display empty (or dummy) events in the output"),
> +       OPT_BOOLEAN(0, "skip-not-exec-file-map_events", &skip_not_exec_file_map_events,
> +                   "skip not exec map events"),
>         OPT_END()
>         };
>         struct perf_data data = {
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 13580a9c50b8..e3f4e5e654c9 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -32,6 +32,7 @@
>  #include "util/time-utils.h"
>  #include "util/path.h"
>  #include "util/event.h"
> +#include "util/map.h"
>  #include "ui/ui.h"
>  #include "print_binary.h"
>  #include "archinsn.h"
> @@ -3936,6 +3937,8 @@ int cmd_script(int argc, const char **argv)
>                     "Guest code can be found in hypervisor process"),
>         OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
>                     "Enable LBR callgraph stitching approach"),
> +       OPT_BOOLEAN(0, "skip-not-exec-map_events", &skip_not_exec_file_map_events,
> +                   "skip not exec map events"),
>         OPTS_EVSWITCH(&script.evswitch),
>         OPT_END()
>         };
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 2a16cae28407..21dde9f9935c 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1904,6 +1904,9 @@ int machine__process_mmap2_event(struct machine *machine,
>         if (thread == NULL)
>                 goto out_problem;
>
> +       if (skip_not_exec_file_map_events && !(event->mmap2.prot & PROT_EXEC))
> +               goto out_problem;
> +
>         map = map__new(machine, event->mmap2.start,
>                         event->mmap2.len, event->mmap2.pgoff,
>                         &dso_id, event->mmap2.prot,
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index e0aa4a254583..2b51ca012c91 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -16,6 +16,8 @@
>  #include "thread.h"
>  #include "vdso.h"
>
> +bool skip_not_exec_file_map_events;
> +
>  static inline int is_android_lib(const char *filename)
>  {
>         return strstarts(filename, "/data/app-lib/") ||
> @@ -168,6 +170,9 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>                 if (dso == NULL)
>                         goto out_delete;
>
> +               if (skip_not_exec_file_map_events && dso__type(dso, machine) == DSO__TYPE_UNKNOWN)
> +                       goto out_delete;
> +
>                 map__init(map, start, start + len, pgoff, dso);
>
>                 if (anon || no_dso) {
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 3dcfe06db6b3..67b0e0f9f0ae 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -11,6 +11,8 @@
>  #include <stdbool.h>
>  #include <linux/types.h>
>
> +extern bool skip_not_exec_file_map_events;
> +
>  struct dso;
>  struct maps;
>  struct machine;
> --
> 2.34.1
>
