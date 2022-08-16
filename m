Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE512595927
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiHPLBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbiHPLAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:00:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C38E56;
        Tue, 16 Aug 2022 03:10:30 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G9c7Pl012713;
        Tue, 16 Aug 2022 10:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=zQ1eKkhn5S4sqWJRfm7DLCvRzfdADJqgGcWVSrrtZ+E=;
 b=Xfk/UUuZj11PjyEIZyn9ywz5D2uhZQt6uS5bXP/y59/HT8h9NlMz17xNA8VmCcjFClxU
 GABWUGO31SgtpDkdonuCtRXvZxJg7xyT4CaiO4yiiJqL8IdmEyNeeN6W15ZhKY3XP4yC
 ysg9g2lnRCBxN/FN69f3aL9R+sZ+xJtunVcvYTngz35xzrpUZ0ir+RL6eHRfp1n4rB5K
 xQBvrX+LFZGQl93o8S29q1A93VM6yKK+2G0IHnDHN9DrlqhKtZLmIO7QSi/abecWSZBe
 ti/LRBD60/9tay0JxTb560qIAZu1iI/+j84YyASfRGQZone2g7M7Z0flmosFc+vo3HSs PA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j06c0rjgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 10:10:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27GAAQnm015426
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 10:10:26 GMT
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 16 Aug 2022 03:10:22 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>,
        <linux-clk@vger.kernel.org>
Subject: [RESEND PATCH V7 0/5] Add support for audio clock gating resets for SC7280
Date:   Tue, 16 Aug 2022 15:39:59 +0530
Message-ID: <1660644604-6592-1-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Uzn17Q8uGfDrkO5ePMLJa1UYzRVIlQAk
X-Proofpoint-GUID: Uzn17Q8uGfDrkO5ePMLJa1UYzRVIlQAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_07,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=758 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Resending this series after correcting commit text in [1/5] patch.

[v7]
  * Fix commit text of [5/5]. Remove '.' from Fixes tag.

[v6]
  * Add [1], [2] to handle the regmap overlap of lpasscc and lpass_aon 

[v5]
  * Fix the fail path and add pm_runtime_disable().

[v4]
  * Fix the "fixes" tag.

[v3]
  * Remove the maxItems from reg property.

[v2]
  * Update/fix the YAML for reg property against each compatible.

[v1]
  * Add support for clock gating resets for lpass audio clock
    controller & MCLKs.

Satya Priya (2):
  dt-bindings: clock: Add "qcom,adsp-pil-mode" property
  clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon

Taniya Das (3):
  dt-bindings: clock: Add resets for LPASS audio clock controller for
    SC7280
  dt-bindings: clock: Add support for external MCLKs for LPASS on SC7280
  clk: qcom: lpass: Add support for resets & external mclk for SC7280

 .../bindings/clock/qcom,sc7280-lpasscc.yaml        |  6 +-
 .../bindings/clock/qcom,sc7280-lpasscorecc.yaml    | 26 ++++++++-
 drivers/clk/qcom/lpassaudiocc-sc7280.c             | 66 +++++++++++++++++++++-
 drivers/clk/qcom/lpasscc-sc7280.c                  | 44 ---------------
 drivers/clk/qcom/lpasscorecc-sc7280.c              | 33 +++++++++++
 .../dt-bindings/clock/qcom,lpassaudiocc-sc7280.h   |  5 ++
 .../dt-bindings/clock/qcom,lpasscorecc-sc7280.h    |  2 +
 7 files changed, 130 insertions(+), 52 deletions(-)

-- 
2.7.4

