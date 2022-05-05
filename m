Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968E851CD4E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387339AbiEFAE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387405AbiEFAEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:04:05 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD51B6211A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:58:15 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id q2so5707174vsr.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpFb8Gr9xZ6jtouMT2pIJ7gZ1NMprA13sbW1RG6i+Wg=;
        b=Ps+rIUYLYUPJvA6Yg44wWsGTb/ZneBk5T1XItoYqyMXKzR0WwJzT2XDsDmARtKJsvD
         sEYu0O2gX3m214u9nEzy94AQHVNtKG8kFTbRiy5STtFTEI/X7wmxR54aS+IMLIJIDCIR
         BAfp+/lvZLUUU1zyDIxtOuyU+X7GezTZt0VnF48/7LtOLK9Qby3Cf2AkJS9KHZjLcq1V
         xiICyEJnJtvQdes8ZyLL1btDbq8kHANsqo1Kx0gr3yn6lbKVIvnMBE7q0MNa6PfXMTwY
         AnVQaRhenTOq/CdpS/Z7tSgjJsWP4U5jy+cWg0i0ELOgqDqOYeoYtziIxa+uaXGM2AfO
         93Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpFb8Gr9xZ6jtouMT2pIJ7gZ1NMprA13sbW1RG6i+Wg=;
        b=ZSia/cQ7IJdf2x3HKOe/3ONk+EZvg14l4scPVc2zQkGpYnQrggOc+epuoy/4TjPsll
         6cdViutsJEDQRkfkRGT1DWuda0mTUwyN8VjEYj9HTK3CletZZlVFh3F5Y6HjXUDaF65I
         rW2eUi1OCg0leLdV1P6fztFkbcSYVVMymqldqagL8in6hETys73W4fKl61LleYUsDjx3
         IEOtSnEW/9Lp/30iLtfK1ZVQZIVeL3zalbBqqSniqiuf1PYaE/f+Y1Cm9chXe0xoE6qu
         LcUkiWeqNkgy9eKPJYXGgujCefCp3P/lM44GgFo3a8I43nT/u9sniLhDP0pWNnT15l6p
         W9Zw==
X-Gm-Message-State: AOAM5321D+DVsigAKTkkq3+wBsgQNEOwvtTDMzn+/vFbm4cJYnuMcLf2
        3m2TdicbIjrKpf5VV6lY6Rhltghsw9YPLnnpdlV/iQ==
X-Google-Smtp-Source: ABdhPJy/tT6+x03aPIFdLdYs3mGfRN/yfZRJaHhq2DvGL46xgDbUPrQx8Om0d8YpJPkxU/n7+hGO7hKKSOAhQkbJ3Qs=
X-Received: by 2002:a67:cf49:0:b0:32d:1bea:c7b8 with SMTP id
 f9-20020a67cf49000000b0032d1beac7b8mr184051vsm.39.1651795094696; Thu, 05 May
 2022 16:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-16-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-16-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 16:58:02 -0700
Message-ID: <CAP-5=fUmXU7smPbGvK8Q1RxfZ-7C+WbUK_Xa9yz3WgQdk9YdPw@mail.gmail.com>
Subject: Re: [PATCH V1 15/23] perf intel-pt: Use evlist__add_system_wide_dummy()
 for switch tracking
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

On Thu, May 5, 2022 at 9:57 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Use evlist__add_system_wide_dummy() for switch tracking in preparation for
> allowing system-wide events on all CPUs while the user requested events are
> on only user requested CPUs.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Delta function names.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/intel-pt.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 2eaac4638aab..e45d64dec57c 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -811,18 +811,11 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>                         if (!cpu_wide && perf_can_record_cpu_wide()) {
>                                 struct evsel *switch_evsel;
>
> -                               err = parse_events(evlist, "dummy:u", NULL);
> -                               if (err)
> -                                       return err;
> +                               switch_evsel = evlist__add_system_wide_dummy(evlist);
> +                               if (!switch_evsel)
> +                                       return -ENOMEM;
>
> -                               switch_evsel = evlist__last(evlist);
> -
> -                               switch_evsel->core.attr.freq = 0;
> -                               switch_evsel->core.attr.sample_period = 1;
>                                 switch_evsel->core.attr.context_switch = 1;
> -
> -                               switch_evsel->core.system_wide = true;
> -                               switch_evsel->no_aux_samples = true;
>                                 switch_evsel->immediate = true;
>
>                                 evsel__set_sample_bit(switch_evsel, TID);
> --
> 2.25.1
>
