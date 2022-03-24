Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDBC4E617F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349417AbiCXKJ6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Mar 2022 06:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242043AbiCXKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:09:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D51F972FA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:08:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nXKO8-00089R-Na; Thu, 24 Mar 2022 11:08:16 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nXKO5-002foR-14; Thu, 24 Mar 2022 11:08:15 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nXKO7-0003cW-2q; Thu, 24 Mar 2022 11:08:15 +0100
Message-ID: <6e04fbc91a924201aac672165a938bf76cf873f1.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] add fwnode support to reset subsystem
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Thu, 24 Mar 2022 11:08:15 +0100
In-Reply-To: <20220323170545.79810f56@fixe.home>
References: <20220323095022.453708-1-clement.leger@bootlin.com>
         <d2d119b07cb51878904574ff14c8e4dd92c28907.camel@pengutronix.de>
         <20220323170545.79810f56@fixe.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2022-03-23 at 17:05 +0100, Clément Léger wrote:
[...]
> 
> As you noticed, the initial goal of the primary series was to add
> fwnode support in order to allow registering devices with software
> nodes. Since a lot of subsystem are of-centric, It was needed to
> modify them to use fwnode and thus accept the use of software nodes.
> 
> The device I'm trying to support is a PCIe card that uses a lan9662
> SoC. This card is meant to be used an ethernet switch with 2 x RJ45
> ports and 2 x 10G SFPs. The lan966x SoCs can be used in two different
> ways:
> 
>  - It can run Linux by itself, on ARM64 cores included in the SoC. This
>    use-case of the lan966x is currently being upstreamed, using a
>    traditional Device Tree representation of the lan996x HW blocks [1]
>    A number of drivers for the different IPs of the SoC have already
>    been merged in upstream Linux.
> 
>  - It can be used as a PCIe endpoint, connected to a separate platform
>    that acts as the PCIe root complex. In this case, all the devices
>    that are embedded on this SoC are exposed through PCIe BARs and the
>    ARM64 cores of the SoC are not used. Since this is a PCIe card, it
>    can be plugged on any platform, of any architecture supporting PCIe.
> 
> Appart from adding software node support, the fwnode API would also
> allow to add ACPI support more easily later.

Thank you for the explanation. So this would be used by the sparx5
switch reset driver to provide the microchip,lan966x-switch-reset
controller via software node?

If that needs to be converted to fwnode anyway, it would be nice to
include the conversion in this series as an example.

[...]
> On that side, I must say I'm not really competent regarding ACPI
> which I do not know enough to answer you on that point.
> 
> The discussions we had with Mark Brown regarding fwnode ACPI support
> pointed out the fact that we should not create unwanted ACPI support
> by using the same descriptions/specifications that exists for the
> device-tree. In order to avoid that, we suggested to explicitely left
> out ACPI with this fwnode support. This will allow to specify that
> support later and integrate it in the subsystem that have been
> converted to fwnode.

Ok.

> > 
> > On the other hand, I think it would be good to avoid the direct of_node
> > assignment, possibly by letting devm_reset_controller_register()
> > initialize of_node or fwnode from the device for most cases, and by
> > adding of_reset_controller_register() and
> > fwnode_reset_controller_register() variants that take the node as an
> > argument for the rest.
> > That could allow to eventually get rid of the of_node pointer.
> 
> Ok, I see that. Do you want this to be done in this series ?

Just thinking out loudly, before starting to drop the
rcdev->of_node assigment from drivers en masse, I'd like to use the
opportunity and turn reset_controller_register() and friends into
macros that provide the module owner as a parameter, so the explicit
rcdev->owner = THIS_MODULE assignment can be removed from the drivers
as well.

I think that is better done separately.

> > For those drivers that provide their own .of_xlate, I'm not sure it
> > would make sense to force them to use .fwnode_xlate if they don't
> > already have a reason to use fwnode on their own.
> 
> No indeed and that's why I added the fwnode_xlate -> of_xlate
> translation function, this will allow to keep the existing of_xlate
> support.

Ok.

regards
Philipp
