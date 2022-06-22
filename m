Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18440554EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359281AbiFVPUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359265AbiFVPUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:20:31 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444E83DDFA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:20:30 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id e4so18089980ybq.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JeQ8TThR2mZAe9jpBHrbZUuk87btCITY/aOirkiHw+c=;
        b=nUSIYZVdQfBuv1tjcVMKmGCtOWCU9/twTvr5RrtCWVCwSbvc5/+Eyuq3Y7AHV9H9za
         D8h54HN0AETi69owjF7iNekID3cPH5p5JIYuououxlYe78/uESEUWJWMUl729cS+QAMV
         qJHigTzaF0DoXcRCPvcf3MqHE/Qg7Mx8Tty1+gbUAV68HdoDFEVgxWe4lkbReRjkuEbd
         pFVL5DnViLWh3NLqqUOCVYUyrRSyJ4HxSPjuUcwIzPu86MECoVjgUPJBzjiHXQLoFG+j
         9uHwqCSj1Cy4anF/KNejoeKeh3euDursyU6PD7ZE6wkm19rJqUHtM+pX6E8rZcjMjn4X
         xd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JeQ8TThR2mZAe9jpBHrbZUuk87btCITY/aOirkiHw+c=;
        b=rrVIYNQfE/v2+h+dWxmxGkFphkifR2tjfoCFP2HFtN5Wo2mKm6BUFnnaCde+bFos+Q
         KKdAn6+sh3zuL/t5ruBCDIskcaKhrceDUzwyMn4WWCpu2fABfqOObNb7jou71a3ig3ri
         EYayRNsHV3IGb+Xxi1LpAPH0N2TFzB2GT28NC3JDMPin0Rzzv6GiJflPnSmNSucX+v2y
         6AkNcPseWOhjEYajNv5YXjfqg6B/MWzYHeIFpKIm1XMkR7b2M0/khHIenWp+Il25ghzn
         +MPoNx71uBC6gI1vOTx+VmwFyo1Jn6hxpyNki5tPyJfKdWiO9lVr8VJBoA8dUowg0R85
         zHCQ==
X-Gm-Message-State: AJIora87/pSzLzkEx+jU9T4xPfIK5LTSZ4jh1ECZjC8OSAR0uID5YfZz
        H2Pb5n+pGnrH/nh+nG9HKD3s3N0M8bZzVfVTn8YEGA==
X-Google-Smtp-Source: AGRyM1ukd98Td+Hb9qjnJFCG8IGR9WXac8/ow/ejM6xLsQFRxGSjnVRqO5VVkQl1POr9+I2Co0U1hhxYwdyvsYcm6d8=
X-Received: by 2002:a25:2b03:0:b0:664:271f:924 with SMTP id
 r3-20020a252b03000000b00664271f0924mr4479296ybr.211.1655911229355; Wed, 22
 Jun 2022 08:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220621154530.GA29721@pc>
In-Reply-To: <20220621154530.GA29721@pc>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Jun 2022 17:20:18 +0200
Message-ID: <CAKfTPtCgbtKkjA+tU2DFJgKAsXV+kFKipMxTuReaT5QKNvvAGA@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: simplify load_sum assignment code in attach_entity_load_avg()
To:     Zhaoyu Liu <zackary.liu.pro@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        kuyo.chang@mediatek.com, linux-kernel@vger.kernel.org
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

On Tue, 21 Jun 2022 at 17:45, Zhaoyu Liu <zackary.liu.pro@gmail.com> wrote:
>
> In commit 40f5aa4c5eae ("sched/pelt: Fix attach_entity_load_avg() corner case"),
> these code was committed:
>         if (se_weight(se) < se->avg.load_sum)
>                 se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se));
>         else
>                 se->avg.load_sum = 1;
>
> they could be replace with:
>         se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se)) ?: 1;
>
> to make the code cleaner.

This quite subjective as I consider current version cleaner than your proposal

>
> Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
> ---
>  kernel/sched/fair.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 78795a997d9c..ed32f66bbd3d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3881,10 +3881,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>         se->avg.runnable_sum = se->avg.runnable_avg * divider;
>
>         se->avg.load_sum = se->avg.load_avg * divider;
> -       if (se_weight(se) < se->avg.load_sum)
> -               se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se));
> -       else
> -               se->avg.load_sum = 1;
> +       se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se)) ?: 1;
>
>         enqueue_load_avg(cfs_rq, se);
>         cfs_rq->avg.util_avg += se->avg.util_avg;
> --
> 2.17.1
>
