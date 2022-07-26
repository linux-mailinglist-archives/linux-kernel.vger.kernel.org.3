Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65B58146C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbiGZNqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbiGZNqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7901E3C8;
        Tue, 26 Jul 2022 06:46:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CC9461573;
        Tue, 26 Jul 2022 13:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12F2C433C1;
        Tue, 26 Jul 2022 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658843174;
        bh=Y7KLQG1Vne9qbaDpnyRbyXPgoHLls22Lqjyu78AiFds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mKAus1aMBcFKC1QfBsK9nYXKGl6o+XeGE084mU2hbR/my4L38CAUfBwTCdreg+fXW
         n47lJQ765XNWbL4tWmaiRbhWxTJJUMKylpxu2VfKNGU6o/+QE3/d/+kf91hmPLkVMC
         zCtRFQFlJluLh+6BlnI37aIyO/NFogK3zqtljdFvNA/DY2ktZlEK0ekea1aRM3wsXM
         CbLMt8DkwhIF4luD4HkJVpbfM+1knZwfV4v/0UbHyb9+A3nlmQAixeojrzYWAVG16Y
         qhq1iATYbL5S/dB4ayNiz1bsLR2Dn84DoFdRxCICbWfPxeZMKBKCrjALm/JhiFbVRX
         r9l+zKX8dJ6oQ==
Received: by mail-oi1-f177.google.com with SMTP id j70so17121162oih.10;
        Tue, 26 Jul 2022 06:46:14 -0700 (PDT)
X-Gm-Message-State: AJIora+1EVhEFoqKmrtXM3d89OG4FliYn1YpBCZLZER83g0GYORFYREO
        /2gwPnIow7RZIQStIHtzCXkirA0eaz10IdYpllE=
X-Google-Smtp-Source: AGRyM1s4JlvzcaEKbhVv3ydzTyV1gB2ZgcW9aOdi7nsPievmOmN9Hm+IOuIF6gLPYPCK/Z46Jbn56Y+DMgGAPywmwWE=
X-Received: by 2002:a05:6808:300b:b0:337:b697:b077 with SMTP id
 ay11-20020a056808300b00b00337b697b077mr7822159oib.126.1658843174055; Tue, 26
 Jul 2022 06:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220725183636.97326-1-ebiggers@kernel.org> <20220725183636.97326-3-ebiggers@kernel.org>
 <Yt8UnWCvoe8dKihc@zx2c4.com>
In-Reply-To: <Yt8UnWCvoe8dKihc@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 26 Jul 2022 06:46:02 -0700
X-Gmail-Original-Message-ID: <CAMj1kXEHM7=6K08uFHpEdYt_35J83hOkAKrq0rcsW0zYgG1f5Q@mail.gmail.com>
Message-ID: <CAMj1kXEHM7=6K08uFHpEdYt_35J83hOkAKrq0rcsW0zYgG1f5Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] crypto: lib - move __crypto_xor into utils
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 at 15:09, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Mon, Jul 25, 2022 at 11:36:35AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> >
> > CRYPTO_LIB_CHACHA depends on CRYPTO for __crypto_xor, defined in
> > crypto/algapi.c.  This is a layering violation because the dependencies
> > should only go in the other direction (crypto/ => lib/crypto/).  Also
> > the correct dependency would be CRYPTO_ALGAPI, not CRYPTO.  Fix this by
> > moving __crypto_xor into the utils module in lib/crypto/.
> >
> > Note that CRYPTO_LIB_CHACHA_GENERIC selected XOR_BLOCKS, which is
> > unrelated and unnecessary.  It was perhaps thought that XOR_BLOCKS was
> > needed for __crypto_xor, but that's not the case.
> >
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
>
> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> With one small question:
>
> > --- /dev/null
> > +++ b/lib/crypto/utils.c
> > @@ -0,0 +1,88 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Crypto library utility functions
> > + *
> > + * Copyright (c) 2006 Herbert Xu <herbert@gondor.apana.org.au>
>
> Didn't Ard basically write the crypto_xor function in its current form?
> I seem to remember some pretty hardcore refactoring he did a while back.
>

Hi Jason,

Thanks for pointing this out. When I made those changes, I don't think
an authorship assertion for copyright purposes was appropriate for the
entire .c file (the FSF have some guidelines for this IIRC). It would
also be strange for me or Eric to suddenly introduce a (c) Linaro (or
ARM, not sure who my employer was at the time) at this point, so I
think we can just leave this as proposed by Eric.
