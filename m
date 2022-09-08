Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD255B2052
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiIHOPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIHOPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:15:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFBCA00CE;
        Thu,  8 Sep 2022 07:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7930861D1D;
        Thu,  8 Sep 2022 14:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28410C433C1;
        Thu,  8 Sep 2022 14:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662646538;
        bh=PD99PoYY/6qzvj7XP3fGAjLRFdQyyNhFVurMX4/wCMk=;
        h=From:To:Cc:Subject:Date:From;
        b=VnOJKY2BhVpISb9cCg4aQ8onLjhyI4chS0OqnTblN6TuwgoftGwhR8KICP76goz7Y
         t5wEZAc7uT7TeUGUV1C4vPFWBvlpp89l90wPtVdTtFKqSWM5nvhqP+M5QJM/261beQ
         /TsD2NMAtbi6du/vObDXSlmWmgNHl63Hf7PzlZX2CZwWpnFOTixOVExRzUu7rdJfff
         S9G+fjAap8domifhRYrHTWG4pgpjrTofrnMqzR0d3D+MJcKT3YPXGDz94wevMTCV/j
         rMcxKO0f/Y+TbBuw48Ul1I2fXCaydhfKg1E1GoKD2mwFoLdud0/8z72skRLlVYA7w5
         4b11qs0RvpSew==
From:   matthias.bgg@kernel.org
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v2] dt-bindings: iommu: mediatek: mt8195: Fix max interrupts
Date:   Thu,  8 Sep 2022 16:15:29 +0200
Message-Id: <20220908141529.1478-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The mt8195-iommu-infra has five banks and one interrupt for each.
Reflect that in the binding.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

Changes in v2:
- keep wide constrains for minItems and maxItems
- delete unrealted required: - interrupts
- use minItems for mediatek,mt8195-iommu-infra case

 .../bindings/iommu/mediatek,iommu.yaml         | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index fee0241b50988..4461dc027d1c4 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -91,7 +91,9 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 5
+    description: each bank has one dedicated interrupt
 
   clocks:
     items:
@@ -183,6 +185,17 @@ allOf:
       required:
         - mediatek,infracfg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8195-iommu-infra
+
+    then:
+      properties:
+        interrupts:
+          minItems: 5
+
   - if: # The IOMMUs don't have larbs.
       not:
         properties:
@@ -191,6 +204,9 @@ allOf:
               const: mediatek,mt8195-iommu-infra
 
     then:
+      properties:
+        interrupts:
+          maxItems: 1
       required:
         - mediatek,larbs
 
-- 
2.37.3

