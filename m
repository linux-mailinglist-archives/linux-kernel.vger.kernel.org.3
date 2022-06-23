Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF503557A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiFWMjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiFWMjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:39:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795BE48E7B;
        Thu, 23 Jun 2022 05:39:12 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D572B66017D2;
        Thu, 23 Jun 2022 13:39:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655987951;
        bh=ZgzmMPSygjLJDHZK16WVrb6boCW48PbwILdNxmzVx4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ls/Kus62omyS2oWsKbe3AP8qdUos5qBFpIZgx0qErociP16Ku3MzkoIYnIVJ2eLPN
         0x0n7H1QGqUwFqN/s42jvnQ4MplaX/JvI+IJ19IMLzOBlhcNAHW64vPV8eMQp5U9dl
         lgW4kvRLQkJcbLhJ5NpdHZ36SJ68uxub5ebRTNt9pKCrA16VpUZausPdbhxapuLxzO
         BYNf/8tp91p+T6iw+Lr40/Gy6+nm9UMNcXxpMxvRbqAmngcmojfXVQx8NXNHIYfDzj
         CJAqocdlH48y/cy1NYn/NigwXknA0dFhKuplEPoQ4pUCaytzxbqzXaTJJ1Hh/EuFgj
         OSGGhE6CGjxGg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8183-kukui: Assign sram supply to mfg_async pd
Date:   Thu, 23 Jun 2022 14:38:50 +0200
Message-Id: <20220623123850.110225-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623123850.110225-1-angelogioacchino.delregno@collabora.com>
References: <20220623123850.110225-1-angelogioacchino.delregno@collabora.com>
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

Add a phandle to the MT8183_POWER_DOMAIN_MFG_ASYNC power domain and
assign the GPU VSRAM supply to this in mt8183-kukui: this allows to
keep the sram powered up while the GPU is used.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi       | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 89e4358f140a..33f3bf277ce9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -821,6 +821,10 @@ cros_ec {
 	};
 };
 
+&mfg_async {
+	domain-supply = <&mt6358_vsram_gpu_reg>;
+};
+
 &mfg {
 	domain-supply = <&mt6358_vgpu_reg>;
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 9485c1efc87c..9d32871973a2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -788,7 +788,7 @@ power-domain@MT8183_POWER_DOMAIN_CONN {
 					#power-domain-cells = <0>;
 				};
 
-				power-domain@MT8183_POWER_DOMAIN_MFG_ASYNC {
+				mfg_async: power-domain@MT8183_POWER_DOMAIN_MFG_ASYNC {
 					reg = <MT8183_POWER_DOMAIN_MFG_ASYNC>;
 					clocks = <&topckgen CLK_TOP_MUX_MFG>;
 					clock-names = "mfg";
-- 
2.35.1

