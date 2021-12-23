Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE4647DEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346510AbhLWGG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:06:27 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:40964 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238776AbhLWGG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:06:26 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN4F4RO005438;
        Wed, 22 Dec 2021 22:06:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=3fNMjXY5Yo3EUBn8euP3yHJDH41JACdnwDYdNTjWkps=;
 b=sqpNBZlg1aMvC2tBN6ZXOwXx1KIAIrDs7YE/TJM4r8T/25sKUn/Sp++I79g7PLwWhvzA
 mRP4e2TCnH9ryPvMl74iUfyI41CvAQuJ+w25/sms1Ki3Swfb50Jqkzgrlvhn8EYNfizv
 MX7gFTYrvuBKdFy0DX8kmIINLrUpcc04C6MfNio8jG/N4wSnQovszH0mqakMw+MRUDw2
 cywb5kocYJYS43BzB6YorOE0/nqzHBy1y7Y/CcP+ToCk/tWJl5xZ1K2RH9jmUBS+Fuf+
 X+flh45Kxr5mHl5+v6T80BWiGl9cuRc1MxvgpKnxdVIlS+hO4m4yTuX51WZta/4lImkh jw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3d3rwxvjth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:06:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czw+2GhlMc3g/CaCIBBxkP43KcpjgkUrXZJTfLM3yr1AgCaOf/Cg4+luJ8vMEoA1VEFEGMPppmawrfhsfD0lToq2HtWSVt7UaJbHoGqj0EbRActWoGz3lO0eMgdpcsQQKWQBON9xFrldqKkAyllraOzdsH0EkuKE1u+lmOtOB6YMfdJqBmWEt1u0QZI62iht2uhcEcBmmb7bvMVvt21YHYu5qQyRxyoy80zkZe7h6Ck4td6ehHCMk1qPF95I845Hm71JkZf9KFYUhO/qAPRBXcb9+M5Vs1IvkiAcgAASZ90CGUyltj/5tv+C0tYJZALBFGJHkicvQAUeH8GjHAbqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fNMjXY5Yo3EUBn8euP3yHJDH41JACdnwDYdNTjWkps=;
 b=SDfb4iMXi9jM9n0+RKu273AspBhmp4n9QxOGl1i5+xR8XnhCXGtVSgrlq4NBWTO/iv3bAlGTXWQVmkyEkTlgd9KAxVH06yX5o+nJkMcJrVQ77mvDc+Vo13Od4fg1OzsttUK6Qbd3qIXOWZ5Pu1feuSq4Ku0Z8usFiuLQosGcwZMGqb8C6ehIORnc25dBN3vXDKSRrchVGMV6ANED37qJIjudTg2AIl6dt28I4XtF3Cczs2hZrV7svhiFIfDxqK+jiIKPebAvm26xfWe3+DNt/ZYyZQXsEuDNk1PcbqtkIzfpLfQ3xPqgHrkheEuMDcUm61ouL+HSf7xFzxRPIHVG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fNMjXY5Yo3EUBn8euP3yHJDH41JACdnwDYdNTjWkps=;
 b=ufU4NDpWeSTyw32jvRKAXZzTFt0wRpEW0ITqk50CpF7mm1hYJ7qnWIb/2Vwvo+pc/pC4nrpJMvOjH53FbCdYr4Xll9C9nKMPVnyxRU+ok5UknggX5Q6218RheoHI9QSXzPcJeIZkChPIP5biaIxpnrdPDV5qXO9geFegDrxHVBw=
