Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEA75A9033
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiIAH0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiIAHZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:25:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F5E51;
        Thu,  1 Sep 2022 00:24:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id az27so21107512wrb.6;
        Thu, 01 Sep 2022 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=W4sHhBFT7l0RZw3UjJyqKYPr5puCq7omf6aKnnWND30=;
        b=JQZZvUi6O0ekBj3q+z2Stpq3f90RJSDx3xoOvdXfAF8N0rSyGrLOA7leU6sDOpvgoO
         50fduhhKDz94Yq/r9Z47JHLiyKu7sYX9pxM6CAk16dTsxL7oGIcsn1nGjO53Sv7l1X/+
         wWDz3gEFby1KyOlMgu9+Urc3i5XFOA64jDY4Yqo3TTqyIVYvHTyyQ+355sjPNsLOY7Mb
         nlEiEjI3FfWhofbgEqCCw7AdaGgb4GKr7+/D5exkDgxhZbbJ1TVyyYW0/2g/8HdMGEhv
         0plb1kZ4T+rlBgOfx7Qo5hGJeylsBNcBFsQZlAhLjMr3XG3KmNY/KpQgJnox/qe+yXpj
         EpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=W4sHhBFT7l0RZw3UjJyqKYPr5puCq7omf6aKnnWND30=;
        b=cslRbQgLzAHjfGwLBsKqG8reeIxfCtrM1Zp4Kj0Z3tNfkLJgyB6h4yMyEMhIAW9khd
         U0DBYCULDZVtmYeHP9/MnbXZQIe5rrdbS05z/A+UAs57epaoLnfdsYOETkU7oLzP4EHc
         ZWm090IFG1jVFTVmhoYy4VKXDoArGXIANKuPUuPazWWQxy/Bkzz+EX2P06vIp+me1Oa/
         +bUIl2AUquXFbcVenPu8kD7FFbaFRLiwgO/a9WixUBOAZL0zMWhYq7dt+fKUSFW3KIT5
         PNly91QXCtr/2YGqUsiXxLrxzKapHrpBMp7UF/316AUzmLKYbrioTiuzMHXbcfJbev9w
         FUPg==
X-Gm-Message-State: ACgBeo1qtIpwubKYWqQdz3iZjUgDDgRqQYC8z6vcb98BzExldsa4mkWh
        kzStRIk3m8BDuvTR6Hbb+nc=
X-Google-Smtp-Source: AA6agR5UAfAyP88xhdAn5WyYEnMT6lPL1ngs0NcfIIBlVKw6XqsJlHInPx6Gie40IB9NPz5vECUixA==
X-Received: by 2002:a05:6000:904:b0:21a:3dca:4297 with SMTP id bz4-20020a056000090400b0021a3dca4297mr13599962wrb.487.1662017088630;
        Thu, 01 Sep 2022 00:24:48 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id x14-20020a5d60ce000000b002252e5a6841sm13952561wrt.57.2022.09.01.00.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:24:48 -0700 (PDT)
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
Subject: [PATCH 09/14] arm64: dts: qcom: sm6115: Add UFS nodes
Date:   Thu,  1 Sep 2022 10:24:08 +0300
Message-Id: <20220901072414.1923075-10-iskren.chernev@gmail.com>
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

The SM6115 comes with UFS support, so add the related UFS and UFS PHY
nodes.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 70 ++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index cde963c56ac9..491fffff8aa1 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -620,6 +620,76 @@ opp-202000000 {
 			};
 		};
 
+		ufs_mem_hc: ufshc@4804000 {
+			compatible = "qcom,sm6115-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0x4804000 0x3000>, <0x4810000 0x8000>;
+			reg-names = "std", "ice";
+			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufs_mem_phy_lanes>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <1>;
+			#reset-cells = <1>;
+			resets = <&gcc GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+
+			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
+			iommus = <&apps_smmu 0x100 0>;
+
+			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_UFS_PHY_AHB_CLK>,
+				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>;
+			clock-names = "core_clk",
+				      "bus_aggr_clk",
+				      "iface_clk",
+				      "core_clk_unipro",
+				      "core_clk_ice",
+				      "ref_clk",
+				      "tx_lane0_sync_clk",
+				      "rx_lane0_sync_clk";
+
+			freq-table-hz = <50000000 200000000>,
+					<0 0>,
+					<0 0>,
+					<37500000 150000000>,
+					<75000000 300000000>,
+					<0 0>,
+					<0 0>,
+					<0 0>;
+
+			non-removable;
+			status = "disabled";
+		};
+
+		ufs_mem_phy: phy@4807000 {
+			compatible = "qcom,sm6115-qmp-ufs-phy";
+			reg = <0x4807000 0x1c4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_UFS_CLKREF_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+			clock-names = "ref", "ref_aux";
+
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
+			status = "disabled";
+
+			ufs_mem_phy_lanes: lanes@4807400 {
+				reg = <0x4807400 0x098>,
+				      <0x4807600 0x130>,
+				      <0x4807c00 0x16c>;
+				#phy-cells = <0>;
+			};
+		};
+
+
 		usb3: usb@4ef8800 {
 			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
 			reg = <0x04ef8800 0x400>;
-- 
2.37.2

