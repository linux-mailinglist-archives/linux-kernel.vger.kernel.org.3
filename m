Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899A757B500
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbiGTLES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiGTLEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:04:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040F26D9E1;
        Wed, 20 Jul 2022 04:04:16 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KAnWmJ008172;
        Wed, 20 Jul 2022 11:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=GXcvdO9ayLwyvlEbvOhdva96oagixi27ayh7cUAUuUU=;
 b=hWi53BVjgyz15VX0/PO3932NoEIJ8HYcYbcN6g5tORGbQ/pVnA2dABbSZRjO1Lw3KWGj
 teSA1XDqUtZEAvbB2GObuuyAPty3x5gOmggrUrIFO0mRwl9aI1k0zjwmNiKNnaciM5Ao
 tjc7bsnF2MiofsMYIDjh5vwzQhEC9kJLskJmZRBoloCrGf6zaUu79V1wwlqrl6CpJzh+
 uMP0yHO2gvbK+56sjLqGmKI33RT3s+8cumBSICoc4C2AXGlxzmr+yUjO+jPcWmU26LP8
 qRB8DETNuRQLkjfZdHSlHT7xGx3DBR6EfUgHAmg9b18OksCsO/uvumeGEYV0z9WkVLln FQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hebfv0tf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 11:04:12 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KB4Bop015372
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 11:04:12 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 04:04:11 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 04:04:07 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <quic_tdas@quicinc.com>,
        <quic_c_skakit@quicinc.com>
Subject: [PATCH V6 0/5] Add support for audio clock gating resets for SC7280
Date:   Wed, 20 Jul 2022 16:33:38 +0530
Message-ID: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 23N64elEEZQwiDmShC013v9JqZSsieqE
X-Proofpoint-ORIG-GUID: 23N64elEEZQwiDmShC013v9JqZSsieqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=726
 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200046
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches [3], [4] and [5] depend on [1], [2] to be merged first. So, adding
the cleanup patches also to this series.

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

