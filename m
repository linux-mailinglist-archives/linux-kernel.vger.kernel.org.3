Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811995261CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380227AbiEMM1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiEMM04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:26:56 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3AA5BD2A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:26:52 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r1so15017888ybo.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CNColVrvzT2paTadmJx7QmfVUH99VFUNC4FwQajaX30=;
        b=fgZoCr+P0YLHIt9difJEkBctiHZD1TAZ4VGl1Wdxe0wL43HKeppNRKfFFjEBzHoTnK
         X+MZTjD/NYV3m2WKlRYDIDK4kxl+KQpDnmBj/jy9Dg8Eik7KJSbnbSNAkWfJnCfPiYaE
         YT6Ub7aOFoQlbMYGV3qFBVQlH3ltkUMH0gg9bamWReNzk4Od8Zs8ONqgWu+RAIgBcEVP
         ip6TDNYvIzo1zGJJAY6MeVnFjQ01/JDpYdLjBMMmZ3R/2EQyGNHgHPllV7CXm9HiKljk
         Fd9YqC1JwP3smDlGcgXwmG+aVIBPAw1mOzEQp7jeg7GdE9GId7CWZgnSCciUhAsAC/P3
         6JpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CNColVrvzT2paTadmJx7QmfVUH99VFUNC4FwQajaX30=;
        b=AxoPb+kKK2Bnv2wXnUHuslAjiaIZxPTj7VN5DZW3yX7IdaVuntoPo1amv9iYhygon2
         OX5WBHvr7lgWnyjKBGoe6DL9sIDZiHIncenEt0s5si4kNuf4uxrW2YjDaEomOeSdIWJV
         i+oGILr0YBm22oQQmjH7uVKk7WuGhr1VILiz6B0tAiFg2JVwNw1fh6fo2EbJjDamexAp
         0wcfdkteqxq47gp4bA3bsgT1gTiG3YFpmY84Jbl57r0NYAEFLInrsJIT2ujQHS3LitxE
         zVPQcyBcx+hwkExc7m24zGJJI7gMI60mSxNFfdomt7H/tFK1wlkti58MJxyLu0zWMsd2
         gmAA==
X-Gm-Message-State: AOAM532545KCnkRQoooiurMFSSuzCQAqHOCk/hvJKdGle0vCDrpYb3tH
        0hXZYli0aJKZVJudRwloS6qlPI/mWGvUHy+vJE05qg==
X-Google-Smtp-Source: ABdhPJxoTL2jX3zw7FK7Qs22T64RPExXJjGiprH1kOuNLfotTjSS/RWHWRl6vMXtyRXLS4ogUW95JldzIV+mEZZTr6o=
X-Received: by 2002:a25:8706:0:b0:64b:4657:d2e1 with SMTP id
 a6-20020a258706000000b0064b4657d2e1mr4492719ybl.147.1652444811517; Fri, 13
 May 2022 05:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com> <CAG_fn=URUve59ZPWRawW+BN-bUy7U3QmFsfOz_7L8ndsL4kQFQ@mail.gmail.com>
 <8a47d0ee50b44520a6f26177e6fe7ec5@AcuMS.aculab.com>
In-Reply-To: <8a47d0ee50b44520a6f26177e6fe7ec5@AcuMS.aculab.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 13 May 2022 14:26:15 +0200
Message-ID: <CAG_fn=XUqzBWzuU0cmjUoSfHTv6pN=LCqGh7Ns8kgR6L169bPw@mail.gmail.com>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
To:     David Laight <David.Laight@aculab.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
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

On Fri, May 13, 2022 at 1:28 PM David Laight <David.Laight@aculab.com> wrot=
e:
>
> ...
> > Once we have the possibility to store tags in the pointers, we don't
> > need redzones for heap/stack objects anymore, which saves quite a bit
> > of memory.
>
> You still need redzones.
> The high bits are ignored for actual memory accesses.
>
> To do otherwise you'd need the high bits to be in the PTE,
> copied to the TLB and finally get into the cache tag.
>
> Then you'd have to use the correct tags for each page.

Sorry, I don't understand how this is relevant to HWASan in the userspace.
Like in ASan, we have a custom allocator that assigns tags to heap
objects. The assigned tag is stored in both the shadow memory for the
object and the pointer returned by the allocator.
Instrumentation inserted by the compiler checks the pointer before
every memory access and ensures that its tag matches the tag of the
object in the shadow memory.
A tag mismatch is reported as an out-of-bounds or a use-after-free,
depending on whether the accessed memory is still considered
allocated.
Because objects with different tags follow each other, there is no
need to add extra redzones to the objects to detect buffer overflows.
(We might need to increase the object alignment though, but that's a
different story).

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)



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
