Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B6B4B2EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353665AbiBKU5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:57:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353485AbiBKU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:50 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67366D57;
        Fri, 11 Feb 2022 12:56:34 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 44E5793;
        Fri, 11 Feb 2022 21:56:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644612992;
        bh=Mbj/JEWHnhuJ4egVN/7JMgXgTiAVpvT6Yrbb2y5h5y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FKhdR2CXuHPyjSKKxXMecloiTMPp9yecKPLJ9U0Ct2G2yW16zr4yRusJCEv3SKAba
         MOZ1u608xioB0ReRpiLgcC3DrILH+EYESIv59Xy2ixgma8zgNmHOvBEn1obcn0hiJy
         tQPjILlJ3SFwbKcsAC8OwZugqaiUeSUHu6MLK3zs=
Date:   Fri, 11 Feb 2022 22:56:28 +0200
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
Message-ID: <YgbNfKiNkPmvaT1k@pendragon.ideasonboard.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-8-paul.kocialkowski@bootlin.com>
 <YgFCuaf007wd8sJy@pendragon.ideasonboard.com>
 <YgaKXvP3rLOLR9VR@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgaKXvP3rLOLR9VR@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 05:10:06PM +0100, Paul Kocialkowski wrote:
> Hi Laurent,
> 
> Thanks for the review!
> 
> On Mon 07 Feb 22, 18:03, Laurent Pinchart wrote:
> > Hi Paul,
> > 
> > Thank you for the patch.
> > 
> > On Sat, Feb 05, 2022 at 07:53:30PM +0100, Paul Kocialkowski wrote:
> > > The A31 CSI controller supports two distinct input interfaces:
> > > parallel and an external MIPI CSI-2 bridge. The parallel interface
> > > is often connected to a set of hardware pins while the MIPI CSI-2
> > > bridge is an internal FIFO-ish link. As a result, these two inputs
> > > are distinguished as two different ports.
> > > 
> > > Note that only one of the two may be present on a controller instance.
> > > For example, the V3s has one controller dedicated to MIPI-CSI2 and one
> > > dedicated to parallel.
> > 
> > Is it that only one of the two is present, or only one of the two is
> > connected ? In the latter case I'd make both ports required, but with
> > only one of them connected.
> 
> There are situations where the actual pins for parallel (port@0) are missing
> and the controller is dedicated to its mipi csi-2 bridge (port@1), cases where
> the two are present and cases where the mipi csi-2 bridge doesn't exist.
> So all in all it's really legit that only one port may be defined.

The port could still exist internally in the IP core though. Of course
that's hard to tell.

> > > Update the binding with an explicit ports node that holds two distinct
> > > port nodes: one for parallel input and one for MIPI CSI-2.
> > > 
> > > This is backward-compatible with the single-port approach that was
> > > previously taken for representing the parallel interface port, which
> > > stays enumerated as fwnode port 0.
> > > 
> > > Note that additional ports may be added in the future, especially to
> > > support feeding the CSI controller's output to the ISP.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Acked-by: Maxime Ripard <mripard@kernel.org>
> > > ---
> > >  .../media/allwinner,sun6i-a31-csi.yaml        | 60 +++++++++++++++----
> > >  1 file changed, 47 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> > > index 8b568072a069..3cc61866ea89 100644
> > > --- a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> > > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> > > @@ -61,6 +61,34 @@ properties:
> > >  
> > >      additionalProperties: false
> > >  
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: "#/properties/port"
> > > +        unevaluatedProperties: false
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        description: MIPI CSI-2 bridge input port
> > > +
> > > +        properties:
> > > +          reg:
> > > +            const: 1
> > > +
> > > +          endpoint:
> > > +            $ref: video-interfaces.yaml#
> > > +            unevaluatedProperties: false
> > > +
> > > +        additionalProperties: false
> > > +
> > > +    anyOf:
> > > +      - required:
> > > +        - port@0
> > > +      - required:
> > > +        - port@1
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > 
> > Shouldn't you specify that either port or ports is required, but not
> > both ? I'd also add a comment in the port node to tell it's deprecated,
> > and that ports should be used instead.
> 
> Yes I agree on both points. I guess that should be a:
> 
> oneOf:
>   - required:
>     - ports
>   - required:
>     - port
> 
> (but feel free to correct me).
> 
> > > @@ -89,19 +117,25 @@ examples:
> > >                        "ram";
> > >          resets = <&ccu RST_BUS_CSI>;
> > >  
> > > -        port {
> > > -            /* Parallel bus endpoint */
> > > -            csi1_ep: endpoint {
> > > -                remote-endpoint = <&adv7611_ep>;
> > > -                bus-width = <16>;
> > > -
> > > -                /*
> > > -                 * If hsync-active/vsync-active are missing,
> > > -                 * embedded BT.656 sync is used.
> > > -                 */
> > > -                 hsync-active = <0>; /* Active low */
> > > -                 vsync-active = <0>; /* Active low */
> > > -                 pclk-sample = <1>;  /* Rising */
> > > +        ports {
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +
> > > +            port@0 {
> > > +                reg = <0>;
> > > +                /* Parallel bus endpoint */
> > > +                csi1_ep: endpoint {
> > > +                    remote-endpoint = <&adv7611_ep>;
> > > +                    bus-width = <16>;
> > > +
> > > +                    /*
> > > +                     * If hsync-active/vsync-active are missing,
> > > +                     * embedded BT.656 sync is used.
> > > +                     */
> > > +                     hsync-active = <0>; /* Active low */
> > > +                     vsync-active = <0>; /* Active low */
> > > +                     pclk-sample = <1>;  /* Rising */
> > 
> > Wrong indentation.
> 
> The double-space before /* Rising */ or something with the heading indent?

The heading has one extra space for all three lines, they should be
aligned to the / of /*, not to the *.

> > > +                };
> > >              };
> > >          };
> > >      };

-- 
Regards,

Laurent Pinchart