Received: from DM5PR19CA0062.namprd19.prod.outlook.com (2603:10b6:3:116::24)
 by DM6PR07MB5290.namprd07.prod.outlook.com (2603:10b6:5:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 06:06:13 +0000
Received: from DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::be) by DM5PR19CA0062.outlook.office365.com
 (2603:10b6:3:116::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Thu, 23 Dec 2021 06:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT050.mail.protection.outlook.com (10.13.178.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:06:13 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN66D5H021540
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:06:14 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:06:12 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:06:12 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:06:12 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN64aH8010649;
        Thu, 23 Dec 2021 07:05:08 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN64ZY3010632;
        Thu, 23 Dec 2021 07:04:35 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 02/15] phy: cadence: Sierra: Prepare driver to add support for multilink configurations
Date:   Thu, 23 Dec 2021 07:01:24 +0100
Message-ID: <20211223060137.9252-3-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c5e95b3-8d29-4ec1-13bb-08d9c5da52dc
X-MS-TrafficTypeDiagnostic: DM6PR07MB5290:EE_
X-Microsoft-Antispam-PRVS: <DM6PR07MB5290C99BEE26EFDBA0A76976C57E9@DM6PR07MB5290.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0EElkO21SLmsfJ6Ze+JU53rB5voABJOmesL0RAn5ozxmmZK2GAErI9LnLMKyRUwbTdZbOSev3iHFdRinh2LM8LPhG/z11hEkEAfAfLAgcpxr9s+aEU7diV18wSc1MqXt++2nDxBEeeisuiX/7XEP6kZpIE+TDr8TEAZ51Gr+qvlc1Wo6qarWEFjmQOTx+gxMMx33sc1jhwHxTzXvnGZneR0jELw8QP0qlney8QFkVjn6SkGjFHL6hwcPV18Qgqhg+maRjoaMagepU8ZgCs2J6u5HOkeZH7A1X9RmHQPqsb48OhFDouzgBy20fvDtHxuilVC4HGR4y1GAz3DlZBYvKwPeqfwfXsnw4tRD9XKYoPlwplM9f0X+RG3ZPwU05sIUmbaNl3kgAVeWcpjDPEmAYGzzW7qPOPpFuDkTgpXfzvlwvCG7/d++fjvsZd8r5M5a55uyvctWoJdWbtdsLtxUpqbfHNgvpEv8JX0Y56kL8CGzY+/MNyyvRGMu2rECBfjwmSGQ2nnWLc9Ro5wgOzfUtH3xrU5pYOtVtLOXAOZ84gIdFpxi1JY4s6HrX2EW57tzy3tc7WKduI361xIZtumKYjiqqjmBz05wQ4TzpGS6bmklJ0c2vzf1/kO2g63JoIxgh5y8Ehos2LiAfdL0I0B8y5AMleO1Ap/jrBXH1mMZeBNwqAlngsjaAEzWVgDSofP5vOOAtr7bTFw9g13SpxgH9Xq7+9XCdWewB4eHJDcpu6dk0iET7BjzfZgjI+dNGhaiPlBOgQcto31yeme/oq4sjIvoaOqBcxcfREcRNSzv97U=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(40470700002)(36860700001)(8676002)(42186006)(316002)(508600001)(47076005)(336012)(7636003)(70206006)(70586007)(2906002)(19627235002)(4326008)(86362001)(83380400001)(40460700001)(356005)(110136005)(2616005)(6666004)(54906003)(426003)(36756003)(5660300002)(26005)(8936002)(82310400004)(1076003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:06:13.2395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5e95b3-8d29-4ec1-13bb-08d9c5da52dc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5290
X-Proofpoint-ORIG-GUID: K1yuaH5fVc-8ec8dIH6aWMbLcQqIdt-3
X-Proofpoint-GUID: K1yuaH5fVc-8ec8dIH6aWMbLcQqIdt-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_01,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112230034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sierra driver currently supports single link configurations only. Prepare
driver to support multilink multiprotocol configurations along with
different SSC modes.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 195 ++++++++++++++++-------
 1 file changed, 139 insertions(+), 56 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 54d1c63932ac..c82ac6716f5e 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -23,6 +23,9 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/phy/phy-cadence.h>
 
+#define NUM_SSC_MODE		3
+#define NUM_PHY_TYPE		3
+
 /* PHY register offsets */
 #define SIERRA_COMMON_CDB_OFFSET			0x0
 #define SIERRA_MACRO_ID_REG				0x0
@@ -217,9 +220,21 @@ static const int pll_mux_parent_index[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
 
 static u32 cdns_sierra_pll_mux_table[] = { 0, 1 };
 
+enum cdns_sierra_phy_type {
+	TYPE_NONE,
+	TYPE_PCIE,
+	TYPE_USB
+};
+
+enum cdns_sierra_ssc_mode {
+	NO_SSC,
+	EXTERNAL_SSC,
+	INTERNAL_SSC
+};
+
 struct cdns_sierra_inst {
 	struct phy *phy;
-	u32 phy_type;
+	enum cdns_sierra_phy_type phy_type;
 	u32 num_lanes;
 	u32 mlane;
 	struct reset_control *lnk_rst;
@@ -230,18 +245,19 @@ struct cdns_reg_pairs {
 	u32 off;
 };
 
+struct cdns_sierra_vals {
+	const struct cdns_reg_pairs *reg_pairs;
+	u32 num_regs;
+};
+
 struct cdns_sierra_data {
-		u32 id_value;
-		u8 block_offset_shift;
-		u8 reg_offset_shift;
-		u32 pcie_cmn_regs;
-		u32 pcie_ln_regs;
-		u32 usb_cmn_regs;
-		u32 usb_ln_regs;
-		const struct cdns_reg_pairs *pcie_cmn_vals;
-		const struct cdns_reg_pairs *pcie_ln_vals;
-		const struct cdns_reg_pairs *usb_cmn_vals;
-		const struct cdns_reg_pairs *usb_ln_vals;
+	u32 id_value;
+	u8 block_offset_shift;
+	u8 reg_offset_shift;
+	struct cdns_sierra_vals *pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					     [NUM_SSC_MODE];
+	struct cdns_sierra_vals *pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					    [NUM_SSC_MODE];
 };
 
 struct cdns_regmap_cdb_context {
@@ -341,10 +357,14 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 {
 	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
 	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
+	const struct cdns_sierra_data *init_data = phy->init_data;
+	struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
+	enum cdns_sierra_phy_type phy_type = ins->phy_type;
+	enum cdns_sierra_ssc_mode ssc = EXTERNAL_SSC;
+	const struct cdns_reg_pairs *reg_pairs;
 	struct regmap *regmap;
+	u32 num_regs;
 	int i, j;
-	const struct cdns_reg_pairs *cmn_vals, *ln_vals;
-	u32 num_cmn_regs, num_ln_regs;
 
 	/* Initialise the PHY registers, unless auto configured */
 	if (phy->autoconf)
@@ -352,28 +372,26 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 
 	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
 	clk_set_rate(phy->input_clks[CMN_REFCLK1_DIG_DIV], 25000000);
-	if (ins->phy_type == PHY_TYPE_PCIE) {
-		num_cmn_regs = phy->init_data->pcie_cmn_regs;
-		num_ln_regs = phy->init_data->pcie_ln_regs;
-		cmn_vals = phy->init_data->pcie_cmn_vals;
-		ln_vals = phy->init_data->pcie_ln_vals;
-	} else if (ins->phy_type == PHY_TYPE_USB3) {
-		num_cmn_regs = phy->init_data->usb_cmn_regs;
-		num_ln_regs = phy->init_data->usb_ln_regs;
-		cmn_vals = phy->init_data->usb_cmn_vals;
-		ln_vals = phy->init_data->usb_ln_vals;
-	} else {
-		return -EINVAL;
-	}
 
-	regmap = phy->regmap_common_cdb;
-	for (j = 0; j < num_cmn_regs ; j++)
-		regmap_write(regmap, cmn_vals[j].off, cmn_vals[j].val);
+	/* PMA common registers configurations */
+	pma_cmn_vals = init_data->pma_cmn_vals[phy_type][TYPE_NONE][ssc];
+	if (pma_cmn_vals) {
+		reg_pairs = pma_cmn_vals->reg_pairs;
+		num_regs = pma_cmn_vals->num_regs;
+		regmap = phy->regmap_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
+	}
 
-	for (i = 0; i < ins->num_lanes; i++) {
-		for (j = 0; j < num_ln_regs ; j++) {
+	/* PMA lane registers configurations */
+	pma_ln_vals = init_data->pma_ln_vals[phy_type][TYPE_NONE][ssc];
+	if (pma_ln_vals) {
+		reg_pairs = pma_ln_vals->reg_pairs;
+		num_regs = pma_ln_vals->num_regs;
+		for (i = 0; i < ins->num_lanes; i++) {
 			regmap = phy->regmap_lane_cdb[i + ins->mlane];
-			regmap_write(regmap, ln_vals[j].off, ln_vals[j].val);
+			for (j = 0; j < num_regs; j++)
+				regmap_write(regmap, reg_pairs[j].off, reg_pairs[j].val);
 		}
 	}
 
@@ -583,15 +601,28 @@ static int cdns_sierra_clk_register(struct cdns_sierra_phy *sp)
 static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 				    struct device_node *child)
 {
+	u32 phy_type;
+
 	if (of_property_read_u32(child, "reg", &inst->mlane))
 		return -EINVAL;
 
 	if (of_property_read_u32(child, "cdns,num-lanes", &inst->num_lanes))
 		return -EINVAL;
 
-	if (of_property_read_u32(child, "cdns,phy-type", &inst->phy_type))
+	if (of_property_read_u32(child, "cdns,phy-type", &phy_type))
 		return -EINVAL;
 
+	switch (phy_type) {
+	case PHY_TYPE_PCIE:
+		inst->phy_type = TYPE_PCIE;
+		break;
+	case PHY_TYPE_USB3:
+		inst->phy_type = TYPE_USB;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1006,6 +1037,16 @@ static const struct cdns_reg_pairs cdns_pcie_ln_regs_ext_ssc[] = {
 	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG}
 };
 
+static struct cdns_sierra_vals pcie_100_ext_ssc_cmn_vals = {
+	.reg_pairs = cdns_pcie_cmn_regs_ext_ssc,
+	.num_regs = ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
+};
+
+static struct cdns_sierra_vals pcie_100_ext_ssc_ln_vals = {
+	.reg_pairs = cdns_pcie_ln_regs_ext_ssc,
+	.num_regs = ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
+};
+
 /* refclk100MHz_20b_USB_cmn_pll_ext_ssc */
 static const struct cdns_reg_pairs cdns_usb_cmn_regs_ext_ssc[] = {
 	{0x2085, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
@@ -1113,32 +1154,74 @@ static const struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
 	{0x4243, SIERRA_RXBUFFER_DFECTRL_PREG}
 };
 
+static struct cdns_sierra_vals usb_100_ext_ssc_cmn_vals = {
+	.reg_pairs = cdns_usb_cmn_regs_ext_ssc,
+	.num_regs = ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
+};
+
+static struct cdns_sierra_vals usb_100_ext_ssc_ln_vals = {
+	.reg_pairs = cdns_usb_ln_regs_ext_ssc,
+	.num_regs = ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
+};
+
 static const struct cdns_sierra_data cdns_map_sierra = {
-	SIERRA_MACRO_ID,
-	0x2,
-	0x2,
-	ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
-	ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
-	ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
-	ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
-	cdns_pcie_cmn_regs_ext_ssc,
-	cdns_pcie_ln_regs_ext_ssc,
-	cdns_usb_cmn_regs_ext_ssc,
-	cdns_usb_ln_regs_ext_ssc,
+	.id_value = SIERRA_MACRO_ID,
+	.block_offset_shift = 0x2,
+	.reg_offset_shift = 0x2,
+	.pma_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
+			},
+		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
+			},
+		},
+	},
+	.pma_ln_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
+			},
+		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
+			},
+		},
+	},
 };
 
 static const struct cdns_sierra_data cdns_ti_map_sierra = {
-	SIERRA_MACRO_ID,
-	0x0,
-	0x1,
-	ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
-	ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
-	ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
-	ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
-	cdns_pcie_cmn_regs_ext_ssc,
-	cdns_pcie_ln_regs_ext_ssc,
-	cdns_usb_cmn_regs_ext_ssc,
-	cdns_usb_ln_regs_ext_ssc,
+	.id_value = SIERRA_MACRO_ID,
+	.block_offset_shift = 0x0,
+	.reg_offset_shift = 0x1,
+	.pma_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
+			},
+		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
+			},
+		},
+	},
+	.pma_ln_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
+			},
+		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
+			},
+		},
+	},
 };
 
 static const struct of_device_id cdns_sierra_id_table[] = {
-- 
2.26.1

