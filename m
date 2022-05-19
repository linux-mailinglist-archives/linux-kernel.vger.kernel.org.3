Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB62852CB05
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiESE0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiESE0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:26:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DA437A9A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:26:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso293601wmn.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cI0MBQijjLIque8/zmHMp1Z3NRxhlIbr3MhwWtgY+Vc=;
        b=oex0qIZnWe02/SnQ2nVgrWFifzmRFdJzZvfpo+Bhi5Y7oDqqXRDtvhyt0w0Hvbbntw
         pDzLAMUVP3X7iXceFqeg4Kr116ygQ+oNJKjiz6QtvoyGPf4eHllpry+vz4D6RgDkuu2j
         rj2HuOVUUgSJfjYkzrptMY5vWYvnnV0ddxQjkPT9yNs69hW3QYuUoPyrZrRC0R+Y+Szs
         9HOZirFtfe7lV8SzsUwDH70jRN5vFcrJa1ThfgR8VEScBfVQawYZ0NNr/viTtuPReHJy
         FbNmL1CBQtRVpHnY51XH27o7cJ6UqfdRwJCwXTg18y5EbZnfOjsEMfLuNNQT1YGYT9b0
         Hb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cI0MBQijjLIque8/zmHMp1Z3NRxhlIbr3MhwWtgY+Vc=;
        b=gJIhdA4q/3ctkthcRy/9Pkio1U0mPK7ut+V7CG+fVNuwo20ydfTxy3U58AyS9Q3870
         0JjmVnHlhmiMr+KMBq3gEjSxYvSInXG3mT0NGKyv3YW3qlkqSdGlIwvDJjTBjqc2LLUS
         QM9/kZP1j6Z5buIhTvN5q/rleJsBgVMVyuX2IiquTHKaD0DAvZnsKtWl5w+77VQInfe6
         y5WnT1UDIyYpbT6W0tAzvN46tT1PAY8jxPyjmWVcoRWOjBHupxZ/ZEa/p15Qffu0nrxc
         h7LiYwmgXs6eZROw9vpEY6x6njcRBBVRE86iHk+OJH988qCrOn6MIxx5YQTbrV0+ap8l
         UDCw==
X-Gm-Message-State: AOAM533rZRWFwcNVj48nIzMTGST1vFqGTL3bPXbzuPfSbeML8iFUKaAC
        lRcgtBznwF0zBJqg2gER60nz5/0q1KkNHXcB9rEmLA==
X-Google-Smtp-Source: ABdhPJzbIZEAZISf4NcpOoMUfXT7cGoK7qEWQFWWEi2wUdZ32e4tNWmHBW9lqBNjBXamMoxWpj8Ez+Bfh3Nt85VqCGY=
X-Received: by 2002:a05:600c:2258:b0:394:2045:bed with SMTP id
 a24-20020a05600c225800b0039420450bedmr2020307wmm.174.1652934396283; Wed, 18
 May 2022 21:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220518143900.1493980-1-kan.liang@linux.intel.com> <20220518143900.1493980-3-kan.liang@linux.intel.com>
In-Reply-To: <20220518143900.1493980-3-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 May 2022 21:26:24 -0700
Message-ID: <CAP-5=fW0aEBNB4CaDmDWZir3Asx8yHgCm7oa2+YNvifLagVtYA@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] perf stat: Always keep perf metrics topdown events
 in a group
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 7:39 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> If any member in a group has a different cpu mask than the other
> members, the current perf stat disables group. when the perf metrics
> topdown events are part of the group, the below <not supported> error
> will be triggered.
>
> $ perf stat -e "{slots,topdown-retiring,uncore_imc_free_running_0/dclk/}" -a sleep 1
> WARNING: grouped events cpus do not match, disabling group:
>   anon group { slots, topdown-retiring, uncore_imc_free_running_0/dclk/ }
>
>  Performance counter stats for 'system wide':
>
>        141,465,174      slots
>    <not supported>      topdown-retiring
>      1,605,330,334      uncore_imc_free_running_0/dclk/
>
> The perf metrics topdown events must always be grouped with a slots
> event as leader.
>
> Factor out evsel__remove_from_group() to only remove the regular events
> from the group.
>
> Remove evsel__must_be_in_group(), since no one use it anymore.
>
> With the patch, the topdown events aren't broken from the group for the
> splitting.
>
> $ perf stat -e "{slots,topdown-retiring,uncore_imc_free_running_0/dclk/}" -a sleep 1
> WARNING: grouped events cpus do not match, disabling group:
>   anon group { slots, topdown-retiring, uncore_imc_free_running_0/dclk/ }
>
>  Performance counter stats for 'system wide':
>
>        346,110,588      slots
>        124,608,256      topdown-retiring
>      1,606,869,976      uncore_imc_free_running_0/dclk/
>
>        1.003877592 seconds time elapsed
>
> Fixes: a9a1790247bd ("perf stat: Ensure group is defined on top of the same cpu mask")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c |  7 ++-----
>  tools/perf/util/evlist.c  |  6 +-----
>  tools/perf/util/evsel.c   | 13 +++++++++++--
>  tools/perf/util/evsel.h   |  2 +-
>  4 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a96f106dc93a..f058e8cddfa8 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -271,11 +271,8 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>                         pr_warning("     %s: %s\n", evsel->name, buf);
>                 }
>
> -               for_each_group_evsel(pos, leader) {
> -                       evsel__set_leader(pos, pos);
> -                       pos->core.nr_members = 0;
> -               }
> -               evsel->core.leader->nr_members = 0;
> +               for_each_group_evsel(pos, leader)
> +                       evsel__remove_from_group(pos, leader);
>         }
>  }
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index dfa65a383502..7fc544330fea 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1795,11 +1795,7 @@ struct evsel *evlist__reset_weak_group(struct evlist *evsel_list, struct evsel *
>                          * them. Some events, like Intel topdown, require being
>                          * in a group and so keep these in the group.
>                          */
> -                       if (!evsel__must_be_in_group(c2) && c2 != leader) {
> -                               evsel__set_leader(c2, c2);
> -                               c2->core.nr_members = 0;
> -                               leader->core.nr_members--;
> -                       }
> +                       evsel__remove_from_group(c2, leader);
>
>                         /*
>                          * Set this for all former members of the group
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index b98882cbb286..deb428ee5e50 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3083,7 +3083,16 @@ bool __weak arch_evsel__must_be_in_group(const struct evsel *evsel __maybe_unuse
>         return false;
>  }
>
> -bool evsel__must_be_in_group(const struct evsel *evsel)
> +/*
> + * Remove an event from a given group (leader).
> + * Some events, e.g., perf metrics Topdown events,
> + * must always be grouped. Ignore the events.
> + */
> +void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader)
>  {
> -       return arch_evsel__must_be_in_group(evsel);
> +       if (!arch_evsel__must_be_in_group(evsel) && evsel != leader) {
> +               evsel__set_leader(evsel, evsel);
> +               evsel->core.nr_members = 0;
> +               leader->core.nr_members--;
> +       }
>  }
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index a36172ed4cf6..47f65f8e7c74 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -483,7 +483,7 @@ bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>  bool evsel__is_leader(struct evsel *evsel);
>  void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
>  int evsel__source_count(const struct evsel *evsel);
> -bool evsel__must_be_in_group(const struct evsel *evsel);
> +void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader);
>
>  bool arch_evsel__must_be_in_group(const struct evsel *evsel);
>
> --
> 2.35.1
>
