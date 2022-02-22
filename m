Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196A44BF19E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiBVFhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:37:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiBVFhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:37:20 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01ECDF65;
        Mon, 21 Feb 2022 21:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645508215; x=1677044215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=LikwOCD19GKA5B0ZPJPA/rewG6VdFFDqbWYdpergKuQ=;
  b=a0/oSoc9BFWns6Uelq87cBps9kphkguEMS5/8owt2tOYpgJFPbnSKkjW
   udBw7ayVaIhd7BO2DdJiqs9nT4A3xDSVjZmMfruCpc/UlnYL8YrbDR5Ed
   tVQCUCE3SuNTcmnv1uZPBr284BycNifHZaxp30t0C+1bol+EHAHh4im4X
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Feb 2022 20:56:45 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Feb 2022 20:56:41 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 22 Feb 2022 10:26:31 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 6E08F46DF; Tue, 22 Feb 2022 10:26:30 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v4 4/5] ARM: dts: qcom: sdx65: Add support for APCS block
Date:   Tue, 22 Feb 2022 10:26:24 +0530
Message-Id: <1645505785-2271-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645505785-2271-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1645505785-2271-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APCS block on SDX65 acts as a mailbox controller and also provides
clock output for the Cortex A7 CPU.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index ec80266..af7453a 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -133,6 +133,15 @@
 			#clock-cells = <0>;
 		};
 
+		apcs: mailbox@17810000 {
+			compatible = "qcom,sdx55-apcs-gcc", "syscon";
+			reg = <0x17810000 0x2000>;
+			#mbox-cells = <1>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&a7pll>, <&gcc GPLL0>;
+			clock-names = "ref", "pll", "aux";
+			#clock-cells = <0>;
+		};
+
 		timer@17820000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.7.4

