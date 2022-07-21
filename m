Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E884B57C647
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiGUIdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiGUIdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:33:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8225E81;
        Thu, 21 Jul 2022 01:33:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id oy13so1942586ejb.1;
        Thu, 21 Jul 2022 01:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6/ZzFcfNXq3FJXVmp131vQ08suTfBEJgqdvlvCUqagg=;
        b=fUW992UR56l7WdJLfb9SyQEjVC5L/8Eo6Nt2OaDp0tKrGDUSHL81BTaID//izNAGoN
         F/S33qqLYfo8TkE9+9ylLiZPVibzSm3gocSkepuoCW9lCpZ6hl6pJhZ/W37MWNYxM5G5
         ynX7JmuFURmDatrMSq+bmMiYskW7Vag4JS56v2zHeSwCq8z4jzz0wgfDVF5CcWg75BEs
         HakItCvr+Hn3/0Desi71EpvdIrnhZXk98I72hI7CF2iZVyFvgSn7SuvlgV75K7OElvPq
         Zl4XtI+oPoDnocDrzPju6w8dLpG04uEC2RlxdTIXfdYneDmpTfKnJ5gIjHD1B+6c/nEt
         7yfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6/ZzFcfNXq3FJXVmp131vQ08suTfBEJgqdvlvCUqagg=;
        b=m+hDyNHXZfrX7ctH+JxIGaVIlVlvQO4PdJmz0j8stSUTdGSViBA5JBuQm6SK/WLdVs
         UjrcFQa/4XW6oWqQhXEa/RS4Z2I0l9o5DEQfsrYEqstibBOEb2lQ4bafyf8ZN1GQUT6H
         zjqDqznQFZJ09ccBRiLsoQesNcFZPWAN5RueOyxusSHn5KNKEbxLhbvKDYpkT4EI6YQM
         /x1PiuqdtnFx8+NzdRkZeO+mKKNv+KV7pBh4SFTmQVZTg/Pft37VcEHTjSW/KHRVe0O+
         f5xoflNC/PN7lBTSG0kDVbxycj8NUQZcahy+A0IF4rncu/wFDwiMLF6J3aD/2EuNxXVQ
         c/NA==
X-Gm-Message-State: AJIora+S55zdcMZ1NM36SglVhFZ3Xn8H71ZaTFRVm2SNXKpzzjnnQBLc
        Zwn50okgGCPWCH9fU+s1RLY=
X-Google-Smtp-Source: AGRyM1sLJgetIf5jJsZaQjxquQ8BPC/F8f52bROyoHmk+eqALowCo76e1HkIc7utmda6/lJMQuFF3Q==
X-Received: by 2002:a17:906:84f7:b0:72b:57c2:5e13 with SMTP id zp23-20020a17090684f700b0072b57c25e13mr40568129ejb.702.1658392390546;
        Thu, 21 Jul 2022 01:33:10 -0700 (PDT)
Received: from localhost.localdomain (ict-networks-195-176-112-012.fwd-v4.ethz.ch. [195.176.112.12])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b0043ba45cec41sm615485edq.36.2022.07.21.01.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:33:10 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Add analog audio output on quartz64-b
Date:   Thu, 21 Jul 2022 10:33:00 +0200
Message-Id: <20220721083301.3711-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the necessary device tree changes to enable analog
audio output on the PINE64 Quartz64 Model B with its RK809
codec.

The headphone detection pin is left out for now because I couldn't
get it to work and am not sure if it even matters, but for future
reference: It's pin GPIO4 RK_PC4, named HP_DET_L_GPIO4_C4 in the
schematic.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
Changes since v1:
 - use generic node name for the simple-audio-card node

---
 .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index 02d5f5a8ca03..3897980d69d1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -42,6 +42,21 @@ led-user {
 		};
 	};
 
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Analog RK809";
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1_8ch>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&rk809>;
+		};
+	};
+
 	sdio_pwrseq: sdio-pwrseq {
 		status = "okay";
 		compatible = "mmc-pwrseq-simple";
@@ -177,11 +192,16 @@ rk809: pmic@20 {
 		reg = <0x20>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
+		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
+		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
+		clock-names = "mclk";
+		clocks = <&cru I2S1_MCLKOUT_TX>;
 		clock-output-names = "rk808-clkout1", "rk808-clkout2";
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int>;
+		pinctrl-0 = <&pmic_int>, <&i2s1m0_mclk>;
 		rockchip,system-power-controller;
+		#sound-dai-cells = <0>;
 		wakeup-source;
 		#clock-cells = <1>;
 
@@ -420,6 +440,16 @@ &i2c5 {
 	status = "disabled";
 };
 
+&i2s1_8ch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s1m0_sclktx
+		     &i2s1m0_lrcktx
+		     &i2s1m0_sdi0
+		     &i2s1m0_sdo0>;
+	rockchip,trcm-sync-tx-only;
+	status = "okay";
+};
+
 &mdio1 {
 	rgmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.37.1

