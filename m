Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C03524175
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349620AbiELAUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345344AbiELAUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:20:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA11654B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:20:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq30so6319204lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hmOCXqJx3aPNv4toFluqExpM2fAmi+JPCbe0noGaZQw=;
        b=RJmRo0HgfC9Kf3yO0+w2/I5Wdot1ejiTWXVtN28t570/TpcfZ0rXnWvezeh6gmWdW+
         UOUa64hf/XUk253RtaHBUlobyqh8Y+2ZpxgEGnOaHs6TxXvVIToG+1RR946wBgrFAbyk
         opCld9z+r4zI7R/FHeYrNOtWFdLHzDZnUBfnxP0+3Iluf55T61NuXpsg3uCRJt5THX+Z
         dsCbcwhJWJcxK/xhknvj1IRvrgMGuYkHvKSkbDh0K6RlnFIAHL3yN8oHALbCM7IN/dAE
         86sTXvEBhUVpOfFCalqkkPuWXTYJALcsdV3Jf6WEosfXUhH1BRbZNdlp0F/HZncqS63c
         FlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hmOCXqJx3aPNv4toFluqExpM2fAmi+JPCbe0noGaZQw=;
        b=xYCvUX2FxHDFySsx2iouMU/98CxKAQ7vIxw//27I924Mm7KtwtyMUQGy1s1HbKTX7X
         4ejRzXpFwdLCs3SBSF49ZGy294hTDIcnXE/sBbwLh7ERIsyO3mvN76QAaDPL9DmU65Rr
         YjJVTPrk+MO1q/4MVdSzdQXvE66gGuOGH17peci3JybURabDtw+eF0Z9/WFBweIU2JVE
         VlFauoWDCKACQBbzaAajpgx6igNlAe2sRCWZVmGD7QjnONpoLYhnFhv4iZj10Yz4na2m
         sNj767SrsQUZFP086c0Nxls6cHJ7J4YidLOnqwGXaQcnKF/TH6nroP6ojret1QTDOUdf
         teiw==
X-Gm-Message-State: AOAM532SSWXkHQdG8ld4QjxHWbiUFRBbeQvN0FaIY2rLecMMEyVFmFpH
        gCQo7NILP/N8C9UJGC5yB0T4UTmkbTILiFgzUrp9zA==
X-Google-Smtp-Source: ABdhPJyJa8CFD2lJb3SXoKRhg9zlKbw7LnvKB8sRqmoJ23L1zXPSQZb94ZFTj6dAS5ma5T1eblHEUYAN6lJ7kSfAXhA=
X-Received: by 2002:ac2:5e86:0:b0:473:d044:60f5 with SMTP id
 b6-20020ac25e86000000b00473d04460f5mr22024882lfq.87.1652314806600; Wed, 11
 May 2022 17:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220512000340.1171988-1-mailhol.vincent@wanadoo.fr> <20220512000340.1171988-3-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220512000340.1171988-3-mailhol.vincent@wanadoo.fr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 17:19:54 -0700
Message-ID: <CAKwvOdntx-ZBqVYhdeOO4C1tF4Mx=OpFNYBQUfB=iXjfQO9bvw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to
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

On Wed, May 11, 2022 at 5:04 PM Vincent Mailhol
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
> So, roughly 27.9% of the calls to either __ffs() or ffz() were using
> constant expressions and could be optimized out.
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

Thanks for the patches!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


-- 
Thanks,
~Nick Desaulniers
