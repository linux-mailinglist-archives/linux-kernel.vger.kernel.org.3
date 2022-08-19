Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B3B59974E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347585AbiHSIdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346719AbiHSIcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D43E9AA2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:30 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d23so865388lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nR+TfTCxfwnZ0rpriGE1cYNwcjlY22/4IV6KiuLJyUA=;
        b=qWxpF6hFApW+kugscYVZOXUTnHoiBN8s32bAEQQdloNlE2m/km+jumHc9TS+vUlDEb
         R380ExFQFz7T3W23cCMPgQ+iH4vPNAMTredFdX9PcQDEfaT7t9990KPNJehOwHbqj12t
         HQabq9i8SDjuwwh9rw6yAJjtmcR4qMdmIC5N5fbH00cxQhmk9lGIOZ8UEZyaGWLuGwYL
         QTkNl+Nmd2dGzeTnXGZts8vWADoph1oMiXF02LAKcZxl/31vJ3nsYwsVYOH+8TO2drEr
         +CFr/WtZXya4le2wVu7FLKqhi315bTmUwbmtVAcJR/Dlh/e6iTO6JOVOJw5/0FHZVlrA
         K2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nR+TfTCxfwnZ0rpriGE1cYNwcjlY22/4IV6KiuLJyUA=;
        b=V/e3sIvUIs7TiTgpN0SuGu1JdeZGLv78mpSg8guFyAyKUkiq8ii0TQQY+8ZSLhYpNM
         67rF8NbvAXTclY/9n5RPkMqypH0j05gdBLmOVNlUN8MBVPeZtzZh0xlhnx20MeUMsbCR
         hGX8EPOV8FXsHrxiL4vDMMKAXttCoJMLoJU4LswE3BRWdoNQDIEcj60rH0Fgx08wgDhS
         YQ7UbFrub0xGJ2e33yAVsnxsUlYUpQj7Zg2AqQznWeGEvwa2qjEDNrqOOP88CaOiMkqH
         FJ5q4qP6bx62jBcGuORitdEbvR9NCrKEPVrInIz6GUScq8mOn4gA1sBAStwAtCoELYOA
         6qlg==
X-Gm-Message-State: ACgBeo1N7xk61ovnHcInX+xVqPi/unBNqbI9Gk2jBA5h80h9nAS5WmkI
        u3O4g/5OdCduZJbMa9ZbQw60Bw==
X-Google-Smtp-Source: AA6agR4K4pT+dAmoviSKHdNtbVIjG/ib3kJ7FVBQIXjODSWNhzjCrASZVBi9CHFQilZWCaeXGrKxmA==
X-Received: by 2002:a05:6512:e99:b0:492:cf19:875 with SMTP id bi25-20020a0565120e9900b00492cf190875mr92408lfb.690.1660897950192;
        Fri, 19 Aug 2022 01:32:30 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 12/16] arm64: dts: qcom: qcs404: switch TCSR mutex to MMIO
Date:   Fri, 19 Aug 2022 11:32:05 +0300
Message-Id: <20220819083209.50844-13-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
References: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCSR mutex bindings allow device to be described only with address
space (so it uses MMIO, not syscon regmap).  This seems reasonable as
TCSR mutex is actually a dedicated IO address space and it also fixes DT
schema checks:

  qcom/qcs404-evb-4000.dtb: hwlock: 'reg' is a required property
  qcom/qcs404-evb-4000.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9ab990061522..3a94eb2cc448 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -295,12 +295,6 @@ smem {
 		hwlocks = <&tcsr_mutex 3>;
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x1000>;
-		#hwlock-cells = <1>;
-	};
-
 	soc: soc@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -726,9 +720,10 @@ gcc: clock-controller@1800000 {
 			assigned-clock-rates = <19200000>;
 		};
 
-		tcsr_mutex_regs: syscon@1905000 {
-			compatible = "syscon";
+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,tcsr-mutex";
 			reg = <0x01905000 0x20000>;
+			#hwlock-cells = <1>;
 		};
 
 		tcsr: syscon@1937000 {
-- 
2.34.1

