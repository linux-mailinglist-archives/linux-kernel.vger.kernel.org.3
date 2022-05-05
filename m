Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0451CCBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386771AbiEEXbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354447AbiEEXbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:31:45 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D763606C4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:28:04 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id y74so5651273vsy.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhQflZE2kOz5iQfI0XCphcVBDGFV9bgpYklPf0EzaxU=;
        b=lCuDggdgmHDg+vHogr+Me/hfOr3FKfk8M0OI07+q0NM8dFU3EyeDHQvOgwkMAhav6Y
         cvA9lFGbZ+kMu2qsDbZ3u4I9UfC6IqXFgi7e+kV4oPGHnByYml/EyL2l8RJdUkHVRM8Z
         5pl61o/3BCKiBv52aQ07Ppnh+j1a2fNgLMxiPpdsuQbLW07chLLlt4eTIRDac9EfsOxc
         hsSiryCWUhqsIxFZZgU0HWeqc321MsvyQuwXECyX0rJOqIDgS3JY18vvCGVlj6t57mxf
         TwkCprjB6r0G9MKrZoO+Y8L6w71ZTExlRsHqZZjlwfkO5WmDrDlIsPQYgqC4wyNG1uFQ
         BkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhQflZE2kOz5iQfI0XCphcVBDGFV9bgpYklPf0EzaxU=;
        b=05Ku8FBIqqN//gQGIzgxBI5PUvg+N8delQVwyk63kVkD1synoz7mCpsKrJe8V3N+w4
         7zCydU2up9Xwf0/HvkxvojTOTZkAshA+W+uZ1OLbu9YBORphUhB3XnNTXbrNnR54c/wB
         3DmKgi0yJJ0ETRGkX6edMtbQ0jMbbnPOUCtRc5o+1dFbv2czmGFDXFHW2bZ/+BOxb+y8
         uncbAVQxiIYJc+q9oMx1QcK4Izdlgy06QPEFy+UzAvYIponASGtj7Lf7NS9+4RkiZEfj
         JWJ52OeaKUMHMTzhIo5vLqiOhN/lu3Xrzn3YJIo4Dj5SAv43JMer3bWfc7q19vMPE3PM
         UzFQ==
X-Gm-Message-State: AOAM530i/0OEJv7tfpiIHK5z2idR81K0P49hwL4cnQNrry9AkrN7QzC5
        N7rusHZB+I08tfOgDjSXcfYGl+R19GupacItUaEkaw==
X-Google-Smtp-Source: ABdhPJymhSRWTgUPQ4NYhHFHHhmwSkdehHtlSphdiOGWDNnaXVkjFhwqLIKzUuKMVuYKsonNBC+ZJe8UyV6YGYq7jVM=
X-Received: by 2002:a05:6102:2929:b0:32d:6662:72e2 with SMTP id
 cz41-20020a056102292900b0032d666272e2mr151259vsb.56.1651793283117; Thu, 05
 May 2022 16:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-9-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-9-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 16:27:50 -0700
Message-ID: <CAP-5=fVbRGw15=XzpLqZEvZM9hh0PwXemqXvNZcWxSH7N2Kscw@mail.gmail.com>
Subject: Re: [PATCH V1 08/23] libperf evlist: Add evsel as a parameter to ->idx()
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
> Add evsel as a parameter to ->idx() in preparation for correctly
> determining whether an auxtrace mmap is needed.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Just to note that in the non-lib version of evsel there is a back link
to the evlist. If we ever had that in the lib version then there'd be
no need to pass the evsel and evlist.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/perf/evlist.c                  | 2 +-
>  tools/lib/perf/include/internal/evlist.h | 3 ++-
>  tools/perf/util/evlist.c                 | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 673c267f900e..ad04da81c367 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -475,7 +475,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>                         refcount_set(&map->refcnt, 2);
>
>                         if (ops->idx)
> -                               ops->idx(evlist, mp, idx);
> +                               ops->idx(evlist, evsel, mp, idx);
>
>                         if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
>                                 return -1;
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index 0d5c830431a7..6f89aec3e608 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -38,7 +38,8 @@ struct perf_evlist {
>  };
>
>  typedef void
> -(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int);
> +(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_evsel*,
> +                             struct perf_mmap_param*, int);
>  typedef struct perf_mmap*
>  (*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
>  typedef int
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 09a1d3400fd9..7ae56b062f44 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -747,6 +747,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
>
>  static void
>  perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
> +                        struct perf_evsel *_evsel __maybe_unused,
>                          struct perf_mmap_param *_mp,
>                          int idx)
>  {
> --
> 2.25.1
>
