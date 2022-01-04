Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C6D48465C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiADRDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:03:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38360 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiADRDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:03:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EE8FB811B1;
        Tue,  4 Jan 2022 17:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133C5C36AF2;
        Tue,  4 Jan 2022 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641315786;
        bh=J4zfBFa5gABB/u4SU7BoX1tKxJDB84PhNKCor0c4REU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HNB659hO2Mi3qrEI4hp4T5Tb37PeoPxyYEg67e4MtqcHmGHbf+PTdRdP4Tcoi6kUs
         SmRsRuet3mlObsjosyBKTWyuKvY6nLvHJ4ay09d84oDhwhhsiP5lHxpuNADrVLaQ2F
         mnOo0Pz4u57OT+btTann/jVUvcw6pNOF2uvvtvcRbwSR2bPxCXrVMSzInd8w+5FHNk
         X6vUhtL7+HgNUOlK2qJAt7djq/OUxzsjrKwcUn5QyNvVJix6zmGt220eC8M6mr00Hv
         D8OV3oEurq/gkBPaODY0DtBukzBUaP74PDQXku4pmcX5FDFhXIcxQFwy7g6xoRKk69
         LTbs9U9ND41jA==
Received: by mail-wm1-f49.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so1786103wmd.5;
        Tue, 04 Jan 2022 09:03:05 -0800 (PST)
X-Gm-Message-State: AOAM530j8/gcysOq2tgza/rWmMkhS4bUOEHIK4oy70GgBNBAfen9xpAW
        ZKtVCwsuCMBr1OtmfFGqW6kDxG0rldKWiZHnvOk=
X-Google-Smtp-Source: ABdhPJzpvIewRwFWqbaGh7wlsRMVH7s6aFI9GMMRWSI5Dtg+Ocwg6NTSVAVCVR+DNCrQd4KYTzpYXXMEm2+56PfO+54=
X-Received: by 2002:a1c:1f93:: with SMTP id f141mr43645538wmf.56.1641315784266;
 Tue, 04 Jan 2022 09:03:04 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oPcEjRnqDesPNKJNOsT+i9vmWRxy9c62t+Xu9Nohsi2A@mail.gmail.com>
 <20220103123152.1043972-1-Jason@zx2c4.com> <YdOhMPwL9sXllm8X@gondor.apana.org.au>
In-Reply-To: <YdOhMPwL9sXllm8X@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 4 Jan 2022 18:02:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFhygHnB12g9MD0wMo_deZ6xd7FMEzbrvEvKVtqYdskAQ@mail.gmail.com>
Message-ID: <CAMj1kXFhygHnB12g9MD0wMo_deZ6xd7FMEzbrvEvKVtqYdskAQ@mail.gmail.com>
Subject: Re: [PATCH v7] lib/crypto: blake2s: include as built-in
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 at 02:22, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Mon, Jan 03, 2022 at 01:31:52PM +0100, Jason A. Donenfeld wrote:
> > In preparation for using blake2s in the RNG, we change the way that it
> > is wired-in to the build system. Instead of using ifdefs to select the
> > right symbol, we use weak symbols. And because ARM doesn't need the
> > generic implementation, we make the generic one default only if an arch
> > library doesn't need it already, and then have arch libraries that do
> > need it opt-in. So that the arch libraries can remain tristate rather
> > than bool, we then split the shash part from the glue code.
> >
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: linux-crypto@vger.kernel.org
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> > Herbert - As discussed, I still intend to take this via the
> > crng/random.git tree because it forms a dependency, and I'd like to send
> > a pull very early in the 5.17 cycle. I've taken some care to minimize
> > changes to the {arch/*/}crypto/Kconfig files, as you mentioned this
> > might cause some conflicts. Your tree should work cleanly on top of this
> > commit.
>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> > Changes v6->v7:
> > - Split arch shash implementations out from the glue code, so that they
> >   can remain as tristates, and we thus don't need to touch
> >   arch/*/crypto/Kconfig at all.
>
> This looks good to me although I confess that I haven't actually
> tried to build it :) Hopefully the build robots will take care of
> this.
>

The only downside here is that the ARM/x86 accelerated shashes and the
generic shash now use the same core transform, right? Given that the
generic blake2s shash is never used for anything in the kernel, the
only reason for its existence was to be able to use the randomized
crypto testing infrastructure to test the arch code.

Ergo, there is no point in retaining the blake2s shashes and we can
simply remove all of them. (Note that blake2b is used as an shash via
the crypto API by btrfs, but blake2s is only used via the library API)
