Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4EF5AF11C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiIFQvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiIFQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:51:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0434083F01;
        Tue,  6 Sep 2022 09:37:34 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286DbCl7015097;
        Tue, 6 Sep 2022 16:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qtuPZn6ok2qymhxb/LJqDqmAA/+7/8q3E29PDfBvFy8=;
 b=MevkV8PcLEXurWCKjtm6KhKFSCTTyZtHQsRy/krH1yhbJHiC4HpTFKFqEVNxmxbWQNuH
 JPcklisEiDryzQOk6xDf3xRLKJKFu1t12GEbd2ESot2bA8ItvoDpolqQ+vY50kPtmlpj
 MYEKH8tm8Tdt2THUQPZxzI6Oapc6Xy2W3zg5Zc6w2WcG6u8XcneX7b8sltyUkkfvLqMt
 5dJ8RQQDQgH1MiLtdtB5TodcyiqpvvCgDHe1zw3E37yl5q4TFNuIg2SEZEJQoB4HCQNa
 jKVSVUKy9YhrbWVnIX+nOPkmqmkCxeYOCF+pCS0oIerOc3RoglKUYKu2sjrZmpmRYq+1 FA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jdys72bmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 16:36:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 286GCWxG001754
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Sep 2022 16:12:33 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 6 Sep 2022 09:12:26 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v12 2/3] phy: qcom-snps: Add support for overriding phy tuning parameters
Date:   Tue, 6 Sep 2022 21:42:08 +0530
Message-ID: <1662480729-10187-3-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662480729-10187-1-git-send-email-quic_kriskura@quicinc.com>
References: <1662480729-10187-1-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T3yHRieGiBO3xhUyTOWN3M8cbFfMJhgA
X-Proofpoint-ORIG-GUID: T3yHRieGiBO3xhUyTOWN3M8cbFfMJhgA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for overriding electrical signal tuning parameters for
SNPS HS Phy.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 252 +++++++++++++++++++++++++-
 1 file changed, 250 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index 5d20378..7a0d01c 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -52,6 +52,12 @@
 #define USB2_SUSPEND_N				BIT(2)
 #define USB2_SUSPEND_N_SEL			BIT(3)
 
+#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0		(0x6c)
+#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1		(0x70)
+#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2		(0x74)
+#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X3		(0x78)
+#define PARAM_OVRD_MASK				0xFF
+
 #define USB2_PHY_USB_PHY_CFG0			(0x94)
 #define UTMI_PHY_DATAPATH_CTRL_OVERRIDE_EN	BIT(0)
 #define UTMI_PHY_CMN_CTRL_OVERRIDE_EN		BIT(1)
@@ -60,12 +66,47 @@
 #define REFCLK_SEL_MASK				GENMASK(1, 0)
 #define REFCLK_SEL_DEFAULT			(0x2 << 0)
 
+#define HS_DISCONNECT_MASK			GENMASK(2, 0)
+#define SQUELCH_DETECTOR_MASK			GENMASK(7, 5)
+
+#define HS_AMPLITUDE_MASK			GENMASK(3, 0)
+#define PREEMPHASIS_DURATION_MASK		BIT(5)
+#define PREEMPHASIS_AMPLITUDE_MASK		GENMASK(7, 6)
+
+#define HS_RISE_FALL_MASK			GENMASK(1, 0)
+#define HS_CROSSOVER_VOLTAGE_MASK		GENMASK(3, 2)
+#define HS_OUTPUT_IMPEDANCE_MASK		GENMASK(5, 4)
+
+#define LS_FS_OUTPUT_IMPEDANCE_MASK		GENMASK(3, 0)
+
 static const char * const qcom_snps_hsphy_vreg_names[] = {
 	"vdda-pll", "vdda33", "vdda18",
 };
 
 #define SNPS_HS_NUM_VREGS		ARRAY_SIZE(qcom_snps_hsphy_vreg_names)
 
