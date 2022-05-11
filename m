Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599D7524028
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348670AbiEKWVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiEKWVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:21:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366BFC9EC7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:21:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j4so5933257lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gq1+NP4bVcZsTpgmI3ILx7iZ+3jeAijEccWu0b0YoYI=;
        b=WI+1aqUxBTsltz4N1yePfUuV4TnoYW7RSHWwCcL/LA0aBuyeeAM3G1TSkAaGAZAkB0
         YXtY97TfzPxFad/utToWChFQ7m+zJShzMu9135dqbNrwuj1fSgHysz4G9l3hDJW3Lx04
         3dn9OE+1heT4hXm0ej8Rni52gkm6vqHImRKAaMhlaTPJ2MJuvldiA19hm8Tf6D8EiXCa
         FShtU7hYmLnANb50ThA+HRgaCxAClNZEnHl5XSLw/5QE+ngyAs8ZGEQYYNKMCVYqsVC8
         s4L1QEqJpFjC9PcIyucQpMAdAY19CO0yj9qUMlWacP/6IOxrzDY3eKmDT2UCQa52+EK1
         b2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gq1+NP4bVcZsTpgmI3ILx7iZ+3jeAijEccWu0b0YoYI=;
        b=dNz4VNXWiOgUvOdkQooUDuB4v4SJCMulf0gSwPKFGkTkLWh0atQ8IyueWv4+ja6Nyb
         qtjuRH3fKZ5cS1spTU5AG+F0E3p4VQeBJE2x8E6bD/rK6LwjU/M7Mq6jiF3zHJZIxtkk
         W5girxznA7e1ibSf5TJ9DCbm8TYig+scRfWvnkie7zpL79aP+P8NaawUs7qOxXxqlMCo
         qe97arwXzl1cgx2PWWszAMrplCeKOH/xeIauVb4nSmm+9FTKxvIO3gTsLnJUeAdQfICG
         FYFasNtI+6rEkrcK0KcDiJsERDhK2ac+PJ/xJcmHcVHjxi4iW+8zhgVnot3iO2IAAQVf
         tMrA==
X-Gm-Message-State: AOAM531Xln/sjfIrSXFcQHUUizPOmAugMn8Ke57g7/CBTTGfAD2fEWV8
        arbOoy/sXmnHovyzwca5yreAzF5/0rgsoOKEmMcZmg==
X-Google-Smtp-Source: ABdhPJxnq/Mno8gj8OXg+JSR2ofs+6YCGnScuRp2exZBfsKfOZiEzAzdOB0OFAzd2W2XZCTHnvYJGntHkJIBDoBmnms=
X-Received: by 2002:a05:6512:3047:b0:473:cf43:6d8f with SMTP id
 b7-20020a056512304700b00473cf436d8fmr22589970lfb.380.1652307667340; Wed, 11
 May 2022 15:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr> <20220511160319.1045812-3-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220511160319.1045812-3-mailhol.vincent@wanadoo.fr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 15:20:55 -0700
Message-ID: <CAKwvOdmDL3CiL11TCXQDJ2tKDbLC+72-TxXOvyO9kA6KKiruKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to
 evaluate constant expressions
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>
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

On Wed, May 11, 2022 at 9:04 AM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> __ffs(x) is equivalent to (unsigned long)__builtin_ctzl(x) and ffz(x)
> is equivalent to (unsigned long)__builtin_ctzl(~x). Because
> __builting_ctzl() returns an int, a cast to (unsigned long) is
> necessary to avoid potential warnings on implicit casts.
>
> For x86_64, the current __ffs() and ffz() implementations do not
> produce optimized code when called with a constant expression. On the
> contrary, the __builtin_ctzl() gets simplified into a single
> instruction.
>
> However, for non constant expressions, the __ffs() and ffz() asm
> versions of the kernel remains slightly better than the code produced
> by GCC (it produces a useless instruction to clear eax).
>
> This patch uses the __builtin_constant_p() to select between the
> kernel's __ffs()/ffz() and the __builtin_ctzl() depending on whether
> the argument is constant or not.
>
> ** Statistics **
>
> On a allyesconfig, before applying this patch...:
>
> | $ objdump -d vmlinux.o | grep tzcnt | wc -l
> | 3607
>
> ...and after:
>
> | $ objdump -d vmlinux.o | grep tzcnt | wc -l
> | 2600
>
> So, roughly 27.9% of the call to either __ffs() or ffz() were using
> constant expression and were optimized out.
>
> (tests done on linux v5.18-rc5 x86_64 using GCC 11.2.1)
>
> Note: on x86_64, the asm bsf instruction produces tzcnt when used with
> the ret prefix (which is why we grep tzcnt instead of bsf in above
> benchmark). c.f. [1]
>
> [1] commit e26a44a2d618 ("x86: Use REP BSF unconditionally")
> http://lkml.kernel.org/r/5058741E020000780009C014@nat28.tlf.novell.com
>
> CC: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Patch LGTM, though I find the location of the double unscores in the
names slightly against my taste.

> ---
>  arch/x86/include/asm/bitops.h | 38 ++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 6ed979547086..7cf5374ce403 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -224,13 +224,7 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
>          ? constant_test_bit((nr), (addr))      \
>          : variable_test_bit((nr), (addr)))
>
> -/**
> - * __ffs - find first set bit in word
> - * @word: The word to search
> - *
> - * Undefined if no bit exists, so code should check against 0 first.
> - */
> -static __always_inline unsigned long __ffs(unsigned long word)
> +static __always_inline unsigned long __variable_ffs(unsigned long word)

How about `variable___ffs`? Patch 1/2 used `variable_ffs` for `ffs`?

>  {
>         asm("rep; bsf %1,%0"
>                 : "=r" (word)
> @@ -238,13 +232,18 @@ static __always_inline unsigned long __ffs(unsigned long word)
>         return word;
>  }
>
> -/**
> - * ffz - find first zero bit in word
> - * @word: The word to search
> - *
> - * Undefined if no zero exists, so code should check against ~0UL first.
> - */
> -static __always_inline unsigned long ffz(unsigned long word)
> +/**
> + * __ffs - find first set bit in word
> + * @word: The word to search
> + *
> + * Undefined if no bit exists, so code should check against 0 first.
> + */
> +#define __ffs(word)                            \
> +       (__builtin_constant_p(word) ?           \
> +        (unsigned long)__builtin_ctzl(word) :  \
> +        __variable_ffs(word))
> +
> +static __always_inline unsigned long __variable_ffz(unsigned long word)

`ffz` had no underscore. Regardless of `__ffs`, this should definitely
be `variable_ffz` IMO.

>  {
>         asm("rep; bsf %1,%0"
>                 : "=r" (word)
> @@ -252,6 +251,17 @@ static __always_inline unsigned long ffz(unsigned long word)
>         return word;
>  }
>
> +/**
> + * ffz - find first zero bit in word
> + * @word: The word to search
> + *
> + * Undefined if no zero exists, so code should check against ~0UL first.
> + */
> +#define ffz(word)                              \
> +       (__builtin_constant_p(word) ?           \
> +        (unsigned long)__builtin_ctzl(~word) : \
> +        __variable_ffz(word))
> +
>  /*
>   * __fls: find last set bit in word
>   * @word: The word to search
> --
> 2.35.1
>


-- 
Thanks,
~Nick Desaulniers
