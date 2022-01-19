Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4659A4936F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352935AbiASJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352816AbiASJOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:14:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF23C061574;
        Wed, 19 Jan 2022 01:14:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DF5DB81911;
        Wed, 19 Jan 2022 09:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E772FC340E7;
        Wed, 19 Jan 2022 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642583643;
        bh=UT1ycB5MKQguCeHT4CqkfeYkeSTVnUZkbqsNKDB91DE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HIVRMtGwk6qaE9ahJmgOL9zeB6VmNjL82sIDY0R9RcQykK5LYcrO9IZYpyqYXcy1o
         EU8LBeG8WtEoW4g9+EXqtZGwEz+29+cw3caj84lZkBGMZOKZFYbbJ8NE+94HD6b5JE
         VB5/dhCa6lv9lm2LJ4Gen5fRp+EDxT8534gp56tpKJ5C+Gn7H7x44+5lBJlyqyiLwk
         uunPHQkLgNBMFxTblL7cDiJYVM5jiF6J7luwxLE8qz82Gr3Oua1tDpugHTtDhUky6o
         8O4bMqjVQ/hwAIjSNDn9SL4SdKkdDiEXYndddjRXzxAk4EzBB+lU8hjzoYd8M5rj9C
         IMUxzQCcVkbBw==
Received: by mail-wm1-f49.google.com with SMTP id ay14-20020a05600c1e0e00b0034d7bef1b5dso6127998wmb.3;
        Wed, 19 Jan 2022 01:14:03 -0800 (PST)
X-Gm-Message-State: AOAM533TzqKYBYEHCOH3NgdRZdf9X84OK2kcvbF1ZpvYsKrSGHj4L6Lv
        HSrqR95Xc50KPNSCVmJVq6C7AHXZAKKllIxSC8I=
X-Google-Smtp-Source: ABdhPJwCrAQgxYS+mSM5rThnIjL7BrcKp/O0rhZ0fCrotJ58xV1UBxwc+zZAx8OHuLmlHLQeNbsXBBo+N7eqth/eSbQ=
X-Received: by 2002:a5d:6210:: with SMTP id y16mr26324324wru.454.1642583642257;
 Wed, 19 Jan 2022 01:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20220119082447.1675-1-miles.chen@mediatek.com>
 <CAHmME9pv4WWATjdqZgwrtHDmq3sX4ABfB9PoNT9Z4tSEduR2Lw@mail.gmail.com> <CAMj1kXEuWRUbCqDBnxiWRaERt6OGL8ufQ1Q7naAGHqKK1oQB1w@mail.gmail.com>
In-Reply-To: <CAMj1kXEuWRUbCqDBnxiWRaERt6OGL8ufQ1Q7naAGHqKK1oQB1w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Jan 2022 10:13:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGUtg1BOauCjxB+S7yMTPArQrPnHf5jnfhOihL-FHrFZA@mail.gmail.com>
Message-ID: <CAMj1kXGUtg1BOauCjxB+S7yMTPArQrPnHf5jnfhOihL-FHrFZA@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <miles.chen@mediatek.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Eric Biggers <ebiggers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 10:09, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (+ Sami, Eric)
>
> On Wed, 19 Jan 2022 at 10:00, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Miles,
> >
> > Thanks for the patch. Could you let me know which architecture and
> > compiler this was broken on? If I had to guess, I'd wager arm32, and
> > you hit this by enabling optimized blake2s?
> >
> > If so, I'm not sure the problem is with weak symbols. Why should CFI
> > break weak symbols? Rather, perhaps the issue is that the function is
> > defined in blake2s-core.S? Are there some CFI macros we need for that
> > definition?
> >
>
> We should try to understand why CFI thinks the prototypes of the two
> symbols are different. There are still a number of issues with CFI, so
> papering over them by reverting stuff that we want for good reasons is
> not the way to go imo.
>
> In the short term, you can work around it by avoiding the indirect
> call to blake2s_compress, e.g.,
>
> diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
> index 93f2ae051370..fef2ff678431 100644
> --- a/lib/crypto/blake2s.c
> +++ b/lib/crypto/blake2s.c
> @@ -16,9 +16,15 @@
>  #include <linux/init.h>
>  #include <linux/bug.h>
>
> +static void __blake2s_compress(struct blake2s_state *state, const u8 *block,
> +                              size_t nblocks, const u32 inc)
> +{
> +       return blake2s_compress(state, block, nblocks, inc);
> +}
> +
>  void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen)
>  {
> -       __blake2s_update(state, in, inlen, blake2s_compress);
> +       __blake2s_update(state, in, inlen, __blake2s_compress);
>  }
>  EXPORT_SYMBOL(blake2s_update);

Ehm, maybe not. As Jason points out, the typedef does not have quite
the right type, so that is most likely the culprit, and this
workaround would trigger CFI in exactly the same way.

Interestingly, the compiler does not seem to mind, right? Or are you
seeing any build time warnings on the reference to blake2s_compress in
the call to __blake2s_update() ?
