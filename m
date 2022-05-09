Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052A251F8F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiEIJx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239802AbiEIJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:47:28 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1491756B4
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:43:32 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2f7c424c66cso137949937b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6N0wgYMD6AvDl9pK6OWMAXj6rVMyYj7BLt9cpbI8cI=;
        b=GazxP/IPUdJpR9ySfbbmwBGpFTShUJw/9vCL34Abf2Vr7lgqLld5QeJSaPKVU3yN5H
         tCJB++ISaQAxpt1YYsVQhvzwckMc1WIRedMUkF/bDC40jzpslm0Bu5kCkSYsm8ESW9kG
         1tUkGKq7mBvOjFHofFfz2UT2WnyQ8bihwqOQRXuqHqUY670z7Gk4SlqFgO20JM5tJU3e
         MrHTv2oL+M2TzDXxdH8OFHpp2u1AfVvYcYSpZc5tWi9JRQCOimhSdryUm1pSPTk/k1XS
         GXLnehf/zxiDDuvpLlBwnGJO5BQ6eg6OGIuznFqR99T32qMeF74wtUDTkQVtUtqnFt+L
         WWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6N0wgYMD6AvDl9pK6OWMAXj6rVMyYj7BLt9cpbI8cI=;
        b=x17ejPCgXiQjZIDtIkA1IgGUb0XdOOUb3grVePQOPTyH9+9t+QEfbTg6BtvaJpIZo6
         nLJKvfdMfVhUncLLvW78idaw6H5zILdeT1FJc+h0pAINH+35Ss3rsYHHyI0VRJWD5/02
         TK5ZJ/sqpLTus/n0bE0hxJk3Q7Um9DYRsL9BgGJMEWIrGPmMs1SQJldO+i+yOf8xdT7Z
         tIs3s/62KAvelq8ua8ZajpcNWWPdXxFYC4AZuh11Wg8lbu+62FWrUWz0aYJiqdWEnl+r
         oh20O/u8SH7DSJ9pY86FIP5/IHXMw1X05dqDeNkvJJOXMMf55qNqLBRpGMsph4uXlSqT
         ZcBA==
X-Gm-Message-State: AOAM53278JCssgKvPmL775o6MQ6LtSAB2hKiiVIbJpwhuF8IIht38izq
        ZVslZbb4ovL4YNQboGtcDRsj71t+ZF4VB/v9ors=
X-Google-Smtp-Source: ABdhPJxFBg9L0Iz6dbtr+9hxwvWVjmUJWCMwscsZod7XxM4XYLhUXuEATEYOq2wSbgUTDgUChPyF1PR3gWn8MtIEbZU=
X-Received: by 2002:a0d:d510:0:b0:2f4:e202:2d9d with SMTP id
 x16-20020a0dd510000000b002f4e2022d9dmr13462464ywd.237.1652089372220; Mon, 09
 May 2022 02:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220430002555.3881-1-vvghjk1234@gmail.com> <49b0d611-e116-c78d-cf14-6d5f96ae500e@suse.cz>
In-Reply-To: <49b0d611-e116-c78d-cf14-6d5f96ae500e@suse.cz>
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
Date:   Mon, 9 May 2022 18:42:40 +0900
Message-ID: <CAEcHRTo3keiv0Xjr_7CG-kiD+Y6ENbdf9fKZzW9zgRd9OrV03g@mail.gmail.com>
Subject: Re: [Patch v3] mm/slub: Remove repeated action in calculate_order()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 7:00 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 4/30/22 02:25, Wonhyuk Yang wrote:
> > To calculate order, calc_slab_order() is called repeatly changing the
> > fract_leftover. Thus, the branch which is not dependent on
> > fract_leftover is executed repeatly. So make it run only once.
> >
> > Plus, when min_object reached to 1, we set fract_leftover to 1. In
> > this case, we can calculate order by max(slub_min_order,
> > get_order(size)) instead of calling calc_slab_order().
> >
> > No functional impact expected.
> >
> > Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >
> >  mm/slub.c | 18 +++++++-----------
> >  1 file changed, 7 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index ed5c2c03a47a..1fe4d62b72b8 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3795,9 +3795,6 @@ static inline unsigned int calc_slab_order(unsigned int size,
> >       unsigned int min_order = slub_min_order;
> >       unsigned int order;
> >
> > -     if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
> > -             return get_order(size * MAX_OBJS_PER_PAGE) - 1;
> > -
> >       for (order = max(min_order, (unsigned int)get_order(min_objects * size));
> >                       order <= max_order; order++) {
> >
> > @@ -3820,6 +3817,11 @@ static inline int calculate_order(unsigned int size)
> >       unsigned int max_objects;
> >       unsigned int nr_cpus;
> >
> > +     if (unlikely(order_objects(slub_min_order, size) > MAX_OBJS_PER_PAGE)) {
> > +             order = get_order(size * MAX_OBJS_PER_PAGE) - 1;
> > +             goto out;
> > +     }
>
> Hm interestingly, both before and after your patch, MAX_OBJS_PER_PAGE might
> be theoretically overflowed not by slub_min_order, but then with higher
> orders. Seems to be prevented only as a side-effect of fragmentation close
> to none, thus higher orders not attempted. Would be maybe less confusing to
> check that explicitly. Even if that's wasteful, but this is not really perf
> critical code.

Yes, I agree that checking the overflow of object number explicitly is
better even if
it is almost impossible. But it checked repeatedly by calling
calc_slab_order(). It
seems to me that is unnecessary doesn't it?

>
> > +
> >       /*
> >        * Attempt to find best configuration for a slab. This
> >        * works by first attempting to generate a layout with
> > @@ -3865,14 +3867,8 @@ static inline int calculate_order(unsigned int size)
> >        * We were unable to place multiple objects in a slab. Now
> >        * lets see if we can place a single object there.
> >        */
> > -     order = calc_slab_order(size, 1, slub_max_order, 1);
> > -     if (order <= slub_max_order)
> > -             return order;
> > -
> > -     /*
> > -      * Doh this slab cannot be placed using slub_max_order.
> > -      */
> > -     order = calc_slab_order(size, 1, MAX_ORDER, 1);
> > +     order = max_t(unsigned int, slub_min_order, get_order(size));
>
> If we failed to assign order above, then AFAICS it means even slub_min_order
> will not give us more than 1 object per slub. Thus it doesn't make sense to
> use it in a max() formula, and we can just se get_order(), no?

That's sounds reasonable. When it reached here, we don't need to keep the
slub_min_order.

>
> > +out:
> >       if (order < MAX_ORDER)
> >               return order;
> >       return -ENOSYS;
>
