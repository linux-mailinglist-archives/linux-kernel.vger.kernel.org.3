Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F735731A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiGMI4d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Jul 2022 04:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiGMI41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:56:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048A8D2153
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:56:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oBYAK-0006wb-Ea; Wed, 13 Jul 2022 10:56:16 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oBYAJ-000fxr-LF; Wed, 13 Jul 2022 10:56:15 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oBYAI-0002b8-JK; Wed, 13 Jul 2022 10:56:14 +0200
Message-ID: <23196dd7ad4eacbee3ad7f4f29b94917a5451450.camel@pengutronix.de>
Subject: Re: [PATCH] reset: microchip-sparx5: allow building as a module
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Michael Walle <michael@walle.cc>
Cc:     Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
        allan.nielsen@microchip.com, clement.leger@bootlin.com,
        horatiu.vultur@microchip.com, lars.povlsen@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Date:   Wed, 13 Jul 2022 10:56:14 +0200
In-Reply-To: <20220712125836.2676525-1-michael@walle.cc>
References: <99cba2d231c5971525ec976611e66f86259dd1e0.camel@pengutronix.de>
         <20220712125836.2676525-1-michael@walle.cc>
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

Hi Michael,

On Di, 2022-07-12 at 14:58 +0200, Michael Walle wrote:
> Hi,
> 
> > On Fr, 2022-06-17 at 12:37 +0200, Clément Léger wrote:
> > > Set RESET_MCHP_SPARX5 as a tristate and add MODULE_DEVICE_TABLE() to
> > > allow building this driver as a module.
> > > 
> > > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> > 
> > Thank you, applied to reset/next.
> 
> Unfortunately, this is breaking ethernet on my board
> (lan966x-kontron-kswitch-d10-mmt-6g-2gs, see dts in arch/arm/).
> 
> I suspect this is because the postcore_initcall() was called earlier
> in the kernel startup. Now, somehow the MDIO controller isn't working
> anymore.
> 
> For a bit of a background, on the LAN9668 (I guess this is also true
> on most other microchip switch platforms), there is a global switch
> reset which is shared among most subsystems, i.e GPIO, SGPIO and
> switch core. The switch driver will use this reset as there is no other
> reset available (e.g. one which only reset the switching core). But when
> it asserts the reset it will also reset other devices on the SoC. This
> was for example the case for the GPIO, see commit 453200af8a85 ("pinctrl:
> ocelot: add optional shared reset"). It seems like the MIIM is also
> affected by this global reset, thus it needs the same fix.
> 
> I tried the obvious by adding the reset to the MIIM, but that didn't
> help for all broken interfaces. I have to dig deeper into that.
> 
> In the meantime I'd appreciate it if this commit can be reverted until
> the other fixes (at least the missing MIIM reset) will be merged.

Thank you for catching this so quickly, I've sent a revert [1].
I'll add that to reset/next, please let me know when this is fixed.

[1] https://lore.kernel.org/all/20220713084010.168720-1-p.zabel@pengutronix.de/

regards
Philipp
