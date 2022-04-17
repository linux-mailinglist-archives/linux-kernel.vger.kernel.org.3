Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2955046D2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 08:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiDQGXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 02:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiDQGXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 02:23:53 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF7F1B79E
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 23:21:19 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id t67so20944342ybi.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 23:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYimQXzjWqzb40fO/1C9OZnRSRr/Zk7PyszpEA08vvI=;
        b=K3UEB8+S1XcuLnW9dHmFz0IzQjCs8XSMr5L5LRen7i093XYkd88sO31b1MeHOUktVG
         Loo1UiIhSQQKly1d30UOmKJ6w3uVj1c2bDNQO2fzBVF5MoQADTjX4s4zCTCawBJemDn7
         pn5z4QvAUvcBcZf6Qyj56ptjMv28EAXsNxAPDdhK0/6fCL455YIIMHlevAHdTYRUhQRp
         kzVNUDFwwNPZecaAPBq5XiXhY/lVSrAfr4tyRkMy2deHMlKDezX0IWqTMlzL3KZESeMf
         IGaI0wXMcHXlW4lCcIquuATEFGhMwtU5w5Xg/HO8dYtCzp7gTkvnCeOVv+w+mGv7HEEa
         0DKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYimQXzjWqzb40fO/1C9OZnRSRr/Zk7PyszpEA08vvI=;
        b=fDJ5NZ90w3ghbrFf7QQkZiD/0Xk3lYd26lyghGv1py3agrBHCTQdgJGxlsXfIz524q
         Mon1FxglOSPfMPs/RljHqBCMe7yG34O5WCYKCMwYNuM7DQbPzcBjhMzROYx+Ue4NwIJs
         y41rxoEpyhuk17QIpxKuZ/f2JIYOYYym8kodz91c1UypnShETkTwkhP/rNK61zoNIhv5
         s2PLFM7+CF6laeEV48X3KYyJbNMy8SyOuF8QgvSpofWG5yzILXzdP3nJmGnLC+O7EPDO
         DG06C1iSYvAuLg5tm2dTDjVJguSHcQ/GZJZkYcH5kgNvXDb8Cu2ZWzb8L41wl9D8guyP
         Stuw==
X-Gm-Message-State: AOAM530YKpkWQGfTO1FSkRtk8GvzFwC0Qt3akksd5Xtio6bT5FgA14rL
        g4oR5e2wzf/XgpJxu/khovpXH40PH+dzyLvnXLM=
X-Google-Smtp-Source: ABdhPJyrMjI6snmoZNuw5XepVTzgpUZZl9dLfKD5fCNuvTzSIu1PSHCyJnMH2nCMbdEvMYI+2drWwha4I5VBRFxuD2Q=
X-Received: by 2002:a5b:ac9:0:b0:641:8ac2:aa5e with SMTP id
 a9-20020a5b0ac9000000b006418ac2aa5emr5457447ybr.50.1650176478789; Sat, 16 Apr
 2022 23:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220416074059.526970-1-vvghjk1234@gmail.com> <YltwuNz4N5BKRFDT@hyeyoo>
 <Ylt2SG4DdtBrb1fq@hyeyoo>
In-Reply-To: <Ylt2SG4DdtBrb1fq@hyeyoo>
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
Date:   Sun, 17 Apr 2022 15:21:07 +0900
Message-ID: <CAEcHRTora1m2XETx-vo782rYiT9bnKn+OBfn=KEgVMYTxQx--w@mail.gmail.com>
Subject: Re: [PATCH v2] mm/slub: Remove repeated action in calculate_order()
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
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

On Sun, Apr 17, 2022 at 11:07 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Sun, Apr 17, 2022 at 10:43:20AM +0900, Hyeonggon Yoo wrote:
> > On Sat, Apr 16, 2022 at 04:40:59PM +0900, Wonhyuk Yang wrote:
> > > To calculate order, calc_slab_order() is called repeatly changing the
> > > fract_leftover. Thus, the branch which is not dependent on
> > > fract_leftover is executed repeatly. So make it run only once.
> > >
> > > Plus, when min_object reached to 0, we set fract_leftover to 1. In
> >
> > Maybe you mean when min_object reached 1.
> >
> > > this case, we can calculate order by max(slub_min_order,
> > > get_order(size)) instead of calling calc_slab_order().
> > >
> > > No functional impact expected.
> > > Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
> > > ---
> > > V1 -> V2: Fix typo miss in a commit message
> > >
> > >  mm/slub.c | 18 +++++++-----------
> > >  1 file changed, 7 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index ed5c2c03a47a..e7a394d7b75a 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -3795,9 +3795,6 @@ static inline unsigned int calc_slab_order(unsigned int size,
> > >     unsigned int min_order = slub_min_order;
> > >     unsigned int order;
> > >
> > > -   if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
> > > -           return get_order(size * MAX_OBJS_PER_PAGE) - 1;
> > > -
> > >     for (order = max(min_order, (unsigned int)get_order(min_objects * size));
> > >                     order <= max_order; order++) {
> > >
> > > @@ -3820,6 +3817,11 @@ static inline int calculate_order(unsigned int size)
> > >     unsigned int max_objects;
> > >     unsigned int nr_cpus;
> > >
> > > +   if (unlikely(order_objects(slub_min_order, size) > MAX_OBJS_PER_PAGE)) {
> > > +           order = get_order(size * MAX_OBJS_PER_PAGE) - 1;
> > > +           goto out;
> > > +   }
> > > +
> > >     /*
> > >      * Attempt to find best configuration for a slab. This
> > >      * works by first attempting to generate a layout with
> > > @@ -3865,14 +3867,8 @@ static inline int calculate_order(unsigned int size)
> > >      * We were unable to place multiple objects in a slab. Now
> > >      * lets see if we can place a single object there.
> > >      */
> > > -   order = calc_slab_order(size, 1, slub_max_order, 1);
> > > -   if (order <= slub_max_order)
> > > -           return order;
> > > -
> > > -   /*
> > > -    * Doh this slab cannot be placed using slub_max_order.
> > > -    */
> > > -   order = calc_slab_order(size, 1, MAX_ORDER, 1);
> > > +   order = max_t(unsigned int, slub_min_order, (unsigned int)get_order(size));
> > > +out:
> >
> > You don't need to cast value of get_order(size). max_t() does cast both operands.
> >
> > >     if (order < MAX_ORDER)
> > >             return order;
> > >     return -ENOSYS;
> >
> > For the correctness of the patch, I don't see any problem about the
> > code.
> >
> > But to be honest I'm a bit skeptical about saving some cycles in
> > calculating slab order. It's done only when creating caches (usually in boot
> > process).
>
> But yeah, maybe it's worth for better maintenance of code.
>
> So after considering my comments, feel free to add:
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>
> Thanks!
>

Thanks for taking the time to review Hyeonggon!
