Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B97551B154
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378887AbiEDVtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378909AbiEDVtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:49:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277D52DEC;
        Wed,  4 May 2022 14:45:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id B99F11F41850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651700722;
        bh=Z7NLVHuEUzvqWLpcaKnXuMWP4ACDh+2QKtdBRgPicLc=;
        h=From:To:Cc:Subject:Date:From;
        b=L491H02D+stl9mpJt8KqtKfQIdnAWesP8IEqv2bdhouKHphRLWr+qGK9FCWkd+goz
         4Fnk969QWT+ahqTdlJ+k8Kj4ZYns29cFez5hXpYJOyJQZt7xNuTHsefd+E7YbrSnar
         xqqlLvp9/ZdtCD+0vEwPnOsBpbrSVdmCforbPdCQr+ow272x4C5L1+Q/xCVzUZUbIQ
         V5ArZLlOksM0ycMMm260iwFbizDJTMsIG6Mj1pmg93r8QniLfyBW9uOucJJ0g45NpD
         rjzt4D9UVtEGZl9/RWxjlXaYjQtBv9l4NDbCNXqr4sE0dxFNonEqsnpUeYjWexwPS0
         sZrRiVLaSLgJQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] arm64: dts: mt8192: Follow binding order for SCP registers
Date:   Wed,  4 May 2022 17:45:16 -0400
Message-Id: <20220504214516.2957504-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The dt-binding for SCP documents the reg-names order as sram, cfg,
l1tcm. Update the SCP node on the mt8192 devicetree to follow that
order, which gets rid of a dtbs_check warning. This doesn't change any
behavior since the SCP driver accesses the memory regions through the
names anyway.

Fixes: c63556ec6bfe ("arm64: dts: mt8192: Add SCP node")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Added missing Fixes tag

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 26dbe9ecc528..733aec2e7f77 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -699,9 +699,9 @@ spi7: spi@1101e000 {
 		scp: scp@10500000 {
 			compatible = "mediatek,mt8192-scp";
 			reg = <0 0x10500000 0 0x100000>,
-			      <0 0x10700000 0 0x8000>,
-			      <0 0x10720000 0 0xe0000>;
-			reg-names = "sram", "l1tcm", "cfg";
+			      <0 0x10720000 0 0xe0000>,
+			      <0 0x10700000 0 0x8000>;
+			reg-names = "sram", "cfg", "l1tcm";
 			interrupts = <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&infracfg CLK_INFRA_SCPSYS>;
 			clock-names = "main";
-- 
2.36.0

