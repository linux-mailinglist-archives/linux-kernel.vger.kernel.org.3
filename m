Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E394D1348
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345294AbiCHJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiCHJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:27:20 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61E53FDBF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:26:23 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4995820000E;
        Tue,  8 Mar 2022 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646731582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ryvVPl4TdU3ql0jktEpltI3IgYRpF014rqv2eBbmRuo=;
        b=RGMBEHafTdFE5z8Q02y/oKvOkNSNMavbHDBaHc+A88k/zngM/PyEQ08OcKpcUW6AjPpIwF
        9zECMjVGhBrxRLedidriyL7nlf92YV2z0rX44pWUayCb0eSC/QviS2JlrEKC0BY3KNKKMe
        WDrYPpeuU4BdpFhtCooL6EIV4nzS8vBgg6CC43MS3SPF+k+8+oSreBEYKB0yp4laJxYPzU
        nytb45OgBDB5t1POL+8EoXkbkcSvryYjOpLQ/tzwkt+q+foAH49zjNp4rJiErG2qkPud1+
        X1ahPZXJDKw3TE2lSLcgKLlIEEPi3UmcYt1qFtKKkYR3Yzr88P2MyUr01398YA==
Date:   Tue, 8 Mar 2022 10:26:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        krzysztof.kozlowski@canonical.com, vigneshr@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: omap2: Actually prevent invalid
 configuration and build error
Message-ID: <20220308102619.71aa9e4e@xps13>
In-Reply-To: <c91edeac-817c-d30d-ae45-f216670b9e69@kernel.org>
References: <20220220004415.GA1519274@roeck-us.net>
        <4bbe337e-8cd8-a4d6-303d-d5aa21bee2e0@infradead.org>
        <20220304165451.0129012e@xps13>
        <6c09de15-1ab2-5ca8-7003-69ff3f7c4dc5@kernel.org>
        <20220307110357.20d50176@xps13>
        <c39d64f0-deef-4cae-fab7-555a48e31811@kernel.org>
        <20220307151249.7e5b7210@xps13>
        <c91edeac-817c-d30d-ae45-f216670b9e69@kernel.org>
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

rogerq@kernel.org wrote on Mon, 7 Mar 2022 23:05:47 +0200:

> Hi Miquel,
>=20
> On 07/03/2022 16:12, Miquel Raynal wrote:
> > Hi Roger,
> >=20
> > rogerq@kernel.org wrote on Mon, 7 Mar 2022 14:25:48 +0200:
> >  =20
> >> Hi Miquel,
> >>
> >> On 07/03/2022 12:03, Miquel Raynal wrote: =20
> >>> Hi Roger,
> >>>
> >>> rogerq@kernel.org wrote on Sat, 5 Mar 2022 00:50:14 +0200:
> >>>    =20
> >>>> Hi Miquel,
> >>>>
> >>>> On 04/03/2022 17:54, Miquel Raynal wrote:   =20
> >>>>> Hi Guenter, Roger,
> >>>>>
> >>>>> rdunlap@infradead.org wrote on Sat, 26 Feb 2022 22:55:28 -0800:
> >>>>>      =20
> >>>>>> On 2/19/22 16:44, Guenter Roeck wrote:     =20
> >>>>>>> On Sat, Feb 19, 2022 at 09:36:00PM +0200, Roger Quadros wrote:   =
    =20
> >>>>>>>> The root of the problem is that we are selecting symbols that ha=
ve
> >>>>>>>> dependencies. This can cause random configurations that can fail.
> >>>>>>>> The cleanest solution is to avoid using select.
> >>>>>>>>
> >>>>>>>> This driver uses interfaces from the OMAP_GPMC driver so we have=
 to
