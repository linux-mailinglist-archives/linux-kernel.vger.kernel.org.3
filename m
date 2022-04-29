Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A098D515503
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380458AbiD2UBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356279AbiD2UBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:01:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC5BA7766;
        Fri, 29 Apr 2022 12:57:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id C30DE1F4696F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651262272;
        bh=aoTbCcZZ92qztLcOxHun78cIUtr7XMDInx4IzvkcyKk=;
        h=From:To:Cc:Subject:Date:From;
        b=AQbAGPd/98luGnCQpTydxXUBRqg2ogAU9Idgb+W7cXtWtSkMeVLrb2lqcl7pP8oJ2
         B/I6qLiFNyA1UrFCLlEVtv3K+tEC/kdR/BzOyYBdD0TyoUN3/8+/bYvzZeDW1cmbvE
         rmaMtHrrIQlOES6uwiKDIW1SJ8HLqd9TshZAeXpHYzbifrQNC8WOBZEQZ/ynjyUB7I
         /ZyxjqUYTLJzVnR+EW3uL5dxTWXDpgRrdZOZzesFeA+VVc9cilfqfErZjWXELjFLId
         pw/S45N6Vmxo2uYXNCOeLECVLq9Np0FRBsIkKuL77aYOwaQWxDulP26vWVkjonkpLo
         kN4p3BaHSMuqw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mediatek: Add fallback compatible for mt8192's flash
Date:   Fri, 29 Apr 2022 15:57:45 -0400
Message-Id: <20220429195745.2203461-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dt-binding for Mediatek's SPI NOR flash controller expects a mt8173
fallback compatible for mt8192, so add it in mt8192.dtsi.

The driver already sets custom data based on the mt8192 compatible, so
this fallback compatible won't be used and is added purely to suppress
the dt-binding warning.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 26dbe9ecc528..32a836105ea7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -896,7 +896,7 @@ pcie_intc0: interrupt-controller {
 		};
 
 		nor_flash: spi@11234000 {
-			compatible = "mediatek,mt8192-nor";
+			compatible = "mediatek,mt8192-nor", "mediatek,mt8173-nor";
 			reg = <0 0x11234000 0 0xe0>;
 			interrupts = <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&topckgen CLK_TOP_SFLASH_SEL>,
-- 
2.36.0

