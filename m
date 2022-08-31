Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94AC5A7590
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiHaFT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaFT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:19:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58517B14D8;
        Tue, 30 Aug 2022 22:19:25 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V4DYPX020411;
        Wed, 31 Aug 2022 05:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NN0hANgOTosS67AZM7qStNdWjz7PM0mNu/rAh+RRKaQ=;
 b=nof6eVgQdjqi+tUoGHd0jgiqo/B9MR+GTqEdp0PbaKtltafb2AN6UbfW0AtXmctJsPwA
 StKylhXquPllJwkb5tr7kJ3B5R0dT08Vqx+v6G37mmUt4ftxWPHSR2greKDo/gBY0Sm7
 uxwje5Uv5arFHRgU4w5eiQ7dfiCfb2KdJ0/bfQqY/+XV+m0OXVs+W9lz94mO46B9wZUm
 VBUvgwriA88o4d2hUdnSIb3NXTPUB+JscY3wJ0munyVAscoqmMYza7+tCQjaNHP/HVdU
 2ctkeLO027iTQgntvs9leTFa9qrPWgx8sZ9llJr3aePL6kQCRcnG14Ozx0pofZ7WhuI3 GA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j9m2t2jnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 05:19:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27V5JCtc013996
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 05:19:12 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 30 Aug 2022 22:19:07 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Douglas Anderson <dianders@chromium.org>,
        <krzysztof.kozlowski@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/6] clk: qcom: Allow custom reset ops
Date:   Wed, 31 Aug 2022 10:48:23 +0530
Message-ID: <20220831104741.v6.2.I75baff799a363bbb960376539e3a0f737377c3f1@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1661923108-789-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1661923108-789-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D6OrqctB7GR9Grklm_IuDSXrkz2tB1AB
X-Proofpoint-ORIG-GUID: D6OrqctB7GR9Grklm_IuDSXrkz2tB1AB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_03,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310025
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow soc specific clk drivers to specify a custom reset operation. We
will use this in an upcoming patch to allow gpucc driver to specify a
differet reset operation for cx_gdsc.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

(no changes since v3)

Changes in v3:
- Use pointer to const for "struct qcom_reset_ops" in qcom_reset_map (Krzysztof)

Changes in v2:
- Return error when a particular custom reset op is not implemented. (Dmitry)

 drivers/clk/qcom/reset.c | 27 +++++++++++++++++++++++++++
 drivers/clk/qcom/reset.h |  8 ++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 819d194..b7ae4a3 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -13,6 +13,21 @@
 
 static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 {
+	struct qcom_reset_controller *rst;
+	const struct qcom_reset_map *map;
+
+	rst = to_qcom_reset_controller(rcdev);
+	map = &rst->reset_map[id];
+
+	if (map->ops && map->ops->reset)
+		return map->ops->reset(map->priv);
+	/*
+	 * If custom ops is implemented but just not this callback, return
+	 * error
+	 */
+	else if (map->ops)
+		return -EOPNOTSUPP;
+
 	rcdev->ops->assert(rcdev, id);
 	udelay(1);
 	rcdev->ops->deassert(rcdev, id);
@@ -28,6 +43,12 @@ qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
+
+	if (map->ops && map->ops->assert)
+		return map->ops->assert(map->priv);
+	else if (map->ops)
+		return -EOPNOTSUPP;
+
 	mask = BIT(map->bit);
 
 	return regmap_update_bits(rst->regmap, map->reg, mask, mask);
@@ -42,6 +63,12 @@ qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
+
+	if (map->ops && map->ops->deassert)
+		return map->ops->deassert(map->priv);
+	else if (map->ops)
+		return -EOPNOTSUPP;
+
 	mask = BIT(map->bit);
 
 	return regmap_update_bits(rst->regmap, map->reg, mask, 0);
diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
index 2a08b5e..f3147eb 100644
--- a/drivers/clk/qcom/reset.h
+++ b/drivers/clk/qcom/reset.h
@@ -8,9 +8,17 @@
 
 #include <linux/reset-controller.h>
 
+struct qcom_reset_ops {
+	int (*reset)(void *priv);
+	int (*assert)(void *priv);
+	int (*deassert)(void *priv);
+};
+
 struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
+	const struct qcom_reset_ops *ops;
+	void *priv;
 };
 
 struct regmap;
-- 
2.7.4

