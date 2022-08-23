Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9DF59DB31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356283AbiHWKlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354566AbiHWK2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:28:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59779A4B0D;
        Tue, 23 Aug 2022 02:06:08 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27N3tqFm001761;
        Tue, 23 Aug 2022 09:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=LM0sqG3wWiXEL/Wnkor2Tjkj6umw1AfTQiffQFf5arI=;
 b=AuQfXJFyFQha7cfahHhXSpUtM8hBgRip4e0cqGURMloBhUL4rzP19uSJJNQwofaqJtym
 Jazbsv39STH+YE450RNbOnCQdsITtNC8/mYNDNzkhTU1s50K+lFvfjJ08YcOP0N9e+E4
 ziSZMmSDVw/09OkNN2UxFC9eACIqeeqsTDSR6hlUS0ZVjlWxru9PmYDppmTM6ajwklyY
 ryvNb00zvQ0A93PWW4qIsX8OFBrb8sKgJR9i1Sgft7cEIv/RJgrYckIueGVkuvGB7Yf8
 62Jyva9p0CsH9VoB0J2eQjn1uYEQ8drffIZyGXDDJb0PTfZ1poBsVicdLDZj62n6wc90 7g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j4dgy2kbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 09:05:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27N95vPV010885
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 09:05:57 GMT
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 23 Aug 2022 02:05:53 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <mka@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH] clk: qcom: lpass: Fix the invalid index errors seen at bootup
Date:   Tue, 23 Aug 2022 14:35:27 +0530
Message-ID: <1661245527-5596-1-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wPDLZBy73CuDUBPiGVk9AIEq5_wa6DS3
X-Proofpoint-GUID: wPDLZBy73CuDUBPiGVk9AIEq5_wa6DS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_04,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxlogscore=859 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After support for resets is added, qcom_cc_really_probe()
would be called twice for the same cc which causes
invalid index errors in qcom_clk_hw_get().

qcom_cc_clk_hw_get: invalid index 5
qcom_cc_clk_hw_get: invalid index 6
qcom_cc_clk_hw_get: invalid index 7

Fixes: a9dd26639d05 ("clk: qcom: lpass: Add support for LPASS clock controller for SC7280")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
This patch depends on [1] 
[1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=667984

 drivers/clk/qcom/lpassaudiocc-sc7280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 063e036..5d4bc56 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -785,7 +785,7 @@ static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
 	regmap_write(regmap, 0x4, 0x3b);
 	regmap_write(regmap, 0x8, 0xff05);
 
-	ret = qcom_cc_really_probe(pdev, &lpass_audio_cc_sc7280_desc, regmap);
+	ret = qcom_cc_probe_by_index(pdev, 0, &lpass_audio_cc_sc7280_desc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register LPASS AUDIO CC clocks\n");
 		pm_runtime_disable(&pdev->dev);
-- 
2.7.4

