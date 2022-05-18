Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4672D52B75B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiERKFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiERKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:05:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665B06FD1E;
        Wed, 18 May 2022 03:05:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A22551F44E0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652868315;
        bh=CgNYAOaieQLCVcum8jYWv0FFa/H0G4zrGj0sGsj1tXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lw4BXx+IXXpqyGnKTcZJ+TzvAy2GKcWKGRMwM8M2YBgjEbsWaAOg4nJ9XTSvoLQFA
         86oNbpCfeOTV63tQBrWVgimKhCAoTxh3KCT0ag+K0S8XrIwTV8gpvp1sFjuHlTdU9J
         LuRN81wM2gzOhkGwOiRMIQip2x3PUN2wQOUldy1dUJEIB7dUCYGGp4nu/T8RU2Xsc+
         2nQSu8PxGF5c1Qw+hQao48aTBDNpH1z/7nh92whr0Y9M6aloXma0tO9zs+B+ZvYtp2
         D0GHZaKblsArfMPWeacJF630dsruE4SOeqTh2DaPklTyQBvcGAK7JDQD806SciPc2+
         0Vto/RgYVJiHg==
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
Subject: [PATCH v2 5/7] arm64: dts: mediatek: mt2712e: Add mediatek,infracfg phandle for IOMMU
Date:   Wed, 18 May 2022 12:05:01 +0200
Message-Id: <20220518100503.37279-6-angelogioacchino.delregno@collabora.com>
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

