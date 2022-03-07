Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736274D00D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiCGON4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239448AbiCGONt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:13:49 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084206A030
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:12:52 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A16E8C0004;
        Mon,  7 Mar 2022 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646662371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7wRRkaUpdd0FO6MkRSvjWKxffLR4zgrZ4eHm549wd8=;
        b=VjCnIllsUSd/hIxdGPlkxd4MA52ZiTiqynK0N4yYK0WuB/R3+ALfLcfuHsq36T70ijuSBm
        cwS3GyltOb1z4fx8OCmx/fjyS8DlNt5LjXwNiKZx9chWpZVYUNJ1F/A4hp6Dtuw0pYeRyO
        aDc+dqeeC+I4eUKgG4KEXJN7d8yPvZqQNMPCumbyyFxAMlxHng0WKYtr/ycqjRg+xnx4rc
        X/2zFsUVkrFrtFQJaO8ubaxFxeZWsPS86gCCrY0FfItvwQTzR3j0iKb/Xphx22EFHmA1eL
        DJ+am6OB86trVx8vCBAG1wVLp07HlNFRDik21J2P8okqkvR8Te0Or8tARw1HmA==
Date:   Mon, 7 Mar 2022 15:12:49 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        krzysztof.kozlowski@canonical.com, vigneshr@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: omap2: Actually prevent invalid
 configuration and build error
Message-ID: <20220307151249.7e5b7210@xps13>
In-Reply-To: <c39d64f0-deef-4cae-fab7-555a48e31811@kernel.org>
References: <20220220004415.GA1519274@roeck-us.net>
        <4bbe337e-8cd8-a4d6-303d-d5aa21bee2e0@infradead.org>
        <20220304165451.0129012e@xps13>
        <6c09de15-1ab2-5ca8-7003-69ff3f7c4dc5@kernel.org>
        <20220307110357.20d50176@xps13>
        <c39d64f0-deef-4cae-fab7-555a48e31811@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

rogerq@kernel.org wrote on Mon, 7 Mar 2022 14:25:48 +0200:

> Hi Miquel,
>=20
> On 07/03/2022 12:03, Miquel Raynal wrote:
> > Hi Roger,
> >=20
> > rogerq@kernel.org wrote on Sat, 5 Mar 2022 00:50:14 +0200:
> >  =20
> >> Hi Miquel,
> >>
> >> On 04/03/2022 17:54, Miquel Raynal wrote: =20
> >>> Hi Guenter, Roger,
> >>>
> >>> rdunlap@infradead.org wrote on Sat, 26 Feb 2022 22:55:28 -0800:
> >>>    =20
> >>>> On 2/19/22 16:44, Guenter Roeck wrote:   =20
> >>>>> On Sat, Feb 19, 2022 at 09:36:00PM +0200, Roger Quadros wrote:     =
=20
> >>>>>> The root of the problem is that we are selecting symbols that have
> >>>>>> dependencies. This can cause random configurations that can fail.
> >>>>>> The cleanest solution is to avoid using select.
> >>>>>>
> >>>>>> This driver uses interfaces from the OMAP_GPMC driver so we have to
> >>>>>> depend on it instead.
> >>>>>>
> >>>>>> Fixes: 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid configu=
ration and build error")
> >>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>     =20
> >>>>>
> >>>>> Tested-by: Guenter Roeck <linux@roeck-us.net>     =20
> >>>>
> >>>> Tested-by: Randy Dunlap <rdunlap@infradead.org>   =20
> >>>
> >>> Sorry for noticing that just now, but there is still a problem with
> >>> this patch: we now always compile-in the OMAP_GPMC driver whenever we
> >>> need the NAND controller, even though it is not needed. This grows the
> >>> kernel for no reason.   =20
> >>
> >> Sorry, I did not understand what you meant.
> >>
> >> We no longer explicitly enable OMAP_GPMC since we dropped the "select".
> >> This fixes all build issues that were reported recently.
> >>
> >> MTD_NAND_OMAP2 will not be enabled if OMAP_GPMC is not since we added
> >> the "depends on". This fixes the original build issue that we started =
to
> >> fix with select initially. =20
> >=20
> > Yes, this side is fine.
> >=20
> > In the initial commit, you proposed:
> >=20
> > --- a/drivers/mtd/nand/raw/Kconfig
> > +++ b/drivers/mtd/nand/raw/Kconfig
> > @@ -42,7 +42,8 @@ config MTD_NAND_OMAP2
> >         tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
> >         depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPIL=
E_TEST
> >         depends on HAS_IOMEM
> > +       select OMAP_GPMC if ARCH_K3
> >=20
> > Which creates a dependency over OMAP_GPMC only for a single
> > architecture. Which means that other OMAP platforms do not necessarily
> > need OMAP_GPMC for the NAND controller to work. Now, you propose: =20
>=20
> No that is not true. Other platforms that need MTD_NAND_OMAP2 are
> explicitly selecting OMAP_GPMC
> i.e. in arch/arm/mach-omap2/Kconfig

Okay, in this case the fix is fine but we will need to clean this up in
a second time.

> > --- a/drivers/mtd/nand/raw/Kconfig
> > +++ b/drivers/mtd/nand/raw/Kconfig
> > @@ -42,8 +42,7 @@ config MTD_NAND_OMAP2
> >  	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
> >  	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> >  	depends on HAS_IOMEM
> > 	depends on OMAP_GPMC
> >=20
> > This means any of the other OMAP architectures will compile the GPMC
> > driver even though they might not need it, which would unnecessarily
> > increase the kernel size.
> >=20
> > Am I missing something? =20
>=20
> MTD_NAND_OMAP2 NAND controller is a submodule of the OMAP GPMC IP. So it
> cannot work without OMAP_GPMC driver.

I didn't remember exactly but in that case it's okay, I was just
surprised by the "select GPMC if ARCH_K3" but indeed with this
explanation it makes more sense.

> Hope this clarifies the doubts.

Yes, thanks. I will send the fix to Linus then.

Cheers,
Miqu=C3=A8l
