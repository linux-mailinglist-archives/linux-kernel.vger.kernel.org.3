Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421CC4CB98E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiCCIuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiCCIt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:49:56 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7373A17585A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:49:09 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id x14so3453920ill.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 00:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31oR/5R8uiOoYLaqojfd9sfVOvx41Qx3BFeK4/Ytd84=;
        b=j5CDqRS3oxPTE35yyFrHx2Y6GB2DlGJtO1iBOz3pvlLX8PTZyPdSu/k/MLAFVdzMdM
         WI9TdX0wk42+MOxOtu4a5Tz8h8cw0KwEDv4EKo5pIzBWME8qpuq6MbGHgKPpeNNbRE77
         9TKifPjcQSQzE+W9OZUSdKgA6FFRCCsXKvU63O2nMiQw248a4c6xQDUeY0MMkBERCopw
         BtfK7bSiJ9jtqkj6DcVbpFE22wS/gbrHcHuZUlUtZX2yo/8axZqS5aeV5waqSET/uOHQ
         7Utib7uaAZUc2eCJhMiVrezn2YYr10VwkBY8JdWuAUpOb5CHIJea6BQ/t6bS6xrOfwWL
         qNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31oR/5R8uiOoYLaqojfd9sfVOvx41Qx3BFeK4/Ytd84=;
        b=Q0wV7ff4kIxZ2HvXW4sj5uZHMEgh3aJsDYe6i0ezWPjFDvHoF+TRWGgoHAVAGHJBnP
         MvfBsxrH9/OCP58tzdwkZdb0cQ40mukH+8p2/iHZnszViwXMdCshtl1eAtjLnWp94q9Z
         bhWf/1WwWqf76w3bLtfNoHo+Sc86EdPKjYMXy6If6uWohgY0uiJUJVWHyHLR9Ev02Oda
         rW63c63mbZDfCy1YU3QYeRdWHDHn6BGhVZA9AQzTRa9WtrF553i5sO/MXUvDKIorhGrj
         YqnjQlTIo4KKVqFSLH6B3MubTQBLmxIV4HPTY+t4X6DUh7E827OjQw4+qjg2SZSHU98f
         +RyQ==
X-Gm-Message-State: AOAM533YJzVz9dt2Vu4ggVGjA/WbZ38bN6tdElULNrV3fE507dxOdKYJ
        CsAHiq+v4kF3z+bTxjG2SHi4nw==
X-Google-Smtp-Source: ABdhPJwPOMyXQ3RYefx6bbUpZKR8O4u9lKzqY1zOzCWZGh6vbFl1jFWIQFFAAaSdqNoF7NR8nEpD4w==
X-Received: by 2002:a05:6e02:15c8:b0:2bd:fdca:18a8 with SMTP id q8-20020a056e0215c800b002bdfdca18a8mr30638024ilu.320.1646297348867;
        Thu, 03 Mar 2022 00:49:08 -0800 (PST)
Received: from localhost.localdomain ([182.64.85.91])
        by smtp.gmail.com with ESMTPSA id m9-20020a923f09000000b002c2a1a3a888sm1480704ila.50.2022.03.03.00.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 00:49:08 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, tdas@codeaurora.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 6/6] arm64: dts: qcom: sa8155p-adp: Enable ethernet node
Date:   Thu,  3 Mar 2022 14:18:24 +0530
Message-Id: <20220303084824.284946-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303084824.284946-1-bhupesh.sharma@linaro.org>
References: <20220303084824.284946-1-bhupesh.sharma@linaro.org>
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

From: Vinod Koul <vkoul@kernel.org>

Enable the etheret node, add the phy node and pinctrl for ethernet.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[bhsharma: Correct ethernet/rgmii related pinmuxs, specify multi-queues and
 plug in the PHY interrupt for WOL]
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 144 +++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 8756c2b25c7e..474f688f14a2 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -47,6 +47,65 @@ vreg_s4a_1p8: smps4 {
 
 		vin-supply = <&vreg_3p3>;
 	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xC>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+		snps,tx-sched-wrr;
+
+		queue0 {
+			snps,weight = <0x10>;
+			snps,dcb-algorithm;
+			snps,priority = <0x0>;
+		};
+
+		queue1 {
+			snps,weight = <0x11>;
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+
+		queue2 {
+			snps,weight = <0x12>;
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+
+		queue3 {
+			snps,weight = <0x13>;
+			snps,dcb-algorithm;
+			snps,priority = <0x3>;
+		};
+	};
 };
 
 &apps_rsc {
@@ -317,6 +376,42 @@ &remoteproc_cdsp {
 	firmware-name = "qcom/sa8155p/cdsp.mdt";
 };
 
+&ethernet {
+	status = "okay";
+
+	snps,reset-gpio = <&tlmm 79 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 11000 70000>;
+
+	snps,ptp-ref-clk-rate = <250000000>;
+	snps,ptp-req-clk-rate = <96000000>;
+
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet_defaults>;
+
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii";
+	mdio {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		compatible = "snps,dwmac-mdio";
+
+		/* Micrel KSZ9031RNZ PHY */
+		rgmii_phy: phy@7 {
+			reg = <0x7>;
+
+			interrupt-parent = <&tlmm>;
+			interrupts-extended = <&tlmm 124 IRQ_TYPE_EDGE_FALLING>; /* phy intr */
+			device_type = "ethernet-phy";
+			compatible = "ethernet-phy-ieee802.3-c22";
+		};
+	};
+};
+
 &uart2 {
 	status = "okay";
 };
@@ -407,4 +502,53 @@ mux {
 			drive-strength = <2>;
 		};
 	};
+
+	ethernet_defaults: ethernet-defaults {
+		mdc {
+			pins = "gpio7";
+			function = "rgmii";
+			bias-pull-up;
+		};
+
+		mdio {
+			pins = "gpio59";
+			function = "rgmii";
+			bias-pull-up;
+		};
+
+		rgmii-rx {
+			pins = "gpio117", "gpio118", "gpio119", "gpio120", "gpio115", "gpio116";
+			function = "rgmii";
+			bias-disable;
+			drive-strength = <2>;
+		};
+
+		rgmii-tx {
+			pins = "gpio122", "gpio4", "gpio5", "gpio6", "gpio114", "gpio121";
+			function = "rgmii";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+
+		phy-intr {
+			pins = "gpio124";
+			function = "emac_phy";
+			bias-disable;
+			drive-strength = <8>;
+		};
+
+		pps {
+			pins = "gpio81";
+			function = "emac_pps";
+			bias-disable;
+			drive-strength = <8>;
+		};
+
+		phy-reset {
+			pins = "gpio79";
+			function = "gpio";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+	};
 };
-- 
2.35.1

