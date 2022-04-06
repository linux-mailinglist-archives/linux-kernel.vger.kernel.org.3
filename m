Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E802E4F5C9C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiDFLtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiDFLsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:48:38 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A945A1C9E;
        Wed,  6 Apr 2022 01:40:37 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 12D00482;
        Wed,  6 Apr 2022 10:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1649234436;
        bh=81bA4B1fv1s0Zy6Ey/vfR4zUq7LStfbbNy+qsp4lTpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xo3xLn4K56FonZN30OlKTFutA2r3s4YXNx1z0yyIV/1CMncfjjO+DjvZg9Z2+57b6
         bhAyj1irTo1TgzWXWrC47x/JvNGbbqP7ktaMlnw84/J88N4MAI5pprKagEAzHPUxR6
         i/LBzjZy6WBegyKt12lzSTisO2hCU4GSNfN1xF3w=
Date:   Wed, 6 Apr 2022 11:40:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/5] dt-bindings: interconnect: imx8m: Add bindings for
 imx8mp noc
Message-ID: <Yk1SALC2+5va4oZP@pendragon.ideasonboard.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
 <20220406082330.2681591-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406082330.2681591-2-peng.fan@oss.nxp.com>
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

On Wed, Apr 06, 2022 at 04:23:26PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP features same NoC/NIC as i.MX8MM/N/Q, and use two compatible
> strings.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> index b8204ed22dd5..0923cd28d6c6 100644
> --- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> @@ -26,16 +26,22 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - fsl,imx8mp-nic
>                - fsl,imx8mn-nic
>                - fsl,imx8mm-nic
>                - fsl,imx8mq-nic

Alphabetical order would be nice here, maybe you could sort those
entries while at it ?

>            - const: fsl,imx8m-nic

Why do we need both -nic and -noc versions of the compatible string btw
? The imx-bus driver matches on

	{ .compatible = "fsl,imx8mq-noc", .data = "imx8mq-interconnect", },
	{ .compatible = "fsl,imx8mm-noc", .data = "imx8mm-interconnect", },
	{ .compatible = "fsl,imx8mn-noc", .data = "imx8mn-interconnect", },
	{ .compatible = "fsl,imx8m-noc", },
	{ .compatible = "fsl,imx8m-nic", },

>        - items:
>            - enum:
> +              - fsl,imx8mp-noc
>                - fsl,imx8mn-noc
>                - fsl,imx8mm-noc
>                - fsl,imx8mq-noc

Same here.

>            - const: fsl,imx8m-noc
> +      - items:
> +          - const: fsl,imx8mp-noc
> +          - const: fsl,imx8m-noc
> +          - const: syscon

Do we want to support both

	compatible = "fsl,imx8mp-noc", "fsl,imx8m-noc";

and

	compatible = "fsl,imx8mp-noc", "fsl,imx8m-noc", "syscon";

or we can pick one of the two (the latter one in that case I suppose) ?

>        - const: fsl,imx8m-nic
>  
>    reg:

-- 
Regards,

Laurent Pinchart
