Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC21D597D07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbiHRESJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243171AbiHRERh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:17:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5922A7228;
        Wed, 17 Aug 2022 21:17:31 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I4C0hD003644;
        Thu, 18 Aug 2022 04:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=H31UzLEojwM3wgQfVzmfwrfB8cyUdcUtpJwyaBqUfKs=;
 b=gtEmTYGpGlLJI5tlY91wfouuqeSIX+bYqu/PtmpZLn6mylhzYgVFmhxxn8u9/7N0GyU8
 TqJ+cP71Av+KI2+F4pi+0VhoKDtbTj28slALS/EEeIHOsb6ATPhlElTBFYehaKSiEhGM
 sq5G3M+rigMfkg05NapCu7e3lckUJ86PD647S/xci+P1oACxUYDrjK8WNwK0Byh8LcVC
 YcX2rkpLTCgE8vgHq//dYtv3UxR/PnM0/kB40yTI7YQK7uzLkiOIT2zOG7IcJcYXvWx9
 svvF+udhW8twtggIodFPocpnmqtgNtBRvOXoZ6vH/X2Bn3SndN+7+y/VhOoSPZVkDZsf wg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j13v1j9tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27I4HI1S018163
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:21 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 07:58:14 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        <krzysztof.kozlowski@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] clk/qcom: Support gdsc collapse polling using 'reset' inteface
Date:   Wed, 17 Aug 2022 20:27:49 +0530
Message-ID: <1660748274-39239-1-git-send-email-quic_akhilpo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3P1GUtWu8JPrHUcEyEHZk5UsUB0eEMhe
X-Proofpoint-ORIG-GUID: 3P1GUtWu8JPrHUcEyEHZk5UsUB0eEMhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 mlxlogscore=674 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some clients like adreno gpu driver would like to ensure that its gdsc
is collapsed at hardware during a gpu reset sequence. This is because it
has a votable gdsc which could be ON due to a vote from another subsystem
like tz, hyp etc or due to an internal hardware signal. To allow
this, gpucc driver can expose an interface to the client driver using
reset framework. Using this the client driver can trigger a polling within
the gdsc driver.

This series is rebased on top of linus's master branch.

Related discussion: https://patchwork.freedesktop.org/patch/493144/

Changes in v2:
- Return error when a particular custom reset op is not implemented. (Dmitry)

Akhil P Oommen (5):
  dt-bindings: clk: qcom: Support gpu cx gdsc reset
  clk: qcom: Allow custom reset ops
  clk: qcom: gdsc: Add a reset op to poll gdsc collapse
  clk: qcom: gpucc-sc7280: Add cx collapse reset support
  arm64: dts: qcom: sc7280: Add Reset support for gpu

 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  3 +++
 drivers/clk/qcom/gdsc.c                       | 23 +++++++++++++++++++----
 drivers/clk/qcom/gdsc.h                       |  7 +++++++
 drivers/clk/qcom/gpucc-sc7280.c               | 10 ++++++++++
 drivers/clk/qcom/reset.c                      | 27 +++++++++++++++++++++++++++
 drivers/clk/qcom/reset.h                      |  8 ++++++++
 include/dt-bindings/clock/qcom,gpucc-sc7280.h |  3 +++
 7 files changed, 77 insertions(+), 4 deletions(-)

-- 
2.7.4

