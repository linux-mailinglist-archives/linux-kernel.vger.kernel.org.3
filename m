Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6A154BD50
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355936AbiFNWIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358464AbiFNWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:08:27 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3294EDEC;
        Tue, 14 Jun 2022 15:08:26 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-fe4ac3b87fso14319370fac.3;
        Tue, 14 Jun 2022 15:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uL+pfJik+rRQSzc9i4k7KVHHfK2XbB8mJChZyZzr7dg=;
        b=HYQeEdIOv0BAeqhZeFoYdjszgmt2IE42IC/1gm1qQoCEY/px33MW0QAb/KU5JGAhjt
         x7rUiUZTJjI+Y/X70uS+Neu/VZyBI7y6DrASxieeGquMu/W7vqWBcR57ANEO4Xlczl2o
         bYSsA4WNWuQFy6AltI/pVzkjofi4GihqzZbyqPdiQCQxdkHPKBOrgYl+Qj5rcqR467PW
         2XZOPcvOQlUjxZDwvSOem6vIvldJOTKsr9A+Ox59QWS/0WoefZfOHGFHQMLKGw+3PURo
         MJCkXLbduPWIzBOFhv5SzyDoQJSRLWNkLN7bmsOJ4y0zRnqYXZvWCcLypcRa2WYsF1JS
         u1Fw==
X-Gm-Message-State: AJIora9ssO30nTs3rcOHDXIDVR8/YTWwB5deiw1K8FShkLcZTsavfyax
        JVaVUx1i287DBuFf+VXiM3tvVo6wlxXv5IlG7f0=
X-Google-Smtp-Source: AGRyM1uTl5swnr44HgvS3WnCGGSBkcYZyGp2KxlIhOgybf9f+SSY/eyv4iYT3URmqg8eMxOPoSae0XBP+EYvB9ug+Qo=
X-Received: by 2002:a05:6870:4585:b0:fb:5105:76b8 with SMTP id
 y5-20020a056870458500b000fb510576b8mr3555860oao.92.1655244506189; Tue, 14 Jun
 2022 15:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220614103751.1395645-1-yajun.deng@linux.dev>
In-Reply-To: <20220614103751.1395645-1-yajun.deng@linux.dev>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Jun 2022 15:08:15 -0700
Message-ID: <CAM9d7cj4=3DNz=kKhVbx0uKYwbbaQF6ZdjkezKPdT67j8rcEMg@mail.gmail.com>
Subject: Re: [PATCH] perf/core: fix perf_event_mux_interval_ms when set zero
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
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

Hello,

On Tue, Jun 14, 2022 at 3:38 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>
> The perf_event_mux_interval_ms is set to zero or one by default.

I see that __perf_mux_hrtimer_init() sets it to PERF_CPU_HRTIMER
if it's less than 1.

Thanks,
Namhyung


> It can't change back when someone changes it from zero to another
> value.
>
> Make perf_event_mux_interval_ms to PERF_CPU_HRTIMER when set zero.
>
> Fixes: 62b856397927 ("perf: Add sysfs entry to adjust multiplexing interval per PMU")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  kernel/events/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 61ad10862c21..73c8c7462bbf 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10954,9 +10954,12 @@ perf_event_mux_interval_ms_store(struct device *dev,
>         if (ret)
>                 return ret;
>
> -       if (timer < 1)
> +       if (timer < 0)
>                 return -EINVAL;
>
> +       if (timer < 1)
> +               timer = PERF_CPU_HRTIMER;
> +
>         /* same value, noting to do */
>         if (timer == pmu->hrtimer_interval_ms)
>                 return count;
> --
> 2.25.1
>
