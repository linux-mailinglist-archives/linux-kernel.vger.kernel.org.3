Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FED518ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiECUdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiECUdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:33:07 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E775C32ED9
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:29:32 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id y32so32216846lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxrFWVN5VsHJB/otfl+bIpmkStn6Z3bAIZsPOXat8VI=;
        b=xotO3VRzHxwRoLrR8eTIFe1zwKAoDAmkEYfk+ywPQIbv80SbFtEsRclJWLP7tq3uE1
         ZC7eNrwyf3RhLgvYCMi8FPExIDKdK0RLM+mYveTotljlk27hQGZyAsBY/MGKRAAicES0
         GEFXLVg/OQ1Q85+d/axCM4cp4OJss7MsM7CEkWFhaNc9afqJwbPynkmviWQE2iwCN9/H
         Sy0th97QYit0850LmGrrE907UZndMLhOhsY+cH5TGkGDbDjRAm+S1R8ysPUmwxYnPRHB
         xZ6V/u+fJUxQO4VbQ54SYOV7/55MUDjCXT4PhqpB3Xq6wgnKvjKv89hjyIOdbMnRj4VX
         DhKg==
X-Gm-Message-State: AOAM5327t2PvRCldBp+PdpEsi0fdDza9M1KYsjpwxTa1ePx+vHsPJsX5
        ikYhV/R3dgLRk0fOEoP1vPJUGf5AFSuv6RAyv1c=
X-Google-Smtp-Source: ABdhPJzPENNrN4xPEOez8EviAj1u8aHC+cv8rZhQYLdkA/hXETuwFQUtk6xHFjs74JJKyw0hbR/tZAeW+twtdNHmpIk=
X-Received: by 2002:a05:6512:39d3:b0:472:4920:96d7 with SMTP id
 k19-20020a05651239d300b00472492096d7mr12715203lfu.47.1651609771069; Tue, 03
 May 2022 13:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220422162402.147958-1-adrian.hunter@intel.com> <20220422162402.147958-19-adrian.hunter@intel.com>
In-Reply-To: <20220422162402.147958-19-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 3 May 2022 13:29:20 -0700
Message-ID: <CAM9d7chPX314n6c_V+3c0HF1OKNSL3zS-s3L78oH39Ds7cSpEg@mail.gmail.com>
Subject: Re: [PATCH RFC 18/21] libperf evlist: Allow mixing per-thread and
 per-cpu mmaps
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:25 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> mmap_per_evsel() will skip events that do not match the CPU, so all CPUs
> can be iterated in any case.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
[...]
> @@ -561,9 +538,12 @@ static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
>  {
>         int nr_mmaps;
>
> +       /* One for each CPU */
>         nr_mmaps = perf_cpu_map__nr(evlist->all_cpus);
> -       if (perf_cpu_map__empty(evlist->all_cpus))
> -               nr_mmaps = perf_thread_map__nr(evlist->threads);
> +       /* One for each thread */
> +       nr_mmaps += perf_thread_map__nr(evlist->threads);
> +       /* Minus the dummy CPU or dummy thread */
> +       nr_mmaps -= 1;

I'm not sure it'd work for per-task events with default-per-cpu mode.

Thanks,
Namhyung

>
>         return nr_mmaps;
>  }
