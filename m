Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44702588831
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiHCHqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiHCHqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:46:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E4B27B39;
        Wed,  3 Aug 2022 00:46:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z16so20443691wrh.12;
        Wed, 03 Aug 2022 00:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I336059hUhtPeHDoaaIpuKg419qdPUulZW8pRMrdOCQ=;
        b=hPMDk+B5MFdjHfySxJPi1wx5TbVV3Cg2LAHwgl8y+kFWBK3kx4OVXKMEfAPg/SG5fm
         bVeHg9ugxTLs6J7JBoBMb56XRytLK7kSMD1EhlmHDq32T5+CrNkNvldo+xcUohx5yIty
         0Lqth9AEx3oHB9zCHcgK8T4rlT7xD2gXIquz9qiXkI9wNU1fXXql6ns8yA8QNi8LOpAi
         LPfr301OCZ4+rVfDD/2N4xK2B/xiK2JzZyMMyz5KFPa1U/ZlXSRIzdbgT0h9pm01ZT3C
         QiXkWnYx1WEt2VLg4KNbUI3f5gIBynsNCAa9AuwPM+NdoZLWygw/E/xh9FTxrY/0uutn
         SVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I336059hUhtPeHDoaaIpuKg419qdPUulZW8pRMrdOCQ=;
        b=a5kAAppQQyv6dfuYXbJHw8E6w4WF0APZrDnfPm35rBgN753S7784p+5jAraCtHNh11
         KSgaOSvXjha18I2UHwIAB1SLNNYLVyswrbPyWmqBaxNMhdCbaGCAhmki1FMup4ELtuxe
         SPW7KTySvs/TGRsBdxATtrdeQGZyc2q7g/ukx4MoQJBk0yr4zDa7T3slXhwELGhJV5LW
         ynVnYdYYZRBmV7cawzciOdJH2xlzatYnXOuAgtMRbQh3eGpBwdi/XIxxcu7nxUooG/fH
         C4skOnwMPy8lwGnf3rlVJuNdj+3rZIXiQ+hLIiZv3KUeRIo8UYuzZYQdF/3PwYznXjyZ
         mfDw==
X-Gm-Message-State: ACgBeo1REyEAZ4SERYGdRpmZjOWUu/mnis1LhvLzUSORC8Rcsv8yHvdQ
        ICJZt2J6u4M0Gt1f/cP9xGjIclb3HLUE2w==
X-Google-Smtp-Source: AA6agR5XPSD6S7JLAYUPl8iTo8MWqmsqnxkKHS6mEj8TlHgabno488AXSIhpWEyr0e3/9tdx6QbdMw==
X-Received: by 2002:a05:6000:1a8e:b0:21d:a7a8:54f4 with SMTP id f14-20020a0560001a8e00b0021da7a854f4mr15376651wry.654.1659512797152;
        Wed, 03 Aug 2022 00:46:37 -0700 (PDT)
Received: from ainazi.fritz.box (p200300d09706d9000384b2cb471c28f8.dip0.t-ipconnect.de. [2003:d0:9706:d900:384:b2cb:471c:28f8])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003a4c6e67f01sm1505065wmz.6.2022.08.03.00.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 00:46:36 -0700 (PDT)
From:   Shinjo Park <peremen@gmail.com>
Cc:     peremen@gmail.com, David Heidelberg <david@ixit.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] ARM: dts: qcom: msm8960: add the device node of USB1
Date:   Wed,  3 Aug 2022 09:46:08 +0200
Message-Id: <20220803074608.21048-1-peremen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2654048.mvXUDI8C0e@ainazi>
References: <2654048.mvXUDI8C0e@ainazi>
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

v3:
 - Include missing clock/qcom,lcc-msm8960.h to make cleanly applicable

v2:
 - Rewrite commit message
 - Reorder status line

 arch/arm/boot/dts/qcom-msm8960.dtsi | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index e14e1c5d1..0e099aa7c 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -3,6 +3,8 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+#include <dt-bindings/clock/qcom,lcc-msm8960.h>
+#include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/mfd/qcom-rpm.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 
@@ -167,6 +169,37 @@ regulators {
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

