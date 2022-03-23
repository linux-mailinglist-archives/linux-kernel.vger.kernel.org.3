Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3664E5643
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbiCWQYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbiCWQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:24:15 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB877C791;
        Wed, 23 Mar 2022 09:22:44 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C72D5240006;
        Wed, 23 Mar 2022 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648052563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iU22Ut2bf3iPraCysIP/pzQ8KDzRQbmOe5f5yJ9SnL4=;
        b=mHlIN0q0OCIRu9O+TqNRdjU5WYOxBxyqjpt2ib13jXmBQ5BJ7oXS1jhqPfFu46AZ1Absjy
        u+RfEDOh5o8D4KeTLOJBRFf6R+4Da6k3jY28ikql5ynblTu1NmX9ZYrIUV1BDR4LXRKEz4
        rZDbzMJKJojt3p8lg5U09k4mv4s2I9hEVau091RzySV+TWBHJgP8QawGBANx8zXZ9X1RFN
        XcwtxFvwEwz4nmhQFAbVi2p4QhTDd2deaVRX4DGy+CsSoPyjv2MHcBUexSwFfuzMsHQ5R9
        hoHQK3bX827EWZevGwG9auNzY7ZuzgHQ2jDptV1fDDhcWJb1gHfUaUTcZ6crSw==
Date:   Wed, 23 Mar 2022 17:21:21 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] reset: add support for fwnode
Message-ID: <20220323172121.220a26e9@fixe.home>
In-Reply-To: <ba95a3fec9c726e2cd61665ac5d7f89d16232d60.camel@pengutronix.de>
References: <20220323095022.453708-1-clement.leger@bootlin.com>
        <20220323095022.453708-3-clement.leger@bootlin.com>
        <ba95a3fec9c726e2cd61665ac5d7f89d16232d60.camel@pengutronix.de>
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

Le Wed, 23 Mar 2022 16:29:41 +0100,
Philipp Zabel <p.zabel@pengutronix.de> a =C3=A9crit :

> On Mi, 2022-03-23 at 10:50 +0100, Cl=C3=A9ment L=C3=A9ger wrote:
> [...]
> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > index 61e688882643..f014da03b7c1 100644
> > --- a/drivers/reset/core.c
> > +++ b/drivers/reset/core.c
> > @@ -4,6 +4,7 @@
> > =C2=A0 *
> > =C2=A0 * Copyright 2013 Philipp Zabel, Pengutronix
> > =C2=A0 */
> > +#include <linux/acpi.h>
> > =C2=A0#include <linux/atomic.h>
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/err.h>
> > @@ -70,26 +71,49 @@ static const char *rcdev_name(struct
> > reset_controller_dev *rcdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rcdev->of_node)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return rcdev->of_node->full_name; =20
>=20
> Could the above be removed, since reset_controller_register() set
> rcdev->fwnode to of_fwnode_handle(rcdev->of_node) earlier?

Yes, this should work in all cases, the only difference is that
fwnode_get_name() returns the basename of the of_node full_name field.
This is potentially a change from what was displayed before. If you are
ok with that, I'll drop these lines.

[...]

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rcdev->of_xlate) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rcdev->fwnode_xlate =3D fwnode_of_reset_xlate; =20
>=20
> It should be documented that .fwnode_xlate/.fwnode_reset_n_cells are
> ignored if .of_xlate is set.

Acked.

[...]

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (id) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0index =3D of_property_match_string(node,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "reset-name=
s", id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0index =3D fwnode_property_match_string(fwnode, "reset-=
names", id);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (index =3D=3D -EILSEQ)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
return ERR_PTR(index); =20
>=20
> I don't think this is good enough any more. At least -ENOMEM is added
> as a possible error return code by this change.

Yes indeed, errors are clearly not correctly handled anymore. At least
-EILSEQ won't be triggered.
>=20
> [...]
> > @@ -945,6 +989,9 @@ struct reset_control *__reset_control_get(struct de=
vice *dev, const char *id,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dev->of_node)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return __of_reset_control_get(dev->of_node, id, =
index, shared,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optional, acquired); =20
>=20
> Could the above be removed, given that __of_reset_control_get() just
> wraps __fwnode_reset_control_get(), which is called right below:

Oh yes, sorry for that. It can clearly be removed.

[...]

> > =C2=A0 * @of_node: corresponding device tree node as phandle target
> > + * @fwnode: corresponding firmware node as reference target
> > =C2=A0 * @of_reset_n_cells: number of cells in reset line specifiers
> > =C2=A0 * @of_xlate: translation function to translate from specifier as=
 found in the
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 device tree to id as given to the reset control ops, defaults
> > - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
o :c:func:`of_reset_simple_xlate`.
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
o :c:func:`fwnode_of_reset_xlate`.
> > + * @fwnode_reset_n_cells: number of cells in reset line reference spec=
ifiers
> > + * @fwnode_xlate: translation function to translate from reference spe=
cifier as
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 found in the firmware node description to id as gi=
ven to the
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reset control ops, defaults to
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 :c:func:`fwnode_reset_simple_xlate`. =20
>=20
> This should mention that .fwnode_xlate is ignored/overwritten when
> .of_xlate is set.

Acked.

>=20
>=20
> regards
> Philipp

Regards,

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
