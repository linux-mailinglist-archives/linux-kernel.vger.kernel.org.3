Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CF75ACF9D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiIEKEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbiIEKEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:04:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278FBA46E;
        Mon,  5 Sep 2022 03:04:31 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF3096601EB2;
        Mon,  5 Sep 2022 11:04:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662372269;
        bh=0o/8cVorzOsad5b/Haf5ctcd6DYaAoupPjEfo3dU2RU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGVQ3Ml3T4lAOa68aT4JDgIxSTwC1eI44hZrH7/OCGO2HSKIX7OELWDA7NH9ftF6i
         GWFr/Cx6ryk1u40MQLuHoayS3N60MUUnXLZOsflnLq1jt5MNjx2YUJD9RAbfEeIMaB
         gJojvM24V98KSbpCqjYtsHWEkf/mdkoirvJZX5SXb9OsheLdZxqSZzpArgyBtZqdM2
         Kzvw+2VnGTCzRHTt1ZHXTSpdFE5jpW38cpR4za3fCvSTyJVcliIwTrHaaMwkqNSGLT
         HcLghPpEVG1xg9WbqKLEgtJEruFi/0StTBo3TBnhWvf9cczzUF73OCTZgFb38JMvMG
         cjWbIGaJyKXXw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 01/10] arm64: dts: mt8183: Fix Mali GPU clock
Date:   Mon,  5 Sep 2022 12:04:07 +0200
Message-Id: <20220905100416.42421-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905100416.42421-1-angelogioacchino.delregno@collabora.com>
References: <20220905100416.42421-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wenst@chromium.org>

The actual clock feeding into the Mali GPU on the MT8183 is from the
clock gate in the MFGCFG block, not CLK_TOP_MFGPLL_CK from the TOPCKGEN
block, which itself is simply a pass-through placeholder for the MFGPLL
in the APMIXEDSYS block.

Fix the hardware description with the correct clock reference.

Fixes: a8168cebf1bc ("arm64: dts: mt8183: Add node for the Mali GPU")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index a70b669c49ba..402136bfd535 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1678,7 +1678,7 @@ gpu: gpu@13040000 {
 				<GIC_SPI 278 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-names = "job", "mmu", "gpu";
 
-			clocks = <&topckgen CLK_TOP_MFGPLL_CK>;
+			clocks = <&mfgcfg CLK_MFG_BG3D>;
 
 			power-domains =
 				<&spm MT8183_POWER_DOMAIN_MFG_CORE0>,
-- 
2.37.2

