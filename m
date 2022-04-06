Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588DA4F5DBB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiDFMKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiDFMKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:10:33 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1B295A3C;
        Wed,  6 Apr 2022 00:53:44 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B19C3E0016;
        Wed,  6 Apr 2022 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649231623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aEHF044mvurdicWAqWTz+vjeqtSmEBRXsYOuXWhcUIE=;
        b=b/QN8+a5O6IuWnDPBGXJBxablmzOTzv3O3zC1Q5qYmh3hnM8Ben3qtFlLnjmilYYPoZVv+
        LY1z0SEQVOIMkXV7ipnv5VOSpdmuPMGIgpJQaiKieocdxEj56RWgje4FOSa0ip6R2wdB3r
        ynGdDdmiO0qdQjBk9C4syeIwccxxFr/xfi3F+f1583B8x9w6ovtdfN39Zyt8Qn/9R4rFfH
        PD8r79eUMyGAQOVn43/Hm3fyl34B6BTvQH8tISWnl7kbDZLetK2yUU/9NYlWEIvHPQBdLB
        PWtQD7zfNHLmK23EzE5z29fr2Ix3MyaM10BFYOWV2lbb49BxEHF/kfqBwvi19A==
Date:   Wed, 6 Apr 2022 09:52:13 +0200
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
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
Message-ID: <20220406095213.21cf3ffb@fixe.home>
In-Reply-To: <CAL_JsqL4xY-k4ZsJDuxX6Wbevv+aNRki4WfeiXg0R-4NkqPC1w@mail.gmail.com>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
        <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
        <20220405092434.6e424ed4@fixe.home>
        <YkxWeMNw9Ba0KjHM@robh.at.kernel.org>
        <20220405175120.23fc6b2a@fixe.home>
        <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
        <CAL_JsqL4xY-k4ZsJDuxX6Wbevv+aNRki4WfeiXg0R-4NkqPC1w@mail.gmail.com>
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

Le Tue, 5 Apr 2022 16:28:02 -0500,
Rob Herring <robh@kernel.org> a =C3=A9crit :


> >
> > No, the kernel already maintains its own tree of devices. You just
> > need to use that to generate the tree. That's really not much more
> > than nodes with a 'reg' property encoding the device and function
> > numbers.
> >
> > We already support matching a PCI device to a DT node. The PCI
> > subsystem checks if there is a corresponding DT node for each PCI
> > device created and sets the of_node pointer if there is. For
> > OpenFirmware systems (PPC), there always is a node. For FDT, we
> > generally don't have a node unless there are additional
> > non-discoverable properties. Hikey960 is an example with PCI device
> > nodes in the DT as it has a soldered down PCIe switch with downstream
> > devices and non-discoverable properties (e.g. reset GPIO for each
> > port). =20
>=20
> Here's a quick and dirty implementation creating DT nodes for PCI devices:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/pop-pci-n=
odes

Ok, thanks, after looking at the branch, it appears that you expect the
PCI nodes matching the probed PCI devices should be created by the PCI
subsystem itself. My previous comment saying that the node would be
created by the PCI driver itself is then wrong and I understand what
you meant.

Then, there is still a bit of magic to do to correctly fill the ranges
for translation and then the driver "simply" have to load the dtbo and
apply it with of_overlay_fdt_apply().

>=20
> Rob



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
