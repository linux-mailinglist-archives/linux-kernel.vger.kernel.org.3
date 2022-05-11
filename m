Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6547D523746
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbiEKP1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343708AbiEKP1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:27:01 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C44250B32;
        Wed, 11 May 2022 08:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652282819; x=1683818819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=r4WzfYXCF4xrMYBwXxL8x/YcPGndJphykDumlO9Y6lo=;
  b=Fs5sAO9BtrUKqvMJsgL921GuwO6O8xHm1DhGOhRTYMKcnV17hploISY9
   GviBwbsx1s1v08aMLZ/3x78IxykH6/ncXRGobBx3WCEUn3/Ut3rw/6asb
   Dey+b8Gv+uAge5L39UPDSlbVtitdoFVVp6SblZradVBgbTBlHXd0i5XnB
   k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 May 2022 08:26:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:26:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 08:26:58 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 08:26:52 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [v4 2/3] phy: qcom-snps: Add support for overriding phy tuning parameters
Date:   Wed, 11 May 2022 20:56:32 +0530
Message-ID: <1652282793-5580-3-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652282793-5580-1-git-send-email-quic_kriskura@quicinc.com>
References: <1652282793-5580-1-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for overriding electrical signal tuning parameters for
SNPS HS Phy.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 267 +++++++++++++++++++++++++-
 1 file changed, 265 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index 5d20378..7d154e7 100644
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
@@ -60,12 +66,76 @@
 #define REFCLK_SEL_MASK				GENMASK(1, 0)
 #define REFCLK_SEL_DEFAULT			(0x2 << 0)
 
+#define HS_DISCONNECT_MASK			GENMASK(2, 0)
+
+#define SQUELCH_DETECTOR_MASK			GENMASK(7, 5)
+
+#define HS_AMPLITUDE_MASK			GENMASK(3, 0)
+
+#define PREEMPHASIS_DURATION_MASK		BIT(5)
+
+#define PREEMPHASIS_AMPLITUDE_MASK		GENMASK(7, 6)
+
+#define HS_RISE_FALL_MASK			GENMASK(1, 0)
+
+#define HS_CROSSOVER_VOLTAGE_MASK		GENMASK(3, 2)
+
+#define HS_OUTPUT_IMPEDANCE_MASK		GENMASK(5, 4)
+
+#define LS_FS_OUTPUT_IMPEDANCE_MASK		GENMASK(3, 0)
+
+
 static const char * const qcom_snps_hsphy_vreg_names[] = {
 	"vdda-pll", "vdda33", "vdda18",
 };
 
 #define SNPS_HS_NUM_VREGS		ARRAY_SIZE(qcom_snps_hsphy_vreg_names)
 
