Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047034FB41E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245118AbiDKG62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbiDKG6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:58:25 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929CA2A25E;
        Sun, 10 Apr 2022 23:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649660171; x=1681196171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SPn7rGfpCdKX5BixSOyXy7nTS1C2Ef91VXqrhvWkrS4=;
  b=bifZ/ONFdc8+Kw/P+M4RC3weZByYW/1FoZLoLTgYYM3wHcwkh1GifZ9f
   K2j3H7MpXuj4Nbdod6LoU6WXyVyz2TxCZ+ytkbmY5igwM/8eqpMBaGJr0
   N2r2ZumcnvznHOzPalae9XhQeB/KEoHJ7incWdSVWNiBRDZaBzNKmGI29
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 10 Apr 2022 23:56:11 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Apr 2022 23:56:09 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 11 Apr 2022 12:25:54 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 4B7773A9B; Mon, 11 Apr 2022 12:25:53 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 5/7] ARM: dts: qcom: sdx65: Enable ARM SMMU
Date:   Mon, 11 Apr 2022 12:25:41 +0530
Message-Id: <1649660143-22400-6-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the ARM SMMU found in the SDX65.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 632ac78..2481769 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -181,6 +181,46 @@
 			status = "disabled";
 		};
 
+		apps_smmu: iommu@15000000 {
+			compatible = "qcom,sdx65-smmu-500", "arm,mmu-500";
+			reg = <0x15000000 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts =	<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		pdc: interrupt-controller@b210000 {
 			compatible = "qcom,sdx65-pdc", "qcom,pdc";
 			reg = <0xb210000 0x10000>;
-- 
2.7.4

