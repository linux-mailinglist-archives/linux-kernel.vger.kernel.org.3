Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA76F53B36E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiFBGV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiFBGVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:21:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0DCDED1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:21:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h62-20020a1c2141000000b0039aa4d054e2so4238121wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 23:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOVgUxA1bDTDyTIwmAcMyzfNGeAcBs7vn2fkT3URToc=;
        b=avOI5wm80HcfnD5JSHV7pK5BsH2+jVSuFyJ0O3c7HNgCLu8Iq6iYXahvWw0avss3eR
         OnEGjxGmWICyBVIHkTj92usczbn9/N5FBHaBqO1wp3+Uqkmyul0llhXTdVW9kDmpUYAW
         veDqiLVP0TXTyVsIk6kp2QSlg57vDs6nj4e/sDOVEFr7KjDkgdqkshtQvMa107DP6z0R
         L71RMNTEyjhK78/fN80/mjnnY2cNuTZJ2jgjuHtqDhgksnFn/5HojsgBb6Syb6oZH1Ys
         +b5+kf8wPP4yulJL4bcrJaiSJGja9DLWWySsMTnwb9zp1/JkzhO9uPs4dEkOCfi9NgoN
         MFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOVgUxA1bDTDyTIwmAcMyzfNGeAcBs7vn2fkT3URToc=;
        b=ISkUD/XR+MhS6BYzvzQI0dU6r5GEQpsv5LQCjWoQXMp9nTM6nl1fljCyfv43Nc/plR
         xZsQd8UnnjsAEHWUL5uFoSKuZq4AIvazqzgOVStzwfCBenV14FVM2HSswcBzd3b/fpys
         9WnvVdbn5Lnc8KilUZQELsKhe+s/LshFzeMqQNzb4F3WOnIfJsPn0ZYkL41vUaUkXlG5
         49F6wt5TUrQWQKG8cc/sZW1l/l5IJAmHQVYC034yW5vaShm68xh9Y0XHpfrvEQOwnbs6
         WbuXcCN28e+k7MzgbfyE7LF7zjPsiU5OEOKKNtUrLjeJ/PXPjppWKG81KYFDrkKBa1rk
         Xuag==
X-Gm-Message-State: AOAM531M/nGTqg0IKOE1f1W+jU7GwSfCIA+THbqhAv45KOPu/J3/yKzl
        jEu5WrlE7yu4QnZGtREIPC/j3X1MBeGAGkABD6NDUg==
X-Google-Smtp-Source: ABdhPJx+Qg9/XPJgAjGUvPxditJJ54bsPjYt9M7fFcFlP4MsNMvGJmvit/KkVxeCCqj60h0rP7xlP0ScE+qOSxcDlPA=
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id
 m1-20020a1ca301000000b003929bc5203cmr2446589wme.67.1654150908114; Wed, 01 Jun
 2022 23:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220601065846.456965-1-namhyung@kernel.org> <20220601065846.456965-3-namhyung@kernel.org>
In-Reply-To: <20220601065846.456965-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 1 Jun 2022 23:21:34 -0700
Message-ID: <CAP-5=fWvS=1XrXnE_a+sif8ZKy2oc6pmo6RmZ6+fFrWoa1VM3A@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf lock: Add lock contention tracepoints record support
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
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

