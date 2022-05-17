Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F50352A338
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347637AbiEQNWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347688AbiEQNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:21:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B540E77;
        Tue, 17 May 2022 06:21:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 372221F43480
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652793676;
        bh=+xTyEZ131wWMOMNxSY33aVPVZoxl3tqtIBcQv4cQtYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivvqqQoWxqCjtPUoCI7WL5esx9B7MME2HblM++OVJNfKsRzccvcZ0hSaWYJ5yC956
         xrdSFHMYnWXDaeSFFhNnm2u76jaOBUJ5jk4DQezlFx/CoVWkBf6K6OLJP6fDRfVTlX
         QffCU1SX7abxmkLY72Mp3ubk3yMuLJWW6RmX8ZK77fHJ2L3n2KS/mV5TGkdlZfUoj4
         nPNgHvl/Y0gnZylhIXVzswGz4ZineG5/Aw+wah/9TVE27wx0qIVVCDUnsRUAq4Fs6+
         1CwW7T/Bg9r0+7X5xqIJRVKM6ABXu2qg3IyAFbgLVPWoEFLg0zpPv21+IdcTdq5ngf
         fA+ycuXOa91LQ==
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
Subject: [PATCH 5/8] arm64: dts: mediatek: mt8173: Add mediatek,infracfg phandle for IOMMU
Date:   Tue, 17 May 2022 15:21:04 +0200
Message-Id: <20220517132107.195932-6-angelogioacchino.delregno@collabora.com>
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

The IOMMU driver now looks for the "mediatek,infracfg" phandle as a
new way to retrieve a syscon to that:
even though the old way is retained, it has been deprecated and the
driver will write a message in kmsg advertising to use the phandle
way instead.

For this reason, assign the right phandle to mediatek,infracfg in
the iommu node.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 40d7b47fc52e..825a3c670373 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -588,6 +588,7 @@ iommu: iommu@10205000 {
 			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&infracfg CLK_INFRA_M4U>;
 			clock-names = "bclk";
+			mediatek,infracfg = <&infracfg>;
 			mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
 					 <&larb3>, <&larb4>, <&larb5>;
 			#iommu-cells = <1>;
-- 
2.35.1

