Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE35244DE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349916AbiELF1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbiELF1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:27:30 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9112AC66
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:27:29 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-edf9ddb312so5395495fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRed4Ua1ssQYxyS7Mzv2BArMr79XrNwtR3ccNj/A1Qg=;
        b=eW0ORiEATXBVnYPhzzYimyatPzH7yu5UThTztMSopmykSGOP7hepVVgSAquNtKnYBt
         bCUSWuqcf+rELuE14/AGyat/LuO67H70lSWUVGaHCtY5KrDL6WVuzNDqSoHgIy8Yp5ix
         lOWCunEe2x1+41rpZcZJZdfS+KNjkeyFXpSsxlZd0Bfje3GqjXTjmfMdop3z67YimAvm
         57Ft7M3caC5WxjG8UibRugQlV7SbLe1KsFRz42fQMiCf/9Tp8KVFbcL+i5L4fxwkmVjQ
         SR3URN+JCAJavorCAz2IfU+l0d7N9xaO6lU030FZOCW1E54KoBRCUkWZRBh1oaNJpEKg
         Emfw==
X-Gm-Message-State: AOAM530NbSJ8uQL6pCunSZPmPlagTlv2JtgZqDmAgkG0QuDassxQ46EL
        0FmPVG3OgKFqMEn2+P1lEjMn/ehW3CKa8UQyqDIxYmqZ4G4=
X-Google-Smtp-Source: ABdhPJxAdy0ZUI361OME4bJvmTmpLq1agN3+XtFItK3IbEd+BIRZkEe4sLwa2ygVaL6vlLUwpDF+TKsUwK+sSke2yzA=
X-Received: by 2002:a05:6870:1705:b0:ed:9fe0:5ef8 with SMTP id
 h5-20020a056870170500b000ed9fe05ef8mr4705508oae.92.1652333248388; Wed, 11 May
 2022 22:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com> <20220506122601.367589-23-adrian.hunter@intel.com>
In-Reply-To: <20220506122601.367589-23-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 11 May 2022 22:27:17 -0700
Message-ID: <CAM9d7cg8JRK2oVUvmWit=F5zhLhpqP=gD6iYBAa8_O-+c=EjPQ@mail.gmail.com>
Subject: Re: [PATCH V2 22/23] perf tools: Allow system-wide events to keep
 their own CPUs
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 5:27 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Currently, user_requested_cpus supplants system-wide CPUs when the evlist
> has_user_cpus. Change that so that system-wide events retain their own
> CPUs and they are added to all_cpus.
>
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/evlist.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 1c801f8da44f..9a6801b53274 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -40,12 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>          * We already have cpus for evsel (via PMU sysfs) so
>          * keep it, if there's no target cpu list defined.
>          */
> -       if (!evsel->own_cpus || evlist->has_user_cpus) {
> -               perf_cpu_map__put(evsel->cpus);
> -               evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> -       } else if (!evsel->system_wide &&
> -                  !evsel->requires_cpu &&
> -                  perf_cpu_map__empty(evlist->user_requested_cpus)) {
> +       if (!evsel->own_cpus ||
> +           (!evsel->system_wide && evlist->has_user_cpus) ||
> +           (!evsel->system_wide &&
> +            !evsel->requires_cpu &&
> +            perf_cpu_map__empty(evlist->user_requested_cpus))) {

This is getting hard to understand.  IIUC this propagation basically
sets user requested cpus to evsel unless it has its own cpus, right?

But the hybrid pmus make this complex.  Maybe we can move the
logic in evlist__fix_hybrid_cpus() here and simplify it like below

if (evsel->own_cpus) {
   if (evsel->pmu->is_hybrid)
      evsel->cpus = fixup_hybrid_cpus(evsel>own_cpus,
                                      evlist->user_requested_cpus);  //?
   else
      evsel->cpus = evlist->own_cpus;  // put + get
} else {
   evsel->cpus = evlist->user_requested_cpus;  // put + get
}

Then we need to make sure evsel->pmu is set properly.

What do you think?

Thanks,
Namhyung


>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>         } else if (evsel->cpus != evsel->own_cpus) {
> --
> 2.25.1
>
