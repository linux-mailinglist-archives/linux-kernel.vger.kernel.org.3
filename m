Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4291D534C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346850AbiEZJMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344454AbiEZJMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:12:38 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78386B09A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:12:36 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id s5so1160317qvo.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+o2YcuR2VIuL1UcC5E0Jvkv57l2f8KjFuaXh67xM/k=;
        b=JYxigCBpH8ZBGuIF6XPxWncLxt4T9ombQz+1bTQhxmfqLCyZtjAbkj/phuGtv3T6rF
         il3/VxueO45ALW2WgNwuURLOiMvOyQrB0bIYiiuePMpbIclxu9Bjm9im4kDhHqdrESzX
         0OYw9hnhdk4efGRrvdw79p/v7ps5IzYrsClYaPbtVw8k0gGUVMGZYXdvLbJaG8TyOAzy
         I8Q4GnivoWW4eUyVk9/RGp0XusvSJL4dE34Wnv27kQ5C3Gs7bkGteT0cOegbLZILYb9+
         vdZ4H9EkDUNknA3bzk+QA7gCxh/xUYCuu3BR2OO+DRxK9St6DZ6giJQ6DgBu55kLFaKd
         Uw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+o2YcuR2VIuL1UcC5E0Jvkv57l2f8KjFuaXh67xM/k=;
        b=FNZecuqJHk6Gv5MVVOrA4LnV7picwy7hnOhHf09hC4T483Az2mV76oPZWKL109vONB
         HAwz/D5IQsi97Ca3+hgRn4F92xB6R4Ist+zcG1qfB08jw4dcW9guxuM6gnYV1xoJsBRU
         TwcpxaTlx3HWbkL9IA3N1IdaDX0cKjZpbO3Nq/AHRlMw7VLvny280y2UHvLxTNG/2WIC
         D0O4ztLSaHT1QVO+chAC4ZthBFRsjjRNKOJsvJXGUnO/E9UzJXNMKucCl6csXpoblL5/
         0d9o2yB/PcQRIHsJqxKYHQrdG5Th7OwVp04KfeZMLgqt1eyM2fj7ReS6xOTuilcYLdkr
         L1tA==
X-Gm-Message-State: AOAM53330fRbV1kWX2bUdLGsGD7RnGS/iHWSsjt6ag4Q6rZy0vy+x5oR
        MZx60MPG+/8pM1CkoGMPqyuMP+Otuj4RFlk1irw=
X-Google-Smtp-Source: ABdhPJxL2PCQwJv9VA7wB5yCOCbjSBGDUITXR8oAnboNztQtuH+3ApmGx8UoaJ7e5GK6eKYS71+nHGaN90YGa098GHw=
X-Received: by 2002:a05:6214:20e6:b0:45d:403f:7a90 with SMTP id
 6-20020a05621420e600b0045d403f7a90mr29051949qvk.1.1653556355924; Thu, 26 May
 2022 02:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220525144013.6481-1-ubizjak@gmail.com> <20220525144013.6481-3-ubizjak@gmail.com>
 <CAHk-=whXtP1XT2cVDFKK2-Xz5Z=7AFki4zwFzenm4bbf4iPJKg@mail.gmail.com> <48001b3d732b418eb5f36def228c2c9d@AcuMS.aculab.com>
In-Reply-To: <48001b3d732b418eb5f36def228c2c9d@AcuMS.aculab.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 26 May 2022 11:12:24 +0200
Message-ID: <CAFULd4Z2pdZhtOLH+BDZBwfruzwZx_HiJJpLrAm-mZUbd88j=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF
 for X86_32 && X86_CMPXCHG64
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Waiman.Long@hp.com" <Waiman.Long@hp.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
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

On Thu, May 26, 2022 at 10:30 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Linus Torvalds
> > Sent: 25 May 2022 17:30
> >
> > On Wed, May 25, 2022 at 7:40 AM Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > +       select ARCH_USE_CMPXCHG_LOCKREF if X86_64 || (X86_32 && X86_CMPXCHG64)
> >
> > Ugh. That looks pointlessly complicated. X86_64 already enables
> > X86_CMPXCHG64 afaik, so you can just say
> >
> >         select ARCH_USE_CMPXCHG_LOCKREF if X86_CMPXCHG64
> >
> > which is much clearer: CMPXCHG_LOCKREF needs CMPXCHG64, and the
> > Kconfig option says exactly that.
> >
> > That said, this also makes me wonder if we should just make cmpxchg8b
> > requirement unconditional.
> >
> > Googling around, it looks like Windows NT stopped booting on CPUs
> > without cmpxchg8b in version 5.1. That was in 2001.
> >
> > Here we are, 21 years later, and we still ostensibly try to support
> > CPUs without it, but I doubt it's worth it.
> >
> > So maybe time to just say "we require cmpxchg8b".
> >
> > In fact, I think we have effectively done that already for years, since we have
> >
> >     config X86_CMPXCHG64
> >             def_bool y
> >             depends on X86_PAE || ...
> >
> > iow, enabling X86_PAE will force-enable CMPXCHG8B due to the wider
> > page table entries.
> >
> > And I would assume that all distros basically do that anyway (but I do
> > not have a 32-bit distro around to check).
> >
> > It would mean that we would finally drop support for i486 (and
> > possibly some Pentium clones, but afaik a number of them did actually
> > support cmpxchg8b even if they didn't report it in cpuid).
>
> Perhaps there could be a non-smp implementation of cmpxchg8b
> that just disables interrupts?
>
> While I have used a dual 486 I doubt Linux would run ever
> have on it. The same is probably true for old dual Pentiums.
>
> I think there are still some 486-class embedded cpu that include
> a few of the newer instructions (usually things like rdtsc).
> But they won't be smp.

The above solution is already implemented when X86_CMPXCHG64 is not
defined. Please see arch/x86/include/asm/cmpxchg_32.h, where in this
case we have:

#define arch_cmpxchg64(ptr, o, n)                \
({                                \
    __typeof__(*(ptr)) __ret;                \
    __typeof__(*(ptr)) __old = (o);                \
    __typeof__(*(ptr)) __new = (n);                \
    alternative_io(LOCK_PREFIX_HERE                \
            "call cmpxchg8b_emu",            \
            "lock; cmpxchg8b (%%esi)" ,        \
               X86_FEATURE_CX8,                \
               "=A" (__ret),                \
               "S" ((ptr)), "0" (__old),        \
               "b" ((unsigned int)__new),        \
               "c" ((unsigned int)(__new>>32))        \
               : "memory");                \
    __ret; })

Without CX8, the code will be patched to the call to cmpxchg8b_emu,
defined in arch/x86/lib/cmpxchg8b_emu.S.

I think that the solution with CONFIG_X86_CMPXCHG64 is quite good.
When defined, arch_cmpxchg64 defines the real CMPXCHG8B instruction.
Without the config flag, the above definition is compiled in and the
code is patched to either the call or the real instruction during
runtime. Also, the config flag makes difference only in
arch/x86/include/asm/cmpxchg_32.h, and with try_cmpxchg64 fallbacks,
one can still use cmpxchg64/try_cmpxchg64 even when the HW doesn't
support CMPXCHG8B natively.

Uros.
