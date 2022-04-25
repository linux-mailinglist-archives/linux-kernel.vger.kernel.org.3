Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E1850DEB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbiDYLW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241798AbiDYLWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:22:55 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C4AC848F;
        Mon, 25 Apr 2022 04:19:49 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EB32EC0004;
        Mon, 25 Apr 2022 11:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650885588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VFE0BQwSW0F3lbSi+iOzFQLCVz0h/2OYs8AJaioXACM=;
        b=Ydc/aBRJdngbs/8Ph6u3Y3iVWXowapQIWXpkVOh0z5gXMd/HPq2amCssJ83Q50Umo4lt2/
        JTNQ5tvRP+27xBCUdZNslrgOjS01zMv43RSjNQIuAK60nY9b0fbyQGwQ4OxuffjERvvCW1
        BWHQFzq1mZumQMnY+vsM1wZT8lBesv+XxYXMC7YGdBb+Vv/lM48QxKsAF0pen/7WIMWsoh
        kD+LCa4G3VSUw69ItvnxkvAyRZHKiAFDVZF/38+XLgjr/IAmfJ3wFyEL4iIhC9zilir+xk
        S/dJijsU8oJi3mzawVkk45vGk28ZjkrzM1H2XXoND/dazW0T+PXfbFipjamzVw==
Date:   Mon, 25 Apr 2022 13:18:30 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
Message-ID: <20220425131830.29aab83b@fixe.home>
In-Reply-To: <1ec5ce3673dcdaa914e20ef2aae03f549d05ff9a.camel@pengutronix.de>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
        <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
        <20220405092434.6e424ed4@fixe.home>
        <YkxWeMNw9Ba0KjHM@robh.at.kernel.org>
        <20220405175120.23fc6b2a@fixe.home>
        <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
        <20220406094019.670a2956@fixe.home>
        <Yk2TVAfPVh9a1tUR@robh.at.kernel.org>
        <20220408174841.34458529@fixe.home>
        <1ec5ce3673dcdaa914e20ef2aae03f549d05ff9a.camel@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, 25 Apr 2022 12:21:15 +0200,
Philipp Zabel <p.zabel@pengutronix.de> a =C3=A9crit :

> Hi Cl=C3=A9ment,
>=20
> On Fr, 2022-04-08 at 17:48 +0200, Cl=C3=A9ment L=C3=A9ger wrote:
> [...]
> > > > > > > I've told the Xilinx folks the same thing, but I would separa=
te this
> > > > > > > into 2 parts. First is just h/w work in a DT based system. Se=
cond is
> > > > > > > creating a base tree an overlay can be applied to. The first =
part should
> > > > > > > be pretty straightforward. We already have PCI bus bindings. =
The only
> > > > > > > tricky part is getting address translation working from leaf =
device thru
> > > > > > > the PCI bus to host bus, but support for that should all be i=
n place
> > > > > > > (given we support ISA buses off of PCI bus). The second part =
will
> > > > > > > require generating PCI DT nodes at runtime. That may be neede=
d for both
> > > > > > > DT and ACPI systems as we don't always describe all the PCI h=
ierarchy
> > > > > > > in DT.     =20
> > > > > >=20
> > > > > > But then, if the driver generate the nodes, it will most probab=
ly
> > > > > > have to describe the nodes by hardcoding them right ?     =20
> > > > >=20
> > > > > No, the kernel already maintains its own tree of devices. You just
> > > > > need to use that to generate the tree. That's really not much more
> > > > > than nodes with a 'reg' property encoding the device and function
> > > > > numbers.   =20
> > > >=20
> > > > Just to clarified a point, my PCI device exposes multiple periphera=
ls
> > > > behind one single PCI function.   =20
> > >=20
> > > Right. I would expect your PCI device DT node to have a 'simple-bus'=
=20
> > > child node with all those peripherals. And maybe there's other nodes=
=20
> > > like fixed-clocks, etc.
> > >  =20
> > > > To be sure I understood what you are suggesting, you propose to cre=
ate
> > > > a DT node from the PCI driver that has been probed dynamically
> > > > matching this same PCI device with a 'reg' property. I also think
> > > > this would requires to generate some 'pci-ranges' to remap the
> > > > downstream devices that are described in the DTBO, finally, load the
> > > > overlay to be apply under this newly created node. Is that right ? =
  =20
> > >=20
> > > Right. You'll need to take the BAR address(es) for the device and sti=
ck=20
> > > those into 'ranges' to translate offsets to BAR+offset. =20
> >=20
> > Hi Rob,
> >=20
> > I got something working (address translation, probing and so on) using
> > what you started. I switch to using changeset however, I'm not sure that
> > it make sense for property creation since the node has not yet been
> > added to the tree. Attaching the node with changeset however seems
> > to make sense. But I'm no expert here, so any advise is welcome.
> >
> > Based on what we said, I created a PCI driver which uses a builtin
> > overlay. In order to be able to apply the overlay on the correct PCI
> > node -the one on which the card was plugged) and thus be totally plug
> > and play, the 'target-path' property is patched using direct fdt
> > function and replaced the target with the PCI device node path.
> > I don't see any other way to do that before applying the overlay since
> > of_overlay_fdt_apply() takes a fdt blob as input.
> >=20
> > The driver also insert correct ranges into the PCI device in order to
> > translate the downstream node addresses to BAR addresses. It seems
> > reasonnable to assume that this depends on the driver and thus should
> > not be done by the PCI of core at all.
> >=20
> > Finally, the driver probes the newly added childs using
> > of_platform_populate(). With all of that, the address translation
> > and the probing works correctly and the platform devices are created.
> > There is still a few things to fix such as the following:
> >=20
> > [ 2830.324773] OF: overlay: WARNING: memory leak will occur if overlay
> > removed, property: /pci/pci@2,6/dev@0,0/compatible
> >=20
> > But it seems like this is something that works and would allow to
> > support various use cases. From what I see, it should also work on
> > other platforms. Major advantage of that over fwnode is that the
> > changes are pretty small and relatively contained. =20
>=20
> Could you show this off somewhere?
>=20
> From this I take that fwnode support in the reset subsystem is not of
> use to you anymore. I'll postpone taking your patches then, until they
> are needed.
>=20
> regards
> Philipp

Hi Philip,

Sorry for the lack of asnwer. Indeed, the fwnode support can be left
out. I'm preparing the patches for contribution for this OF overlay
thing, and everything regarding the subsystem have been removed. You
can look at commits [1], [2], [3] and at a driver using them [4]. This
allows the subsystem to be kept entirely without a single modification
(except for the PCI/OF one).

Thanks,

Cl=C3=A9ment


[1]
https://github.com/clementleger/linux/commit/248d7f25951f90cf5647d295e1c505=
1cc72ed970
[2]
https://github.com/clementleger/linux/commit/bf3c4c0749e5110b6a58ac9622cafc=
10872ed17f
[3]
https://github.com/clementleger/linux/commit/8764a2e386fdede73991415277b95e=
79553622f3
[4]
https://github.com/clementleger/linux/commit/7c66a1ad8f3fadfb538c410f192c95=
73c66338d5




--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
