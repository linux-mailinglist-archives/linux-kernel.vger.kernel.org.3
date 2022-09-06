Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F85AEFEE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiIFQHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiIFQH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:07:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0877699252;
        Tue,  6 Sep 2022 08:30:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e13so16044930wrm.1;
        Tue, 06 Sep 2022 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=i5Fx7IVYwPyLivAgaYsyID9MSMUQe3FGyD8Gwua8VA4=;
        b=Dpd6+bbXENGWjlJ+Rk/N6aSO+77Eta7XIFQFlzwexijOux30B7jCSrI3nK4/pMPvrV
         Z3sLxXUbxuzzGFctCsnnkCjsxltRgjMWUy1Mir8HzQhj/kvEXVzpmgLE5dSFST43ApMr
         htPvRgyEVPmVlgDRW9Q1XwvBCevfw9Zr9IW0SqqYk9u00XIkCv5BDs5Wz3mAdV8A12FC
         ER7PvRT56Memx7kVLS3YR9Z7r+b3QUd419WJ5H1PWQHCkjVQ0rtyrqhJ71GfdnfiEMBX
         hXIbNw2SOTjd7XkpPeNfhaFpKailuPfMKx0vCX8FxTygbgsbhZuGhOitkBFO8QOlMvb9
         NeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=i5Fx7IVYwPyLivAgaYsyID9MSMUQe3FGyD8Gwua8VA4=;
        b=x2KHGnvgvJlaCB5g21VSfWP2Vs9SV/Uw5As4AaOb012UZavhx20p6rBIoqVA5S8f4k
         VS+cl32x3D3goIo3CsmVQ3AXQLNItmaxjr+po+flgyXj4iwppTY8pS4OOG21BmYDMxr4
         j1TdwTLXhBvwkLbaZFD5m5Bao3Mz4TmjzZTCXtdWtkkle1APpCtgrdPAcxOOiCZbR/z9
         WX8k8RVaxpG3XbiHSsnHH4DCV1aEVXbTIOTI6ZsD8YDltUg6nxU4cBqvgbWET03Yq/ys
         jcasZixZcRp1OYiYQXrKDEqvR9J8VFvDYXFVGK/C3uddRyeYVaD/YxI3/A4jPMFMBFaE
         gPoA==
X-Gm-Message-State: ACgBeo1OrMPK/1PFGzadixdjBaR1X8CXhVwvox3Dz2PRmICDZCibmSNu
        /tV1FViqEDp0CGztL0jOC5adVbEDXhiusA==
X-Google-Smtp-Source: AA6agR7Gk+SyBM5KEpmW40JfCj1eCWgs4ex/z4EHEwPDBeTPMJA2kA8/BBoluAnx+PZIBZFMAlxOsw==
X-Received: by 2002:a05:6000:1566:b0:228:b754:186e with SMTP id 6-20020a056000156600b00228b754186emr4831466wrz.226.1662478240266;
        Tue, 06 Sep 2022 08:30:40 -0700 (PDT)
Received: from Clement-Blade14.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a6125562e1sm14922731wmg.46.2022.09.06.08.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 08:30:39 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 2/5] arm64: dts: allwinner: h6: Add cooling map for GPU
Date:   Tue,  6 Sep 2022 17:30:31 +0200
Message-Id: <20220906153034.153321-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906153034.153321-1-peron.clem@gmail.com>
References: <20220906153034.153321-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a simple cooling map for the GPU.

This cooling map come from the vendor kernel 4.9 with a
2°C hysteresis added.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 51 +++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 5a28303d3d4c..53f6660656ac 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -186,6 +186,7 @@ gpu: gpu@1800000 {
 			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
 			clock-names = "core", "bus";
 			resets = <&ccu RST_BUS_GPU>;
+			#cooling-cells = <2>;
 			status = "disabled";
 		};
 
@@ -1072,9 +1073,55 @@ map0 {
 		};
 
 		gpu-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
+			polling-delay-passive = <1000>;
+			polling-delay = <2000>;
 			thermal-sensors = <&ths 1>;
+
+			trips {
+				gpu_alert0: gpu-alert-0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu_alert1: gpu-alert-1 {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu_alert2: gpu-alert-2 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				// Forbid the GPU to go over 756MHz
+				map0 {
+					trip = <&gpu_alert0>;
+					cooling-device = <&gpu 1 THERMAL_NO_LIMIT>;
+				};
+
+				// Forbid the GPU to go over 624MHz
+				map1 {
+					trip = <&gpu_alert1>;
+					cooling-device = <&gpu 2 THERMAL_NO_LIMIT>;
+				};
+
+				// Forbid the GPU to go over 576MHz
+				map2 {
+					trip = <&gpu_alert2>;
+					cooling-device = <&gpu 3 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 };
-- 
2.34.1

