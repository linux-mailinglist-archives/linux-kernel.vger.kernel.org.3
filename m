Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3514849FA56
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241623AbiA1NHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241408AbiA1NHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:07:11 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B49C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:07:11 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id r65so18173960ybc.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YgGxwqesxYhk+GrHgJnKwpv75Cf0zbWqGe6zVs0QN+M=;
        b=cNBEtVx5FT1+KykCzEe9T2FFs9AIQBumaxy53+2enGDqLWGuhatShrWWnhC49Jy9xw
         VmTHspZqGebuddH4NHpFewL2UtFVBpApT3VtMcKLUIBuB/WhObXIS47vBZw4v3RpZ/HM
         q5of2qbhTXbKMMRrGBrJEwq9vP20jD9Q+OBNWFLYgvH+Bm4JCrCO2xlDtTR217dtey2i
         kuaKb7v1zs6oPJeRtzhyGmy3hR+bFGpG3lR36aJXckQNlP4uqZRLDN0mhpFpZCE81jEg
         ImcsFQXJCnKDW4AzBbhzX+Ajy1vnY2eqn+d9RADdGcZGQHfk43bOCwvVKr3QM2jXvMGF
         yH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YgGxwqesxYhk+GrHgJnKwpv75Cf0zbWqGe6zVs0QN+M=;
        b=P5ZMNOxYSTxHgnXmj4Ls0eyeH5OwRckPlkpc/PBR9DepS5/YjaWMbMl+27Jru8qIse
         /yEVMRROZVwJBNwRYoYlv9qT6e+aq+WAXYBj0bp5aq3ZLepTBiq1J0sdZ8JmGHus9/66
         oIMiIYmtT8i9pk6+HgD1/ZRHLUe/DWNEppwfv2Jta2mpCLGgZdnolI0we1bgQvmH7zhz
         urNcyU82lwsj9IJyPp9/jeR2S7kXb8tT087EYQUZYprIfM00E+MC91p6zUpp2oUUt66I
         Ak7XqkwsXKAMI+ynms66dBlNpqiOx3aEOxA/Z55/TCEQPs0GvXLJdhR2D8twCtFLlP2E
         YHOg==
X-Gm-Message-State: AOAM531H3kzdteINYgcK70R782lYELxK60kjmNmKoub+vGqqdMQItQf3
        f+S9OxmTkJYKZSDo8lxFf/s0qiknj5oV52D1EfFe1A==
X-Google-Smtp-Source: ABdhPJzb57UArYumAtcFeFp1C6yIxpu8it15t9WtSxwl45jhC2s8WeqrPkgaWoXnmz9TXVUA2MkZKhDWx0uFxL1ECgM=
X-Received: by 2002:a25:bb4d:: with SMTP id b13mr12751188ybk.129.1643375230778;
 Fri, 28 Jan 2022 05:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20220128100815.3231551-1-anders.roxell@linaro.org> <c6beb8a8-ecf3-1c17-f685-f5e69cd6265a@csgroup.eu>
In-Reply-To: <c6beb8a8-ecf3-1c17-f685-f5e69cd6265a@csgroup.eu>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 28 Jan 2022 14:07:00 +0100
Message-ID: <CADYN=9L=RB2AoBNU6Cfy2UKyznJy+oo0aPvapHp-v1f12uVs-A@mail.gmail.com>
Subject: Re: [PATCHv2] powerpc: mm: radix_tlb: rearrange the if-else block
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 at 11:14, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 28/01/2022 =C3=A0 11:08, Anders Roxell a =C3=A9crit :
> > Clang warns:
> >
> > arch/powerpc/mm/book3s64/radix_tlb.c:1191:23: error: variable 'hstart' =
is uninitialized when used here [-Werror,-Wuninitialized]
> >                                  __tlbiel_va_range(hstart, hend, pid,
> >                                                    ^~~~~~
> > arch/powerpc/mm/book3s64/radix_tlb.c:1175:23: note: initialize the vari=
able 'hstart' to silence this warning
> >                  unsigned long hstart, hend;
> >                                      ^
> >                                       =3D 0
> > arch/powerpc/mm/book3s64/radix_tlb.c:1191:31: error: variable 'hend' is=
 uninitialized when used here [-Werror,-Wuninitialized]
> >                                  __tlbiel_va_range(hstart, hend, pid,
> >                                                            ^~~~
> > arch/powerpc/mm/book3s64/radix_tlb.c:1175:29: note: initialize the vari=
able 'hend' to silence this warning
> >                  unsigned long hstart, hend;
> >                                            ^
> >                                             =3D 0
> > 2 errors generated.
> >
> > Rework the 'if (IS_ENABLE(CONFIG_TRANSPARENT_HUGEPAGE))' so hstart/hend
> > always gets initialized, this will silence the warnings. That will also
> > simplify the 'else' path. Clang is getting confused with these warnings=
,
> > but the warnings is a false-positive.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >   arch/powerpc/mm/book3s64/radix_tlb.c | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/boo=
k3s64/radix_tlb.c
> > index 7724af19ed7e..7d65965a0688 100644
> > --- a/arch/powerpc/mm/book3s64/radix_tlb.c
> > +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
> > @@ -1174,12 +1174,9 @@ static inline void __radix__flush_tlb_range(stru=
ct mm_struct *mm,
> >               bool hflush =3D false;
>
> You should then remove the default initialisation of hflush to false
> which has become pointless.
>
> With that fixed,
>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thank you for the review.
I will send a v3 shortly with that fixed.

Cheers,
Anders
