Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE74F60EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiDFOKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiDFOIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:08:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE312C272
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:48:12 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nc2Ga-00078y-C5; Wed, 06 Apr 2022 11:47:56 +0200
Message-ID: <6a77a71069d771d408f716d05cafc6b3a1e13cda.camel@pengutronix.de>
Subject: Re: [PATCH 0/5] imx: support noc settings with power domain
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Date:   Wed, 06 Apr 2022 11:47:54 +0200
In-Reply-To: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
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

Am Mittwoch, dem 06.04.2022 um 16:23 +0800 schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP has a design that NoC(Not main NoC) is distributed in multiple
> blocks, such as vpumix, hsiomix and etc. The access to NoC requires
> power domain on and blk ctrl settings configured.
> 
> So the design here is for mixes that not have blk-ctrl, configure
> the NoC in gpcv2 driver, for mixes that have blk-ctrl, configure
> the NoC in blk-ctrl drivers.
> 
> This v1 patchset not apply on Shawn's tree, I picked up Lucas's HSIO
> and Laurent's mediablk patches, then worked out this patchset:
> https://github.com/MrVan/linux/tree/noc-imx8mp
> 
> Note: This interconnect related functions not added. This patchset
> is only to replace the function did in NXP downstream:
> https://source.codeaurora.org/external/imx/imx-atf/tree/plat/imx/imx8m/imx8mp/gpc.c?h=lf_v2.4#n157

As a general comment I think this is implemented the wrong way around.

Neither GPC, nor the blk-ctrl should poke into the NoC registers
directly. The NoC driver should attach itself to the power domain via a
notifier (same as the blk-ctrl does with the GPC domains) and should do
the necessary NoC configuration when the power domain is powered up.

Regards,
Lucas
> 
> Peng Fan (5):
>   dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
>   arm64: dts: imx8mp: add noc node
>   soc: imx: gpcv2: support i.MX8MP NoC settings
>   soc: imx: imx8m-blk-ctrl: support i.MX8MP media blk ctrl noc settings
>   soc: imx: imx8mp-blk-ctrl: introduce HSIO blk ctrl noc settings
> 
>  .../bindings/interconnect/fsl,imx8m-noc.yaml  |   6 +
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |   7 ++
>  drivers/soc/imx/gpcv2.c                       |  56 ++++++++-
>  drivers/soc/imx/imx8m-blk-ctrl.c              | 109 ++++++++++++++++++
>  drivers/soc/imx/imx8mp-blk-ctrl.c             |  74 ++++++++++++
>  5 files changed, 251 insertions(+), 1 deletion(-)
> 


