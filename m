Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B3447DEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346572AbhLWGMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:12:46 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:24190 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234171AbhLWGMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:12:43 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN3mvUC005509;
        Wed, 22 Dec 2021 22:12:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=rJ5LvbsV6vF+hIBAZ7qS5ZxOtvz1rhEcV0aiXNdI7sI=;
 b=Ekrab2UwuaciJf1LZFf6b+CychppYjRgFNJ5+IrH/lgbIBWX13m/XGp5qzouUmyJdH2A
 4AjO2aLEtPtfYI7Sz3W+pDoQu9NOg5H8NzpuBiW9KAcMVQNJNdGSQp9OsoOU+N1J0hKM
 djn8iMvgR8hZGt0gVW38BsMR46i+ZBUbySbqaglQB+HVHxjHFbHXhsvXuNIYCpDPLwQi
 vu14ZeVKdJV4B+hK6Hr2HOaQUy9XkhANJqxk+9xVYVW5Q1iPmp90UJUqItVYSHeciKjj
 wqPXmXFktUV1Txtcu7ShHG44zzmpSPdpBvRSgEF0TpGW1SiEeNlNGUkDK0/VidLwB3Qh NQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3d3rwxvkdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:12:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=du3zCpAE2qNgLyp2qsERBZ5JbPUVb5fWm92gLGLIOB2uVaRvJcjcyRxHMCpMupnUB80jalMdluHKiC5TyAPFcLovF82bYSJlZfnZOH1cp5v1HYC9HV5msw8pt7kL4jGbt/ycZBoqtnl9g3ruZYN+AxauNUJH0TXFsi7FyP6lC7PIo0mQ0ssAhDplvIknFBAjzT7xJCEUi3rnkPDD3HHAVUyZse26OE7GSjDSwHaejFTJUYbLfSfAIV8ph0IGJA/rZOWbmmOs+eLafQPh3v0BvGh+fXlw7H2j1xfzK/7uTZay2vsqx0Xkl+NY5Tohwu5hFDLCcg6qGtmENwbGQV0NEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ5LvbsV6vF+hIBAZ7qS5ZxOtvz1rhEcV0aiXNdI7sI=;
 b=l49AKE84hXfbkTwKtevwDoRiYRBlTUcHtCZHZKBz5gQQvWmyTx3UAqYRYE4gNHnEtVrlfxtXfgtCffLjjrvWkW5MzSINKfRVIXm1n1Zj49p+r4C0QNLb/VhXZAqqEgJnoh8p/7EFGfiP+EH7f8INA5Xb1TkqB7uSMa7I4sxOOzXyTm2TqlejLTKgih/GPto+xL4h8QFcvQrqnpG4gNeL6vD69tOWQp1LXILImYs47KlzUvz+BTIIKwZhnko/7jLlt/CHSMHdB+K4XNe2POHV01MpQbg2ZaVNZQxC1eEugw/EWcsymu76GsRq07AunHM4bBFelKkICOciMsZBxIM9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ5LvbsV6vF+hIBAZ7qS5ZxOtvz1rhEcV0aiXNdI7sI=;
 b=ZnQE7IT5/FBNwAfb0FEXdujzKIFZ79bvNgZivei2tRFahGohGsFk64KzJ3LvS+R1mIqiKxnzoQvW2zl+9aam6E5tLIFlLfSVA1noPPdb6Wyltb9pE/9VIeJAa6npdAwkY95XkcgQq4+Rkha5lXOjpZVrLC0i7FldAgXsBhz/7wo=
