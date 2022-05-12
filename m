Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C60524CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353681AbiELMZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353680AbiELMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:24:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E710624734C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:24:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q23so7031712wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=befZQ9FS23fWMFZgR26WPFKtinCTSI/vcnKTdqrsD2I=;
        b=3BHa3XT/PM1d1Fqi4xdlw28bRsyHbtLMKPZ3xkV1jdTvwnDc4q2bNcQ7kJkdQqg2PG
         ooi6aQOfiOzLrON7fQvWJQHbOEFE1bXmTqDtJfD2uhBwfqsTPcwh23AVpQ2qO0zH/O3/
         AV4mGC+ARmcDMVCotPPZkyyvkqbjDeVluw7uOg6vG95WukWDTm76nWqLWuiqvPFZCkSK
         a/+8/aQicU0gw32smoTPprxZLzqH5r8x5vGutquYVlUh38sRJ2K9G4S+UnfSijBUP0Ey
         8dlgbR/MCauaFiOLg5bBREaJz3FqgsXlqhf7Ew1Ghva9ZT6WTCSbrrZ1/N/dJBtXbpZL
         8+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=befZQ9FS23fWMFZgR26WPFKtinCTSI/vcnKTdqrsD2I=;
        b=DbKr/XncwSRoPMd/wdo7+ECRL0+yOB2R1Wvz93BrxEgNjAozdX/hmKwZk+/rSmY+NT
         xKZDpXI86xujqRxtpfe2qpdeuq2ZMWeL6IxA8nqa4BB2+pcu6dVscNUdtsG5EL5bbm2a
         29FEpCXYeWu19W3jvrCDTXIXSn8VIWMvLUysJ5DJUEdtLYRHiiqc2vIOEq9oiIABo97A
         FUjV1ui9CpFNAYmLKLpeWSAMD/CxuL2edsr52s6ym7ZMJY8GFnmXUT1gHYX2y7X/KO5N
         mEdv8YWKPKnpsu7p4wVoPUQode6FbREOIoBXDsIX4k8B8nzIT/NMmh67KseEstbLhm3h
         IEfw==
X-Gm-Message-State: AOAM530uy1wCIV4/7V7gWa7PuQdB+g5wvpV+gabJFA5TtBaaIpajbcY+
        ant6ZJY9g5K4i7oWYqkRiB9/hw==
X-Google-Smtp-Source: ABdhPJzl2RnwuKtjp0w2JW5qr0wn4jOfQ9nztXnOxQtRwboK1PADSs7vYj8oT4mnuqSVmq7o/fDkmA==
X-Received: by 2002:a5d:47ca:0:b0:20c:72c9:d3be with SMTP id o10-20020a5d47ca000000b0020c72c9d3bemr26671903wrc.114.1652358283467;
        Thu, 12 May 2022 05:24:43 -0700 (PDT)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc156000000b003942a244f30sm3047819wmi.9.2022.05.12.05.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:24:43 -0700 (PDT)
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
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v6 6/7] arm64: dts: mt8195: Add efuse node to mt8195
Date:   Thu, 12 May 2022 14:24:32 +0200
Message-Id: <20220512122433.1399802-7-abailon@baylibre.com>
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

This adds the efuse node. This will be required by the thermal driver
to get the calibration data.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 416d37e07324..12887fb4d0d1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
 #include <dt-bindings/power/mt8195-power.h>
 #include <dt-bindings/reset/ti-syscon.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "mediatek,mt8195";
@@ -1248,6 +1249,23 @@ nor_flash: spi@1132c000 {
 			status = "disabled";
 		};
 
+		efuse: efuse@11c10000 {
+			compatible = "mediatek,efuse";
+			reg = <0 0x11c10000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			lvts_e_data1: data1 {
+				reg = <0x1bc 0x14>;
+			};
+			lvts_e_data2: data1-1 {
+				reg = <0x1d0 0x38>;
+			};
+			svs_calibration: calib@580 {
+				reg = <0x580 0x64>;
+			};
+		};
+
 		u3phy2: t-phy@11c40000 {
 			compatible = "mediatek,mt8195-tphy", "mediatek,generic-tphy-v3";
 			#address-cells = <1>;
-- 
2.35.1

