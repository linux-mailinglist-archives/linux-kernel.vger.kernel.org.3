Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9C14AAB3A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358317AbiBESzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:55:05 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:49837 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381062AbiBESyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:54:53 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9ADEC240009;
        Sat,  5 Feb 2022 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYHTZKqj0x0O/vJOFCxW3AwpA9ajkrs61CKkByxlSfY=;
        b=dR6U3nGVfoZM8vXisu6jKz0ldY5QaRrqMCaS7JtFLZ7PgD8shwIZwbkZJUymE4AVLIQic9
        uIX2rWIuED2LDgUzMGMnk1PzWXprX0XKs1QnWmhEpTlmdYHVRrDUKaXmT5D674/R6Q+SP2
        HI5Bpgz94SgVIS3n5Gz8t0i5tj/1m09H+SeFOuEDf1qPSwBhRMWlHj1jMcaan8N3z1lp3c
        QbBxfgoi3cVsZXB0ZqpH1yQknf5rrCkfSi9ylhXCm9uf2Px9seeMt84fNpVgpseqengYaZ
        FhbInBNu3n1NQfbGNQlIXLCWlC4R4XRtZlJJkkf5PtEigaZeySzun5HHJa/Ovg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 07/66] dt-bindings: media: sun6i-a31-csi: Add MIPI CSI-2 input port
Date:   Sat,  5 Feb 2022 19:53:30 +0100
Message-Id: <20220205185429.2278860-8-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A31 CSI controller supports two distinct input interfaces:
parallel and an external MIPI CSI-2 bridge. The parallel interface
is often connected to a set of hardware pins while the MIPI CSI-2
bridge is an internal FIFO-ish link. As a result, these two inputs
are distinguished as two different ports.

Note that only one of the two may be present on a controller instance.
For example, the V3s has one controller dedicated to MIPI-CSI2 and one
dedicated to parallel.

Update the binding with an explicit ports node that holds two distinct
port nodes: one for parallel input and one for MIPI CSI-2.

This is backward-compatible with the single-port approach that was
previously taken for representing the parallel interface port, which
stays enumerated as fwnode port 0.

Note that additional ports may be added in the future, especially to
support feeding the CSI controller's output to the ISP.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 .../media/allwinner,sun6i-a31-csi.yaml        | 60 +++++++++++++++----
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
index 8b568072a069..3cc61866ea89 100644
--- a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
+++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
@@ -61,6 +61,34 @@ properties:
 
     additionalProperties: false
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: "#/properties/port"
+        unevaluatedProperties: false
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: MIPI CSI-2 bridge input port
+
+        properties:
+          reg:
+            const: 1
+
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+        additionalProperties: false
+
+    anyOf:
+      - required:
+        - port@0
+      - required:
+        - port@1
+
 required:
   - compatible
   - reg
@@ -89,19 +117,25 @@ examples:
                       "ram";
         resets = <&ccu RST_BUS_CSI>;
 
-        port {
-            /* Parallel bus endpoint */
-            csi1_ep: endpoint {
-                remote-endpoint = <&adv7611_ep>;
-                bus-width = <16>;
-
-                /*
-                 * If hsync-active/vsync-active are missing,
-                 * embedded BT.656 sync is used.
-                 */
-                 hsync-active = <0>; /* Active low */
-                 vsync-active = <0>; /* Active low */
-                 pclk-sample = <1>;  /* Rising */
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                /* Parallel bus endpoint */
+                csi1_ep: endpoint {
+                    remote-endpoint = <&adv7611_ep>;
+                    bus-width = <16>;
+
+                    /*
+                     * If hsync-active/vsync-active are missing,
+                     * embedded BT.656 sync is used.
+                     */
+                     hsync-active = <0>; /* Active low */
+                     vsync-active = <0>; /* Active low */
+                     pclk-sample = <1>;  /* Rising */
+                };
             };
         };
     };
-- 
2.34.1

