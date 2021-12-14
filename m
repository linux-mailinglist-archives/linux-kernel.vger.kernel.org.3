Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01222474AED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhLNS3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhLNS27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:28:59 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473DDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 10:28:59 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id x15so6656557ilc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 10:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/eebjakvP32P8uCIh8l8LVBJtnJ0BrHqeLhOnlTGnSw=;
        b=YtmXK3JnkvyyVA5xRFhf/RPO1p91z6a9njyTx5RFN2G7G/13J5IDhreG/c1fKFOT4x
         i333CBxEM33ImfuwmdorFD0ok8OalxM6qQVUPgFxQqpPweTPnuf2CH7A/3scLZlsU+rP
         jgOrWrqTnZ1id+qeVUIgFmPJ0NCSt8KNkrGjH5tzwWfbMXLP4PPnGP4zLz49sSZl+K0J
         uAxcouHH7s2UXr9u78H4buraJPWOfu2Qud08LaiS06ELHunVhHLZ6JD/WMLPMv/HZMb/
         cuTHv3bivib40wW5Ub3izhbKFbZ46yusYbbQrpFqCs9x3NnZpLrXKmjErq0A5dLKDIdb
         SA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/eebjakvP32P8uCIh8l8LVBJtnJ0BrHqeLhOnlTGnSw=;
        b=Kx7USJ7W6IvZVme2TEjpdJfvQTmQqyFKQvI87S3FRGfZGE+F0uFoi9dJ5u7B/XG93/
         a4Clg2aBpf3jkXH542On1wVIig18258pLrX11Xpi6Riq/GJoTJ0zjTHkaFzmrurHhhiL
         Hto6LxY8QvORibj0uKW+87j2+H+BhmPENxnb7v5MSCqRsmgz6cnXrcXVo/4MYNqOlTzP
         zKecV2J9M6a9raGS4MldSVDbPqsw4B1b6rTlQfRUD1HaqxRbS0tOH9CSCidrYg3tAY1W
         7g3VLEc8NDk055QA1qLKdLSRwVrsYL/gvuWGUBFmpgbgn3tKtWICof8T7TqoyjxUMd19
         hpZg==
X-Gm-Message-State: AOAM530UzRQtX5j+OtraP0jSHB3f3NScapK4RVFwWGpaVvpBEW87tCuA
        ABSQbQ67PdpqGXlOb9KkD9AWb6SUioFMIky4nr2JymgCx4k=
X-Google-Smtp-Source: ABdhPJxhYREczc9iLVovDzjU48QsJU0KQxIpCixjxea5GpU3byn+IKq4EL/Z4k1bbyGdAhZ9hlMtlKWk1xaYURinc9g=
X-Received: by 2002:a92:c090:: with SMTP id h16mr4769444ile.235.1639506538741;
 Tue, 14 Dec 2021 10:28:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <cd8667450f7a0daf6b4081276e11a5f7bed60128.1639432170.git.andreyknvl@google.com>
 <Ybjbw5iPg2BWsgqF@elver.google.com>
In-Reply-To: <Ybjbw5iPg2BWsgqF@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 14 Dec 2021 19:28:48 +0100
Message-ID: <CA+fCnZfx-if88cgRQ3bZM4aDriCiEx7Bg9RFw_9GMQn2JiwCcQ@mail.gmail.com>
Subject: Re: [PATCH mm v3 28/38] kasan, page_alloc: allow skipping memory init
 for HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 7:00 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, Dec 13, 2021 at 10:54PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Add a new GFP flag __GFP_SKIP_ZERO that allows to skip memory
> > initialization. The flag is only effective with HW_TAGS KASAN.
> [...]
> > - * is being zeroed (either via __GFP_ZERO or via init_on_alloc).
> > + * is being zeroed (either via __GFP_ZERO or via init_on_alloc, provided that
> > + * __GFP_SKIP_ZERO is not set).
> > + *
> > + * %__GFP_SKIP_ZERO makes page_alloc skip zeroing memory.
> > + * Only effective when HW_TAGS KASAN is enabled.
> >   *
> >   * %__GFP_SKIP_KASAN_UNPOISON makes KASAN skip unpoisoning on page allocation.
> >   * Only effective in HW_TAGS mode.
> > @@ -242,6 +247,7 @@ struct vm_area_struct;
> >  #define __GFP_COMP   ((__force gfp_t)___GFP_COMP)
> >  #define __GFP_ZERO   ((__force gfp_t)___GFP_ZERO)
> >  #define __GFP_ZEROTAGS       ((__force gfp_t)___GFP_ZEROTAGS)
> > +#define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
> >  #define __GFP_SKIP_KASAN_UNPOISON ((__force gfp_t)___GFP_SKIP_KASAN_UNPOISON)
> >  #define __GFP_SKIP_KASAN_POISON   ((__force gfp_t)___GFP_SKIP_KASAN_POISON)
> >
> > @@ -249,7 +255,7 @@ struct vm_area_struct;
> >  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
> >
> >  /* Room for N __GFP_FOO bits */
> > -#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
> > +#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
>
> You're adding several new flags, I think you should also make a
> corresponding change to include/trace/events/mmflags.h?
>
> At least __GFP_SKIP_KASAN_POISON is currently in there.

Indeed, will fix in v4. Thanks!
