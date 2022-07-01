Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9788563CA7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 01:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiGAXGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 19:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiGAXGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 19:06:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E726D56B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 16:06:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l68so2113748wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7xp4nnQTL9CDa5RM9fRJT3jD+dPM5rIbsC2OObud0M=;
        b=LblUYuIy5SXHWSx5d4ANlDn7+H26GGlOrNWd1X0wQLsV+nBm26Fm3YCX7N+9EIQ44J
         AiC2WSMAe0Xs6L9RJuoPj4h3zObFsiGadgy/a/d1V6mX3FfBbi5EXE1Y7ZY1hrVpJE76
         8AIQ7nwP7EYx4PrdvWqTKFREo6VPPG8PCbuyrL0IwafyjXPfif7fGg7rmkt3iPIHzc7L
         ZI3DQFuc8xdNvzAjE/H2bW41SmNh1GFpAxw7/KULFIfVRn82gmidRAj6Ieva9zKNjyZx
         f3jl0gpe9v2PwYcDkdSL9BJX/SVKAMTFcvjjZ2ZqJsWqT03zn6vQsAWLXaeRi6PWanHH
         YCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7xp4nnQTL9CDa5RM9fRJT3jD+dPM5rIbsC2OObud0M=;
        b=nvDkDDrXhXulzlA0+i3+743kjMGJ7S2fuzNZeTx0zO3yckT3d7umdHcBecz5kQgdgH
         44rsS5rn/mHNyhnMp1+tPZGRWtcKKJ9ONdr/yLakwczmh126aNeKwd0QrQOF/FA8oFUg
         xKFY7UNQuG8KsgJ/m9MhKicG9BwB3MFeHzglITtt8pCquH9IGH+IQuy34UBb0LlEqmvy
         MetE9xPQHw4W61YQYDw//Wfl7R9insh4vXdFnulFWlFnfgQF/2xfZED9jKPiuFXSOViS
         7lcFSh+yzuwKKuamvpyO069x7jiU7BCQ8HqBP/fYGjzw0ADOAydvErPZ64NRlJfhC1/r
         Cyyg==
X-Gm-Message-State: AJIora8KRuRzRQLBrAzvzQk7lWsY75XdqE1DYKWU37RQO0X0rA4+pYI+
        9V6qv4coc06i6xankkiQA7AoYN/XSlE7hIt7yFZ+Lw==
X-Google-Smtp-Source: AGRyM1v4TG9T22ukbtdPxW1GOczpQEwVEWtguEGORPaZuQzTrHnF+xTTs3JjDEuz4C20xf6u4bp+0AjHNi+ZzN6vvWA=
X-Received: by 2002:a05:600c:4e4c:b0:3a0:53a2:48b5 with SMTP id
 e12-20020a05600c4e4c00b003a053a248b5mr18301843wmq.174.1656716777822; Fri, 01
 Jul 2022 16:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220701205458.985106-1-namhyung@kernel.org>
In-Reply-To: <20220701205458.985106-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 1 Jul 2022 16:06:05 -0700
Message-ID: <CAP-5=fVbp4QT2J4Ek9e+1XL1HEMrUrYgNXptcWqyCHZxWbVAGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tools: Don't sort the task scan result from /proc
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
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

On Fri, Jul 1, 2022 at 1:55 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It should not sort the result as procfs already returns a proper
> ordering of tasks.  Actually sorting the order caused problems that it
> doesn't guararantee to process the main thread first.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/synthetic-events.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 27acdc5e5723..a068f42833c3 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -754,7 +754,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>         snprintf(filename, sizeof(filename), "%s/proc/%d/task",
>                  machine->root_dir, pid);
>
> -       n = scandir(filename, &dirent, filter_task, alphasort);
> +       n = scandir(filename, &dirent, filter_task, NULL);
>         if (n < 0)
>                 return n;
>
> @@ -987,7 +987,7 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
>                 return 0;
>
>         snprintf(proc_path, sizeof(proc_path), "%s/proc", machine->root_dir);
> -       n = scandir(proc_path, &dirent, filter_task, alphasort);
> +       n = scandir(proc_path, &dirent, filter_task, NULL);
>         if (n < 0)
>                 return err;
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
