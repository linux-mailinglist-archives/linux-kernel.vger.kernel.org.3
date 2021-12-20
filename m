Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787D947B28F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhLTSGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:06:20 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:35290 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhLTSGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=F2yXVlUie46ploGVEKTVoENJ3NUWMLnJ1b5tqhVQaJ8=; b=sRKEgiDutdKLfiIWGcZwR6DJjY
        tkJpVp4UrKYNEvC1+bCY38BOs5h9PuBYHQIs5nK4hYza8WEvPxf4TlqPKv5F2ByyB5LXEFYQ9hnez
        yU4Az32dJqGLoCM3dhIg3hPraYOUfTArs1JHlPSERJk8eIUXqdsh+rY4mu3ThMuQEIeY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mzN2y-00H47W-Bl; Mon, 20 Dec 2021 19:06:04 +0100
Date:   Mon, 20 Dec 2021 19:06:04 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        SoC Team <soc@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gongruiqi1@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH -next 0/3] replace open coded VA->PA calculation
Message-ID: <YcDGDLScE+3ZlU8/@lunn.ch>
References: <20211218085843.212497-1-cuigaosheng1@huawei.com>
 <CAK8P3a1-0u4VCCfgc7tjmnANM0yr7oUrQX2y-ZSVvZHDN191BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1-0u4VCCfgc7tjmnANM0yr7oUrQX2y-ZSVvZHDN191BQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:39:43PM +0100, Arnd Bergmann wrote:
> On Sat, Dec 18, 2021 at 9:58 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
> >
> > These patches replace an open coded calculation to obtain the physical
> > address of a far symbol with a call to the new ldr_l etc macro, and they
> > belong to the kaslr patch set of arm32.
> >
> > Reference: https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm-kaslr-latest
> >
> > Ard Biesheuvel (3):
> >   arm-soc: exynos: replace open coded VA->PA conversions
> >   arm-soc: mvebu: replace open coded VA->PA conversion
> >   arm-soc: various: replace open coded VA->PA calculation
> 
> Usually these patches should go through the respective platform
> maintainer trees,
> and from there into the soc tree, but time is a little short here.
> 
> I could apply them directly with the maintainer Acks

Sorry, but this is too low level for me to understand what is going
on, and so feel confident actually giving an ACK for the mvebu change.

Should the resulting assembly be exactly the same? Has the submitter
disassembled the object code and shown there is no actual difference
in the assembler output?

   Andrew
