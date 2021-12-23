Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC8947DF0E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242286AbhLWG1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:27:11 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:50200 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232444AbhLWG1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:27:10 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BMN45ku002320;
        Wed, 22 Dec 2021 22:27:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=JjT7CiBTd8oFk6y4G/0DgaLt/Yhg0WdpUuVz5SsLryA=;
 b=ca3Pl4w4/7Hjf1UfNjGCh6pqWQB65tR6tAJjD90PtSDQQ5l2jopKAxpP+tQYmnUuzPN9
 YAIElgWzIjBR5WZ3dhGnNYKXiinqmvfSzwv/p0OoZS6UYGBlSyxuAM82ae2fv7xcAjF/
 XDDITCiCns3/bhbfGCRVlK/KdjU0rCG06E8LLyet7VOdRFBzju7/+Iaxe+I1EzVnT2Is
 UotbZ9+OAOCCJpWrdngzQvlDCQ2QMAH/fV6GD9iqlEY1K2ybDzsfoBK2NmsJndI85NoW
 tAGZKU2SsMvFaIn9+uN832ODFU1JsIsXx/Wq/PMLGBG+s4KKvssDYpjJ4UIDwnuQ2esb JQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3d411ru6ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:26:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqIafPf9o9ScLhNZ271KGDO/zPlBgCcoa9NDWz0Bq+hxZqN0/g56gOHvDI4nJ0o3QHl8hvgig0vAC2d60+vgYbIC+Gc8rqdyyahOG/AkYO/WJt8r2gEpHNqb/KkxY7ui2D6OaHC0w4/CXJgF87vVIAOKjlcX/4qirxKTEo4ouvt7yIpFA66WD/36Xsfpcnb0gr88yL4JGGbcXME+yxxOhNaWde3V68uOgBDMJGf0/4NqXcNbB4RrRIOKmt41C7K4A3kdibdcvKwsfBTSJc3CJoRYVYojGedMRsXC5XhXmRizqnUFFGMyHW6okOnfIvIhBDihoUDP2lACz7hl082UCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjT7CiBTd8oFk6y4G/0DgaLt/Yhg0WdpUuVz5SsLryA=;
 b=jEwV+NV1eExg9BtdSCm1aFiOfajhQKBOOl3xbPxBWhbsB7Ls9+Vg6WhXflNXcgU/pPFnS060aKxtD3wvKF9p31y5Ot4U4nSPjHTBWbdQXJGDV3lHlAs9diEziCMr9B7ALLT7w2z+nm7jXq2ywSdtwRuYNShIl3sisxuwS2p0xXCQ/CaWa/a9kmmL806VHES5nH4tXO6sLeb35IT9ZNzEw44wtRwbbIZdr++MPHWDNWx7CCGRRGB5SjPXGvPOiSqP+XLBy9/Appbs/2hgNmCPxkqMwP/RoaLf6SUTcnr83Vc1SeSZHgROUYw3xCL9gmAXnUcbCyNHzkUc10UBLBMscg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjT7CiBTd8oFk6y4G/0DgaLt/Yhg0WdpUuVz5SsLryA=;
 b=YO1pi3/EcJT/AJ6rVo07G/owqiBs7HAHcpKBnrY8GFQT8xuikLvDl+L8vySm7Fwby9dB05YiKj25oEntTAeuXug4o1Mq5zT+Y4Jt9CnVxCWSxk3J1AY+QOPCnGeV1flNY7eacvOeSf5IClzcJq7TjeP9GY1x7KeFAvzGIuWJK4Q=
