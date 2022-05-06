Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7A51CDA4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387427AbiEFANu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiEFANo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:13:44 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685744FC51
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:10:03 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id e19so5711312vsu.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 17:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJ+SLgOYbrk33Dg8nsfPTJsmGxPqpaD9tEBJ44rZ4jw=;
        b=FbPAHd/cZf+oAk+bPlSFKG2psQnIN9Ga5SEkyA2zB9lXPbBREx+dtWxFkZOI9h2TDZ
         heGuPUQrTH9WBVp7W3t4F5sNVMJV2lnenWSpjafTIzoa+kZdcYAqkA5Jos7Q6raI5joR
         AzyY1okzWTfGXBYJeKuXZWHIadIPV1erisLPNhmhAS8gUU7Vag5k+OUEv80ey1b6SHZL
         j6/hulSkdu+HeCKpW3n1u8PDrstm/jPteQpYWz6UJqxsXiw58knckbmjJX2oqVx8SYJQ
         1aFmHX5/QqwnrxGGbqR/iZgfrlFx5LDK1gvpqytNaC96z1PPn2kNe9jY3pzVxP5+HyBi
         FsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJ+SLgOYbrk33Dg8nsfPTJsmGxPqpaD9tEBJ44rZ4jw=;
        b=iGWdnGG/ApxwxN8vclhv6sdDQlDfg1g9wMQSQaj7wDPj3WhXg5lGN+DhNNBGVUWaCD
         r7lIpj9BuiXSU0W064/N36OSpvKdtWqVYKzDOJQg8i+Ude4c7WTszZQcqCE55/9t7Qkv
         C7v5hswdwGQpli917S/WhpeAiTh8DS+1DkHaFgtWVuvcPKJZlUIP8RpNA30qINwoi66m
         n8zYDd+c2JCiOgn92DCOgSmDzLqZLHZoAi/xhVuhQlWxlWMlGEn4egnVQnfs4ZMskYDd
         Tq3voaefbqc0REl/1VhEXk8Vy4LlEABUBU2nZdNBZBYP3gcUc0vInu7DyOAzNxrn0Yz9
         NAKQ==
X-Gm-Message-State: AOAM533rwdjQs/hn/WpapQCptMVb8Ty/UxrVu90xnuXqC56F00sbQ8WF
        gPf4FGr/sTkhtwlkgc+z7pL8iVlVCIp4RQhPlJgcW0uz8+TsJg==
X-Google-Smtp-Source: ABdhPJztSde5JBbjcISPX1oFD0cbFRYTyNx96VYRc3OFukDxOLeFQBxalmiknIIMpuq3aidN7pUx3K/GN5wtbZugy9o=
X-Received: by 2002:a67:af01:0:b0:32d:3d57:cff with SMTP id
 v1-20020a67af01000000b0032d3d570cffmr201532vsl.8.1651795802384; Thu, 05 May
 2022 17:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-19-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-19-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 17:09:49 -0700
Message-ID: <CAP-5=fWFMNPjrKJMC8EH4_D=bcT8JHWqrVaaM4v0c51dpypfJw@mail.gmail.com>
Subject: Re: [PATCH V1 18/23] libperf evlist: Allow mixing per-thread and
 per-cpu mmaps
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
> mmap_per_evsel() will skip events that do not match the CPU, so all CPUs
> can be iterated in any case.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/perf/evlist.c | 36 +++++++-----------------------------
>  1 file changed, 7 insertions(+), 29 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 048b546f9444..0acf43946479 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -508,29 +508,6 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>         return 0;
>  }
>
> -static int
> -mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
> -               struct perf_mmap_param *mp)
> -{
> -       int thread;
> -       int nr_threads = perf_thread_map__nr(evlist->threads);
> -
> -       for (thread = 0; thread < nr_threads; thread++) {
> -               int output = -1;
> -               int output_overwrite = -1;
> -
> -               if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
> -                                  &output, &output_overwrite))
> -                       goto out_unmap;
> -       }
> -
> -       return 0;
> -
> -out_unmap:
> -       perf_evlist__munmap(evlist);
> -       return -1;
> -}
> -
>  static int
>  mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>              struct perf_mmap_param *mp)
> @@ -561,9 +538,14 @@ static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
>  {
>         int nr_mmaps;
>
> +       /* One for each CPU */
>         nr_mmaps = perf_cpu_map__nr(evlist->all_cpus);
> -       if (perf_cpu_map__empty(evlist->all_cpus))
> -               nr_mmaps = perf_thread_map__nr(evlist->threads);
> +       if (perf_cpu_map__empty(evlist->all_cpus)) {

Here with the current definition of perf_cpu_map__empty this is a NULL
or first element is any CPU (aka dummy) test. Given our conversation
this may not work as intended for that definition.

> +               /* Plus one for each thread */
> +               nr_mmaps += perf_thread_map__nr(evlist->threads);
> +               /* Minus the per-thread CPU (-1) */
> +               nr_mmaps -= 1;
> +       }
>
>         return nr_mmaps;
>  }
> @@ -573,7 +555,6 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>                           struct perf_mmap_param *mp)
>  {
>         struct perf_evsel *evsel;
> -       const struct perf_cpu_map *cpus = evlist->all_cpus;
>
>         if (!ops || !ops->get || !ops->mmap)
>                 return -EINVAL;
> @@ -592,9 +573,6 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>         if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
>                 return -ENOMEM;
>
> -       if (perf_cpu_map__empty(cpus))
> -               return mmap_per_thread(evlist, ops, mp);
> -
>         return mmap_per_cpu(evlist, ops, mp);
>  }
>
> --
> 2.25.1
>
