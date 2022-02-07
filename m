Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9425B4AC532
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381725AbiBGQOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442655AbiBGQE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:04:56 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C811C0401CC;
        Mon,  7 Feb 2022 08:04:55 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3E872340;
        Mon,  7 Feb 2022 17:04:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644249893;
        bh=EBS3kkJ8BCBs5yuj170BnDdZuFVfeUksdyi/hOkIA0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvyY9OKI0dHBs/LuDngKy5LRwVmt4U8MI1JrSmzwEUbroZ1j66FdAKeufPHPc7msD
         NxjUI4SKDw4w34fThGl88PBkP2eV0Y/iGXexOPDFBST9fnesGw30bWNPIqTqgpShzO
         4YXjESc+sTvUEu1GGJ+aQxB0h7K4mhQSax2L7XJE=
Date:   Mon, 7 Feb 2022 18:04:51 +0200
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 62/66] dt-bindings: media: sun6i-a31-csi: Add ISP
 output port
Message-ID: <YgFDI17Q3AlZxaOi@pendragon.ideasonboard.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-63-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-63-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 07:54:25PM +0100, Paul Kocialkowski wrote:
> Some Allwinner devices come with an Image Signal Processor (ISP) that
> allows processing camera data to produce good-looking images,
> especially from raw bayer representations.
> 
> The ISP does not have a dedicated capture path: it is fed directly by
> one of the CSI controllers, which can be selected at run-time.
> 
> Represent this possibility as a graph connection between the CSI
> controller and the ISP in the device-tree bindings.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../bindings/media/allwinner,sun6i-a31-csi.yaml    | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> index 3cc61866ea89..7952413f98d8 100644
> --- a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> @@ -83,6 +83,20 @@ properties:
>  
>          additionalProperties: false
>  
> +      port@2:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: ISP output port
> +
> +        properties:
> +          reg:
> +            const: 2
> +
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false

This could be

            $ref: video-interfaces.yaml#
            remote-endpoint: true
            additionalProperties: false

to reject other properties.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
> +        additionalProperties: false
> +
>      anyOf:
>        - required:
>          - port@0

-- 
Regards,

Laurent Pinchart
