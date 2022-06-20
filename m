Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE4551398
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbiFTJBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbiFTJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:01:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8682E12D1F;
        Mon, 20 Jun 2022 02:01:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AF8CC883;
        Mon, 20 Jun 2022 11:01:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655715681;
        bh=KcPiSA4mOJI0Q7DYqgykvdJaq4trgNKPzkJE9THtiKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjDoEtQ+kewvnqkyrxVBkvGIEVhmpCBk+DqAfSx9WMgDA4l1UmRAII/nvh8HK4dh1
         N/ZFDbuGxXbc15n4wO1jfdWlhje0cyeBFwhasCXbapWUCe48LFyXyZ5E6oL6qlO1PJ
         k4lNgzzX3HwmKoqs72nvjIr+sZLuurjOC8trFXVU=
Date:   Mon, 20 Jun 2022 12:01:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, paul.elder@ideasonboard.com, marex@denx.de,
        aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: correct clock of pgc_ispdwp
Message-ID: <YrA3Uxtmfce2jQBs@pendragon.ideasonboard.com>
References: <20220620032044.4093226-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220620032044.4093226-1-peng.fan@oss.nxp.com>
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

On Mon, Jun 20, 2022 at 11:20:44AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The deprecated DIV clk is previously part of the ISP composite clk, but
> there is still one child clk(IMX8MP_CLK_MEDIA_ISP_ROOT) sourcing from
> IMX8MP_CLK_MEDIA_ISP( previously IMX8MP_CLK_MEDIA_ISP_DIV)
> 
> So IMX8MP_CLK_MEDIA_ISP_ROOT should be used, not IMX8MP_CLK_MEDIA_ISP_DIV.
> 
> Fixes: 9d89189d5227 ("arm64: dts: imx8mp: Add MEDIAMIX power domains")

Oops, my bad.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index b2f4a5f1f73c..2f970d458f80 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -595,7 +595,7 @@ pgc_hsiomix: power-domains@17 {
>  					pgc_ispdwp: power-domain@18 {
>  						#power-domain-cells = <0>;
>  						reg = <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
> -						clocks = <&clk IMX8MP_CLK_MEDIA_ISP_DIV>;
> +						clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>;
>  					};
>  				};
>  			};

-- 
Regards,

Laurent Pinchart
