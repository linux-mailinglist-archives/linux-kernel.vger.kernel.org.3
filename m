Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82072518A50
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbiECQtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbiECQtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:49:19 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8F130F60
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:45:46 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id z144so16979509vsz.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEhaO2VPQGWGGw5hqYFADWCcKvr48MqA446UlAU+u6w=;
        b=ihBy0nfgFvQDwq0V/txi6ueM4+pRCxeyNKqD1ZGtCvH67DXsAtw210EzAfGrof3gFw
         anFjAp4RnT8H4m08ykPMTJc2epSwi0cWgJm9nBcen3B9Z+KOh02kaIvt9Tq5GDDj6zeE
         DdJXRhawHB7zzEO4+oVd397TkpjUzQYaF1ZDJ1eCvYobjkJznud1el91ow29OySch1iV
         RnEEHL7yBhnFQQFyhJmrYXy5a3zTVrrZbq0uSgn065RwNw0xM4lpIhdcgGRjmfHF6atB
         eVnXYbc/2MxonRzPkj9dVOW2k4p297ysSK2FpWGAKClXx9b5oaLdQAfu4T2udzzPKe54
         nMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEhaO2VPQGWGGw5hqYFADWCcKvr48MqA446UlAU+u6w=;
        b=8G8KwPdCIEzv7u3hC2asDNFAv5qj6KqKD6b+zaNyOg+D3gc3hJrjIzHZi1qy8KAc71
         qiAoPKzfg+z2oNH0H9dhJc/F0tyxlDTvrE5XlgbEm1iGhVScA2hfQdEqgJrkP8o0U+jd
         irGj2xFuLv2xlKKzI5uIEOx37Em/uXf34uchNzIql8rgzGoM+FZTNGJb5K7VnmL2W2+2
         YiCWI8zTNbh1pCuR5hKkAs0rLe9NnDYKPVMmR/yeEMH9jDctHlgWj8gml0eBD5bowl89
         TU9aRRmebxPVRPK0+tjTUTPU21IUt41EF7QsKeGo3wI32a35sgS3YW/gOwOKQA/Ta0Py
         Y2DA==
X-Gm-Message-State: AOAM533YckgV3xnBQvpJkhZVdvidqLohf9gdOxiQ8m+3oWeuWxOvATe1
        IBSSOjh775lhtfOfEl5X2TEqJvzdATmDXxMRokb8sZ0TeoT1u1ZN
X-Google-Smtp-Source: ABdhPJxOoxJmJG8LzxWmoJNOJsNmzcTFnjlgtb69g6tB1S0/7oqHricRjcACgGeSnyOKjEz3INsZGKVBW2fi841XSL8=
X-Received: by 2002:a67:af01:0:b0:32d:3d57:cff with SMTP id
 v1-20020a67af01000000b0032d3d570cffmr3398577vsl.8.1651596345258; Tue, 03 May
 2022 09:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220422162402.147958-1-adrian.hunter@intel.com> <20220422162402.147958-3-adrian.hunter@intel.com>
In-Reply-To: <20220422162402.147958-3-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 3 May 2022 09:45:33 -0700
Message-ID: <CAP-5=fU-FiHWZKaV-1qEXyE23TRVmZTZ2gXLE7KMS=B7VZ=aOw@mail.gmail.com>
Subject: Re: [PATCH RFC 02/21] libperf evsel: Add perf_evsel__enable_thread()
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

On Fri, Apr 22, 2022 at 9:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add perf_evsel__enable_thread() as a counterpart to
> perf_evsel__enable_cpu(), to enable all events for a thread.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/evsel.c              | 10 ++++++++++
>  tools/lib/perf/include/perf/evsel.h |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 20ae9f5f8b30..2a1f07f877be 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -360,6 +360,16 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
>         return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
>  }
>
> +int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
> +{
> +       int err = 0;
> +       int i;
> +
> +       for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> +               err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i, thread);

Looking at the argument names to perf_evsel__ioctl, i is the
cpu_map_idx. Would it be more intention revealing here to do:

perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
   if (err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, idx, thread))
     break;
}

or perhaps:

for (idx = 0; idx < perf_cpu_map__nr(evsel->fd) && !err; idx++)

Thanks,
Ian

> +       return err;
> +}
> +
>  int perf_evsel__enable(struct perf_evsel *evsel)
>  {
>         int i;
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index 2a9516b42d15..699c0ed97d34 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -36,6 +36,7 @@ LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int
>                                  struct perf_counts_values *count);
>  LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
> +LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
>  LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
>  LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
> --
> 2.25.1
>
