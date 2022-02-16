Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B64B9477
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiBPX0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:26:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiBPX0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:26:49 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEA22D1CF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:26:34 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y129so9431349ybe.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yl++UbQHvu031O88qjaOvVPH96zPax6XyUywms3AfE8=;
        b=du1dfzkCVyYJKstpFmIAxK2VNbKxzZZ6BqvK/vaUaaHusJhtDgI8Zx2SL2BK83cgC0
         yjx7jgQd+h2bjjVfymSN82w/XWqXpRoMuoaQyPKCRg5Ig5iW6S6yy/+/mNRLIvex4SnI
         2mrF33ukku/kGa51F8cAwgK/AE9FUo0IjGDPucJWRd8WnTg1g+0verMaJSCRb0T953UF
         Da31rWgY2Pqx/0IPX3Yxlrz4zMDvsyUxHyZnBFPT5w/gYZJMmG0UcnvWxAn55S/GISKq
         yf/+sau0mzPk2xw1Mk2yEyxC5GtlGCTV+bj8rBFxae37maEgxLhVfh2RZYGXkYu0OzUB
         Ek4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yl++UbQHvu031O88qjaOvVPH96zPax6XyUywms3AfE8=;
        b=ZJQwrTrKjNL5Wi2QfVZljY3PyT5JeQwd63xokvAhmMV0GbMXvQe0lNIF4/vip2qenf
         HRW+AP89KfUO8Hw2FbVqWlL0Daru9JW0qADd8dpz6WOtcgf7B4Au0IMIHGdxo70RKDSS
         0LXDU/T46+7NEY3/vyKNADltVuwpSE3aZHZvcL3dCiCXcWXD13U5QxdKd9UTtTFjR8AO
         9fNd6cNGtSv7FnKIYbZFKWs+DRpRhaLs54zg00kPlT5d21nyTYX0+Fq4Rcnosoe8wmaY
         qxLDzZvEKdwga7YAa/uuD8qxwYg+CqEsvvUk0+40bloognGCJTjpTL5hjoVFrocwLydI
         x6yA==
X-Gm-Message-State: AOAM533kKM4GJgDlBbivtxK8cC12HzH2vsW+VmIS0qk/BInlqK4PfscJ
        4J7R4D5amFfWlvqETF5puIFSdSfEa88GWGlQDuZfAw==
X-Google-Smtp-Source: ABdhPJwjoTHWombbeiuCgd+bm9lJ6I8IV5xERt6WrfekPcH+1L/91PJDXxGq1mQj3Rwwc+WX88bk3+QQzDWQ+x8mhKg=
X-Received: by 2002:a25:28a:0:b0:620:e848:af9b with SMTP id
 132-20020a25028a000000b00620e848af9bmr218531ybc.374.1645053993763; Wed, 16
 Feb 2022 15:26:33 -0800 (PST)
MIME-Version: 1.0
References: <5b120f7cadcc0e0d8d5f41fd0cff35981b3f7f3a.1645038022.git.andreyknvl@google.com>
 <CANpmjNP0QCMhSL+ePf5G8UwbmdjM-qpimAQbuQD+pYK8Gx+2Gw@mail.gmail.com> <CA+fCnZd0aXZcZaSs7ijUZ+WaD6+s0vPcnp1vLOn2=1dSJQMa8A@mail.gmail.com>
In-Reply-To: <CA+fCnZd0aXZcZaSs7ijUZ+WaD6+s0vPcnp1vLOn2=1dSJQMa8A@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 17 Feb 2022 00:26:22 +0100
Message-ID: <CANpmjNOgae3xePOekX5jDD29rLi-3Us9N7LskXaRpU8BOirnyw@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: print virtual mapping info in reports
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Wed, 16 Feb 2022 at 21:42, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Wed, Feb 16, 2022 at 8:31 PM Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 16 Feb 2022 at 20:01, <andrey.konovalov@linux.dev> wrote:
> > >
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > Print virtual mapping range and its creator in reports affecting virtual
> > > mappings.
> > >
> > > Also get physical page pointer for such mappings, so page information
> > > gets printed as well.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > ---
> > >
> > > Note: no need to merge this patch into any of the KASAN vmalloc patches
> > > that are already in mm, better to keep it separate.
> > > ---
> > >  mm/kasan/report.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > > index 137c2c0b09db..8002fb3c417d 100644
> > > --- a/mm/kasan/report.c
> > > +++ b/mm/kasan/report.c
> > > @@ -260,8 +260,18 @@ static void print_address_description(void *addr, u8 tag)
> > >                 pr_err(" %pS\n", addr);
> > >         }
> > >
> > > +       if (is_vmalloc_addr(addr)) {
> > > +               struct vm_struct *va = find_vm_area(addr);
> > > +
> > > +               pr_err("The buggy address belongs to the virtual mapping at\n"
> > > +                      " [%px, %px) created by:\n"
> > > +                      " %pS\n", va->addr, va->addr + va->size, va->caller);
> >
> > Can you show an example of what this looks like?
>
> [   20.883723] The buggy address belongs to the virtual mapping at
> [   20.883723]  [ffff8000081c9000, ffff8000081cb000) created by:
> [   20.883723]  vmalloc_oob+0xd8/0x4dc
>
> > It's not showing a stack trace,
>
> No, only a single frame.
>
> > so why not continue the line and just say "... created by: %pS\n"
>
> Putting it on a separate line makes the line lengths looks more balanced.
>
> Also, printing a frame on a separate line is consistent with the rest
> of KASAN reporting code.

That's reasonable, thanks.

Reviewed-by: Marco Elver <elver@google.com>
