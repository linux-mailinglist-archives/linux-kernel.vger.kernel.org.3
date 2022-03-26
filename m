Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3234E81D0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 16:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiCZPwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 11:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiCZPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 11:52:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF5DBFD
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:50:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a8so20626556ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OGCQNOw1Se0K0qXz1pxIgif7mQdrfH8tD2xtpZ00QKA=;
        b=NHOrYe3Kw3Gm6xFJ+J0XF8+3iDYw+6td04sxOHOSkrUvjaNOOkT6CxS/R5ipFQAbdL
         FpjZ0sEqF/dDg0ThbgCVi3KzDccdXyOecoURkVHD/Wuq49NKFW+WydB9d8vdQn2EgFTC
         vTogx3sece5F2OCaBDqab2nBFFVv+/EN492m3+f7DxrSSc+zTVjoqrOkdKsGPQ4O9eHL
         yR+IIBLFnyO/sZRg9Vo77wWFj9m4VEbpXAH/gNI+Cr+oUYNauayJ4LpGgIpHS9Gy292S
         pR3jpiUz0GquRUyyGAAEsuTy1VD42qd8N5vFMmuRkTJxTL/9OCaISWpDftaJ6UA5jqwI
         Ye6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OGCQNOw1Se0K0qXz1pxIgif7mQdrfH8tD2xtpZ00QKA=;
        b=GlEwKemtJTEh+WP8Y/fAQnqZ7TKSVY2wyt/yPXfldW82pNRuZWufOGxYDMc0UvO2W+
         RZsYVmgmqi2ej/O2DwwR5tViuBX8gtsyyBkeSM6/UOktwP1AFfB1q5KofcZcE8McTjLo
         vR76LH5DES8XSsTjhzHnI1u4TGMVZJFvV7xlI3WqCAOg8YDvoKQwmbBHZ9kYxdn2G2AY
         SgHDcZG8d2qq5Q4wGz8bySgXQ6IYakEZ1tZhzYwcMAl2lYxow83WJA2V5y98nNsxdmL1
         NpZgAJDDgAmTJbs3O0rgHKDJm2pdopizKKERLLE3wHXQd64yttQHfqLCV7SAXwP0UCUM
         jXZA==
X-Gm-Message-State: AOAM531EmGHu5qIHHMo1+5xKotXtThY0tKpeTZ0+H6YMurb9Zw4dCW39
        Jg3VrNmb1c+6MHg5yPyeWyk=
X-Google-Smtp-Source: ABdhPJywcyPim9N/QtlOICDAoM8iJGZOReK8MLK0NuX03aOzBXK0pI/jdpFfqljR5B6opmUAo1meSA==
X-Received: by 2002:a17:906:7706:b0:6d6:e521:5471 with SMTP id q6-20020a170906770600b006d6e5215471mr17762757ejm.387.1648309823909;
        Sat, 26 Mar 2022 08:50:23 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b006cee1bceddasm3638026ejn.130.2022.03.26.08.50.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Mar 2022 08:50:23 -0700 (PDT)
Date:   Sat, 26 Mar 2022 15:50:22 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     DaeRo Lee <skseofh@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: no need to double-check if free pages are
 under high-watermark
Message-ID: <20220326155022.6pqxcfazjaw47eu5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220102033129.12913-1-skseofh@gmail.com>
 <20220106094650.GX3366@techsingularity.net>
 <CAATEi5=Cmt__5mQLcis5dO9ncc5nyQgiGD22UXtLsgJH5ZbwkA@mail.gmail.com>
 <20220106125758.GY3366@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106125758.GY3366@techsingularity.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 12:57:58PM +0000, Mel Gorman wrote:
>On Thu, Jan 06, 2022 at 09:03:34PM +0900, DaeRo Lee wrote:
>> > > @@ -4355,7 +4355,7 @@ static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
>> > >  static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
>> > >                               unsigned int highest_zoneidx)
>> > >  {
>> > > -     long remaining = 0;
>> > > +     long remaining = ~0;
>> > >       DEFINE_WAIT(wait);
>> > >
>> > >       if (freezing(current) || kthread_should_stop())
>> >
>> > While this does avoid calling prepare_kswapd_sleep() twice if the pgdat
>> > is balanced on the first try, it then does not restore the vmstat
>> > thresholds and doesn't call schedul() for kswapd to go to sleep.
>> 
>> I intended not to call prepare_kswapd_sleep() twice when the pgdat is NOT
>> balanced on the first try:)
>> 
>
>Stupid typo on my part.
>
>> > @@ -4406,11 +4412,11 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
>> >         }
>> >
>> >         /*
>> > -        * After a short sleep, check if it was a premature sleep. If not, then
>> > -        * go fully to sleep until explicitly woken up.
>> > +        * If balanced to the high watermark, restore vmstat thresholds and
>> > +        * kswapd goes to sleep. If kswapd remains awake, account whether
>> > +        * the low or high watermark was hit quickly.
>> >          */
>> > -       if (!remaining &&
>> > -           prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
>> > +       if (balanced) {
>> >                 trace_mm_vmscan_kswapd_sleep(pgdat->node_id);
>> >
>> >                 /*
>> 
>> But, I think what you did is more readable and nice.
>> Thanks!
>> 
>
>Feel free to pick it up, rerun your tests to ensure it's behaving as
>expected and resend! Include something in the changelog about user-visible
>effects if any (or a note saying that it reduces unnecssary overhead)
>and resend with me added to the cc.
>

Hi, All

Seems this thread stops here. I don't see following patch and current upstream
doesn't include this change.

May I continue this? Of course, with author-ship from DaeRo Lee <skseofh@gmail.com>.

Mel,

Would you mind suggesting some cases that I could do to see the effects from
this change? Such as the overhead or throughput? Or what cases you expect?


-- 
Wei Yang
Help you, Help me
