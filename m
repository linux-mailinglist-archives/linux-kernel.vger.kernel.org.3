Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5364F6710
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiDFRXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbiDFRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:23:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502AF140DF3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:22:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so4678055lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTfG28cRodiq/+2LJPZqP5fNSiZIDmn4jveiK6bxlps=;
        b=XI8nDaN0YTRRNOuuWDmD8ZTIYZbINFcKXcZ1ur9Xcei88v3/EKSmM8tCwJMOQ3TfmC
         RyeuZDtXfUgVT55tcrcFqV3NaqcLriA2zG0gxqu+y7xA9c1+M3ZfRdh+SozpG5YadYWX
         +05bbdM9jD1n3FYWXPjTNyFW2xjzqT+etMHWvHo60SOBQ85ceGIF1aT6EChLR0EPZjVi
         hwnMsa00bl0U5Ar0ZNXYxFjTqQbOai5YDm6RsOVUbH9+EMA8zKTxk6QDKrI4psvh9OT0
         tdtFHR7UCohyPOfPRX+srh53WrkZpWZFdvOlvYzO0pjU5a0DR42aYRKl3AyoYIn6SeHe
         VrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTfG28cRodiq/+2LJPZqP5fNSiZIDmn4jveiK6bxlps=;
        b=WTqSIwKdWrXp/4ttou+XI4MmDEPFrtk3l8K2jwOOkJX8CqJE5Wkr2I6WWEiB3vrAYq
         vAI5nuze9tDfxHNbsRTpdy566WI90KGLR64DhBy69WnfWES6lqV3y1Bz8mXWIZJjUTTe
         DfiPEjM11BvaRbd4wCDCCgbKz4xkk2c/OfiAB/2Fvh3A4exkuDoZYb/VikmwAEOp+jN0
         UVsQTjcTEEUrpzxhXN/uwKEo3o3rwIFRPvVohU9HOeyrukQ5KhwJurI/a7cYOQD5lmsc
         s9b3UOrML0f2dHalH76zs+2QLvV4Y1QXHChzkgj/P36eP/nWdxq6snPc6HMmECAioY8D
         LqEQ==
X-Gm-Message-State: AOAM531cuHu8P8DeBqLTDbNxXRls8s8QjuamNn6sOPEqunkh0GBnT6yZ
        IDLqS2m/UwvvGoXKAgfA6DSx1wnf8alcNqKPlp1GyA==
X-Google-Smtp-Source: ABdhPJzsC6htLHc6A2/+kZT4bQJxCHdpcaZojKgrHPwgl3D8qEq+Zb8UlKmQKu0ryToG3Gwrpq9AfLEiPzDPsf9WPqY=
X-Received: by 2002:ac2:5f19:0:b0:44a:f3de:58bd with SMTP id
 25-20020ac25f19000000b0044af3de58bdmr6480353lfq.645.1649258530121; Wed, 06
 Apr 2022 08:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <1649239025-10010-1-git-send-email-zgpeng@tencent.com>
In-Reply-To: <1649239025-10010-1-git-send-email-zgpeng@tencent.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Apr 2022 17:21:58 +0200
Message-ID: <CAKfTPtCv=pBDsvWDguFXtf_YZDf2Yx+xrpc3hDevQFz6BoadJA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Move calculate of avg_load to a better location
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

On Wed, 6 Apr 2022 at 11:57, zgpeng <zgpeng.linux@gmail.com> wrote:
>
> In calculate_imbalance function, when the value of local->avg_load is
> greater than or equal to busiest->avg_load, the calculated sds->avg_load is
> not used. So this calculation can be placed in a more appropriate position.
>
> Signed-off-by: zgpeng <zgpeng@tencent.com>
> Reviewed-by: Samuel Liao <samuelliao@tencent.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299..601f8bd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9460,8 +9460,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>                 local->avg_load = (local->group_load * SCHED_CAPACITY_SCALE) /
>                                   local->group_capacity;
>
> -               sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
> -                               sds->total_capacity;
>                 /*
>                  * If the local group is more loaded than the selected
>                  * busiest group don't try to pull any tasks.
> @@ -9470,6 +9468,9 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>                         env->imbalance = 0;
>                         return;
>                 }
> +
> +               sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
> +                               sds->total_capacity;
>         }
>
>         /*
> --
> 2.9.5
>
