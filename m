Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1265959B5A1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiHURbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 13:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiHURbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 13:31:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ACD17AAF;
        Sun, 21 Aug 2022 10:31:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a4so10675641wrq.1;
        Sun, 21 Aug 2022 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xXtd3T1/ZmQUyro/3HUWSi05URHaw6Uj3JAxrNnokZQ=;
        b=WrCaNmPmrBGJvcCKPkD/xrN9evhffeqMgS/b4hmh1mBEAG1Ow5N7Zlj9BKGmeGuRTS
         afuBjwzks5LCQ3PW0m6IJJLbkIGaOzMU61twhKeaK+a3jSc+HVE/e9OwQF5pGnG0TXTd
         XHJfJh5GchRTl5S7oIvp9AT1+WvBSk/Y2iAdc2kV9tDYRm69BZKtf1t4v/LkukH/OD0j
         9pdGK/Nb9rZFvsTDw2Z6SQdxGe1KsQ/RvNxSnw64Ems1gjopQnrZ3AN9oI6V5eXvqt4X
         0fCk39/so6YeaVn06GZkQgl84qmoxDZ29mwKlXyUnYzJTpCxDOmlkU55l8lPiNhuph6X
         olBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xXtd3T1/ZmQUyro/3HUWSi05URHaw6Uj3JAxrNnokZQ=;
        b=gst1Nu7V7XNz20GgPf28WjSrQmDQzTKWW1OFTVOIHUtsaeBHUoabUPdsEhxXtESm2a
         PBfOgz6T/yh3TbyWDI/+mdd4eiK4R1JUU5AcnlsUOMiA6Kgx28y8/uSQ3cng4GeeE66R
         Bx91BNmck5ulZqksWYpIy9JZnoBwq/C74MHcz2412pvjyaacw9e0TwAh5aWfgJUbbHJc
         n71Se2cH9qD5p4bKY/IHa9kxwm+CnAHHzKSBMBu8I6DVxoWVRjUSgjATMzfBUFImpgtf
         dqtafLk/nG7dhoCT4bDwUX3NW55IPFHKHUi/P4J4bDu5i5/Ga5faRF6UDtoHEjFlKHMR
         e3HQ==
X-Gm-Message-State: ACgBeo2S9S3I1w+gFoEx5BFbzVlInhdCTom4jWhXUDRVwSK/Jh6E+mBv
        Ua+nT046OkOAkSTgAi2gUzI=
X-Google-Smtp-Source: AA6agR4viVgw7SRXAAacJiqkBrwpN7r4KswavSgQ6UWx06oXqqUMu6VnRmfkNRqzLYnrE+PRPvYBUQ==
X-Received: by 2002:a5d:43d1:0:b0:225:2707:dee with SMTP id v17-20020a5d43d1000000b0022527070deemr8873986wrr.25.1661103067713;
        Sun, 21 Aug 2022 10:31:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:a77:3d70:9d84:ec8d:98d9:c29a])
        by smtp.gmail.com with ESMTPSA id b18-20020adff912000000b00224f7c1328dsm9387205wrr.67.2022.08.21.10.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 10:31:07 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 2/4] arm64: dts: allwinner: h6: Add cooling map for GPU
Date:   Sun, 21 Aug 2022 19:30:49 +0200
Message-Id: <20220821173051.155038-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220821173051.155038-1-peron.clem@gmail.com>
References: <20220821173051.155038-1-peron.clem@gmail.com>
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

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 5a28303d3d4c..943ae5374dd6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -186,6 +186,7 @@ gpu: gpu@1800000 {
 			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
 			clock-names = "core", "bus";
 			resets = <&ccu RST_BUS_GPU>;
+			#cooling-cells = <2>;
 			status = "disabled";
 		};
 
@@ -1075,6 +1076,27 @@ gpu-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 1>;
+
+			trips {
+				gpu_alert: gpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 };
-- 
2.34.1

