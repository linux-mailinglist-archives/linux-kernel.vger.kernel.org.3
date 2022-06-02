Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D7C53B383
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiFBGXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiFBGXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:23:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2C52873F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:23:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k16so5088278wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 23:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFf/wKtid+qqccnmCaXHbzsv7XOixvDy8MiGyLaP5Qo=;
        b=PqntItYQPiJwKKS6LxUkXZsMQ6h6bpmWtjoPdJai/0MKKdyVctE4sgX4tuP9P7udN6
         vvdXyCf37H6omgn5heEWafAu1BrY2wyr643CcRjVZKSU+TdhkUw2coEK7Kt8l2bmLmRx
         T7wOV8rnYTUJG/O8COvGeZZ6Z//+sdWE/FjuLbs6QguKYGbXq1yu+XGYnDn5Y64tgArh
         J5AETSnWSVT9Hif4ZruHaQncMJc8Wgnf/hOqPs1BQX86MDLterZhrvfKyL+2cDGvbH69
         b+2CJ5TWM3qyNRRIB32wu27FzySTutvKzf2Bb1MvxvLwlBd3G8Ruh9Imdw1LhQlGGXb3
         5cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFf/wKtid+qqccnmCaXHbzsv7XOixvDy8MiGyLaP5Qo=;
        b=SKNUHwOgtbG+GndiYSdYi+7tdyx0ZNQR2LWAWtB7QvtO5RWykaE9OlC4XSsD+NHoEa
         A5EvidgeSBuhoJxMBTr+67XPlauqf40+GXJLa4/E+DzdiaQ8QsihPnqxAU0SzgmcByfv
         aacjk/U7LNn0lQXjONZVVjBBbLINltjds6HFXR0gVCVXsvfBCFNZ0vYSjVx0YynEjtYf
         o6LNGl0nd66JUNhZR91MVTzccGxXkpcDdbqJvIdU1Osg2FbnMtHzK3FvxlXl1OOHg6ei
         yzIl36Ci07b46z0VPr0plNsTlLREXZHbjOmv6+kie4sAwSJcXZHv8cGH8slEUkrtlvU+
         Stig==
X-Gm-Message-State: AOAM533rQTgyui0a2j58w2nlaNWOOxwNRLWeayZbT+b4qt9ZX5RReKlF
        H3TA03v/ecUdI1m75gXcZgrX7G+SB6r+7pslBXuJnQ==
X-Google-Smtp-Source: ABdhPJxGLD1VpApAnmNP6w3Pc683S/fjU5HhAr23MHk/sDTUluttPZncUt28EOBNAy+ndZVOco8MtSEygg+vL9ysNSM=
X-Received: by 2002:adf:eb91:0:b0:20f:fcc2:475c with SMTP id
 t17-20020adfeb91000000b0020ffcc2475cmr2253920wrn.40.1654151011227; Wed, 01
 Jun 2022 23:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220601065846.456965-1-namhyung@kernel.org> <20220601065846.456965-4-namhyung@kernel.org>
