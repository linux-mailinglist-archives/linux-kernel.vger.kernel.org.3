Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE9A47DF07
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346617AbhLWGWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:22:11 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:30716 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232444AbhLWGWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:22:10 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN3qOQu005437;
        Wed, 22 Dec 2021 22:21:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=W5JYz3vRTyN7wWn37BrjLOz0EMc40/jKxgC0uwH0wzE=;
 b=sXLQhiuB916qoj8lSV6M8pnSpIyv02z40Pbja5L3LeqETxbPwy/SVI48Bq0D+mw2343a
 EczMniJjaMnGLHUbgUbMfHqSNKJf8jHOTRDBFQZl692LBB53ZTNctnFgeYxOdMNY2stV
 4DEgH5JAhGjeDCVhl0pTFGCNfQFUbgexGDpT8K+WcnuY4wpARocsp2PTfWngidIS29NG
 dV0VkVJJs/7q+xwj3ytv5WuWb+BXndgbzFH+Us+JJXCY2v0rvkrXODRCSwsa1AXzu0zp
 PmlIJxU2ssAKFcKUR/SydDuxiVvp5U5wFtxkpj1F43Ap8+gq4dffX6NIuixeM2YNAj6q zg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3d3rwxvm4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:21:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJRs+4yZhNhXarUSBapBOABDdLroKzW8MoKQxDRAkMixo3yu2LMe52UiVdzZq6skD2GHFIRcivrx2Yuco2h5gJU0UCMJXm/em4ivM2gWKv4zW2+G7O70MzEkSGzQDqrKvdqbjX1QqbNQiJPNsw0yCRGb0sCKXppuXdyI9LUECEsKt7+pmgBFjSi+Uqf6pHeDYsXnC8r45vPjrWOD5Q4GLn9olkCz9lj/IPii7z57YTydG1hrPjkw5cn18Q385/3HETiv2NJEaRYkgMkQ+g+DhgWtdQjoPiWp+FjSqr0aHMmeBytUtHUDRLn4R2+aq/XdfJt/QIdLij05zNT7PmiAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5JYz3vRTyN7wWn37BrjLOz0EMc40/jKxgC0uwH0wzE=;
 b=cqzDcWFbWn5BkCrKtHY//snYp0DxzrX6VNg6ssyB4d2Ol7HHJLTkpEHawT/Pst/e/3SdMhDOg3gqaUq8wilyge4hy0fxXyMpebdR3poipZ48Z9gLaBcv47EAiRZ908vIqJr+Egt3yH3VtAqdHqNwh1hnddM9QbowFSQHq3UCXZY46ZzeyZLyuAVHH1YGjh7VNwyV5wO4XRImoNubVggx8lIB+2Oe3F2IVBJV0cPqtduo7XaX81YrVKtv52fiFOdpbHXe4O3cHPsZtsDdHA+UeVvipq2wgYnY20rk0fmOYqiIWpKSh2b6+og7ABWFtj+Ozk2/YzHkouQ2p5l4WeD8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5JYz3vRTyN7wWn37BrjLOz0EMc40/jKxgC0uwH0wzE=;
 b=QfPHbDP0vFEwz+QnRw2c3yJmT7FSiCHQ3Q5zEtAbgeKnfxYkdR/vI05AZW/S3O57wQyBA+hcTAS/VEfFLmEsAr1pSyrYW14q9wZtr4BIaC+6EjFM6vCNdazP5Lo7zpxTJfZaLuxrB0qfeT9kfoBWMtgTohqjjAgRLBbJu1XGL5c=
