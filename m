Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48042516E0C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384463AbiEBKW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384510AbiEBKWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:22:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF63263B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:18:54 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nlT8c-0006jf-QH; Mon, 02 May 2022 12:18:42 +0200
Message-ID: <f91157496327cead5d098a4f37e9f019e526f7c8.camel@pengutronix.de>
Subject: Re: [PATCH v1 0/4] imx8mm display controller power sequence
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Viraj Shah <viraj.shah@linutronix.de>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 02 May 2022 12:18:39 +0200
In-Reply-To: <20220502100233.6023-1-viraj.shah@linutronix.de>
References: <20220502100233.6023-1-viraj.shah@linutronix.de>
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

Hi Viraj,

Am Montag, dem 02.05.2022 um 12:02 +0200 schrieb Viraj Shah:
> This patch queue addresses the power sequence of the display controller
> of the imx8mm SoC. The sequence mentioned in example code 5 in section
> 5.2.9.5 of reference manual imx-8MMini-yhsc.pdf was not being performed.
> This meant that the display controller was not coming up.

I don't know where you got the idea that the current implementation
doesn't work. Numerous people are using this to get the i.MX8MM display
light up. All you need to do is add the various display pipeline
peripherals into the virtual power-domains provided by the blk-ctrl
driver. The only thing that prevents upstream from having a working
display pipeline is the conversion of the exynos-dsi into a proper
bridge driver, which has just landed upstream and the addition of a few
DT nodes, now that the drivers are getting ready.

Regards,
Lucas

> 
> Viraj Shah (4):
>   soc: imx: gpcv2: Power sequence for DISP
>   soc: imx: imx8m-blk-ctrl: Display Power ON sequence
>   soc: imx: imx8m-blk-ctrl: Add reset bits for mipi dsi phy
>   arm64: dts: imx8mm.dtsi: Add resets for dispmix power domain.
> 
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi |  1 +
>  drivers/soc/imx/gpcv2.c                   | 36 +++++++++++++++++++----
>  drivers/soc/imx/imx8m-blk-ctrl.c          |  9 ++++--
>  3 files changed, 38 insertions(+), 8 deletions(-)
> 


