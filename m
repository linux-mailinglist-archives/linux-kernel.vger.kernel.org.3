Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B638D4B6BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbiBOMSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:18:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiBOMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:18:45 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4564B1074E1;
        Tue, 15 Feb 2022 04:18:35 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b14so7221804ede.9;
        Tue, 15 Feb 2022 04:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xq2jvVOWw99k+EzkKpclX9QGXWedMY9k22KEFFs6jsk=;
        b=c4ogmbcUG2iJFi+BDJCrq3bsPGWN6kY2PqKCyWXKpXRw/ljmZX+gqjc1VS+Qyozx3e
         ylQdqk+DR3Ip2dVdtZDg65D4aXbdHPFpZj61SNXF7Bu+qBmbY2DDbjzkOaz5tWyPLpKY
         vgvCodUPdzt7FKu9TZw/k7V5yqilo2FV4GmdFPFzF7heJ1Z7/yMMXxRxfJhQvBFophI3
         YSMOB/UvHGcXMmhqPXiRGbfIqyCyp8ZO7E02Fx6uzRL9lGuvyy7DngxEmKn/1SubJwcw
         Czw1FStP2/72HiHL34rz5jJnLqJ82XS2bwZG52NU/l64fBfmlUrB2uCVDaQoQAdjaOco
         8AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xq2jvVOWw99k+EzkKpclX9QGXWedMY9k22KEFFs6jsk=;
        b=V6I/bSQ7BoibtoF/vOs3pA3rVv8zFPZBzne1JEW5xHyvoHIOcq3MMqg9bFlOpsli+Q
         msWOQUr+k6Hu9hrf7hLOPldP86zfzD37M5NsTbzbUKitAx4BcRIusfjHEaY2LM1Vb9rI
         9GWF8S/+kI4Y2yvbQR686zOvaEuUQZt33ZKI/d/dVaTPqya0XXQ/ThYoRC7yKl8T2Exb
         iyvjBr7OcjmHkn8P0egQSeUBGCLmQItfgG5nPImiXeRTmtF23q6smoS7Y+Atu7zVn2YK
         NP/3RMYJIi9zdJS7zfX1twUVCFYCzXqP7D+gUbp2km5T7DcD+joGchYg9lSbRf4LYpEh
         vhHg==
X-Gm-Message-State: AOAM531FLe9K+ijNhsgxnB0V6AsvDmYMUxY9TidivHtxmrfjVEyGEOyo
        9CjEmrChX4rowzJ9vFw5Y8w=
X-Google-Smtp-Source: ABdhPJwKSrrktnTwJ3otHZVNysl6dxBiSOZopsbOfrJ11xv7Xg7cY0F1WEZoJzVjWAvS/30VOC4nUQ==
X-Received: by 2002:aa7:d858:: with SMTP id f24mr3694596eds.156.1644927513671;
        Tue, 15 Feb 2022 04:18:33 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id v8sm4138713edc.30.2022.02.15.04.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 04:18:33 -0800 (PST)
Date:   Tue, 15 Feb 2022 13:18:31 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc:     acme@kernel.org, jolsa@redhat.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf: Add API for allocating new thread map
Message-ID: <YguaF9kmFyoZ1ZhC@krava>
References: <20220210085225.551891-1-tz.stoyanov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210085225.551891-1-tz.stoyanov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:52:25AM +0200, Tzvetomir Stoyanov (VMware) wrote:
> The existing API perf_thread_map__new_dummy() allocates new thread map
> for one thread. I couldn't find a way to reallocate the map with more
> threads, or to allocate a new map for more than one thread. Having
> multiple threads in a thread map is essential for some use cases.
> That's why a new API is proposed, which allocates a new thread map
> for given number of threads:
>  perf_thread_map__new()

I'm ok with that, just wondering if we should call it 'perf_thread_map__new_nr'
because we already have perf_cpu_map__new(const char *cpu_list) so
it might be better to keep perf_cpu_map and perf_thread_map in sync

Arnaldo, thoughts on this?

jirka

