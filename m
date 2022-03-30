Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EDF4EBF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245630AbiC3K5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245612AbiC3K5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:57:08 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18F2F269A61;
        Wed, 30 Mar 2022 03:55:23 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Mar 2022 19:55:22 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 9A1212058443;
        Wed, 30 Mar 2022 19:55:22 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Mar 2022 19:55:22 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D281FB62B7;
        Wed, 30 Mar 2022 19:55:21 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 3/5] dt-bindings: phy: uniphier-ahci: Fix missing reset-names
Date:   Wed, 30 Mar 2022 19:55:13 +0900
Message-Id: <1648637715-19262-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648637715-19262-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1648637715-19262-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UniPhier AHCI PHY controller needs to specify 6 reset lines, so this adds
missing "phy" to reset-names and increases maxItems of resets.

Fixes: 34f92b67621f ("dt-bindings: phy: uniphier-ahci: Add bindings for Pro4 SoC")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
index 3b400a85b44a..14f7579e7daa 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
@@ -43,13 +43,14 @@ properties:
 
   resets:
     minItems: 2
-    maxItems: 5
+    maxItems: 6
 
   reset-names:
     oneOf:
       - items:          # for Pro4
           - const: link
           - const: gio
+          - const: phy
           - const: pm
           - const: tx
           - const: rx
-- 
2.25.1

