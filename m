Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E474AC52A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385696AbiBGQPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387251AbiBGQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:03:11 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47D9C0401CE;
        Mon,  7 Feb 2022 08:03:08 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DC3CF340;
        Mon,  7 Feb 2022 17:03:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644249787;
        bh=nfHhY7SAAx/jSa8dp1hMDTzjQj/OuY2kGz3jjvPk5xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+CZh0fGXgBerQVwuj4ZfLJQ6bwJ9df1Vzllh4VKcSm+MtCyn0LFsexbZWLsxjcsb
         2skIMGdk4g0rNN5bgOMEeHnJUPIe4cLJ3I4iUbUt3S9fuywk0x7fmElGrEqbiPZV8J
         3HmpuM9QGZsrLtswnZ8AtdRp5YENQqjto4nHkQHs=
Date:   Mon, 7 Feb 2022 18:03:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 07/66] dt-bindings: media: sun6i-a31-csi: Add MIPI
 CSI-2 input port
Message-ID: <YgFCuaf007wd8sJy@pendragon.ideasonboard.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-8-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-8-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch.

On Sat, Feb 05, 2022 at 07:53:30PM +0100, Paul Kocialkowski wrote:
> The A31 CSI controller supports two distinct input interfaces:
> parallel and an external MIPI CSI-2 bridge. The parallel interface
> is often connected to a set of hardware pins while the MIPI CSI-2
> bridge is an internal FIFO-ish link. As a result, these two inputs
> are distinguished as two different ports.
> 
> Note that only one of the two may be present on a controller instance.
> For example, the V3s has one controller dedicated to MIPI-CSI2 and one
> dedicated to parallel.

Is it that only one of the two is present, or only one of the two is
connected ? In the latter case I'd make both ports required, but with
only one of them connected.

> Update the binding with an explicit ports node that holds two distinct
> port nodes: one for parallel input and one for MIPI CSI-2.
> 
> This is backward-compatible with the single-port approach that was
> previously taken for representing the parallel interface port, which
> stays enumerated as fwnode port 0.
> 
> Note that additional ports may be added in the future, especially to
> support feeding the CSI controller's output to the ISP.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> ---
>  .../media/allwinner,sun6i-a31-csi.yaml        | 60 +++++++++++++++----
>  1 file changed, 47 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> index 8b568072a069..3cc61866ea89 100644
> --- a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> @@ -61,6 +61,34 @@ properties:
>  
>      additionalProperties: false
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: "#/properties/port"
> +        unevaluatedProperties: false
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: MIPI CSI-2 bridge input port
> +
> +        properties:
> +          reg:
> +            const: 1
> +
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +        additionalProperties: false
> +
> +    anyOf:
> +      - required:
> +        - port@0
> +      - required:
> +        - port@1
> +
>  required:
>    - compatible
>    - reg

Shouldn't you specify that either port or ports is required, but not
both ? I'd also add a comment in the port node to tell it's deprecated,
and that ports should be used instead.

> @@ -89,19 +117,25 @@ examples:
>                        "ram";
>          resets = <&ccu RST_BUS_CSI>;
>  
> -        port {
> -            /* Parallel bus endpoint */
> -            csi1_ep: endpoint {
> -                remote-endpoint = <&adv7611_ep>;
> -                bus-width = <16>;
> -
> -                /*
> -                 * If hsync-active/vsync-active are missing,
> -                 * embedded BT.656 sync is used.
> -                 */
> -                 hsync-active = <0>; /* Active low */
> -                 vsync-active = <0>; /* Active low */
> -                 pclk-sample = <1>;  /* Rising */
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                /* Parallel bus endpoint */
> +                csi1_ep: endpoint {
> +                    remote-endpoint = <&adv7611_ep>;
> +                    bus-width = <16>;
> +
> +                    /*
> +                     * If hsync-active/vsync-active are missing,
> +                     * embedded BT.656 sync is used.
> +                     */
> +                     hsync-active = <0>; /* Active low */
> +                     vsync-active = <0>; /* Active low */
> +                     pclk-sample = <1>;  /* Rising */

Wrong indentation.

> +                };
>              };
>          };
>      };

-- 
Regards,

Laurent Pinchart