+struct override_param {
+	s32	value;
+	u8	reg_val;
+};
+
+struct override_param_map {
+	const char *prop_name;
+	const struct override_param *param_table;
+	u8 table_size;
+	u8 reg_offset;
+	u8 param_mask;
+};
+
+struct phy_override_seq {
+	bool	need_update;
+	u8	offset;
+	u8	value;
+	u8	mask;
+};
+
+#define NUM_HSPHY_TUNING_PARAMS	(9)
+
 /**
  * struct qcom_snps_hsphy - snps hs phy attributes
  *
@@ -91,6 +132,7 @@ struct qcom_snps_hsphy {
 
 	bool phy_initialized;
 	enum phy_mode mode;
+	struct phy_override_seq update_seq_cfg[NUM_HSPHY_TUNING_PARAMS];
 };
 
 static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
@@ -173,10 +215,158 @@ static int qcom_snps_hsphy_set_mode(struct phy *phy, enum phy_mode mode,
 	return 0;
 }
 
+static const struct override_param hs_disconnect_sc7280[] = {
+	{ -272, 0 },
+	{ 0, 1 },
+	{ 317, 2 },
+	{ 630, 3 },
+	{ 973, 4 },
+	{ 1332, 5 },
+	{ 1743, 6 },
+	{ 2156, 7 },
+};
+
+static const struct override_param squelch_det_threshold_sc7280[] = {
+	{ -2090, 7 },
+	{ -1560, 6 },
+	{ -1030, 5 },
+	{ -530, 4 },
+	{ 0, 3 },
+	{ 530, 2 },
+	{ 1060, 1 },
+	{ 1590, 0 },
+};
+
+static const struct override_param hs_amplitude_sc7280[] = {
+	{ -660, 0 },
+	{ -440, 1 },
+	{ -220, 2 },
+	{ 0, 3 },
+	{ 230, 4 },
+	{ 440, 5 },
+	{ 650, 6 },
+	{ 890, 7 },
+	{ 1110, 8 },
+	{ 1330, 9 },
+	{ 1560, 10 },
+	{ 1780, 11 },
+	{ 2000, 12 },
+	{ 2220, 13 },
+	{ 2430, 14 },
+	{ 2670, 15 },
+};
+
+static const struct override_param preemphasis_duration_sc7280[] = {
+	{ 10000, 1 },
+	{ 20000, 0 },
+};
+
+static const struct override_param preemphasis_amplitude_sc7280[] = {
+	{ 10000, 1 },
+	{ 20000, 2 },
+	{ 30000, 3 },
+	{ 40000, 0 },
+};
+
+static const struct override_param hs_rise_fall_time_sc7280[] = {
+	{ -4100, 3 },
+	{ 0, 2 },
+	{ 2810, 1 },
+	{ 5430, 0 },
+};
+
+static const struct override_param hs_crossover_voltage_sc7280[] = {
+	{ -31000, 1 },
+	{ 0, 3 },
+	{ 28000, 2 },
+};
+
+static const struct override_param hs_output_impedance_sc7280[] = {
+	{ -2300000, 3 },
+	{ 0, 2 },
+	{ 2600000, 1 },
+	{ 6100000, 0 },
+};
+
+static const struct override_param ls_fs_output_impedance_sc7280[] = {
+	{ -1053, 15 },
+	{ -557, 7 },
+	{ 0, 3 },
+	{ 612, 1 },
+	{ 1310, 0 },
+};
+
+static const struct override_param_map sc7280_snps_7nm_phy[] = {
+	{
+		"qcom,hs-disconnect-bp",
+		hs_disconnect_sc7280,
+		ARRAY_SIZE(hs_disconnect_sc7280),
+		USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
+		HS_DISCONNECT_MASK
+	},
+	{
+		"qcom,squelch-detector-bp",
+		squelch_det_threshold_sc7280,
+		ARRAY_SIZE(squelch_det_threshold_sc7280),
+		USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
+		SQUELCH_DETECTOR_MASK
+	},
+	{
+		"qcom,hs-amplitude-bp",
+		hs_amplitude_sc7280,
+		ARRAY_SIZE(hs_amplitude_sc7280),
+		USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
+		HS_AMPLITUDE_MASK
+	},
+	{
+		"qcom,pre-emphasis-duration-bp",
+		preemphasis_duration_sc7280,
+		ARRAY_SIZE(preemphasis_duration_sc7280),
+		USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
+		PREEMPHASIS_DURATION_MASK,
+	},
+	{
+		"qcom,pre-emphasis-amplitude-bp",
+		preemphasis_amplitude_sc7280,
+		ARRAY_SIZE(preemphasis_amplitude_sc7280),
+		USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
+		PREEMPHASIS_AMPLITUDE_MASK,
+	},
+	{
+		"qcom,hs-rise-fall-time-bp",
+		hs_rise_fall_time_sc7280,
+		ARRAY_SIZE(hs_rise_fall_time_sc7280),
+		USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
+		HS_RISE_FALL_MASK
+	},
+	{
+		"qcom,hs-crossover-voltage-microvolt",
+		hs_crossover_voltage_sc7280,
+		ARRAY_SIZE(hs_crossover_voltage_sc7280),
+		USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
+		HS_CROSSOVER_VOLTAGE_MASK
+	},
+	{
+		"qcom,hs-output-impedance-micro-ohms",
+		hs_output_impedance_sc7280,
+		ARRAY_SIZE(hs_output_impedance_sc7280),
+		USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
+		HS_OUTPUT_IMPEDANCE_MASK,
+	},
+	{
+		"qcom,ls-fs-output-impedance-bp",
+		ls_fs_output_impedance_sc7280,
+		ARRAY_SIZE(ls_fs_output_impedance_sc7280),
+		USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X3,
+		LS_FS_OUTPUT_IMPEDANCE_MASK,
+	},
+	{},
+};
+
 static int qcom_snps_hsphy_init(struct phy *phy)
 {
 	struct qcom_snps_hsphy *hsphy = phy_get_drvdata(phy);
-	int ret;
+	int ret, i;
 
 	dev_vdbg(&phy->dev, "%s(): Initializing SNPS HS phy\n", __func__);
 
@@ -223,6 +413,14 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_HS_PHY_CTRL1,
 					VBUSVLDEXT0, VBUSVLDEXT0);
 
+	for (i = 0; i < ARRAY_SIZE(hsphy->update_seq_cfg); i++) {
+		if (hsphy->update_seq_cfg[i].need_update)
+			qcom_snps_hsphy_write_mask(hsphy->base,
+					hsphy->update_seq_cfg[i].offset,
+					hsphy->update_seq_cfg[i].mask,
+					hsphy->update_seq_cfg[i].value);
+	}
+
 	qcom_snps_hsphy_write_mask(hsphy->base,
 					USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2,
 					VREGBYPASS, VREGBYPASS);
@@ -280,7 +478,10 @@ static const struct phy_ops qcom_snps_hsphy_gen_ops = {
 static const struct of_device_id qcom_snps_hsphy_of_match_table[] = {
 	{ .compatible	= "qcom,sm8150-usb-hs-phy", },
 	{ .compatible	= "qcom,usb-snps-hs-5nm-phy", },
-	{ .compatible	= "qcom,usb-snps-hs-7nm-phy", },
+	{
+		.compatible	= "qcom,usb-snps-hs-7nm-phy",
+		.data		= &sc7280_snps_7nm_phy,
+	},
 	{ .compatible	= "qcom,usb-snps-femto-v2-phy",	},
 	{ }
 };
@@ -291,6 +492,52 @@ static const struct dev_pm_ops qcom_snps_hsphy_pm_ops = {
 			   qcom_snps_hsphy_runtime_resume, NULL)
 };
 
+static void qcom_snps_hsphy_override_param_update_val(
+			const struct override_param_map map,
+			s32 dt_val, struct phy_override_seq *seq_entry)
+{
+	int i;
+
+	/*
+	 * Param table for each param is in increasing order
+	 * of dt values. We need to iterate over the list to
+	 * select the entry that matches the dt value and pick
+	 * up the corresponding register value.
+	 */
+	for (i = 0; i < map.table_size - 1; i++) {
+		if (map.param_table[i].value == dt_val)
+			break;
+	}
+
+	seq_entry->need_update = true;
+	seq_entry->offset = map.reg_offset;
+	seq_entry->mask = map.param_mask;
+	seq_entry->value = map.param_table[i].reg_val << __ffs(map.param_mask);
+}
+
+static void qcom_snps_hsphy_read_override_param_seq(struct device *dev)
+{
+	struct device_node *node = dev->of_node;
+	s32 val;
+	int ret, i;
+	struct qcom_snps_hsphy *hsphy;
+	const struct override_param_map *cfg = of_device_get_match_data(dev);
+
+	hsphy = dev_get_drvdata(dev);
+
+	for (i = 0; cfg[i].prop_name != NULL; i++) {
+		ret = of_property_read_s32(node, cfg[i].prop_name, &val);
+		if (ret)
+			continue;
+
+		qcom_snps_hsphy_override_param_update_val(cfg[i], val,
+					&hsphy->update_seq_cfg[i]);
+		dev_dbg(&hsphy->phy->dev, "Read param: %s dt_val: %d reg_val: 0x%x\n",
+			cfg[i].prop_name, val, hsphy->update_seq_cfg[i].value);
+
+	}
+}
+
 static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -352,6 +599,7 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, hsphy);
 	phy_set_drvdata(generic_phy, hsphy);
+	qcom_snps_hsphy_read_override_param_seq(dev);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (!IS_ERR(phy_provider))
-- 
2.7.4

