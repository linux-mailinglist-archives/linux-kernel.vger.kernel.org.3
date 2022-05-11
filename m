Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D591E522D01
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242743AbiEKHQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbiEKHQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:16:50 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAEF66AFE;
        Wed, 11 May 2022 00:16:47 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2F5AF1C0002;
        Wed, 11 May 2022 07:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652253406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fOqxb4Qu9rmih6DzG9zt5c/lYLp6jBz4NYLyC5x7wow=;
        b=BzgOuVt+7Zca6d+dNLk2gWvrAkAqOfykz9eziVZyd3Z9zJzIwFb2oIETTedQIGbTi6y4sg
        5Ska0+kn3yD2mX3EOatDjrPVRqosF9cWc8TqaStubN2zIj04GVmiY3J3yLZ85Hw/0W9Glz
        iYs5UgjNHwcyWrRXrp0N1JNc2K9c2uXetfAz/X+T8Zhgbk5CC4vHdm3R2ckSPZ5euvDjDX
        hGkO28k69Fs264A8+2uJhsNLNFwgoD8LCq5GavzW0yQgRYtMZIByxNKLPWJA6tHRCiOz7A
        iaBIrElYm74U2o+vlc1PkgcTQZ9lWGzdvKWorcZF4M28rQCr1xrQ2/ma4mHWqA==
Date:   Wed, 11 May 2022 09:16:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mikhail Zhilkin <csharper2005@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mtd: parsers: add support for Sercomm partitions
Message-ID: <20220511091643.064f9d13@xps13>
In-Reply-To: <ede9e050-3b60-ba0e-c626-044f7825adb7@gmail.com>
References: <20220329122016.4122899-1-csharper2005@gmail.com>
        <20220330100958.57dc4d61@xps13>
        <ede9e050-3b60-ba0e-c626-044f7825adb7@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

csharper2005@gmail.com wrote on Tue, 10 May 2022 23:07:23 +0300:

> Hi Miquel,
>=20
> On 3/30/2022 11:09 AM, Miquel Raynal wrote:
> > Hi Mikhail,
> >
> > csharper2005@gmail.com wrote on Tue, 29 Mar 2022 12:20:16 +0000:
> > =20
> >> This adds an MTD partition parser for the Sercomm partition table that
> >> is used in some Beeline, Netgear and Sercomm routers.
> >>
> >> The Sercomm partition map table contains real partition offsets, which
> >> may differ from device to device depending on the number and location =
of
> >> bad blocks on NAND.
> >>
> >> Device tree example:
> >> partitions {
> >> 	compatible =3D "sercomm,sc-partitions", "fixed-partitions";
> >> 	#address-cells =3D <1>;
> >> 	#size-cells =3D <1>;
> >>
> >> 	partition@0 {
> >> 		label =3D "u-boot";
> >> 		reg =3D <0x0 0x100000>;
> >> 		scpart-id =3D <0>;
> >> 		read-only;
> >> 	};
> >> }; =20
> > You'll need a DT binding patch and Rob's ack! =20
>=20
> I hope that I near to finish with DT binding...
>=20
> Link:
> https://lore.kernel.org/all/20220510162314.20810-1-csharper2005@gmail.com/
>=20
> Link:
> https://lore.kernel.org/all/20220510162403.20861-1-csharper2005@gmail.com/
>=20
> >> This is essentially the same code as proposed by NOGUCHI Hiroshi
> >> <drvlabo@gmail.com> here: =20
> > I would credit Hiroshi with a Suggested-by at least =20
>=20
> I read submitting patches rules again and thought that Signed-off-by is
> suitable for this case. Is this ok?

Either you take his work almost like it is and he must be the author
*and* the first signed-off-by line, or you take the authorship if you
think you did enough modifications to the code and in this case you can
either credit him with a suggested-by before your signed-off, or you
can credit him with a co-developed-by + his signed-off and then yours.

>=20
> Link:
> https://lore.kernel.org/all/20220510162655.21011-1-csharper2005@gmail.com/
>=20
> >> https://github.com/openwrt/openwrt/pull/1318#issuecomment-420607394 =20
> > And use a Link: tag for this.
> > =20
> Fixed, thanks!
>=20
> Link:
> https://lore.kernel.org/all/20220510162655.21011-1-csharper2005@gmail.com/
>=20
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
