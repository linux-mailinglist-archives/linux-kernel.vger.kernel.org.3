Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971E64FB634
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343916AbiDKIls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343910AbiDKIln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:41:43 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A2D3D485
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:39:28 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id k36so4482088ybj.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9nJm17K/yud/Vja2i5nosF7JRnfY8vZ/WHIXKk9f6w=;
        b=QjG37G9hcBCKyJJPEueSmvuJ4kGecn9OdjK0F5aKlzodqMICJs2bJyRMuIEvtpWfm+
         ag/mGQx9OIiQQyEuximvaMdligXWgRdG5meye0AsQrnWqQawlmRca/NLtkeGps3VBRPE
         GqLxLxzz3gVd9K6ZGkM7mTTmwbbSX4AZVV+qAcYFfCyS+ELU4TzhKefl5HAJx/YnzJzP
         13NhTf9YXB62ISsZ13uuOxJgrMOJELQ2JCV4gs78L+IAA5r8g9462BhMZaK2DjVjRhqo
         ZSThhlkvMyq4FzQagerPBLr/RFk13GuscmRf4UjWsjCnXtBZhux2YsTskn46fugduT4D
         gMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9nJm17K/yud/Vja2i5nosF7JRnfY8vZ/WHIXKk9f6w=;
        b=JBK7J5Kb9lm745ZfS9KLal3cBa/mdnA5UrgCvyuqfkUbyZgp5UBPrJmvxZc9m+S0JA
         8UGZOr2HRH6Az26FlzBvweJzn1hKnbuj6mHfc1I0LlRFj9dA7dB5QupbKO9Z1pbVfHOZ
         AtpJxg+UyrgG7+HB75+WfMAN5jdz9ZEmy20fT86zlQcQAI4Csd1FI+REHJo2eSW0i94d
         H9QNKeutANqFKmRHkUG6o2+ZI6cyfaC+U4ofEOHv4V9NddC/CTNmdLcFTIy97x/CiPYI
         /EC+MgIs1H8DuPqk51XXZJeppnHIKjkqVm+uhmPl4vYTI0jyZvWreHUTvhMmgHwgt/vF
         Ko0A==
X-Gm-Message-State: AOAM531J3NKoORefivj/AJTgxmgyWVAfevExfIa7Gn35QRXsYkI6W2Fe
        4TvIl59oQA65sGeXAjQL1iWbPB9jH641PyMu+IoehA==
X-Google-Smtp-Source: ABdhPJxQukCB3C2RSIxVqw7saiBSI8LGmbDPS1ymWQyy9ZS8UYDHorULHehzgaFixVzrNwBrVJ4LCY/l/CbBTmcGgpo=
X-Received: by 2002:a25:d80a:0:b0:641:38dd:2f4c with SMTP id
 p10-20020a25d80a000000b0064138dd2f4cmr4717123ybg.225.1649666367294; Mon, 11
 Apr 2022 01:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220411061702.22978-1-kuyo.chang@mediatek.com>
In-Reply-To: <20220411061702.22978-1-kuyo.chang@mediatek.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 Apr 2022 10:39:16 +0200
Message-ID: <CAKfTPtAyhc-tAWXmXcHstmiBSMjj5GENizX__KRDab28NRum1A@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/pelt: Refine the enqueue_load_avg calculate method
To:     Kuyo Chang <kuyo.chang@mediatek.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 at 08:17, Kuyo Chang <kuyo.chang@mediatek.com> wrote:
>
> From: kuyo chang <kuyo.chang@mediatek.com>
>
> I meet the warning message at cfs_rq_is_decayed at below code.
>
> SCHED_WARN_ON(cfs_rq->avg.load_avg ||
>                     cfs_rq->avg.util_avg ||
>                     cfs_rq->avg.runnable_avg)
>
> Following is the calltrace.
>
> Call trace:
> __update_blocked_fair
> update_blocked_averages
> newidle_balance
> pick_next_task_fair
> __schedule
> schedule
> pipe_read
> vfs_read
> ksys_read
>
> After code analyzing and some debug messages, I found it exits a corner
> case at attach_entity_load_avg which will cause load_sum is zero and
> load_avg is not.
> Consider se_weight is 88761 according by sched_prio_to_weight table.
> And assume the get_pelt_divider() is 47742, se->avg.load_avg is 1.
> By the calculating for se->avg.load_sum as following will become zero
> as following.
> se->avg.load_sum =
>         div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
> se->avg.load_sum = 1*47742/88761 = 0.

The root problem is there, se->avg.load_sum must not be null if
se->avg.load_avg is not null because the correct relation between _avg
and _sum is:

load_avg = weight * load_sum / divider.

so the fix should be attach_entity_load_avg() and probably the below is enough

se->avg.load_sum = div_u64(se->avg.load_avg * se->avg.load_sum,
se_weight(se)) + 1;

>
> After enqueue_load_avg code as below.
> cfs_rq->avg.load_avg += se->avg.load_avg;
> cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
>
> Then the load_sum for cfs_rq will be 1 while the load_sum for cfs_rq is 0.
> So it will hit the warning message.
>
> After all, I refer the following commit patch to do the similar thing at
> enqueue_load_avg.
> sched/pelt: Relax the sync of load_sum with load_avg
>
> After long time testing, the kernel warning was gone and the system runs
> as well as before.
>
> Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
> ---
>  kernel/sched/fair.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..30d8b6dba249 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3074,8 +3074,10 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  static inline void
>  enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -       cfs_rq->avg.load_avg += se->avg.load_avg;
> -       cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
> +       add_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
> +       add_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_sum);
> +       cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
> +                                         cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
>  }
>
>  static inline void
> --
> 2.18.0
>