+struct override_param {
+	s32	value;
+	u8	reg;
+};
+
+#define OVERRIDE_PARAM(bps, val)\
+{				\
+	.value = bps,		\
+	.reg = val,		\
+}
+
+struct override_param_map {
+	struct override_param *param_table;
+	u8 table_size;
+	u8 reg_offset;
+	u8 param_mask;
+};
+
+#define OVERRIDE_PARAM_MAP(table, num_elements, offset, mask)		\
+{									\
+	.param_table = table,						\
+	.table_size = num_elements,					\
+	.reg_offset = offset,						\
+	.param_mask = mask,						\
+}
+
+struct phy_override_seq {
+	bool	need_update;
+	u8	offset;
+	u8	value;
+	u8	mask;
+};
+
+static const char *phy_seq_props[] = {
+	"qcom,hs-disconnect-bps",
+	"qcom,squelch-detector-bps",
+	"qcom,hs-amplitude-bps",
+	"qcom,preemphasis-duration-bps",
+	"qcom,preemphasis-amplitude-bps",
+	"qcom,hs-rise-fall-time-bps",
+	"qcom,hs-crossover-voltage-mv",
+	"qcom,hs-output-impedance-mohm",
+	"qcom,ls-fs-output-impedance-bps",
+};
+
 /**
  * struct qcom_snps_hsphy - snps hs phy attributes
  *
@@ -91,6 +161,7 @@ struct qcom_snps_hsphy {
 
 	bool phy_initialized;
 	enum phy_mode mode;
+	struct phy_override_seq update_seq_cfg[ARRAY_SIZE(phy_seq_props)];
 };
 
 static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
@@ -173,10 +244,147 @@ static int qcom_snps_hsphy_set_mode(struct phy *phy, enum phy_mode mode,
 	return 0;
 }
 
+static struct override_param hs_disconnect_sc7280[] = {
+	OVERRIDE_PARAM(-272, 0),
+	OVERRIDE_PARAM(0, 1),
+	OVERRIDE_PARAM(317, 2),
+	OVERRIDE_PARAM(630, 3),
+	OVERRIDE_PARAM(973, 4),
+	OVERRIDE_PARAM(1332, 5),
+	OVERRIDE_PARAM(1743, 6),
+	OVERRIDE_PARAM(2156, 7),
+};
+
+static struct override_param squelch_det_threshold_sc7280[] = {
+	OVERRIDE_PARAM(-2090, 7),
+	OVERRIDE_PARAM(-1560, 6),
+	OVERRIDE_PARAM(-1030, 5),
+	OVERRIDE_PARAM(-530, 4),
+	OVERRIDE_PARAM(0, 3),
+	OVERRIDE_PARAM(530, 2),
+	OVERRIDE_PARAM(1060, 1),
+	OVERRIDE_PARAM(1590, 0),
+};
+
+static struct override_param hs_amplitude_sc7280[] = {
+	OVERRIDE_PARAM(-660, 0),
+	OVERRIDE_PARAM(-440, 1),
+	OVERRIDE_PARAM(-220, 2),
+	OVERRIDE_PARAM(0, 3),
+	OVERRIDE_PARAM(230, 4),
+	OVERRIDE_PARAM(440, 5),
+	OVERRIDE_PARAM(650, 6),
+	OVERRIDE_PARAM(890, 7),
+	OVERRIDE_PARAM(1110, 8),
+	OVERRIDE_PARAM(1330, 9),
+	OVERRIDE_PARAM(1560, 10),
+	OVERRIDE_PARAM(1780, 11),
+	OVERRIDE_PARAM(2000, 12),
+	OVERRIDE_PARAM(2220, 13),
+	OVERRIDE_PARAM(2430, 14),
+	OVERRIDE_PARAM(2670, 15),
+};
+
+static struct override_param preemphasis_duration_sc7280[] = {
+	OVERRIDE_PARAM(100, 1),
+	OVERRIDE_PARAM(200, 0),
+};
+
+static struct override_param preemphasis_amplitude_sc7280[] = {
+	OVERRIDE_PARAM(100, 1),
+	OVERRIDE_PARAM(200, 2),
+	OVERRIDE_PARAM(300, 3),
+	OVERRIDE_PARAM(400, 0),
+};
+
+static struct override_param hs_rise_fall_time_sc7280[] = {
+	OVERRIDE_PARAM(-4100, 3),
+	OVERRIDE_PARAM(0, 2),
+	OVERRIDE_PARAM(2810, 1),
+	OVERRIDE_PARAM(5430, 0),
+};
+
+static struct override_param hs_crossover_voltage_sc7280[] = {
+	OVERRIDE_PARAM(-31, 1),
+	OVERRIDE_PARAM(28, 2),
+	OVERRIDE_PARAM(0, 3),
+};
+
+static struct override_param hs_output_impedance_sc7280[] = {
+	OVERRIDE_PARAM(-2300, 3),
+	OVERRIDE_PARAM(0, 2),
+	OVERRIDE_PARAM(2600, 1),
+	OVERRIDE_PARAM(6100, 0),
+};
+
+static struct override_param ls_fs_output_impedance_sc7280[] = {
+	OVERRIDE_PARAM(-1053, 15),
+	OVERRIDE_PARAM(-557, 7),
+	OVERRIDE_PARAM(0, 3),
+	OVERRIDE_PARAM(612, 1),
+	OVERRIDE_PARAM(1310, 0),
+};
+
+struct override_param_map sc7280_idp[] = {
+	OVERRIDE_PARAM_MAP(
+			hs_disconnect_sc7280,
+			ARRAY_SIZE(hs_disconnect_sc7280),
+			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
+			HS_DISCONNECT_MASK),
+
+	OVERRIDE_PARAM_MAP(
+			squelch_det_threshold_sc7280,
+			ARRAY_SIZE(squelch_det_threshold_sc7280),
+			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
+			SQUELCH_DETECTOR_MASK),
+
+	OVERRIDE_PARAM_MAP(
+			hs_amplitude_sc7280,
+			ARRAY_SIZE(hs_amplitude_sc7280),
+			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
+			HS_AMPLITUDE_MASK),
+
+	OVERRIDE_PARAM_MAP(
+			preemphasis_duration_sc7280,
+			ARRAY_SIZE(preemphasis_duration_sc7280),
+			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
+			PREEMPHASIS_DURATION_MASK),
+
+	OVERRIDE_PARAM_MAP(
+			preemphasis_amplitude_sc7280,
+			ARRAY_SIZE(preemphasis_amplitude_sc7280),
+			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
+			PREEMPHASIS_AMPLITUDE_MASK),
+
+	OVERRIDE_PARAM_MAP(
+			hs_rise_fall_time_sc7280,
+			ARRAY_SIZE(hs_rise_fall_time_sc7280),
+			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
+			HS_RISE_FALL_MASK),
+
+	OVERRIDE_PARAM_MAP(
+			hs_crossover_voltage_sc7280,
+			ARRAY_SIZE(hs_crossover_voltage_sc7280),
+			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
+			HS_CROSSOVER_VOLTAGE_MASK),
+
+	OVERRIDE_PARAM_MAP(
+			hs_output_impedance_sc7280,
+			ARRAY_SIZE(hs_output_impedance_sc7280),
+			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
+			HS_OUTPUT_IMPEDANCE_MASK),
+
+	OVERRIDE_PARAM_MAP(
+			ls_fs_output_impedance_sc7280,
+			ARRAY_SIZE(ls_fs_output_impedance_sc7280),
+			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X3,
+			LS_FS_OUTPUT_IMPEDANCE_MASK),
+};
+
 static int qcom_snps_hsphy_init(struct phy *phy)
 {
 	struct qcom_snps_hsphy *hsphy = phy_get_drvdata(phy);
-	int ret;
+	int ret, i;
 
 	dev_vdbg(&phy->dev, "%s(): Initializing SNPS HS phy\n", __func__);
 
@@ -223,6 +431,14 @@ static int qcom_snps_hsphy_init(struct phy *phy)
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
@@ -280,7 +496,10 @@ static const struct phy_ops qcom_snps_hsphy_gen_ops = {
 static const struct of_device_id qcom_snps_hsphy_of_match_table[] = {
 	{ .compatible	= "qcom,sm8150-usb-hs-phy", },
 	{ .compatible	= "qcom,usb-snps-hs-5nm-phy", },
-	{ .compatible	= "qcom,usb-snps-hs-7nm-phy", },
+	{
+		.compatible	= "qcom,usb-snps-hs-7nm-phy",
+		.data		= &sc7280_idp,
+	},
 	{ .compatible	= "qcom,usb-snps-femto-v2-phy",	},
 	{ }
 };
@@ -291,6 +510,49 @@ static const struct dev_pm_ops qcom_snps_hsphy_pm_ops = {
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
+	 * select the entry that has equal or the next highest value.
+	 */
+	for (i = 0 ; i < map.table_size-1; i++) {
+		if (map.param_table[i].value >= dt_val)
+			break;
+	}
+
+	seq_entry->need_update = true;
+	seq_entry->offset = map.reg_offset;
+	seq_entry->mask = map.param_mask;
+	seq_entry->value =  map.param_table[i].reg << __ffs(map.param_mask);
+}
+
+static void qcom_snps_hsphy_read_override_param_seq(struct device *dev)
+{
+	struct device_node *node = dev->of_node;
+	s32 val;
+	int ret, i;
+	struct qcom_snps_hsphy *hsphy;
+	struct override_param_map *cfg = of_device_get_match_data(dev);
+
+	hsphy = dev_get_drvdata(dev);
+
+	for (i = 0; i < ARRAY_SIZE(phy_seq_props); i++) {
+		ret = of_property_read_s32(node, phy_seq_props[i], &val);
+		if (!ret) {
+			dev_dbg(&hsphy->phy->dev, "Read param: %s val: %d\n",
+						phy_seq_props[i], val);
+			qcom_snps_hsphy_override_param_update_val(cfg[i], val,
+						&hsphy->update_seq_cfg[i]);
+		}
+	}
+}
+
 static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -352,6 +614,7 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, hsphy);
 	phy_set_drvdata(generic_phy, hsphy);
+	qcom_snps_hsphy_read_override_param_seq(dev);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (!IS_ERR(phy_provider))
-- 
2.7.4

