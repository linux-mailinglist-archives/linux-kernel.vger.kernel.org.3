Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA605524CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353766AbiELMZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353682AbiELMYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:24:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00FE247374
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:24:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so2911928wmz.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/dkIwzTHk+5gsotg7nLbrQsDZjzi6VTdK6DCeSc+w8=;
        b=QriHUDKYodKrRPdxpYYgtJTXUTjl6lU+iPjloHZmUjl6pz0T8QXq4FytbPxG5TJGWW
         SIR6jIVEMBAdtCoHsg9ZBHYt6Fmt76/9P2zA1nFKnL/uSuHVQrl2w4mMEupUJyKHsBNa
         rtkoisnbWKZ8J5IotNBpXoseTd6d9z7v+TL0JtYf9ARG9ApeW8ypCGCc//Kr+q/mzJiE
         D8nTwJ+ZSunczyXzcyX+2Jwstqa2kSug0pZrza8UvXqsS2qR9TPdlBrw1+9uqA1W7CvI
         7ZOt+8WS4I1B2yOcHuxg40VI2Q25dDYeQjnveExd7cXE8Vi5pNx3CYHsBZtVuDGtmXLY
         QYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/dkIwzTHk+5gsotg7nLbrQsDZjzi6VTdK6DCeSc+w8=;
        b=YEr5bEjMDZGJKyk8u2/aQNGL5q7WoU48px5PlmBNlW3gmd/jzC3A38DgIx2fs6y5SF
         7y8WG152EhmBBJdH8cA2MeAm9jJoO7faNh9ZpCL/hWrPNFhKJz3blIyyulGTqKz579Xh
         /eERmmUGK7U5vGchkjAnqNE7Ry7/Ap9xtG5TtjKQ8fnAVMC7LYUdI7NXieEgKx9wKl1F
         2oS/WUBCnY4ROaZym7XrVh4p2Y5ahXhmKmeXKhzyLR1OEybc5fBFsXhSFWLglCQ47RZn
         bMQCQWpAT+7xcyoXg2eu7+wwRC4BeUiEio+rFSmzrZtaaHA3R1aL+AJ75SFoN1iUmz4E
         gPGw==
X-Gm-Message-State: AOAM530oOoI+g3OuJTfD1wg4B5O+Gof1BdRDyK5efX2toLdQPlcltu04
        /Tg7UqvwvWSLLfjnRQVsmlgKcQ==
X-Google-Smtp-Source: ABdhPJz7xhNH2VS8qz0wUUIsoo72WfBxVT3Sy5iAc/peGlJ6NUtqhpFPZLhhTH9iUNPRol++6IwYDw==
X-Received: by 2002:a7b:ce02:0:b0:381:2007:f75c with SMTP id m2-20020a7bce02000000b003812007f75cmr10138584wmc.6.1652358284482;
        Thu, 12 May 2022 05:24:44 -0700 (PDT)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc156000000b003942a244f30sm3047819wmi.9.2022.05.12.05.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:24:44 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, michael.kao@mediatek.com,
        ben.tseng@mediatek.com, ethan.chang@mediatek.com,
        frank-w@public-files.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, khilman@baylibre.com,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v6 7/7] arm64: dts: mt8195: Add thermal zone
Date:   Thu, 12 May 2022 14:24:33 +0200
Message-Id: <20220512122433.1399802-8-abailon@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512122433.1399802-1-abailon@baylibre.com>
References: <20220512122433.1399802-1-abailon@baylibre.com>
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

From: Tinghan Shen <tinghan.shen@mediatek.com>

This adds the thermal zone for the mt8195.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 103 +++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 12887fb4d0d1..d6e5b595a89f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -823,6 +823,21 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvts: lvts@1100b000 {
+			compatible = "mediatek,mt8195-lvts";
+			#thermal-sensor-cells = <1>;
+			reg = <0 0x1100b000 0 0x1000>,
+				<0 0x11278000 0 0x1000>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+					<GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			clock-names = "lvts_clk";
+			resets = <&infracfg_rst 1>,
+					<&infracfg_rst 2>;
+			nvmem-cells = <&lvts_e_data1 &lvts_e_data2>;
+			nvmem-cell-names = "e_data1","e_data2";
+		};
+
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8195-spi",
 				     "mediatek,mt6765-spi";
@@ -1627,4 +1642,92 @@ vencsys_core1: clock-controller@1b000000 {
 			#clock-cells = <1>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu_big1 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 0>;
+		};
+		cpu_big2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 1>;
+		};
+		cpu_big3 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 2>;
+		};
+		cpu_big4 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 3>;
+		};
+		cpu_little1{
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 4>;
+		};
+		cpu_little2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 5>;
+		};
+		cpu_little3 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 6>;
+		};
+		cpu_little4 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 7>;
+		};
+		vpu1 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 8>;
+		};
+		vpu2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 9>;
+		};
+		gpu1 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 10>;
+		};
+		gpu2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 11>;
+		};
+		vdec {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 12>;
+		};
+		img {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 13>;
+		};
+		infra {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 14>;
+		};
+		cam1 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 15>;
+		};
+		cam2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 16>;
+		};
+	};
 };
-- 
2.35.1