Received: from DM6PR21CA0022.namprd21.prod.outlook.com (2603:10b6:5:174::32)
 by BY5PR07MB6997.namprd07.prod.outlook.com (2603:10b6:a03:1ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 06:26:55 +0000
Received: from DM6NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::a7) by DM6PR21CA0022.outlook.office365.com
 (2603:10b6:5:174::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.4 via Frontend
 Transport; Thu, 23 Dec 2021 06:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT003.mail.protection.outlook.com (10.13.179.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:26:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6QscD020522
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:26:55 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:26:47 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:26:35 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:26:29 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6OqUN022355;
        Thu, 23 Dec 2021 07:25:25 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN6Oq5H022354;
        Thu, 23 Dec 2021 07:24:52 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 15/15] phy: cadence: Sierra: Add support for derived reference clock output
Date:   Thu, 23 Dec 2021 07:01:37 +0100
Message-ID: <20211223060137.9252-16-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae4fc2db-1d98-417a-fee0-08d9c5dd36cc
X-MS-TrafficTypeDiagnostic: BY5PR07MB6997:EE_
X-Microsoft-Antispam-PRVS: <BY5PR07MB6997189422DBDF81AC88CAF2C57E9@BY5PR07MB6997.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPdN+5L2p1LRyatB9xo2e6G6z58OnfXJNtJsvOb2OclFToaAtCfwdMUVS7Y9Rc0Zcs1glJilCwaMkiqDdn9ixR1SYgCzanfa4bgqrKgzjVPrkb70B6hYvm0VYWKPC2LaQEjjfx9378v/d/DCpyf85tFchJjnS78mNmxLA4RqOegBGrjeV+txsLvrw+SKkzdc7HopKAfRSNWIwmkoOjpJ2MH2Zh8at+TQSrgKi5vJ7/ks95xcEmYFeEcOLz//AzSgpqUZ7XHzyyczj9f35SNeRaS5c98Q48Q7nCVdfSx9So06r7NOdC3czecbJcFyaBbuN8++ZD6DSFt8p4gDgzU2PUVp/2dCfHC581TEINc2hOJIpq6h5aoVTLJKNL6/GUQzE2XU7DjoTlBwm1C2o2UzpmEGqq4h9XDhTQgJ3qQlTq+0uhH1GR5q6ZLwS/f1h3ZQ7PoJKtWus2LQCX22Wd08rj0CmGzdYFW4RroYHuysW7rlI4igfnVUW4JbyentaDw6tIai4M+6hUcyxjy8ZUIIlzFhLuwBFVkZMCrXjJrTV3NEWbvcjYCXODBX3S43yDNjVZncMU/NbKCAWStS+1NxZfyeK+DeH9VUpaZwfXWoYeUgY31oOTJ0Le7uV/d/WpyibkYST8SwZzqLsx+uvuaC4GnCbx0cavnK/QR2U9QkUwh2plYfx8r+dE98sXpGbcHbCfiw4aGB5J4zt3LlNrmEJfopN03p02RChSK/OAlyn286Q47Vzzz9LemuB/PmxxkneALWnP/jjsRa36QNnKEmT/gB27O37s8FI01Zm3LKRNTQVBFrLPWGFc8ws+0SIYhb1Wedjve/wnjGiA5Mnrdczw==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(40470700002)(36840700001)(46966006)(86362001)(356005)(36860700001)(426003)(7636003)(47076005)(4326008)(82310400004)(8676002)(26005)(70206006)(70586007)(8936002)(186003)(336012)(316002)(42186006)(508600001)(110136005)(40460700001)(2906002)(5660300002)(2616005)(1076003)(36756003)(54906003)(83380400001)(6666004)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:26:54.6546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4fc2db-1d98-417a-fee0-08d9c5dd36cc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT003.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6997
X-Proofpoint-ORIG-GUID: yICFwlzp22XZ48Z_lNoXSfl6vUwgEFG8
X-Proofpoint-GUID: yICFwlzp22XZ48Z_lNoXSfl6vUwgEFG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_01,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sierra has derived differential reference clock output which is sourced
after the spread spectrum generation has been added. Add support to drive
derived reference clock out of serdes. Model this derived clock as a
"clock" so that platforms using this can enable it.

Sierra Main LC VCO PLL divider 1 clock is programmed to output 100MHz
clock output.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 109 ++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index e2b0530ca04c..da24acd26666 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -34,6 +34,7 @@
 #define SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG		0x49
 #define SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG		0x4A
 #define SIERRA_CMN_PLLLC_LOCK_CNTSTART_PREG		0x4B
+#define SIERRA_CMN_PLLLC_CLK1_PREG			0x4D
 #define SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG		0x4F
 #define SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG		0x50
 #define SIERRA_CMN_PLLLC_DSMCORR_PREG			0x51
@@ -203,7 +204,7 @@
 #define SIERRA_MAX_LANES				16
 #define PLL_LOCK_TIME					100000
 
-#define CDNS_SIERRA_OUTPUT_CLOCKS			2
+#define CDNS_SIERRA_OUTPUT_CLOCKS			3
 #define CDNS_SIERRA_INPUT_CLOCKS			5
 enum cdns_sierra_clock_input {
 	PHY_CLK,
@@ -226,10 +227,15 @@ static const struct reg_field pllctrl_lock =
 				REG_FIELD(SIERRA_PLLCTRL_STATUS_PREG, 0, 0);
 static const struct reg_field phy_iso_link_ctrl_1 =
 				REG_FIELD(SIERRA_PHY_ISO_LINK_CTRL, 1, 1);
+static const struct reg_field cmn_plllc_clk1outdiv_preg =
+				REG_FIELD(SIERRA_CMN_PLLLC_CLK1_PREG, 0, 6);
+static const struct reg_field cmn_plllc_clk1_en_preg =
+				REG_FIELD(SIERRA_CMN_PLLLC_CLK1_PREG, 12, 12);
 
 static const char * const clk_names[] = {
 	[CDNS_SIERRA_PLL_CMNLC] = "pll_cmnlc",
 	[CDNS_SIERRA_PLL_CMNLC1] = "pll_cmnlc1",
+	[CDNS_SIERRA_DERIVED_REFCLK] = "refclk_der",
 };
 
 enum cdns_sierra_cmn_plllc {
@@ -277,6 +283,16 @@ static u32 cdns_sierra_pll_mux_table[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
 	[CMN_PLLLC1] = { 1, 0 },
 };
 
+struct cdns_sierra_derived_refclk {
+	struct clk_hw           hw;
+	struct regmap_field     *cmn_plllc_clk1outdiv_preg;
+	struct regmap_field     *cmn_plllc_clk1_en_preg;
+	struct clk_init_data	clk_data;
+};
+
+#define to_cdns_sierra_derived_refclk(_hw)	\
+			container_of(_hw, struct cdns_sierra_derived_refclk, hw)
+
 enum cdns_sierra_phy_type {
 	TYPE_NONE,
 	TYPE_PCIE,
@@ -766,6 +782,91 @@ static int cdns_sierra_phy_register_pll_mux(struct cdns_sierra_phy *sp)
 	return 0;
 }
 
+static int cdns_sierra_derived_refclk_enable(struct clk_hw *hw)
+{
+	struct cdns_sierra_derived_refclk *derived_refclk = to_cdns_sierra_derived_refclk(hw);
+
+	regmap_field_write(derived_refclk->cmn_plllc_clk1_en_preg, 0x1);
+
+	/* Programming to get 100Mhz clock output in ref_der_clk_out 5GHz VCO/50 = 100MHz */
+	regmap_field_write(derived_refclk->cmn_plllc_clk1outdiv_preg, 0x2E);
+
+	return 0;
+}
+
+static void cdns_sierra_derived_refclk_disable(struct clk_hw *hw)
+{
+	struct cdns_sierra_derived_refclk *derived_refclk = to_cdns_sierra_derived_refclk(hw);
+
+	regmap_field_write(derived_refclk->cmn_plllc_clk1_en_preg, 0);
+}
+
+static int cdns_sierra_derived_refclk_is_enabled(struct clk_hw *hw)
+{
+	struct cdns_sierra_derived_refclk *derived_refclk = to_cdns_sierra_derived_refclk(hw);
+	int val;
+
+	regmap_field_read(derived_refclk->cmn_plllc_clk1_en_preg, &val);
+
+	return !!val;
+}
+
+static const struct clk_ops cdns_sierra_derived_refclk_ops = {
+	.enable = cdns_sierra_derived_refclk_enable,
+	.disable = cdns_sierra_derived_refclk_disable,
+	.is_enabled = cdns_sierra_derived_refclk_is_enabled,
+};
+
+static int cdns_sierra_derived_refclk_register(struct cdns_sierra_phy *sp)
+{
+	struct cdns_sierra_derived_refclk *derived_refclk;
+	struct device *dev = sp->dev;
+	struct regmap_field *field;
+	struct clk_init_data *init;
+	struct regmap *regmap;
+	char clk_name[100];
+	struct clk *clk;
+
+	derived_refclk = devm_kzalloc(dev, sizeof(*derived_refclk), GFP_KERNEL);
+	if (!derived_refclk)
+		return -ENOMEM;
+
+	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
+		 clk_names[CDNS_SIERRA_DERIVED_REFCLK]);
+
+	init = &derived_refclk->clk_data;
+
+	init->ops = &cdns_sierra_derived_refclk_ops;
+	init->flags = 0;
+	init->name = clk_name;
+
+	regmap = sp->regmap_common_cdb;
+
+	field = devm_regmap_field_alloc(dev, regmap, cmn_plllc_clk1outdiv_preg);
+	if (IS_ERR(field)) {
+		dev_err(dev, "cmn_plllc_clk1outdiv_preg reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	derived_refclk->cmn_plllc_clk1outdiv_preg = field;
+
+	field = devm_regmap_field_alloc(dev, regmap, cmn_plllc_clk1_en_preg);
+	if (IS_ERR(field)) {
+		dev_err(dev, "cmn_plllc_clk1_en_preg reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	derived_refclk->cmn_plllc_clk1_en_preg = field;
+
+	derived_refclk->hw.init = init;
+
+	clk = devm_clk_register(dev, &derived_refclk->hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	sp->output_clks[CDNS_SIERRA_DERIVED_REFCLK] = clk;
+
+	return 0;
+}
+
 static void cdns_sierra_clk_unregister(struct cdns_sierra_phy *sp)
 {
 	struct device *dev = sp->dev;
@@ -786,6 +887,12 @@ static int cdns_sierra_clk_register(struct cdns_sierra_phy *sp)
 		return ret;
 	}
 
+	ret = cdns_sierra_derived_refclk_register(sp);
+	if (ret) {
+		dev_err(dev, "Failed to register derived refclk\n");
+		return ret;
+	}
+
 	sp->clk_data.clks = sp->output_clks;
 	sp->clk_data.clk_num = CDNS_SIERRA_OUTPUT_CLOCKS;
 	ret = of_clk_add_provider(node, of_clk_src_onecell_get, &sp->clk_data);
-- 
2.26.1

