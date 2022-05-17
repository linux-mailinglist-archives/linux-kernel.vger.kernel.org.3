Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6295297B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbiEQDLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiEQDL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:11:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7371217079
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:11:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r23so6823490wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMh76iAC9YB/sb6ygJH2Vie34czdyQCqLma1106KOhU=;
        b=fwgypfnjBUPStUq3qUibeKOm3vSgp+Uiz0JSOinYycCjr/N/gEtCip87733ZfgMb0o
         DDilvtrOJbjXE0nTAIeO6BD5+YmyMC6NNysWpV2jQa1jXF80xmoLoZtDcgr+P8X74oRg
         jBLNe5fFxVJ9dhV6RujJ/SW9cxCyMfk9Ubc8p3vNM7TxQwJbVpBK7snTbW3ed//avZNy
         BoCh7Cyii0qkZuCnvxKJELgd9PD2JdQVv8C7+dpopOow8fg2wazvcz1SXpvg3zKv4iPA
         WGY63mtQHcHeWpMGCw1DTQw3uVm/zqS6RQPwU9wORepCf04eW58iRmkNFCthRadPumrN
         gakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMh76iAC9YB/sb6ygJH2Vie34czdyQCqLma1106KOhU=;
        b=rVlSk/vibDFs8u3bijdzAbnzA8MeDSzVmTz/EwD75b7FdQlXcdhCRdd+2++zZJxMSY
         bLGn2MIGkLaId7W/3gpA4M+qi98NDr0Py/scoVYFpXUM3DVesMTzTstF1URxmxBR3ND2
         YXDtlRd/mH9Xx6fMDcO2JPo6JLAPBkart2cV5ojH5XbEBYd660QFsTLzQwv7uxJ6l6ih
         ogxyCA80t/8jJ++K1J6V80KqznkE6I6fOfr6jmcv8nxOV3R/nMP4m/ed4rbG/h0Rwy6s
         B3Lsrn08n9f0gfuSAjzbiWuvGpSq1Y6t9B4e6Oj/nfVYDP/BuXLQpltoCJulWCnNgBbo
         Mf3w==
X-Gm-Message-State: AOAM5311BGIWMtSooJtGqd/FL3GVg869u3TW7x0BTPQ4Lg9PivZIbcMq
        JEHLh/vbNDs8rFIu83VUIFJ6uMoy0h68gvb0yfk98Kj68FRVQg==
X-Google-Smtp-Source: ABdhPJwxyB7THXGUrXSj3fPuvTpuwBfaL/Rfsom2JZMVxvWWAQgFvoZnZLqpOAN4YrrGninfpOP1PZ4bhssvppzaMBo=
X-Received: by 2002:a5d:674c:0:b0:20d:87e:8d6f with SMTP id
 l12-20020a5d674c000000b0020d087e8d6fmr6668508wrw.40.1652757084847; Mon, 16
 May 2022 20:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220516152436.1104757-1-kan.liang@linux.intel.com> <20220516152436.1104757-3-kan.liang@linux.intel.com>
In-Reply-To: <20220516152436.1104757-3-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 16 May 2022 20:11:11 -0700
Message-ID: <CAP-5=fUpUtWAME1wCmEycONzSwEe5m76b4jB14M8+B6Ptks3jQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] perf stat: Always keep perf metrics topdown events
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

On Mon, May 16, 2022 at 8:25 AM <kan.liang@linux.intel.com> wrote:
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
> ---
>  tools/perf/builtin-stat.c |  7 +++----
>  tools/perf/util/evlist.c  |  6 +-----
>  tools/perf/util/evsel.c   | 13 +++++++++++--
>  tools/perf/util/evsel.h   |  2 +-
>  4 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a96f106dc93a..75c88c7939b1 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -271,10 +271,9 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>                         pr_warning("     %s: %s\n", evsel->name, buf);
>                 }
>
> -               for_each_group_evsel(pos, leader) {
> -                       evsel__set_leader(pos, pos);
> -                       pos->core.nr_members = 0;
> -               }
> +               for_each_group_evsel(pos, leader)
> +                       evsel__remove_from_group(pos, leader);
> +
>                 evsel->core.leader->nr_members = 0;

This shouldn't be necessary now.

>         }
>  }
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

Should we also have:

if (leader->core.nr_members == 1)
     leader->core.nr_members = 0;

Other wise say:

{instructions,cycles}

with a remove of cycles becomes:

{instructions}, cycles

rather than the previous:

instructions,cycles

Actually, looking at:
https://lore.kernel.org/lkml/20220512061308.1152233-2-irogers@google.com/

+ /* Reset the leader count if all entries were removed. */
+ if (leader->core.nr_members)
+ leader->core.nr_members = 0;

is wrong and should be:

+ /* Reset the leader count if all entries were removed. */
+ if (leader->core.nr_members == 1)
+ leader->core.nr_members = 0;

I'll fix and re-send.

Thanks,
Ian

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
