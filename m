Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2098E5046CF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 08:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiDQGT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 02:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiDQGTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 02:19:54 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A61CFC2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 23:17:19 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id h8so20874029ybj.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 23:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=leDgynV+ujUVCmP8gHEBiaj8szQTU9a+b8YdxSYSrEo=;
        b=hXjmP63NBnxBsIZ9pGc9BjrZ5ijRcBF7UGZ7Wsu8qrJ5IcFnIcJvbhIpceZBmgRi31
         U32ucpUmUbSKMU9ePwS0fA/cIaxNSjfh45lziYMjuiJ+hDIBRKV3l+Cqu38FNggLp9+h
         EjIHBgSB2PQs9UmfRP/rQuURxK5DYSP+5vOizFPynjcTf54MwJf8pu+okKWRu647ERQI
         3iRSP+YGexv34Utxid0DV0Z6S4Clw02tVv3VJ2npH2BCAn4xBsl+TJISSDqoTm4+dnnL
         rAjCoxo7wP3JpNWpk4qslKfQCCEwkq9N0VzyZiwrIbPHDlCzPuKkvpNwntJtL+M1QjQ0
         SkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=leDgynV+ujUVCmP8gHEBiaj8szQTU9a+b8YdxSYSrEo=;
        b=vjvxfw7S7zxCk9zQTxoDkNySOUv5Ftc/vF8u6Rcv/ZOMfTbe3d7IL300lP9Zh2blis
         OASlrEAnP3HCFMjhy0MMxMa72JC5HvqPIwRGna0r/Z4bKeXLua5oMZKumlKkO++Ow45X
         1HHxtIpHgP1G2WfDao1B7Xlk93igYI52HIIb55yhn/ZSGajOJjfbvanMedDn6YPsm3+y
         qtv+7KzyPiPGTq6FmPEhr//LKb8n5ARJpJVhwgELvqMr8WSGJ8bDWTkk4GBYyaco3HAk
         w+3mZVN1usuYlECkyeN7hW6SdKRMS7p0xAEsZF0kX2IG5wwIZQxiYbRsKIjD5kRxkcPQ
         2o5g==
X-Gm-Message-State: AOAM531RZYRAjVy7Dp5wvFE5i4kLqOXu/pVMFCepiFURYX7biqi76FGs
        zSQHtLsTmu0xBkOUID0L16PzUIW0sKEJcngNRNcEE5ytv4MlQw==
X-Google-Smtp-Source: ABdhPJzEC4LcSFDCovop6KxhhoZtj8dXg9HDWbdjPGdEgB77k3cvqSoPhXZe4LjFA2/gdG7PNu1LV1fT+jmcXp5AK8E=
X-Received: by 2002:a25:7b41:0:b0:641:26a9:9be3 with SMTP id
 w62-20020a257b41000000b0064126a99be3mr5169454ybc.163.1650176238278; Sat, 16
 Apr 2022 23:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220416074059.526970-1-vvghjk1234@gmail.com> <YltwuNz4N5BKRFDT@hyeyoo>
In-Reply-To: <YltwuNz4N5BKRFDT@hyeyoo>
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
Date:   Sun, 17 Apr 2022 15:17:07 +0900
Message-ID: <CAEcHRTroA+p1RZzAe-DtwK_dzNiYcNGyop9gtYyW8KEKgq=bDA@mail.gmail.com>
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

On Sun, Apr 17, 2022 at 10:43 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Sat, Apr 16, 2022 at 04:40:59PM +0900, Wonhyuk Yang wrote:
> > To calculate order, calc_slab_order() is called repeatly changing the
> > fract_leftover. Thus, the branch which is not dependent on
> > fract_leftover is executed repeatly. So make it run only once.
> >
> > Plus, when min_object reached to 0, we set fract_leftover to 1. In
>
> Maybe you mean when min_object reached 1.

Yes, That comment need to be updated...

>
> > this case, we can calculate order by max(slub_min_order,
> > get_order(size)) instead of calling calc_slab_order().
> >
> > No functional impact expected.
> > Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
> > ---
> > V1 -> V2: Fix typo miss in a commit message
> >
> >  mm/slub.c | 18 +++++++-----------
> >  1 file changed, 7 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index ed5c2c03a47a..e7a394d7b75a 100644
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
> > +     order = max_t(unsigned int, slub_min_order, (unsigned int)get_order(size));
> > +out:
>
> You don't need to cast value of get_order(size). max_t() does cast both operands.

That's a good point, I will delete it.

>
> >       if (order < MAX_ORDER)
> >               return order;
> >       return -ENOSYS;
>
> For the correctness of the patch, I don't see any problem about the
> code.
>
> But to be honest I'm a bit skeptical about saving some cycles in
> calculating slab order. It's done only when creating caches (usually in boot
> process).
>
