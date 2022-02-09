Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4BE4AF6F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbiBIQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbiBIQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:39:53 -0500
Received: from fwd1.porkbun.com (fwd1.porkbun.com [52.10.174.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8457C0612BE;
        Wed,  9 Feb 2022 08:39:56 -0800 (PST)
Received: by fwd1.porkbun.com (Postfix, from userid 497)
        id 78B7C429CD; Wed,  9 Feb 2022 16:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1644424796;
        bh=ooNj/8suxQGCS+iG0qUYChLq9ehXfq6KW/VZ9iEQVtM=;
        h=From:To:Cc:Subject:Date;
        b=m2Mzvb3yBRtES/mr4zsa1QF5lj5mhZS1V0C6oe92XDpcv5MPqBz/vU8gOtlrbORKR
         Tt0RqZoBdYPdmZsDUpBxIPYrE5UnfhCnMpsu6k89T+MgqUrwY6FVkrIoJVnMoPveiy
         8vYKvLi8nSFutE0FplWcPfZ3ZRuUbp7VUV9dmiNM=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
Received: from rayyan-pc.. (unknown [90.242.138.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: rayyan@ansari.sh)
        by fwd1.porkbun.com (Postfix) with ESMTPSA id B8E4D41C54;
        Wed,  9 Feb 2022 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1644424781;
        bh=ooNj/8suxQGCS+iG0qUYChLq9ehXfq6KW/VZ9iEQVtM=;
        h=From:To:Cc:Subject:Date;
        b=ZM0LJZsYefdS00PyYlDAREOJZ+oo2lgbvjHxMsfx6vGyauOZP0s8MW22WeUp9KIBg
         WPohoiTLEsz9SvHvTuB24ydfECHae4XNrRHeJsHRTEYFIdZRWdQ1M+5X0num9UF2ap
         7u+fgkXSA0MqW4/hGjzKg4plnyZ1S8+ZMuGshFsg=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: qcom: pm8226: Add VADC node
Date:   Wed,  9 Feb 2022 16:38:40 +0000
Message-Id: <20220209163841.7360-1-rayyan@ansari.sh>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the voltage ADC (VADC) found in PM8226.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index b3d0f7b5874d..5e07f34e4ec4 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
 
 &spmi_bus {
 	pm8226_0: pm8226@0 {
@@ -40,6 +41,39 @@ smbb: charger@1000 {
 			chg_otg: otg-vbus { };
 		};
 
+		pm8226_vadc: adc@3100 {
+			compatible = "qcom,spmi-vadc";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			adc-chan@7 {
+				reg = <VADC_VSYS>;
+				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
+			};
+			adc-chan@8 {
+				reg = <VADC_DIE_TEMP>;
+				label = "die_temp";
+			};
+			adc-chan@9 {
+				reg = <VADC_REF_625MV>;
+				label = "ref_625mv";
+			};
+			adc-chan@a {
+				reg = <VADC_REF_1250MV>;
+				label = "ref_1250mv";
+			};
+			adc-chan@e {
+				reg = <VADC_GND_REF>;
+			};
+			adc-chan@f {
+				reg = <VADC_VDD_VADC>;
+			};
+		};
+
 		pm8226_mpps: mpps@a000 {
 			compatible = "qcom,pm8226-mpp", "qcom,spmi-mpp";
 			reg = <0xa000>;
-- 
2.34.1

