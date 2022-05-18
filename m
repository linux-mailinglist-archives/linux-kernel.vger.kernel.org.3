Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B1D52B6A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiERKFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiERKFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:05:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA566F482;
        Wed, 18 May 2022 03:05:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 61ED61F44E08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652868312;
        bh=QldET8Tith6XpQTESLUFmBU4bL4nM1vDAby2xnsh/3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKHk/q8oiV3Jx3vURxCYvrr6N5xQTM4Rz6VneBa345wqTTsd7cyy706N9/c1Ef0LL
         Uo1pcr/J2bfK7IVi5S9JVpE/Nzf6FstsiVPOvRJl4MlMxGL3Ffaak2NLVO+DSIGoEY
         JuzIue3TVMTOZMsjQrkpI9Klyql3w06eO6Iz1ewjzOf5gReh2QeNyB+tIjoZ01uTu+
         RdSzpYgDrgYJ08oMFOboynMNmbYDJas7zfM/stIogyptfG2a+ilzRJAhVi84l5a61K
         Od5YBOeDWxAzgYZvKUQs10U5B9x8RW2k5FderWzNRBuPsanB3Bl88sZmBErSkoRv4z
         TMN2KNghaK3dA==
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
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 1/7] dt-bindings: iommu: mediatek: Add phandles for mediatek infra/pericfg
Date:   Wed, 18 May 2022 12:04:57 +0200
Message-Id: <20220518100503.37279-2-angelogioacchino.delregno@collabora.com>
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

Add properties "mediatek,infracfg" and "mediatek,pericfg" to let the
mtk_iommu driver retrieve phandles to the infracfg and pericfg syscon(s)
instead of performing a per-soc compatible lookup.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/iommu/mediatek,iommu.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 2ae3bbad7f1a..c4af41947593 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -101,6 +101,10 @@ properties:
     items:
       - const: bclk
 
+  mediatek,infracfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle to the mediatek infracfg syscon
+
   mediatek,larbs:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     minItems: 1
@@ -112,6 +116,10 @@ properties:
       Refer to bindings/memory-controllers/mediatek,smi-larb.yaml. It must sort
       according to the local arbiter index, like larb0, larb1, larb2...
 
+  mediatek,pericfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle to the mediatek pericfg syscon
+
   '#iommu-cells':
     const: 1
     description: |
-- 
2.35.1