Received: from BN0PR04CA0067.namprd04.prod.outlook.com (2603:10b6:408:ea::12)
 by BL0PR07MB5523.namprd07.prod.outlook.com (2603:10b6:208:89::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Thu, 23 Dec
 2021 06:12:31 +0000
Received: from BN8NAM12FT015.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::a3) by BN0PR04CA0067.outlook.office365.com
 (2603:10b6:408:ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Thu, 23 Dec 2021 06:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT015.mail.protection.outlook.com (10.13.183.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:12:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 1BN6CTu7025278
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:12:30 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:12:22 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:12:22 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6AkKZ017150;
        Thu, 23 Dec 2021 07:11:18 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN6Ajlp017149;
        Thu, 23 Dec 2021 07:10:45 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 06/15] phy: cadence: Sierra: Rename some regmap variables to be in sync with Sierra documentation
Date:   Thu, 23 Dec 2021 07:01:28 +0100
Message-ID: <20211223060137.9252-7-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84bf569b-01af-41ec-68a7-08d9c5db335d
X-MS-TrafficTypeDiagnostic: BL0PR07MB5523:EE_
X-Microsoft-Antispam-PRVS: <BL0PR07MB55233E5122D5A625FEF1ECD3C57E9@BL0PR07MB5523.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VuyC2aJDN7laS6jB0o1O90nC/0qS7VXHRL2U8oFVvixsv4681QA8FRKGOz5CfrlIuWR7Esi9RQ+5MLkBMn655HpbA8zzUUBJz8URay4JD9jKykL6XgRrnyXsaOagpp75eFjoXH8294Ljlx+nbmynj5m7k2vcizCholdTTypQ3WoaIe88t2EFfIvL1JkmK9Gn8BDuFsZGiT8lcoBhUtgTx/3ExAWmTyHCgFIvlFLY1DvVqBdm2Pp3Hm+qOcInDpWlaqKPzxY8H9dYWU3LvlOFx4ChrAKH3Q95FMTv17tpkWrxYCXQktpZQF+LRrP+sqFbrofzZSlI09ezkSMYdnZeb1NhUGFpnBxS0SfLk+gBZk2wTdUhNomGL3fP+at3+UNHrA3qTdco1w+58WgiPBmG921WJyMnIab65/ol9eINSU8zMGfWcw4emFM2KMpD6B8vonTe9BsiJU3lSABL7aWK2UykLefcLlxnzLyqTvC/5TY+zdJiVlwVSOQ0n2pE9tcmB44jZhGUoWIfM/nTyPUJ/NfLtUnuVX4doMEItJh8lXBq+JopCyJk55jUituTSpaKdOiojLNmiI/erGifh5o0HoUd5N4cnZpKwb+0w/tbDLLvsjJXty1R4E8KpCL2Cd3YMZz1o/PHWSp2IBXwnjO/I91soGh4fuCHj39CRNf6Pk0ZX5ztrpA5VwVflIh66E5CkC9jjnHo/aLEqS2ljCwVww6XGAVnDmNgWOr1fTpHdckcyJQrXdQuLHDr+1ckmpn7Yp+31WAzO2X3BuDmnA2QBkdOph/oEBjycs813kUAemg8UU+s3ygeCySrGX6/I+gINLdATwFxn7rPr1nDubZrQ==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(40470700002)(46966006)(40460700001)(508600001)(26005)(8676002)(186003)(82310400004)(5660300002)(4326008)(336012)(110136005)(6666004)(1076003)(2906002)(86362001)(2616005)(426003)(36756003)(36860700001)(42186006)(70206006)(316002)(54906003)(47076005)(70586007)(81166007)(356005)(83380400001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:12:29.8342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bf569b-01af-41ec-68a7-08d9c5db335d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT015.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5523
X-Proofpoint-ORIG-GUID: 3LNF6wIuC8SyKgeoGGvOtd5W3g_cGUl8
X-Proofpoint-GUID: 3LNF6wIuC8SyKgeoGGvOtd5W3g_cGUl8
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

No functional change. Rename some regmap variables as mentioned in Sierra
register description documentation.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 4674328574f5..9f2b8aefee9c 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -145,8 +145,9 @@
 #define SIERRA_DEQ_TAU_CTRL1_FAST_MAINT_PREG		0x14F
 #define SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG		0x150
 
-#define SIERRA_PHY_CONFIG_CTRL_OFFSET(block_offset)	\
-				      (0xc000 << (block_offset))
+/* PHY PCS common registers */
+#define SIERRA_PHY_PCS_COMMON_OFFSET(block_offset)	\
+				     (0xc000 << (block_offset))
 #define SIERRA_PHY_PLL_CFG				0xe
 
 #define SIERRA_MACRO_ID					0x00007364
@@ -275,7 +276,7 @@ struct cdns_sierra_phy {
 	struct reset_control *phy_rst;
 	struct reset_control *apb_rst;
 	struct regmap *regmap_lane_cdb[SIERRA_MAX_LANES];
-	struct regmap *regmap_phy_config_ctrl;
+	struct regmap *regmap_phy_pcs_common_cdb;
 	struct regmap *regmap_common_cdb;
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
@@ -346,8 +347,8 @@ static const struct regmap_config cdns_sierra_common_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
-static const struct regmap_config cdns_sierra_phy_config_ctrl_config = {
-	.name = "sierra_phy_config_ctrl",
+static const struct regmap_config cdns_sierra_phy_pcs_cmn_cdb_config = {
+	.name = "sierra_phy_pcs_cmn_cdb",
 	.reg_stride = 1,
 	.fast_io = true,
 	.reg_write = cdns_regmap_write,
@@ -689,7 +690,7 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 		sp->cmn_refrcv_refclk_termen_preg[i] = field;
 	}
 
-	regmap = sp->regmap_phy_config_ctrl;
+	regmap = sp->regmap_phy_pcs_common_cdb;
 	field = devm_regmap_field_alloc(dev, regmap, phy_pll_cfg_1);
 	if (IS_ERR(field)) {
 		dev_err(dev, "PHY_PLL_CFG_1 reg field init failed\n");
@@ -741,14 +742,14 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	}
 	sp->regmap_common_cdb = regmap;
 
-	block_offset = SIERRA_PHY_CONFIG_CTRL_OFFSET(block_offset_shift);
+	block_offset = SIERRA_PHY_PCS_COMMON_OFFSET(block_offset_shift);
 	regmap = cdns_regmap_init(dev, base, block_offset, reg_offset_shift,
-				  &cdns_sierra_phy_config_ctrl_config);
+				  &cdns_sierra_phy_pcs_cmn_cdb_config);
 	if (IS_ERR(regmap)) {
-		dev_err(dev, "Failed to init PHY config and control regmap\n");
+		dev_err(dev, "Failed to init PHY PCS common CDB regmap\n");
 		return PTR_ERR(regmap);
 	}
-	sp->regmap_phy_config_ctrl = regmap;
+	sp->regmap_phy_pcs_common_cdb = regmap;
 
 	return 0;
 }
-- 
2.26.1

