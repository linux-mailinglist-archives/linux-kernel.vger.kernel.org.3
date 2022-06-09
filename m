Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C754485C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbiFIKIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbiFIKIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:08:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0320963D7;
        Thu,  9 Jun 2022 03:08:12 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E996F66017CB;
        Thu,  9 Jun 2022 11:08:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654769291;
        bh=CgNYAOaieQLCVcum8jYWv0FFa/H0G4zrGj0sGsj1tXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4v9L0EwV6ZsghUeg0tMGf6fhREdFwlSxn5OIdaxyAuxixlQ4vc1mzjV5mAiMi/0S
         Y3WXyYPd5tu9/AhpTbDVMRDqtHIkAD9u8XCJtHJ0M4R5Vx41+7VZI5lkjfagzYkXBf
         FYA8CDWVDbT13PoUBpcVoVXTi+lypmCRFqqQzicyUgtTCOBYsHDd19KU9nWfupPSKp
         NnML1F+R9cf9+URrZzLDaTkg0aUKxsjzbtMz3Dfe2MKnICQY8o+9L/126eozTriZ3a
         5dqcZDmn1GD8GaG/PgCqGYCcEi/AJlcZWRmdRQP4mBPofkwleHAMeQi0NjgSWnBXRl
         W2OGPbpFxLcbQ==
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
Subject: [PATCH v3 4/6] arm64: dts: mediatek: mt2712e: Add mediatek,infracfg phandle for IOMMU
Date:   Thu,  9 Jun 2022 12:08:00 +0200
Message-Id: <20220609100802.54513-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU driver now looks for the "mediatek,infracfg" phandle as a
new way to retrieve a syscon to that:
even though the old way is retained, it has been deprecated and the
driver will write a message in kmsg advertising to use the phandle
way instead.

For this reason, assign the right phandle to mediatek,infracfg in
the iommu node.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 623eb3beabf2..4797537cb368 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -329,6 +329,7 @@ iommu0: iommu@10205000 {
 		interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&infracfg CLK_INFRA_M4U>;
 		clock-names = "bclk";
+		mediatek,infracfg = <&infracfg>;
 		mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
 				 <&larb3>, <&larb6>;
 		#iommu-cells = <1>;
@@ -346,6 +347,7 @@ iommu1: iommu@1020a000 {
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&infracfg CLK_INFRA_M4U>;
 		clock-names = "bclk";
+		mediatek,infracfg = <&infracfg>;
 		mediatek,larbs = <&larb4>, <&larb5>, <&larb7>;
 		#iommu-cells = <1>;
 	};
-- 
2.35.1

