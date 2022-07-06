Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2644E5682F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiGFJHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiGFJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:06:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F3924F33
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:05:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l68so8419142wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXNec13rQxx7mczo0Bb45Dl1W4/rRz+jQsRU4AeJnZM=;
        b=2KH0c9i5pRILecSD4cAr1i5IG81/CljsGJebd4GrlEu87GGF+p4iLvgg69UypD4DGA
         l545no2gU5djMfQXCkQ13fkRA6JgbOl04rIrM6ABTL0bmmCnR1jciczP2obeGis+6VaG
         v3YHDgcdTBNvuLmF7cDwpiCUQHw2E/SyNMjbz6/BHLG0R1x71jyIulfD0jboY1YyPPIM
         k9BAZp0vE4EF8p5/Xeho4rFX51MilcYI0SEO6UF+eTxIihL0BCZ5GdVEBIFl9mZV70m0
         m3hNv+FivGSRxvIYos1Wgq1x6JMp3lx9XVdmv+NO6xxmbgGCXd+0QaoI5xzy42DkYErn
         qIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXNec13rQxx7mczo0Bb45Dl1W4/rRz+jQsRU4AeJnZM=;
        b=0lZahhqUnVwriudXPr9lmUSG6TgK8vJUau0N1lAkUfkVXEg19nPkDr3WmxQyrU8IJD
         /U8ns9Gkis/R34PH+IOLXSYT8pBRS4pRgCKhar2PcX9l0/frLar+bmX9PvW3XCxfoGu3
         OCGkva6wJNM/9ThoNx9doCRbeNqO/judN/xgAu+XSLM2jSfdLvoWYUIk5QDnPwzc1tm3
         d1Gap/S9m/bi2zx4PclTnjsWaDVsSoS7ClY++9jXyIEmrvgycnVNXrJxAqNPM6lCYMci
         Dv0+GA1W0k35tt/M5qEsFOZMguHLTCe6lCxoqgczZftDQif+NeEsXdJESHVRCKDu+KZg
         Q3BA==
X-Gm-Message-State: AJIora/68+AW7TTsEa+BwvK4DoGYnnMPQCnCG/TGoEBmACnm5IbdD4KX
        lNK81DnOMHS5/g89uCwMH/N9MQ==
X-Google-Smtp-Source: AGRyM1toIJ3bBwvAdPj3WgU9vUOPQT1BAvlEHJ5810B7GsO/4J25yaE+bYN0O90J2JbxvuU5axmchw==
X-Received: by 2002:a05:600c:3788:b0:3a0:4279:5142 with SMTP id o8-20020a05600c378800b003a042795142mr38248606wmr.21.1657098301075;
        Wed, 06 Jul 2022 02:05:01 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfe28b000000b0021d6ef34b2asm5230223wri.51.2022.07.06.02.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:05:00 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@metanate.com, didi.debian@cknow.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v8 27/33] arm64: dts: rockchip: add rk3328 crypto node
Date:   Wed,  6 Jul 2022 09:04:06 +0000
Message-Id: <20220706090412.806101-28-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706090412.806101-1-clabbe@baylibre.com>
References: <20220706090412.806101-1-clabbe@baylibre.com>
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

rk3328 has a crypto IP handled by the rk3288 crypto driver so adds a
node for it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 49ae15708a0b..96a7a777bae8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -1025,6 +1025,17 @@ gic: interrupt-controller@ff811000 {
 		      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	crypto: crypto@ff060000 {
+		compatible = "rockchip,rk3328-crypto";
+		reg = <0x0 0xff060000 0x0 0x4000>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_CRYPTO_MST>, <&cru HCLK_CRYPTO_SLV>,
+			 <&cru SCLK_CRYPTO>;
+		clock-names = "hclk_master", "hclk_slave", "sclk";
+		resets = <&cru SRST_CRYPTO>;
+		reset-names = "crypto-rst";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3328-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.35.1

