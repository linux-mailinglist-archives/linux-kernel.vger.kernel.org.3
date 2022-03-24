Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0104E6199
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349438AbiCXKT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242598AbiCXKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:19:28 -0400
X-Greylist: delayed 87964 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 03:17:54 PDT
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C84986F6;
        Thu, 24 Mar 2022 03:17:53 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B1AFCC0009;
        Thu, 24 Mar 2022 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648117072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wB4fsNUnfvTORAoSj+fhxzGTTkt2Xjx10FK5iZYooic=;
        b=ga4nWGcMRwhPWM6ioXMmQykJVe9JQEIwfYfa9s9dxFjcPxY8XurBQYN0cLnpMjIPTxu1Ob
        zjMrruY/bBuq7YbyWrmyGmptdNEuBnYQ7cqBq4MbMcwBmR1gFm7z4SUeV0du5EW4/fOrvw
        RfzMsk1jVb42sAfljemG/cnY1u5h7d2dpAOc52SXN3ho7yfsoaS2oDid5sSO4F2+SNM4rb
        2C2aTlkP5h8/ikTkxZi+Zg6YgX1yGf2PRu5MHQ7XoRxYXQmbukTZ5OD4Faov0RiERxrDny
        O9JEPY8DtI9uJufklDWwIhHyhST4V/IMNNU0Dvi89heAiHdYbzA4VevPcwYA7A==
Date:   Thu, 24 Mar 2022 11:16:31 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] add fwnode support to reset subsystem
Message-ID: <20220324111631.64208e6a@fixe.home>
In-Reply-To: <6e04fbc91a924201aac672165a938bf76cf873f1.camel@pengutronix.de>
References: <20220323095022.453708-1-clement.leger@bootlin.com>
        <d2d119b07cb51878904574ff14c8e4dd92c28907.camel@pengutronix.de>
        <20220323170545.79810f56@fixe.home>
        <6e04fbc91a924201aac672165a938bf76cf873f1.camel@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

Le Thu, 24 Mar 2022 11:08:15 +0100,
Philipp Zabel <p.zabel@pengutronix.de> a =C3=A9crit :

> > =C2=A0- It can be used as a PCIe endpoint, connected to a separate plat=
form
> > =C2=A0=C2=A0 that acts as the PCIe root complex. In this case, all the =
devices
> > =C2=A0=C2=A0 that are embedded on this SoC are exposed through PCIe BAR=
s and the
> > =C2=A0=C2=A0 ARM64 cores of the SoC are not used. Since this is a PCIe =
card, it
> > =C2=A0=C2=A0 can be plugged on any platform, of any architecture suppor=
ting PCIe.
> >=20
> > Appart from adding software node support, the fwnode API would also
> > allow to add ACPI support more easily later. =20
>=20
> Thank you for the explanation. So this would be used by the sparx5
> switch reset driver to provide the microchip,lan966x-switch-reset
> controller via software node?

Exactly.

>=20
> If that needs to be converted to fwnode anyway, it would be nice to
> include the conversion in this series as an example.

Yes indeed, the sparx5 driver was modified in my private tree. I will
change it to use fwnode.

>=20
> [...]
> > On that side, I must say I'm not really competent regarding ACPI
> > which I do not know enough to answer you on that point.
> >=20
> > The discussions we had with Mark Brown regarding fwnode ACPI support
> > pointed out the fact that we should not create unwanted ACPI support
> > by using the same descriptions/specifications that exists for the
> > device-tree. In order to avoid that, we suggested to explicitely left
> > out ACPI with this fwnode support. This will allow to specify that
> > support later and integrate it in the subsystem that have been
> > converted to fwnode. =20
>=20
> Ok.
>=20
> > >=20
> > > On the other hand, I think it would be good to avoid the direct of_no=
de
> > > assignment, possibly by letting devm_reset_controller_register()
> > > initialize of_node or fwnode from the device for most cases, and by
> > > adding of_reset_controller_register() and
> > > fwnode_reset_controller_register() variants that take the node as an
> > > argument for the rest.
> > > That could allow to eventually get rid of the of_node pointer. =20
> >=20
> > Ok, I see that. Do you want this to be done in this series ? =20
>=20
> Just thinking out loudly, before starting to drop the
> rcdev->of_node assigment from drivers en masse, I'd like to use the
> opportunity and turn reset_controller_register() and friends into
> macros that provide the module owner as a parameter, so the explicit
> rcdev->owner =3D THIS_MODULE assignment can be removed from the drivers
> as well.

Indeed, that seems like a good thing to do, direct assignments are often
a pain to change all other the place. BTW, once drivers are converted
to avoid direct assignment of the of_node field, it will be removable,
the fwnode field will be sufficient for all operations.

Thanks,

Cl=C3=A9ment

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
