Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF204E55F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245389AbiCWQIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245380AbiCWQIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:08:40 -0400
X-Greylist: delayed 22518 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 09:07:08 PDT
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1097C7A5;
        Wed, 23 Mar 2022 09:07:08 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 408881BF209;
        Wed, 23 Mar 2022 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648051627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xv05aiR4hzSvY3jv3FGf0YL5cIGyfqch5Z4Gz9CQAc0=;
        b=UMT61C+dM6p9/KXllJb5MLsiz61vMWnXa35kZYuMvcVRWfKSEd2LUr4RDm8WTyzYo83Hp0
        +29PZ+fmj1cr5w8krRbEwySxZV7AI5T+au73jXJzzwKehtNuNczW42hFrFUAMkiNn+UVV1
        p6xcEtkDG2iCUglRfno5luBq7xObPlafCxX1j46bBC4IGJa4SNv8udPBLEyGyeXRbwsQjV
        RvsWD9vxLwzal2dzMhFEN0z2izRuveywQXOQBg4p2j4zwTYJDXk0CdZycpDzPpNfgpZr+1
        A0rZnruEuez3MfWg80tCSfKzrApItbhH+MYwSxbc7so2bZg0fWoMwbkKlHm/Jg==
Date:   Wed, 23 Mar 2022 17:05:45 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] add fwnode support to reset subsystem
Message-ID: <20220323170545.79810f56@fixe.home>
In-Reply-To: <d2d119b07cb51878904574ff14c8e4dd92c28907.camel@pengutronix.de>
References: <20220323095022.453708-1-clement.leger@bootlin.com>
        <d2d119b07cb51878904574ff14c8e4dd92c28907.camel@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, 23 Mar 2022 16:07:26 +0100,
Philipp Zabel <p.zabel@pengutronix.de> a =C3=A9crit :

> Hi Cl=C3=A9ment,
>=20
> On Mi, 2022-03-23 at 10:50 +0100, Cl=C3=A9ment L=C3=A9ger wrote:
> > This series is part of a larger series which aims at adding fwnode
> > support in multiple subsystems [1]. The goal of this series was to
> > add support for software node in various subsystem but in a first
> > time only the fwnode support had gained consensus and will be added
> > to multiple subsystems. =20
>=20
> Could you explain the purpose of this a little? From the referenced
> mail it looks like this would be intended allow to register reset
> controllers via software node? Are there any real systems where this
> would be useful?

Hi Philipp and thanks for reviewing this series.

As you noticed, the initial goal of the primary series was to add
fwnode support in order to allow registering devices with software
nodes. Since a lot of subsystem are of-centric, It was needed to modify
them to use fwnode and thus accept the use of software nodes.

The device I'm trying to support is a PCIe card that uses a lan9662
SoC. This card is meant to be used an ethernet switch with 2 x RJ45
ports and 2 x 10G SFPs. The lan966x SoCs can be used in two different
ways:

 - It can run Linux by itself, on ARM64 cores included in the SoC. This
   use-case of the lan966x is currently being upstreamed, using a
   traditional Device Tree representation of the lan996x HW blocks [1]
   A number of drivers for the different IPs of the SoC have already
   been merged in upstream Linux.

 - It can be used as a PCIe endpoint, connected to a separate platform
   that acts as the PCIe root complex. In this case, all the devices
   that are embedded on this SoC are exposed through PCIe BARs and the
   ARM64 cores of the SoC are not used. Since this is a PCIe card, it
   can be plugged on any platform, of any architecture supporting PCIe.

Appart from adding software node support, the fwnode API would also
allow to add ACPI support more easily later.

>=20
> > For the moment ACPI node support is excluded from the fwnode support
> > to avoid creating an unspecified ACPI reset device description. =20
>=20
> Are there any plans or ongoing discussions to specify such a
> description in the future? Right now I'm only aware of the ACPI _RST
> method as used by this patch:
>=20
> [1] https://lore.kernel.org/all/20220307135626.16673-1-kyarlagadda@nvidia=
.com/
>=20

On that side, I must say I'm not really competent regarding ACPI
which I do not know enough to answer you on that point.

The discussions we had with Mark Brown regarding fwnode ACPI support
pointed out the fact that we should not create unwanted ACPI support by
using the same descriptions/specifications that exists for the
device-tree. In order to avoid that, we suggested to explicitely left
out ACPI with this fwnode support. This will allow to specify that
support later and integrate it in the subsystem that have been
converted to fwnode.

> > One question raised by this series is that I'm not sure if all reset
> > drivers should be modified to use the new fwnode support or keep the
> > existing device-tree support. Maintainer advice on that particular
> > question will be welcome. =20
>=20
> I would prefer not to have to switch all those small DT-only reset
> controller drivers all over the tree from of_node to fwnode.

That makes sense.

> On the other hand, I think it would be good to avoid the direct of_node
> assignment, possibly by letting devm_reset_controller_register()
> initialize of_node or fwnode from the device for most cases, and by
> adding of_reset_controller_register() and
> fwnode_reset_controller_register() variants that take the node as an
> argument for the rest.
> That could allow to eventually get rid of the of_node pointer.

Ok, I see that. Do you want this to be done in this series ?

>=20
> For those drivers that provide their own .of_xlate, I'm not sure it
> would make sense to force them to use .fwnode_xlate if they don't
> already have a reason to use fwnode on their own.

No indeed and that's why I added the fwnode_xlate -> of_xlate
translation function, this will allow to keep the existing of_xlate
support.

>=20
> regards
> Philipp

Regards,

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
