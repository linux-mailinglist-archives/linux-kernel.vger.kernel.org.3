Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC42B481F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbhL3TLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbhL3TLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:11:40 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B54CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:11:40 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id u8so30639821iol.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPu8b1zm5l26lxQv3Kupma6jp1vzEvVrzyOVnWiH1iE=;
        b=DYv3/L8m1C+//6z+gGBtZ/Gw6/jDkpDfeubB94WOXRybqSfTsUPpy5xIbr5IkDJ456
         JFEINKg4J05U2tkD/QrPPlwFN+A7cQYH9E1BaXLUmK9J51tWxFid53hemXZN2ghKiy+X
         l0BCjUhBRNJFw/5xQU+n5iWpc7X05leuU7BVHLqtypKkSsYf2xmT9I1QSRpHgzTOJCI0
         h5cfLuhqd47B9NjWP6vUfu0cUb6tgQ/cZ3Bhp4LzTqlpjPsfR0QRPdzkffYHgpEG6sp+
         89RT6aqi+aLmDulYeixtBoavmr8y8/Kcch00iAa4e2BQFPr9MpND5oxOXGVMaruY6eTL
         ec1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPu8b1zm5l26lxQv3Kupma6jp1vzEvVrzyOVnWiH1iE=;
        b=EiVM23KngH7+FKPZPRPJuAQHLAAD1BZV4vLkpeX9ddp72dWb9GZuJFA0Sgf1q5zPcs
         o8h2/MTMaRnI6X0gKM27JnshkVtHHGP4HT/nT6FZSlNPDfysFUlQmBpX4yTqwR6TTRot
         s418F0Xj36imVL4rOVkpKBqVEECnfwtn0TdzwGxKYSSDqv3CeMEfuUNDBCAlzXx+EtR0
         56RC+NY8fNNenzSw2T7/C9nW0EcOE+f4Jc2waNU8TiQhwrMFsPNZj9xAFMmWwxasSVuY
         TRpzaQaQrgg0kWIXwApe4eXMfOqmIkT3VO/MRW+F/m3/CDIdvSTTJJiMOjtqgyYj9KFd
         QDQw==
X-Gm-Message-State: AOAM5306RRFmB+HxrJ7rLgn7XXI5oNHpChCo4xUw4DxWIhzst8N/E5Mn
        2nIffXQgSSyWWOqwBf9QZkohG4rV9ZSeYOcPPA4=
X-Google-Smtp-Source: ABdhPJyWzqTL/fogtFxden0UIQV4GZQcWfMzs9KPHNVuo+ldoHL4+1vn/FYeyBb2TQf6AkWo5N4E5H1RNdasgZpp5e0=
X-Received: by 2002:a05:6602:26d0:: with SMTP id g16mr8170007ioo.56.1640891499870;
 Thu, 30 Dec 2021 11:11:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <73a0b47ec72a9c29e0efc18a9941237b3b3ad736.1640036051.git.andreyknvl@google.com>
 <YcHC5c9ssDrcnORl@elver.google.com>
In-Reply-To: <YcHC5c9ssDrcnORl@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 30 Dec 2021 20:11:29 +0100
Message-ID: <CA+fCnZdFJ3r8bcpqhMz5fLn63DoecE1kJY1fvcmpP7zg+Q2Fig@mail.gmail.com>
Subject: Re: [PATCH mm v4 28/39] kasan, page_alloc: allow skipping unpoisoning
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

On Tue, Dec 21, 2021 at 1:05 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, Dec 20, 2021 at 11:02PM +0100, andrey.konovalov@linux.dev wrote:
> [...]
> >  #ifdef CONFIG_KASAN_HW_TAGS
> >  #define __def_gfpflag_names_kasan                                          \
> > -     , {(unsigned long)__GFP_SKIP_KASAN_POISON, "__GFP_SKIP_KASAN_POISON"}
> > +     , {(unsigned long)__GFP_SKIP_KASAN_POISON, "__GFP_SKIP_KASAN_POISON"} \
> > +     , {(unsigned long)__GFP_SKIP_KASAN_UNPOISON,                          \
> > +                                             "__GFP_SKIP_KASAN_UNPOISON"}
> >  #else
> >  #define __def_gfpflag_names_kasan
> >  #endif
>
> Adhering to 80 cols here makes the above less readable. If you do a v5,
> my suggestion is:
>
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index f18eeb5fdde2..f9f0ae3a4b6b 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -51,11 +51,10 @@
>         {(unsigned long)__GFP_ZEROTAGS,         "__GFP_ZEROTAGS"}       \
>
>  #ifdef CONFIG_KASAN_HW_TAGS
> -#define __def_gfpflag_names_kasan                                            \
> -       , {(unsigned long)__GFP_SKIP_ZERO, "__GFP_SKIP_ZERO"}                 \
> -       , {(unsigned long)__GFP_SKIP_KASAN_POISON, "__GFP_SKIP_KASAN_POISON"} \
> -       , {(unsigned long)__GFP_SKIP_KASAN_UNPOISON,                          \
> -                                               "__GFP_SKIP_KASAN_UNPOISON"}
> +#define __def_gfpflag_names_kasan ,                                                    \
> +       {(unsigned long)__GFP_SKIP_ZERO,                "__GFP_SKIP_ZERO"},             \
> +       {(unsigned long)__GFP_SKIP_KASAN_POISON,        "__GFP_SKIP_KASAN_POISON"},     \
> +       {(unsigned long)__GFP_SKIP_KASAN_UNPOISON,      "__GFP_SKIP_KASAN_UNPOISON"}
>  #else
>  #define __def_gfpflag_names_kasan
>  #endif

Will do in v5, thanks!
