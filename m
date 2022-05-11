Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDEC5240FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349480AbiEKXYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349494AbiEKXYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:24:13 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ACAD60
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:24:11 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id j2so6885933ybu.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oy3Pm5sCLuohvb8vkD/fkUbAx0+U5niUi5E5iwOTC80=;
        b=Fc0G6AHCdIjYaiOyRQwi3V3I8t8+47LOCFwdm8KVUd7v9EgOiOkv5nII2+8OBja5At
         1mUeZmaB7Bw0eqPHM+3QB2o/8tp1mQfvNcA1IKEpOh5LhPiI1YAISke81HYFq3EwVsGv
         tACgvSrytn+uIlS/usnLt1ARLyUHxJP/GEzL7Hp2954V9VEU1KbQSuPIRcXKkhY21bGB
         nfWWnqlzVROARvlR8onos5v4ZJWDyKpNbwO3XODEuuzSHWEaKkU1DYsTgpTRfQRPeFW9
         HWhoO7ZVf6EDLbeFSZKmnCLTS/zhTbyptHNPmkroLHzfqJzJNdJndoEYd7NejZ5og8M7
         micw==
X-Gm-Message-State: AOAM533eIdmQ6biwwyJmBBRnhNdT8Pxm6K+Yy/PQEdDNRtlVd3JAfhqD
        UdhLxKx8/J1bIP5L+VmaGjjvC8DIAbrykQSYAzI=
X-Google-Smtp-Source: ABdhPJyVDRbFRlLmXJHpnwBSAwDxCMiSkisNBqSmSTztcJmphl3CHpb5Ya+K6Txjjw+vGr104VZX3qvLzgIdCyttuZ4=
X-Received: by 2002:a25:cb4b:0:b0:645:d702:eb15 with SMTP id
 b72-20020a25cb4b000000b00645d702eb15mr24152368ybg.500.1652311449899; Wed, 11
 May 2022 16:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220511160319.1045812-3-mailhol.vincent@wanadoo.fr> <CAKwvOdmDL3CiL11TCXQDJ2tKDbLC+72-TxXOvyO9kA6KKiruKQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmDL3CiL11TCXQDJ2tKDbLC+72-TxXOvyO9kA6KKiruKQ@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 12 May 2022 08:23:58 +0900
Message-ID: <CAMZ6RqJjYEpSL3bR59G4h74F_xGhns2cv_mHiG_yeLSgqrhjuQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to
 evaluate constant expressions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu. 12 May 2022 at 07:20, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Wed, May 11, 2022 at 9:04 AM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > __ffs(x) is equivalent to (unsigned long)__builtin_ctzl(x) and ffz(x)
> > is equivalent to (unsigned long)__builtin_ctzl(~x). Because
> > __builting_ctzl() returns an int, a cast to (unsigned long) is
> > necessary to avoid potential warnings on implicit casts.
> >
> > For x86_64, the current __ffs() and ffz() implementations do not
> > produce optimized code when called with a constant expression. On the
> > contrary, the __builtin_ctzl() gets simplified into a single
> > instruction.
> >
> > However, for non constant expressions, the __ffs() and ffz() asm
> > versions of the kernel remains slightly better than the code produced
> > by GCC (it produces a useless instruction to clear eax).
> >
> > This patch uses the __builtin_constant_p() to select between the
> > kernel's __ffs()/ffz() and the __builtin_ctzl() depending on whether
> > the argument is constant or not.
> >
> > ** Statistics **
> >
> > On a allyesconfig, before applying this patch...:
> >
> > | $ objdump -d vmlinux.o | grep tzcnt | wc -l
> > | 3607
> >
> > ...and after:
> >
> > | $ objdump -d vmlinux.o | grep tzcnt | wc -l
> > | 2600
> >
> > So, roughly 27.9% of the call to either __ffs() or ffz() were using
> > constant expression and were optimized out.
> >
> > (tests done on linux v5.18-rc5 x86_64 using GCC 11.2.1)
> >
> > Note: on x86_64, the asm bsf instruction produces tzcnt when used with
> > the ret prefix (which is why we grep tzcnt instead of bsf in above
> > benchmark). c.f. [1]
> >
> > [1] commit e26a44a2d618 ("x86: Use REP BSF unconditionally")
> > http://lkml.kernel.org/r/5058741E020000780009C014@nat28.tlf.novell.com
> >
> > CC: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
> Patch LGTM, though I find the location of the double unscores in the
> names slightly against my taste.
>
> > ---
> >  arch/x86/include/asm/bitops.h | 38 ++++++++++++++++++++++-------------
> >  1 file changed, 24 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> > index 6ed979547086..7cf5374ce403 100644
> > --- a/arch/x86/include/asm/bitops.h
> > +++ b/arch/x86/include/asm/bitops.h
> > @@ -224,13 +224,7 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
> >          ? constant_test_bit((nr), (addr))      \
> >          : variable_test_bit((nr), (addr)))
> >
> > -/**
> > - * __ffs - find first set bit in word
> > - * @word: The word to search
> > - *
> > - * Undefined if no bit exists, so code should check against 0 first.
> > - */
> > -static __always_inline unsigned long __ffs(unsigned long word)
> > +static __always_inline unsigned long __variable_ffs(unsigned long word)
>
> How about `variable___ffs`? Patch 1/2 used `variable_ffs` for `ffs`?

On a first glance, having the triple underscores in the middle of the
name seemed odd. On second thought, it is more consistent with the
rest, and I finally like the idea. Will be adopted in v3.

> >  {
> >         asm("rep; bsf %1,%0"
> >                 : "=r" (word)
> > @@ -238,13 +232,18 @@ static __always_inline unsigned long __ffs(unsigned long word)
> >         return word;
> >  }
> >
> > -/**
> > - * ffz - find first zero bit in word
> > - * @word: The word to search
> > - *
> > - * Undefined if no zero exists, so code should check against ~0UL first.
> > - */
> > -static __always_inline unsigned long ffz(unsigned long word)
> > +/**
> > + * __ffs - find first set bit in word
> > + * @word: The word to search
> > + *
> > + * Undefined if no bit exists, so code should check against 0 first.
> > + */
> > +#define __ffs(word)                            \
> > +       (__builtin_constant_p(word) ?           \
> > +        (unsigned long)__builtin_ctzl(word) :  \
> > +        __variable_ffs(word))
> > +
> > +static __always_inline unsigned long __variable_ffz(unsigned long word)
>
> `ffz` had no underscore. Regardless of `__ffs`, this should definitely
> be `variable_ffz` IMO.

ACK.

> >  {
> >         asm("rep; bsf %1,%0"
> >                 : "=r" (word)
> > @@ -252,6 +251,17 @@ static __always_inline unsigned long ffz(unsigned long word)
> >         return word;
> >  }
> >
> > +/**
> > + * ffz - find first zero bit in word
> > + * @word: The word to search
> > + *
> > + * Undefined if no zero exists, so code should check against ~0UL first.
> > + */
> > +#define ffz(word)                              \
> > +       (__builtin_constant_p(word) ?           \
> > +        (unsigned long)__builtin_ctzl(~word) : \
> > +        __variable_ffz(word))
> > +
> >  /*
> >   * __fls: find last set bit in word
> >   * @word: The word to search
> > --
> > 2.35.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