> 
> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> ---
>  tools/lib/perf/Documentation/libperf.txt |  1 +
>  tools/lib/perf/include/perf/threadmap.h  |  1 +
>  tools/lib/perf/libperf.map               |  1 +
>  tools/lib/perf/tests/test-threadmap.c    | 27 ++++++++++++++++++++++++
>  tools/lib/perf/threadmap.c               | 15 +++++++++----
>  5 files changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index 32c5051c24eb..9cbd41c29bff 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -62,6 +62,7 @@ SYNOPSIS
>    struct perf_thread_map;
>  
>    struct perf_thread_map *perf_thread_map__new_dummy(void);
> +  struct perf_thread_map *perf_thread_map__new(int nr);
>  
>    void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
>    char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
> diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
> index a7c50de8d010..47d433416040 100644
> --- a/tools/lib/perf/include/perf/threadmap.h
> +++ b/tools/lib/perf/include/perf/threadmap.h
> @@ -8,6 +8,7 @@
>  struct perf_thread_map;
>  
>  LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
> +LIBPERF_API struct perf_thread_map *perf_thread_map__new(int nr);
>  
>  LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
>  LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index 93696affda2e..240a2f087b70 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -11,6 +11,7 @@ LIBPERF_0.0.1 {
>  		perf_cpu_map__empty;
>  		perf_cpu_map__max;
>  		perf_cpu_map__has;
> +		perf_thread_map__new;
>  		perf_thread_map__new_dummy;
>  		perf_thread_map__set_pid;
>  		perf_thread_map__comm;
> diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
> index 5e2a0291e94c..3388bf36dfc0 100644
> --- a/tools/lib/perf/tests/test-threadmap.c
> +++ b/tools/lib/perf/tests/test-threadmap.c
> @@ -11,9 +11,12 @@ static int libperf_print(enum libperf_print_level level,
>  	return vfprintf(stderr, fmt, ap);
>  }
>  
> +#define THREADS_NR	5
> +
>  int test_threadmap(int argc, char **argv)
>  {
>  	struct perf_thread_map *threads;
> +	int i;
>  
>  	__T_START;
>  
> @@ -27,6 +30,30 @@ int test_threadmap(int argc, char **argv)
>  	perf_thread_map__put(threads);
>  	perf_thread_map__put(threads);
>  
> +	threads = perf_thread_map__new(THREADS_NR);
> +	if (!threads)
> +		tests_failed++;
> +
> +	if (perf_thread_map__nr(threads) != THREADS_NR)
> +		tests_failed++;
> +
> +	for (i = 0; i < THREADS_NR; i++) {
> +		if (perf_thread_map__pid(threads, i) != -1)
> +			tests_failed++;
> +	}
> +
> +	for (i = 1; i < THREADS_NR; i++)
> +		perf_thread_map__set_pid(threads, i, i * 100);
> +
> +	if (perf_thread_map__pid(threads, 0) != -1)
> +		tests_failed++;
> +
> +	for (i = 1; i < THREADS_NR; i++) {
> +		if (perf_thread_map__pid(threads, i) != i * 100)
> +			tests_failed++;
> +	}
> +	perf_thread_map__put(threads);
> +
>  	__T_END;
>  	return tests_failed == 0 ? 0 : -1;
>  }
> diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
> index e92c368b0a6c..843fe1070cc9 100644
> --- a/tools/lib/perf/threadmap.c
> +++ b/tools/lib/perf/threadmap.c
> @@ -42,18 +42,25 @@ char *perf_thread_map__comm(struct perf_thread_map *map, int thread)
>  	return map->map[thread].comm;
>  }
>  
> -struct perf_thread_map *perf_thread_map__new_dummy(void)
> +struct perf_thread_map *perf_thread_map__new(int nr)
>  {
> -	struct perf_thread_map *threads = thread_map__alloc(1);
> +	struct perf_thread_map *threads = thread_map__alloc(nr);
> +	int i;
>  
>  	if (threads != NULL) {
> -		perf_thread_map__set_pid(threads, 0, -1);
> -		threads->nr = 1;
> +		for (i = 0; i < nr; i++)
> +			perf_thread_map__set_pid(threads, i, -1);
> +		threads->nr = nr;
>  		refcount_set(&threads->refcnt, 1);
>  	}
>  	return threads;
>  }
>  
> +struct perf_thread_map *perf_thread_map__new_dummy(void)
> +{
> +	return perf_thread_map__new(1);
> +}
> +
>  static void perf_thread_map__delete(struct perf_thread_map *threads)
>  {
>  	if (threads) {
> -- 
> 2.34.1
> 
