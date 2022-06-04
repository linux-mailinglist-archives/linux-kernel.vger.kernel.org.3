Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46EE53D8A4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 23:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbiFDVkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 17:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiFDVkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 17:40:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728EA22292;
        Sat,  4 Jun 2022 14:40:07 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8416F6D4;
        Sat,  4 Jun 2022 23:40:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654378804;
        bh=u2g4RQI6otMc6+/Eb8lBzry0VC0TwPROt30ekEuQdK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4zYNyqFWG8xiseIfzX0ccj7usIKSimNwggl78cF6emCiSFrR8t2I+s37+Rae2ieT
         b3y11nYKrP1N7TRJyjbVXWIzM73nPHQdU8L/EWqsQO+es3ur3ZPnLcZxsgNb7Mg7GP
         gx5SMKxY6VICwQc1FuOQ9+x/+d54gu8L42iyplGw=
Date:   Sun, 5 Jun 2022 00:39:59 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, kernel@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/8] dt-bindings: soc: imx: add interconnect property for
 i.MX8MP media blk ctrl
Message-ID: <YpvRL4d2Sh9hvVMl@pendragon.ideasonboard.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
 <20220601094537.3390127-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601094537.3390127-2-peng.fan@oss.nxp.com>
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

On Wed, Jun 01, 2022 at 05:45:30PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add interconnect property for i.MX8MP mediamix blk ctrl
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml         | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
> index 21d3ee486295..706bef39b87e 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
> @@ -64,6 +64,20 @@ properties:
>        - const: isp
>        - const: phy
>  
> +  interconnects:
> +    maxItems: 8
> +
> +  interconnect-names:
> +    items:
> +      - const: lcdif-rd
> +      - const: lcdif-wr
> +      - const: isi0
> +      - const: isi1
> +      - const: isi2

If I understand correctly, these are for the 1x RD and 2x WR channels of
the ISI. Would it make sense to name thim accordingly, maybe isi-rd,
isi-wr0 and isi-wr1 ? I'm not sure about the order though.

> +      - const: isp0
> +      - const: isp1
> +      - const: dwe
> +
>  required:
>    - compatible
>    - reg

-- 
Regards,

Laurent Pinchart
