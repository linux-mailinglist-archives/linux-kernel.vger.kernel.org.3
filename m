Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226BF5449F2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbiFILXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiFILXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:23:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF8FF0708;
        Thu,  9 Jun 2022 04:23:13 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 745DD66017D4;
        Thu,  9 Jun 2022 12:23:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654773792;
        bh=a4rg/JyrfKEPVSNVifJkG8mIf7X7Pe0ajY4dp1vpzts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjUzNuyMK/20GfbAc/y72h7+fAwkNXNVsq/OGwPUZo/9PWwiDnKghTypqicng8F9V
         zOJtHMkFUOUIOmJFMR8t/XDtAE5XJzpmpcvUWd5mskK5v1eDN3rTflqXt5DH7Uo8WE
         S5t9wMVNuZq8cpsQKF74uGhb8LALAjnJNMtBTjpWAUWhF0hMqdBddyVK9hpk4L+lYZ
         vg9TsWac7trd+76Ti0b/cae83y/nvR9OOX4G9pi2l9SBw1ICfLxb2aVo7U/y1xCY3e
         SpiCjCrQ3/i7sLiNx9OIEJV3y3nxlvN99lYyiQFLveZ4ba9Pm5kqFskiemmPB7/3RL
         psXJSX4t1NqHw==
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
Subject: [PATCH v2 04/10] arm64: dts: mediatek: mt6795: Add watchdog node to avoid timeouts
Date:   Thu,  9 Jun 2022 13:22:57 +0200
Message-Id: <20220609112303.117928-5-angelogioacchino.delregno@collabora.com>
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

At least on commercial devices like some smartphones, the bootloader
will initialize the SoC watchdog and set it to reboot the board when
it times out. The last pet that this watchdog is getting is right
before booting the kernel and left it enabled as a protection against
boot failure: this means that Linux is expected to initialize this
device and pet as soon as possible, or it will bark and reset the AP.

In order to prevent that, add the required watchdog node as default
enabled: this will have no side effects on boards that are not
performing the aforementioned watchdog setup before booting Linux.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index 639104b3f693..363fa25b4edc 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -188,6 +188,14 @@ soc {
 		compatible = "simple-bus";
 		ranges;
 
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt6795-wdt";
+			reg = <0 0x10007000 0 0x100>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_LOW>;
+			#reset-cells = <1>;
+			timeout-sec = <20>;
+		};
+
 		sysirq: intpol-controller@10200620 {
 			compatible = "mediatek,mt6795-sysirq",
 				     "mediatek,mt6577-sysirq";
-- 
2.35.1

