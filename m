Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3674D6A2C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiCKXFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiCKXF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:05:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31787B11E;
        Fri, 11 Mar 2022 15:04:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F83362026;
        Fri, 11 Mar 2022 23:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6B4C340EC;
        Fri, 11 Mar 2022 23:04:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WkaW5kUN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647039837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iU768NbCOwlNRZFo6HjCf6YcGMUw9fVxw/WXICDda/c=;
        b=WkaW5kUNsUQoQ5lkd8lZRDDh+IUHOmYx/Er47DStC4efvN/eGUF1RwWhzFD4R4ch51tFjI
        +RtLGigGZja9J8m0esqaWpYZQiKs1/f3jtUSWcQ5Ae0RVJ4wyJxIOxJEqT/ohDZTZKo1HW
        TgRTIT/ohJG2IwCnwlzEksIYPmU0HFI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 38c3577c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Mar 2022 23:03:57 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id z30so19854368ybi.2;
        Fri, 11 Mar 2022 15:03:56 -0800 (PST)
X-Gm-Message-State: AOAM533ldRo4bGvhINnP/C6aC9LDWpkAUlzNduiHRbHK+3EOM6WO+Cs4
        4ga5KjANZs13tMpK5GIQlzm3GkXNlVj73ynlwUE=
X-Google-Smtp-Source: ABdhPJzb+6m6mC9NJaH1gFTUli2BOSEieC6FDfMICSN651izpAZSkz4593eFwo5CLg+NhpPmYocblzZLNAOOTcyCckI=
X-Received: by 2002:a05:6902:544:b0:628:df6d:a492 with SMTP id
 z4-20020a056902054400b00628df6da492mr10303321ybs.398.1647039833577; Fri, 11
 Mar 2022 15:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20210610134459.28541-1-tianjia.zhang@linux.alibaba.com>
 <20210610134459.28541-2-tianjia.zhang@linux.alibaba.com> <Yh32tEhUgGeSXf/A@zx2c4.com>
 <Yh65NU6TwcvW/VZV@gondor.apana.org.au> <CAHmME9qL4gHwJZcYGRmJ8sxcjkpGFjWDH2gxu15FXzgCUDLifw@mail.gmail.com>
 <Yh/uW6z7aOyG0Jl8@gmail.com>
In-Reply-To: <Yh/uW6z7aOyG0Jl8@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 11 Mar 2022 16:03:42 -0700
X-Gmail-Original-Message-ID: <CAHmME9rUUGAM+MP802=dSe0HMLnGAq4Yne-NHfJxyGaKMcdSxg@mail.gmail.com>
Message-ID: <CAHmME9rUUGAM+MP802=dSe0HMLnGAq4Yne-NHfJxyGaKMcdSxg@mail.gmail.com>
Subject: Re: [PATCH 1/3] crypto: sm4 - create SM4 library based on sm4 generic code
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Markku-Juhani O . Saarinen" <mjos@iki.fi>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        X86 ML <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tianjia,

On Wed, Mar 2, 2022 at 3:23 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Mar 02, 2022 at 01:26:13AM +0100, Jason A. Donenfeld wrote:
> > On Wed, Mar 2, 2022 at 1:24 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > >
> > > On Tue, Mar 01, 2022 at 11:34:28AM +0100, Jason A. Donenfeld wrote:
> > > > >  lib/crypto/Kconfig   |   3 +
> > > > >  lib/crypto/Makefile  |   3 +
> > > > >  lib/crypto/sm4.c     | 184 +++++++++++++++++++++++++++++++++++++++++++
> > > >
> > > > If this is only used by the crypto API, it does not belong in
> > > > lib/crypto.
> > >
> > > Nope there is no such rule.  lib/crypto is fine if you're adding
> > > code that is shared between crypto and arch/*/crypto.
> >
> > The sprawling madness continues then... Noted.
>
> I think it would make more sense for this code to be in crypto/, for the reason
> that Jason gave.

Were you planning on submitting a patch for this?

Thanks,
Jason
