Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1923859FEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbiHXPrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbiHXPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:47:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0FC31ECD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:45:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b5so16987625wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/4CgS497YurVrqQ2wYhTl+ey6pjS27PxE7RLVw+qVns=;
        b=MeaL150z8K8Z4J6A3U+FHkz+XdjoKxR25a2hjxsYZchm8L73rVZEHCh9UBSh5hLUrT
         Gcw2VGA8nYAefk456KE2pUJgYV8hEdQmcLRBthCQ0TlwyeXjFgCSLwpz+bFkAPd3xeAQ
         d+leLLYqJXF2QcVcq704qQqi+5Q2FJs4U9jVv1URSz4uiY3iFGvnUiPgeS2b0UrWemOK
         n0kpTyida6gC8ki6S/3w50j39LH3G8abubMzMV+SBKBC4X66CR7tprBI7xvFQTV7nz6s
         g36bGh9NJQQ5fn6z9Rglid0i1Xcy04vMQ6skhWS3XtJCHylW8ZiRnRa0RmblU2Pyg6ji
         V1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/4CgS497YurVrqQ2wYhTl+ey6pjS27PxE7RLVw+qVns=;
        b=sP3rO6QCAyGyB6SAUdKOlMLqq3w1AKNa98OvayqPPyCnQmzp50S8jb+DCfmIYt3cUh
         DE6CinP5lobujbHJxO/xpBIFZNVH5E2Yu6MPdJgx1rWq/hvkEKZFop1gxnLbGzcCCwaO
         Ea3OBhDDz3m8nZh5U16mw3hy6bBdYoSDL3V045hGxJTtIQiDXe/B53GhnZG6wNqnW2FG
         I/PFERoM2zBGHT+jOnTZdM3SvamOJxcEWFArxlKmWsSFAP7Yq8oqPFYUxBEUPU1jeraS
         LaxjTZa/uSkNQBraCBF32VzR8cxc2fPEPux3yt/udJgowGdZBc8SirqcNGF3KJ3aZQTg
         QnPA==
X-Gm-Message-State: ACgBeo2RkYK7mqbg83O0GTfpZVYsMNtxmV9wo4K3/CnOELN4HAmCPGfM
        rmByL7e2Mk+xofOfuc9FJtoRemTLhpBqc24W1rMVQQ==
X-Google-Smtp-Source: AA6agR6axg1+gK7f80oGloC+qkVYm0uTADt/QTSODMXk4vpRlmK9LV5PNwQWAnACDxGvNpfMFZxH4PonWMnsbD4tudE=
X-Received: by 2002:adf:d1ea:0:b0:225:474b:1061 with SMTP id
 g10-20020adfd1ea000000b00225474b1061mr10801075wrd.343.1661355956001; Wed, 24
 Aug 2022 08:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220824072814.16422-1-adrian.hunter@intel.com> <20220824072814.16422-5-adrian.hunter@intel.com>
In-Reply-To: <20220824072814.16422-5-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Aug 2022 08:45:44 -0700
Message-ID: <CAP-5=fVsXgHVwP1=OyvGF3iQT6g0zdu0KkbiMcnagKBMCjwKZQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf evlist: Add evlist__{en/dis}able_non_dummy()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-kernel@vger.kernel.org
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

On Wed, Aug 24, 2022 at 12:28 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Dummy events are used to provide sideband information like MMAP events that
> are always needed even when main events are disabled. Add functions that
> take that into account.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evlist.c | 30 ++++++++++++++++++++++++------
>  tools/perf/util/evlist.h |  2 ++
>  2 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 4c5e6e9f8d11..3cfe730c12b8 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -480,7 +480,7 @@ static int evlist__is_enabled(struct evlist *evlist)
>         return false;
>  }
>
> -static void __evlist__disable(struct evlist *evlist, char *evsel_name)
> +static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl_dummy)
>  {
>         struct evsel *pos;
>         struct evlist_cpu_iterator evlist_cpu_itr;
> @@ -502,6 +502,8 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>                                 continue;
>                         if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
>                                 continue;
> +                       if (excl_dummy && evsel__is_dummy_event(pos))
> +                               continue;
>                         if (pos->immediate)
>                                 has_imm = true;
>                         if (pos->immediate != imm)
> @@ -518,6 +520,8 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>                         continue;
>                 if (!evsel__is_group_leader(pos) || !pos->core.fd)
>                         continue;
> +               if (excl_dummy && evsel__is_dummy_event(pos))
> +                       continue;
>                 pos->disabled = true;
>         }
>
> @@ -533,15 +537,20 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>
>  void evlist__disable(struct evlist *evlist)
>  {
> -       __evlist__disable(evlist, NULL);
> +       __evlist__disable(evlist, NULL, false);
> +}
> +
> +void evlist__disable_non_dummy(struct evlist *evlist)
> +{
> +       __evlist__disable(evlist, NULL, true);

nit: I think it is better to  prefer to name the argument when passing
constants, it can avoid errors if later constants are introduced, etc.
It can also be checked by compiler warnings. As this is limited to the
same file it is not hugely critical.

>  }
>
>  void evlist__disable_evsel(struct evlist *evlist, char *evsel_name)
>  {
> -       __evlist__disable(evlist, evsel_name);
> +       __evlist__disable(evlist, evsel_name, false);
>  }
>
> -static void __evlist__enable(struct evlist *evlist, char *evsel_name)
> +static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_dummy)
>  {
>         struct evsel *pos;
>         struct evlist_cpu_iterator evlist_cpu_itr;
> @@ -560,6 +569,8 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
>                         continue;
>                 if (!evsel__is_group_leader(pos) || !pos->core.fd)
>                         continue;
> +               if (excl_dummy && evsel__is_dummy_event(pos))
> +                       continue;
>                 evsel__enable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
>         }
>         affinity__cleanup(affinity);
> @@ -568,6 +579,8 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
>                         continue;
>                 if (!evsel__is_group_leader(pos) || !pos->core.fd)
>                         continue;
> +               if (excl_dummy && evsel__is_dummy_event(pos))
> +                       continue;
>                 pos->disabled = false;
>         }
>
> @@ -581,12 +594,17 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
>
>  void evlist__enable(struct evlist *evlist)
>  {
> -       __evlist__enable(evlist, NULL);
> +       __evlist__enable(evlist, NULL, false);
> +}
> +
> +void evlist__enable_non_dummy(struct evlist *evlist)
> +{
> +       __evlist__enable(evlist, NULL, true);
>  }
>
>  void evlist__enable_evsel(struct evlist *evlist, char *evsel_name)
>  {
> -       __evlist__enable(evlist, evsel_name);
> +       __evlist__enable(evlist, evsel_name, false);
>  }
>
>  void evlist__toggle_enable(struct evlist *evlist)
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 3a464585d397..3a8474406738 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -205,6 +205,8 @@ void evlist__enable(struct evlist *evlist);
>  void evlist__toggle_enable(struct evlist *evlist);
>  void evlist__disable_evsel(struct evlist *evlist, char *evsel_name);
>  void evlist__enable_evsel(struct evlist *evlist, char *evsel_name);
> +void evlist__disable_non_dummy(struct evlist *evlist);
> +void evlist__enable_non_dummy(struct evlist *evlist);
>
>  void evlist__set_selected(struct evlist *evlist, struct evsel *evsel);
>
> --
> 2.25.1
>
