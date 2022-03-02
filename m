Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BFA4CB1C2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244301AbiCBWIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243600AbiCBWIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:08:44 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DB13B00E;
        Wed,  2 Mar 2022 14:07:57 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BB3AEE0005;
        Wed,  2 Mar 2022 22:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646258876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eymG5qtlYkxjiqQgEdxW89q1KILX/L8h+KZV8d8+vVY=;
        b=evJeg/DYJqPbJp6//lkkq0Tz6uchK2o+BcKYPowU5ktya//YVfpO8z2qO/tIRPdxs5IW6Y
        D0b8dbx8mKZbuSKVdHJhfSPsK9e7+7Wfn/V7qzMLd6fS8ECs4RgLrdTJv6qlqzPw5CVUKg
        KbleBJ5iGe9PyZUDsJ31q8blkUYJNpyn+v5v+nFQ1z66FUCPcNDiB1osAl7GrwnDOdZvRK
        uoWWu5KotZA1uc8P1sHWSw0pr9PXurFDQ1oDR65PFBO8kFcY+qNJi20KKW4rJPA09BJz4R
        rx0JhZ//QBcsPvQBGdgtY7kR697cy4I0SUPky5fySCa98il+toIMgC/CboD6uw==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 1/9] dt-bindings: sun6i-a31-mipi-dphy: Add optional direction property
Date:   Wed,  2 Mar 2022 23:07:31 +0100
Message-Id: <20220302220739.144303-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
References: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
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
2.35.1

