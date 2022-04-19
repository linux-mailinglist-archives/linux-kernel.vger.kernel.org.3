Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D97450667F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbiDSIKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiDSIKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:10:20 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D988F1CB3E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:07:38 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ec42eae76bso163487977b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/yGTP55Q3zKCVvsyO3pqJukwATC0ZlhhZ8VlgwH+4k=;
        b=EbTRqHc1mXW90UbzM8S7dYlhr+0BJPriQ+S21B43cirXEp/VJSmlbSXCOXZKx3Dzcr
         j6d9U8wdry+aNeouRvOjrhmUUg3pFjONHC6FKMSYuvEtu4BXu/GbJXBGObsh7cGxbUil
         ETv0TamHTr+5q36Et0DOeEcKa60j//TcTrvGGA449/Uux3f+kZSFyOLaVKnJJUYSiFsA
         AIRGlJHkj4QKJVBEhQ48qtYATWdV/J4txXbnGLCYN0g6MifNXRlf64kOQaqDN+P3b55m
         Psjys5DhYpS9DbA8KrdB0kCNV3tZlQkx2ojHJWzESgShiPPQwjrP/mAANcoTex6npkPH
         Yhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/yGTP55Q3zKCVvsyO3pqJukwATC0ZlhhZ8VlgwH+4k=;
        b=6TG1/cMWZkDbDu/pzgyy3upx5bz2SiJxfbeV6nQpI2Dku9TTxpf7XiGC+wqOeJoGjS
         haKNrqX18Fxy9xaweWjoyUbwBhJ5V4C3YIIfJhBJ1fizLcks3BbTC2gIda0VMdGbqxaH
         A98z2ty1WY6F1pPgCQ7ThPE5CZgKDkSQi1djTut3XiVxpusMR8kU1WteDseAAgfsJG6t
         MjQqlPRQ1Oq/KfaZDYO74sBfUza57yNCty1kCHvn25uqbGUFykC+SRQMNWe0YLDTGhrB
         RwH3P653G7cm6fmqmHgiEpX3kIoYqap4aMQDHASh8AhgSbJb+vO/FeZojtAzyKfHqs7h
         pT9Q==
X-Gm-Message-State: AOAM530SxGmwDYxi3JcEEu8wVpiabqtXvdeKF9ucA6CYNmNEjqcMMvWA
        Xie1Jmg1jYmtRBMS3BFE1R7Mah8JuK0O7BSg8ImkQg==
X-Google-Smtp-Source: ABdhPJwEllwA44WDjgjPJKdDmac4B8OtWyYwezegrfIbwxZq2N35xvB3EfXfA7s5o+0sSU6+DmdsJi36Wel7eiNLDoI=
X-Received: by 2002:a81:6189:0:b0:2eb:deb5:9f63 with SMTP id
 v131-20020a816189000000b002ebdeb59f63mr13358223ywb.319.1650355658062; Tue, 19
 Apr 2022 01:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <1649566716-24687-1-git-send-email-zgpeng@tencent.com>
In-Reply-To: <1649566716-24687-1-git-send-email-zgpeng@tencent.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 Apr 2022 10:07:26 +0200
Message-ID: <CAKfTPtDXhAr7tweb6pjUAaSfKaHH3q=CYiGXgEbSoQzewg_dfw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix the scene where group's imbalance is set incorrectly
To:     zgpeng <zgpeng.linux@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
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

On Sun, 10 Apr 2022 at 06:58, zgpeng <zgpeng.linux@gmail.com> wrote:
>
> In the load_balance function, if the balance fails due to
> affinity,then parent group's imbalance will be set to 1.
> However, there will be a scene where balance is achieved,
> but the imbalance flag is still set to 1, which needs to
> be fixed.
>
> The specific trigger scenarios are as follows. In the
> load_balance function, the first loop picks out the busiest
> cpu. During the process of pulling the process from the
> busiest cpu, it is found that all tasks cannot be run on the
> DST cpu. At this time, both LBF_SOME_PINNED andLBF_ALL_PINNED
> of env.flags are set. Because balance fails and LBF_SOME_PINNED

shouldn't LBF_DST_PINNED and dst_cpu have been set ?
and goto more_balance should clear env.imbalance before we set group's
imbalance ?

> is set, the parent group's mbalance flag will be set to 1. At
> the same time, because LBF_ALL_PINNED is set, it will re-enter
> the second cycle to select another busiest cpu to pull the process.
> Because the busiest CPU has changed, the process can be pulled to
> DST cpu, so it is possible to reach a balance state.

The new load_balance will be done without the previous busiest cpu

>
> But at this time, the parent group's imbalance flag is not set
> correctly again. As a result, the load balance is successfully
> achieved, but the parent group's imbalance flag is incorrectly
> set to 1. In this case, the upper-layer load balance will
> erroneously select this domain as the busiest group, thereby
> breaking the balance.
>
> Signed-off-by: zgpeng <zgpeng@tencent.com>
> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299..e137917 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10019,13 +10019,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                 }
>
>                 /*
> -                * We failed to reach balance because of affinity.
> +                * According to balance status, set group_imbalance correctly.
>                  */
>                 if (sd_parent) {
>                         int *group_imbalance = &sd_parent->groups->sgc->imbalance;
>
> -                       if ((env.flags & LBF_SOME_PINNED) && env.imbalance > 0)
> -                               *group_imbalance = 1;
> +                       if (env.flags & LBF_SOME_PINNED)
> +                               *group_imbalance = env.imbalance > 0 ? 1 : 0;
>                 }
>
>                 /* All tasks on this runqueue were pinned by CPU affinity */
> --
> 2.9.5
>
