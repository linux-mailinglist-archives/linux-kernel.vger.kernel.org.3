Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD6B528388
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiEPLt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbiEPLtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:49:53 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4294E0E9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:49:52 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2fed823dd32so39469167b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4XtkkgDY70ODUGHGl87xJIvARSTddMeTRl5MzriSEag=;
        b=tR2WwLJQK3Xoss/NvMGDcRkuGYbpCWjlIeAtJ2fMqal3hOIOFZxrBYz4T3pkmi/5kT
         xOi7S5z5/vP/VDnpXIh/1M/WpZFpS7X0u2UxPcfYL1JNySJvNfEhgTBkhsB2nKlXP7Mk
         5geihxNdDq6mP/nnE6vaApD43Vf6/weNRQ1fu0uahCM/tEdy6VtTQAZXmdjn/xwRRoYn
         edjtIBHuvBjPE8Y+in06a0p5q676OvBJrn+QyU/SAjN2GjXxa99D2NFhhgHWNuaIOzPz
         hFUT6cp0oaGBfZnXr2VMLvy5FGl1uepzcbU2YZFEotz2VOmdudnUBEfWuJUPTytfniQk
         /caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4XtkkgDY70ODUGHGl87xJIvARSTddMeTRl5MzriSEag=;
        b=Eb/B3hKovCz506T0Dl8L9hafzCWgOoJZ1gARLhXp/HNIImuywbR4WNGciPedDGTrX9
         55upt9MYBWqMO+DEUaYClmJ8OqRm3dT9HUHTm6uEdVXaExaTmev3mLBXtRXBURgU9Aii
         LJFe1LDLGUBQt9RuJBX6JEN1cBy8NEg65I9bSCQrQcGL5PV5Ii9WW3qMQGKtURPEX7fj
         1CojsgBZqNrB3oDDhc64SwdN3fZtfWEoEAC/kvltfEFbSeh6F7sV5gZwve5ipKvc4i/q
         VbJDCW/mTck+opcgaDZeUW3Fguoy15yabiVHd9N9J+x9RdpoLwhp+AejIRYF35FehXC3
         4hqw==
X-Gm-Message-State: AOAM5301osmNCxyIKqto4c+Y/6Ff5Nwmn1v2BIvlonhB2a+rUMRNBITD
        mcrKCtZcYTcgIIGHWxVdexZw2uiwxFfcYjcnoKqh9w==
X-Google-Smtp-Source: ABdhPJx2Q9of50T64pn6+gSbgtYcKkZGPXW6zopRcYz9chzp4PzVO+UL/Je9mgpUQg0Ktv0NtxHiV3crHzWpPx9s5Gw=
X-Received: by 2002:a0d:f0c3:0:b0:2f4:d291:9dde with SMTP id
 z186-20020a0df0c3000000b002f4d2919ddemr19141054ywe.437.1652701791936; Mon, 16
 May 2022 04:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220426164315.625149-1-glider@google.com> <20220426164315.625149-28-glider@google.com>
 <87bkwmy7t4.ffs@tglx>
In-Reply-To: <87bkwmy7t4.ffs@tglx>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 16 May 2022 13:49:16 +0200
Message-ID: <CAG_fn=WhNZ8+7RXvr_2nGa-mCpLYxBK=cw3wFg6bxOqgXTOH0A@mail.gmail.com>
Subject: Re: [PATCH v3 27/46] kmsan: instrumentation.h: add instrumentation_begin_with_regs()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 3:28 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Apr 26 2022 at 18:42, Alexander Potapenko wrote:
> > +void kmsan_instrumentation_begin(struct pt_regs *regs)
> > +{
> > +     struct kmsan_context_state *state =3D &kmsan_get_context()->cstat=
e;
> > +
> > +     if (state)
> > +             __memset(state, 0, sizeof(struct kmsan_context_state));
>
>   sizeof(*state) please
>
> > +     if (!kmsan_enabled || !regs)
> > +             return;
>
> Why has state to be cleared when kmsan is not enabled and how do you end =
up
> with regs =3D=3D NULL here?
>
> Thanks,
>
>         tglx
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/87bkwmy7t4.ffs%40tglx.

As discussed in another thread, I'll be dropping this patch in favor
of the new kmsan_unpoison_entry_regs().

I'll also ensure I consistently use sizeof(*pointer) where applicable.

Regarding regs=3D=3DNULL, this is actually not a thing.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
