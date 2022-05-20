Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2281152F144
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352038AbiETRJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352048AbiETRJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:09:35 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796F71862B6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:09:32 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v71so15221107ybi.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QU49IpXWY3ILYjrG9pprYmKd2girarG6kbSVlkmZXq4=;
        b=RFVe4hjab8BtmvgSDTDCxD8vofyFqNalvXRBQZgx9gZ4x0DAquq0obhlAEFHddTmeW
         Loz1ZuchS0quSsRLELcG8rhU8pxiZJxYaO165uilvHF+A02AKKBm4UZs1j/+3risPDCw
         AuXygWBks+teEdgM/k5tlJsk4Ri/AzDhCkFN4xOJIUXax7f+otVYztbsGlIEoQ0bHDSr
         fzTB0DZN/sTP9AaKfRqBx7fTJfU8EK1BQ8upFpH+yLeNa/kK0VIdE5tgoCkicTGFnVA0
         LGObsSEUesvNzfC3iZrUfd1CzOmDJh8+Rq+YxtpUs5go5GbpW23fIo/yOU9DrdSO6YFQ
         UKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QU49IpXWY3ILYjrG9pprYmKd2girarG6kbSVlkmZXq4=;
        b=JNilvhHiF3rjtvlj6nP406lAmdsyTslxl1H3WiY0dYW5CDISJVT+bd72YlRwlCeKZ6
         VaVG26MM/sCtLqoFQHJTYyhysOXAlzx6qDCct9yfL5ooIxl7+rVLfnAvhSI7XFJuh8kd
         gma6AIaJ7jCVmkp2Of1chYyqfB9kdKPlbsm9N0IRjkSNxtEebeCiQA1fuHeq0S3PzgMI
         Ph0M1uEBZOn//T5BrPIDq3OzM5A5m1AR3RGcZIrZ2COmnJdEGIX+ljk/B41xEZEUuh/S
         XZ3PLnJFccwShYYasdi4+p8K4fg12KS7NeEE7luOfA6XFMyNvLBXLf9J1sh0BUKSluy1
         cJ3g==
X-Gm-Message-State: AOAM530mPPI/MKD65q6pvLz7BMAv+ugEGqXMfWAYTnlGhnJ4qky6xI4O
        aOybweLvsFdmlNeoE6sbOcvEa8pxWHJo/OI6tYGAXA==
X-Google-Smtp-Source: ABdhPJxEo6gFNLNscO7/ZgLV0QwPqEiaGItXCsWeFOnHsvuK0OOHvvT7zEaAuGJHZkw4CGOdImbbhBWl0Vj1Ie7MLSo=
X-Received: by 2002:a05:6902:13c2:b0:641:b6d:a151 with SMTP id
 y2-20020a05690213c200b006410b6da151mr10461624ybu.348.1653066571425; Fri, 20
 May 2022 10:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220520165826.2140252-1-keescook@chromium.org>
In-Reply-To: <20220520165826.2140252-1-keescook@chromium.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 20 May 2022 10:09:20 -0700
Message-ID: <CAJuCfpGqY4sidGe3XSTjJ-tt+5wsm0JTpmUa-hc8WgT9aRXXSQ@mail.gmail.com>
Subject: Re: [PATCH] sched/psi: Bounds-check state iterator against NR_PSI_STATES
To:     Kees Cook <keescook@chromium.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 9:58 AM Kees Cook <keescook@chromium.org> wrote:
>
> GCC 12 cannot tell that "t" will be bounded by NR_PSI_STATES, which could
> lead to walking off the end of the tasks array, which is NR_PSI_STATES in
> size. Explicitly bounds-check "t" as part of the loop.
>
> In file included from ../kernel/sched/build_utility.c:97:
> ../kernel/sched/psi.c: In function 'psi_group_change':
> ../kernel/sched/psi.c:730:38: warning: array subscript 32 is above array bounds of 'unsigned int[5]' [-Warray-bounds]
>   730 |                         groupc->tasks[t]++;
>       |                         ~~~~~~~~~~~~~^~~
> In file included from ../include/linux/psi.h:6,
>                  from ../kernel/sched/build_utility.c:36:
> ../include/linux/psi_types.h:84:22: note: while referencing 'tasks'
>    84 |         unsigned int tasks[NR_PSI_TASK_COUNTS];
>       |                      ^~~~~
> ../kernel/sched/psi.c:730:38: warning: array subscript 32 is above array bounds of 'unsigned int[5]' [-Warray-bounds]
>   730 |                         groupc->tasks[t]++;
>       |                         ~~~~~~~~~~~~~^~~
> ../include/linux/psi_types.h:84:22: note: while referencing 'tasks'
>    84 |         unsigned int tasks[NR_PSI_TASK_COUNTS];
>       |                      ^~~~~
>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index a337f3e35997..827f16a79936 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -725,7 +725,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
>                 }
>         }
>
> -       for (t = 0; set; set &= ~(1 << t), t++)
> +       for (t = 0; set && t < ARRAY_SIZE(groupc->tasks); set &= ~(1 << t), t++)
>                 if (set & (1 << t))
>                         groupc->tasks[t]++;
>
> --
> 2.32.0
>
