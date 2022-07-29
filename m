Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3302C584E19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiG2Jfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiG2Jfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:35:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888934E616;
        Fri, 29 Jul 2022 02:35:43 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 11ED66601B51;
        Fri, 29 Jul 2022 10:35:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659087341;
        bh=pw9xTOk9v3V4FiTXBQbWTtQRmlJWsKMyW63P0AgFxhQ=;
        h=From:To:Cc:Subject:Date:From;
        b=nbemYziwH4GIkcmLEOGySkCwfgA6Aj8wofc+Ck60at/IegAJmLo9GENhHdrS8zKeP
         g7nphxWWKvgGsmxlpCtUnJWB6aWxJqniSZxfXz7S8PQURWzxatJhvQQPhVDC2a021j
         Upn3K+9ba94hfaVeCAOiqnX4ERtlixi6JwRWgZ0VY1+9mr2hLay6PgLR+FBvk/VY05
         UMfiNh/SA7ooATHeF21D3U7oNem08JkFhHX/jHHYy/zXuiG06TZsGdG9qrFYDNEavw
         wbHb3+GXAC9u/Bg84dbgtytq8Ooq1AyTGbGGX0maXwtagNcNCCRDHOEOLzI0WvOXqh
         zdafetwG6BzAA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] arm64: dts: mediatek: mt6795: Add CPUX system timer node
Date:   Fri, 29 Jul 2022 11:35:36 +0200
Message-Id: <20220729093536.27623-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for mt6795-systimer: this is necessary to start the
System Timer(s) for all cores, finally making CNTVCT_EL0 usable.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index d4842b4a4eb7..46f0e54be766 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -230,6 +230,14 @@ sysirq: intpol-controller@10200620 {
 			reg = <0 0x10200620 0 0x20>;
 		};
 
+		systimer: timer@10200670 {
+			compatible = "mediatek,mt6795-systimer";
+			reg = <0 0x10200670 0 0x10>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&system_clk>;
+			clock-names = "clk13m";
+		};
+
 		gic: interrupt-controller@10221000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.35.1

