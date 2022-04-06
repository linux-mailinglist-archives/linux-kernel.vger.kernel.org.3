Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531854F674F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiDFRfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbiDFRex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:34:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4EF1F6BE7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:41:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d5so4758454lfj.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIVsdQsPt2lxmnjdpo863Zg6K+OImetGpesYpOQLQrY=;
        b=miXKVMm0bdpNo8et8CZm7eD33XHm+hRGYT5aUy/TjlYtIbm8+mQgqEB71S4VfHGLU5
         4BrZqQae+7jH7cSgOVqtH4rAJA6AtEycG5yWt/1K8hOBGtWcv6af58Fny759ak3zTWcx
         st/uFU6mUpXZ2yldbatFSNSGeQbjjuTWR7uNA/JWuxH0U3ZM5xD1KodgyJTd4koONW53
         QTzflRlgvGq0UaFb4ufnA6wOAUW0aqelgom78FQOXlMjNsKK11QbYgD3VxAvw9D7SCgW
         sPBeiuza/3cB9IstHe+dlqqOjawFexBxrJDnSJSqCaggD9GQX/PTm4RkKjVmc8CgP2FM
         z5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIVsdQsPt2lxmnjdpo863Zg6K+OImetGpesYpOQLQrY=;
        b=lJImb9Y7keCmJA9AtZLi5MdHEUApArS0JxOmvAmWukjbSL0kJThL0SYVhTXZ2M/3HD
         3LjZeObT3Ek6ze0m2Scjh6HbgixRH3GwIqq9ypNSlwlPG/n4rlBP2A7AobV3u5+dFaMo
         12qKBeu2D7tufmTIM60wgPqhcm/Xx/12qrdn1AQDCaAfFKVUkWdonUfvLnPg8iYd+vko
         yuol39iyNOfmyOrT6RFBMSXvtzbRHm8qLw8goWxo9l6Mo/VbvUg+Pqr9re8WffP9Iy9t
         g/CxYshaljnPM0HR24R7bJbhgU1it2lJctMXReVYGIaoy++XwxxbEkJrMtSg1oiJ8zCr
         Hiwg==
X-Gm-Message-State: AOAM533/LtOsOyya+c+2cJNfri8BMOuXQTTs52V7hgbO9LmCwaRCBs5j
        RBwcOyiA4NBE2HKCYhX9c0aVGgjFfQ70IVGqkbovPA==
X-Google-Smtp-Source: ABdhPJxcJUN8YmcY60C5+lVqseVI93O5+3mb5MF+QKmQFOUn2PLcEHssbp2CqD/3x1eZBKiCg9zFAUEoMy0CxpVXUqk=
X-Received: by 2002:a05:6512:250:b0:44a:47c6:96a7 with SMTP id
 b16-20020a056512025000b0044a47c696a7mr6136832lfo.46.1649259712451; Wed, 06
 Apr 2022 08:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <1649245580-27256-1-git-send-email-zgpeng@tencent.com>
In-Reply-To: <1649245580-27256-1-git-send-email-zgpeng@tencent.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Apr 2022 17:41:41 +0200
Message-ID: <CAKfTPtDCXP8pt=F563sovxXJr-ALFuxNtE+1gWL-s7A-h4waew@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Simplify the scene where both local and
 busiest are group_fully_busy
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

On Wed, 6 Apr 2022 at 13:46, zgpeng <zgpeng.linux@gmail.com> wrote:
>
> When both local and busiest group are group_fully_busy type, because
> the avg_load of the group of type group_fully_busy is not calculated, the
> avg_load value is equal to 0. In this case, load balancing will not actually
> done, because after a series of calculations in the calculate_imbalance, it
> will be considered that load balance is not required. Therefore,it is not
> necessary to enter calculate_imbalance to do some useless work.
>
> Signed-off-by: zgpeng <zgpeng@tencent.com>
> Reviewed-by: Samuel Liao <samuelliao@tencent.com>
> ---
>  kernel/sched/fair.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9f75303..cc1d6c4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9634,6 +9634,18 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>                          * busiest doesn't have any tasks waiting to run
>                          */
>                         goto out_balanced;
> +

We are there because both local and busiest are not overloaded, local
is idle or newly_idle and there might be an opportunity to pull a
waiting task on local to use this local cpu. I wonder if we should not
cover this opportunity in calculate_imbalance instead of skipping it

> +               if (local->group_type == group_fully_busy)
> +                       /*
> +                        * If local group is group_fully_busy, the code goes here,
> +                        * the type of busiest group must also be group_fully_busy.
> +                        * Because the avg_load of the group_fully_busy type is not
> +                        * calculated at present, it is actually equal to 0. In this
> +                        * scenario, load balance is not performed. therefore, it can
> +                        * be returned directly here, and there is no need to do some
> +                        * useless work in calculate_imbalance.
> +                        */
> +                       goto out_balanced;
>         }
>
>  force_balance:
> --
> 2.9.5
>
