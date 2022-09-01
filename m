Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA25E5A9429
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiIAKTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiIAKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:19:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4C813418F;
        Thu,  1 Sep 2022 03:19:04 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2819cEEX003472;
        Thu, 1 Sep 2022 10:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=qS26eoGYtM3IcSGsZUsPpBd5i9/TOIqrcxtJBkrGh0c=;
 b=AfeOoVgJvMzCwpOGBXDGXb9JNtYrfZE1BdchliKi54ClJdQ2iIK+EeIOwrjpnut9DY4D
 NRihIc6mIiQx6MiMQAdt8pehi/+fL55Rd3Hr3X+pIotwzSxbB5eIm/jvMSlOkz+NUDS4
 wtEPyuhuzcWhvxVYBzNREmBRRZ3fiIB8RMMirsCUWq+lszyQgoqik0DMm9N8LQXvd+aZ
 l/v8Lxh+iQeytHTymWI2Kjpknlka3Dg+6rQaei11gXQrjqPAb+oay9+Pkp4GPaSFBxMN
 hkvGqkwfDyGNgDb0QiJA19CPadC5aN6uKD+udW0cIWN2BIMtNOpNON1INe6hsOgaWe+C Gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jarc80dej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 10:18:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 281AItjg008396
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 10:18:55 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 03:18:50 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mka@chromium.org>
CC:     <johan+linaro@kernel.org>, <quic_kriskura@quicinc.com>,
        <dianders@chromium.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 1/3] clk: qcom: gdsc: Fix the handling of PWRSTS_RET support
Date:   Thu, 1 Sep 2022 15:47:54 +0530
Message-ID: <20220901101756.28164-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gWh9pBeloEVVZkeVRrPfB-vWvdFEAK64
X-Proofpoint-GUID: gWh9pBeloEVVZkeVRrPfB-vWvdFEAK64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=987 lowpriorityscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GDSCs cannot be transitioned into a Retention state in SW.
When either the RETAIN_MEM bit, or both the RETAIN_MEM and
RETAIN_PERIPH bits are set, and the GDSC is left ON, the HW
takes care of retaining the memory/logic for the domain when
the parent domain transitions to low power state.
The existing logic handling the PWRSTS_RET seems to set the
RETAIN_MEM/RETAIN_PERIPH bits but then explicitly turns the
GDSC OFF as part of _gdsc_disable(). Fix that by leaving the
GDSC in ON state.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
There are a few existing users of PWRSTS_RET and I am not
sure if they would be impacted with this change

1. mdss_gdsc in mmcc-msm8974.c, I am expecting that the
gdsc is actually transitioning to OFF and might be left
ON as part of this change, atleast till we hit system wide
low power state.
If we really leak more power because of this
change, the right thing to do would be to update .pwrsts for
mdss_gdsc to PWRSTS_OFF_ON instead of PWRSTS_RET_ON
I dont have a msm8974 hardware, so if anyone who has can report
any issues I can take a look further on how to fix it.

2. gpu_gx_gdsc in gpucc-msm8998.c and
   gpu_gx_gdsc in gpucc-sdm660.c
Both of these seem to add support for 3 power state
OFF, RET and ON, however I dont see any logic in gdsc
driver to handle 3 different power states.
So I am expecting that these are infact just transitioning
between ON and OFF and RET state is never really used.
The ideal fix for them would be to just update their resp.
.pwrsts to PWRSTS_OFF_ON only. 

 drivers/clk/qcom/gdsc.c | 10 ++++++++++
 drivers/clk/qcom/gdsc.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index d3244006c661..ccf63771e852 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -368,6 +368,16 @@ static int _gdsc_disable(struct gdsc *sc)
 	if (sc->pwrsts & PWRSTS_OFF)
 		gdsc_clear_mem_on(sc);
 
+	/*
+	 * If the GDSC supports only a Retention state, apart from ON,
+	 * leave it in ON state.
+	 * There is no SW control to transition the GDSC into
+	 * Retention state. This happens in HW when the parent
+	 * domain goes down to a Low power state
+	 */
+	if (sc->pwrsts == PWRSTS_RET_ON)
+		return 0;
+
 	ret = gdsc_toggle_logic(sc, GDSC_OFF);
 	if (ret)
 		return ret;
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 5de48c9439b2..981a12c8502d 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -49,6 +49,11 @@ struct gdsc {
 	const u8			pwrsts;
 /* Powerdomain allowable state bitfields */
 #define PWRSTS_OFF		BIT(0)
+/*
+ * There is no SW control to transition a GDSC into
+ * PWRSTS_RET. This happens in HW when the parent
+ * domain goes down to a low power state
+ */
 #define PWRSTS_RET		BIT(1)
 #define PWRSTS_ON		BIT(2)
 #define PWRSTS_OFF_ON		(PWRSTS_OFF | PWRSTS_ON)
-- 
2.17.1

