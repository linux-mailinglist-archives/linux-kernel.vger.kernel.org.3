Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F334F6485
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiDFQGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiDFQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:06:09 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4789028E39;
        Wed,  6 Apr 2022 06:37:41 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4D151C0004;
        Wed,  6 Apr 2022 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649252260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FH99r01rSjiYpZmMc6KUEx7cbU28Glohzh6YuFZpwCg=;
        b=NMHjp3eIjygCXnXkmuit45vnyOKfQ69n3ArPh+HZIYyf7wEkfxP6qFPO7d8lwG+Dz6WayV
        5BSPZaRuofzCmRczDKVvudfGJV+YX9ubne8LLbhfr6OKTOxNtJuLSblojB4QRBko4p0aAO
        7AaZE/foEmAu9yKlbMVMtzr2mgmOCc8kGr+8lxzhlQQJ6lrEMoumgC9lMFdu5u6CgW3cY8
        87C/f6fzh7UY12KAyxYbCbXEDG7qUTNCjtPg2bmR9T5zdpTFedNX0fgsTiT7TDQmNdYtof
        KB2jopL2Vo/AqjOcP3q/VFsQDiRdheZEgJVuvu37XEYrsNH83SFwqIgpdrAuZg==
Date:   Wed, 6 Apr 2022 15:36:10 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
Message-ID: <20220406153610.1d479a05@fixe.home>
In-Reply-To: <Yk2WulTcdtwlMGrj@mail.local>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
        <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
        <20220405092434.6e424ed4@fixe.home>
        <YkxWeMNw9Ba0KjHM@robh.at.kernel.org>
        <20220405175120.23fc6b2a@fixe.home>
        <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
        <20220406094019.670a2956@fixe.home>
        <Yk2TVAfPVh9a1tUR@robh.at.kernel.org>
        <Yk2WulTcdtwlMGrj@mail.local>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, 6 Apr 2022 15:33:46 +0200,
Alexandre Belloni <alexandre.belloni@bootlin.com> a =C3=A9crit :

> On 06/04/2022 08:19:16-0500, Rob Herring wrote:
> > > > > > I've told the Xilinx folks the same thing, but I would separate=
 this
> > > > > > into 2 parts. First is just h/w work in a DT based system. Seco=
nd is
> > > > > > creating a base tree an overlay can be applied to. The first pa=
rt should
> > > > > > be pretty straightforward. We already have PCI bus bindings. Th=
e only
> > > > > > tricky part is getting address translation working from leaf de=
vice thru
> > > > > > the PCI bus to host bus, but support for that should all be in =
place
> > > > > > (given we support ISA buses off of PCI bus). The second part wi=
ll
> > > > > > require generating PCI DT nodes at runtime. That may be needed =
for both
> > > > > > DT and ACPI systems as we don't always describe all the PCI hie=
rarchy
> > > > > > in DT.   =20
> > > > >
> > > > > But then, if the driver generate the nodes, it will most probably
> > > > > have to describe the nodes by hardcoding them right ?   =20
> > > >=20
> > > > No, the kernel already maintains its own tree of devices. You just
> > > > need to use that to generate the tree. That's really not much more
> > > > than nodes with a 'reg' property encoding the device and function
> > > > numbers. =20
> > >=20
> > > Just to clarified a point, my PCI device exposes multiple peripherals
> > > behind one single PCI function. =20
> >=20
> > Right. I would expect your PCI device DT node to have a 'simple-bus'=20
> > child node with all those peripherals. And maybe there's other nodes=20
> > like fixed-clocks, etc.
> >  =20
> > > To be sure I understood what you are suggesting, you propose to create
> > > a DT node from the PCI driver that has been probed dynamically
> > > matching this same PCI device with a 'reg' property. I also think
> > > this would requires to generate some 'pci-ranges' to remap the
> > > downstream devices that are described in the DTBO, finally, load the
> > > overlay to be apply under this newly created node. Is that right ? =20
> >=20
> > Right. You'll need to take the BAR address(es) for the device and stick=
=20
> > those into 'ranges' to translate offsets to BAR+offset.
> >  =20
>=20
> Last time I tried that, this was not working well because it means that
> the ranges property of the device depends on the host machine...
>=20

Yes, but we can actually resolve that dynamically. The ranges property
that is inserted is inserted in the top node (the PCI device one).
Since this node will be created by "us" (the kernel/driver), we can
insert whatever we want. And most probably, we'll insert a specific BAR
remapping. The underlying nodes will then be loaded from the overlay
and merged in the top PCI device node (At least I guess ;)). These
nodes don't need any "machine dependent" addresses, only realtive
addresses from the top node.


--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
