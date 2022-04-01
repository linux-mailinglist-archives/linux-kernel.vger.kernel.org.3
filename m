Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3A4EEDDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbiDANMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346199AbiDANMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:12:05 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706984F9D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:10:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 5so4887502lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwPRrwecdoFviBYk3z2czJVnElCA5iLcaTmf1cxWb3Q=;
        b=J0kI1TPWiUfbDcU6INtuF44yG+6+VYb4YwWejocR0pfR/1QhMBaijCR5nATHp533D+
         48bol6xx9ygzxo/MMy/TtBM4S4uHPqLeZvRg+bNzlpEPEnIZas4koX/ZIctfO4qWmc80
         xUTPSnq87gkvMU7Fz8941ucjfq5w7QvVdqoG5fAmKKLtiKC8WKpwzjkR4uMVMUGoIC2f
         o12iIc2UYEJV8gBVu4V/6nOiFJqH6Wmo2e+DGVEPDh4BHqYpWU04H+yxt7fEDAY4xhso
         o5Ev0Be64G6QeSlI/VKB5/1F6n7GHgfA6Yo2S9Btx3LZnuaZaZhw+IKeapTQc3LkM9z0
         DqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwPRrwecdoFviBYk3z2czJVnElCA5iLcaTmf1cxWb3Q=;
        b=0E6iGqSPPIzNUBDQpKxjabO1RruwoNeSH9pfWkD0z9b7qLKymMeTx7kikvcR/G6Mhp
         9TX6IRkHlcwh/4iWdHNPKJIHrA+u8oLu2DCdWjjRm7y14baQWHsipivXvnNRnliHR2Z9
         LD5g/EQTYbEPZheWb14dQvGlNnpmvavHepnPKRdbZuOiv9dHUeh+3Xv8Xh0jeAVvE86j
         NclM5aj2Qc9mCHi4Qrr5ZhTn1I4faShGnTpcwxWs+d5/YV0ehPbPt7NWhjh6qJTJR0o5
         KDtLPvGEw5bjlulsn0whhje0bSlF1hesfFtyre+oLt6Z5MldE/r/V0XE+sft8cFG9gw2
         Zmcg==
X-Gm-Message-State: AOAM53154H/8RhEVGY/pIfuwKyWRyxpgyyMchQnik69WEdjxEVr5VpbF
        prxgSqN1ijIO6j/CmOE9wl21ztgUXgC3khBzytJWhQ==
X-Google-Smtp-Source: ABdhPJxUg5k+Cr6DFSPnYsg8v9GaeKdFP9j73DSS0ooOrACZdveWSjU7IuyYjHjCZ60K/ylc2e7Vk2AGRUyseOZDQIA=
X-Received: by 2002:a19:ac42:0:b0:448:1f15:4b18 with SMTP id
 r2-20020a19ac42000000b004481f154b18mr14075861lfc.32.1648818613358; Fri, 01
 Apr 2022 06:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220401091127.3234638-1-zhangsong34@huawei.com>
In-Reply-To: <20220401091127.3234638-1-zhangsong34@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 1 Apr 2022 15:09:59 +0200
Message-ID: <CAKfTPtCNLELdiQXCdbxrXotqCkRV-2mKK7uVXQv---mbnekaUQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Allow non-idle task to preempt idle task directly
To:     zhangsong <zhangsong34@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        zhangsong <zhangsong34@gmail.com>
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

On Fri, 1 Apr 2022 at 11:13, zhangsong <zhangsong34@huawei.com> wrote:
>
> From: zhangsong <zhangsong34@gmail.com>
>
> In check_preempt_tick(), the sched idle task may exectue at least
> `sysctl_sched_min_granularity` time but any other cfs tasks cannot
> preempt it. So it is nessesary to ignore the `sysctl_sched_min_granularity`
> resctriction for sched idle task preemption.

Could you explain why you need to remove this condition for sched_idle ?
sched_idle tasks are already preempted at wakeup by others. And they
run while others are runnable only if they has not run for a very long
time compares to other. The ideal_runtime of a sched_idle task is
capped to 750us min to ensure a minimum progress. But this will happen
not more than once  every 256ms and most probably even less often.

>
> Signed-off-by: zhangsong <zhangsong34@gmail.com>
> ---
>  kernel/sched/fair.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d6..edcb33440 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4477,6 +4477,15 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>         struct sched_entity *se;
>         s64 delta;
>
> +       se = __pick_first_entity(cfs_rq);
> +
> +       if ((cfs_rq->last && se_is_idle(cfs_rq->last) - se_is_idle(curr) < 0) ||
> +           (cfs_rq->next && se_is_idle(cfs_rq->last) - se_is_idle(curr) < 0) ||
> +           se_is_idle(se) - se_is_idle(curr) < 0) {
> +               resched_curr(rq_of(cfs_rq));
> +               return;

Why all these complex conditions ?
if (se_is_idle(curr)) should be enough


> +       }
> +
>         ideal_runtime = sched_slice(cfs_rq, curr);
>         delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
>         if (delta_exec > ideal_runtime) {
> @@ -4497,7 +4506,6 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>         if (delta_exec < sysctl_sched_min_granularity)
>                 return;
>
> -       se = __pick_first_entity(cfs_rq);
>         delta = curr->vruntime - se->vruntime;
>
>         if (delta < 0)
> --
> 2.27.0
>
