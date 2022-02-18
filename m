Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0371C4BBBDB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiBRPI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:08:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiBRPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:08:27 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737D067346
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:08:10 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id d3so4833249ilr.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WAY4GVsgjaO40pd4PC+o5Qrkod87XgfNtjMligfgoY=;
        b=k0fc5rFlb0nYvtjo4+yOGOzoacZjWtAHBTbCbMc7Q25WPenvdId6aWq+y6Rdb+00Dq
         aOaQ218/pbphHfK1eH91BX8+P0n48dqdTw2zXtA+iPrZ1D3/fyQW8/DtgREA0pJKvUj6
         Lp3X/6UpSCjLaud6YFWBrPpbWCOZpWE2/WLzSzX0WdLKV9qwvctPYZ60VTz33cAFUw2H
         ipn17iIMIdUWIB+10TVBgomrK5cedM2iYJRHZjXO/1y0/Lu4+/ZN9IN9pabjQMn7Gx6n
         qpN+ALnPW/fafYsm5bvSbyI2r+q53/Kf+9VFoS0l84yOd5GtMAbo2c69nY8gVvEJjEaB
         R64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WAY4GVsgjaO40pd4PC+o5Qrkod87XgfNtjMligfgoY=;
        b=aEoeumAeVil8ElhNQKr8SRY2fkoAhnVVOEbLM00MsHGWc4xaLdjh1KiceTZ7O0D44K
         4hICThDJ3oCcyokVo5YbZFeXO7PXI3/B8C/jx3ggb4PxMTZWqylqwRWFs9L/I00z83u0
         9ZSUWeou+1EAO5yKFgbwxGahIJWtMbZ2oGKxRmoxoXgj2RIvnXc9zWTOxL3vzjkL3Egu
         OVEAbeEx00wTEUiqqlIPoMZbDsIEDHGg98R2eGfxFywT5jHd1iyP33X3elWjAP/SzLKm
         JAV79CRTXF+7w49kLna1VMxAaje7bM5UMkVQnLBi7m5QVwkap0IxjpV+9hCb7z5Ze16o
         cAkg==
X-Gm-Message-State: AOAM532rA+BMXW0igiB/XvSZFYb1DWx9eJDmGnOW5+eIjT2UZqcXPJ3O
        +ePDJG8JqMMxPXToezMzgqxhoIq6piREqVYloao=
X-Google-Smtp-Source: ABdhPJzMnq7hK9D6lNRhKVIGRl8EXyxXzDy7SCwE7CO0ADTREL9Si+pDygSfUleL+W61anVYscsBJdjjvZkJ28zIcZ4=
X-Received: by 2002:a05:6e02:1905:b0:2c1:e164:76eb with SMTP id
 w5-20020a056e02190500b002c1e16476ebmr982921ilu.28.1645196889849; Fri, 18 Feb
 2022 07:08:09 -0800 (PST)
MIME-Version: 1.0
References: <5b120f7cadcc0e0d8d5f41fd0cff35981b3f7f3a.1645038022.git.andreyknvl@google.com>
 <Yg44yQJ9tQMgmiZq@lakrids>
In-Reply-To: <Yg44yQJ9tQMgmiZq@lakrids>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 18 Feb 2022 16:07:58 +0100
Message-ID: <CA+fCnZfAwSJQp7zE+qHChaSvy1uEL6xi0JiHtMi6iq29Fk3tRw@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: print virtual mapping info in reports
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
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

On Thu, Feb 17, 2022 at 1:00 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Feb 16, 2022 at 08:01:37PM +0100, andrey.konovalov@linux.dev wrote:
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
> >               pr_err(" %pS\n", addr);
> >       }
> >
> > +     if (is_vmalloc_addr(addr)) {
> > +             struct vm_struct *va = find_vm_area(addr);
> > +
> > +             pr_err("The buggy address belongs to the virtual mapping at\n"
> > +                    " [%px, %px) created by:\n"
> > +                    " %pS\n", va->addr, va->addr + va->size, va->caller);
>
> The return value of find_vm_area() needs a NULL check here;
> is_vmalloc_addr(addr) just checks that `addr` is within the vmalloc VA
> range, and doesn't guarantee that there is a vmap_area associated with
> that `addr`.
>
> Without the NULL-check, we'll blow up on the `va->addr` dereference and
> will fail to make the report, which would be unfortunate.

Indeed. Will fix in v2. Thanks, Mark!
