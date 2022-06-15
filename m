Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0265254C0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 06:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiFOEv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 00:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiFOEv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 00:51:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C172E08F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 21:51:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f8so9424114plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 21:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6WAiR9ODFenT0pGV9PYtDziPX2QjLk3EOTxMDGIVGc=;
        b=EClL/J1HWpbNQqyt0eK3B9xqRm6OxDs3oMRzV7qoC3fKV6vIZpYmupM1uS30sYAfhE
         yNFUPH/2rrnVLnWl0pobmscVgmY6xwGui/28B4vZ1WFDT19y8KscMbgSNSgv9cGDmgQR
         98+sFrlj6YzugDgEYx7e751i+ifb5FE0TNxCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6WAiR9ODFenT0pGV9PYtDziPX2QjLk3EOTxMDGIVGc=;
        b=EoThdl9xRg+URRd5HLe4D7gN5dTnXWyeS1VuGKXm9nqg98qNkjzatuSw+KXMggopd4
         16mlVOXL4PxP4iO2/F/VrBCU1CDgVvKXtxrXKE47xV9jdGq2PmgGdiSbc6OHureeyRUY
         6NAMulEXBnpczGfPsZ5e0pDpBLvT1N61r37yqisMG67tlUa4RWAXXGweRimoY+O/63ms
         n4M9FX9iuBhLbPAJw5TGIPYu7H4rOSmrShFcqspLbp4BpY7JrwBwNCLlMqULm36mq5c3
         uIxyqn+pNVlmusmwxvUCgGJiM+lFgprla4l+EQswo5LgI3GpQNUb5aN2xbmrpFlz2TMr
         GaFw==
X-Gm-Message-State: AJIora8zffsEPpwOQQVV3HmqLZ/GkZVJ8y7SjhoqhBGj2Qf9jxbOeduv
        L4kkXe7Ta2mPhfNoSk6OT+midw==
X-Google-Smtp-Source: AGRyM1us1/gLEAQjjVi/lQpGK2jdBLHhP0c4XnBo74TK2dHflGfaqq79NjgmPEIKLKz0EdhmGPXvMg==
X-Received: by 2002:a17:902:da88:b0:167:5b56:8edb with SMTP id j8-20020a170902da8800b001675b568edbmr7389162plx.71.1655268714938;
        Tue, 14 Jun 2022 21:51:54 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b0015e8d4eb1dbsm8183466plb.37.2022.06.14.21.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 21:51:54 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: [v1] arm64: dts: rk3399: i2s: switch BCLK to GPIO
Date:   Wed, 15 Jun 2022 04:51:46 +0000
Message-Id: <20220615045146.3134420-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 10 +++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 27 ++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

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
index fbd0346624e6..60d8cb32cec8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1662,9 +1662,10 @@ i2s0: i2s@ff880000 {
 		dma-names = "tx", "rx";
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S0_8CH>, <&cru HCLK_I2S0_8CH>;
-		pinctrl-names = "default";
+		pinctrl-names = "bclk_on", "bclk_off";
 		pinctrl-0 = <&i2s0_8ch_bus>;
 		power-domains = <&power RK3399_PD_SDIOAUDIO>;
+		pinctrl-1 = <&i2s0_8ch_bus_bclk_off>;
 		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
@@ -2225,6 +2226,8 @@ pcfg_input_pull_down: pcfg-input-pull-down {
 			input-enable;
 			bias-pull-down;
 			drive-strength = <2>;
+		pcfg_pull_none_hiz: pcfg-pull-none-hiz {
+			bias-disable;
 		};
 
 		clock {
@@ -2407,6 +2410,19 @@ i2s0_8ch_bus: i2s0-8ch-bus {
 					<3 RK_PD7 1 &pcfg_pull_none>,
 					<4 RK_PA0 1 &pcfg_pull_none>;
 			};
+
+			i2s0_8ch_bus_bclk_off: i2s0-8ch-bus-bclk-off {
+				rockchip,pins =
+					<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none_hiz>,
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
@@ -2418,6 +2434,15 @@ i2s1_2ch_bus: i2s1-2ch-bus {
 					<4 RK_PA6 1 &pcfg_pull_none>,
 					<4 RK_PA7 1 &pcfg_pull_none>;
 			};
+
+			i2s1_2ch_bus_bclk_off: i2s1-2ch-bus-bclk-off {
+				rockchip,pins =
+					<4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none_hiz>,
+					<4 RK_PA4 1 &pcfg_pull_none>,
+					<4 RK_PA5 1 &pcfg_pull_none>,
+					<4 RK_PA6 1 &pcfg_pull_none>,
+					<4 RK_PA7 1 &pcfg_pull_none>;
+			};
 		};
 
 		sdio0 {
-- 
2.36.1.476.g0c4daa206d-goog

