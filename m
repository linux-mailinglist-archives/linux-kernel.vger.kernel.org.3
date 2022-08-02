Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D17588151
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiHBRsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHBRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:47:59 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C023DF51
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:47:58 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-32269d60830so148639077b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=CyPUbDaavl0pxtUchWqOoJ+rGYNrTSx7Qsh7yOX4nqk=;
        b=Vi4b18H4ruvdsnsfKL+xHB8JIstAaWj9GfTkdEHEJfP6HGkV2K7VRqfDfHV17mNn9+
         YfDABrmK4w3SaPqVBh5bXyQbe6x3QXHpoIU4WzT8xxgoUcS5ml2XHVtfsuJ2zqcQFhAd
         J8s0AZuAHn9KYK0oFgegc6so4j9E30I7XfPuVoFbmhCmTQvId+u5/XCreKdsxSA5N46X
         SzXnSQqra+iDjPn1Yh+9dDucGZnRiNvonatXvefk8NrHF+gnwxvG5okVRbt49+/VrHxu
         aM9r26REYHwDUJwLqat8Mxrb/RWmuMfHajj/WVBheWk/3pUXKjHQbhf0W8qkPy+w2fDD
         sXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=CyPUbDaavl0pxtUchWqOoJ+rGYNrTSx7Qsh7yOX4nqk=;
        b=s3tyJMBDs+yyJtA1IWLqayau/SGxj45P/B137lz33gTJkU53xieswXNIYJ+ZxTLTtk
         t4GziZNprhGkLMLfx9LKr//ZZ/7YTmQyr7ttBcywjWSNkgBd6rgYMZ1uIGm/pSozzX4+
         vfqC1QGOpKcOg0fgRvoW9CDoRtP6bMeh9uEMhTuprRTeP4nt6wHMMd6g5ecbeFG2Wn5b
         3gP3REka1z2OU3jd8bebTxdgMPrY9H/9X3RaZNkYA3fugwkSqxH0WbAhCdSKwGr424E9
         dhYBe0CUn6+miJuXJ/NU6BS1f9ROKP7bGzOtY8bRYfD0lyjS5bldry6qgNSx6KxHc5Mt
         8caQ==
X-Gm-Message-State: ACgBeo3Xi7qzU90qhbhUXAwONOmeCypNYW45oNBElQiEPS1OkV7Bjhlz
        ucvTjB7j+FEWTEEQLNbbUuai9FMnoc1pqTby50Nmhw==
X-Google-Smtp-Source: AA6agR5ff/2YTaiH0o2yaXcd9Vb4iGB8rk5BtGV2WejE90cyd/4A41JUybbJAmYoeDw71I0Y93ZyFnAevmMFLK5vkyw=
X-Received: by 2002:a81:5ca:0:b0:31f:38d6:f59f with SMTP id
 193-20020a8105ca000000b0031f38d6f59fmr18721968ywf.324.1659462477479; Tue, 02
 Aug 2022 10:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-30-glider@google.com>
 <Ys6c/JYJlQjIfZtH@elver.google.com>
In-Reply-To: <Ys6c/JYJlQjIfZtH@elver.google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Aug 2022 19:47:21 +0200
Message-ID: <CAG_fn=V_0Jw_mKpj0P5-hUeCUZZzC2u1LCD8Nvp8FvCy_x=wqg@mail.gmail.com>
Subject: Re: [PATCH v4 29/45] block: kmsan: skip bio block merging logic for KMSAN
To:     Marco Elver <elver@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:23 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, Jul 01, 2022 at 04:22PM +0200, 'Alexander Potapenko' via kasan-de=
v wrote:
> [...]
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -867,6 +867,8 @@ static inline bool page_is_mergeable(const struct b=
io_vec *bv,
> >               return false;
> >
> >       *same_page =3D ((vec_end_addr & PAGE_MASK) =3D=3D page_addr);
> > +     if (!*same_page && IS_ENABLED(CONFIG_KMSAN))
> > +             return false;
> >       if (*same_page)
> >               return true;
>
>         if (*same_page)
>                 return true;
>         else if (IS_ENABLED(CONFIG_KMSAN))
>                 return false;
>
Done.
> >       return (bv->bv_page + bv_end / PAGE_SIZE) =3D=3D (page + off / PA=
GE_SIZE);



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
