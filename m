Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70584573458
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiGMKeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbiGMKeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:34:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0DE1920
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:34:08 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id n74so18532971yba.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PD3ohJ/EmhNYKgVuLh+1SqFmgLy6OdvncR7q74oGJgI=;
        b=SFkRptQv/fARrJEXyjgdl3GI/SNI8s22WPYtvUrVhQI7uqGJl1eG7kDJG9WCzpi/oS
         vbOs8s7fLxxgZipbGnE+yg2GJbqhEOAof8pKtlWJO3Nv40SHvj+Ok+9BDj4FJRxH7+p1
         FNdVIuTsM+3E0KR+CwyzKwWY3lbJAsKTDJP9YJ17aKY0UajdUFkZGa5EkGCYtUUfm+jj
         UjFKgWFRFTer4Hkq1JP2TkX4prE8+mpUkTbipb78wRzGnvCjsX995BzgRk/BswHHsiS2
         X5bDvWUo/+QLB8d2JenM7ZAiK6VfHNsNnB01WX5kJluNt0tuqVJCjSFBQlEplHVJk62w
         jBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PD3ohJ/EmhNYKgVuLh+1SqFmgLy6OdvncR7q74oGJgI=;
        b=d9vsJxdcc2pgiYL0mzgjLO2VeOuJ3w7UvYMZT+AMmpjxyelVaCpoaYN4r+FqVBt/i/
         I1lZTIpaNuFuw8nkn53+FZwCQiwm5XykBzRl4TpciiiZKZ9a0nq5qgetw14hx0+MlZ+T
         Zx6bdVH7aEan8PDhNt+5iObYRFC0P0FgiZyrlZdbFW/Tpb+mshik7LwrEpEnlBTtNoCm
         /gBXgKgqlxzsqbg4Aw6SDLit0lhtwHBbkU2ea2j5zrJCDYhjp54E6FScVf9r5hCePxPc
         PvIqzBGvk1nUg9yVUF6cIKhw58sAFUW+0lmIb2b483cxgoqTlOCwsBJ/TYKpOhPkWMmu
         b3Cg==
X-Gm-Message-State: AJIora+pE6jqtZ0p0LVtZ30Tm2KfLD877wDVhozmo9NRj9ueXEOTNLB7
        8tf4xpJCyKHKTd4PIXThTgs6cXCtR1JSNgp5z7NvRw==
X-Google-Smtp-Source: AGRyM1vA9+p0W0ZH+zrwNUqogn3p1vap0TQyU6ssDzvta9TdLjk0Bu4O0HaJelNrRS0933ZUZYhceElQHXKy5uIogzE=
X-Received: by 2002:a25:abc5:0:b0:66e:3983:3ca7 with SMTP id
 v63-20020a25abc5000000b0066e39833ca7mr2939658ybi.168.1657708447835; Wed, 13
 Jul 2022 03:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220712133946.307181-1-42.hyeyoo@gmail.com> <20220712133946.307181-17-42.hyeyoo@gmail.com>
 <alpine.DEB.2.22.394.2207121701070.57893@gentwo.de> <Ys6Pp6ZPwJTdJvpk@ip-172-31-24-42.ap-northeast-1.compute.internal>
 <alpine.DEB.2.22.394.2207131205590.112646@gentwo.de>
In-Reply-To: <alpine.DEB.2.22.394.2207131205590.112646@gentwo.de>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 Jul 2022 12:33:31 +0200
Message-ID: <CANpmjNPbbugrbCFADy1C7PgaU-4PMd9UK90QiHKS-Md0ocqa3w@mail.gmail.com>
Subject: Re: [PATCH 16/16] mm/sl[au]b: check if large object is valid in __ksize()
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Wed, 13 Jul 2022 at 12:07, Christoph Lameter <cl@gentwo.de> wrote:
>
> On Wed, 13 Jul 2022, Hyeonggon Yoo wrote:
>
> > > Why return 0 if there is an error and why bother the callers with these
> > > checks. BUG()?
> >
> > I thought BUG should be used when there is no other solution.
>
> Spurios returns of 0 that the caller has to check for is a solution?

It's never really been about the caller checking for 0, see below.

> > > I guess this is an error since the order-0 page cannot come from slab
> > > allocations.
> >
> > comment in ksize() says:
> >       "The caller must guarantee that objp points to a valid object
> >       previously allocated with either kmalloc() or kmem_cache_alloc()."
> >
> > It should not be used on order-0 page that is not allocated from slab. No?
>
> I guess we would need to check. Code could exist that does this.
>
> Getting a 0 size would be surprising too here. BUG()? Or WARN() and return
> PAGE_SIZE.

We shouldn't crash, so it should be WARN(), but also returning
PAGE_SIZE is bad. The intuition behind returning 0 is to try and make
the buggy code cause less harm to the rest of the kernel.

From [1]:

> Similarly, if you are able to tell if the passed pointer is not a
> valid object some other way, you can do something better - namely,
> return 0. The intuition here is that the caller has a pointer to an
> invalid object, and wants to use ksize() to determine its size, and
> most likely access all those bytes. Arguably, at that point the kernel
> is already in a degrading state. But we can try to not let things get
> worse by having ksize() return 0, in the hopes that it will stop
> corrupting more memory. It won't work in all cases, but should avoid
> things like "s = ksize(obj); touch_all_bytes(obj, s)" where the size
> bounds the memory accessed corrupting random memory.

[1] https://lore.kernel.org/all/CANpmjNNYt9AG8RrGF0pq2dPbFc=vw2kaOnL2k5+8kfJeEMGuwg@mail.gmail.com/

Thanks,
-- Marco
