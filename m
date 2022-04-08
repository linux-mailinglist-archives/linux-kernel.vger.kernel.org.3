Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3DD4F99DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbiDHPwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237793AbiDHPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:52:18 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3CFCA6FB;
        Fri,  8 Apr 2022 08:50:12 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EB2ECC0003;
        Fri,  8 Apr 2022 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649433011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rAt83kGtVYJZF3EBEbN5MMvf2qH0ArJM1Y4wwCRzF+U=;
        b=goYCf35UiOfKb4ovjeqCSFHPqjUX3tM40fxE3XD+Wq4RyPbPohztgA71H3Yi9bpVbBXBi5
        gMskv8UFPDa90U/jaP3a/s6KsVrUrCb2wUT7rwKTCVgWAeX/xraUBK5dF4+7kGeJJYQpC2
        aezVXmlE4tN8MSGGIu6pSlC1vTGmxM+M7H/n/cxYXjO4q3OKklOvPMscUXsybbIFmaad04
        gFm+Jb0iPYEL6s6Tt8wIYS5tJljiUduDVbo5TtJ3WAloASa/kYC87so4fltXcq2Z2Ii79R
        B35n6YO3fyqhB4hJ/WzTI6ZbTe+wkldCQMwNqt+o7Mf86A0AKrmqqSTo/j+6OQ==
Date:   Fri, 8 Apr 2022 17:48:41 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Rob Herring <robh@kernel.org>
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
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
Message-ID: <20220408174841.34458529@fixe.home>
In-Reply-To: <Yk2TVAfPVh9a1tUR@robh.at.kernel.org>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
        <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
        <20220405092434.6e424ed4@fixe.home>
        <YkxWeMNw9Ba0KjHM@robh.at.kernel.org>
        <20220405175120.23fc6b2a@fixe.home>
        <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
        <20220406094019.670a2956@fixe.home>
        <Yk2TVAfPVh9a1tUR@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

Le Wed, 6 Apr 2022 08:19:16 -0500,
Rob Herring <robh@kernel.org> a =C3=A9crit :

> >  =20
> > >=20
> > >  =20
> > > > > I've told the Xilinx folks the same thing, but I would separate t=
his
> > > > > into 2 parts. First is just h/w work in a DT based system. Second=
 is
> > > > > creating a base tree an overlay can be applied to. The first part=
 should
> > > > > be pretty straightforward. We already have PCI bus bindings. The =
only
> > > > > tricky part is getting address translation working from leaf devi=
ce thru
> > > > > the PCI bus to host bus, but support for that should all be in pl=
ace
> > > > > (given we support ISA buses off of PCI bus). The second part will
> > > > > require generating PCI DT nodes at runtime. That may be needed fo=
r both
> > > > > DT and ACPI systems as we don't always describe all the PCI hiera=
rchy
> > > > > in DT.   =20
> > > >
> > > > But then, if the driver generate the nodes, it will most probably
> > > > have to describe the nodes by hardcoding them right ?   =20
> > >=20
> > > No, the kernel already maintains its own tree of devices. You just
> > > need to use that to generate the tree. That's really not much more
> > > than nodes with a 'reg' property encoding the device and function
> > > numbers. =20
> >=20
> > Just to clarified a point, my PCI device exposes multiple peripherals
> > behind one single PCI function. =20
>=20
> Right. I would expect your PCI device DT node to have a 'simple-bus'=20
> child node with all those peripherals. And maybe there's other nodes=20
> like fixed-clocks, etc.
>=20
> > To be sure I understood what you are suggesting, you propose to create
> > a DT node from the PCI driver that has been probed dynamically
> > matching this same PCI device with a 'reg' property. I also think
> > this would requires to generate some 'pci-ranges' to remap the
> > downstream devices that are described in the DTBO, finally, load the
> > overlay to be apply under this newly created node. Is that right ? =20
>=20
> Right. You'll need to take the BAR address(es) for the device and stick=20
> those into 'ranges' to translate offsets to BAR+offset.

Hi Rob,

I got something working (address translation, probing and so on) using
what you started. I switch to using changeset however, I'm not sure that
it make sense for property creation since the node has not yet been
added to the tree. Attaching the node with changeset however seems
to make sense. But I'm no expert here, so any advise is welcome.

Based on what we said, I created a PCI driver which uses a builtin
overlay. In order to be able to apply the overlay on the correct PCI
node -the one on which the card was plugged) and thus be totally plug
and play, the 'target-path' property is patched using direct fdt
function and replaced the target with the PCI device node path.
I don't see any other way to do that before applying the overlay since
of_overlay_fdt_apply() takes a fdt blob as input.

The driver also insert correct ranges into the PCI device in order to
translate the downstream node addresses to BAR addresses. It seems
reasonnable to assume that this depends on the driver and thus should
not be done by the PCI of core at all.

Finally, the driver probes the newly added childs using
of_platform_populate(). With all of that, the address translation
and the probing works correctly and the platform devices are created.
There is still a few things to fix such as the following:

[ 2830.324773] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /pci/pci@2,6/dev@0,0/compatible

But it seems like this is something that works and would allow to
support various use cases. From what I see, it should also work on
other platforms. Major advantage of that over fwnode is that the
changes are pretty small and relatively contained.

However, one point that might be a bit of a problem is enabling
CONFIG_OF on x86 for instance. While it seems to work, is there any
potential concerns about this ? Moreover, ideally, I would want the
driver to "select OF" since without that, the driver won't be visible.
Or should it "depends on OF" but thus, it would be almost mandatory to
enable CONFIG_OF on x86 kernels if we want to support this driver
without the need to recompile a kernel.

Thanks,

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
