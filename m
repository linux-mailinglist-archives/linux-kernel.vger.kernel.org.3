Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AC851CD59
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbiEFAGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387343AbiEFAGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:06:39 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F035160DBD
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:02:03 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id w124so5711173vsb.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 17:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hCrMtZQXFwUd0ScHZjSqlL/WfdVN1+eLkWphb//TkgU=;
        b=cttb9X7VtWEHQNy+Ju8l9ps6/eUjlBkSSNbb16kRgDvgGYbBfUbtVWaKa0D2LZ8ldP
         Ow+4szKAp93+mrneoLvO2HbYT2t5jzLG74pxPtmAQwr7mARSIfuqnGoCB+d7DWfLFpYF
         rihRdpGvbAwDmeUs/JH9XnKWHRLUdUEqMPbKOp5rG1hxNGK+ncvDbIZwyLANU0qCore5
         oz8cpZRHal5IW8x+KUexmHvp4+tzY381YTwtXb7z1JcUt9ke4AXn1gk/5GAeKGVc1ew4
         Vvr9AZZw8b2Ml6EpIXOrMe6XXSynkJa0XmX7iaI0BPu74EGKaOKv7xbxtKYkSirR3j0q
         asEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hCrMtZQXFwUd0ScHZjSqlL/WfdVN1+eLkWphb//TkgU=;
        b=Dq3hAMgGfm6vq8nCm18g1i4RVqP7LfgvViilAmb+cW2ksXOEVwYD4qhCd9wTIxdvcu
         /xt7mFapZW9120L3enwpcCpiHpDTqWKevQLQtbkpbW/f2/XC/YbDEO7BGgoqhQmDvbXb
         Ga1K/OARpBchWtuwZJjb1Zacu8Nnyu6Ys7WJBiEv7SzydZ0tTpCTlc5YuWhPgiX866ih
         cGkcbb7IKch1iaM8MfZCtwQP3UiJJ5zVqbJa2nAjSZAEBpZWyDf+SUXwnQxJn1scxrBi
         Qaz/6imeF4vnVDqwz4eoMp3f/HXeB62dGrGi/kFrnTaqXvHDQR+CG2nxhjH06GX++L9o
         abBA==
X-Gm-Message-State: AOAM533RrJxKVMzgszzi52IUV/t0OfWaxFMM43SMBLeuAMTkeFofcC5z
        cPqYRwXR7I8rI3/Zisl6+7TNxkI/mH6N9YOljpcHcQ==
X-Google-Smtp-Source: ABdhPJxky9QDgXdC5BAL6wW3bTSheDLKc+JA4sUbvkhOVX9ZUtrGTY770f/kjy4dbZRhbhjaXKQN/xkJMfHm67liizY=
X-Received: by 2002:a67:af01:0:b0:32d:3d57:cff with SMTP id
 v1-20020a67af01000000b0032d3d570cffmr191603vsl.8.1651795322934; Thu, 05 May
 2022 17:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-17-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-17-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 17:01:50 -0700
Message-ID: <CAP-5=fW-EYfy2Avdsopgp7BkCV-COYQJuP7=ZaPcfqa+wj37dQ@mail.gmail.com>
Subject: Re: [PATCH V1 16/23] perf intel-pt: Track sideband system-wide when needed
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
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

On Thu, May 5, 2022 at 9:58 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> User space tasks can migrate between CPUs, so when tracing selected CPUs,
> sideband for all CPUs is still needed. This is in preparation for allowing
> system-wide events on all CPUs while the user requested events are on only
> user requested CPUs.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/arch/x86/util/intel-pt.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index e45d64dec57c..62be78bc90b6 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -864,20 +864,22 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>
>         /* Add dummy event to keep tracking */
>         if (opts->full_auxtrace) {
> +               bool need_system_wide_tracking;

Nit: perhaps need_dummy_on_all_online_cpus

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>                 struct evsel *tracking_evsel;
>
> -               err = parse_events(evlist, "dummy:u", NULL);
> -               if (err)
> -                       return err;
> +               /*
> +                * User space tasks can migrate between CPUs, so when tracing
> +                * selected CPUs, sideband for all CPUs is still needed.
> +                */
> +               need_system_wide_tracking = evlist->core.has_user_cpus &&
> +                                           !intel_pt_evsel->core.attr.exclude_user;
>
> -               tracking_evsel = evlist__last(evlist);
> +               tracking_evsel = evlist__add_aux_dummy(evlist, need_system_wide_tracking);
> +               if (!tracking_evsel)
> +                       return -ENOMEM;
>
>                 evlist__set_tracking_event(evlist, tracking_evsel);
>
> -               tracking_evsel->core.attr.freq = 0;
> -               tracking_evsel->core.attr.sample_period = 1;
> -
> -               tracking_evsel->no_aux_samples = true;
>                 if (need_immediate)
>                         tracking_evsel->immediate = true;
>
> --
> 2.25.1
>