Received: from MWHPR1401CA0007.namprd14.prod.outlook.com
 (2603:10b6:301:4b::17) by SN6PR07MB5422.namprd07.prod.outlook.com
 (2603:10b6:805:a7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 06:21:55 +0000
Received: from MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::e) by MWHPR1401CA0007.outlook.office365.com
 (2603:10b6:301:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Thu, 23 Dec 2021 06:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT021.mail.protection.outlook.com (10.13.180.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:21:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 1BN6Lrxk025789
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:21:54 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:21:46 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:21:46 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6KAMN020804;
        Thu, 23 Dec 2021 07:20:42 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN6KAAY020798;
        Thu, 23 Dec 2021 07:20:10 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 12/15] phy: cadence: Sierra: Add support for PHY multilink configurations
Date:   Thu, 23 Dec 2021 07:01:34 +0100
Message-ID: <20211223060137.9252-13-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec78a5d6-ab75-48ee-2a6a-08d9c5dc8378
X-MS-TrafficTypeDiagnostic: SN6PR07MB5422:EE_
X-Microsoft-Antispam-PRVS: <SN6PR07MB542253E70CC45E8A0D060DE3C57E9@SN6PR07MB5422.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxdSHx+8Sv5UP87ji19jlHGv9hbFFA0Ql6TZzj8TMHZo2DXkwcWk7Ytsp9+Ai5sfsXRltlzdPTym7BGd+XHj6dQROKNWJUSH6i7aqhaMc9NZAVobTdQA2CRRTClL1y0OG3DuylCo8rFPXALoVqD2V0X6/DCK6kDCdhUC7CIZORB3SZId/g/wKVN/Hq98Q1oRfkN3nvJTxswQn7at3JQ1GE0kwpsqSBQsihmc7tS/Gablma945l1aBLIy7EjsK+MZeAxqKR5+tVv7fE6eboc8nj/7v2g1LZyw4evnZE6NZo/dluS7pT9enPsw6g3vAgWhuAS1sNY0TsW1ttNlcAi3zGdrdc+qpXDYNyKZjdvyyqvRKkd8XMGvahx1IFVhu3F7oZwuo29u7+kxfQpJ0weoGXu/8uJK9ZrXuMj+sv++/SADxKVlnA1hY8ZpLMOmhQ0haYYIJPaSb5Wu6xQJhPlHg6++zHTDj7XOEBjU0G2j2CJSkZEL6E/Y6RH8cfN0lrhiaRdqeEwYVL+n97BZqj3khOq58UaeWz8zXNYYZ1Cf9OoyVA/3FVBtf5Yh3ZWviEafcuwXyemsGY1Y8RzTH7Ok+UJNr4Wpb9l7lvM27QpJMT0oKnXp9HEDsrdZkh8bSmutXUfvq8JZUJbqUpCQS/AWuU4HJtO/dZSuuJuKKk9kkEfDJxS0x3YGQnP6Im4V4z8bsKcnTdo7xH4QgaoLYKvSRl91DbKiiLWzkE2bocL5FJ5jsBlreSFAx5WBRVy8xvZBhSiRwDE0LxbL2j6gKQu/ZnqxKtW5daNjcDUklhMpt+SmIdu7oMH2S0PxwMuyAnZYJdPj3IkvbIxbd5P0mndrPw==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(40470700002)(36840700001)(46966006)(186003)(356005)(8676002)(336012)(426003)(4326008)(316002)(2616005)(8936002)(81166007)(36756003)(30864003)(6666004)(1076003)(2906002)(70206006)(82310400004)(110136005)(83380400001)(508600001)(54906003)(5660300002)(40460700001)(26005)(42186006)(86362001)(47076005)(70586007)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:21:53.8022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec78a5d6-ab75-48ee-2a6a-08d9c5dc8378
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5422
X-Proofpoint-ORIG-GUID: 51JDXn40KEEXTGZZvte4qlNNMjXxB6CU
X-Proofpoint-GUID: 51JDXn40KEEXTGZZvte4qlNNMjXxB6CU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_01,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112230035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for multilink configuration of Sierra PHY. Currently,
maximum two links are supported.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 198 ++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index abdbc6ebd5a8..8f356bf38be8 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -24,7 +24,7 @@
 #include <dt-bindings/phy/phy-cadence.h>
 
 #define NUM_SSC_MODE		3
-#define NUM_PHY_TYPE		3
+#define NUM_PHY_TYPE		4
 
 /* PHY register offsets */
 #define SIERRA_COMMON_CDB_OFFSET			0x0
@@ -184,6 +184,13 @@
 				     (0xE000 << (block_offset))
 #define SIERRA_PHY_PMA_CMN_CTRL				0x000
 
+/* PHY PMA lane registers */
+#define SIERRA_PHY_PMA_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
+				       ((0xF000 << (block_offset)) +	\
+				       (((ln) << 8) << (reg_offset)))
+
+#define SIERRA_PHY_PMA_XCVR_CTRL			0x000
+
 #define SIERRA_MACRO_ID					0x00007364
 #define SIERRA_MAX_LANES				16
 #define PLL_LOCK_TIME					100000
@@ -299,6 +306,8 @@ struct cdns_sierra_data {
 	u8 reg_offset_shift;
 	struct cdns_sierra_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					     [NUM_SSC_MODE];
+	struct cdns_sierra_vals *phy_pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+						[NUM_SSC_MODE];
 	struct cdns_sierra_vals *pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					     [NUM_SSC_MODE];
 	struct cdns_sierra_vals *pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
@@ -322,6 +331,7 @@ struct cdns_sierra_phy {
 	struct regmap *regmap_phy_pcs_common_cdb;
 	struct regmap *regmap_phy_pcs_lane_cdb[SIERRA_MAX_LANES];
 	struct regmap *regmap_phy_pma_common_cdb;
+	struct regmap *regmap_phy_pma_lane_cdb[SIERRA_MAX_LANES];
 	struct regmap *regmap_common_cdb;
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
@@ -438,6 +448,34 @@ static const struct regmap_config cdns_sierra_phy_pma_cmn_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
+#define SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF(n) \
+{ \
+	.name = "sierra_phy_pma_lane" n "_cdb", \
+	.reg_stride = 1, \
+	.fast_io = true, \
+	.reg_write = cdns_regmap_write, \
+	.reg_read = cdns_regmap_read, \
+}
+
+static const struct regmap_config cdns_sierra_phy_pma_lane_cdb_config[] = {
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("0"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("1"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("2"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("3"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("4"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("5"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("6"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("7"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("8"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("9"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("10"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("11"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("12"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("13"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("14"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("15"),
+};
+
 static int cdns_sierra_phy_init(struct phy *gphy)
 {
 	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
@@ -446,6 +484,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
 	enum cdns_sierra_phy_type phy_type = ins->phy_type;
 	enum cdns_sierra_ssc_mode ssc = ins->ssc_mode;
+	struct cdns_sierra_vals *phy_pma_ln_vals;
 	const struct cdns_reg_pairs *reg_pairs;
 	struct cdns_sierra_vals *pcs_cmn_vals;
 	struct regmap *regmap;
@@ -453,7 +492,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	int i, j;
 
 	/* Initialise the PHY registers, unless auto configured */
-	if (phy->autoconf)
+	if (phy->autoconf || phy->nsubnodes > 1)
 		return 0;
 
 	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
@@ -469,6 +508,18 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 			regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
 	}
 
+	/* PHY PMA lane registers configurations */
+	phy_pma_ln_vals = init_data->phy_pma_ln_vals[phy_type][TYPE_NONE][ssc];
+	if (phy_pma_ln_vals) {
+		reg_pairs = phy_pma_ln_vals->reg_pairs;
+		num_regs = phy_pma_ln_vals->num_regs;
+		for (i = 0; i < ins->num_lanes; i++) {
+			regmap = phy->regmap_phy_pma_lane_cdb[i + ins->mlane];
+			for (j = 0; j < num_regs; j++)
+				regmap_write(regmap, reg_pairs[j].off, reg_pairs[j].val);
+		}
+	}
+
 	/* PMA common registers configurations */
 	pma_cmn_vals = init_data->pma_cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (pma_cmn_vals) {
@@ -502,10 +553,13 @@ static int cdns_sierra_phy_on(struct phy *gphy)
 	u32 val;
 	int ret;
 
-	ret = reset_control_deassert(sp->phy_rst);
-	if (ret) {
-		dev_err(dev, "Failed to take the PHY out of reset\n");
-		return ret;
+	if (sp->nsubnodes == 1) {
+		/* Take the PHY out of reset */
+		ret = reset_control_deassert(sp->phy_rst);
+		if (ret) {
+			dev_err(dev, "Failed to take the PHY out of reset\n");
+			return ret;
+		}
 	}
 
 	/* Take the PHY lane group out of reset */
@@ -923,6 +977,19 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	}
 	sp->regmap_phy_pma_common_cdb = regmap;
 
+	for (i = 0; i < SIERRA_MAX_LANES; i++) {
+		block_offset = SIERRA_PHY_PMA_LANE_CDB_OFFSET(i, block_offset_shift,
+							      reg_offset_shift);
+		regmap = cdns_regmap_init(dev, base, block_offset,
+					  reg_offset_shift,
+					  &cdns_sierra_phy_pma_lane_cdb_config[i]);
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "Failed to init PHY PMA lane CDB regmap\n");
+			return PTR_ERR(regmap);
+		}
+		sp->regmap_phy_pma_lane_cdb[i] = regmap;
+	}
+
 	return 0;
 }
 
@@ -1030,6 +1097,118 @@ static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
 	return 0;
 }
 
+static int cdns_sierra_phy_configure_multilink(struct cdns_sierra_phy *sp)
+{
+	const struct cdns_sierra_data *init_data = sp->init_data;
+	struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
+	enum cdns_sierra_phy_type phy_t1, phy_t2;
+	struct cdns_sierra_vals *phy_pma_ln_vals;
+	const struct cdns_reg_pairs *reg_pairs;
+	struct cdns_sierra_vals *pcs_cmn_vals;
+	int i, j, node, mlane, num_lanes, ret;
+	enum cdns_sierra_ssc_mode ssc;
+	struct regmap *regmap;
+	u32 num_regs;
+
+	/* Maximum 2 links (subnodes) are supported */
+	if (sp->nsubnodes != 2)
+		return -EINVAL;
+
+	clk_set_rate(sp->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
+	clk_set_rate(sp->input_clks[CMN_REFCLK1_DIG_DIV], 25000000);
+
+	/* PHY configured to use both PLL LC and LC1 */
+	regmap_field_write(sp->phy_pll_cfg_1, 0x1);
+
+	phy_t1 = sp->phys[0].phy_type;
+	phy_t2 = sp->phys[1].phy_type;
+
+	/*
+	 * PHY configuration for multi-link operation is done in two steps.
+	 * e.g. Consider a case for a 4 lane PHY with PCIe using 2 lanes and QSGMII other 2 lanes.
+	 * Sierra PHY has 2 PLLs, viz. PLLLC and PLLLC1. So in this case, PLLLC is used for PCIe
+	 * and PLLLC1 is used for QSGMII. PHY is configured in two steps as described below.
+	 *
+	 * [1] For first step, phy_t1 = TYPE_PCIE and phy_t2 = TYPE_QSGMII
+	 *     So the register values are selected as [TYPE_PCIE][TYPE_QSGMII][ssc].
+	 *     This will configure PHY registers associated for PCIe (i.e. first protocol)
+	 *     involving PLLLC registers and registers for first 2 lanes of PHY.
+	 * [2] In second step, the variables phy_t1 and phy_t2 are swapped. So now,
+	 *     phy_t1 = TYPE_QSGMII and phy_t2 = TYPE_PCIE. And the register values are selected as
+	 *     [TYPE_QSGMII][TYPE_PCIE][ssc].
+	 *     This will configure PHY registers associated for QSGMII (i.e. second protocol)
+	 *     involving PLLLC1 registers and registers for other 2 lanes of PHY.
+	 *
+	 * This completes the PHY configuration for multilink operation. This approach enables
+	 * dividing the large number of PHY register configurations into protocol specific
+	 * smaller groups.
+	 */
+	for (node = 0; node < sp->nsubnodes; node++) {
+		if (node == 1) {
+			/*
+			 * If first link with phy_t1 is configured, then configure the PHY for
+			 * second link with phy_t2. Get the array values as [phy_t2][phy_t1][ssc].
+			 */
+			swap(phy_t1, phy_t2);
+		}
+
+		mlane = sp->phys[node].mlane;
+		ssc = sp->phys[node].ssc_mode;
+		num_lanes = sp->phys[node].num_lanes;
+
+		/* PHY PCS common registers configurations */
+		pcs_cmn_vals = init_data->pcs_cmn_vals[phy_t1][phy_t2][ssc];
+		if (pcs_cmn_vals) {
+			reg_pairs = pcs_cmn_vals->reg_pairs;
+			num_regs = pcs_cmn_vals->num_regs;
+			regmap = sp->regmap_phy_pcs_common_cdb;
+			for (i = 0; i < num_regs; i++)
+				regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
+		}
+
+		/* PHY PMA lane registers configurations */
+		phy_pma_ln_vals = init_data->phy_pma_ln_vals[phy_t1][phy_t2][ssc];
+		if (phy_pma_ln_vals) {
+			reg_pairs = phy_pma_ln_vals->reg_pairs;
+			num_regs = phy_pma_ln_vals->num_regs;
+			for (i = 0; i < num_lanes; i++) {
+				regmap = sp->regmap_phy_pma_lane_cdb[i + mlane];
+				for (j = 0; j < num_regs; j++)
+					regmap_write(regmap, reg_pairs[j].off, reg_pairs[j].val);
+			}
+		}
+
+		/* PMA common registers configurations */
+		pma_cmn_vals = init_data->pma_cmn_vals[phy_t1][phy_t2][ssc];
+		if (pma_cmn_vals) {
+			reg_pairs = pma_cmn_vals->reg_pairs;
+			num_regs = pma_cmn_vals->num_regs;
+			regmap = sp->regmap_common_cdb;
+			for (i = 0; i < num_regs; i++)
+				regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
+		}
+
+		/* PMA lane registers configurations */
+		pma_ln_vals = init_data->pma_ln_vals[phy_t1][phy_t2][ssc];
+		if (pma_ln_vals) {
+			reg_pairs = pma_ln_vals->reg_pairs;
+			num_regs = pma_ln_vals->num_regs;
+			for (i = 0; i < num_lanes; i++) {
+				regmap = sp->regmap_lane_cdb[i + mlane];
+				for (j = 0; j < num_regs; j++)
+					regmap_write(regmap, reg_pairs[j].off, reg_pairs[j].val);
+			}
+		}
+	}
+
+	/* Take the PHY out of reset */
+	ret = reset_control_deassert(sp->phy_rst);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int cdns_sierra_phy_probe(struct platform_device *pdev)
 {
 	struct cdns_sierra_phy *sp;
@@ -1149,8 +1328,11 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	}
 
 	/* If more than one subnode, configure the PHY as multilink */
-	if (!sp->autoconf && sp->nsubnodes > 1)
-		regmap_field_write(sp->phy_pll_cfg_1, 0x1);
+	if (!sp->autoconf && sp->nsubnodes > 1) {
+		ret = cdns_sierra_phy_configure_multilink(sp);
+		if (ret)
+			goto put_child2;
+	}
 
 	pm_runtime_enable(dev);
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-- 
2.26.1

