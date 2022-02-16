Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A694B9290
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiBPUmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:42:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiBPUms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:42:48 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C901DED5C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:42:34 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 24so1203010ioe.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkHFJYvYVkKYBcB7iK0KWU7QvRr9ZBff0a6WbJBCpHQ=;
        b=l5ABOM2nj9+mns6PKN+jKYIK1X4cEIhbWdWpZDho+hWH+SUK5JBh24RapaHjKyB345
         smKzpit9wOYzv/3WQSNpJyo+Pr26BhWAahMPpenMpHS91V7d0oUDJW4XnqZP6rhHAr8M
         ingqBYI+4zRkNrBTOhbEhnfUM8Ff7Wlmk+Nsd0M4ErJjmOG7e3ymLE+GBAgVZ0dpmGEt
         Tv1iZanyVJqp95/KK8n0lxH9c6z5hgb2TQhC53YX7y55hBN4f+mDygaXeSP0PFCmMr7x
         TZfo8Y3zOKRdhcN/r0D3N4eLazM7boBurOsOs/mkzj84LClMZ+JhM/bu6Uk2uxbbroVK
         uJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkHFJYvYVkKYBcB7iK0KWU7QvRr9ZBff0a6WbJBCpHQ=;
        b=m5x4K53ofJxAPaQlRcUiyOoehI3WBDtP+t1DPNk/MB+z0Hd/EcklSdACrqCdxb6l0Y
         wV8hb072DkfvYCy0n6esusIo25/b/Yps+arCM/ImLpsubvVz2tUmeD5vhixiDw0hkbeE
         pmFtynD+QlXJZup3lvXBhWlTFwVX1SdFqAs0JbX7zLO66lQG5tWMX8tkiOPKEX909HLR
         6uGRD9XqUC3v37Rne1hId49Cb716vtiHbAw4pftfr7INlApS7aZ4FRA4DJ6Q4r0J2sac
         or1egaGjdh8WkKk0X6gTTtQCsoi9KVjN7GHfdwBdPqbHweP5IXr6qSl+DF4LdHlSUzNx
         IdZg==
X-Gm-Message-State: AOAM532xDy7T6B7Btsymqx17xVZ52v1OAsu7faynMP0DX8qQL0apHYxn
        vkoj31BReusA6iKmyIa4IPfeBC+bCzYox5KLUa0F4QXwO18=
X-Google-Smtp-Source: ABdhPJzmsdyC0hQQB7IFocQsue8DyUPQjEaRe5d+gseybDvolIfDUHELU0Uus9DTI0fM+LpC981cDxlRh3kE7ZKdmTE=
X-Received: by 2002:a05:6638:13c5:b0:313:f0f6:2346 with SMTP id
 i5-20020a05663813c500b00313f0f62346mr2833881jaj.218.1645044153997; Wed, 16
 Feb 2022 12:42:33 -0800 (PST)
MIME-Version: 1.0
References: <5b120f7cadcc0e0d8d5f41fd0cff35981b3f7f3a.1645038022.git.andreyknvl@google.com>
 <CANpmjNP0QCMhSL+ePf5G8UwbmdjM-qpimAQbuQD+pYK8Gx+2Gw@mail.gmail.com>
In-Reply-To: <CANpmjNP0QCMhSL+ePf5G8UwbmdjM-qpimAQbuQD+pYK8Gx+2Gw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 16 Feb 2022 21:42:23 +0100
Message-ID: <CA+fCnZd0aXZcZaSs7ijUZ+WaD6+s0vPcnp1vLOn2=1dSJQMa8A@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: print virtual mapping info in reports
To:     Marco Elver <elver@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 8:31 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 16 Feb 2022 at 20:01, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Print virtual mapping range and its creator in reports affecting virtual
> > mappings.
> >
> > Also get physical page pointer for such mappings, so page information
> > gets printed as well.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > ---
> >
> > Note: no need to merge this patch into any of the KASAN vmalloc patches
> > that are already in mm, better to keep it separate.
> > ---
> >  mm/kasan/report.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 137c2c0b09db..8002fb3c417d 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -260,8 +260,18 @@ static void print_address_description(void *addr, u8 tag)
> >                 pr_err(" %pS\n", addr);
> >         }
> >
> > +       if (is_vmalloc_addr(addr)) {
> > +               struct vm_struct *va = find_vm_area(addr);
> > +
> > +               pr_err("The buggy address belongs to the virtual mapping at\n"
> > +                      " [%px, %px) created by:\n"
> > +                      " %pS\n", va->addr, va->addr + va->size, va->caller);
>
> Can you show an example of what this looks like?

[   20.883723] The buggy address belongs to the virtual mapping at
[   20.883723]  [ffff8000081c9000, ffff8000081cb000) created by:
[   20.883723]  vmalloc_oob+0xd8/0x4dc

> It's not showing a stack trace,

No, only a single frame.

> so why not continue the line and just say "... created by: %pS\n"

Putting it on a separate line makes the line lengths looks more balanced.

Also, printing a frame on a separate line is consistent with the rest
of KASAN reporting code.
