Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5A5A8C43
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiIAER5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiIAERy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:17:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785846610A;
        Wed, 31 Aug 2022 21:17:51 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2813URWQ001037;
        Thu, 1 Sep 2022 04:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=3MJVROO+LBj4KjA+N+tsV1mjxSslj/W7eQfnflkxjC0=;
 b=k2/PxIeJrIUiOsX5ta7LMOZ+qA6I/SvB6/gUBUQOsWeAhTTeiFc1k3MKB6ex4nnHLYX3
 q8rE3CRgJc8Yn0oH5dDJyJ95aoSEBmYg9dm23DNjcz9CTvXK/VXk9KdO6iienSd2/c9z
 2KlAaV/lnG/TXp6/CrkcyTbNyoNBZbWNi1Gst+I+BuFq3gJNsDK9NiUxr+nPzyTm9YYd
 FCMbiiRHl2aH+9EaklrJJxn3/sX8UvmhRxhDizvDK6fMDzkAuMpfKruVFN/R6jEpR22x
 SLQe3XoHVhTNcQI9kVMLIxMSfPpNv2Mz2hURhs5/8Ap+FyWgR+UKhWE73K95KwyPu9v8 OQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jab5gj4cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 04:17:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2814HkT8013711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 04:17:46 GMT
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 31 Aug 2022 21:17:42 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH V9 0/5] Add support for audio clock gating resets for SC7280
Date:   Thu, 1 Sep 2022 09:47:21 +0530
Message-ID: <1662005846-4838-1-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pJ6cV8XpmOBzPWeNhgoUirPsPLoQ07Wj
X-Proofpoint-GUID: pJ6cV8XpmOBzPWeNhgoUirPsPLoQ07Wj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=763 bulkscore=0 spamscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010019
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v9]
  * Fix the order of SoB for [/5] and [2/5]

[v8]
  * Squash [1] into [5/5]
  [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1661245527-5596-1-git-send-email-quic_c_skakit@quicinc.com/

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

Taniya Das (5):
  dt-bindings: clock: Add "qcom,adsp-pil-mode" property
  clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon
  dt-bindings: clock: Add resets for LPASS audio clock controller for
    SC7280
  dt-bindings: clock: Add support for external MCLKs for LPASS on SC7280
  clk: qcom: lpass: Add support for resets & external mclk for SC7280

 .../bindings/clock/qcom,sc7280-lpasscc.yaml        |  6 +-
 .../bindings/clock/qcom,sc7280-lpasscorecc.yaml    | 26 ++++++++-
 drivers/clk/qcom/lpassaudiocc-sc7280.c             | 68 +++++++++++++++++++++-
 drivers/clk/qcom/lpasscc-sc7280.c                  | 44 --------------
 drivers/clk/qcom/lpasscorecc-sc7280.c              | 33 +++++++++++
 .../dt-bindings/clock/qcom,lpassaudiocc-sc7280.h   |  5 ++
 .../dt-bindings/clock/qcom,lpasscorecc-sc7280.h    |  2 +
 7 files changed, 131 insertions(+), 53 deletions(-)

-- 
2.7.4

