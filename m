Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849FF5AAD34
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiIBLLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbiIBLLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:11:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE0A9E2C0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 04:11:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qh18so3151110ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 04:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pgosDup0kTlaT74lXGXfgBHrhkiJ9yYENuHZSc/mVk8=;
        b=UXEiCDwktlEbe9re+UzPAG6MLdZSfmqVtt7UKc7uT49N+0SqZ4AzoZ5rwbEOOYcxVv
         RdBHvr6btdgBKYF6tR98Q5kjVVHl96NQGVqC3Wm7yVajTNVBPF5p1rm5c+dDgrUW66cq
         jZqvyCGabdeo5d1l4dVvdrGIUQE4ZU6ZDxCNy8amoXBpoR3ii+obhv4XTdmS806BcCJb
         Uj9yCcoLtTLfoCIW+rMbetJDpqVnpI3no+jWCWVh1sJnI1WvOoMZOY/plMyzoJzIczIC
         Kjt8gGN2/YhPZ9RwvMW+mDeoPeP9Dx36PMq6j9ZA8+tNW2wCfX7EIOvX+4p6XXSoPtw0
         YOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pgosDup0kTlaT74lXGXfgBHrhkiJ9yYENuHZSc/mVk8=;
        b=2BpSd3OarwksmlzlDgmPszH15XGHb1AGE704jOBKWE5NLq/kBNx9M75grsca5tr4p4
         uuOlnPvVQeQXhvWarJRNVWU2Tfls6wTRSS09tcj8WaXR3j1ebb0wUfe8bxoPeEBSM7Fk
         Zjdrqc87Z97AD9pmVi7eKRHWT/ORu/SG8MZzDl29AYmBQdmnLiwdUceSEvtPp7T8oWOH
         WXpPNxI3vJyvo9P3BHmXv3pdwqdIFTxgkRPWXG9bJXHVOo5nDx2axFws+WSz5Z56QkTd
         163sH7oWk04uGy/2GBAWMwUfKXbUPXdcm+8IGSIV9/NBxG7zNFtBX/JpmMGMIteWnRFJ
         UYXA==
X-Gm-Message-State: ACgBeo1HKZWUqaRsJqcyWDRX+3Jp78u3750BDacK/4yRCKnwVLKoHNUR
        PSvzKjuWLVqX1YQRvbjHN+wHNQ==
X-Google-Smtp-Source: AA6agR5uv6ZSUD5tOWHQmTksHQW9QBLDMjkC2uPD+MejoEgEQqO1CQKQSv2GOloq0ImI0WeYP0LNYw==
X-Received: by 2002:a17:907:70b:b0:740:ef93:2ffb with SMTP id xb11-20020a170907070b00b00740ef932ffbmr21896909ejb.93.1662117065962;
        Fri, 02 Sep 2022 04:11:05 -0700 (PDT)
Received: from otso.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl. [31.151.115.246])
        by smtp.gmail.com with ESMTPSA id h1-20020a50cdc1000000b004483624d550sm1245624edj.71.2022.09.02.04.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 04:11:05 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: Add pm7250b PMIC
Date:   Fri,  2 Sep 2022 13:10:54 +0200
Message-Id: <20220902111055.106814-2-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902111055.106814-1-luca.weiss@fairphone.com>
References: <20220902111055.106814-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM7250B is a PMIC primarily used for charging and fuel gauge but also
has some of the standard functionality like temp-alarm, adc, etc.

Add the .dtsi with some of the functionality added.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm7250b.dtsi | 149 ++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm7250b.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
new file mode 100644
index 000000000000..61f7a6345150
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pm7250b-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm7250b_temp>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <145000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+	pmic@2 {
+		compatible = "qcom,pm7250b", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm7250b_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x2 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			io-channels = <&pm7250b_adc ADC5_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm7250b_adc: adc@3100 {
+			compatible = "qcom,spmi-adc5";
+			reg = <0x3100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+			adc-chan@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			adc-chan@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
+			};
+
+			adc-chan@2 {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
+			};
+
+			adc-chan@7 {
+				reg = <ADC5_USB_IN_I>;
+				qcom,pre-scaling = <1 1>;
+				label = "usb_in_i_uv";
+			};
+
+			adc-chan@8 {
+				reg = <ADC5_USB_IN_V_16>;
+				qcom,pre-scaling = <1 16>;
+				label = "usb_in_v_div_16";
+			};
+
+			adc-chan@9 {
+				reg = <ADC5_CHG_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "chg_temp";
+			};
+
+			adc-chan@e {
+				reg = <ADC5_AMUX_THM2>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				label = "smb1390_therm";
+			};
+
+			adc-chan@1e {
+				reg = <ADC5_MID_CHG_DIV6>;
+				qcom,pre-scaling = <1 6>;
+				label = "chg_mid";
+			};
+
+			adc-chan@83 {
+				reg = <ADC5_VPH_PWR>;
+				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
+			};
+
+			adc-chan@84 {
+				reg = <ADC5_VBAT_SNS>;
+				qcom,pre-scaling = <1 3>;
+				label = "vbat_sns";
+			};
+
+			adc-chan@99 {
+				reg = <ADC5_SBUx>;
+				qcom,pre-scaling = <1 3>;
+				label = "chg_sbux";
+			};
+		};
+
+		pm7250b_adc_tm: adc-tm@3500 {
+			compatible = "qcom,spmi-adc-tm5";
+			reg = <0x3500>;
+			interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+	};
+
+	pmic@3 {
+		compatible = "qcom,pm7250b", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
2.37.3

