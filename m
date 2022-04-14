Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7684A500716
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiDNHkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiDNHkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:40:17 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66C75620A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:37:51 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ebebe631ccso46744107b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2sEUdWYrr9ayBEuVJWBpv3UkoWU5IV5/Hq3UQC9Oqks=;
        b=naA6NBKsG/T3OEnLS6yYkSg1tHF33i6JVoono0ACrn6usn2OHiD89Z4512zT+q5uYO
         EfBWUetaEUbaQqO1vf55u8yAFl0zh1EKDUvnQK2y6xabfZpFANEg0RX7xxEBgiM7loYz
         CBdJc1lnpUaPIRWKhzKRxaMWkt9XKDT9rxNHOweP5XXjMy6p2CaK8cJA3tFFuG9uE9Wb
         zizY2pJ8bAJPcwylMUXjy53zsGBisz+BmC2rYeFwdmgNUhOE5w+EEt3dNj81uAVGcH0a
         /0DNj8H4wNtaPt7lyr4b+k1+B7lzy+CIfTeKvXmJ/JMc5lZjbaZAjI5OXG+wJYsRs3o9
         ubNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sEUdWYrr9ayBEuVJWBpv3UkoWU5IV5/Hq3UQC9Oqks=;
        b=DSEJ2Q3pNY0LT+oPhFtd2pjppBeWf3S8Rn39i+R3knrOW2tkcingbssADmXs9qVNOU
         2IpZa/EUt2pTqSDl3TLH556IRPkHi5MHfFHgNwCtXB8DMBfvgJbQ3rMtxX4jPOyQZenN
         25kOQ2CAYYhP0rPD+F5AIfBVq8dTVBLR75Z1pGpcoDoLstbT8lMODWfzDAMhqXBkE1Yx
         KiK5y/9s3ny0M90D3f47/VwPv6g5s3L9GzYG1HuO+5J+01Rxhfav18JKkiqqIkYLKXjk
         as78nGhxLmmLTQmEY+D6qJ+deSHkJfutERvvJD+t/3u6rE+nlml6R0zaSWyUTnSabOK9
         0Law==
X-Gm-Message-State: AOAM533Xxc3un8AxYhPLkTfJ4Am2F8yvorak8T/OT5sScyTyZuzNGMCO
        BlXNeP0bZXzdwPq5hf8FeG412vTjeHrYoaXTaj8jjg==
X-Google-Smtp-Source: ABdhPJyFMz2V/+P0cegLwco6lv2a7DNKoC8L3DEBpqC8kwi8ZXyMTVyJgIH1+lySoP+mMQHK7rKlEQsbjyOY/ITTS84=
X-Received: by 2002:a81:db52:0:b0:2e6:b428:f541 with SMTP id
 b18-20020a81db52000000b002e6b428f541mr1032097ywn.359.1649921870910; Thu, 14
 Apr 2022 00:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220414015940.9537-1-kuyo.chang@mediatek.com>
In-Reply-To: <20220414015940.9537-1-kuyo.chang@mediatek.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Apr 2022 09:37:39 +0200
Message-ID: <CAKfTPtBn-9WWcA3=e0etbq_6cP5O6TXNqZ1B5=2SPe-yaC+PxQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] [PATCH v2]sched/pelt: Refine the enqueue_load_avg
 calculate method
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

On Thu, 14 Apr 2022 at 03:59, Kuyo Chang <kuyo.chang@mediatek.com> wrote:
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
> case at attach_entity_load_avg which will cause load_sum is null but
> load_avg is not.
> Consider se_weight is 88761 according by sched_prio_to_weight table.
> And assume the get_pelt_divider() is 47742, se->avg.load_avg is 1.
> By the calculating for se->avg.load_sum as following will become zero
> as following.
> se->avg.load_sum =
>         div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
> se->avg.load_sum = 1*47742/88761 = 0.
>
> After enqueue_load_avg code as below.
> cfs_rq->avg.load_avg += se->avg.load_avg;
> cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
>
> Then the load_sum for cfs_rq will be 1 while the load_sum for cfs_rq is 0.
> So it will hit the warning message.
>
> In order to fix the corner case, make sure the se->load_avg|sum is correct
> before enqueue_load_avg.
>
> After long time testing, the kernel warning was gone and the system runs
> as well as before.

This needs a fix tag:
Fixes: f207934fb79d ("sched/fair: Align PELT windows between cfs_rq and its se")

>
> Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>
> v1->v2:
>
> (1)Thanks for suggestion from Peter Zijlstra & Vincent Guittot.
> (2)By suggestion from Vincent Guittot,
> rework the se->load_sum calculation method for fix the corner case,
> make sure the se->load_avg|sum is correct before enqueue_load_avg.
> (3)Rework changlog.
>
>  kernel/sched/fair.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..159274482c4e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3829,10 +3829,12 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>
>         se->avg.runnable_sum = se->avg.runnable_avg * divider;
>
> -       se->avg.load_sum = divider;
> -       if (se_weight(se)) {
> +       se->avg.load_sum = se->avg.load_avg * divider;
> +       if (se_weight(se) < se->avg.load_sum) {
>                 se->avg.load_sum =
> -                       div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
> +                       div_u64(se->avg.load_sum, se_weight(se));
> +       } else {
> +               se->avg.load_sum = 1;
>         }
>
>         enqueue_load_avg(cfs_rq, se);
> --
> 2.18.0
>
