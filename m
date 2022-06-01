Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C42F53A2F3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352247AbiFAKpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351549AbiFAKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:45:38 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B627CB7D;
        Wed,  1 Jun 2022 03:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654080337; x=1685616337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=azlyfzRu9cMqIBHovpx4gwhu0zJW42GZxYs3Wuf5XOM=;
  b=u1wnSgR4LgPJ9lRNC546rTUK7Z3HJfWVjIpFrjyQ2rMdsdiuHYXNqRY9
   eZ/Bpduv92N/35+qRAoI2FEjVifVOxRpbtHW7RrMvYflGf/K8YOWur+/I
   Tx4jRU8LAK2F7+vyjE5q6Aeze11il9NE8FD5D1cAWdLu0q3jCGGfcMsYE
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 01 Jun 2022 03:45:37 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Jun 2022 03:45:35 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 01 Jun 2022 16:15:24 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id E3B983FCD; Wed,  1 Jun 2022 16:15:23 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        manivannan.sadhasivam@linaro.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 11/11] ARM: dts: qcom: sdx65: Add pshold support
Date:   Wed,  1 Jun 2022 16:15:12 +0530
Message-Id: <1654080312-5408-12-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for pshold block to drive pshold towards the PMIC, which is
used to trigger a configurable event such as reboot or poweroff of the
SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index c76f330..a249646 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -394,6 +394,11 @@
 			};
 		};
 
+		restart@c264000 {
+			compatible = "qcom,pshold";
+			reg = <0x0c264000 0x1000>;
+		};
+
 		spmi_bus: qcom,spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0xd00>,
-- 
2.7.4

