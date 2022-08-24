Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCECE59FEA7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiHXPmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbiHXPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:42:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933775B7BF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:41:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bs25so21274473wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=L830z2TNERTcGl4tbqgzwrwOvLMbfJvhxS0C+/JtFw8=;
        b=qQu/PQN7dwLKePtNOVTsvHiRu+6r+2c66s3MpriN8xtWEuDfqq6nr64X0IeiJlfS0p
         c6CKXA2VSkdeLHlwuD6XFfKR7Fa3+gEjy+npCoz93rC5bTjIzCvpkkQuA8VMaDHS8khD
         w9M7xv2e5lM/XGDq/B/y9jNXB29sgJZJ93ixQVdPVe2hQkkVVam2/LtX/e0iz8Zp3yPK
         lVnoqsnSZVsyD8yIAozMnlSH50IYqfAHvCrUY9RpFxYPeeQv/7sB+WcpMcJjfh2OK089
         GDYpfSGGBrkkpE1FGiDXmy5sP8FH6g0kCGTO5fPCNjXI52Sq5AoGMTnzSOKK38HvWZ0V
         zevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=L830z2TNERTcGl4tbqgzwrwOvLMbfJvhxS0C+/JtFw8=;
        b=QjU0cF6flKfeS5braJOY+YAUF98S5hk8bvgWYtal1t9AU52V+07Cb52PquPZsZwSh1
         xPDxsr6IhidHKeX3h3QQxM++CyiC/NXo93U4puJaL3k5NEyHUnBU1WWOZc3jhOrC7wMG
         hOA207alzdZbSsNmPxRhnyjXRecrQnxg0H86d5hO04fodNJySAY6eVAIwZsPGcxp70PR
         8JOtpijrZmFW8v8pJQ4HlaiiLIVZa+FnJXVUuWozB3Pp/e5vA6/3nqv/Wy1GWfdzWkVr
         lAPKexvf43BHZes6cIKuh1MVd/rLEuAuw9D09gmeKPLilhryTFyBsajOUK6kiNHR21Nk
         TNAw==
X-Gm-Message-State: ACgBeo0kqH6sMzRhSrKiNh6GkcUVXtWXXqUp0WSs+jjuPIeXe//QMbxm
        13gLvYwJqeBhvRoHjbdHzOPFmP3IuqVSu3rmyl+NCQ==
X-Google-Smtp-Source: AA6agR4KaYIx6iGPiHJjUkYV9BYSPQa3moZGZB/PuohjsgwIQH/dSC/nh0UbXrb/pakBiHrMXVdkZby/E7+907u0XgA=
X-Received: by 2002:a05:6000:1008:b0:225:58e0:223f with SMTP id
 a8-20020a056000100800b0022558e0223fmr8820928wrx.375.1661355699767; Wed, 24
 Aug 2022 08:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220824072814.16422-1-adrian.hunter@intel.com> <20220824072814.16422-3-adrian.hunter@intel.com>
In-Reply-To: <20220824072814.16422-3-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Aug 2022 08:41:27 -0700
Message-ID: <CAP-5=fUTzXr_60dtXr1_C7sZZz8gOJT2vFFpSXb5yhXDrqO5Yw@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf record: Fix done_fd wakeup event
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-kernel@vger.kernel.org
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

On Wed, Aug 24, 2022 at 12:28 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> evlist__add_wakeup_eventfd() calls perf_evlist__add_pollfd() to add a
> non-perf-event to the evlist pollfds. Since commit 415ccb58f68a
> ("perf record: Introduce thread specific data array") that doesn't work
> because evlist pollfs is not polled and done_fd is not duplicated into
> thread-data.
>
> Patch "perf record: Fix way of handling non-perf-event pollfds" added a new
> approach that ensures file descriptors like done_fd are handled correctly
> by flagging them as fdarray_flag__non_perf_event.
>
> Fix by flagging done_fd as fdarray_flag__non_perf_event.
>
> Example:
>
>  Before:
>
>   $ sleep 3 & perf record -vv -p $!
>   ...
>   thread_data[0x55f44bd34140]: pollfd[0] <- event_fd=5
>   thread_data[0x55f44bd34140]: pollfd[1] <- event_fd=6
>   thread_data[0x55f44bd34140]: pollfd[2] <- event_fd=7
>   thread_data[0x55f44bd34140]: pollfd[3] <- event_fd=8
>   thread_data[0x55f44bd34140]: pollfd[4] <- event_fd=9
>   thread_data[0x55f44bd34140]: pollfd[5] <- event_fd=10
>   thread_data[0x55f44bd34140]: pollfd[6] <- event_fd=11
>   thread_data[0x55f44bd34140]: pollfd[7] <- event_fd=12
>   ...
>
>  After:
>
>   $ sleep 3 & perf record -vv -p $!
>   ...
>   thread_data[0x55a8ded89140]: pollfd[0] <- event_fd=5
>   thread_data[0x55a8ded89140]: pollfd[1] <- event_fd=6
>   thread_data[0x55a8ded89140]: pollfd[2] <- event_fd=7
>   thread_data[0x55a8ded89140]: pollfd[3] <- event_fd=8
>   thread_data[0x55a8ded89140]: pollfd[4] <- event_fd=9
>   thread_data[0x55a8ded89140]: pollfd[5] <- event_fd=10
>   thread_data[0x55a8ded89140]: pollfd[6] <- event_fd=11
>   thread_data[0x55a8ded89140]: pollfd[7] <- event_fd=12
>   thread_data[0x55a8ded89140]: pollfd[8] <- non_perf_event fd=4
>   ...
>
> This patch depends on "perf record: Fix way of handling non-perf-event
> pollfds".
>
> Fixes: 415ccb58f68a ("perf record: Introduce thread specific data array")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evlist.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 48167f3941a6..0b2222d05577 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -608,7 +608,8 @@ int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
>  int evlist__add_wakeup_eventfd(struct evlist *evlist, int fd)
>  {
>         return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN,
> -                                      fdarray_flag__nonfilterable);
> +                                      fdarray_flag__nonfilterable |
> +                                      fdarray_flag__non_perf_event);
>  }
>  #endif
>
> --
> 2.25.1
>
