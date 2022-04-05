Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C974F4F6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838055AbiDFAtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457472AbiDEQDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:17 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DF4393;
        Tue,  5 Apr 2022 08:52:50 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 61FAD6000A;
        Tue,  5 Apr 2022 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649173968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cOBb0NZbmOhvhTUbG/GppbVQfOoOT/4Xzf0IMBMQe18=;
        b=kvIPNi7TjxggAg1ZueoAidcyN/Y1X6yQiVx4hfclMyYCC/rzlCWcXlaxEMWiE+XDNa/zI+
        MbZuCZX4gjg4hhZS1VMTlA27YK2JHwuE/cTqN3XHdLWhh3fDPnapYfwPrGrLhVt2cTPc3U
        9gq36ccDcRThSJ4nqmzDAqpyw2y93xO4sfn1984nrLIGGKExgq0iQTbo4Txcu3HjQy11qU
        yI6J4BiKhysiHQ913J9HBLqvRWujAgqusSAq0lehFr0orUyWyhna2XSjoMKZzMGQEk5DNa
        EQDLLe8Wf7xGaiaNhk6IKx1ZK3vhXlWq3sUci4Ec534VwMy0MprPT2euAqsqOQ==
Date:   Tue, 5 Apr 2022 17:51:20 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
Message-ID: <20220405175120.23fc6b2a@fixe.home>
In-Reply-To: <YkxWeMNw9Ba0KjHM@robh.at.kernel.org>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
        <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
        <20220405092434.6e424ed4@fixe.home>
        <YkxWeMNw9Ba0KjHM@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 5 Apr 2022 09:47:20 -0500,
Rob Herring <robh@kernel.org> a =C3=A9crit :

> + some Xilinx folks
>=20
> On Tue, Apr 05, 2022 at 09:24:34AM +0200, Cl=C3=A9ment L=C3=A9ger wrote:
> > Le Mon, 4 Apr 2022 12:41:37 -0500,
> > Rob Herring <robh@kernel.org> a =C3=A9crit :
> >  =20
> > > On Thu, Mar 24, 2022 at 03:12:34PM +0100, Cl=C3=A9ment L=C3=A9ger wro=
te: =20
> > > > This series is part of a larger series which aims at adding fwnode
> > > > support in multiple subsystems [1]. The goal of this series was to
> > > > add support for software node in various subsystem but in a first
> > > > time only the fwnode support had gained consensus and will be added
> > > > to multiple subsystems.   =20
> > >=20
> > > The goal is describing a solution. What is the problem?
> > >=20
> > > What's the scenario where you have a reset provider not described by=
=20
> > > firmware providing resets to devices (consumers) also not described b=
y=20
> > > firmware. =20
> >=20
> > Hi Rob, there was a link attached to this series since there was a
> > previous one that was sent which described the problem. Here is a link
> > to the same thread but to a specific message which clarifies the
> > problem and the solutions that were mentionned by other maintainers
> > (ACPI overlays, DT overlays, software nodes and so on):
> >=20
> > https://lore.kernel.org/netdev/20220224154040.2633a4e4@fixe.home/ =20
>=20
> Thanks, but your commit message should explain the problem. The problem=20
> is not subsystems don't support fwnode.
>=20
> This is the exact same problem the Xilinx folks are trying to solve with=
=20
> their PCIe FPGA cards[1] (and that is not really a v1). They need to=20
> describe h/w downstream from a 'discoverable' device. Their case is=20
> further complicated with the dynamic nature of FPGAs. It's also not just=
=20
> PCIe. Another usecase is describing downstream devices on USB FTDI=20
> serial chips which can have GPIO, I2C, SPI downstream. And then you want=
=20
> to plug in 10 of those.

I also tried loading an overlay from a driver on an ACPI based system.
Their patch is (I guess) targeting the specific problem that there is
no base DT when using ACPI. However, Mark Brown feedback was not to
mix OF and ACPI:

"That seems like it's opening a can of worms that might be best left
closed."

But I would be interested to know how the Xilinx guys are doing that
on x86/ACPI based system.

>=20
> I don't think swnodes are going to scale for these usecases. We moved=20
> h/w description out of the kernel for a reason. Why are we adding that=20
> back in a new form? The complexity for what folks want to describe is=20
> only going to increase.
>=20
> I think DT overlays is the right (or only) solution here. Of course the=20
> DT maintainer would say that. Actually, I would be happier to not have=20
> to support overlays in the kernel.

DT overlay might work on DT based system. If I'm going to plug the card
on an ACPI based platform (x86), I also want that card to work
seamlessly without requiring the user to create an ACPI overlay.

If you proposal was to use DT overlays on an ACPI based system, doing
so would also require to "plug" the PCI subystem when described with
ACPI to "probe" DT overlays describing PCI devices, not sure this is
something trivial and it would be PCI centric.

>=20
> I've told the Xilinx folks the same thing, but I would separate this=20
> into 2 parts. First is just h/w work in a DT based system. Second is=20
> creating a base tree an overlay can be applied to. The first part should=
=20
> be pretty straightforward. We already have PCI bus bindings. The only=20
> tricky part is getting address translation working from leaf device thru=
=20
> the PCI bus to host bus, but support for that should all be in place=20
> (given we support ISA buses off of PCI bus). The second part will=20
> require generating PCI DT nodes at runtime. That may be needed for both=20
> DT and ACPI systems as we don't always describe all the PCI hierarchy
> in DT.=20

But then, if the driver generate the nodes, it will most probably
have to describe the nodes by hardcoding them right ? Or probably load
some dtbo from the FS. If so, I would then have to describe the card
for both ACPI and DT. How is that better than using a single software
node description for both ACPI/OF based systems ? Or maybe I missed
something, but the device description won't come out of thin air I
guess.

Also, when saying "That may be needed for both DT and ACPI systems", do
you actually meant that ACPI overlay should be described for ACPI based
systems and DT overlays for DT based ones ? If so, some subsystems do
not even support ACPI (reset for instance which is need for my
PCI card but that is not the only one). So how to accomodate both ? This
would result in having 2 separate descriptions for ACPI and OF and
potentially non working with ACPI description.

Software nodes have the advantage of being independent from the
description systems used (ACPI/OF). If switching susbsystems to use
fwnode, this would also allows to accomodate easily for all nodes types
and potentially factorize some code.

> That could work either by the PCI subsystem creating nodes as it
> populates devices or your driver could make a request to populate nodes=20
> for its hierarchy. That's not a hard problem to solve. That's what=20
> OpenFirmware implementations do already.

This would also require to get address translation working with ACPI
based systems since the PCI bus isn't described with DT on such
systems. I'm not sure how trivial it is. Or it would require to add PCI
root complex entries into the device-tree to allow adress translation
to work using the existing system probably.

>
>=20
> Rob
>=20
>=20
> https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/

Looking at the feedback of the previous series that I mentionned,
absolutely nobody agreed on the solution to be adopted. I asked for a
consensus but I only got an answer from Hans de Goede which was ok
with the fwnode way. I would be really glad to have some consensus on
that in order to implement a final solution (and if the OF overlays is
the one to be used, I'll use it).

Thanks,

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
