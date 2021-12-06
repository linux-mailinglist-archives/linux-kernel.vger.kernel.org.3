Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED1246A932
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350198AbhLFVOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350185AbhLFVOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:14:09 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CF8C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:10:40 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id 14so14540843ioe.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwRwUjyY6hc655acCUnran3GDnVqWndaVhYkx0l7k24=;
        b=mwEsGhvX6mKD+PVSJnfyedkcuQZfQ85ka5ZM+pIUTJvypKSVlZbwvZQnoLOIdLLSfz
         d53QGen/VHPQHZHJnJML4AAGs50OvW/T3mUwMX4hPmIlLy17bXza5ibkFUB5gaNjj/gL
         UscROk83VQmLC/10OHyPmC+uFXJao4vSiRu9MPJPSmJHVuzRvfc30x9wymJJ68+xUZkP
         k5RIX1nMa/9ne6312KPMRSdIRkPMxC7giU2CEbpGh20bQx+IANVWekzCTfnliiKfhkxs
         6ogDSgImlcO/ci0PV/MA+YmId6kp/hdI5FpJZAUt8exGQ6BG/9PylF4h5FBZsOpATG9x
         lCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwRwUjyY6hc655acCUnran3GDnVqWndaVhYkx0l7k24=;
        b=SUCrwyO0HoY5+wuaEUvcziFeF2VWGT9pguuHf8jGafLuBPGk15iYaWrTjBCdnMTz+g
         WjY84+5Y/BF7JvVdBc7dvh1sPip/2p1oiWyv2bwx2gvRgML3F9jsDq0VSE14Rv9Llhf0
         DcAKEfQvrM52SLH2BUy82FErSHEUg1Z1EeLuu0rvBkAvXfS+YRm7HKkSsEajSQrlQxFJ
         efetYieNfrR2B5nIUFYX0qWcKI+h3ZY2wdMbYknxoQ2gN0pzFqs1/J9VnY8c8CDDOcWu
         fKZh8iGuDFE9T0ZOkNj0q7Mk2Vydfpqe82n6CvR0BAVKrJ87N4+UxwACaj/HcE14yR9y
         kGFg==
X-Gm-Message-State: AOAM533FQhCwkQYJSTN4+jeUg0NcLM9yqP3gc7JRSH298AVmpvX25sWF
        qrXPw3rVDnsT79lZ7dZK2gGmsQFcgyhgOl3ZIX4=
X-Google-Smtp-Source: ABdhPJz9/8bJnfrPY/6R3plha0QHLKoEihYxy3HjH3SBNEAb3ptkLzGgT0n6k8AW2FJDSpHv5aZBS4DEePnWzJICXJQ=
X-Received: by 2002:a5e:d502:: with SMTP id e2mr38338219iom.118.1638825039996;
 Mon, 06 Dec 2021 13:10:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <8afdf7eb0bae77d2e94210d689d524580cf5ed9a.1638308023.git.andreyknvl@google.com>
 <Yadd+oOVYSOPoWMS@elver.google.com>
In-Reply-To: <Yadd+oOVYSOPoWMS@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 6 Dec 2021 22:10:29 +0100
Message-ID: <CA+fCnZdJCCRNLWD0QdgrXTocwDMroQ_MsBNi36N3JBG-UiVNvw@mail.gmail.com>
Subject: Re: [PATCH 29/31] kasan, arm64: allow KASAN_VMALLOC with HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 12:35 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 30, 2021 at 11:08PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > vmalloc tagging support for HW_TAGS KASAN is now complete.
> >
> > Allow enabling CONFIG_KASAN_VMALLOC.
>
> This actually doesn't "allow" enabling it, it unconditionally enables it
> and a user can't disable CONFIG_KASAN_VMALLOC.
>
> I found some background in acc3042d62cb9 why arm64 wants this.

Indeed. Will adjust the description in v2.

> > Also adjust CONFIG_KASAN_VMALLOC description:
> >
> > - Mention HW_TAGS support.
> > - Remove unneeded internal details: they have no place in Kconfig
> >   description and are already explained in the documentation.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/Kconfig |  3 +--
> >  lib/Kconfig.kasan  | 20 ++++++++++----------
> >  2 files changed, 11 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index c05d7a06276f..5981e5460c51 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -205,8 +205,7 @@ config ARM64
> >       select IOMMU_DMA if IOMMU_SUPPORT
> >       select IRQ_DOMAIN
> >       select IRQ_FORCED_THREADING
> > -     select KASAN_VMALLOC if KASAN_GENERIC
> > -     select KASAN_VMALLOC if KASAN_SW_TAGS
> > +     select KASAN_VMALLOC
>
> This produces the following warning when making an arm64 defconfig:
>
>  | WARNING: unmet direct dependencies detected for KASAN_VMALLOC
>  |   Depends on [n]: KASAN [=n] && HAVE_ARCH_KASAN_VMALLOC [=y]
>  |   Selected by [y]:
>  |   - ARM64 [=y]
>  |
>  | WARNING: unmet direct dependencies detected for KASAN_VMALLOC
>  |   Depends on [n]: KASAN [=n] && HAVE_ARCH_KASAN_VMALLOC [=y]
>  |   Selected by [y]:
>  |   - ARM64 [=y]
>
> To unconditionally select KASAN_VMALLOC, it should probably be
>
>         select KASAN_VMALLOC if KASAN

Will fix in v2.

Thanks!
