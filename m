Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99E94CB238
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiCBWYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiCBWYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:24:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D61CE0AEA;
        Wed,  2 Mar 2022 14:23:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E629B61AA8;
        Wed,  2 Mar 2022 22:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125FEC004E1;
        Wed,  2 Mar 2022 22:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646259805;
        bh=ruaxpWDeM+wgTsYbBMTZZvhUl9cquYwlcym89lKCGMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jED46bNwHfOG4K5q0CuXZfDANIQ8ePJYDXhNnnl9bX2mI1ZBrbEJWrEkYfKLFt9xY
         WQn9JurdZoalUi8N6A+v/fjWbn6PwaDS7Rdmf0rJXTocM4dw6EDwEQC5GnoHLpKg1a
         NOFKJuOt/APeiQgqXKgURqb5c2JI4jcbW0qWO68/CS96SB+a4aDen9guhtKNwV2CWb
         rT9S0oUTr1/i87mpUDFtoaerBU3SCvmvb4s+DLjM8Xpo0ZL0bEov/tdLo5JO1B5zEw
         ZsnXzzxtTh69nVk26ccAeIq/Dc6K0AY31FUHYeknifGSWzpq8aedZag9t07BSj+qco
         pvLpM9VMZn/BA==
Date:   Wed, 2 Mar 2022 22:23:23 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
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
Subject: Re: [PATCH 1/3] crypto: sm4 - create SM4 library based on sm4
 generic code
Message-ID: <Yh/uW6z7aOyG0Jl8@gmail.com>
References: <20210610134459.28541-1-tianjia.zhang@linux.alibaba.com>
 <20210610134459.28541-2-tianjia.zhang@linux.alibaba.com>
 <Yh32tEhUgGeSXf/A@zx2c4.com>
 <Yh65NU6TwcvW/VZV@gondor.apana.org.au>
 <CAHmME9qL4gHwJZcYGRmJ8sxcjkpGFjWDH2gxu15FXzgCUDLifw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qL4gHwJZcYGRmJ8sxcjkpGFjWDH2gxu15FXzgCUDLifw@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 01:26:13AM +0100, Jason A. Donenfeld wrote:
> On Wed, Mar 2, 2022 at 1:24 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > On Tue, Mar 01, 2022 at 11:34:28AM +0100, Jason A. Donenfeld wrote:
> > > >  lib/crypto/Kconfig   |   3 +
> > > >  lib/crypto/Makefile  |   3 +
> > > >  lib/crypto/sm4.c     | 184 +++++++++++++++++++++++++++++++++++++++++++
> > >
> > > If this is only used by the crypto API, it does not belong in
> > > lib/crypto.
> >
> > Nope there is no such rule.  lib/crypto is fine if you're adding
> > code that is shared between crypto and arch/*/crypto.
> 
> The sprawling madness continues then... Noted.

I think it would make more sense for this code to be in crypto/, for the reason
that Jason gave.

- Eric
