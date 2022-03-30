Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791844EC602
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346613AbiC3Nw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346491AbiC3Nw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:52:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94650133D8B;
        Wed, 30 Mar 2022 06:50:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r13so41661069ejd.5;
        Wed, 30 Mar 2022 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1OLDSq/HMivImgf5vlU82yeV23lshpzhfTJKY95m+Z8=;
        b=H5U9h4jAU0SRA9mYbThvS4qFeQ8C3Fh5k6/CLwP1tHEgS24U7HWxp3Rhc8iGRVKMCK
         I1ZCFUP6d9M0osRXl6cH8kWr1vNURf1UbiOcGcBnElzuvap40sG70vKEWQ0wnKzLTcFL
         sfXlsnTJg3VvtEVM83R0NkxJyYdQSEjmjb3Yeu0ENtDts6NRVZ42ToEYKDrvQPyG75uo
         0yfLuTVULfTJS0O9XbNeNYfbP7D8njRJWNaQJavNva/IxnXW9yBkHi+5RaWmKtupPn9c
         FjELMZie/femNx85sK+NcsQRKw87oGyV3JSAnpJ0lyUVt22guLpfW98gHDQq/QatWaeh
         ogBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1OLDSq/HMivImgf5vlU82yeV23lshpzhfTJKY95m+Z8=;
        b=Mo7BVCMhmfneoXFlWL/13Ze3Wrk0n84BKibUWRoid12uBX1w2CMzT4puGzCNlow3vB
         irliaavrR53p7bnWM67Bck8Fgtx0JfnOWLHZD+/kCIuYlpUhoWLePFMrTdnD+7dwGezv
         R0AQeoUCABNm9FbZ369BNERu78NWaPI6aIlDMILcZymGhDgzqnM1dICFfdHEdurqyOgM
         enVjlWYl7ZF7lcqOG3yyBd5+uO2xT+ml4FxpBCclqxw3Zwpj6nNDLyvX4cjbGJ1H19gP
         Xkhc41vzTW36P1VXNMSBbtcxQNR13ru3Lufcp9Z/aUpaulIx6k8COoLxKmXtZBGrzUkL
         R7AQ==
X-Gm-Message-State: AOAM533ng0F5mVolSzRgBWfCzxEoaTudWvtV58M8CIZqvNKop3u2CyGe
        wNA43unHHQC5U2C7MBtuAai1jNyvnRoezw==
X-Google-Smtp-Source: ABdhPJxMB3BHLF1VMfqbB7RLZ1Vx9XU6izABsdLNoOOTTt3yKeGFPBiGYxgg37i3B6C5OzIy24rRWw==
X-Received: by 2002:a17:907:6d9e:b0:6df:bb09:10eb with SMTP id sb30-20020a1709076d9e00b006dfbb0910ebmr39394770ejc.409.1648648239003;
        Wed, 30 Mar 2022 06:50:39 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm8353128ejj.142.2022.03.30.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:50:38 -0700 (PDT)
Date:   Wed, 30 Mar 2022 15:50:36 +0200
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/7] libperf: Add perf_evsel__check_overflow()
 functions
Message-ID: <YkRgLBTHVQbdX8rK@krava>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <20220325043829.224045-6-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325043829.224045-6-nakamura.shun@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:38:27PM +0900, Shunsuke Nakamura wrote:
> Add the following functions:
> 
>   perf_evsel__check_overflow
>   perf_evsel__check_overflow_cpu
> 
> to check for perf events with the file descriptor specified in the
> argument.
> These functions can be used in signal handlers to check overflow.
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
>  tools/lib/perf/Documentation/libperf.txt |  3 +++
>  tools/lib/perf/evsel.c                   | 34 ++++++++++++++++++++++++
>  tools/lib/perf/include/perf/evsel.h      |  4 +++
>  tools/lib/perf/libperf.map               |  2 ++
>  4 files changed, 43 insertions(+)
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index 700c1ce15159..4ae8d738b948 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -165,6 +165,9 @@ SYNOPSIS
>                                int cpu_map_idx);
>    int perf_evsel__period(struct perf_evsel *evsel, int period);
>    int perf_evsel__period_cpu(struct perf_evsel *evsel, int period, int cpu_map_idx);
> +  int perf_evsel__check_overflow(struct perf_evsel *evsel, int sig_fd, bool *overflow);
> +  int perf_evsel__check_overflow_cpu(struct perf_evsel *evsel, int cpu_map_idx,
> +                                     int sig_fd, bool *overflow);

should this be more like:

  perf_evsel__has_fd(struct perf_evsel *evsel, int fd)

also why do we need to export *_cpu version for this?
I don't see it used in the test

>    struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
>    struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
>    struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index db9b7274feb5..6ff3cf692df3 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -616,3 +616,37 @@ int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
>  
>  	return err;
>  }
> +
> +int perf_evsel__check_overflow_cpu(struct perf_evsel *evsel, int cpu_map_idx,
> +				   int sig_fd, bool *overflow)
> +{
> +	int thread;
> +	int *fd;
> +	int err = 0;
> +
> +	if (!overflow)
> +		return -EINVAL;
> +
> +	*overflow = false;
> +
> +	for (thread = 0; thread < xyarray__max_y(evsel->fd) && !err; ++thread) {
> +		fd = FD(evsel, cpu_map_idx, thread);
> +		if (sig_fd <= 0 || !fd || *fd < 0)
> +			err = -EINVAL;

sig_fd check should be before the loop

jirka
