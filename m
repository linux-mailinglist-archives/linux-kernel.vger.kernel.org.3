Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEAD559571
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiFXI2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiFXI2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:28:46 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86968248FC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:28:45 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3176b6ed923so17432367b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=juJPwPR296pSJZwsH9/Iy+TMiLjsg5L/e3X7qop/D3w=;
        b=Yen0y2jHteguKUwEE6qaiTm+lhM9bjOuVD5af9lqIfB669iZhRqRU+TC8W6kj0hI3M
         YG3d6JOmMQ5+s1J+K+s4D6C8jualhWVv70vHc3EkNIE2cpKal4D48l0vJAiqwcX0p2CG
         F9tUhwi2kPg0X5cHoKyCGOO5FHxcxGuBLhgT0QoAI2A/xvHiRMrTQNktW6/o3SyyOGSK
         pe7IfdAY1PfZmHSU+A1FKLxfXQUSfCB1OwSiEcWDkbmxneFZUS5YCvsT9jJQ2M4ERlt8
         kPX6xhEblEjJUoujRI3ab/ZUqtI7zEGzWjZOQNFJU6vWPcfzfjwowpBy4gWsCdzgdpcr
         dpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juJPwPR296pSJZwsH9/Iy+TMiLjsg5L/e3X7qop/D3w=;
        b=BWprIbY6NwdyU1IMdDaV6uhf5OLJyz55yZ0fcAfsswJecxN38KVogw+2DD4xkzrCOV
         M3Gppycc1PVAu0UUukrZE0tiIR1PejZMpdnxrmK+3x6gqmZCzIGV1wkcgcjZ48FB3gAZ
         HQKbF486oQCm1EToy0jSqdkoKmkrUGDuefxOYwl3NmwMHhm4wkn1KKyOCUNeq8x0vWqm
         GDDXxSHgEm3uaSVY0jNweJuc16b3dzuLUmrqWobULvMQpbNNRFEshBhVxd4okVLoyGk6
         w9qi4LaIKxv4zNqtTm1YR5zM1ybNCi3qxQdrxeenmEA8vWR96BX5z9TIYwyWN1o4XAPR
         FJrw==
X-Gm-Message-State: AJIora93s2+rcIcgWmqCIGQQOriprA8Pz7OnqZmWEtmwAZ5ScFOC8dt3
        W6XvxZYszMByo0m77EVwSanHUfacoPwl+csQ3Iq/rg==
X-Google-Smtp-Source: AGRyM1vpXuHX/b68bS4ayavud0a5eakM5MhbMfcsLJodMJUZ4whj1SvXh17eHSaMDiWAQlCGApLgvLq0yCqBlwuOVj0=
X-Received: by 2002:a81:3a12:0:b0:314:6097:b801 with SMTP id
 h18-20020a813a12000000b003146097b801mr15576175ywa.512.1656059324577; Fri, 24
 Jun 2022 01:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220623111937.6491-1-yee.lee@mediatek.com> <20220623111937.6491-2-yee.lee@mediatek.com>
 <CANpmjNN-jsZoVmJWD2Dz6O3_YVjy0av6e0iD-+OYXpik1LbLvg@mail.gmail.com> <bdfd039fbde06113071f773ae6d5635ff4664e2c.camel@mediatek.com>
In-Reply-To: <bdfd039fbde06113071f773ae6d5635ff4664e2c.camel@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 24 Jun 2022 10:28:08 +0200
Message-ID: <CANpmjNPfkFjUteMCDzUSPmTKbpnSfjmWqp9ft8vb-v=B8eeRKw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: kfence: skip kmemleak alloc in kfence_pool
To:     Yee Lee <yee.lee@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KFENCE" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022 at 10:20, 'Yee Lee' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Thu, 2022-06-23 at 13:59 +0200, Marco Elver wrote:
> > On Thu, 23 Jun 2022 at 13:20, yee.lee via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > >
> > > From: Yee Lee <yee.lee@mediatek.com>
> > >
> > > Use MEMBLOCK_ALLOC_NOLEAKTRACE to skip kmemleak registration when
> > > the kfence pool is allocated from memblock. And the kmemleak_free
> > > later can be removed too.
> >
> > Is this purely meant to be a cleanup and non-functional change?
> >
> > > Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> > >
> > > ---
> > >  mm/kfence/core.c | 18 ++++++++----------
> > >  1 file changed, 8 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > > index 4e7cd4c8e687..0d33d83f5244 100644
> > > --- a/mm/kfence/core.c
> > > +++ b/mm/kfence/core.c
> > > @@ -600,14 +600,6 @@ static unsigned long kfence_init_pool(void)
> > >                 addr += 2 * PAGE_SIZE;
> > >         }
> > >
> > > -       /*
> > > -        * The pool is live and will never be deallocated from this
> > > point on.
> > > -        * Remove the pool object from the kmemleak object tree, as
> > > it would
> > > -        * otherwise overlap with allocations returned by
> > > kfence_alloc(), which
> > > -        * are registered with kmemleak through the slab post-alloc
> > > hook.
> > > -        */
> > > -       kmemleak_free(__kfence_pool);
> >
> > This appears to only be a non-functional change if the pool is
> > allocated early. If the pool is allocated late using page-alloc, then
> > there'll not be a kmemleak_free() on that memory and we'll have the
> > same problem.
>
> Do you mean the kzalloc(slab_is_available) in memblock_allc()? That
> implies that MEMBLOCK_ALLOC_NOLEAKTRACE has no guarantee skipping
> kmemleak_alloc from this. (Maybe add it?)

No, if KFENCE is initialized through kfence_init_late() ->
kfence_init_pool_late() -> kfence_init_pool().
