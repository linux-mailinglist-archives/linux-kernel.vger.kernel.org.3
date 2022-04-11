Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DD44FB429
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245184AbiDKG6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbiDKG62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:58:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3981F2AC56;
        Sun, 10 Apr 2022 23:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649660175; x=1681196175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8WoLxVpJwsGyepr056PagqgtM+agMi/R0Cz0UrtHKc0=;
  b=qJIYUCVdvRo7djC0CqQwA3hSF0XL9tyOUHxPeTdAn3t/7vM/URZ6Hl6j
   MXDdgauAnqhQJNk6fR5tyVYXJALOwAAciDjy7RS6i+1U3hPXnQkWmJ1KK
   sSVooTsflTHSzKyclpppk/Wpk+rPiXo9fPv8cKpWsl6crQ5UbcaO6NfXR
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 10 Apr 2022 23:56:15 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Apr 2022 23:56:13 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 11 Apr 2022 12:25:52 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 31C2D3A9B; Mon, 11 Apr 2022 12:25:51 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 1/7] ARM: dts: qcom: sdx65: Add reserved memory nodes
Date:   Mon, 11 Apr 2022 12:25:37 +0530
Message-Id: <1649660143-22400-2-git-send-email-quic_rohiagar@quicinc.com>
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

Add reserved memory nodes to the SDX65 dtsi as defined by
the memory map.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 21 +++++++++++++++++
 arch/arm/boot/dts/qcom-sdx65.dtsi    | 45 ++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index ad99f56..5d51cc4 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -23,6 +23,27 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		mpss_dsm: mpss_dsm_region@8c400000 {
+			no-map;
+			reg = <0x8c400000 0x3200000>;
+		};
+
+		ipa_fw_mem: ipa_fw_region@8fced000 {
+			no-map;
+			reg = <0x8fced000 0x10000>;
+		};
+
+		mpss_adsp_mem: mpss_adsp_region@90800000 {
+			no-map;
+			reg = <0x90800000 0x10000000>;
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 7e2697f..365df74 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -66,6 +66,51 @@
 			reg = <0x8fee0000 0x20000>;
 			no-map;
 		};
+
+		secdata_mem: secdata_region@8fcfd000 {
+			no-map;
+			reg = <0x8fcfd000 0x1000>;
+		};
+
+		hyp_mem: hyp_region@8fd00000 {
+			no-map;
+			reg = <0x8fd00000 0x80000>;
+		};
+
+		aop_mem: aop_regions@8fe00000 {
+			no-map;
+			reg = <0x8fe00000 0x20000>;
+		};
+
+		access_control_mem: access_control_region@8fd80000 {
+			no-map;
+			reg = <0x8fd80000 0x80000>;
+		};
+
+		smem_mem: smem_region@8fe20000 {
+			no-map;
+			reg = <0x8fe20000 0xc0000>;
+		};
+
+		tz_mem: tz_mem_region@8ff00000 {
+			no-map;
+			reg = <0x8ff00000 0x100000>;
+		};
+
+		tz_apps_mem: tz_apps_mem_region@90000000 {
+			no-map;
+			reg = <0x90000000 0x500000>;
+		};
+
+		tz_heap_mem: tz_heap_region@8fcad000 {
+			no-map;
+			reg = <0x8fcad000 0x40000>;
+		};
+
+		llcc_tcm_mem: llcc_tcm_region@15800000 {
+			no-map;
+			reg = <0x15800000 0x800000>;
+		};
 	};
 
 	soc: soc {
-- 
2.7.4

