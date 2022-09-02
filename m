Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2435AA712
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 06:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiIBElJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 00:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIBElG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 00:41:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390A5AE22B;
        Thu,  1 Sep 2022 21:41:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2824QimO029163;
        Fri, 2 Sep 2022 04:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=MfoTqYR14hSfoM2+FEog2Mx+KbQ5o5dZRdkS7s9Vd68=;
 b=ffSPX1TQIkpm5xGPvPRYHqBq4Rgevqzber5+MImW4xxBFBVFC1W+vPz2AJLAWAD3p+1X
 nYkpQxYyUBRb2QnwxPiThkHbDek936ur+NTypM8kP5jDMXCIvdktkKHwd/Z99jJdhyK3
 sSHltmxn5Z8cpvSPewBSp3tBLZscL0ESznncvv3Hi8YCgpI8uFKRzjW/xuW+Njemm2a2
 OTs7dbcLwcmSMjM7IV8B5CG7ZOXUj2CktCYbNW1bzIypUx3Lv40VN/2dQx3CaqrHWyij
 ddkp987ZeiYB6Na8BHj+jaHCZBaTN+tBTrs+m8Kn4TLWqgIGeginSKhUHbQNY7eJI4EV iQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jafkx4v3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 04:41:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2824ZxpJ001416
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 04:35:59 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 21:35:56 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2 0/4] soc: qcom: icc-bwmon: Add support for llcc and cpu bwmon on sc7280
Date:   Fri, 2 Sep 2022 10:05:07 +0530
Message-ID: <20220902043511.17130-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3-P9iYNBXn6B6G_JBbqYoFhCsNECt1ZG
X-Proofpoint-GUID: 3-P9iYNBXn6B6G_JBbqYoFhCsNECt1ZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=793 malwarescore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020020
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
Patch 1/1: rearranged compatibles in alphabetical order, no changes in rest of the patches

This patchset adds support for cpu bwmon (bwmon4) and llcc bwmon (bwmon5) found
on sc7280 SoC.

Patchset is based on top of series [1] that adds support for llcc bwmon on sdm845

[1]
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=663695&state=*

Rajendra Nayak (4):
  dt-bindings: interconnect: qcom,msm8998-bwmon: Add support for sc7280
    BWMONs
  soc: qcom: icc-bwmon: add support for sc7280 LLCC BWMON
  soc: qcom: icc-bwmon: force clear counter/irq registers
  arm64: dts: qcom: sc7280: Add cpu and llcc BWMON

 .../interconnect/qcom,msm8998-bwmon.yaml      |  2 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 76 +++++++++++++++++++
 drivers/soc/qcom/icc-bwmon.c                  | 21 +++++
 3 files changed, 99 insertions(+)

-- 
2.17.1

