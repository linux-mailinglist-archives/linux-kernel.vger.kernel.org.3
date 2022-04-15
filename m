Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14508502C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354999AbiDOPYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbiDOPYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:24:25 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586D05F4E2;
        Fri, 15 Apr 2022 08:21:56 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 07D7A240007;
        Fri, 15 Apr 2022 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650036114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VsUxuduSUSmT5cVDhch3xSuWAwRsl9IrVPZo+IvctwA=;
        b=jeJ9wnGKPLZD9sEkT//XK2wPy5CnxYAhOtEEf/QB1cVtYyhQmB809YT54bF+h77Luy9+0L
        WCySsqrjMw0pzXl2KgwEgb9pVhSPZdn1bnBMjjOMIukqnyeZImUT+eLT0kdj0pUMovvwTX
        JEzvhXGPhgzgx5TqVGHHazRFtEHQNU84xc0BAH8Wnr/SrcdmuthgqNYR60P3hT16U9sVrG
        WGZjBPqsJPRNfjp8ui/BF3k3AVizbfjKG1j1ZBywxDN8ml56eRunvbimffVEBPSnsr6HEp
        8ux5jaxaFIMNTiQVvUV5HthUiibQBkxi21m0BmfDk5D+KnMHc/NmQOxqYnV7Ag==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/8] dt-bindings: sun6i-a31-mipi-dphy: Add optional direction property
Date:   Fri, 15 Apr 2022 17:21:31 +0200
Message-Id: <20220415152138.635525-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415152138.635525-1-paul.kocialkowski@bootlin.com>
References: <20220415152138.635525-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner A31 MIPI D-PHY block supports both tx and rx directions,
although each instance of the block is meant to be used in one
direction only. There will typically be one instance for MIPI DSI and
one for MIPI CSI-2 (it seems unlikely to ever see a shared instance).

Describe the direction with a new allwinner,direction property.
For backwards compatibility, the property is optional and tx mode
should be assumed by default.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
index d0b541a461f3..22636c9fdab8 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
@@ -37,6 +37,18 @@ properties:
   resets:
     maxItems: 1
 
+  allwinner,direction:
+    $ref: '/schemas/types.yaml#/definitions/string'
+    description: |
+      Direction of the D-PHY:
+      - "rx" for receiving (e.g. when used with MIPI CSI-2);
+      - "tx" for transmitting (e.g. when used with MIPI DSI).
+
+    enum:
+      - tx
+      - rx
+    default: tx
+
 required:
   - "#phy-cells"
   - compatible
-- 
2.35.2

