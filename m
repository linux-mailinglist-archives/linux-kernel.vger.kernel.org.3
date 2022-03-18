Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143944DE13A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbiCRSll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbiCRSlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:41:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AB71C9476
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:40:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u23so9089164ejt.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P4Kb7KaG4SHKOCFmSwuaetu2AmaYDmmzIQaLbfYBkIY=;
        b=khW7ecMgr9h4H/gr4OgaENPoHbpSHHEj1C/BNSaVNLNGuXrbcCfKvPaEOnFIhi3BiN
         KgjUGHKS3nLlRPy1UNdsjZem+ivw2/bPvwr49oPntThlPHwZ9Dv0C/LQv9Qk2pggyuDw
         Ej5XK1I5fwSl0GQvCZgGzihqUaq/4ffXqe0ryRKQR8B1dBzg5Fqr0eBlJquH/NWkNLv8
         ul1DMoGZP80bxYuQlze27VobUDWdLdIXQY7mkFw604w36Td8oAxgN8vdVIRv0DUsWKgM
         Q+JpcVY9ASB/PA03atBRa4gF3GvZX6poK5dtO9nlZbHqHZMuF7YxZjt48MSVC8pjYw2H
         RkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P4Kb7KaG4SHKOCFmSwuaetu2AmaYDmmzIQaLbfYBkIY=;
        b=d7FIanExCesGdcFNxp+4lIimuT8gtIRjJBlY6Fx4DCca651wEyNiSNR/iyrEaTEZmk
         g2Ch7K4Bi+2sIDYnLRRUFqI+tXl7innsfqIoqA9YaWcqxoUHkD+sIAlqXSNlSftVspp0
         XwUk1ydT6YVLwIcdcgkqmv5kwn79ZqLpA3Pw+FJ2r7w9G4o779dImmT1d8zEWfJ0xoMa
         rz4RDuBDolhYG9Y1EVmOipZcF/EJp4Z5cZRYLAYtarx1FRvhF6LWU/RCF4jXcPIRDOPi
         ZqE8UWNufSsmLL+AX71Rm9xgyYI1sw6X/neQdZ4pnFMGPRPJtBtbRN4M7Z67wPuhnaHH
         tCXg==
X-Gm-Message-State: AOAM531ysoke3s8+N9NtsUL9Kev40MD6K1k5sCdPAi6sU0mI68J1tdSF
        +CyGGbt2dpkEkuFUW423VvfkXJhN3im00w==
X-Google-Smtp-Source: ABdhPJxpB6DPIeEcuQfFinBQN+TQE1Hym0owqp3TwkL7NdBZRGAoJycH2zYgj3jo17Ndq189KG+jIQ==
X-Received: by 2002:a05:6402:1912:b0:418:cd23:3742 with SMTP id e18-20020a056402191200b00418cd233742mr10821976edz.412.1647628230716;
        Fri, 18 Mar 2022 11:30:30 -0700 (PDT)
Received: from otso.arnhem.chello.nl (a246182.upc-a.chello.nl. [62.163.246.182])
        by smtp.gmail.com with ESMTPSA id y8-20020a50eb08000000b00418b114469csm4567551edp.52.2022.03.18.11.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:30:30 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: qcom: sm6350: Add UFS nodes
Date:   Fri, 18 Mar 2022 19:30:03 +0100
Message-Id: <20220318183004.858707-6-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318183004.858707-1-luca.weiss@fairphone.com>
References: <20220318183004.858707-1-luca.weiss@fairphone.com>
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

Add the necessary nodes for UFS and its PHY.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 79 ++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index d7c9edff19f7..c5c93b6bcd2a 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -541,6 +541,85 @@ uart2: serial@98c000 {
 			};
 		};
 
+		ufs_mem_hc: ufshc@1d84000 {
+			compatible = "qcom,sm6350-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0 0x01d84000 0 0x3000>,
+			      <0 0x01d90000 0 0x8000>;
+			reg-names = "std", "ice";
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufs_mem_phy_lanes>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			#reset-cells = <1>;
+			resets = <&gcc GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
+			iommus = <&apps_smmu 0x80 0x0>;
+
+			clock-names =
+				"core_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro",
+				"core_clk_ice",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk",
+				"rx_lane1_sync_clk";
+			clocks =
+				<&gcc GCC_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_UFS_PHY_AHB_CLK>,
+				<&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>,
+				<&rpmhcc RPMH_QLINK_CLK>,
+				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+			freq-table-hz =
+				<50000000 200000000>,
+				<0 0>,
+				<0 0>,
+				<37500000 150000000>,
+				<75000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+
+			status = "disabled";
+		};
+
+		ufs_mem_phy: phy@1d87000 {
+			compatible = "qcom,sm6350-qmp-ufs-phy";
+			reg = <0 0x01d87000 0 0x18c>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clock-names = "ref",
+				      "ref_aux";
+			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
+
+			status = "disabled";
+
+			ufs_mem_phy_lanes: phy@1d87400 {
+				reg = <0 0x01d87400 0 0x128>,
+				      <0 0x01d87600 0 0x1fc>,
+				      <0 0x01d87c00 0 0x1dc>,
+				      <0 0x01d87800 0 0x128>,
+				      <0 0x01d87a00 0 0x1fc>;
+				#phy-cells = <0>;
+			};
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
-- 
2.35.1

