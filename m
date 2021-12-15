Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E63F4762FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhLOURR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhLOURP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:17:15 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D8C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 12:17:14 -0800 (PST)
Received: from [IPv6:2a02:a03f:eafe:c901:b1b8:ded9:465d:f19c] (unknown [IPv6:2a02:a03f:eafe:c901:b1b8:ded9:465d:f19c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id E7B7628198D;
        Wed, 15 Dec 2021 21:17:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1639599433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvnfDiVPncy0UCcN3nNJYwL++VMY6OLiJYafN2vAPhY=;
        b=dS6+jsOF+ZT4iWI+7TABURR61lP531BZOvVyyTKx5pArdOwFQiSLi5JDU91Aez41qH5Pog
        ZlGRUfnvYfGo1fKX/AmbVv17kMVlOrKLk/yKi0x6WiDQTgrAH/ADhjJ1Zrx5g3k/tQ75i7
        VR+5ma0mAfDB/IRPEaPzFdlWcYk6GQlRnrxkmSi8C8R6DI0CW0Jb4OLzMx9b5hLEpilO52
        GlPpomSzz5pEzQPewbuRxqIXIQJJWPSCFLDLX3IEg65UPeavAo7RL4v7tvUB8yw1yMuUH6
        7w8lyjPbLYKaaEEbOP5kdZaBZRvfgVvrVx2yv/Z/Cu6rUpsb+dnQStZeRPSsHg==
Message-ID: <0ba66064ba998f613e209f928ea459ca166a830b.camel@svanheule.net>
Subject: Re: [PATCH 1/9] mips: drop selecting the non-existing config
 SYS_HAS_EARLY_PRINTK_8250
From:   Sander Vanheule <sander@svanheule.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Bert Vermeulen <bert@biot.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Date:   Wed, 15 Dec 2021 21:17:11 +0100
In-Reply-To: <CAKXUXMxQ_rCt0CQxKm7ym44vuMTT1cgnzSCdZZQN--DPwayG6Q@mail.gmail.com>
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
         <20211213111642.11317-2-lukas.bulwahn@gmail.com>
         <cd01c62484faa9a5b364020c5c8985e3ea7fa643.camel@svanheule.net>
         <CAKXUXMxQ_rCt0CQxKm7ym44vuMTT1cgnzSCdZZQN--DPwayG6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Tue, 2021-12-14 at 13:25 +0100, Lukas Bulwahn wrote:
> On Mon, Dec 13, 2021 at 7:52 PM Sander Vanheule <sander@svanheule.net> wrote:
> > 
> > Hi Lukas,
> > 
> > Thanks for the patch!
> > 
> > On Mon, 2021-12-13 at 12:16 +0100, Lukas Bulwahn wrote:
> > > Commit 4042147a0cc6 ("MIPS: Add Realtek RTL838x/RTL839x support as generic
> > > MIPS system") introduces config MACH_REALTEK_RTL, which selects the
> > > non-existing config SYS_HAS_EARLY_PRINTK_8250.
> > > 
> > > As the MACH_REALTEK_RTL config also selects SYS_HAS_EARLY_PRINTK and
> > > USE_GENERIC_EARLY_PRINTK_8250, an early printk with 8250 should be covered.
> > > Probably SYS_HAS_EARLY_PRINTK_8250 is just some left-over from an early
> > > draft version of this commit.
> > > 
> > > Drop selecting the non-existing config SYS_HAS_EARLY_PRINTK_8250.
> > > 
> > > Fixes: 4042147a0cc6 ("MIPS: Add Realtek RTL838x/RTL839x support as generic MIPS
> > > system")
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > ---
> > >  arch/mips/Kconfig | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > index 00951bfdbab0..c89ce68d9580 100644
> > > --- a/arch/mips/Kconfig
> > > +++ b/arch/mips/Kconfig
> > > @@ -640,7 +640,6 @@ config MACH_REALTEK_RTL
> > >         select SYS_SUPPORTS_MULTITHREADING
> > >         select SYS_SUPPORTS_VPE_LOADER
> > >         select SYS_HAS_EARLY_PRINTK
> > > -       select SYS_HAS_EARLY_PRINTK_8250
> > >         select USE_GENERIC_EARLY_PRINTK_8250
> > >         select BOOT_RAW
> > >         select PINCTRL
> > 
> > MACH_REALTEK_RTL doesn't actually call setup_8250_early_printk_port(). That means
> > USE_GENERIC_EARLY_PRINTK_8250 is also not needed. Being MIPS_GENERIC, that
> > additionaly
> > means SYS_HAS_EARLY_PRINTK doesn't need to be selected.
> > 
> > I only recently found the MIPS_GENERIC "early" console therefore doesn't actually
> > work,
> > but we use the "ns16550a" earlycon console instead. So feel free to also drop the
> > other
> > two other EARLY_PRINTK symbols, if you think this is in-scope for this patch.
> > Otherwise I
> > can submit a separate patch later.
> > 
> > In any case:
> > Acked-by: Sander Vanheule <sander@svanheule.net>
> > 
> 
> I am fine either way. Thomas, also feel free to just drop this patch
> in the series and take the full clean-up patch from Sander.

I've submitted my clean-up patch for all three configs, so I guess this patch is now
superseded.

Best,
Sander

