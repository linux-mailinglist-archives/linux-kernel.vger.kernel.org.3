Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA325A9029
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiIAH0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbiIAHZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:25:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E52EE682;
        Thu,  1 Sep 2022 00:24:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k9so21142447wri.0;
        Thu, 01 Sep 2022 00:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AJIl6VqM6vm5p4ptSn3Po2SC4HiT/nr8TjK5PxWJm7k=;
        b=cSy+zrsc4YEnxJV0s5BprZJI+o107Ym8i1qu/dP9/7A4iLQ9+UFHBTDVKr2HMgAjOK
         mmuBR9kMNbfuGaTwO8oknMocwEMAkAgw6V+5YgSsKmq57Pfn/AZeYi0vNyYNi6K9SaoU
         IWy1ThCLfswjjHqBdSwKf+53HPRGu607i9zjWDPQ6zXALpLlRfaHBwER6+KTBkCuzty+
         g8va4s1L8VgjAurdsSO++6C/J9k3r/NJ5slDIY6K62oz3wJHKf5lS3nMIYFe5zlnGZHA
         j+u5KZydLZ+YEbdSENqcDQ1rj/Cu+caS0rm0aO/+54Vz78hfk0UGzPvn67b9mc263Rbk
         8nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AJIl6VqM6vm5p4ptSn3Po2SC4HiT/nr8TjK5PxWJm7k=;
        b=KdLz95D1dlyQZiTXLwHIcR9NUWZQny1xu6HgmcLrYIAcQhXFFOv/A+ApIHqD4PRpgE
         XR/VtuDBKIZUyP2XrTPr+GG2JYlv+UAuhLyG2dEVhJUFnPHkzH7ncF7dDukdCzVhJI/e
         LFMq5f2smLjZRCj4hoOkMO1nR9aCYgPfsT7M6SyFEmQkzzg12dEp8vjIuSHw95oJ5sfw
         SB65QFRjZMQw+CKrNyovfQfHpCyPzZDv9pDDRpYd3HpzzVgt7vhuePqkye7feVZD7Yuy
         tQA+2LJHjgHCizVRNG06l1V2ZrzmtLsTNBIOvGKsOnAoYiJ3mY4HVy5JJnMlda+fpcw0
         6Sqw==
X-Gm-Message-State: ACgBeo1e51A6TriWgzODGViFjcKYiY0FYkdCZHLVSRx7DnZcoFG4YK3S
        aAobzKI6NNNP/oVydQkNtQQGxL32K3Q=
X-Google-Smtp-Source: AA6agR6oPH0gDeYcI23+iNP2rV+AY81gBxl/nar4+wjtrHkZf0RNiQOcVGgLXVfp78pxJhrIUlG12w==
X-Received: by 2002:a05:6000:258:b0:226:dc6e:9ef8 with SMTP id m24-20020a056000025800b00226dc6e9ef8mr9180591wrz.215.1662017079326;
        Thu, 01 Sep 2022 00:24:39 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c4ecd00b003a4c6e67f01sm5317127wmq.6.2022.09.01.00.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:24:38 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] arm64: dts: qcom: sm6115: Add usb and related phy nodes
Date:   Thu,  1 Sep 2022 10:24:05 +0300
Message-Id: <20220901072414.1923075-7-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
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

Add support for the USB controller and its HS PHY to SM6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 62 ++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index a6be8b93a44d..00fd185c87aa 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -412,6 +412,21 @@ gcc: clock-controller@1400000 {
 			#power-domain-cells = <1>;
 		};
 
+		hsusb_phy: phy@1613000 {
+			compatible = "qcom,sm6115-qusb2-phy";
+			reg = <0x1613000 0x180>;
+			#phy-cells = <0>;
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_AHB2PHY_USB_CLK>;
+			clock-names = "ref", "cfg_ahb";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+			nvmem-cells = <&qusb2_hstx_trim>;
+
+			status = "disabled";
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,qfprom";
 			reg = <0x1b40000 0x7000>;
@@ -434,6 +449,53 @@ rpm_msg_ram: memory@45f0000 {
 			reg = <0x45f0000 0x7000>;
 		};
 
+		usb3: usb@4ef8800 {
+			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
+			reg = <0x04ef8800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_SYS_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
+				      "sleep", "xo";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <66666667>;
+
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
+			qcom,select-utmi-as-pipe-clk;
+			status = "disabled";
+
+			usb3_dwc3: dwc3@4e00000 {
+				compatible = "snps,dwc3";
+				reg = <0x04e00000 0xcd00>;
+				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&hsusb_phy>;
+				phy-names = "usb2-phy";
+				iommus = <&apps_smmu 0x120 0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				snps,has-lpm-erratum;
+				snps,hird-threshold = /bits/ 8 <0x10>;
+				snps,usb3_lpm_capable;
+				imod-interval-ns = <160>;
+				maximum-speed = "high-speed";
+				dr_mode = "peripheral";
+			};
+		};
+
 		apps_smmu: iommu@c600000 {
 			compatible = "qcom,sm6115-smmu-500", "arm,mmu-500";
 			reg = <0xc600000 0x80000>;
-- 
2.37.2

