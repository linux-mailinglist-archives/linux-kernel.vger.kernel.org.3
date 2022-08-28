Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519145A3F62
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 21:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiH1TWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiH1TWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 15:22:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0429C80;
        Sun, 28 Aug 2022 12:22:16 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27SJLWN9012339;
        Sun, 28 Aug 2022 19:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rCWzUM10XcrQHFNoF0Rr6Y0KkFhaxt6fPjOXSCmrhCg=;
 b=FvsTTIHf13K4FVfJG9MCqo5xA0UbSvG2tC+fhB/jH5yuBEOFgaZ7S9kx3EeQoeUvoDps
 3XhtyDpLlf1ZMnBYXs3d3P0l7bVojuIGnUEdteqRKJfoxAkfu+CvQsgRYZGg8AatQLKD
 HMvzNjfukUKOvFDnorObJa4wHVLFM9uoSByWBAhsL+9ZcJgkGUw2rP37I82qiKOPGFm8
 pv0AkKF0wN3gP7L+4nRGrygBL4uibJQD9Lafl68Ipx7WusJeEbRZ5e7LsAPye4yatKng
 5HkmmJxQu8xc/aQul6ydI/d/K2in0Qrs8lavWdtoXsTU+LYd/yN+Ntv8TDvKM33KxVVc +g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j7akquaym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 19:22:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27SJM1It006514
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 19:22:01 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 28 Aug 2022 12:21:56 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <krzysztof.kozlowski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/6] clk: qcom: gdsc: Add a reset op to poll gdsc collapse
Date:   Mon, 29 Aug 2022 00:51:16 +0530
Message-ID: <20220829005035.v5.3.I162c4be55f230cd439f0643f1624527bdc8a9831@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1661714479-28981-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1661714479-28981-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A0HfXz-0encJFcXgIMHZZSufdjUQXKzR
X-Proofpoint-GUID: A0HfXz-0encJFcXgIMHZZSufdjUQXKzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-28_12,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208280080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reset op compatible function to poll for gdsc collapse.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

(no changes since v2)

Changes in v2:
- Minor update to function prototype

 drivers/clk/qcom/gdsc.c | 23 +++++++++++++++++++----
 drivers/clk/qcom/gdsc.h |  7 +++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 44520ef..2d0f1d1 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -17,6 +17,7 @@
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include "gdsc.h"
+#include "reset.h"
 
 #define PWR_ON_MASK		BIT(31)
 #define EN_REST_WAIT_MASK	GENMASK_ULL(23, 20)
@@ -116,7 +117,8 @@ static int gdsc_hwctrl(struct gdsc *sc, bool en)
 	return regmap_update_bits(sc->regmap, sc->gdscr, HW_CONTROL_MASK, val);
 }
 
-static int gdsc_poll_status(struct gdsc *sc, enum gdsc_status status)
+static int gdsc_poll_status(struct gdsc *sc, enum gdsc_status status,
+		s64 timeout_us, unsigned int interval_ms)
 {
 	ktime_t start;
 
@@ -124,7 +126,9 @@ static int gdsc_poll_status(struct gdsc *sc, enum gdsc_status status)
 	do {
 		if (gdsc_check_status(sc, status))
 			return 0;
-	} while (ktime_us_delta(ktime_get(), start) < TIMEOUT_US);
+		if (interval_ms)
+			msleep(interval_ms);
+	} while (ktime_us_delta(ktime_get(), start) < timeout_us);
 
 	if (gdsc_check_status(sc, status))
 		return 0;
@@ -172,7 +176,7 @@ static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
 		udelay(1);
 	}
 
-	ret = gdsc_poll_status(sc, status);
+	ret = gdsc_poll_status(sc, status, TIMEOUT_US, 0);
 	WARN(ret, "%s status stuck at 'o%s'", sc->pd.name, status ? "ff" : "n");
 
 	if (!ret && status == GDSC_OFF && sc->rsupply) {
@@ -343,7 +347,7 @@ static int _gdsc_disable(struct gdsc *sc)
 		 */
 		udelay(1);
 
-		ret = gdsc_poll_status(sc, GDSC_ON);
+		ret = gdsc_poll_status(sc, GDSC_ON, TIMEOUT_US, 0);
 		if (ret)
 			return ret;
 	}
@@ -565,3 +569,14 @@ int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
+
+int gdsc_wait_for_collapse(void *priv)
+{
+	struct gdsc *sc = priv;
+	int ret;
+
+	ret = gdsc_poll_status(sc, GDSC_OFF, 500000, 5);
+	WARN(ret, "%s status stuck at 'on'", sc->pd.name);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gdsc_wait_for_collapse);
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index ad313d7..d484bdb 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -12,6 +12,7 @@
 struct regmap;
 struct regulator;
 struct reset_controller_dev;
+struct qcom_reset_map;
 
 /**
  * struct gdsc - Globally Distributed Switch Controller
@@ -79,6 +80,7 @@ int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
 		  struct regmap *);
 void gdsc_unregister(struct gdsc_desc *desc);
 int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
+int gdsc_wait_for_collapse(void *priv);
 #else
 static inline int gdsc_register(struct gdsc_desc *desc,
 				struct reset_controller_dev *rcdev,
@@ -88,5 +90,10 @@ static inline int gdsc_register(struct gdsc_desc *desc,
 }
 
 static inline void gdsc_unregister(struct gdsc_desc *desc) {};
+
+static int gdsc_wait_for_collapse(void *priv)
+{
+	return  -ENOSYS;
+}
 #endif /* CONFIG_QCOM_GDSC */
 #endif /* __QCOM_GDSC_H__ */
-- 
2.7.4

