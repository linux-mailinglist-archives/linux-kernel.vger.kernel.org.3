Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6CC583559
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiG0WeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiG0WeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:34:22 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5283558F7;
        Wed, 27 Jul 2022 15:34:21 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id c20so13669632qtw.8;
        Wed, 27 Jul 2022 15:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bamaAy7O7niPVirX1xMmIvvusqm/a9l82Aqy7GRrkkg=;
        b=idm8yOZI7eGCwwcC974nZkBBpviJQ24lExeZsLppnGfuXYOKCPlQMv+enqfoCe6g2j
         3D+rVLeA50hi1yoIwh1ZyafQoTpuyFEnGU4E7Nt7w5vH7KfCBfqYCxn+0UEKwF+yaTI6
         dODqqQEibG5lNhXUgMj+bblmncLos+e7GPgsrrInrajECvavjO1qBbwZM0g/msb6nV6Q
         I9MrOvt7UbeQxlou8M34RfQmKfxXnbip0rl26L551aKH5teEIhzYv/XXEj2XM6Mtll9R
         Aadts7HBDeT/7nsi/Tho3pSYbO+orjwrDIAe45kDQX1WRVPMKXDwB4splBXBuqJJxWm8
         y2HQ==
X-Gm-Message-State: AJIora9FmFciGixC9kEShWlJq/5IACvP4HKGnl+3ct/J2H6KyQJzkCng
        5XbnzVj6L6n7VLohJ3YJ8o3zNj9dUI6hKbAppdnpVuI6t2cQinG2
X-Google-Smtp-Source: AGRyM1sIwlcWEF7k08orHbM1e4dSfe+U2xi4u0nV/d5iHGU8v/D4QxnS+8syB/7lUREBEleVblRMsovZk9hHMxWiQyI=
X-Received: by 2002:ac8:5e09:0:b0:31f:44f5:5331 with SMTP id
 h9-20020ac85e09000000b0031f44f55331mr7328057qtx.66.1658961260872; Wed, 27 Jul
 2022 15:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220727111954.105118-1-gpavithrasha@gmail.com> <20220727111954.105118-2-gpavithrasha@gmail.com>
In-Reply-To: <20220727111954.105118-2-gpavithrasha@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Jul 2022 15:34:10 -0700
Message-ID: <CAM9d7cgqhFdoHneDe0h-i-c5WM+BLiuSpvfTyczCKGJQk8bwMQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] perf mutex with nsinfo: Updated pthread_mutex_t usage
To:     gpavithrasha@gmail.com
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 4:20 AM <gpavithrasha@gmail.com> wrote:
>
> From: pavithra <gpavithrasha@gmail.com>
>
> Updated usage of pthread_mutex_t with nsinfo
> with the new wrapped lock(struct) in mutex.h
> (remove data races).

It doesn't look like you updated the usage with new wrapping.
Instead you introduced new usage.  Then I think you need to
describe why it's needed and what problems it solves.

>
> Signed-off-by: pavithra <gpavithrasha@gmail.com>
> ---
>  tools/perf/builtin-inject.c   | 6 +++---
>  tools/perf/util/map.c         | 2 ++
>  tools/perf/util/probe-event.c | 6 +++++-
>  tools/perf/util/symbol.c      | 2 +-
>  4 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 372ecb3e2c06..81eaed8da207 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -388,10 +388,10 @@ static int perf_event__repipe_id_index(struct perf_session *session,
>  static int dso__read_build_id(struct dso *dso)
>  {
>         if (dso->has_build_id)
> -               return 0;
> -
> +               return 0;
> +
>         if (filename__read_build_id(dso->long_name, dso->build_id,
> -                                   sizeof(dso->build_id)) > 0) {
> +                                  sizeof(dso->build_id)) > 0) {

Unrelated whitespace changes.. is it really needed?

Also I'm not sure you are working on acme/perf/core branch.

>                 dso->has_build_id = true;
>                 return 0;
>         }
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 5b83ed1ebbd6..2ef5fe0cc53c 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -214,8 +214,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>                         if (!(prot & PROT_EXEC))
>                                 dso__set_loaded(dso);
>                 }
> +               mutex_lock(&dso->lock);
>                 dso->nsinfo = nsi;
>                 dso__put(dso);
> +               mutex_unlock(&dso->lock);
>         }
>         return map;
>  out_delete:
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 91cab5f669d2..e527f2612ba4 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -38,6 +38,7 @@
>  #include "session.h"
>  #include "string2.h"
>  #include "strbuf.h"
> +#include "mutex.h"
>
>  #include <subcmd/pager.h>
>  #include <linux/ctype.h>
> @@ -171,8 +172,11 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
>                 struct map *map;
>
>                 map = dso__new_map(target);
> -               if (map && map->dso)
> +               if (map && map->dso) {
> +                       mutex_lock(&map->dso->lock);
>                         map->dso->nsinfo = nsinfo__get(nsi);
> +                       mutex_unlock(&map->dso->lock);
> +               }
>                 return map;
>         } else {
>                 return kernel_get_module_map(target);
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 342be12cfa1e..4b711b13f915 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1619,7 +1619,7 @@ int dso__load(struct dso *dso, struct map *map)
>         struct nscookie nsc;
>         char newmapname[PATH_MAX];
>         const char *map_path = dso->long_name;
> -
> +       mutex_lock(&dso->lock);

No matching unlock?

Thanks,
Namhyung


>         perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0;
>         if (perfmap) {
>                 if (dso->nsinfo && (dso__find_perf_map(newmapname,
> --
> 2.25.1
>
