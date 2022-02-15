Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95F44B623F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 05:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiBOEyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 23:54:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiBOEyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 23:54:09 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9256C55A2;
        Mon, 14 Feb 2022 20:53:59 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d187so32873945pfa.10;
        Mon, 14 Feb 2022 20:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQkfdtClRni2h3znN9UiF7Ukufkj8rvzkK7VvnWbIxI=;
        b=J5PPM7uKwIIklULMzXC7qYZ9Iy+6WXGAZQQjEFuSbVQowFhJY53o2fU3iA5BQeHd79
         TAMz1TprnJPfTs3XxqRua76HVRPr9l8HJI2wZcyTlXu9t3CeGTonOC7z6CBqfpGEKfT6
         +13VheAo/OWeZOmBQp0cGRXT6OuvbfdupfmVL947OaWyi79orjagslIyVQshaygrEDMN
         1d2DnBgvYbNL+oH/AEL4hH6H94faYmNS8/QUmwO0+gH67XzEZk+aureuU3FS18HxlCZI
         lLkstQdlv6GDreuqt66NCqHZ1ertoFZMbc5y3x990YvCSp5XCQZ4Ui8ilDwtEWkS5t8b
         0SAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQkfdtClRni2h3znN9UiF7Ukufkj8rvzkK7VvnWbIxI=;
        b=cF5e8iTJZO9+Lo11EszDIzn1c+aLWKVxBrV+6JjJAB0dYlmHKfhX5v07bteMqSDJ+T
         15XmlULiWGLk8vUvIx6ivTeJY2MndJYHG9vW7XI1jz0Cm48YcTJsMJm53fu+lNwddx1L
         YMf2S/sfMKM92nYQkXSUJ4uzyW4xhdejDdg2GsfzM7Egk4WdVzJuKfAesDmeSAoWcR5p
         XvLRqbe/hWZsaBo8/QvXBhJ/3AAdQ8l+CDki2H7awrZNXGeQUQnRL1KE23Fz3DZiYw/X
         DqesSL2UATBJPP2MgfJ/YsA03RRnVo9lChs7RboR50+g6/krd2QWwjo4a51jaUY9jpB/
         MU/A==
X-Gm-Message-State: AOAM533luuKAhfC0eUcOsnE/yigRh+MEBWHG8rrAHsOy17I4F6oOv8F/
        gH7rVdCAKGz68vFrZZy7aBpC/2thkQP9ZzTeaHw=
X-Google-Smtp-Source: ABdhPJw+2zcSDSURptSVJWKFp7tZkQZ73Obmk+E49D65vtMbPuQvYRjHFB6H8ALaGtr/6pUJjblCGBQRVU/phWxNjis=
X-Received: by 2002:a65:6090:: with SMTP id t16mr2015509pgu.323.1644900839188;
 Mon, 14 Feb 2022 20:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20220210085225.551891-1-tz.stoyanov@gmail.com>
In-Reply-To: <20220210085225.551891-1-tz.stoyanov@gmail.com>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Tue, 15 Feb 2022 06:53:42 +0200
Message-ID: <CAPpZLN4c=PW0m5fvUJ4ugaGCYOiZfs+bNzJKOfJjWzEcBa0FOA@mail.gmail.com>
Subject: Re: [PATCH] libperf: Add API for allocating new thread map
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A gentle ping.
I'll be glad for any comments or suggestions for a possible workaround
of this problem.
Thanks!

On Thu, Feb 10, 2022 at 10:52 AM Tzvetomir Stoyanov (VMware)
<tz.stoyanov@gmail.com> wrote:
>
> The existing API perf_thread_map__new_dummy() allocates new thread map
> for one thread. I couldn't find a way to reallocate the map with more
> threads, or to allocate a new map for more than one thread. Having
> multiple threads in a thread map is essential for some use cases.
> That's why a new API is proposed, which allocates a new thread map
> for given number of threads:
>  perf_thread_map__new()
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
>                 perf_cpu_map__empty;
>                 perf_cpu_map__max;
>                 perf_cpu_map__has;
> +               perf_thread_map__new;
>                 perf_thread_map__new_dummy;
>                 perf_thread_map__set_pid;
>                 perf_thread_map__comm;
> diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
> index 5e2a0291e94c..3388bf36dfc0 100644
> --- a/tools/lib/perf/tests/test-threadmap.c
> +++ b/tools/lib/perf/tests/test-threadmap.c
> @@ -11,9 +11,12 @@ static int libperf_print(enum libperf_print_level level,
>         return vfprintf(stderr, fmt, ap);
>  }
>
> +#define THREADS_NR     5
> +
>  int test_threadmap(int argc, char **argv)
>  {
>         struct perf_thread_map *threads;
> +       int i;
>
>         __T_START;
>
> @@ -27,6 +30,30 @@ int test_threadmap(int argc, char **argv)
>         perf_thread_map__put(threads);
>         perf_thread_map__put(threads);
>
> +       threads = perf_thread_map__new(THREADS_NR);
> +       if (!threads)
> +               tests_failed++;
> +
> +       if (perf_thread_map__nr(threads) != THREADS_NR)
> +               tests_failed++;
> +
> +       for (i = 0; i < THREADS_NR; i++) {
> +               if (perf_thread_map__pid(threads, i) != -1)
> +                       tests_failed++;
> +       }
> +
> +       for (i = 1; i < THREADS_NR; i++)
> +               perf_thread_map__set_pid(threads, i, i * 100);
> +
> +       if (perf_thread_map__pid(threads, 0) != -1)
> +               tests_failed++;
> +
> +       for (i = 1; i < THREADS_NR; i++) {
> +               if (perf_thread_map__pid(threads, i) != i * 100)
> +                       tests_failed++;
> +       }
> +       perf_thread_map__put(threads);
> +
>         __T_END;
>         return tests_failed == 0 ? 0 : -1;
>  }
> diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
> index e92c368b0a6c..843fe1070cc9 100644
> --- a/tools/lib/perf/threadmap.c
> +++ b/tools/lib/perf/threadmap.c
> @@ -42,18 +42,25 @@ char *perf_thread_map__comm(struct perf_thread_map *map, int thread)
>         return map->map[thread].comm;
>  }
>
> -struct perf_thread_map *perf_thread_map__new_dummy(void)
> +struct perf_thread_map *perf_thread_map__new(int nr)
>  {
> -       struct perf_thread_map *threads = thread_map__alloc(1);
> +       struct perf_thread_map *threads = thread_map__alloc(nr);
> +       int i;
>
>         if (threads != NULL) {
> -               perf_thread_map__set_pid(threads, 0, -1);
> -               threads->nr = 1;
> +               for (i = 0; i < nr; i++)
> +                       perf_thread_map__set_pid(threads, i, -1);
> +               threads->nr = nr;
>                 refcount_set(&threads->refcnt, 1);
>         }
>         return threads;
>  }
>
> +struct perf_thread_map *perf_thread_map__new_dummy(void)
> +{
> +       return perf_thread_map__new(1);
> +}
> +
>  static void perf_thread_map__delete(struct perf_thread_map *threads)
>  {
>         if (threads) {
> --
> 2.34.1
>


-- 
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
