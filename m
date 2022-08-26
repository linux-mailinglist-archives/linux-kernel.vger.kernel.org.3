Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0092F5A2F07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344933AbiHZSqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345411AbiHZSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:45:49 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26231E9256;
        Fri, 26 Aug 2022 11:42:15 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 14D824000C;
        Fri, 26 Aug 2022 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661539327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yq9qCs8d0+gMGAhESkCWOrYcrw3Z2Gzpyql4CYmayvQ=;
        b=l4d6ET+LUWrsYQ/0lQVRiAsqJTeS7CD+lOxGZnjtGsOuASsV/AEDlCcjcF7VK8uNc75wPU
        0t59lNErbtwqA16CxiYfo8zmTnWxOTFpjNtMj257ILumRdEoIt2nUHmvkNY2C3FPmDUG85
        7toafyRLIQDEF0fA09JkopRefPv5HCPoauv45uURfgwA/+GHb45UZeiyw4aZxlMwsl9IED
        hqXDqNBqXD6FzOojiqUIPb2DQY1g2HNUa8jioeb6WvdzGEi+mM1+ez1UISogg8iTsry4yC
        po5Bfz272kMKTBrhKRs/2JWjRnFyjOWNHBrBgIxgi/bSSjZ2UdPCmBt+nDQTLQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/6] dt-bindings: media: sun6i-a31-csi: Add ISP output port
Date:   Fri, 26 Aug 2022 20:41:40 +0200
Message-Id: <20220826184144.605605-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826184144.605605-1-paul.kocialkowski@bootlin.com>
References: <20220826184144.605605-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Allwinner devices come with an Image Signal Processor (ISP) that
allows processing camera data to produce good-looking images,
especially from raw bayer representations.

The ISP does not have a dedicated capture path: it is fed directly by
one of the CSI controllers, which can be selected at run-time.

Represent this possibility as a graph connection between the CSI
controller and the ISP in the device-tree bindings.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
index 8551c4a711dc..54eb80e517e3 100644
--- a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
+++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
@@ -73,6 +73,10 @@ properties:
         $ref: /schemas/graph.yaml#/properties/port
         description: MIPI CSI-2 bridge input port
 
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: ISP output port
+
     anyOf:
       - required:
           - port@0
-- 
2.37.1

