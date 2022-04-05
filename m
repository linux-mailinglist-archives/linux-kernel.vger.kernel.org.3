Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE48D4F5237
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849653AbiDFCjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453283AbiDEWct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0217DA8C;
        Tue,  5 Apr 2022 14:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA23615C3;
        Tue,  5 Apr 2022 21:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8F5C385A0;
        Tue,  5 Apr 2022 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649194094;
        bh=dgxLB7KBPcoMWIp7zDjDHZFRjO0hDLRflaEpybns6pM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=btiVEPMno2PRbyb8Ly/fD3AJOiiQO1/uEeojq7z8UtZ02Fq3z1MVU/xulx0tH7GYP
         f7lTLTl8W5jYza8Fp484gQGM1KfN1x/SUG2ob8Mj2lIynXN39eWJD+sTvlyLf2Pgbh
         SsaRN1gt1Zenj6nOGRRP1k97BAkhR++MsPEwy5gHUb+2IZup33qtL4a3O/Mx8TLVQF
         NJp81mxhklgT44e8z7/g1x5oWY2dRWC2dUg/hq9V8g4dbNbjdarKRBTSrjiM2Eiu/U
         dyPM0XsInN/ZimsPOXkBloJbnSSId84sLgEvbNY8P2iSD6TBRmjHhWU96ltEg5UjNh
         bG+m+n/zJ5AIw==
Received: by mail-il1-f182.google.com with SMTP id y16so538411ilq.6;
        Tue, 05 Apr 2022 14:28:14 -0700 (PDT)
X-Gm-Message-State: AOAM530Mc+MQ7T853Voa26KHy5LFC27FB5TuhWujV3eOzv2G7nMwyeOx
        OWun2lkgr7X45+B9huobgjJ72+v/zVgTCHL0Ig==
X-Google-Smtp-Source: ABdhPJywDkiVM1kX65rReD44qtz6uP2bKpaT+ryBVPh2PSvxSFlU1fiugGmtpYEY8FBCEeoCF77xxc9YGMJKmcD88gg=
X-Received: by 2002:a05:6e02:1685:b0:2c9:a9e9:846 with SMTP id
 f5-20020a056e02168500b002c9a9e90846mr2817768ila.273.1649194093891; Tue, 05
 Apr 2022 14:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220324141237.297207-1-clement.leger@bootlin.com>
 <Ykst0Vb4fk+iALzc@robh.at.kernel.org> <20220405092434.6e424ed4@fixe.home>
 <YkxWeMNw9Ba0KjHM@robh.at.kernel.org> <20220405175120.23fc6b2a@fixe.home> <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
In-Reply-To: <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 5 Apr 2022 16:28:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL4xY-k4ZsJDuxX6Wbevv+aNRki4WfeiXg0R-4NkqPC1w@mail.gmail.com>
Message-ID: <CAL_JsqL4xY-k4ZsJDuxX6Wbevv+aNRki4WfeiXg0R-4NkqPC1w@mail.gmail.com>
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

On Tue, Apr 5, 2022 at 12:11 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Apr 5, 2022 at 10:52 AM Cl=C3=A9ment L=C3=A9ger <clement.leger@bo=
otlin.com> wrote:
> >
> > Le Tue, 5 Apr 2022 09:47:20 -0500,
> > Rob Herring <robh@kernel.org> a =C3=A9crit :
> >
> > > + some Xilinx folks
> > >
> > > On Tue, Apr 05, 2022 at 09:24:34AM +0200, Cl=C3=A9ment L=C3=A9ger wro=
te:
> > > > Le Mon, 4 Apr 2022 12:41:37 -0500,
> > > > Rob Herring <robh@kernel.org> a =C3=A9crit :
> > > >
> > > > > On Thu, Mar 24, 2022 at 03:12:34PM +0100, Cl=C3=A9ment L=C3=A9ger=
 wrote:
> > > > > > This series is part of a larger series which aims at adding fwn=
ode
> > > > > > support in multiple subsystems [1]. The goal of this series was=
 to
> > > > > > add support for software node in various subsystem but in a fir=
st
> > > > > > time only the fwnode support had gained consensus and will be a=
dded
> > > > > > to multiple subsystems.
> > > > >
> > > > > The goal is describing a solution. What is the problem?
> > > > >
> > > > > What's the scenario where you have a reset provider not described=
 by
