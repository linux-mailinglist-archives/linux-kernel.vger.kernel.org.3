Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2C4F63CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiDFPnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiDFPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:42:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471A0383A31
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:59:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k21so3964133lfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYXa8PFombRep9engE5rxdSOyyjwdVOdpF8aMt9fJa4=;
        b=M59yDwO2o4yzklFtm1AMD2UQOlXvO3HNwryTxlWbl7F02YmLU8T5zlClxUwOc2LvWU
         mTtElYRwMaTfqO1YKDeXCg3rxMzLc+MnJYO0fd5NDA9oko+X+n1IcXHnWIxXhTayWSLK
         am2xSnSC1UAkXkUFu/IO2iBZKUEjC719BEFcq+JxjP0iJjn04b5tPrXsBhtvn/Po6RxZ
         qfjJiJQCkcfyiDANBAH1RxIp52GBWosM9qR78rDD6C33D/MkmSNb2JcBiLzPpTamqfyU
         L1jgRJnQ/5RBYofUF5ZuF0PLgUSNuEY0Jqb1NNrPYLSSivPFLTQU0VfaR+QNpd2dW9Xs
         NBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYXa8PFombRep9engE5rxdSOyyjwdVOdpF8aMt9fJa4=;
        b=vhCoqKXH+dghoxd8u1I4jfLN1eaFfAggYJ/KEH4EZ19MWx5UuXU6DSQwTC0r/U5Sl7
         7JlofAA943F8kU0cyLHa+Hqhe2IDXv1qJayJc8ZUiWrZM4qjRPTdD5lc2tHDkjZpO3yJ
         jsza4eDG+c8hXOxEGdX3vtBB10h6NwnD5SSmZ0G3zXyaorkpOmY2AtvowyHhek/0X6/M
         TbKlQpgCrG/i5jmLZsniC7zUFkIhMe4+3UlAu/EVboSqvZoVbcROgOk2/t9xfY8dZNin
         StX7ez51U8mI0Sx1loSSIo+xqxXnrnnkE0/iDL3rlkTD5e4zpZ8q/vRQ+h3rYNFh/KZO
         9UUg==
X-Gm-Message-State: AOAM531Q0xot2K/1MEQ1WeUCVHyZvp5L7ZMndFKtgwYSV9/jrCyXF4r7
        aL7fAnRrmGUCsihi36/bdrVY2m3YUikNpNfHDxa56g==
X-Google-Smtp-Source: ABdhPJw48YGXp2udx4i6v8NHf4/QDTBgScbw2w19gAG/EarGScJwWfKy9eKhX0mne5GSqPHsxp0AIQIYSEtf4+WPRsA=
X-Received: by 2002:a05:6512:3f86:b0:44a:f5bf:ec9a with SMTP id
 x6-20020a0565123f8600b0044af5bfec9amr5958675lfa.490.1649249956530; Wed, 06
 Apr 2022 05:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <1649244204-23471-1-git-send-email-zgpeng@tencent.com>
In-Reply-To: <1649244204-23471-1-git-send-email-zgpeng@tencent.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Apr 2022 14:59:05 +0200
Message-ID: <CAKfTPtDh7qFpdjsEBvT34WEgW8uGbdwsZnyXjq4KpAcOse9Pew@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Return the busiest group only if imbalance is meaningful
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

On Wed, 6 Apr 2022 at 13:23, zgpeng <zgpeng.linux@gmail.com> wrote:
>
> When calculate_imbalance function calculate the imbalance, it may
> actually get a negative number. In this case, it is meaningless to

We should not return a negative imbalance but I suppose this can
happen when we are using the avg_load metrics to calculate imbalance.
Have you faced a use case where imbalance is negative ?

> return the so-called busiest group and continue to search for the
> busiest cpu later. Therefore, only when the imbalance is greater
> than 0 should return the busiest group, otherwise return NULL.
>
> Signed-off-by: zgpeng <zgpeng@tencent.com>
> Reviewed-by: Samuel Liao <samuelliao@tencent.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 601f8bd..9f75303 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9639,7 +9639,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  force_balance:
>         /* Looks like there is an imbalance. Compute it */
>         calculate_imbalance(env, &sds);
> -       return env->imbalance ? sds.busiest : NULL;
> +       return env->imbalance > 0 ? sds.busiest : NULL;
>
>  out_balanced:
>         env->imbalance = 0;
> --
> 2.9.5
>