In-Reply-To: <20220601065846.456965-4-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 1 Jun 2022 23:23:18 -0700
Message-ID: <CAP-5=fWDN_DjaVhJWDCiHvnKJnbD4xj8_VMtJz+rQyZKvjvdUw@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf lock: Handle lock contention tracepoints
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
> When the lock contention events are used, there's no tracking of
> acquire and release.  So the state machine is simplified to use
> UNINITIALIZED -> CONTENDED -> ACQUIRED only.
>
> Note that CONTENDED state is re-entrant since mutex locks can hit two
> or more consecutive contention_begin events for optimistic spinning
> and sleep.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-lock.c | 125 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 3e3320b8cede..82cbf0f2e4cd 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -789,6 +789,124 @@ static int report_lock_release_event(struct evsel *evsel,
>         return 0;
>  }
>
> +static int report_lock_contention_begin_event(struct evsel *evsel,
> +                                             struct perf_sample *sample)
> +{
> +       struct lock_stat *ls;
> +       struct thread_stat *ts;
> +       struct lock_seq_stat *seq;
> +       u64 addr = evsel__intval(evsel, sample, "lock_addr");
> +
> +       if (show_thread_stats)
> +               addr = sample->tid;
> +
> +       ls = lock_stat_findnew(addr, "No name");
> +       if (!ls)
> +               return -ENOMEM;
> +
> +       ts = thread_stat_findnew(sample->tid);
> +       if (!ts)
> +               return -ENOMEM;
> +
> +       seq = get_seq(ts, addr);
> +       if (!seq)
> +               return -ENOMEM;
> +
> +       switch (seq->state) {
> +       case SEQ_STATE_UNINITIALIZED:
> +       case SEQ_STATE_ACQUIRED:
> +               break;
> +       case SEQ_STATE_CONTENDED:
> +               /*
> +                * It can have nested contention begin with mutex spinning,
> +                * then we would use the original contention begin event and
> +                * ignore the second one.
> +                */
> +               goto end;
> +       case SEQ_STATE_ACQUIRING:
> +       case SEQ_STATE_READ_ACQUIRED:
> +       case SEQ_STATE_RELEASED:
> +               /* broken lock sequence */
> +               if (!ls->broken) {
> +                       ls->broken = 1;
> +                       bad_hist[BROKEN_CONTENDED]++;
> +               }
> +               list_del_init(&seq->list);
> +               free(seq);
> +               goto end;
> +       default:
> +               BUG_ON("Unknown state of lock sequence found!\n");
> +               break;
> +       }
> +
> +       if (seq->state != SEQ_STATE_CONTENDED) {
> +               seq->state = SEQ_STATE_CONTENDED;
> +               seq->prev_event_time = sample->time;
> +               ls->nr_contended++;
> +       }
> +end:
> +       return 0;
> +}
> +
> +static int report_lock_contention_end_event(struct evsel *evsel,
> +                                           struct perf_sample *sample)
> +{
> +       struct lock_stat *ls;
> +       struct thread_stat *ts;
> +       struct lock_seq_stat *seq;
> +       u64 contended_term;
> +       u64 addr = evsel__intval(evsel, sample, "lock_addr");
> +
> +       if (show_thread_stats)
> +               addr = sample->tid;
> +
> +       ls = lock_stat_findnew(addr, "No name");
> +       if (!ls)
> +               return -ENOMEM;
> +
> +       ts = thread_stat_findnew(sample->tid);
> +       if (!ts)
> +               return -ENOMEM;
> +
> +       seq = get_seq(ts, addr);
> +       if (!seq)
> +               return -ENOMEM;
> +
> +       switch (seq->state) {
> +       case SEQ_STATE_UNINITIALIZED:
> +               goto end;
> +       case SEQ_STATE_CONTENDED:
> +               contended_term = sample->time - seq->prev_event_time;
> +               ls->wait_time_total += contended_term;
> +               if (contended_term < ls->wait_time_min)
> +                       ls->wait_time_min = contended_term;
> +               if (ls->wait_time_max < contended_term)
> +                       ls->wait_time_max = contended_term;
> +               break;
> +       case SEQ_STATE_ACQUIRING:
> +       case SEQ_STATE_ACQUIRED:
> +       case SEQ_STATE_READ_ACQUIRED:
> +       case SEQ_STATE_RELEASED:
> +               /* broken lock sequence */
> +               if (!ls->broken) {
> +                       ls->broken = 1;
> +                       bad_hist[BROKEN_CONTENDED]++;
> +               }
> +               list_del_init(&seq->list);
> +               free(seq);
> +               goto end;
> +       default:
> +               BUG_ON("Unknown state of lock sequence found!\n");
> +               break;
> +       }
> +
> +       seq->state = SEQ_STATE_ACQUIRED;
> +       ls->nr_acquired++;
> +       ls->avg_wait_time = ls->wait_time_total/ls->nr_acquired;
> +end:
> +       return 0;
> +}
> +
>  /* lock oriented handlers */
>  /* TODO: handlers for CPU oriented, thread oriented */
>  static struct trace_lock_handler report_lock_ops  = {
> @@ -796,6 +914,8 @@ static struct trace_lock_handler report_lock_ops  = {
>         .acquired_event         = report_lock_acquired_event,
>         .contended_event        = report_lock_contended_event,
>         .release_event          = report_lock_release_event,
> +       .contention_begin_event = report_lock_contention_begin_event,
> +       .contention_end_event   = report_lock_contention_end_event,
>  };
>
>  static struct trace_lock_handler *trace_handler;
> @@ -1081,6 +1201,11 @@ static int __cmd_report(bool display_info)
>                 goto out_delete;
>         }
>
> +       if (perf_session__set_tracepoints_handlers(session, contention_tracepoints)) {
> +               pr_err("Initializing perf session tracepoint handlers failed\n");
> +               goto out_delete;
> +       }
> +
>         if (setup_output_field(output_fields))
>                 goto out_delete;
>
> --
> 2.36.1.255.ge46751e96f-goog
>
