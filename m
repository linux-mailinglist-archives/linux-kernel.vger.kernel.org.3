Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BEF4AA5B2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 03:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378976AbiBECXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 21:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbiBECXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:23:19 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33D8C061347;
        Fri,  4 Feb 2022 18:23:18 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A876E472;
        Sat,  5 Feb 2022 03:23:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644027795;
        bh=8Gxgs/LVp8UXOT1xU7N2J6LDQ9LAZmNhrPd3LDIdlMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NCNAtwUHtLHwGFxaEF2imjparL0hfE4rzgnfLYW6qlioSE7/xW5JH9C1IJPEBx2ru
         4DT6SluBZkEN+jVpXsMh3VN9pXV0FcCvKOXCs/jOvYZaKXArGVhsjCUQym1zsKPI2B
         TefR05bvw6QBik7WRO50TPU5MSRMbP+xQBioJDj0=
Date:   Sat, 5 Feb 2022 04:22:51 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     jeanmichel.hautbois@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: (EXT) [RFC PATCH v4 03/12] dt-bindings: media: Add bindings for
 bcm2835-unicam
Message-ID: <Yf3fe2F88SNcl2Jd@pendragon.ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
 <20220203175009.558868-4-jeanmichel.hautbois@ideasonboard.com>
 <7954256.DvuYhMxLoT@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7954256.DvuYhMxLoT@steina-w>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Fri, Feb 04, 2022 at 09:50:06AM +0100, Alexander Stein wrote:
> Am Donnerstag, 3. Februar 2022, 18:50:00 CET schrieb Jean-Michel Hautbois:
> > Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unicam
> > camera interface. Also add a MAINTAINERS entry for it.
> > 
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> > 
> > ---
> > v4:
> > - make MAINTAINERS its own patch
> > - describe the reg and clocks correctly
> > - use a vendor entry for the number of data lanes
> > ---
> >  .../bindings/media/brcm,bcm2835-unicam.yaml   | 110 ++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> > b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml new file
> > mode 100644
> > index 000000000000..0725a0267c60
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> > @@ -0,0 +1,110 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom BCM283x Camera Interface (Unicam)
> > +
> > +maintainers:
> > +  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> > +
> > +description: |-
> > +  The Unicam block on BCM283x SoCs is the receiver for either
> > +  CSI-2 or CCP2 data from image sensors or similar devices.
> > +
> > +  The main platform using this SoC is the Raspberry Pi family of boards.
> > +  On the Pi the VideoCore firmware can also control this hardware block,
> > +  and driving it from two different processors will cause issues.
> > +  To avoid this, the firmware checks the device tree configuration
> > +  during boot. If it finds device tree nodes starting by csi then
> > +  it will stop the firmware accessing the block, and it can then
> > +  safely be used via the device tree binding.
> > +
> > +properties:
> > +  compatible:
> > +    const: brcm,bcm2835-unicam
> > +
> > +  reg:
> > +    items:
> > +      - description: Unicam block.
> > +      - description: Clock Manager Image (CMI) block.
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Clock to drive the LP state machine of Unicam.
> > +      - description: Clock for the vpu (core clock).
> > +
> > +  clock-names:
> > +    items:
> > +      - const: lp
> > +      - const: vpu
> > +
> > +  power-domains:
> > +    items:
> > +      - description: Unicam power domain
> > +
> > +  brcm,num-data-lanes:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 2, 4 ]
> > +    description: Number of data lanes on the csi bus
> 
> There is already data-lanes in Documentation/devicetree/bindings/media/video-
> interfaces.yaml. AFAICS these two are identical. Can't the video-
> interface.yaml be used for this? I'm no expert TBH.

This is the number of data lanes that the Unicam instance supports.
There are two Unicam instances, and they can have 2 or 4 data lanes
depending on the SoC. The data-lanes endpoint property indicates the
number of lanes used on a particular board.

-- 
Regards,

Laurent Pinchart
