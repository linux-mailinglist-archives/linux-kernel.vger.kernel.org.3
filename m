Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B98950DDCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiDYKYs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Apr 2022 06:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiDYKYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:24:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A7B583B2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:21:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nivqI-00049H-9V; Mon, 25 Apr 2022 12:21:18 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nivqH-0057yg-Ob; Mon, 25 Apr 2022 12:21:16 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nivqF-0005uW-Hw; Mon, 25 Apr 2022 12:21:15 +0200
Message-ID: <1ec5ce3673dcdaa914e20ef2aae03f549d05ff9a.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Rob Herring <robh@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@xilinx.com>,
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
Date:   Mon, 25 Apr 2022 12:21:15 +0200
In-Reply-To: <20220408174841.34458529@fixe.home>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
         <Ykst0Vb4fk+iALzc@robh.at.kernel.org> <20220405092434.6e424ed4@fixe.home>
         <YkxWeMNw9Ba0KjHM@robh.at.kernel.org> <20220405175120.23fc6b2a@fixe.home>
         <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
         <20220406094019.670a2956@fixe.home> <Yk2TVAfPVh9a1tUR@robh.at.kernel.org>
         <20220408174841.34458529@fixe.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

On Fr, 2022-04-08 at 17:48 +0200, Clément Léger wrote:
[...]
> > > > > > I've told the Xilinx folks the same thing, but I would separate this
> > > > > > into 2 parts. First is just h/w work in a DT based system. Second is
> > > > > > creating a base tree an overlay can be applied to. The first part should
> > > > > > be pretty straightforward. We already have PCI bus bindings. The only
> > > > > > tricky part is getting address translation working from leaf device thru
> > > > > > the PCI bus to host bus, but support for that should all be in place
> > > > > > (given we support ISA buses off of PCI bus). The second part will
> > > > > > require generating PCI DT nodes at runtime. That may be needed for both
> > > > > > DT and ACPI systems as we don't always describe all the PCI hierarchy
> > > > > > in DT.    
> > > > > 
> > > > > But then, if the driver generate the nodes, it will most probably
> > > > > have to describe the nodes by hardcoding them right ?    
> > > > 
> > > > No, the kernel already maintains its own tree of devices. You just
> > > > need to use that to generate the tree. That's really not much more
> > > > than nodes with a 'reg' property encoding the device and function
> > > > numbers.  
> > > 
> > > Just to clarified a point, my PCI device exposes multiple peripherals
> > > behind one single PCI function.  
> > 
> > Right. I would expect your PCI device DT node to have a 'simple-bus' 
> > child node with all those peripherals. And maybe there's other nodes 
> > like fixed-clocks, etc.
> > 
> > > To be sure I understood what you are suggesting, you propose to create
> > > a DT node from the PCI driver that has been probed dynamically
> > > matching this same PCI device with a 'reg' property. I also think
> > > this would requires to generate some 'pci-ranges' to remap the
> > > downstream devices that are described in the DTBO, finally, load the
> > > overlay to be apply under this newly created node. Is that right ?  
> > 
> > Right. You'll need to take the BAR address(es) for the device and stick 
> > those into 'ranges' to translate offsets to BAR+offset.
> 
> Hi Rob,
> 
> I got something working (address translation, probing and so on) using
> what you started. I switch to using changeset however, I'm not sure that
> it make sense for property creation since the node has not yet been
> added to the tree. Attaching the node with changeset however seems
> to make sense. But I'm no expert here, so any advise is welcome.
>
> Based on what we said, I created a PCI driver which uses a builtin
> overlay. In order to be able to apply the overlay on the correct PCI
> node -the one on which the card was plugged) and thus be totally plug
> and play, the 'target-path' property is patched using direct fdt
> function and replaced the target with the PCI device node path.
> I don't see any other way to do that before applying the overlay since
> of_overlay_fdt_apply() takes a fdt blob as input.
> 
> The driver also insert correct ranges into the PCI device in order to
> translate the downstream node addresses to BAR addresses. It seems
> reasonnable to assume that this depends on the driver and thus should
> not be done by the PCI of core at all.
> 
> Finally, the driver probes the newly added childs using
> of_platform_populate(). With all of that, the address translation
> and the probing works correctly and the platform devices are created.
> There is still a few things to fix such as the following:
> 
> [ 2830.324773] OF: overlay: WARNING: memory leak will occur if overlay
> removed, property: /pci/pci@2,6/dev@0,0/compatible
> 
> But it seems like this is something that works and would allow to
> support various use cases. From what I see, it should also work on
> other platforms. Major advantage of that over fwnode is that the
> changes are pretty small and relatively contained.

Could you show this off somewhere?

From this I take that fwnode support in the reset subsystem is not of
use to you anymore. I'll postpone taking your patches then, until they
are needed.

regards
Philipp
