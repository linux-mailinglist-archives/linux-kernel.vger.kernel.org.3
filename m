Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB75B0336
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiIGLhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIGLgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:36:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777CC2C13D;
        Wed,  7 Sep 2022 04:36:46 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2878lxlr002379;
        Wed, 7 Sep 2022 11:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=+J2q28663HnekhnqpbxMxmUltK8XR8Y64XsYPBktWAE=;
 b=nA0pS6lJmrE2J3C8/BuihqFFQhix+ZjthMpSdJJnRDg+BwK2ZeLANDJ8noi4eVG1TtBo
 5CkZDTbnNZ3VXTFd0+of5LUFAdL5m/TN+sqH4pvL0Mhhh2z42V1GA7Goi1Qb4DZQFXv1
 woUkTkulyB/Rx1NvRy5ZibRG+9hX0FXNeYtiPo2M1Cecq5LU2uX+F7qKqaFjZFkPMtwi
 vJJAT1oIqChK3L1o6VE0sy57eFfpiwSmSRfhdKU0XZmZcxKHi08mCIsJO0jBfbF9iHSC
 /NojEfopuhjJG5S9Os6yd5XolEE6w2F1pO7AO7Mf13pt9NYt4k+EEeBBTOSTtM+9TMXR PQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jeqfwgjbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 11:36:37 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 287BaXbF032259;
        Wed, 7 Sep 2022 11:36:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3jc00kxt4u-1;
        Wed, 07 Sep 2022 11:36:33 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 287BaX6K032254;
        Wed, 7 Sep 2022 11:36:33 GMT
Received: from rajeevny-linux.qualcomm.com (RAJEEVNY-LINUX.qualcomm.com [10.204.66.121])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 287BaWLu032253;
        Wed, 07 Sep 2022 11:36:33 +0000
Received: by rajeevny-linux.qualcomm.com (Postfix, from userid 2363605)
        id 1DAF020F8B; Wed,  7 Sep 2022 17:06:32 +0530 (IST)
From:   Rajeev Nandan <quic_rajeevny@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Rajeev Nandan <quic_rajeevny@quicinc.com>,
        linux-kernel@vger.kernel.org, sean@poorly.run, robdclark@gmail.com,
        robh+dt@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, quic_abhinavk@quicinc.com,
        quic_kalyant@quicinc.com
Subject: [v1] arm64: dts: qcom: sc7280: assign DSI clock source parents
Date:   Wed,  7 Sep 2022 17:05:53 +0530
Message-Id: <1662550553-28933-1-git-send-email-quic_rajeevny@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XZbuI_TuHvG35CCqqA2BUiBDCfv4OYN4
X-Proofpoint-GUID: XZbuI_TuHvG35CCqqA2BUiBDCfv4OYN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_06,2022-09-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=926
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070044
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign DSI clock source parents to DSI PHY clocks.

Signed-off-by: Rajeev Nandan <quic_rajeevny@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

This change is needed after the refactor done by the patch [2] 
(drm/msm/dsi: stop setting clock parents manually) of series [1],
to fix the DSI pixel clock set rate error:
  dsi_link_clk_set_rate_6g: Failed to set rate pixel clk, -22
  msm_dsi_host_power_on: failed to enable link clocks. ret=-22

[1] https://github.com/torvalds/linux/commit/9b077c1581cf57206f5f7788ea569e8fae0719a7
[2] https://lore.kernel.org/all/20210709210729.953114-1-dmitry.baryshkov@linaro.org/

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 50c3d79..a80aa64 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3650,6 +3650,9 @@
 					      "iface",
 					      "bus";
 
+				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi_phy 0>, <&mdss_dsi_phy 1>;
+
 				operating-points-v2 = <&dsi_opp_table>;
 				power-domains = <&rpmhpd SC7280_CX>;
 
-- 
2.7.4

