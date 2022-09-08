Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F55E5B1EDB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiIHN0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiIHNZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:25:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDB011C145;
        Thu,  8 Sep 2022 06:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FA97B82075;
        Thu,  8 Sep 2022 13:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10000C43470;
        Thu,  8 Sep 2022 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662643544;
        bh=vKmdZnSEqQsgGYqX0IyUeu5ecemFZS/PREfqX8Z3614=;
        h=From:To:Cc:Subject:Date:From;
        b=QCBpWX3Yd+k88zciOQ5QXOLEW9QXWpWmKrfzwp+BYl1BmLURpPXKrBbUGuxum5r/u
         NmXJ/oBKrOy864Aj0w4szD96VRM82oc6fGsmNeaOL/qY57Rl+zNldk85SvsFKnqxkY
         QSLaBRdaBlfMGPTBJrcMZTGoB9/SBrR1B6a5nKQEx9YZ1zj+nLXxuZRDnGA9hdgh1V
         S5g/fRHMEorYRXxx4Sd5bnxorRW0o7wNDjJ3jfWc+71Z+oWYNZUcuSprSWsd8QeRRR
         D4WLSTXtkVyE52HU8DLgIkylxcX2lplcdWryOJj0tMpY+m3ZguGlnqnCPWojBKNRBe
         zcA5kvua4pqLg==
From:   matthias.bgg@kernel.org
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        iommu@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v1] dt-bindings: iommu: mediatek: mt8195: Fix max interrupts
Date:   Thu,  8 Sep 2022 15:25:35 +0200
Message-Id: <20220908132535.9350-1-matthias.bgg@kernel.org>
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

 .../bindings/iommu/mediatek,iommu.yaml        | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index fee0241b50988..621aca2adfb7f 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -91,7 +91,7 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    description: each bank has one dedicated interrupt
 
   clocks:
     items:
@@ -183,6 +183,19 @@ allOf:
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
+          maxItems: 5
+      required:
+        - interrupts
+
   - if: # The IOMMUs don't have larbs.
       not:
         properties:
@@ -191,8 +204,12 @@ allOf:
               const: mediatek,mt8195-iommu-infra
 
     then:
+      properties:
+        interrupts:
+          maxItems: 1
       required:
         - mediatek,larbs
+        - interrupts
 
 additionalProperties: false
 
-- 
2.37.3

