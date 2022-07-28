Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B78583953
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiG1HOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiG1HOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:14:35 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8AA5E33B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:14:33 -0700 (PDT)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 8944E302367;
        Thu, 28 Jul 2022 09:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1658992470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PpzI60Wtg+NyCzJ8AJPimr3aOxfGcPHZgi57jrfiNY=;
        b=LpK6m8a7Xw8wuBPm2qLtfn81rNNH6OcX6SAq47e8aWmNs+5IN/G6+sDTEcheuOa5R5GlUg
        uyxdoxYEC0jmmOzKbTGnmzXAKmjRosH7zqMRAI5HGuugEcWfqkbRZgPREJkP+wX62BYH6B
        jyZzSwWODxe2mXo7oW3S3YJTmsR5wR4YNGoSqO8CMUbbtYA4l4OL1KsJ9NcqPqsoWEBWkJ
        l94WmihEUafyXtr03h4kCKZSNgurPdPrtn5lpW9HAipscdaHWTefTUQxxGSskZ6qtp4kWv
        +lLwJtpCAZ2CIBtfwUHGh0TaB0xjue37d35jtGgGhizcbLE+ygTDQtlhGK1kmQ==
Message-ID: <78673dc7438a03bf9ed0103a935abf0172f146ce.camel@svanheule.net>
Subject: Re: [PATCH RFC v1] spi: realtek-rtl: Fix clearing some register bits
From:   Sander Vanheule <sander@svanheule.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, mail@birger-koblitz.de
Date:   Thu, 28 Jul 2022 09:14:28 +0200
In-Reply-To: <CAFBinCDZYb-Pt_Vn14cDmprM6CxRoEbTUTx16FMv=cWf-pnrQw@mail.gmail.com>
References: <20220725193547.1038414-1-martin.blumenstingl@googlemail.com>
         <af067c133aa410370aaa4f11e334bc910b4c21e2.camel@svanheule.net>
         <CAFBinCDZYb-Pt_Vn14cDmprM6CxRoEbTUTx16FMv=cWf-pnrQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2022-07-27 at 21:13 +0200, Martin Blumenstingl wrote:
> Hi Sander,
>=20
> On Tue, Jul 26, 2022 at 11:03 AM Sander Vanheule <sander@svanheule.net> w=
rote:
> [...]
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D readl(REG(RTL_SP=
I_SFCSR));
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value &=3D RTL_SPI_SFCSR_LEN_MA=
SK;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value &=3D ~RTL_SPI_SFCSR_LEN_M=
ASK;
> >=20
> > Although typically a field mask has the only the bits of that field set=
,
> > RTL_SPI_SFCSR_LEN_MASK is already inverted. So LEN_MASK has all bits se=
t,
> > *except* for those where LEN is stored.
> >=20
> > This means the code currently is:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value &=3D ~(0x3 << 28);
> >=20
> > which is correct AFAICT, as it clears the LEN bits, but keeps all the o=
thers.
> Thank you for this hint! I completely missed that when reading the
> definition of the macro.
>=20
> > While this part is currently not wrong, I wouldn't be opposed to a patc=
h to make
> > it less confusing by not inverting the field mask in the definition of
> > RTL_SPI_SFCSR_LEN_MASK.
> I can re-spin this patch and move the ~ operator where most people
> expect it to be.
>=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (size =3D=3D 4)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 value |=3D RTL_SPI_SFCSR_LEN4;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (size =3D=3D 1)
> > > @@ -143,7 +143,7 @@ static void init_hw(struct rtspi *rtspi)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Permanently disable CS1=
, since it's never used */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value |=3D RTL_SPI_SFCSR_C=
SB1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Select CS0 for use */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value &=3D RTL_SPI_SFCSR_CS;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value &=3D ~RTL_SPI_SFCSR_CS;
> >=20
> > This macro is not inverted, so it does clear any previously set bits, a=
nd
> > probably doesn't end up with RTL_SPI_SFCRS_CS set. However, is in an in=
it call
> > and it doesn't appear to cause any issues later on, right? Is this beca=
use the
> > SFCSR register is (unintentionally) cleared and that is actually requir=
ed?
> I'm not sure what's right or wrong here but the code reads strange:
> =C2=A0=C2=A0=C2=A0 value =3D readl(...);
> =C2=A0=C2=A0=C2=A0 value |=3D BIT(30); /* RTL_SPI_SFCSR_CSB1 */
> =C2=A0=C2=A0=C2=A0 value &=3D BIT(24); /* RTL_SPI_SFCSR_CS */
> What's the point in setting RTL_SPI_SFCSR_CSB1 (bit 30) when it's
> immediately cleared in the next operation?
>=20
> Also any bits read from the register except RTL_SPI_SFCSR_CS (bit 24)
> are cleared - why even bother reading that register then?

I agree that this is rather suspicious code, to say the least. However, I h=
ave not been involved in
the development of this driver until now, so I would also have to look into=
 the original code to
decipher the required behaviour.

>=20
> If you have any advice on how to change this code then I'm happy to do so=
.
> Otherwise I'd leave it as is, especially since I cannot test this in any =
way.

Since I have multiple devices available for testing, I could try out patche=
s. You can look into this
issue if you want, but you don't have to spend time on this if you don't ha=
ve any to spare.

If you (or anyone) would like to investigate more and require a reference, =
you can use e.g. the GPL
code archive for the TP-Link T1600G-52PS v4:
https://static.tp-link.com/resources/gpl/t1600g-52ps-v4_gpl.tar.gz

Some likely useful files under /t1600g-52ps-v4_gpl/ldk_realtek/realtek-V2.1=
.6.pre2 would be:
 * u-boot-2011.12/board/Realtek/rtl838x/flash_spi.c
 * sdk/system/linux/linux-2.6.32.x/drivers/mtd/maps/rtk-*.c

Best,
Sander
