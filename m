Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5B52B75C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiERKFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiERKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:05:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B216F4BB;
        Wed, 18 May 2022 03:05:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 73E8D1F44E0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652868316;
        bh=xqId+HG46WeS4vw+PN9qoFt/EVggOMa2jWD4Kmnw1DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CcH2GTIWkCcwoJU3BLHr5f1qUd7wqGQkjJekXU6U9Z4nAbjLOKs/wV5uP2lzrWZ6T
         OR2k6euZ8hcdFlYR59HkJ9iRL8NjE0ED2ht9+ZqSen4bmw0kgmQXIfUa9RFvk+ucxo
         sA2oIVPaJd18oEVgvQrvkLC145fNbL734lDh+MSlb+4R7aiMIoDfz9EZGkoXB0v9Dt
         c0PPEFRq6NcjoTJIRscHV2yuJ7f4uLHw5n6omifVwt2rVo0RpiXsE2FCeO9w8vilJ/
         b4Zt5gX7hJ+qtHOCCQ/irB01cBBt1rIQxfBlEmRqp5pOHoIPMAGtLoe+mKVGlm4nhD
         Y2usH/93JX1Jg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 6/7] dt-bindings: iommu: mediatek: Require mediatek,infracfg for mt2712/8173
Date:   Wed, 18 May 2022 12:05:02 +0200
Message-Id: <20220518100503.37279-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
References: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both MT2712 and MT8173 got a mediatek,infracfg phandle: add that to
the required properties for these SoCs to deprecate the old way of
looking for SoC-specific infracfg compatible in the entire devicetree.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iommu/mediatek,iommu.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index c4af41947593..acc2d7e63a9f 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -175,6 +175,18 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt2712-m4u
+              - mediatek,mt8173-m4u
+
+    then:
+      required:
+        - mediatek,infracfg
+
   - if: # The IOMMUs don't have larbs.
       not:
         properties:
-- 
2.35.1

