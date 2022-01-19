Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9D7493801
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353494AbiASKNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353474AbiASKNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:13:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CF9C061574;
        Wed, 19 Jan 2022 02:13:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3006EB8191A;
        Wed, 19 Jan 2022 10:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CE1C340E5;
        Wed, 19 Jan 2022 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642587228;
        bh=1yUmZ1gtr9CBj5pMoqsvEIB5CbXXsyQeM7ffKKbaC24=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q81WFpPHkZ7JV6ZOKutx3YkmR40mCv+CdMEBEV/oDqtHeIMtAqjMsI+Lusl40hoF7
         LqRAw540lQZlb3gDjcnAMs6IKjNXYoc2D3wKozp/5wCOq+M/JPlLElqw0l+bIvdk5T
         nNv7bctlnKXGscv3xmuYtKXvaN5Bc1ceZ0tEX6AKAZ0PVl+hhouyzA5nvw2UKuP43W
         K4UabxmcdfsYryv0uIJ47AByUPXCN2kmAb+qFjV8E+g1tS4xzUf3gHME+56cKih0h7
         VgeCDujJ3Dskn7NfyrD+AkhDqXLCoQIzNEFQo8waUrvJgGVL2f4FqAmm8gjls6l9VM
         YjvOnUbbsfGQg==
Received: by mail-wm1-f46.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso13319237wmj.0;
        Wed, 19 Jan 2022 02:13:48 -0800 (PST)
X-Gm-Message-State: AOAM533Mge5F1gr664RRxeaIwqRdOOYv9K2gUkwV6V5mIUul6TayJtzm
        jRiR5XW+3jhkZWxrwbBnvml4C4gEfzvLuGWDkEA=
X-Google-Smtp-Source: ABdhPJxqBXw77uQHArSK2VBrtoFpSbj05KpONweHZEWVRXOUUkrJGt/k3ZzOnZtzegeC/V1Mhu+oTLrNfHeOMfbtlwY=
X-Received: by 2002:a05:600c:3c9c:: with SMTP id bg28mr2689276wmb.190.1642587227212;
 Wed, 19 Jan 2022 02:13:47 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oX+4Ek81xy0nBOegqABH0xYqyONAqinsu7GZ7AaQaqYQ@mail.gmail.com>
 <20220119100615.5059-1-miles.chen@mediatek.com>
In-Reply-To: <20220119100615.5059-1-miles.chen@mediatek.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Jan 2022 11:13:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE_6WboUK0VPbTwzTbMNxv8b4XUp7USQUp=YqcCRMTZig@mail.gmail.com>
Message-ID: <CAMj1kXE_6WboUK0VPbTwzTbMNxv8b4XUp7USQUp=YqcCRMTZig@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     "Jason A. Donenfeld" <jason@zx2c4.com>,
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

On Wed, 19 Jan 2022 at 11:06, Miles Chen <miles.chen@mediatek.com> wrote:
>
> Hi,
>
> >Hi Miles,
> >
> >I'm actually not able to reproduce your oops. I'm using vanilla clang
> >13, cross compiling for arm64, with thin LTO enabled and CFI enabled.
> >Kernel seems to run fine.
> >
> >
> >Are there other settings that are needed to trigger this? Do you see
> >it in upstream clang or just the Android fork of clang?
> >
> I will try another clang (the previous version I use).
> I am using Android fork of clang and there is a clang upgrade in this merge.
>

One thing that could be worth a try is to make __blake2s_update() and
__blake2s_final() __always_inline rather than just inline, which by
itself does not appear to be sufficient for the code to get inlined.
(If it were, the indirect call should have disappeared as well)

Given that indirect calls suck on x86, we should probably apply that
change in any case, regardless of CFI.
