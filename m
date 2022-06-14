Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA3054B3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbiFNOxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbiFNOxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:53:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8073421E2A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:53:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so6356311wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Beybp5XJ8a3dHy7RTQ7s0JAdwjglxG9m7qsg7aTj7KU=;
        b=gqJqn6qGZ/TOsOaGxprWFd08BSsoSzW9yScic5r1RcJYQwXWr7It7UYmHtWnpGGEsb
         4+I9bQUv7NRJqAfGoFk+BxPBMGSiyRLmPE0Nv6yKJlTPhd+HzHDXAK5c4hI9fKnn61Qc
         bcbCUz+1Q21/oQguxzwwTFvww+VnHK6kwwW52Pu5c41tzBG8RTrMKHUjefM+qoQYT0YQ
         b/0lYYN/d/OAPLf9V/AdPheRlwK63EUpWHmeoEyvrRAw2xQOGsmhOb90Mnc/BJAY8aMa
         pgZu2HF+7nWTaM+EfE5hBKE8DuAcwFXkw6HNs00ojvk1tn821LZOl4UGAg64u5F3Uu1X
         o/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Beybp5XJ8a3dHy7RTQ7s0JAdwjglxG9m7qsg7aTj7KU=;
        b=sXyKLmSg9WhEBa9UjSY9kTQhLKyBT5a2kPIbA8cGi5TvGtXeW2iLgJlOPaEpSVBO4a
         KwFnpv0Z+oBEzxj9BNZvwzGWaYaYP+xBNNMx48jAJB86fX4oBlIhFXg8btrmUDFBcSLG
         +tpYufsxqIhhkNDggBz625fs6oUzbcotAM2o2Ejs2HKE+22rZFbEPVDsdyCSzoKTlFj0
         Qh+dZs7ci8W9vC+SGOvP0WcAZWXt75kVEWmkKwiQ7SmbF2honURC5e6JDIYNwhXYvgK5
         Iq/0f0vC1t/WS9Q8xbzVD0pI23+DXswR+g7daVyAIcf+OBzXkERhzpHQ+qk2dpkt3mD9
         7a1A==
X-Gm-Message-State: AOAM531bTyLv9VHMaG4sl8zLEbjWNGyULRCvZUoiFvwny0viyqSM0s4F
        k4lblKP+cdZwWKgWKgHFbMwisQQ6Q5kvZfaRLtfpag==
X-Google-Smtp-Source: ABdhPJywS2htEDLwBMWXZrrCy9+TllwAinrXt7Rfo/66rSD9A4VOt5bjRN7nbwUdEtwrycbTPh03CIlRqT7H7SMGJyQ=
X-Received: by 2002:a7b:c7da:0:b0:39c:5b34:3019 with SMTP id
 z26-20020a7bc7da000000b0039c5b343019mr4579162wmk.115.1655218393856; Tue, 14
 Jun 2022 07:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220610113316.6682-1-adrian.hunter@intel.com> <20220610113316.6682-4-adrian.hunter@intel.com>
In-Reply-To: <20220610113316.6682-4-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jun 2022 07:53:01 -0700
Message-ID: <CAP-5=fVWOeqZ+BePoe3Te1fCaru_O5u+E0Lah8pGvSOfLDQaWQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf record: Add new option to sample identifier
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
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

On Fri, Jun 10, 2022 at 4:33 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> In preparation for recording sideband events in a virtual machine guest so
> that they can be injected into a host perf.data file.
>
> Add an option to always include sample type PERF_SAMPLE_IDENTIFIER.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 3 +++
>  tools/perf/builtin-record.c              | 2 ++
>  tools/perf/util/record.c                 | 2 +-
>  tools/perf/util/record.h                 | 1 +
>  4 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index cf8ad50f3de1..8fcea74fe3c2 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -313,6 +313,9 @@ OPTIONS
>  --sample-cpu::
>         Record the sample cpu.
>
> +--sample-identifier::
> +       Record the sample identifier.

I can see this is following the pattern of --sample-cpu above, but I'm
not sure a "sample identifier" is going to be clear to a novice user.
The comment adds little beyond the option name. Perhaps expand with an
example?

Thanks,
Ian

> +
>  -n::
>  --no-samples::
>         Don't sample.
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 00c2a6cdf1be..40dca1fba4e3 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3191,6 +3191,8 @@ static struct option __record_options[] = {
>         OPT_BOOLEAN(0, "code-page-size", &record.opts.sample_code_page_size,
>                     "Record the sampled code address (ip) page size"),
>         OPT_BOOLEAN(0, "sample-cpu", &record.opts.sample_cpu, "Record the sample cpu"),
> +       OPT_BOOLEAN(0, "sample-identifier", &record.opts.sample_identifier,
> +                   "Record the sample identifier"),
>         OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
>                         &record.opts.sample_time_set,
>                         "Record the sample timestamps"),
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index 5b09ecbb05dc..b529636ab3ea 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -121,7 +121,7 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
>         evlist__for_each_entry(evlist, evsel)
>                 evsel__config_leader_sampling(evsel, evlist);
>
> -       if (opts->full_auxtrace) {
> +       if (opts->full_auxtrace || opts->sample_identifier) {
>                 /*
>                  * Need to be able to synthesize and parse selected events with
>                  * arbitrary sample types, which requires always being able to
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index be9a957501f4..4269e916f450 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -28,6 +28,7 @@ struct record_opts {
>         bool          sample_time;
>         bool          sample_time_set;
>         bool          sample_cpu;
> +       bool          sample_identifier;
>         bool          period;
>         bool          period_set;
>         bool          running_time;
> --
> 2.25.1
>
