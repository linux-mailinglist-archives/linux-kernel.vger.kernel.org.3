Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE304F6285
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiDFPIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiDFPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:07:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CA21BD9A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:01:48 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nc4Gd-0000QF-Of; Wed, 06 Apr 2022 13:56:07 +0200
Message-ID: <4fc33f18fcde29d421a014c22f6ea92a41a39da9.camel@pengutronix.de>
Subject: Re: [PATCH 0/5] imx: support noc settings with power domain
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "djakov@kernel.org" <djakov@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Cc:     "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 06 Apr 2022 13:56:06 +0200
In-Reply-To: <DU0PR04MB9417E35732AD4B823726D84D88E79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
         <6a77a71069d771d408f716d05cafc6b3a1e13cda.camel@pengutronix.de>
         <DU0PR04MB9417E35732AD4B823726D84D88E79@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 06.04.2022 um 10:55 +0000 schrieb Peng Fan:
> > Subject: Re: [PATCH 0/5] imx: support noc settings with power domain
> > 
> > Hi Peng,
> > 
> > Am Mittwoch, dem 06.04.2022 um 16:23 +0800 schrieb Peng Fan (OSS):
> > > From: Peng Fan <peng.fan@nxp.com>
> > > 
> > > i.MX8MP has a design that NoC(Not main NoC) is distributed in multiple
> > > blocks, such as vpumix, hsiomix and etc. The access to NoC requires
> > > power domain on and blk ctrl settings configured.
> > > 
> > > So the design here is for mixes that not have blk-ctrl, configure the
> > > NoC in gpcv2 driver, for mixes that have blk-ctrl, configure the NoC
> > > in blk-ctrl drivers.
> > > 
> > > This v1 patchset not apply on Shawn's tree, I picked up Lucas's HSIO
> > > and Laurent's mediablk patches, then worked out this patchset:
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
> > > 
> > ub.com%2FMrVan%2Flinux%2Ftree%2Fnoc-imx8mp&amp;data=04%7C01%7
> > Cpeng.fan
> > > %40nxp.com%7C3bd1d020ad8f4a68efc808da17b28ac8%7C686ea1d3bc2b
> > 4c6fa92cd9
> > > 
> > 9c5c301635%7C0%7C0%7C637848352908363591%7CUnknown%7CTWFpbG
> > Zsb3d8eyJWIj
> > > 
> > oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> > 000&am
> > > 
> > p;sdata=ZVeHFy%2FEaWPhAj%2BURGIDXoWYdX5eeQoEIeZYZoxPPNo%3D&a
> > mp;reserve
> > > d=0
> > > 
> > > Note: This interconnect related functions not added. This patchset is
> > > only to replace the function did in NXP downstream:
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsour
> > > 
> > ce.codeaurora.org%2Fexternal%2Fimx%2Fimx-atf%2Ftree%2Fplat%2Fimx%2
> > Fimx
> > > 
> > 8m%2Fimx8mp%2Fgpc.c%3Fh%3Dlf_v2.4%23n157&amp;data=04%7C01%7C
> > peng.fan%4
> > > 
> > 0nxp.com%7C3bd1d020ad8f4a68efc808da17b28ac8%7C686ea1d3bc2b4c6fa
> > 92cd99c
> > > 
> > 5c301635%7C0%7C0%7C637848352908363591%7CUnknown%7CTWFpbGZs
> > b3d8eyJWIjoi
> > > 
> > MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> > 00&amp;
> > > 
> > sdata=eLawc3SJQBRmVwcOA2%2B6u6d2ZaYxqcO4Gm%2FqEJpqxFE%3D&a
> > mp;reserved=
> > > 0
> > 
> > As a general comment I think this is implemented the wrong way around.
> > 
> > Neither GPC, nor the blk-ctrl should poke into the NoC registers directly. The
> > NoC driver should attach itself to the power domain via a notifier (same as
> > the blk-ctrl does with the GPC domains) and should do the necessary NoC
> > configuration when the power domain is powered up.
> 
> If separate NoC in a standalone driver, NoC may be configured not as early as
> power domain up. Saying lcdif is running, NoC driver probe starts w/o defer
> probe.

The right way to solve this would be to actually implement the
interconnect bits, so that consumers like the LCDIF that have specific
NOC bandwidth/latency requirements could request them from the NoC
driver. Proper probe deferral would come naturally with this.

The static NoC configuration per domain is quite a cludge IHMO, maybe
due to the decision to not open up any information about this part of
the SoC. Spreading support for this hack into multiple drivers doesn't
sound like a direction we want to take for upstream. At minimum we
could try to define the interconnect DT bits, so that the LCDIF driver,
etc. could attach to the NoC driver, giving us proper probe defer
behavior, even if the actual configuration is still static.

Regards,
Lucas

