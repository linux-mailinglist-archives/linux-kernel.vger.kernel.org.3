Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BC54F4693
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357098AbiDEUgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572882AbiDEROI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:14:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C557432989;
        Tue,  5 Apr 2022 10:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A058B81EAB;
        Tue,  5 Apr 2022 17:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED14C385A7;
        Tue,  5 Apr 2022 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649178724;
        bh=Fi3gwLDlrpbGZghmXGrutA6z7lh/k2OJOgwNvI5pN+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QECIHsTKsZKpjJwm2fChAOn/xZblKZ47DiND23UTeH1kZwIEfs0AISCNutuLXmEUt
         spY6MNUiDxH+7Jcjl0DyV/WH4vX+RoTUT5M/xG5h8jLXUcYiJEjHFdYyoVXu+xz5Jj
         C7n9HhvreAD3nttOs2pTfYROaob1D1WiD4P/kOfju831Mrly+A57Q6Z9J31Gz4/QXP
         lXZUY5b1DUed/BQv88mwXHkIKt0mUi79IQ1TA+/woTxjRCqYMhl5yqUu/a/yVxK2rw
         v3hC3XBivbRl1wtMl04X3YpDdvw9xQm0daOWJDMjbi3z41QzbN5nWJyuNTzGhqo7Hy
         rnJmeWyFt1ePQ==
Received: by mail-il1-f177.google.com with SMTP id 14so9674333ily.11;
        Tue, 05 Apr 2022 10:12:03 -0700 (PDT)
X-Gm-Message-State: AOAM530LyastRDvLwiPNe1pKqAgWhscbwPs40oGqsjLJ7mHV0K6WcsaQ
        4Yc2Iw/Pt2CqKGgaSCVsafm6Mn1MenPDL0AIag==
X-Google-Smtp-Source: ABdhPJzYBf9pAgvDdaUWa11guFTFnhz96eXEdIaoWioaIc+fB/HqJmh3/mx15Wmj2ADzE6sE5NZK5wukNbYOLBSNuJE=
X-Received: by 2002:a92:dd86:0:b0:2bc:805c:23c7 with SMTP id
 g6-20020a92dd86000000b002bc805c23c7mr2154392iln.279.1649178722976; Tue, 05
 Apr 2022 10:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220324141237.297207-1-clement.leger@bootlin.com>
 <Ykst0Vb4fk+iALzc@robh.at.kernel.org> <20220405092434.6e424ed4@fixe.home>
 <YkxWeMNw9Ba0KjHM@robh.at.kernel.org> <20220405175120.23fc6b2a@fixe.home>
In-Reply-To: <20220405175120.23fc6b2a@fixe.home>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 5 Apr 2022 12:11:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
Message-ID: <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Lizhi Hou <lizhi.hou@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 10:52 AM Cl=C3=A9ment L=C3=A9ger <clement.leger@boot=
lin.com> wrote:
>
> Le Tue, 5 Apr 2022 09:47:20 -0500,
> Rob Herring <robh@kernel.org> a =C3=A9crit :
>
> > + some Xilinx folks
> >
> > On Tue, Apr 05, 2022 at 09:24:34AM +0200, Cl=C3=A9ment L=C3=A9ger wrote=
:
> > > Le Mon, 4 Apr 2022 12:41:37 -0500,
> > > Rob Herring <robh@kernel.org> a =C3=A9crit :
> > >
> > > > On Thu, Mar 24, 2022 at 03:12:34PM +0100, Cl=C3=A9ment L=C3=A9ger w=
rote:
> > > > > This series is part of a larger series which aims at adding fwnod=
e
> > > > > support in multiple subsystems [1]. The goal of this series was t=
o
> > > > > add support for software node in various subsystem but in a first
> > > > > time only the fwnode support had gained consensus and will be add=
ed
> > > > > to multiple subsystems.
> > > >
> > > > The goal is describing a solution. What is the problem?
> > > >
> > > > What's the scenario where you have a reset provider not described b=
y
> > > > firmware providing resets to devices (consumers) also not described=
 by
> > > > firmware.
> > >
> > > Hi Rob, there was a link attached to this series since there was a
> > > previous one that was sent which described the problem. Here is a lin=
k
> > > to the same thread but to a specific message which clarifies the
> > > problem and the solutions that were mentionned by other maintainers
> > > (ACPI overlays, DT overlays, software nodes and so on):
> > >
> > > https://lore.kernel.org/netdev/20220224154040.2633a4e4@fixe.home/
> >
> > Thanks, but your commit message should explain the problem. The problem
> > is not subsystems don't support fwnode.
> >
> > This is the exact same problem the Xilinx folks are trying to solve wit=
h
> > their PCIe FPGA cards[1] (and that is not really a v1). They need to
> > describe h/w downstream from a 'discoverable' device. Their case is
> > further complicated with the dynamic nature of FPGAs. It's also not jus=
t
> > PCIe. Another usecase is describing downstream devices on USB FTDI
> > serial chips which can have GPIO, I2C, SPI downstream. And then you wan=
t
> > to plug in 10 of those.
>
> I also tried loading an overlay from a driver on an ACPI based system.
> Their patch is (I guess) targeting the specific problem that there is
> no base DT when using ACPI. However, Mark Brown feedback was not to
> mix OF and ACPI:

I agree there. I don't think we should use DT bindings in ACPI tables
which is already happening. In this case, I think what's described by
ACPI and DT must be completely disjoint. I think that's the case here
as everything is downstream of the PCIe device.

