Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0066B4FFA27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbiDMPat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiDMPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:30:47 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5FD633A0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:28:25 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7E3141C0002;
        Wed, 13 Apr 2022 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649863704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WGuKkZoZhqAp3vshntO7a0lSfalv/QZe/nQ44NUXLMc=;
        b=fjHFRViT16sOsvfG3G/TDkG5Aj69mjco8uA9n8i3tjVrkhiNXyvVcYtwx6NANeUlxEiRxs
        4azAHfxQyuSZKYkj8sUIg4XpPzMYOysj9o4xNd7TE/imZtURksFoadaX7xHLHByVFdwe+r
        AO6HhHg5gbB/3Fy2mGcXxzN6RwDV72xDLigcXHG49kkyDcQZhy/gEeJc4nvtHr/H0dc4Ag
        T/gUbuDShrMYKdqEXBTZPLpghxIfk1k27mLLOwRM0f0kY+4oCMsyezUJigZ2HyKLYe8WpK
        qqs6Da+AdYt7/XVSQk77BMFNBeK5a0xjtE4cC6D4qYcVUdfhKbQwIS0Syl1/NQ==
Date:   Wed, 13 Apr 2022 17:28:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spinand: add support for ESMT F50x1G41LB
Message-ID: <20220413172819.438f79e4@xps13>
In-Reply-To: <CAJsYDV+3J0ipbR+N-xE=DH-WXsjierdHe_pJtKf1Xbt7fdaiWw@mail.gmail.com>
References: <20220413083824.247136-1-gch981213@gmail.com>
        <20220413145843.46a3d9b5@xps13>
        <CAJsYDV+3J0ipbR+N-xE=DH-WXsjierdHe_pJtKf1Xbt7fdaiWw@mail.gmail.com>
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

Hello,

gch981213@gmail.com wrote on Wed, 13 Apr 2022 22:50:43 +0800:

> Hi!
>=20
> On Wed, Apr 13, 2022 at 8:58 PM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> > [...] =20
> > > This patch is made purely based on datasheet info without testing
> > > on any actual chips. =20
> >
> > Do you plan to get one of these any time soon? =20
>=20
> No. I already have way more spi-nand chips than I possibly
> need due to my last GigaDevice submission :)

:)

>=20
> I need to replace the spi-nand driver for mediatek in OpenWrt
> with my recent submission, and this chip is used in one of the
> currently supported router. So I made this patch from
> datasheet for it.
>=20
> BTW Rockchip added identical chip support in their u-boot.[0]
> I assume they've tested it.
>=20
> > I am not really confident merging a 100% non-tested driver :) =20
>=20
> I can understand that.
> I'll roll this patch out in OpenWrt anyway. I can wait for a test
> there and resubmit piled downstream patches for chip supports
> after next OpenWrt stable release.

Yes, please, any feedback from the OpenWrt community would be good. If
you can get a Tested-by I'll take the patch (resend it with the tag so
that I don't miss it).

> > [...] =20
> > > +
> > > +/* ESMT uses GigaDevice 0xc8 JECDEC ID on some SPI NANDs */
> > > +#define SPINAND_MFR_ESMT_C8                  0xc8 =20
> >
> > What happens if the gigadevice driver probes first? =20
>=20
> Their device ID aren't conflicting yet, so nothing will happen
> at the moment.
>=20
> There is a solution for future conflict: Recent SPI-NAND chips
> contain a parameter page which has the exact chip vendor
> and model. We can do one more detection with the parameter
> page content.
> Winbond W25N01KV is a 2k+96 SPI-NAND with 4-bit ECC.
> It uses the exact same chip id as the current W25N01GV
> (2k+64 1-bit ECC). We need to support detection using
> parameter page for this crazy decision by Winbond anyway.

:')

> I'll try to code something for this with my free time.
> My current idea is: We first do a detection based on chip id.
> If that failed, try to read the parameter page. If we got a
> valid one, match the chip vendor and model string.
>=20
> Any thoughts?

Yeah that looks reasonable.

> (BTW this ESMT chip is POWERCHIP PSU1GS20DX
> according to the parameter page in their datasheet.
> But I can't find a datasheet for this model number.)
>=20
> > =20
> > > +
> > > +#define F50L2G41XA_ECC_STATUS_MASK           GENMASK(6, 4)
> > > +#define F50L2G41XA_STATUS_ECC_1_3_BITFLIPS   (1 << 4)
> > > +#define F50L2G41XA_STATUS_ECC_4_6_BITFLIPS   (3 << 4)
> > > +#define F50L2G41XA_STATUS_ECC_7_8_BITFLIPS   (5 << 4) =20
>=20
> Oops. These are left-over defines when I discovered that ESMT 2G/4G
> SPI-NANDs are repackaged micron parts and dropped their support
> from this file.
> A v3 is needed anyway. I'll wait for a test before submitting it.
>=20
> [0]: https://github.com/rockchip-linux/u-boot/commit/52b00601782854887378=
54a48ddecd381f8b236e


Thanks,
Miqu=C3=A8l
