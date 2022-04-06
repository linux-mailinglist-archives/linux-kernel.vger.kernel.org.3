Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F704F5E93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiDFMzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiDFMze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:55:34 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC4B183B2;
        Wed,  6 Apr 2022 01:57:32 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 32FAB482;
        Wed,  6 Apr 2022 10:57:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1649235450;
        bh=v5nTKQqUqKr5/cx0X/3Bedy0Wjdy1thvy6+ObtvhlJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vo5nF1u0KxQrvXumWtqaqPudJetgRSMuJAIT8CUyJa3ahEB8hTYI6jSgc8g99f2P0
         pqO2fVJWhj78sU/mskdcU1Rf9cQJEuADsC8P8xxL4N+f018kJgIc+orzfxYI7DIBo2
         Pb66JyE2YSPsxlgNlwb674RrknZ3T7aw8uYfuDSE=
Date:   Wed, 6 Apr 2022 11:57:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/5] arm64: dts: imx8mp: add noc node
Message-ID: <Yk1V9vyyilj9lRY8@pendragon.ideasonboard.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
 <20220406082330.2681591-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406082330.2681591-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

Thank you for the patch.

On Wed, Apr 06, 2022 at 04:23:27PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8MP main noc node
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index e9e55fdd7652..be902f8155e8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1015,6 +1015,13 @@ gpu2d: gpu@38008000 {
>  			power-domains = <&pgc_gpu2d>;
>  		};
>  
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mp-noc", "fsl,imx8m-noc", "syscon";
> +			reg = <0x32700000 0x100000>;

I can't comment on this, as the memory is documented as reserved in the
reference manual, but I have no reason not to trust you :-)

> +			clocks = <&clk IMX8MP_CLK_NOC>;

There's also a NOC_WRAPPER clock documented in the reference manual, and
also a NOC_IO clock. Are those related, do we need to care about them ?

> +			#interconnect-cells = <1>;
> +		};
> +
>  		aips4 {
>  			compatible = "fsl,aips-bus", "simple-bus";
>  			reg = <0x32c00000 0x400000>;

-- 
Regards,

Laurent Pinchart
