Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D6558804E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiHBQcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiHBQcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:32:02 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80211837F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 09:32:00 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g5so63122ybg.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=jBLRsOY6b2BWFCEwUDOOLDtlfS4iNN5NSPXBB7OTTdA=;
        b=C4yceeMrnfpv45TrBL5GxEv4ZUizC3/Vr/jdh5+Zbi+KLMTBmkoAfxkD1EYYg12lXR
         pVh9AeV8yvh5TuY9NmlD5eP0jKvFj7RP4G22OnxoGm/N4AdkMtswGPXRhOT2BAXTVf+g
         FxUqNI0/HgsAV4zTTqe6XuZcWKi6X5wZ9M7NjSvOyx1jz7FGR6CrHM8rbpH9l0DxzWoe
         hf6GZ3KmxjshcXvib72rR5MKZV0MM1F8H1CRVx3BPyeg9Gw1DE8RZTD5fXM+LhoZ5DnJ
         bgOGwc3ofHcCsX0ffHzVQHWF/qTn8A1ekfgQvNGt/WK7yTeGQxrDPRF9ro3QNUjzbtCk
         zTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=jBLRsOY6b2BWFCEwUDOOLDtlfS4iNN5NSPXBB7OTTdA=;
        b=eL72lTmxlnUAspSP0dFyjKs+UpErDz0pccb4fxJ59/fY98Jsv8XypzFkn8e0mc9WVb
         G4+5DQGfvOVo/EbIz6J8ER+5g7LYQzUbUcy/n4qDc6YOE53rS/qV3nyLGVtR7iOyewpB
         P1coAs7BwtBu78g5XSnSScbOWrItnxsoSSI4iFRfmUNXfl2YQw41uhNvwRUHOS9TWP8X
         NuOc5ZpaQKRLIEmb3c+G4Fu1vATmaepzl8FGMA9kvStViznjB9CmR/EmoEs85Hel6VhE
         iS4pQxMWW//qvIY2UxvY01TGJgEMC4baBQcFicqyLj+5PYJeY2259rZmdmV6wYyvVfhS
         aDCg==
X-Gm-Message-State: ACgBeo0AgWM8tGBbyZ1fs1pkBsk5TZQIFNulhsqCZ7AZbSAatxxcMCNM
        9s5IGB7EEzGkP+wGF8jZGwlmHnQZC4/G6Xdjw8qT/g==
X-Google-Smtp-Source: AA6agR4IP/yDKQLvxlaLVuFqguT0B75J5VxgY1hE7G7tnFEWCGuvYJ1oLYRqlboQgCEcZi6lhGNXNp7TZO+7bdc8488=
X-Received: by 2002:a25:b9d1:0:b0:671:49f9:4e01 with SMTP id
 y17-20020a25b9d1000000b0067149f94e01mr16899347ybj.398.1659457919894; Tue, 02
 Aug 2022 09:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-16-glider@google.com>
 <CANpmjNOJ-2xim3KM=9O=sfSgQXZi81R6PQj=antfHnejaOOogg@mail.gmail.com>
In-Reply-To: <CANpmjNOJ-2xim3KM=9O=sfSgQXZi81R6PQj=antfHnejaOOogg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Aug 2022 18:31:23 +0200
Message-ID: <CAG_fn=UBVs+QgdWDa_UB_zs0OUO=-zjcoH+8NY7obUm20rkBOQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/45] mm: kmsan: call KMSAN hooks from SLUB code
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
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jul 12, 2022 at 3:14 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 1 Jul 2022 at 16:23, 'Alexander Potapenko' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > In order to report uninitialized memory coming from heap allocations
> > KMSAN has to poison them unless they're created with __GFP_ZERO.
> >
> > It's handy that we need KMSAN hooks in the places where
> > init_on_alloc/init_on_free initialization is performed.
> >
> > In addition, we apply __no_kmsan_checks to get_freepointer_safe() to
> > suppress reports when accessing freelist pointers that reside in freed
> > objects.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> But see comment below.
>

>
> Remove unnecessary whitespace change.
Will do, thanks for catching!


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
