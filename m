Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056C94EBA11
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242890AbiC3FW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242893AbiC3FWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:22:42 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 592EF139CEE;
        Tue, 29 Mar 2022 22:20:58 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Mar 2022 14:20:58 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 074A22058443;
        Wed, 30 Mar 2022 14:20:58 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Mar 2022 14:20:58 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5DFB2B62B7;
        Wed, 30 Mar 2022 14:20:57 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 4/5] dt-bindings: phy: uniphier-usb3hs: Fix incorrect clock-names and reset-names
Date:   Wed, 30 Mar 2022 14:20:50 +0900
Message-Id: <1648617651-9004-5-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648617651-9004-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1648617651-9004-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no clock-names and reset-names for Pro5 SoC, that should have two
properties, "gio" and "link" like usb3-ssphy.

And according to the existing PXs2 devicetree, the clock-names for PXs2 SoC
should have "link" and "phy", and minItems of clocks should be 2.

Fixes: 134ab2845acb ("dt-bindings: phy: Convert UniPhier USB3-PHY conroller to json-schema")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../phy/socionext,uniphier-usb3hs-phy.yaml       | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
index 33946efcac5e..1bbd164f2527 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
@@ -31,12 +31,14 @@ properties:
     const: 0
 
   clocks:
-    minItems: 1
+    minItems: 2
     maxItems: 3
 
   clock-names:
     oneOf:
-      - const: link          # for PXs2
+      - items:               # for Pro5
+          - const: gio
+          - const: link
       - items:               # for PXs3 with phy-ext
           - const: link
           - const: phy
@@ -49,9 +51,13 @@ properties:
     maxItems: 2
 
   reset-names:
-    items:
-      - const: link
-      - const: phy
+    oneOf:
+      - items:               # for Pro5
+          - const: gio
+          - const: link
+      - items:               # for others
+          - const: link
+          - const: phy
 
   vbus-supply:
     description: A phandle to the regulator for USB VBUS
-- 
2.25.1