On Tue, May 31, 2022 at 11:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> When LOCKDEP and LOCK_STAT events are not available, it falls back to
> record the new lock contention tracepoints.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-lock.c | 70 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 23a33ac15e68..3e3320b8cede 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -495,6 +495,12 @@ struct trace_lock_handler {
>
>         int (*release_event)(struct evsel *evsel,
>                              struct perf_sample *sample);
> +
> +       int (*contention_begin_event)(struct evsel *evsel,
> +                                     struct perf_sample *sample);
> +
> +       int (*contention_end_event)(struct evsel *evsel,
> +                                   struct perf_sample *sample);

Would it make sense to add a comment here about LOCKDEP and LOCK_STAT?
It could be confusing if the handler isn't called on different
kernels.

Thanks,
Ian

>  };
>
>  static struct lock_seq_stat *get_seq(struct thread_stat *ts, u64 addr)
> @@ -822,6 +828,20 @@ static int evsel__process_lock_release(struct evsel *evsel, struct perf_sample *
>         return 0;
>  }
>
> +static int evsel__process_contention_begin(struct evsel *evsel, struct perf_sample *sample)
> +{
> +       if (trace_handler->contention_begin_event)
> +               return trace_handler->contention_begin_event(evsel, sample);
> +       return 0;
> +}
> +
> +static int evsel__process_contention_end(struct evsel *evsel, struct perf_sample *sample)
> +{
> +       if (trace_handler->contention_end_event)
> +               return trace_handler->contention_end_event(evsel, sample);
> +       return 0;
> +}
> +
>  static void print_bad_events(int bad, int total)
>  {
>         /* Output for debug, this have to be removed */
> @@ -1023,6 +1043,11 @@ static const struct evsel_str_handler lock_tracepoints[] = {
>         { "lock:lock_release",   evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
>  };
>
> +static const struct evsel_str_handler contention_tracepoints[] = {
> +       { "lock:contention_begin", evsel__process_contention_begin, },
> +       { "lock:contention_end",   evsel__process_contention_end,   },
> +};
> +
>  static bool force;
>
>  static int __cmd_report(bool display_info)
> @@ -1086,20 +1111,41 @@ static int __cmd_record(int argc, const char **argv)
>                 "record", "-R", "-m", "1024", "-c", "1", "--synth", "task",
>         };
>         unsigned int rec_argc, i, j, ret;
> +       unsigned int nr_tracepoints;
>         const char **rec_argv;
> +       bool has_lock_stat = true;
>
>         for (i = 0; i < ARRAY_SIZE(lock_tracepoints); i++) {
>                 if (!is_valid_tracepoint(lock_tracepoints[i].name)) {
> -                               pr_err("tracepoint %s is not enabled. "
> -                                      "Are CONFIG_LOCKDEP and CONFIG_LOCK_STAT enabled?\n",
> -                                      lock_tracepoints[i].name);
> -                               return 1;
> +                       pr_debug("tracepoint %s is not enabled. "
> +                                "Are CONFIG_LOCKDEP and CONFIG_LOCK_STAT enabled?\n",
> +                                lock_tracepoints[i].name);
> +                       has_lock_stat = false;
> +                       break;
> +               }
> +       }
> +
> +       if (has_lock_stat)
> +               goto setup_args;
> +
> +       for (i = 0; i < ARRAY_SIZE(contention_tracepoints); i++) {
> +               if (!is_valid_tracepoint(contention_tracepoints[i].name)) {
> +                       pr_err("tracepoint %s is not enabled.\n",
> +                              contention_tracepoints[i].name);
> +                       return 1;
>                 }
>         }
>
> +setup_args:
>         rec_argc = ARRAY_SIZE(record_args) + argc - 1;
> +
> +       if (has_lock_stat)
> +               nr_tracepoints = ARRAY_SIZE(lock_tracepoints);
> +       else
> +               nr_tracepoints = ARRAY_SIZE(contention_tracepoints);
> +
>         /* factor of 2 is for -e in front of each tracepoint */
> -       rec_argc += 2 * ARRAY_SIZE(lock_tracepoints);
> +       rec_argc += 2 * nr_tracepoints;
>
>         rec_argv = calloc(rec_argc + 1, sizeof(char *));
>         if (!rec_argv)
> @@ -1108,9 +1154,19 @@ static int __cmd_record(int argc, const char **argv)
>         for (i = 0; i < ARRAY_SIZE(record_args); i++)
>                 rec_argv[i] = strdup(record_args[i]);
>
> -       for (j = 0; j < ARRAY_SIZE(lock_tracepoints); j++) {
> +       for (j = 0; j < nr_tracepoints; j++) {
> +               const char *ev_name;
> +
> +               if (has_lock_stat)
> +                       ev_name = strdup(lock_tracepoints[j].name);
> +               else
> +                       ev_name = strdup(contention_tracepoints[j].name);
> +
> +               if (!ev_name)
> +                       return -ENOMEM;
> +
>                 rec_argv[i++] = "-e";
> -               rec_argv[i++] = strdup(lock_tracepoints[j].name);
> +               rec_argv[i++] = ev_name;
>         }
>
>         for (j = 1; j < (unsigned int)argc; j++, i++)
> --
> 2.36.1.255.ge46751e96f-goog
>
