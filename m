Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5EF4E8BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbiC1CHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiC1CHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:07:39 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EB71E098;
        Sun, 27 Mar 2022 19:06:00 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 28 Mar 2022 11:06:00 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 1300E2058B50;
        Mon, 28 Mar 2022 11:06:00 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 28 Mar 2022 11:06:00 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A943DB62B7;
        Mon, 28 Mar 2022 11:05:59 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 3/3] dt-bindings: phy: uniphier-ahci: Fix missing reset-names
Date:   Mon, 28 Mar 2022 11:05:52 +0900
Message-Id: <1648433152-23126-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648433152-23126-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1648433152-23126-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing "phy" reset-names to fix the following warning:

  uniphier-pro4-ace.dtb: ahci-phy@10: resets: [[26, 28], [26, 12], [26, 30], [36, 0], [36, 1], [36, 2]] is too long
      From schema: Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
  uniphier-pro4-ace.dtb: ahci-phy@10: reset-names: 'oneOf' conditional failed, one must be fixed:
      ['link', 'gio', 'phy', 'pm', 'tx', 'rx'] is too long
      From schema: Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml

Fixes: 34f92b67621f ("dt-bindings: phy: uniphier-ahci: Add bindings for Pro4 SoC")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
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

