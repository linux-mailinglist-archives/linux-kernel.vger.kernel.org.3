Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C28476034
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbhLOSFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:05:00 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:33716 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbhLOSE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:04:59 -0500
Received: by mail-lf1-f50.google.com with SMTP id d38so331179lfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/GYOqU5sUvHHNf2iUeDF6MRwtFZAxx9yZ3HDrblBPQ=;
        b=zXe4EA8pQXBv2zcU0y8RJXRdGdrgCdNixIQvlqzhf02u5wimH9+7vmQDmDIJpZi29U
         oobxgelO5U854z9ho+ZJ1HoeC8Zt+dxy5Xdf2So5v9wAayM2YQyZVBFOYdUJ3pZHS5WW
         MY9ACzRubtplSt3iSDu3ZIwhJxSSkZSqU7BRlgptsMYG7tdEtD4ca9m7zIV9N6nd8xpl
         AQdS/AE3Wcfz4NLKGzRjU1CVBBkN5c467XZOSr9yVaooh+WyxU+9zyCRdiUcrTVl9V07
         GLfOnHVXGNN77+p/ozqyTxiPWKuBWO1pjD6LAOS9lVGPJhpGx7HbVKhdNNtCBXHl/xD8
         JBtw==
X-Gm-Message-State: AOAM532kV0SLhH8yTQIAfozIjGnS7qYnN2r5sVgfzSrU2kA44FNY8zrL
        M4fxHg7pIa/Sl1wf0DqygQrp9J/FkI1JykooxBM=
X-Google-Smtp-Source: ABdhPJyW/vLdODlQ1W4a8S2qdvlpYqrMJOD/6cRvxUrzv+iaxqczfuzGJRzCQK1HgjrtYuz3fnMZmQiMntFblbjTzJs=
X-Received: by 2002:a05:6512:22c3:: with SMTP id g3mr11174012lfu.528.1639591498265;
 Wed, 15 Dec 2021 10:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20211215080636.149562-1-adrian.hunter@intel.com> <20211215080636.149562-2-adrian.hunter@intel.com>
In-Reply-To: <20211215080636.149562-2-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Dec 2021 10:04:47 -0800
Message-ID: <CAM9d7ciipw--44hKt3-K693L+0eFY_c=J=WKJ2N+NV+Yo2=-4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf intel-pt: Fix parsing of VM time correlation arguments
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Dec 15, 2021 at 12:07 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Parser did not take ':' into account.
>
> Example:
>
>  Before:
>
>   $ perf record -e intel_pt//u uname
>   Linux
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.026 MB perf.data ]
>   $ perf inject -i perf.data --vm-time-correlation="dry-run 123"
>   $ perf inject -i perf.data --vm-time-correlation="dry-run 123:456"
>   Failed to parse VM Time Correlation options
>   0x620 [0x98]: failed to process type: 70 [Invalid argument]
>   $
>
>  After:
>
>   $ perf inject -i perf.data --vm-time-correlation="dry-run 123:456"
>   $
>
> Fixes: e3ff42bdebcfe ("perf intel-pt: Parse VM Time Correlation options and set up decoding")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/intel-pt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 10c3187e4c5a..e8613cbda331 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3625,6 +3625,7 @@ static int intel_pt_parse_vm_tm_corr_arg(struct intel_pt *pt, char **args)
>                 *args = p;
>                 return 0;
>         }
> +       p += 1;
>         while (1) {
>                 vmcs = strtoull(p, &p, 0);
>                 if (errno)
> --
> 2.25.1
>
