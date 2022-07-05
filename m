Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F45156708A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiGEONT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiGEOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D89A1C8;
        Tue,  5 Jul 2022 07:06:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id q6so21771466eji.13;
        Tue, 05 Jul 2022 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iotBaBGSGm6mxJVJOGjmsDN+mBAOX2RyhBgobPBYyEU=;
        b=VBPk+93kdFLZe8UHyRnMTrggReTPNxIkWEWCBr23bReXa8Z+HfJTAXlKpIGXUqBGUN
         nM9RnBEBQ4Qw5kB48SRBaxKEKDfia+P8hzKcF3PavOBZqaIgNWAVKR+z2XOLK57vVqFG
         lfvzPYTb/3180YaP0QKb6xHRwzyeRgufvZ0PJQoJsW1mtK+64CqkCSwUXBFmDLuK1Rq4
         YRMozqXbXTd18icrTl82udc5txIMKxR0DSPuNn/xNdd5tUYKnG8XXk+o8KCN9m4eNYfB
         bvxLpqHx8axkQwjzxOb+st+kP3wbFf7OCiXnWNwlyC+EOpfxOgOCM+gywzkSPhKT8t2f
         znmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iotBaBGSGm6mxJVJOGjmsDN+mBAOX2RyhBgobPBYyEU=;
        b=yyrv/KV9sHrHG77x4J+x51SenPtpAvHkwMiHiODNdc+UOrnUVKSgTTd+caPe7UI1Wi
         usLLpZJrYuAib+MBvam9e1AyDGhv95bvVqdQTZpDP3tkPhgB9XeBBv2TsQblgh4Jh3L8
         WbG9HgBOBirwmmuSDSwyuojPFWPMK5nmrqf4nO2Ef5f7Crh74ZqwD2IrOdColXhTXw8C
         teZabIXlLzUlI3iZtL+ektVXd2nmyuoqLsVcROpoRIjBbOjQevtxoeSa6r8IN/+nHQi/
         7FVYGMV2C4pWUr7U5OyNpRdaE2qDaqF11tIMjzI9ZTjD7htaf7OYQxZhqnIB8cQx/NRU
         hmcQ==
X-Gm-Message-State: AJIora9+xWj5WSMixdVlRAzT3GW+03uxFgW8vihpjEMIiG2q4vwzm20K
        Px6XgRTBOK7lok9QK/rB74g=
X-Google-Smtp-Source: AGRyM1taYYdZTeYZFs9uU69Pls+aCryjLMCNzxn06WWd/CQZarw5vW1FnIZNx8zOYBq900QFjdAOXA==
X-Received: by 2002:a17:906:7a0b:b0:722:dac6:a8ff with SMTP id d11-20020a1709067a0b00b00722dac6a8ffmr34185611ejo.593.1657029991286;
        Tue, 05 Jul 2022 07:06:31 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:30 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH 03/13] ARM: dts: qcom: add missing rpm regulators and cells for ipq8064
Date:   Tue,  5 Jul 2022 15:39:07 +0200
Message-Id: <20220705133917.8405-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705133917.8405-1-ansuelsmth@gmail.com>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
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

Add cells definition for rpm node and add missing regulators for the 4
regulator present on ipq8064. There regulators are controlled by rpm and
to correctly works gsbi4_i2c require to be NEVER disabled or rpm will
reject any regulator change request.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 1b4b72723ead..c0b05d2a2d6d 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -844,10 +844,46 @@ rpm: rpm@108000 {
 			clocks = <&gcc RPM_MSG_RAM_H_CLK>;
 			clock-names = "ram";
 
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
 				#clock-cells = <1>;
 			};
+
+			smb208_regulators: regulators {
+				compatible = "qcom,rpm-smb208-regulators";
+				status = "okay";
+
+				smb208_s1a: s1a {
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1150000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+
+				smb208_s1b: s1b {
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1150000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+
+				smb208_s2a: s2a {
+					regulator-min-microvolt = < 800000>;
+					regulator-max-microvolt = <1250000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+
+				smb208_s2b: s2b {
+					regulator-min-microvolt = < 800000>;
+					regulator-max-microvolt = <1250000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+			};
 		};
 
 		tcsr: syscon@1a400000 {
-- 
2.36.1

