Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29E5000FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbiDMVQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbiDMVPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:15:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E74688B06
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:11:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r13so4353930wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVlwaZ4r8ijIp+ov3AzcuVTp5XRIpxTrDG+Zd3PV7JM=;
        b=ZRHlFVvi16U6+yoBP5GHkYV2aQKBX4ciYTOKAMEoFO75CALi3MqoTMV8h6fSxQKRNM
         YC6VFCSW+GKiOF5Dmmcl6Qhh7VsAkX7acmwzgZMehKZLruEuuPO2iQLM5GGV2h5Q7Swn
         gOO88lMpu1w3LoncZ9Xs7yZ+iidJDMS9dvxhdXcTMyGC9AhXAg1a+p9ZJgcEPf4hHHNG
         lDhzc2wZYgCqhLsY76otluWbqUVrtoT0EyC/z16Z9nV+rcrae0mi+dCXk20qv7PG67dL
         sHHRZCZkAlaLGn3o5fNE6U60EuDzPr0F/3qNMVwVUikySR+0rV0yQE0EhFyhFvsdX7AS
         pEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVlwaZ4r8ijIp+ov3AzcuVTp5XRIpxTrDG+Zd3PV7JM=;
        b=JAU2bJPf3NbQF2HefcI+0L60peSYti+7xTNc71wzlg8MU3U9KFetyXnNsPO/cK9lBC
         1FQXbCt987nHV3SHEZ1G3iJyDQJeGGKdLEl4uqAsgygzwZzEO5sGlaUrZE0oHX9Rp95M
         mWmw/9pqVzrUEvaD50BGLurhMEBTJK8WtWI7NIQmUc7LJuwCqsA0L+GOmpl1whXH6lIm
         iX7irzAg0qckFkJfDjg+Yaq9wz6TlSzFqRf2OhTHL11T9tUnjTFTRAmU9UA7Aj08VPHX
         VGGAuTAzWtuRld1MAz4gkzCsbYUFieiPHckThZVDEuyjqHKbqd4tIunCTWuhwoCn24df
         V3QQ==
X-Gm-Message-State: AOAM5317OqbJEJs7/s9q5xEH3ILt6BbVZlVS73y2Lxrk/jfWlQb6lEj9
        AxrXeY6riPxCCl46wKTMSM7gDhD5J3iyVaGL4XdkrsyvbIaRTw==
X-Google-Smtp-Source: ABdhPJyMrFJ4QQ7As5Vq4HgSlcuor/51e+7VQC8fiSYCu07wYxr2Xjxc8+aZOUf97xSkkMHgHgaR763dH2PIlomrU3s=
X-Received: by 2002:adf:eb09:0:b0:207:bb77:9abb with SMTP id
 s9-20020adfeb09000000b00207bb779abbmr487388wrn.375.1649884313810; Wed, 13 Apr
 2022 14:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220413114232.26914-1-adrian.hunter@intel.com>
In-Reply-To: <20220413114232.26914-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 Apr 2022 14:11:41 -0700
Message-ID: <CAP-5=fUWHb=fSVQmURbxqOO=DvhjeczzJpuXbR2ebtEsmhf7TQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix segfault accessing sample_id xyarray
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
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

On Wed, Apr 13, 2022 at 4:42 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> perf_evsel sample_id is an xyarray which can cause a segfault when
> accessed beyond its size. e.g.
>
>  # perf record -e intel_pt// -C 1 sleep 1
>  Segmentation fault (core dumped)
>
> That is happening because a dummy event is opened to capture text poke
> events accoss all CPUs, however the mmap logic is allocating according
> to the number of user_requested_cpus.

Nit: typo on 'accoss'

> In general, perf sometimes uses the evsel cpus to open events, and
> sometimes the evlist user_requested_cpus. However, it is not necessary
> to determine which case is which because the opened event file
> descriptors are also in an xyarray, the size of whch can be used
> to correctly allocate the size of the sample_id xyarray, because there
> is one ID per file descriptor. Note, in the affected code path,
> perf_evsel fd array is subsequently used to get the file descriptor for
> the mmap, so it makes sense for the xyarrays to be the same size there.
>
> Fixes: 246eba8e9041c4 ("perf tools: Add support for PERF_RECORD_TEXT_POKE")
> Fixes: d1a177595b3a82 ("libperf: Adopt perf_evlist__mmap()/munmap() from tools/perf")
> Cc: stable@vger.kernel.org # 5.5+
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/perf/evlist.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 1b15ba13c477..a09315538a30 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -577,7 +577,6 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>  {
>         struct perf_evsel *evsel;
>         const struct perf_cpu_map *cpus = evlist->user_requested_cpus;
> -       const struct perf_thread_map *threads = evlist->threads;
>
>         if (!ops || !ops->get || !ops->mmap)
>                 return -EINVAL;
> @@ -589,7 +588,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>         perf_evlist__for_each_entry(evlist, evsel) {
>                 if ((evsel->attr.read_format & PERF_FORMAT_ID) &&
>                     evsel->sample_id == NULL &&
> -                   perf_evsel__alloc_id(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
> +                   perf_evsel__alloc_id(evsel, evsel->fd->max_x, evsel->fd->max_y) < 0)
>                         return -ENOMEM;
>         }
>
> --
> 2.25.1
>
