Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5723550990
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 11:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiFSJxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 05:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiFSJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 05:53:41 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA97B874
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 02:53:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g186so7767284pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 02:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A3uZ1jIICpHiZnFU43B5vH0CMaK9r5CfFs9x4zrpuJE=;
        b=RT/0V4CPmcHYnjRoDd/Q/pPB6JYKQG10Orfi42dHN4qbs9wO2sOwXQCZe0ZxF112r6
         KDKyAbAHcoX/soTsP9+WrNoWraur+POHy1NfEuOFh3l/uhbXHOpLtRIoCUCR6j58bumD
         lPYnQehk2CJVVtR6gGcujjOrnT9u8HJt6DCHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A3uZ1jIICpHiZnFU43B5vH0CMaK9r5CfFs9x4zrpuJE=;
        b=QxC01tuqv0Opr6kz/QrqaiPkkZIxv37wRmlp9n+h7cavkqK06AwCwIs/9Gk6/eBwdZ
         nhJ7eZdIp8Q0NMcktkpCIgMiEjaxlsExkYo73rCdZETLyScBy+NeBRrcPzTPZywnrqjy
         SwKUUW/a7P7r5BJlzXDNLvDar4AsNxU98eCQh8QLTfO7x7h85fQN5ndMzGKm4PQYhKVy
         +NrSExw0G7bJg+D+K+kxamVae6kusl8Cx5n7CEcEo0DW5GKT0zxy2OonRamgDQau4JHg
         mlxkfBpTwc10fjE2OkQ164yTVLe1kPUcHGxTLVG2elguOznLatXSkOwfRJrOS4XJy56N
         5utA==
X-Gm-Message-State: AJIora+AY6yZx9kLDJwmBYxPXRYrssy49Zb8GwdDROgbfYY+P4M3CL6t
        5yS8jnclWhAb0EFSd5kBpBYEXQ==
X-Google-Smtp-Source: AGRyM1vmgR7Io25BpLbpcTj1C4ziE8TVq3kjgRXrx9mlFv2icUudpWQ5jrTEmip+qvm8QY7RF+lRDQ==
X-Received: by 2002:a05:6a00:813:b0:51c:17b2:60cf with SMTP id m19-20020a056a00081300b0051c17b260cfmr18994984pfk.70.1655632419261;
        Sun, 19 Jun 2022 02:53:39 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id 135-20020a62178d000000b0050dc762817esm6799971pfx.88.2022.06.19.02.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 02:53:38 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v4 2/3] arm64: dts: rk3399: i2s: switch BCLK to GPIO
Date:   Sun, 19 Jun 2022 09:53:23 +0000
Message-Id: <20220619095324.492678-3-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220619095324.492678-1-judyhsiao@chromium.org>
References: <20220619095324.492678-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Brian Norris <briannorris@chromium.org>
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
2.36.1.476.g0c4daa206d-goog

