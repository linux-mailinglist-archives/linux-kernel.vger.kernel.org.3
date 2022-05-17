Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9652AD11
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353068AbiEQUyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353039AbiEQUxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:53:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07BF5251C;
        Tue, 17 May 2022 13:53:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z2so12855ejj.3;
        Tue, 17 May 2022 13:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1hlOjb+KKdy0/QG/BxO1k2JNdhSZM3UJOdwKv3T7/8=;
        b=O+g2EiFszka8Gyv4mBKpvWJcQksP96SoPGoXsMWBT1OpzZnGQfH/WciGdmQhHaS3Xp
         yOXcajZxS5Cyk78GDmgCzvVcJimedr0ZVIAuIN96TU9uJKlaT8GBJ9nvLiq7fQi4CxaB
         H1qBdB+zFjk3KU2dbj7ro9KD7JpxOBDjQLCxvcWYLnHbGWlL4JlCtyBxzoaJeJ6S+StA
         Ufi0s5LQelE/+vtwCjx58kanBUUsjURCa4U7J2GjdxskELO6YOX/KHP0EyRLf9NJy/wk
         oIXDcK9n7yri/MLC65pPR9kI7BLL3QmX+1TdVE1pwbwBznye5xtLQ22tzj3yGvp8uEad
         S1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1hlOjb+KKdy0/QG/BxO1k2JNdhSZM3UJOdwKv3T7/8=;
        b=btL5snrlarjQ8ihg/JA07Gp6YVvc99k4eAXRE4I5rg/wA8PfiRgMZjkT1IdltYT2L7
         c2xON2Q/oZaaMsGO4ElewbxcDi6DrFOp+9+KnRCkHfyr4DeCTtLyyKDWUspjRoujLJlA
         a5rEIXXI3eaguM3QhEr4BoD/z53SUEFzcMnKvyC4d4+I+bkntj2vAv5CczKJFxE2ALvw
         gw/D7qYjd3ysOkK3Ox87a76FafKZ1Qg2/aIz1DhXv8Nwyr4e0QZR+3whlDjY45WG3Sbu
         hC0MWG2m6Qn97ri9/WiOIIrYpvnkBib29h1euLJu2pWByZnc3l3f4fwaS4ngqSTczE3F
         xxlA==
X-Gm-Message-State: AOAM531ekFAubZOQ4msu678RwbJJV9BFnq2Ru/dzXnhoq95T4nZmZnVP
        veZeE2hc8ESNC7lfXCTE4vY=
X-Google-Smtp-Source: ABdhPJx3V68VWfSWW6xJEt+valHr9O6njAez/YK7ILuhrOyetHlEXHTE1zxvW3zzUw1IKW3kp5HVmA==
X-Received: by 2002:a17:906:8306:b0:6f3:da72:5ca1 with SMTP id j6-20020a170906830600b006f3da725ca1mr21543924ejx.606.1652820830197;
        Tue, 17 May 2022 13:53:50 -0700 (PDT)
Received: from fedora.robimarko.hr ([188.252.220.143])
        by smtp.googlemail.com with ESMTPSA id v22-20020a17090651d600b006f3ef214e10sm120907ejk.118.2022.05.17.13.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:53:49 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 5/6] arm64: dts: ipq8074: add SPMI PMP8074 PMIC regulators
Date:   Tue, 17 May 2022 22:53:40 +0200
Message-Id: <20220517205341.536587-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517205341.536587-1-robimarko@gmail.com>
References: <20220517205341.536587-1-robimarko@gmail.com>
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

PMP8074 is used in IPQ8074 and provides S3 for cores,
S4 for UBI core and LDO11 for SDIO/eMMC.

So, lets add the nodes in preparation for DVFS later.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 789fec7c6aa4..d1a0b77c38a4 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-ipq8074.h>
+#include <dt-bindings/spmi/spmi.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ8074";
@@ -421,6 +422,39 @@ spmi_bus: spmi@200f000 {
 			interrupt-controller;
 			#interrupt-cells = <4>;
 			cell-index = <0>;
+
+			pmic@1 {
+				compatible ="qcom,spmi-pmic";
+				reg = <0x1 SPMI_USID>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				regulators {
+					compatible = "qcom,pmp8074-regulators";
+
+					s3: s3 {
+						regulator-name = "vdd_s3";
+						regulator-min-microvolt = <592000>;
+						regulator-max-microvolt = <1064000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					s4: s4 {
+						regulator-name = "vdd_s4";
+						regulator-min-microvolt = <712000>;
+						regulator-max-microvolt = <992000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					l11: l11 {
+						regulator-name = "l11";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <3300000>;
+					};
+				};
+			};
 		};
 
 		sdhc_1: sdhci@7824900 {
-- 
2.36.1

