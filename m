Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4774FB42F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiDKG7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245124AbiDKG6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:58:33 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C702AC5F;
        Sun, 10 Apr 2022 23:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649660179; x=1681196179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+KRMi56LVuC86kOFkBF4O8ESf02mAw9nnU+hNYWAH/Y=;
  b=rAc57Nx/nGjipDWyoTivQwXoNUPOAeDozpyz+YLp7vpnEhXbM6eoOIKL
   JpjqGC/Vb0be4hTZmywl8HzbVDrFoXbQGATObgFphPpnJ/f0maia91uwk
   Kr0C/WItqMOG4OOxFr0pYlRtVJKKUA8rwLAEMwqdg74xwHt6O96vjMJ18
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 10 Apr 2022 23:56:19 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Apr 2022 23:56:17 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 11 Apr 2022 12:25:53 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 3509B3AA2; Mon, 11 Apr 2022 12:25:52 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 3/7] ARM: dts: qcom: sdx65: Add support for SDHCI controller
Date:   Mon, 11 Apr 2022 12:25:39 +0530
Message-Id: <1649660143-22400-4-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for SDHCI controller found in Qualcomm SDX65
platform. The SDHCI controller is based on the MSM SDHCI v5 IP.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 365df74..632ac78 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -168,6 +168,19 @@
 			#interrupt-cells = <2>;
 		};
 
+		sdhc_1: sdhci@8804000 {
+			compatible = "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x08804000 0x1000>;
+			reg-names = "hc_mem";
+			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
+				<&gcc GCC_SDCC1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
 		pdc: interrupt-controller@b210000 {
 			compatible = "qcom,sdx65-pdc", "qcom,pdc";
 			reg = <0xb210000 0x10000>;
-- 
2.7.4