> > > > > firmware providing resets to devices (consumers) also not describ=
ed by
> > > > > firmware.
> > > >
> > > > Hi Rob, there was a link attached to this series since there was a
> > > > previous one that was sent which described the problem. Here is a l=
ink
> > > > to the same thread but to a specific message which clarifies the
> > > > problem and the solutions that were mentionned by other maintainers
> > > > (ACPI overlays, DT overlays, software nodes and so on):
> > > >
> > > > https://lore.kernel.org/netdev/20220224154040.2633a4e4@fixe.home/
> > >
> > > Thanks, but your commit message should explain the problem. The probl=
em
> > > is not subsystems don't support fwnode.
> > >
> > > This is the exact same problem the Xilinx folks are trying to solve w=
ith
> > > their PCIe FPGA cards[1] (and that is not really a v1). They need to
> > > describe h/w downstream from a 'discoverable' device. Their case is
> > > further complicated with the dynamic nature of FPGAs. It's also not j=
ust
> > > PCIe. Another usecase is describing downstream devices on USB FTDI
> > > serial chips which can have GPIO, I2C, SPI downstream. And then you w=
ant
> > > to plug in 10 of those.
> >
> > I also tried loading an overlay from a driver on an ACPI based system.
> > Their patch is (I guess) targeting the specific problem that there is
> > no base DT when using ACPI. However, Mark Brown feedback was not to
> > mix OF and ACPI:
>
> I agree there. I don't think we should use DT bindings in ACPI tables
> which is already happening. In this case, I think what's described by
> ACPI and DT must be completely disjoint. I think that's the case here
> as everything is downstream of the PCIe device.
>
> > "That seems like it's opening a can of worms that might be best left
> > closed."
> >
> > But I would be interested to know how the Xilinx guys are doing that
> > on x86/ACPI based system.
>
> They aren't, yet...
>
>
> > > I don't think swnodes are going to scale for these usecases. We moved
> > > h/w description out of the kernel for a reason. Why are we adding tha=
t
> > > back in a new form? The complexity for what folks want to describe is
> > > only going to increase.
> > >
> > > I think DT overlays is the right (or only) solution here. Of course t=
he
> > > DT maintainer would say that. Actually, I would be happier to not hav=
e
> > > to support overlays in the kernel.
> >
> > DT overlay might work on DT based system. If I'm going to plug the card
> > on an ACPI based platform (x86), I also want that card to work
> > seamlessly without requiring the user to create an ACPI overlay.
>
> I agree, it should work the same way for the user.
>
> > If you proposal was to use DT overlays on an ACPI based system, doing
> > so would also require to "plug" the PCI subystem when described with
> > ACPI to "probe" DT overlays describing PCI devices, not sure this is
> > something trivial and it would be PCI centric.
>
> Yes, this is the 2nd part I describe. I don't think there's any way to
> avoid this being bus specific because bus specific nodes have to be
> created.
>
>
> > > I've told the Xilinx folks the same thing, but I would separate this
> > > into 2 parts. First is just h/w work in a DT based system. Second is
> > > creating a base tree an overlay can be applied to. The first part sho=
uld
> > > be pretty straightforward. We already have PCI bus bindings. The only
> > > tricky part is getting address translation working from leaf device t=
hru
> > > the PCI bus to host bus, but support for that should all be in place
> > > (given we support ISA buses off of PCI bus). The second part will
> > > require generating PCI DT nodes at runtime. That may be needed for bo=
th
> > > DT and ACPI systems as we don't always describe all the PCI hierarchy
> > > in DT.
> >
> > But then, if the driver generate the nodes, it will most probably
> > have to describe the nodes by hardcoding them right ?
>
> No, the kernel already maintains its own tree of devices. You just
> need to use that to generate the tree. That's really not much more
> than nodes with a 'reg' property encoding the device and function
> numbers.
>
> We already support matching a PCI device to a DT node. The PCI
> subsystem checks if there is a corresponding DT node for each PCI
> device created and sets the of_node pointer if there is. For
> OpenFirmware systems (PPC), there always is a node. For FDT, we
> generally don't have a node unless there are additional
> non-discoverable properties. Hikey960 is an example with PCI device
> nodes in the DT as it has a soldered down PCIe switch with downstream
> devices and non-discoverable properties (e.g. reset GPIO for each
> port).

Here's a quick and dirty implementation creating DT nodes for PCI devices:

git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/pop-pci-nod=
es

Rob