> "That seems like it's opening a can of worms that might be best left
> closed."
>
> But I would be interested to know how the Xilinx guys are doing that
> on x86/ACPI based system.

They aren't, yet...


> > I don't think swnodes are going to scale for these usecases. We moved
> > h/w description out of the kernel for a reason. Why are we adding that
> > back in a new form? The complexity for what folks want to describe is
> > only going to increase.
> >
> > I think DT overlays is the right (or only) solution here. Of course the
> > DT maintainer would say that. Actually, I would be happier to not have
> > to support overlays in the kernel.
>
> DT overlay might work on DT based system. If I'm going to plug the card
> on an ACPI based platform (x86), I also want that card to work
> seamlessly without requiring the user to create an ACPI overlay.

I agree, it should work the same way for the user.

> If you proposal was to use DT overlays on an ACPI based system, doing
> so would also require to "plug" the PCI subystem when described with
> ACPI to "probe" DT overlays describing PCI devices, not sure this is
> something trivial and it would be PCI centric.

Yes, this is the 2nd part I describe. I don't think there's any way to
avoid this being bus specific because bus specific nodes have to be
created.


> > I've told the Xilinx folks the same thing, but I would separate this
> > into 2 parts. First is just h/w work in a DT based system. Second is
> > creating a base tree an overlay can be applied to. The first part shoul=
d
> > be pretty straightforward. We already have PCI bus bindings. The only
> > tricky part is getting address translation working from leaf device thr=
u
> > the PCI bus to host bus, but support for that should all be in place
> > (given we support ISA buses off of PCI bus). The second part will
> > require generating PCI DT nodes at runtime. That may be needed for both
> > DT and ACPI systems as we don't always describe all the PCI hierarchy
> > in DT.
>
> But then, if the driver generate the nodes, it will most probably
> have to describe the nodes by hardcoding them right ?

No, the kernel already maintains its own tree of devices. You just
need to use that to generate the tree. That's really not much more
than nodes with a 'reg' property encoding the device and function
numbers.

We already support matching a PCI device to a DT node. The PCI
subsystem checks if there is a corresponding DT node for each PCI
device created and sets the of_node pointer if there is. For
OpenFirmware systems (PPC), there always is a node. For FDT, we
generally don't have a node unless there are additional
non-discoverable properties. Hikey960 is an example with PCI device
nodes in the DT as it has a soldered down PCIe switch with downstream
devices and non-discoverable properties (e.g. reset GPIO for each
port).

> Or probably load
> some dtbo from the FS. If so, I would then have to describe the card
> for both ACPI and DT. How is that better than using a single software
> node description for both ACPI/OF based systems ? Or maybe I missed
> something, but the device description won't come out of thin air I
> guess.

What you would have to load is a DT overlay describing all your
downstream devices.

We support DTBs (including DTBOs) built into the kernel already, so
whether it's built into the kernel or in the FS is up to you really.

> Also, when saying "That may be needed for both DT and ACPI systems", do
> you actually meant that ACPI overlay should be described for ACPI based
> systems and DT overlays for DT based ones ?

No, as I said: "I think DT overlays is the right (or only) solution
here." ACPI overlays doesn't seem like a workable solution because it
can't describe your downstream devices.

The reason generating nodes may be needed on DT systems as well is
that all PCI devices are not described in DT systems either.

> If so, some subsystems do
> not even support ACPI (reset for instance which is need for my
> PCI card but that is not the only one). So how to accomodate both ? This
> would result in having 2 separate descriptions for ACPI and OF and
> potentially non working with ACPI description.
>
> Software nodes have the advantage of being independent from the
> description systems used (ACPI/OF). If switching susbsystems to use
> fwnode, this would also allows to accomodate easily for all nodes types
> and potentially factorize some code.

It's not independent. You are effectively creating the DT nodes with C
code. Are these not DT bindings:

> static const struct property_entry ddr_clk_props[] =3D {
>         PROPERTY_ENTRY_U32("clock-frequency", 30000000),
>         PROPERTY_ENTRY_U32("#clock-cells", 0),
>         {}
> };

Sure looks like DT bindings to me. I don't think moving them into the
kernel as sw nodes avoids any of the potential pitfalls of mixing ACPI
and DT. For example, what happens when you have a downstream sw node
device that wants to do DMA allocations and transfers? I suspect that
sw nodes can't really handle more than trivial cases.


> > That could work either by the PCI subsystem creating nodes as it
> > populates devices or your driver could make a request to populate nodes
> > for its hierarchy. That's not a hard problem to solve. That's what
> > OpenFirmware implementations do already.
>
> This would also require to get address translation working with ACPI
> based systems since the PCI bus isn't described with DT on such
> systems. I'm not sure how trivial it is. Or it would require to add PCI
> root complex entries into the device-tree to allow adress translation
> to work using the existing system probably.

It would require all that most likely. Maybe there's some shortcuts we
can take. All the necessary information is maintained by the kernel
already. Normally it's populated from the firmware into the kernel
structures. But here we need the opposite direction.


> > https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.c=
om/
>
> Looking at the feedback of the previous series that I mentionned,
> absolutely nobody agreed on the solution to be adopted. I asked for a
> consensus but I only got an answer from Hans de Goede which was ok
> with the fwnode way. I would be really glad to have some consensus on
> that in order to implement a final solution (and if the OF overlays is
> the one to be used, I'll use it).

Yes, that's a challenge, but buried in some patch series is not going
to get you there. I am trying to widen the discussion because it is a
problem that's been on my radar for some time.

Rob