> >>>>>>>> depend on it instead.
> >>>>>>>>
> >>>>>>>> Fixes: 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid confi=
guration and build error")
> >>>>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>       =20
> >>>>>>>
> >>>>>>> Tested-by: Guenter Roeck <linux@roeck-us.net>       =20
> >>>>>>
> >>>>>> Tested-by: Randy Dunlap <rdunlap@infradead.org>     =20
> >>>>>
> >>>>> Sorry for noticing that just now, but there is still a problem with
> >>>>> this patch: we now always compile-in the OMAP_GPMC driver whenever =
we
> >>>>> need the NAND controller, even though it is not needed. This grows =
the
> >>>>> kernel for no reason.     =20
> >>>>
> >>>> Sorry, I did not understand what you meant.
> >>>>
> >>>> We no longer explicitly enable OMAP_GPMC since we dropped the "selec=
t".
> >>>> This fixes all build issues that were reported recently.
> >>>>
> >>>> MTD_NAND_OMAP2 will not be enabled if OMAP_GPMC is not since we added
> >>>> the "depends on". This fixes the original build issue that we starte=
d to
> >>>> fix with select initially.   =20
> >>>
> >>> Yes, this side is fine.
> >>>
> >>> In the initial commit, you proposed:
> >>>
> >>> --- a/drivers/mtd/nand/raw/Kconfig
> >>> +++ b/drivers/mtd/nand/raw/Kconfig
> >>> @@ -42,7 +42,8 @@ config MTD_NAND_OMAP2
> >>>         tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
> >>>         depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMP=
ILE_TEST
> >>>         depends on HAS_IOMEM
> >>> +       select OMAP_GPMC if ARCH_K3
> >>>
> >>> Which creates a dependency over OMAP_GPMC only for a single
> >>> architecture. Which means that other OMAP platforms do not necessarily
> >>> need OMAP_GPMC for the NAND controller to work. Now, you propose:   =
=20
> >>
> >> No that is not true. Other platforms that need MTD_NAND_OMAP2 are
> >> explicitly selecting OMAP_GPMC
> >> i.e. in arch/arm/mach-omap2/Kconfig =20
> >=20
> > Okay, in this case the fix is fine but we will need to clean this up in
> > a second time. =20
>=20
> What clean up are you implying here? Those legacy platform might need
> OMAP_GPMC for booting so they select it. There is nothing much we can do =
there.

If all the board that need the OMAP_GPMC select it, then we should just
take care that the K3 architecture does not behave differently unless
there is a good reason to do it differently. AFAIR you told me this
architecture did not select OMAP_GPMC yet.

> What is left to do now is make user/defconfig files to enable OMAP_GPMC d=
river
> so other platforms that don't need OMAP_GPMC for basic operation can still
> enable them later via defconfig or manually by user.

And yes, that is also what I meant to be "cleaned up" :)

> >>> --- a/drivers/mtd/nand/raw/Kconfig
> >>> +++ b/drivers/mtd/nand/raw/Kconfig
> >>> @@ -42,8 +42,7 @@ config MTD_NAND_OMAP2
> >>>  	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
> >>>  	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TE=
ST
> >>>  	depends on HAS_IOMEM
> >>> 	depends on OMAP_GPMC
> >>>
> >>> This means any of the other OMAP architectures will compile the GPMC
> >>> driver even though they might not need it, which would unnecessarily
> >>> increase the kernel size.
> >>>
> >>> Am I missing something?   =20
> >>
> >> MTD_NAND_OMAP2 NAND controller is a submodule of the OMAP GPMC IP. So =
it
> >> cannot work without OMAP_GPMC driver. =20
> >=20
> > I didn't remember exactly but in that case it's okay, I was just
> > surprised by the "select GPMC if ARCH_K3" but indeed with this
> > explanation it makes more sense.
> >  =20
> >> Hope this clarifies the doubts. =20
> >=20
> > Yes, thanks. I will send the fix to Linus then.
> >=20
> > Cheers,
> > Miqu=C3=A8l =20
>=20
> cheers,
> -roger


Thanks,
Miqu=C3=A8l
