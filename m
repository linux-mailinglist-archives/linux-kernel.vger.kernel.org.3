Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55C454B7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344782AbiFNRj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344635AbiFNRjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:39:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3CF2F64E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:39:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1o1AVr-0005KQ-66; Tue, 14 Jun 2022 19:39:35 +0200
Message-ID: <c2034c030333f89e0ac7d86c906dd222cc151d52.camel@pengutronix.de>
Subject: Re: [PATCH 0/8] interconnect: support i.MX8MP
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "djakov@kernel.org" <djakov@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Abel Vesa <abel.vesa@nxp.com>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Tue, 14 Jun 2022 19:39:33 +0200
In-Reply-To: <DU0PR04MB941799547BD863444C6F268D88AB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
         <DU0PR04MB941799547BD863444C6F268D88AB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
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

Hi Peng,

Am Montag, dem 13.06.2022 um 01:23 +0000 schrieb Peng Fan:
> All,
> 
> > Subject: [PATCH 0/8] interconnect: support i.MX8MP
> 
> I am going to send out V2 this week to address the comments until now.
> But before that I would like to see if any one has any comments on the
> design here.
> 
> Georgi, do you have comments on Patch 2 " interconnect: add device
> managed bulk API"
> 
> Lucas, since you had comments when I first use syscon to configure NoC,
> are you ok with the design to use interconnect in this patchset?
> 
I'm still not 100% convinced that the blk-ctrl is the right consumer
for the interconnect, since it doesn't do any busmastering. However,
the design looks much better than the syscon based one.

I mostly worry about being able to extend this to do more than the
current static configuration if/when NXP decides to release more
information about the NoC configuration options or someone reverse
engineers this part of the SoC. I still hope that we could optimize NoC
usage by setting real bandwidth and latency limits for the devices
connected to the NoC. As the blk-ctrl doesn't have any clue about this
right now, we can't really set any more specific requests than the
current INT_MAX ones.
I guess we could extend things in this way by making the blk-ctrl not
only be a simple consumer of the interconnect, but aggregate requests
from the devices in the blk-ctrl domain and forward them to the NOC
provider, right?

Regards,
Lucas

> Thanks,
> Peng.
> 
> > 
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > This patchset is to support i.MX8MP NoC settings, i.MX8MP NoC initial value
> > after power up is invalid, need set a valid value after related power domain up.
> > 
> > This patchset also includes two patch[1,2] during my development to enable the
> > ICC feature for i.MX8MP.
> > 
> > I not include ddrc DVFS in this patchset, ths patchset is only to support NoC
> > value mode/priority/ext_control being set to a valid value that suggested by
> > i.MX Chip Design Team. The value is same as NXP downstream one inside Arm
> > Trusted Firmware:
> > https://source.codeaurora.org/external/imx/imx-atf/tree/plat/imx/imx8m/imx
> > 8mp/gpc.c?h=lf_v2.4#n97
> > 
> > A repo created here:
> > https://github.com/MrVan/linux/tree/imx8mp-interconnect
> > 
> > Peng Fan (8):
> >   dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
> >   interconnect: add device managed bulk API
> >   interconnect: imx: fix max_node_id
> >   interconnect: imx: set src node
> >   interconnect: imx: introduce imx_icc_provider
> >   interconnect: imx: set of_node for interconnect provider
> >   interconnect: imx: configure NoC mode/prioriry/ext_control
> >   interconnect: imx: Add platform driver for imx8mp
> > 
> >  .../bindings/interconnect/fsl,imx8m-noc.yaml  |   6 +
> >  drivers/interconnect/bulk.c                   |  34 +++
> >  drivers/interconnect/imx/Kconfig              |   4 +
> >  drivers/interconnect/imx/Makefile             |   2 +
> >  drivers/interconnect/imx/imx.c                |  68 +++--
> >  drivers/interconnect/imx/imx.h                |  25 +-
> >  drivers/interconnect/imx/imx8mm.c             |   2 +-
> >  drivers/interconnect/imx/imx8mn.c             |   2 +-
> >  drivers/interconnect/imx/imx8mp.c             | 232
> > ++++++++++++++++++
> >  drivers/interconnect/imx/imx8mq.c             |   2 +-
> >  include/dt-bindings/interconnect/fsl,imx8mp.h |  59 +++++
> >  include/linux/interconnect.h                  |   6 +
> >  12 files changed, 424 insertions(+), 18 deletions(-)  create mode 100644
> > drivers/interconnect/imx/imx8mp.c  create mode 100644
> > include/dt-bindings/interconnect/fsl,imx8mp.h
> > 
> > --
> > 2.25.1
> 


