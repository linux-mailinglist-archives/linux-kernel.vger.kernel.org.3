Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8314B2EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353381AbiBKUsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:48:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353360AbiBKUsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:48:00 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2B1CEC;
        Fri, 11 Feb 2022 12:47:59 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 752CC93;
        Fri, 11 Feb 2022 21:47:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644612477;
        bh=ehf6vTlCeB9+XYe9AmuIirbghRbW0KEWGRwclDo3v5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMLv4XNB8rkEmEcFHY5ynpBplZLVhBle485lTzKMlvpAAGn8QYGGIggZx6kaNBarf
         +6zUn47Uo7bvLS58Y0bNE5kfUt9FKGWXHaOW258MJlIJyhoN7xVL+B77t/BA/yUAfD
         HSd3OL2ofQH601HhtMr2CDJwBnFFHjt1kybXQLVM=
Date:   Fri, 11 Feb 2022 22:47:53 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-staging@lists.linux.dev, Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 05/66] dt-bindings: sun6i-a31-mipi-dphy: Add optional
 direction property
Message-ID: <YgbLeVchq5IkfnFv@pendragon.ideasonboard.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-6-paul.kocialkowski@bootlin.com>
 <YgZ6qsdO+SfTemPZ@robh.at.kernel.org>
 <YgZ83To26Dgy+JD4@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgZ83To26Dgy+JD4@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 04:12:29PM +0100, Paul Kocialkowski wrote:
> Hi Rob,
> 
> On Fri 11 Feb 22, 09:03, Rob Herring wrote:
> > On Sat, Feb 05, 2022 at 07:53:28PM +0100, Paul Kocialkowski wrote:
> > > The Allwinner A31 MIPI D-PHY block supports both tx and rx directions,
> > > although each instance of the block is meant to be used in one
> > > direction only. There will typically be one instance for MIPI DSI and
> > > one for MIPI CSI-2 (it seems unlikely to ever see a shared instance).
> > > 
> > > Describe the direction with a new allwinner,direction property.
> > > For backwards compatibility, the property is optional and tx mode
> > > should be assumed by default.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml  | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
> > > index d0b541a461f3..22636c9fdab8 100644
> > > --- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
> > > @@ -37,6 +37,18 @@ properties:
> > >    resets:
> > >      maxItems: 1
> > >  
> > > +  allwinner,direction:
> > > +    $ref: '/schemas/types.yaml#/definitions/string'
> > > +    description: |
> > > +      Direction of the D-PHY:
> > > +      - "rx" for receiving (e.g. when used with MIPI CSI-2);
> > > +      - "tx" for transmitting (e.g. when used with MIPI DSI).
> > > +
> > > +    enum:
> > > +      - tx
> > > +      - rx
> > > +    default: tx
> > 
> > Can you the phy mode to imply the direction?
> 
> So there was a first attempt at this which introduced a PHY submode but
> it was concluded after discussions that the direction is not really a
> mode of operation choice, in the sense that the D-PHY cannot be reconfigured
> to behave in Rx or Tx mode: it is instead statically assigned to one role
> or the other. This is why it feels more appropriate to describe it in the
> device-tree.

Another option could be different compatible strings, as the RX and TX
PHYs actually have very little in common. I don't mind much either way.

> See this thread from the previous iteration:
> https://patchwork.linuxtv.org/project/linux-media/patch/20210115200141.1397785-3-paul.kocialkowski@bootlin.com/#128800

-- 
Regards,

Laurent Pinchart
