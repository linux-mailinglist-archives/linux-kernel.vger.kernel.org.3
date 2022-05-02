Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B35516C3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383843AbiEBIlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383811AbiEBIlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:41:42 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2284D186C6;
        Mon,  2 May 2022 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651480695; x=1683016695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bVbPOiK0y82rmhyKlFrtAgGmGuURv7LBQSfEtrPIoNU=;
  b=b8EDs9Z6dzQu+RoE0IR9ASNKsToHdNLkw9VzqHRsE7UC0S7kLijl2Pm9
   OruROcNJYms4qkdvKbfg3a83Z5D/48HaoSxQ+9Pbv3HA6zOWK9CsW1EYh
   +SPcutuNq6KSojwnjVZ/6uY0c5cafiyxzVFXEU34i77tgbnWHMf5EvuPC
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 01:38:15 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 May 2022 01:38:13 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 14:07:51 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 0B32B3BED; Mon,  2 May 2022 14:07:50 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        bhupesh.sharma@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 4/4] ARM: dts: qcom: sdx65: Add Shared memory manager support
Date:   Mon,  2 May 2022 14:07:45 +0530
Message-Id: <1651480665-14978-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add smem node to support shared memory manager on SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 210e55c..57bda62 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -87,8 +87,10 @@
 		};
 
 		smem_mem: memory@8fe20000 {
-			no-map;
+			compatible = "qcom,smem";
 			reg = <0x8fe20000 0xc0000>;
+			hwlocks = <&tcsr_mutex 3>;
+			no-map;
 		};
 
 		cmd_db: reserved-memory@8fee0000 {
-- 
2.7.4

