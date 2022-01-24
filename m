Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8807498587
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbiAXQ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:58:02 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:17795 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243796AbiAXQ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:58:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1643043479; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BmbwObkwttro0SkpL4p0P2XaUDTExkEYfbCchug/+GI=; b=vZFNpNT6t++UjJxzzIePhWchIejBneLoz90n1QPY/EWYS8mDZdoAP2e84prgmuMHPe4uOYN4
 Jk4a4tQ6BUIFsKV+9dPDMQlm7awNLgcyqHRyJL5/AzE3CwyaIpEB/Q4Zf3yEsz9HZGbCM6SD
 aUzK0Ny7PUKK99DlnFEdSpGMW6E=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61eeda94020b4d26a6184209 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Jan 2022 16:57:56
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4E3DC4360D; Mon, 24 Jan 2022 16:57:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hu-tdas-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57B9DC4338F;
        Mon, 24 Jan 2022 16:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 57B9DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers
Date:   Mon, 24 Jan 2022 22:27:45 +0530
Message-Id: <20220124165745.16277-1-tdas@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the low pass audio clock controller device nodes.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
Dependent onLPASS clock controller change: https://lkml.org/lkml/2022/1/24/772

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 43 ++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 937c2e0e93eb..0aa834ce6b61 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/clock/qcom,dispcc-sc7280.h>
 #include <dt-bindings/clock/qcom,gcc-sc7280.h>
 #include <dt-bindings/clock/qcom,gpucc-sc7280.h>
+#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
+#include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sc7280.h>
 #include <dt-bindings/interconnect/qcom,sc7280.h>
@@ -1744,6 +1746,47 @@
 			#clock-cells = <1>;
 		};

+		lpass_audiocc: clock-controller@3300000 {
+			compatible = "qcom,sc7280-lpassaudiocc";
+			reg = <0  0x03300000 0 0x30000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+			       <&lpass_aon LPASS_AON_CC_MAIN_RCG_CLK_SRC>;
+			clock-names = "bi_tcxo", "lpass_aon_cc_main_rcg_clk_src";
+			power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		lpass_aon: clock-controller@3380000 {
+			compatible = "qcom,sc7280-lpassaoncc";
+			reg = <0  0x03380000 0 0x30000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+			       <&rpmhcc RPMH_CXO_CLK_A>,
+			       <&lpasscc LPASS_CORE_CC_CORE_CLK>;
+			clock-names = "bi_tcxo", "bi_tcxo_ao", "iface";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		lpasscore: clock-controller@3900000 {
+			compatible = "qcom,sc7280-lpasscorecc";
+			reg = <0  0x03900000 0 0x50000>;
+			clocks =  <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "bi_tcxo";
+			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>;
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		lpass_hm: clock-controller@3c00000 {
+			compatible = "qcom,sc7280-lpasshm";
+			reg = <0 0x3c00000 0 0x28>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "bi_tcxo";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		lpass_ag_noc: interconnect@3c40000 {
 			reg = <0 0x03c40000 0 0xf080>;
 			compatible = "qcom,sc7280-lpass-ag-noc";
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

