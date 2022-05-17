Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE99E52A333
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347621AbiEQNVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347662AbiEQNVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:21:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F5D41320;
        Tue, 17 May 2022 06:21:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 826481F43400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652793675;
        bh=4okfIjIm+hnY/zUZA5OTvdiC6J+Y0f3qgmZrTuLC8jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDFVs0hPgbko7BwC7qA+BryOxNJ0dC6XXfmGM/pL3VlOhXUD09UOGsL6T1IT+ilxy
         mJ+QvxRTpivjB4gGUX/NF3Ko5RFm3NIeg8ZlW3es8DcLbcTZywdHk2/8D8ioAanG1X
         lh6IqWT+v8oNE+QJEOnJgAQ0MDfouEFehge+mwrrxaFJaFWUCrduWiizjR5YOBwy/x
         SdKEKe7m5jdz7e6JKnEy+BRMiI/P0xO4iulYZCOD8pUNwU3uNdhVqCdiLGY0usH0Gp
         qPQlLCZEp0nAEbA89nZyk6em/SbdaO2vmJXi/prvdtBociicl2ceoToEnK+XzTjA4g
         LGyxAXDr1t8SA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/8] dt-bindings: iommu: mediatek: Add mediatek,pericfg phandle
Date:   Tue, 17 May 2022 15:21:02 +0200
Message-Id: <20220517132107.195932-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
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

Add property "mediatek,pericfg" to let the mtk_iommu driver retrieve
a phandle to the pericfg syscon instead of performing a per-soc
compatible lookup, as it was also done with infracfg.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 78c72c22740b..a6cf9678271f 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -116,6 +116,10 @@ properties:
       Refer to bindings/memory-controllers/mediatek,smi-larb.yaml. It must sort
       according to the local arbiter index, like larb0, larb1, larb2...
 
+  mediatek,pericfg:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle to the mediatek pericfg syscon
+
   '#iommu-cells':
     const: 1
     description: |
-- 
2.35.1

