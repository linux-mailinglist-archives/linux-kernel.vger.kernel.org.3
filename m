Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACB54EA1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345724AbiC1Uuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346396AbiC1Usg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:48:36 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6EF4D621
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:46:42 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id o67so17072412vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XsQUCW+gJbF0u5yR61fkU3TsOCnzNiiW+Vxpx9INrJc=;
        b=MNDWq16FFczuLNyJYyOX7vHHTdWA2Wu9kBX8qv46n3K741rT37IeIbD5nIaONQCbZw
         ykDGIGbG84boAlB7ETuwBxvrdxO+W+mgFtJ62oabT7/6qxVREQR3w7OLi7valopAvXDs
         AV7VBcy2wlN3N6BksJRwTutIU587j9Y07p2fp50UjdbZoG4WdtCzvC30Y8HTOdESgA+w
         0VVUlhmtXEPzAgba0s1aNVkRTMFb72tQDKquGKo/uMscY8thjFyOoFsVZ/92RXSwejP0
         1RumF0DEYGBBRUsTdmmR9HLRx5PFijQywtx0AE7xJFZqYlsuJfLcyUGEm8N36jj/I/uo
         1OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XsQUCW+gJbF0u5yR61fkU3TsOCnzNiiW+Vxpx9INrJc=;
        b=b6QJyZ335RkJtjhubY7t44jF6CTto+sKCTTPESkWOkPfsqFjO4cfpQDfDUa/4GKGEk
         Lx/kg7M8CEq/kGmqYKmj0+qtJ+Gw3IUczOfoD635Of8g3EKdgKnz7tpInd5m6xKThX0o
         YW8np/7M61qjoC42/N39nNJGvUgwgSAlRsuTO3v1GSyLKqL3UubCXwBYr1FrQjU1DcsK
         Y4gGrjymIIovXxHBtoyV+wqQlDEZNIDRsvi1do8n8Cpzv8UzKFTODXw8W9oTUzSgdoBS
         2AMlEXgmdCP7dVmD8EJD1+EMvYasn9ftEQwB3Ai1PRYcEvix+gVmH2xklA0d/ml0BSog
         cY3g==
X-Gm-Message-State: AOAM530UopKmJHVeBJz6kXibT3fg8hIUYZENAlBr+IIhTeqNuMn7loLS
        +KW6USPpy0LgNw+XwjvAhlAuDqMdzui9+RXc00B9+w==
X-Google-Smtp-Source: ABdhPJzzdXoVPaMj6oTX3qrkIGyEHAVu69MNP7vNBnLGNfBJAsNqF3ReaFVP6i9HdVRszInntBnpHH+cIw0gdA37t+k=
X-Received: by 2002:a05:6102:c8b:b0:325:983f:9862 with SMTP id
 f11-20020a0561020c8b00b00325983f9862mr5858756vst.74.1648500401268; Mon, 28
 Mar 2022 13:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220328062414.1893550-1-irogers@google.com> <20220328062414.1893550-5-irogers@google.com>
 <YkIbXzCYEutqxQRE@kernel.org>
In-Reply-To: <YkIbXzCYEutqxQRE@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 28 Mar 2022 13:46:29 -0700
Message-ID: <CAP-5=fXUPTPgKE1TAtBxx4hBNYQJwDbHf+ZNq7AKkaYabYC+KA@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf stat: Avoid segv if core.user_cpus isn't set.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Mon, Mar 28, 2022 at 1:32 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sun, Mar 27, 2022 at 11:24:13PM -0700, Ian Rogers escreveu:
> > Passing null to perf_cpu_map__max doesn't make sense as there is no
> > valid max. Avoid this problem by null checking in
> > perf_stat_init_aggr_mode.
>
> Applying this one after changing user_cpus back to cpus as this is a fix
> independent of this patchset.
>
> In the future, please try to have such patches at the beginning of the
> series, so that  they can get cherry-picked more easily.

Ack. The problem is best exhibited when the intersect happens, without
it getting a reproducer wasn't something I was able to do.

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 5bee529f7656..ecd5cf4fd872 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1472,7 +1472,10 @@ static int perf_stat_init_aggr_mode(void)
> >        * taking the highest cpu number to be the size of
> >        * the aggregation translate cpumap.
> >        */
> > -     nr = perf_cpu_map__max(evsel_list->core.user_cpus).cpu;
> > +     if (evsel_list->core.user_cpus)
> > +             nr = perf_cpu_map__max(evsel_list->core.user_cpus).cpu;
> > +     else
> > +             nr = 0;
> >       stat_config.cpus_aggr_map = cpu_aggr_map__empty_new(nr + 1);
> >       return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
> >  }
> > --
> > 2.35.1.1021.g381101b075-goog
>
> --
>
> - Arnaldo
