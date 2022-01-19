Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA59A4938A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350468AbiASKft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbiASKfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:35:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BF4C061574;
        Wed, 19 Jan 2022 02:35:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 210AAB81981;
        Wed, 19 Jan 2022 10:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C6CC340EC;
        Wed, 19 Jan 2022 10:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642588544;
        bh=dLVBsjWsa3tGe7VI+gEjPAK21hcD2zsUppaxNspCidw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OY+FuNZsU4FCGv13S5pE17km9nFJ1sREVRgpDGQ3pF1hqIWYJj8cI5XCxXu372wy/
         x8qRQrobeWclhryEaq/pzYK0MrdOCEu9NcYrJ29i4IpnUqbQXN5oZ/Ibd1wYTh7Icr
         fIDmXjiYEcnQ4R5kQzKQWcrgUtdgL4TMU28ukJlmRMrmncy5mtPeWwlStAI7Z06KbW
         tQJpb54LWKlSp0sliFIzFwuiS98/B9vCwQaZtKuYxBKehYH5lDeD2kdFGSgM2bLL+H
         iYtuj0ZJhGM5vIlNeKiRPtvNK1JnwxlfhAVe7PRK4OZ9279oqgJmf5WHeBjEgVYksT
         olvWSmwJx5vpg==
Received: by mail-wm1-f43.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso13417779wmj.2;
        Wed, 19 Jan 2022 02:35:44 -0800 (PST)
X-Gm-Message-State: AOAM533KlsqsgcWikPieGJL2/nY1iuRJFxmdcWJBlFX3W58bSIP2WBtZ
        ahm+KhqtcegR1kUDPpoUgKehHFjUFtOAWngRa7E=
X-Google-Smtp-Source: ABdhPJxz62Vu1t8USPQKfzN9UxWCuXzIdAWIMYfTvzG08o48WSftiicOZMHsxR2P9Zuf5cNWB4skcW66Hpc+FiM5xGo=
X-Received: by 2002:a05:600c:3c9c:: with SMTP id bg28mr2778170wmb.190.1642588543206;
 Wed, 19 Jan 2022 02:35:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oX+4Ek81xy0nBOegqABH0xYqyONAqinsu7GZ7AaQaqYQ@mail.gmail.com>
 <20220119100615.5059-1-miles.chen@mediatek.com> <CAMj1kXE_6WboUK0VPbTwzTbMNxv8b4XUp7USQUp=YqcCRMTZig@mail.gmail.com>
 <CAHmME9o-=q6jT6mF3XsfoA17756YVEWdXGHukP=rxWS1gs5irg@mail.gmail.com>
In-Reply-To: <CAHmME9o-=q6jT6mF3XsfoA17756YVEWdXGHukP=rxWS1gs5irg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Jan 2022 11:35:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFdgPj7Ky-361QNAOLccr1mq5m9LSsPfbgpwV58fLAxJw@mail.gmail.com>
Message-ID: <CAMj1kXFdgPj7Ky-361QNAOLccr1mq5m9LSsPfbgpwV58fLAxJw@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 11:20, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On 1/19/22, Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Wed, 19 Jan 2022 at 11:06, Miles Chen <miles.chen@mediatek.com> wrote:
> >>
> >> Hi,
> >>
> >> >Hi Miles,
> >> >
> >> >I'm actually not able to reproduce your oops. I'm using vanilla clang
> >> >13, cross compiling for arm64, with thin LTO enabled and CFI enabled.
> >> >Kernel seems to run fine.
> >> >
> >> >
> >> >Are there other settings that are needed to trigger this? Do you see
> >> >it in upstream clang or just the Android fork of clang?
> >> >
> >> I will try another clang (the previous version I use).
> >> I am using Android fork of clang and there is a clang upgrade in this
> >> merge.
> >>
> >
> > One thing that could be worth a try is to make __blake2s_update() and
> > __blake2s_final() __always_inline rather than just inline, which by
> > itself does not appear to be sufficient for the code to get inlined.
> > (If it were, the indirect call should have disappeared as well)
> >
> > Given that indirect calls suck on x86, we should probably apply that
> > change in any case, regardless of CFI.
> >
>
> Had the same thought at first, but then looking at the original stack
> trace, it looks like the __ function is inlined:
>
> [    0.000000][    T0]  __cfi_slowpath_diag+0x354/0x4b0
> [    0.000000][    T0]  blake2s_update+0x14c/0x178
> [    0.000000][    T0]  _extract_entropy+0xf4/0x29c
>

Indeed. How odd. I hope this doesn't happen with the x86 backend
because that would be plain silly. On arm64, it doesn't actually
matter in terms of performance, it just needs one additional callee
save register to preserve the function pointer across calls.
