Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6848A5449F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbiFILXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243568AbiFILXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:23:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2896714AF57;
        Thu,  9 Jun 2022 04:23:16 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3AD3866017CB;
        Thu,  9 Jun 2022 12:23:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654773795;
        bh=bX8kZUebSBXb8b4ayhewUrKLvLfjaP3abnUzIjQpOJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcf0tVja6OFi/B4kwvc/z00sqwC0BpLerzg+3dFvMs27S6yMh+SJVQJUK3a/aH1hs
         qZvI5DY1DWuotr+5pmiEZpQG/cjFhzJKjkMK+6kp2at0glcndHhHMGpIhnrm89uhDS
         X6FiS4cLVthH5chFmgviVHaGaWwisWwsBxWutPUGX6vOure4V68SR4CuxZ6tGWR1pP
         bylxGfdFy+xG0Ti62ZZiFQMhk7CfbbNqi22iVXm0Mto+6CUoTCWk4+RbqFGWEFrDTH
         0FZ6skMxWC+YkRojHKdXadsKxmLMlfnUw/x6rKzQ1/IoqK3KUPuQ2mGDgL4ROd7nXc
         8aikxxmjTA/xA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 07/10] arm64: dts: mediatek: mt6795: Add general purpose timer node
Date:   Thu,  9 Jun 2022 13:23:00 +0200
Message-Id: <20220609112303.117928-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609112303.117928-1-angelogioacchino.delregno@collabora.com>
References: <20220609112303.117928-1-angelogioacchino.delregno@collabora.com>
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

Add the timer node, enabling two GPTs, of which one will be used as
sched_clock.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index b6f7681cc151..217d99621558 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -198,6 +198,14 @@ watchdog: watchdog@10007000 {
 			timeout-sec = <20>;
 		};
 
+		timer: timer@10008000 {
+			compatible = "mediatek,mt6795-timer",
+				     "mediatek,mt6577-timer";
+			reg = <0 0x10008000 0 0x1000>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&system_clk>, <&clk32k>;
+		};
+
 		sysirq: intpol-controller@10200620 {
 			compatible = "mediatek,mt6795-sysirq",
 				     "mediatek,mt6577-sysirq";
-- 
2.35.1

