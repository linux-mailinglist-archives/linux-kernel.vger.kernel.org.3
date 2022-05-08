Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1077551EF7A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379514AbiEHTLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiEHTEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:04:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122DDDDE
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:00:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j15so16738378wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMwemA1KBr+zaynR0+gGDDohbL3jNdImjBWzdvOknd8=;
        b=EKtj9FmoJmyr7uYOyeb7nMFyHdD1zia/sjrPRiCyT+J8yo1CQN+YccLI1tcJSuVl10
         y2M02JQk1GHo8X7n1gMYaNNIbnaDELayQurEp9mspRqcXxrLxRJoaDhqXpGmclwy193H
         ow/LDsq2FlBGJqO+vn4caA5HuaIIY01+rzzlsBlApA39FLqyQo2ftfoVO6WG4OoshcWN
         amj0kDQCe5XquyWjqcR0i86Oce3A2wsz1O3Of2wmAF4QpMIsFNN3MQ1M0uvO/KZ5miwh
         h9V6LKleVlcyueROSR7e9v1LLkni2viH+sGl2ehMGnqtfY9KbqdeHzMKYv7cuU8Gnj8U
         rw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMwemA1KBr+zaynR0+gGDDohbL3jNdImjBWzdvOknd8=;
        b=x28OwRTbK3Z/IysDrN6+L5/PUyq+Q1s8IVw79MU3g0LpGq00tZRLp9PESOCqSZRmBU
         shkhrbSqG/4wcc1JvjB41kKAnSH3fGaFdnZG//djkyY8zw4HPgEVrI5OAKjpqaCqPCmY
         sTT2syiWfX59675oPTSSLRGppbxTX/3DEtscv0beputjs6fNIQVzdS1fPxM+VrzH+ToK
         zVgAsGJVF1wL9jexzM+EgMuOptOo2IO8WVNPGndbMOMPipovQ8gJERpNt5H3VzQAT0Bg
         kyBXiVquISz5tnPoGHwAVio8eaOUBT9QiEpuV2cY54Jvekm1yMvFHjKrSpBJhj6Do2Eb
         CSNA==
X-Gm-Message-State: AOAM530ptzNbFP64KhrMlFojkJX6ylnTKFgy6JzuD4KkNyIU8pASfNWK
        EFYLFsKw0nOMgLhDlu+2nymhjw==
X-Google-Smtp-Source: ABdhPJwn2fQPOM2L3JnuiJ6deNhGCDHhqvrOJr1Y+w1dWYse552yfSIZSbwVBC26KFirLL3OjH8A8g==
X-Received: by 2002:a5d:444f:0:b0:20a:cd55:8c32 with SMTP id x15-20020a5d444f000000b0020acd558c32mr11382140wrr.586.1652036434655;
        Sun, 08 May 2022 12:00:34 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05600c3b9000b00394699f803dsm10552348wms.46.2022.05.08.12.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:00:34 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 28/33] arm64: dts: rockchip: rk3399: add crypto node
Date:   Sun,  8 May 2022 18:59:52 +0000
Message-Id: <20220508185957.3629088-29-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508185957.3629088-1-clabbe@baylibre.com>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3399 has a crypto IP handled by the rk3288 crypto driver so adds a
node for it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 8db8b2dba12d..27ab2c377140 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -582,6 +582,26 @@ saradc: saradc@ff100000 {
 		status = "disabled";
 	};
 
+	crypto0: crypto@ff8b0000 {
+		compatible = "rockchip,rk3399-crypto";
+		reg = <0x0 0xff8b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_M_CRYPTO0>, <&cru HCLK_S_CRYPTO0>, <&cru SCLK_CRYPTO0>;
+		clock-names = "hclk_master", "hclk_slave", "sclk";
+		resets = <&cru SRST_CRYPTO0>, <&cru SRST_CRYPTO0_S>, <&cru SRST_CRYPTO0_M>;
+		reset-names = "rst_master", "rst_slave", "crypto-rst";
+	};
+
+	crypto1: crypto@ff8b8000 {
+		compatible = "rockchip,rk3399-crypto";
+		reg = <0x0 0xff8b8000 0x0 0x4000>;
+		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_M_CRYPTO1>, <&cru HCLK_S_CRYPTO1>, <&cru SCLK_CRYPTO1>;
+		clock-names = "hclk_master", "hclk_slave", "sclk";
+		resets = <&cru SRST_CRYPTO1>, <&cru SRST_CRYPTO1_S>, <&cru SRST_CRYPTO1_M>;
+		reset-names = "rst_master", "rst_slave", "crypto-rst";
+	};
+
 	i2c1: i2c@ff110000 {
 		compatible = "rockchip,rk3399-i2c";
 		reg = <0x0 0xff110000 0x0 0x1000>;
-- 
2.35.1

