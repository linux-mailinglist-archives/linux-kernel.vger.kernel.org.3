Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E269585916
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiG3IOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 04:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiG3IOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 04:14:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B1D32D8D;
        Sat, 30 Jul 2022 01:14:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o13so8253259edc.0;
        Sat, 30 Jul 2022 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PsLPNnKs6iTnC1do3IWMEO8a4UGkJ3BffVfJlY4cSQ=;
        b=oiQ75bJfuXDStnvurdOtLrtgayWaHMYfM65teAR6eLIaMTEqpRLZi9BpYwyZMDvPfO
         tz9YUP9mrDbkSDQaw9iG72qgbmnGopNHTq/fKEO7mjyPaGckBEUYLWkE5LtoN4tJ/r+1
         P/SYumcKSe+3hf0JqlU66c4T7Vd7PyOOAugdY8kcI1qcvrbUNRBkEvMx6Mj0+mTYR7Ii
         6qm2skUkol8/95WiyJYgDVW5lloLUbaHdiziASgcDVqfqnrnYwFQwWsc/AHH3890j4z1
         f5/6/5J/UG0Oszxp7pzBc4P1mvLuKBpTPUc5ChxpV0NeYribet+W7Y5t9uCAOzn2lMXu
         Md0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PsLPNnKs6iTnC1do3IWMEO8a4UGkJ3BffVfJlY4cSQ=;
        b=m5ISUJQEXfxleFJpGaQnPipqHXnv0TAWbRoLUPxUp3lfSIRI19jNK78JkNn5HKwXwD
         AE2P/a9+YL2rZLTtnh6IVySEF+rpiZ5xiloZ93uqY1AYZN1WGKNo2jF2NuRst8MJ19Ec
         5RV2SkhGb4E6qFFsjRrgMIGUH1EqNQVrth3QQK0bvQQ6miN6j9iTb4xymWbTec5/9E4z
         VVH5zRWZnIxkJDhCPYCv/l7oz36RQ80BvNwOIusBQSHlrJAmbneiAnWFYvcaPbi5IqnL
         iZxfRd+G0v0gms0ApwMNKL/vsxAPUpUIJhhBRss5j02AQqmo34aQbUJL/x3rRiBd70Mo
         n+RQ==
X-Gm-Message-State: ACgBeo3OIWU+7nKQHMQmn6SsquXXgeGUVAzEABaMjOr4rc2ENq/PjkAK
        M8X6RWQS5U0bD6EdZEIlWy8=
X-Google-Smtp-Source: AA6agR6t+zre459vkhTc2LeCF987lVWwFc7CD+Bbj33yYWqgkDTS73qkQzGJDz10yr7alXluxU9+eg==
X-Received: by 2002:aa7:cf13:0:b0:43d:603a:b736 with SMTP id a19-20020aa7cf13000000b0043d603ab736mr742196edy.20.1659168876936;
        Sat, 30 Jul 2022 01:14:36 -0700 (PDT)
Received: from ainazi.fritz.box (p200300d09725550031ca3b9b629d79a8.dip0.t-ipconnect.de. [2003:d0:9725:5500:31ca:3b9b:629d:79a8])
        by smtp.gmail.com with ESMTPSA id u6-20020aa7d986000000b0043bb8023caesm3532584eds.62.2022.07.30.01.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 01:14:36 -0700 (PDT)
From:   Shinjo Park <peremen@gmail.com>
Cc:     peremen@gmail.com, David Heidelberg <david@ixit.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ARM: dts: qcom: msm8960: add the device node of USB1
Date:   Sat, 30 Jul 2022 10:14:12 +0200
Message-Id: <20220730081412.14297-1-peremen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <76ed8999-c211-f8ea-c70c-21fddd75a896@linaro.org>
References: <76ed8999-c211-f8ea-c70c-21fddd75a896@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the same USB definition as qcom-apq8064.dtsi, tested on Casio GzOne.

Signed-off-by: Shinjo Park <peremen@gmail.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
---

v2:
 - Rewrite commit message
 - Reorder status line

 arch/arm/boot/dts/qcom-msm8960.dtsi | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index e1f010c9643e..4c8a67c0cc7b 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,lcc-msm8960.h>
+#include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/mfd/qcom-rpm.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 
@@ -201,6 +202,37 @@ regulators {
 			};
 		};
 
+		usb1: usb@12500000 {
+			compatible = "qcom,ci-hdrc";
+			reg = <0x12500000 0x200>,
+			      <0x12500200 0x200>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc USB_HS1_XCVR_CLK>, <&gcc USB_HS1_H_CLK>;
+			clock-names = "core", "iface";
+			assigned-clocks = <&gcc USB_HS1_XCVR_CLK>;
+			assigned-clock-rates = <60000000>;
+			resets = <&gcc USB_HS1_RESET>;
+			reset-names = "core";
+			phy_type = "ulpi";
+			ahb-burst-config = <0>;
+			phys = <&usb_hs1_phy>;
+			phy-names = "usb-phy";
+			#reset-cells = <1>;
+			status = "disabled";
+
+			ulpi {
+				usb_hs1_phy: phy {
+					compatible = "qcom,usb-hs-phy-msm8960",
+						     "qcom,usb-hs-phy";
+					clocks = <&sleep_clk>, <&cxo_board>;
+					clock-names = "sleep", "ref";
+					resets = <&usb1 0>;
+					reset-names = "por";
+					#phy-cells = <0>;
+				};
+			};
+		};
+
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
-- 
2.34.1

