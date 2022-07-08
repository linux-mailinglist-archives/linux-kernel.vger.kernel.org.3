Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3656656B413
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiGHIHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237707AbiGHIHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:07:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161628049A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:07:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q5so110871plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yrPt4qD/JmjcNFx3ynJ+Aoh0y9NjRgnFT1MYYJEO1pc=;
        b=mnyrqzCNMNXcxFBg5hrXHpQH3kGkG/YYp+PL4YagspWeH9/PEgNNP4xYt964mJgvFL
         St8C+KafMB99DqcLeNo9lris91DOLgaX0IefvtgFOvOvW7zJMWZDWOuHPlQFFmiU1y0y
         nqDq1qZQYeYkTcwpNz+odJMVYR0Ar8HsUJenw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yrPt4qD/JmjcNFx3ynJ+Aoh0y9NjRgnFT1MYYJEO1pc=;
        b=i4id3qL/PkYsOWGuS8DMC5pq/FCo9Cc9+xh5UgrEe5pqzaDLJ8QddmCvTH54d87WME
         cUC1r3Ajg7XzHaRJH597OxGBn18nc0FnQzZEEOy6pA6hP+D0q19S9Eojmh2iKEFHYvB8
         wI57gGor6L4GK7gBPh6NcOtGfRYZ3TAYfFAlIbmC6yoF30dCU9kHbTfKSePNyLPmc78U
         42jn5ifT+LoaxzOuXbsxNKdITbv1BoyobVbPfyBzbjjh8lJKhnVaTqSPcfZqzYznvs6y
         dkYdh6pKwK/RTGdv4ceSWN+86sprQAgE+lcKscdaq7jwMp+UY6ZsSDDGjMJnesj6G3Up
         J1yA==
X-Gm-Message-State: AJIora+BAWyZSy7Ra3/kgxK4ppJ2m8kcAjAJwb0gcUx6+gbkUjWz5pKI
        +HO2eDGGmznKmJy/CDBI7RHN1g==
X-Google-Smtp-Source: AGRyM1uamhzBFa5P+oq1pLu4V7IRdmSNjDjcV0bjdqsDBeS2d4DcCPkRKdaPuq5KRhwCbR/6CkH+rA==
X-Received: by 2002:a17:90b:4a03:b0:1ed:2071:e8c with SMTP id kk3-20020a17090b4a0300b001ed20710e8cmr10559037pjb.216.1657267654589;
        Fri, 08 Jul 2022 01:07:34 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902b58b00b0015e8d4eb26esm29137786pls.184.2022.07.08.01.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:07:33 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Lin Huang <hl@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v1] arm64: dts: rk3399: i2s: switch BCLK to GPIO
Date:   Fri,  8 Jul 2022 08:07:26 +0000
Message-Id: <20220708080726.4170711-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We discoverd that the state of BCLK on, LRCLK off and SD_MODE on
may cause the speaker melting issue. Removing LRCLK while BCLK
is present can cause unexpected output behavior including a large
DC output voltage as described in the Max98357a datasheet.

In order to:
  1. prevent BCLK from turning on by other component.
  2. keep BCLK and LRCLK being present at the same time

This patch adjusts the device tree to allow BCLK to switch
to GPIO func before LRCLK output, and switch back during
LRCLK is output.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 10 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 25 ++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index 913d845eb51a..df1647e9d487 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -766,6 +766,16 @@ &i2s0_8ch_bus {
 		<4 RK_PA0 1 &pcfg_pull_none_6ma>;
 };
 
+&i2s0_8ch_bus_bclk_off {
+	rockchip,pins =
+		<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none_6ma>,
+		<3 RK_PD1 1 &pcfg_pull_none_6ma>,
+		<3 RK_PD2 1 &pcfg_pull_none_6ma>,
+		<3 RK_PD3 1 &pcfg_pull_none_6ma>,
+		<3 RK_PD7 1 &pcfg_pull_none_6ma>,
+		<4 RK_PA0 1 &pcfg_pull_none_6ma>;
+};
+
 /* there is no external pull up, so need to set this pin pull up */
 &sdmmc_cd_pin {
 	rockchip,pins = <1 RK_PB3 RK_FUNC_GPIO &pcfg_pull_up>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index fbd0346624e6..311c8394cc84 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1662,8 +1662,9 @@ i2s0: i2s@ff880000 {
 		dma-names = "tx", "rx";
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S0_8CH>, <&cru HCLK_I2S0_8CH>;
-		pinctrl-names = "default";
+		pinctrl-names = "bclk_on", "bclk_off";
 		pinctrl-0 = <&i2s0_8ch_bus>;
+		pinctrl-1 = <&i2s0_8ch_bus_bclk_off>;
 		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		#sound-dai-cells = <0>;
 		status = "disabled";
@@ -2407,6 +2408,19 @@ i2s0_8ch_bus: i2s0-8ch-bus {
 					<3 RK_PD7 1 &pcfg_pull_none>,
 					<4 RK_PA0 1 &pcfg_pull_none>;
 			};
+
+			i2s0_8ch_bus_bclk_off: i2s0-8ch-bus-bclk-off {
+				rockchip,pins =
+					<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>,
+					<3 RK_PD1 1 &pcfg_pull_none>,
+					<3 RK_PD2 1 &pcfg_pull_none>,
+					<3 RK_PD3 1 &pcfg_pull_none>,
+					<3 RK_PD4 1 &pcfg_pull_none>,
+					<3 RK_PD5 1 &pcfg_pull_none>,
+					<3 RK_PD6 1 &pcfg_pull_none>,
+					<3 RK_PD7 1 &pcfg_pull_none>,
+					<4 RK_PA0 1 &pcfg_pull_none>;
+			};
 		};
 
 		i2s1 {
@@ -2418,6 +2432,15 @@ i2s1_2ch_bus: i2s1-2ch-bus {
 					<4 RK_PA6 1 &pcfg_pull_none>,
 					<4 RK_PA7 1 &pcfg_pull_none>;
 			};
+
+			i2s1_2ch_bus_bclk_off: i2s1-2ch-bus-bclk-off {
+				rockchip,pins =
+					<4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>,
+					<4 RK_PA4 1 &pcfg_pull_none>,
+					<4 RK_PA5 1 &pcfg_pull_none>,
+					<4 RK_PA6 1 &pcfg_pull_none>,
+					<4 RK_PA7 1 &pcfg_pull_none>;
+			};
 		};
 
 		sdio0 {
-- 
2.37.0.rc0.161.g10f37bed90-goog

