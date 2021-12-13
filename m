Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4610A4733FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241872AbhLMS31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241723AbhLMS3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:29:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB09C061574;
        Mon, 13 Dec 2021 10:29:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C943611AB;
        Mon, 13 Dec 2021 18:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B27C34602;
        Mon, 13 Dec 2021 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639420164;
        bh=dwmZCtu/nnxrkO4uE9UCl7n6sr+jvUg3xCrI1Q2jU7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oF+1FRcff5FSXd2n2eexUMZ3r2KALwtrpAtkSdPPa3SGXoXACB9DHrbyQgF0ZiKL4
         fXjrqwIH0JFPeKtyQUQAQEkXp2Lzv8VtZa3RRNJCnXVyFjrF5FyCcdftxzzGjiireA
         EPRSO7l1z5j+rcunUB9xNEAHtB6xGFOzp2BKDSaSrVIjfpUJhwxbstW6PUetIywHWd
         Sf5Timfd5e+jTDR4Ub167IoIw7rEMSQ2T6APYE4mCtN5es9gASDgPYg0Ol7oTZyZeq
         RG48Z5jQR0LUnp9wl8aXHwxjnJ3a8pFZRyH4ok8GJc6pWSGaFZOa1gb6wEt+aSVDQS
         3QLSrxerLKY4g==
Date:   Mon, 13 Dec 2021 18:29:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        XiaokangQian <xiaokang.qian@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>, nd <nd@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: arm64/gcm-ce - unroll factors to 4-way
 interleave of aes and ghash
Message-ID: <20211213182918.GC12405@willie-the-truck>
References: <20210923063027.166247-1-xiaokang.qian@arm.com>
 <YVK1u4BgVAa84fMa@sol.localdomain>
 <CAMj1kXHeJBUAzcLHRNYDbbUDe5vRS7Bxy_LKF5gdRLJca7TNRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHeJBUAzcLHRNYDbbUDe5vRS7Bxy_LKF5gdRLJca7TNRQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 11:04:03PM +0200, Ard Biesheuvel wrote:
> On Tue, 28 Sept 2021 at 08:27, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Thu, Sep 23, 2021 at 06:30:25AM +0000, XiaokangQian wrote:
> > > To improve performance on cores with deep piplines such as A72,N1,
> > > implement gcm(aes) using a 4-way interleave of aes and ghash (totally
> > > 8 blocks in parallel), which can make full utilize of pipelines rather
> > > than the 4-way interleave we used currently. It can gain about 20% for
> > > big data sizes such that 8k.
> > >
> > > This is a complete new version of the GCM part of the combined GCM/GHASH
> > > driver, it will co-exist with the old driver, only serve for big data
> > > sizes. Instead of interleaving four invocations of AES where each chunk
> > > of 64 bytes is encrypted first and then ghashed, the new version uses a
> > > more coarse grained approach where a chunk of 64 bytes is encrypted and
> > > at the same time, one chunk of 64 bytes is ghashed (or ghashed and
> > > decrypted in the converse case).
> > >
> > > The table below compares the performance of the old driver and the new
> > > one on various micro-architectures and running in various modes with
> > > various data sizes.
> > >
> > >             |     AES-128       |     AES-192       |     AES-256       |
> > >      #bytes | 1024 | 1420 |  8k | 1024 | 1420 |  8k | 1024 | 1420 |  8k |
> > >      -------+------+------+-----+------+------+-----+------+------+-----+
> > >         A72 | 5.5% |  12% | 25% | 2.2% |  9.5%|  23%| -1%  |  6.7%| 19% |
> > >         A57 |-0.5% |  9.3%| 32% | -3%  |  6.3%|  26%| -6%  |  3.3%| 21% |
> > >         N1  | 0.4% |  7.6%|24.5%| -2%  |  5%  |  22%| -4%  |  2.7%| 20% |
> > >
> > > Signed-off-by: XiaokangQian <xiaokang.qian@arm.com>
> >
> > Does this pass the self-tests, including the fuzz tests which are enabled by
> > CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y?
> >
> 
> Please test both little-endian and big-endian. (Note that you don't
> need a big-endian user space for this - the self tests are executed
> before the rootfs is mounted)
> 
> Also, you will have to rebase this onto the latest cryptodev tree,
> which carries some changes I made recently to this driver.

XiaokangQian -- did you post an updated version of this? It would end up
going via Herbert, but I was keeping half an eye on it and it all seems
to have gone quiet.

Thanks,

Will
