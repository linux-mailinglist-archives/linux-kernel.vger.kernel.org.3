Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5583E503632
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 13:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiDPLID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 07:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiDPLHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 07:07:47 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA6B5F7A;
        Sat, 16 Apr 2022 04:05:15 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a186so5443036qkc.10;
        Sat, 16 Apr 2022 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqOtlYyePRN/r4aPym/C6r8euVVGX9fSqK0zMFP5Scg=;
        b=Ay1l2u7NSquF+9PFgxtbeBqNLhrl/1lHtqjekfmK+9qQ/SzNzdamOekZ0caVKln0z9
         GEWVMDqegY3wwkydYjmptujbX7Xomb9wkwHuDaH+i9bwlKhnr6VAKR0dFP5GIlbhjqbt
         JWM0zCBy8cF/YHITuVC7cU2pH5pC3Kojg7wLJf3scsmrGUimgssZ5bE0CeR02TqF4sVk
         pyH/jQoA1B0pG/DLmymtXOuPJaSK1MGmV8rQsukr5eFkGMcJ0xJmbqWHuOrzFWw3Ld99
         yPRbBFr6DkgV5xZBbab+kqen3JiTg0qyRNl8Gcc9YoQ8PJfjuCkdihuwQlFQyijn/NHs
         K6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqOtlYyePRN/r4aPym/C6r8euVVGX9fSqK0zMFP5Scg=;
        b=RJDtVmHhHLG1m1hA+jA3EgAEtqQ4VorFobrpo+fHgnbi0zwEA5IBG/I0jb7QtAmRF+
         1bkL0guN5dVk3hM2PsO+OZ3hvcuA3mVs5putnqRMjLSE/a8Wu7lhFY+/Dx8pRFRpMtCu
         MBj5t8u3bsl3z9/y+gOxaITNzkkGaTqemd+JuPyNdGpqq2qVCCGyYxpDvBPV1hJ9yUF4
         5IogJ1BQn8sDXEsYWB1qdLvMYd8aPeFST+Pcb7lLps2QPMLufHKzY/9gdsRzb6AaZW5p
         Wh23d4FeJB/DRwmYtuwzrVmKLmDBO9f8DDNDm0liHlO595FwRXOlt219xCRoL0h44v6T
         jTtQ==
X-Gm-Message-State: AOAM531a/FqaA2U7XvPnoA4++1h+vGK5CU0CPjgWT/GNsC88AFT1i+NP
        ZIfaFK+RffcwJePqHxvDXNE=
X-Google-Smtp-Source: ABdhPJxmwpn+eW8bdaz975hRwX2JS+73deqtcOTIOVPwSnY4StdJw+G5r+6cVfuDeQ6dNs7KIKgE9Q==
X-Received: by 2002:a37:ba45:0:b0:69b:e728:34b7 with SMTP id k66-20020a37ba45000000b0069be72834b7mr1656171qkf.606.1650107114886;
        Sat, 16 Apr 2022 04:05:14 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id w6-20020a05622a190600b002f1f91ad3e7sm97026qtc.22.2022.04.16.04.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 04:05:14 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] arm64: dts: rockchip: enable pcie controller on quartz64-a
Date:   Sat, 16 Apr 2022 07:05:06 -0400
Message-Id: <20220416110507.642398-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416110507.642398-1-pgwipeout@gmail.com>
References: <20220416110507.642398-1-pgwipeout@gmail.com>
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

Add the nodes to enable the pcie controller on the quartz64 model a
board.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 141a433429b5..85926d46337d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -125,6 +125,18 @@ vbus: vbus {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
+	vcc3v3_pcie_p: vcc3v3_pcie_p {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_enable_h>;
+		regulator-name = "vcc3v3_pcie_p";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
 	vcc5v0_usb: vcc5v0_usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
@@ -201,6 +213,10 @@ &combphy1 {
 	status = "okay";
 };
 
+&combphy2 {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_cpu>;
 };
@@ -509,6 +525,14 @@ rgmii_phy1: ethernet-phy@0 {
 	};
 };
 
+&pcie2x1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_reset_h>;
+	reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+	vpcie3v3-supply = <&vcc3v3_pcie_p>;
+};
+
 &pinctrl {
 	bt {
 		bt_enable_h: bt-enable-h {
@@ -534,6 +558,16 @@ diy_led_enable_h: diy-led-enable-h {
 		};
 	};
 
+	pcie {
+		pcie_enable_h: pcie-enable-h {
+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie_reset_h: pcie-reset-h {
+			rockchip,pins = <1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.25.1

