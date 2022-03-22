Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96FE4E44A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiCVREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiCVREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:04:06 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A75D46B14
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:02:38 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u3so24904150ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIBwyCFA8yu0ZwbObg31b7AuYcniAsjV38ZCEKNbmEs=;
        b=eLZjTCnmz/MJskMW0Kx+WYB3YbOumPc4a5X5vE0tih1aCTVrAd15AW4a/LR/YaaAnj
         DmZKFF4T2mmVHwy1yi6h3xezVUEJxEB8h7TCOGIf/WXVynxd8dyZbf2xG51ZbuNE8uCY
         PsGMa75RvSN/Dk+hf2DCnaUb5U/LGy4iLRcjpauITH+wqbfRcvDR3Bcxi6ypKq7Ji16E
         V3mNIFubUOJq3hX5giXxQVCDJuJB9b1AAFbtVYjcP58tL6nG5NAtSg60NCFOPwMxpov4
         SEaRKk7aGFiKjpGi4E3+3futcITEJIpJ7XMhTwvw9hlabBqrZyO7c79WwRa7g1Af+Pkf
         rJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIBwyCFA8yu0ZwbObg31b7AuYcniAsjV38ZCEKNbmEs=;
        b=hs6enbXlmNakulUepHBod2cF39MZ2KjzzqmRgx+LJQGvxzrnn11o6tlFfRdSmk5NqW
         fT243ixcmantQ7ULx9fA3wPNARFLKWnbrub0EhMYnoCZ+lwuMk0kPBdbRWcvugwYSqId
         NDf0irxs8B1FcT8DYU+51LpFFdojPNZ2N6fiTubMEtGTNu4KIa1mt5Wvq5T2sQSjPDgt
         fFnrRndlzxmLHLvUzjlSqquRTAn/+CsXP+ZFa8ww3J0fK7N6nMIXgvD1xioPtpE84VPd
         5JoS6Tp8s2CjbYXFhMZaNQcRNWD/IB0DMmTwQReKcxqkEfHYVgVvWYgKtRQ8j/cDrEFN
         9TDA==
X-Gm-Message-State: AOAM531xLG9KSjdRPfQZdS/LKeglKoczW0tEZA0G4Qj0SuBfc2s7czyP
        0yF3S+KpOmQNth6ppngTUGrYPu3c9tluIkjc6uvOtATrqrqIpogS
X-Google-Smtp-Source: ABdhPJz56XKTAMhxLOEhU4dMPRaQZpKutqbXKi+guc67m6Jv0gTpaFk3QWQR3g81THfjHOADVBK+pIn/W0HiBnTV7xM=
X-Received: by 2002:a05:651c:1791:b0:243:94bd:d94c with SMTP id
 bn17-20020a05651c179100b0024394bdd94cmr19231645ljb.468.1647968554603; Tue, 22
 Mar 2022 10:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220316183833.1563139-1-arnd@kernel.org> <3b9cedd6-a084-5d87-2fdd-0da10146827b@arm.com>
 <CAKwvOdnut8db1Z1FdZkkSXCvmggrzfKv9Y9GO3uz4ND=K5sB3g@mail.gmail.com>
In-Reply-To: <CAKwvOdnut8db1Z1FdZkkSXCvmggrzfKv9Y9GO3uz4ND=K5sB3g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 22 Mar 2022 10:02:23 -0700
Message-ID: <CAKwvOdkyGumBcCWwNo+yBFZ_A9OOFgVCOecOgpcfEunNRqy_+w@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix clang warning about TRAMP_VALIAS
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Fri, Mar 18, 2022 at 12:52 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Mar 18, 2022 at 12:11 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2022-03-16 18:38, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > The newly introduced TRAMP_VALIAS definition causes a build warning
> > > with clang-14:
> > >
> > > arch/arm64/include/asm/vectors.h:66:31: error: arithmetic on a null pointer treated as a cast from integer to pointer is a GNU extension [-Werror,-Wnull-pointer-arithmetic]
> >
> > Tangentially, all the other GNU extensions we depend on throughout Linux
> > are also GNU extensions. Do we know what's special about this one?
>
> My first thought is that -Wnull-pointer-arithmetic should be in the
> -Wgnu flag group, such that -Wno-gnu (as set by Kbuild) implies
> -Wno-null-pointer-arithmetic.
>
> One issue seems to be that -Wnull-pointer-arithmetic seems to control
> at least 2 different checks in clang.
>
> https://godbolt.org/z/hdYYejj3d
>
> So it's likely these two checks should have 2 distinct flags, such
> that the warning we're observing can be grouped under -Wgnu.
>
> Filed: https://github.com/llvm/llvm-project/issues/54444

Fix should be landing shortly:
https://reviews.llvm.org/D122224

-- 
Thanks,
~Nick Desaulniers
