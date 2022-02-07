Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4865E4AB4F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbiBGGgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiBGGbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:31:37 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 22:31:35 PST
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DA8C043181;
        Sun,  6 Feb 2022 22:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644215495; x=1675751495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wq/xULOuP/jvk92XmnTa8NRyCBGFLagVj5mIPmhXCgg=;
  b=KcmvVb4bNLLQtmC9DQEwxG3EYkMR5ZUqy1F+h6KHtqlfKng4Jqxoddz3
   xISbzygx0HjRCqC+QRnw3NfS9fxfknMAoHIozm8giM0yE6DomIWlyHlz9
   Dl/6eUXJ0CAJydJEeq1PCRyIQGcSQG9afA7tZI1gz8dx9KKFnF0yI5lt0
   5ndt8clHeVHMygZwsmlD3fDkvf+DEfqabaOoh/FfwetomPia7VyNdY7v6
   lD8xQxzQEjfH6YKydd2gPlWn030o3abTmd5GBT1pic1gncPogMm9ryqBP
   X73t75lwNaSl6mXOV80dpWVdCCMhNHKgdDnUN/tgKpy+cPBt/yqUVrDiW
   g==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21920108"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Feb 2022 07:30:28 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Feb 2022 07:30:28 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Feb 2022 07:30:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644215428; x=1675751428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wq/xULOuP/jvk92XmnTa8NRyCBGFLagVj5mIPmhXCgg=;
  b=BE0+XcqqIwWe058GxcNFZCo42yRP3dWCit9o/vKc3X3X15RT+j+FU+Zr
   8gK0oqDorM5nZjRBv5XA2kF1KL63x5LpgA/o+3ZWDhNtU7KmE8wPWefqw
   AlWejtC8LwB8p1WUriQOIuiWxOdz/kIqFZgwVrIO3O12tu5hG4yLR+Ypy
   k7xlJLG6qqEG2FxGa/4Qbw4eIyYhoPsq1eF8K4deBBnn7QlAnLXXrYdko
   Ve1MfxW2h9gj4oqLCGxSrcIHhdyn+W5rGGF9y22rKtx5JxS2eOBmKKLeo
   c1549qmR9KRNIQSrTDSgGSMPYH70F77GfP1IToZ4njAaic/kfUWPvKBnD
   g==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21920107"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Feb 2022 07:30:28 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 16B47280065;
        Mon,  7 Feb 2022 07:30:28 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     jeanmichel.hautbois@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: (EXT) Re: (EXT) [RFC PATCH v4 03/12] dt-bindings: media: Add bindings for bcm2835-unicam
Date:   Mon, 07 Feb 2022 07:30:25 +0100
Message-ID: <5541132.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Yf3fe2F88SNcl2Jd@pendragon.ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com> <7954256.DvuYhMxLoT@steina-w> <Yf3fe2F88SNcl2Jd@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Am Samstag, 5. Februar 2022, 03:22:51 CET schrieb Laurent Pinchart:
> Hi Alexander,
> 
> On Fri, Feb 04, 2022 at 09:50:06AM +0100, Alexander Stein wrote:
> > Am Donnerstag, 3. Februar 2022, 18:50:00 CET schrieb Jean-Michel Hautbois:
> > > Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unicam
> > > camera interface. Also add a MAINTAINERS entry for it.
> > > 
> > > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > > Signed-off-by: Jean-Michel Hautbois
> > > <jeanmichel.hautbois@ideasonboard.com>
> > > 
> > > ---
> > > v4:
> > > - make MAINTAINERS its own patch
> > > - describe the reg and clocks correctly
> > > - use a vendor entry for the number of data lanes
> > > ---
> > > 
> > >  .../bindings/media/brcm,bcm2835-unicam.yaml   | 110 ++++++++++++++++++
> > >  1 file changed, 110 insertions(+)
> > >  create mode 100644
> > > 
> > > Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> > > b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml new
> > > file
> > > mode 100644
> > > index 000000000000..0725a0267c60
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> > > @@ -0,0 +1,110 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Broadcom BCM283x Camera Interface (Unicam)
> > > +
> > > +maintainers:
> > > +  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> > > +
> > > +description: |-
> > > +  The Unicam block on BCM283x SoCs is the receiver for either
> > > +  CSI-2 or CCP2 data from image sensors or similar devices.
> > > +
> > > +  The main platform using this SoC is the Raspberry Pi family of
> > > boards.
> > > +  On the Pi the VideoCore firmware can also control this hardware
> > > block,
> > > +  and driving it from two different processors will cause issues.
> > > +  To avoid this, the firmware checks the device tree configuration
> > > +  during boot. If it finds device tree nodes starting by csi then
> > > +  it will stop the firmware accessing the block, and it can then
> > > +  safely be used via the device tree binding.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: brcm,bcm2835-unicam
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: Unicam block.
> > > +      - description: Clock Manager Image (CMI) block.
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Clock to drive the LP state machine of Unicam.
> > > +      - description: Clock for the vpu (core clock).
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: lp
> > > +      - const: vpu
> > > +
> > > +  power-domains:
> > > +    items:
> > > +      - description: Unicam power domain
> > > +
> > > +  brcm,num-data-lanes:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [ 2, 4 ]
> > > +    description: Number of data lanes on the csi bus
> > 
> > There is already data-lanes in
> > Documentation/devicetree/bindings/media/video- interfaces.yaml. AFAICS
> > these two are identical. Can't the video-
> > interface.yaml be used for this? I'm no expert TBH.
> 
> This is the number of data lanes that the Unicam instance supports.
> There are two Unicam instances, and they can have 2 or 4 data lanes
> depending on the SoC. The data-lanes endpoint property indicates the
> number of lanes used on a particular board.

Thanks for the explanation. Isn't this something which could be derived from 
the compatible, e.g. having 2 different ones for 2 and 4 lanes respectively?
See [1] for a similar situation in the SPI subsystem.
I don't have a strong opinion, just want to share my feedback.

Regards,
Alexander

[1] https://patchwork.kernel.org/project/spi-devel-general/patch/
20211207104114.2720764-1-alexander.stein@ew.tq-group.com/#24641405


