Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457C0547276
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 08:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiFKGxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 02:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiFKGx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 02:53:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E7BE19;
        Fri, 10 Jun 2022 23:53:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z7so1332173edm.13;
        Fri, 10 Jun 2022 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wN1RtBcP0tZreOj0xnYy6ghrnHUaccRwTp8/xCskyk0=;
        b=drXJ2Nnp1HsY9uMRMmhBW43v8r/PuTtIdKdbLIpof4gruMkvSO9pUpCknH8Xze7s5i
         ezfcg00I+GMnbUtXVO0iog9WBGxasTz6/b/C0OOQppbbrCuDsflzsHsmyjAYz/TVRdsg
         SlFUjt6k7bFygzYHTHEczu1gfBmtU/FnDFRrZUOBRK0JCfyJ0dSBW3tKtb5U4sw22a76
         3yd6vG2OwqY3MMgCUdCAoiic1bZa4+lwzies/FmLyQXKXC/F/bFsEI1xAod70+5Etp7J
         /9fJx9Ufx65RoNhSNmmYJvpNLU5e3OxEH0WkW/k1GDfA5g67POyzP9sY7fbkkf2gu8Hj
         PNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wN1RtBcP0tZreOj0xnYy6ghrnHUaccRwTp8/xCskyk0=;
        b=O+WtBmTSWbmYU96Db+2DsYuHlO2St7Xxvf4VLychbuaeDW0ASnuLndSrSWT053Lxks
         YcSMyP85bLe0ocSarRZds4JKBZkJuSH6L3eReGZjtz4xYnAo0iihLziI2aNjJFXmN1N7
         0XvAmqCbs+aRkGOc6ijmlUdWCAUmdhoMHUrRXNu5oIBN88aRsbjfx19b/ifH9HJTMe+f
         5EHRTO87uJ7DZAKV2cUa+34fvUTnjBHLDqWx3Wruyl3O1H64OPCMvgs5K9DcaHIZK5Ws
         b7hsY94/9OqyNcKVx/Tnf99q5yhgxjJGr1xRDInaTp8e4aEtRLzksFjT3AfF09ChKgS/
         lhiQ==
X-Gm-Message-State: AOAM530QMXjRvwQGQ+yh2eAtPllSL7rpDi+xm36lil46XcVvMShxqvIU
        942Bek+YLBcplCHX/typQdM=
X-Google-Smtp-Source: ABdhPJzW988HLxC7qcZIhf2eFxRPIiplwpsgoZieAq+H2ABUYvgz0HpnzySBj0UsaABVKLR1pcC4Ww==
X-Received: by 2002:a05:6402:ca5:b0:42d:dba5:b2a0 with SMTP id cn5-20020a0564020ca500b0042ddba5b2a0mr55402932edb.197.1654930406307;
        Fri, 10 Jun 2022 23:53:26 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id v14-20020a056402348e00b0042dc25fdf5bsm874261edc.29.2022.06.10.23.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 23:53:25 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: dts: rockchip: rk356x: Add HDMI audio nodes
Date:   Sat, 11 Jun 2022 08:52:59 +0200
Message-Id: <20220611065300.885212-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220611065300.885212-1-frattaroli.nicolas@gmail.com>
References: <20220611065300.885212-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the i2s0 node and an hdmi-sound sound device to the
rk356x device tree. On the rk356[68], the i2s0 controller is
connected to HDMI audio.

Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index cc1c5a65c5e5..319981c3e9f7 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -183,6 +183,22 @@ opp-800000000 {
 		};
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "HDMI";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0_8ch>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a55-pmu";
 		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>,
@@ -951,6 +967,23 @@ spdif: spdif@fe460000 {
 		status = "disabled";
 	};
 
+	i2s0_8ch: i2s@fe400000 {
+		compatible = "rockchip,rk3568-i2s-tdm";
+		reg = <0x0 0xfe400000 0x0 0x1000>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+		assigned-clocks = <&cru CLK_I2S0_8CH_TX_SRC>, <&cru CLK_I2S0_8CH_RX_SRC>;
+		assigned-clock-rates = <1188000000>, <1188000000>;
+		clocks = <&cru MCLK_I2S0_8CH_TX>, <&cru MCLK_I2S0_8CH_RX>, <&cru HCLK_I2S0_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		dmas = <&dmac1 0>;
+		dma-names = "tx";
+		resets = <&cru SRST_M_I2S0_8CH_TX>, <&cru SRST_M_I2S0_8CH_RX>;
+		reset-names = "tx-m", "rx-m";
+		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	i2s1_8ch: i2s@fe410000 {
 		compatible = "rockchip,rk3568-i2s-tdm";
 		reg = <0x0 0xfe410000 0x0 0x1000>;
-- 
2.36.1

