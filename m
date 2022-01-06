Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BACA48641A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbiAFMDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiAFMDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:03:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA79C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 04:03:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t26so4327083wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 04:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npqnSRFaqTG8o+cxUeN3GZfyCv3xZD6P4Yk0HwVV8bQ=;
        b=KE4Xp00e/JzUe50/FTAnwwVdW+9ao6IQv2wjaX8p+tQbSpU4z4UnH6POGxtRjDKLkp
         DNjYATk++cxEC577Zm3WjP7H5QBZQaHXsYhMUHIVT/IZQfIXrb8ylvU5by0S0bnQJEa7
         19IjpJxYk2SHvEI5m0MtvAHHD1etKI0lGxC1rGlTzG3UIPwp/hEtCxYVNtrqCGLW4Lhs
         26LM8nCOc/LpqB1JN1YcnBYiE6pJzOhWWVxJUBV6TF0fUCcIG0uuKVSCMOFpz4GUkvVi
         M6fef0qm+bjS4n5Oob80i2R+5Ly2lpcDFweciXMLWqrutz2zbA7MpMgUiu5zIRUpVW7e
         u37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npqnSRFaqTG8o+cxUeN3GZfyCv3xZD6P4Yk0HwVV8bQ=;
        b=X0FW5zchIwY+O/ML+x/cP2lYiHjecQypysBtRi4tIz0++60JdusUDbcUbQiUgNZtxT
         SyW6jdMcyG6pzl7VM+YbGboqQaQXdJwalUrM42oIO+adtMDBnKGL2tTUZ326NFrRVJzN
         KjgU3RoCpudjcBOWfCryjvXc6WDTUx4ge6JK7JwMnDCpMxEnc1/BA/S2pSRKGHTpPfym
         Zi7quYCwabTgeeF4Vh4wx3p/GP0azl5//AO9eXaXtGX3ijLh5RvzdJ83+ssEVnyhH1+c
         3qYgNnbiItwE73fceoHjjAQ5XdhIvn85GXgkFjMPPdOjq5tbtapuziVrJcTW2AofGpsY
         rY4A==
X-Gm-Message-State: AOAM532gRELhGe4qDy/TzGvePhLba7ZoorG089lyUaDJVTwuvkri07XR
        /yqTFuT3q0q6N4TJdHKEoQoNy9EuzMJ+CWyMY38=
X-Google-Smtp-Source: ABdhPJyBOyB7PdKBHGSsXV4wwFxJBkvHHrU7Rz8Cv5j+BgIyvaW8RjMtw06EmnHNLgokIw1a6YHuBW3stkzyrMVouN8=
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr38717983wrw.216.1641470625631;
 Thu, 06 Jan 2022 04:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20220102033129.12913-1-skseofh@gmail.com> <20220106094650.GX3366@techsingularity.net>
In-Reply-To: <20220106094650.GX3366@techsingularity.net>
From:   DaeRo Lee <skseofh@gmail.com>
Date:   Thu, 6 Jan 2022 21:03:34 +0900
Message-ID: <CAATEi5=Cmt__5mQLcis5dO9ncc5nyQgiGD22UXtLsgJH5ZbwkA@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan.c: no need to double-check if free pages are
 under high-watermark
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -4355,7 +4355,7 @@ static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
> >  static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
> >                               unsigned int highest_zoneidx)
> >  {
> > -     long remaining = 0;
> > +     long remaining = ~0;
> >       DEFINE_WAIT(wait);
> >
> >       if (freezing(current) || kthread_should_stop())
>
> While this does avoid calling prepare_kswapd_sleep() twice if the pgdat
> is balanced on the first try, it then does not restore the vmstat
> thresholds and doesn't call schedul() for kswapd to go to sleep.

I intended not to call prepare_kswapd_sleep() twice when the pgdat is NOT
balanced on the first try:)

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 700434db5735..40784693c840 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4355,7 +4355,8 @@ static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
>  static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
>                                 unsigned int highest_zoneidx)
>  {
> -       long remaining = 0;
> +       long remaining;
> +       bool balanced;
>         DEFINE_WAIT(wait);
>
>         if (freezing(current) || kthread_should_stop())
> @@ -4370,7 +4371,8 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
>          * eligible zone balanced that it's also unlikely that compaction will
>          * succeed.
>          */
> -       if (prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
> +       balanced = prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx);
> +       if (balanced) {
>                 /*
>                  * Compaction records what page blocks it recently failed to
>                  * isolate pages from and skips them in the future scanning.
> @@ -4387,6 +4389,10 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
>
>                 remaining = schedule_timeout(HZ/10);
>
> +               /* Is pgdat balanced after a short sleep? */
> +               balanced = prepare_kswapd_sleep(pgdat, reclaim_order,
> +                                                       highest_zoneidx);
> +
>                 /*
>                  * If woken prematurely then reset kswapd_highest_zoneidx and
>                  * order. The values will either be from a wakeup request or
> @@ -4406,11 +4412,11 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
>         }
>
>         /*
> -        * After a short sleep, check if it was a premature sleep. If not, then
> -        * go fully to sleep until explicitly woken up.
> +        * If balanced to the high watermark, restore vmstat thresholds and
> +        * kswapd goes to sleep. If kswapd remains awake, account whether
> +        * the low or high watermark was hit quickly.
>          */
> -       if (!remaining &&
> -           prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
> +       if (balanced) {
>                 trace_mm_vmscan_kswapd_sleep(pgdat->node_id);
>
>                 /*

But, I think what you did is more readable and nice.
Thanks!

> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 700434db5735..1217ecec5bbb 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4331,7 +4331,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >       /*
> >        * Return the order kswapd stopped reclaiming at as
> >        * prepare_kswapd_sleep() takes it into account. If another caller
> > -      * entered the allocator slow path while kswapd was awake, order will
> > +      * entered the allqocator slow path while kswapd was awake, order will
> >        * remain at the higher level.
> >        */
> >       return sc.order;
>
> This hunk just adds a typo, drop it.

Sorry about that;;
