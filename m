Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36065A97F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiIANAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiIAM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:58:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB59D915C2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:57:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso1309607wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Rj/Na2p2CdSqeZMTsRP9N7r+JNYd47iwYks0u+hdyhY=;
        b=nSB5MxRXG1HrU13CxyoiFeYyk9+Kmtibu4qeyazX1OrM5eg50fRBwlRyVzchgZYXzK
         pgVGRZwD0CPwuEX+bwRpYqd7JtkVm80jFwSvUKSgR/vTGuX9BEUzbVjSOjzS6+jN+Zak
         ozJ/Rnz6f7o4Uj3CCw2Gy4/vY9GMs0BBeel/bz0A3fu9Tm+cArUucavcodJa0ErGneRJ
         CSLbcsM8oeXs1Sg7va5P7Q5atGEw5z+TrI64tgUgaLSrPRii+PUbVJ79NDcjjLDxTnI2
         9qLQ+OCno2DMFWYi5sDqqzUdSRswn4rWHOQKviJSoqo7F9M0LETh5HPJSkk8fKZG9Iht
         xs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Rj/Na2p2CdSqeZMTsRP9N7r+JNYd47iwYks0u+hdyhY=;
        b=pcmSBxXcrGOpY0aCm0OKN4c5r8HSROrDfC/ZC3SCNWVfPnb2wdDpvWg1sQbFdV8e1G
         5MptGiNRoMYrEMBlqfocc4NZPk4sK/t9HNhyJ4Zp0STsGQtdIfT8pzkerzDyaa4jm93+
         As+MacLkFZfxCucHpEbIpvQWiovdLispPpInmcl2BHqcbMfExENkmFVSOhoTC2t22yQd
         kLDhweRmyKsNKv4pNzkaJzoyuI6mzGs451T/xwiuf1sj/4fJxn8awCGzm82P5TKGz3EZ
         6IYLgN2YesrC5KR64HEatmdT2tujSFCjJ19S0AvM7sAAicoCPA4Aj4Nf9SEyblLhGluS
         x5Qg==
X-Gm-Message-State: ACgBeo3U6rUkHXu+QT6s51XSZq8OCAXiYwaqgsS9Revff5KVbdz30tEp
        Ihl+gas8/+9WGykhqouHvdheMQ==
X-Google-Smtp-Source: AA6agR48476bm3b8oC3PPl+7byFqEBBIf9010+acdf8xGdzXK/sMbAVym/ITPr7LOFIup4oxtbdfrA==
X-Received: by 2002:a05:600c:410f:b0:3a8:54b6:557 with SMTP id j15-20020a05600c410f00b003a854b60557mr5041108wmi.34.1662037065767;
        Thu, 01 Sep 2022 05:57:45 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm15556709wry.6.2022.09.01.05.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:57:45 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, ardb@kernel.org,
        davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v9 28/33] arm64: dts: rockchip: rk3399: add crypto node
Date:   Thu,  1 Sep 2022 12:57:05 +0000
Message-Id: <20220901125710.3733083-29-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901125710.3733083-1-clabbe@baylibre.com>
References: <20220901125710.3733083-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3399 has a crypto IP handled by the rk3288 crypto driver so adds a
node for it.

Tested-by Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 9d5b0e8c9cca..8e5aa1ca62d1 100644
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

