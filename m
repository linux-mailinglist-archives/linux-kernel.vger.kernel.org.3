Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0F47DEFA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhLWGQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:16:06 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:6410 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232070AbhLWGQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:16:03 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BMLxBKr002429;
        Wed, 22 Dec 2021 22:15:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=5B9ve2mpCGnaBjtQAIGf5JYjG/1v1jS1oXk9hKYF0LI=;
 b=GEi2h3/SqIeVqUY0PJik0Iijo0TzbrwTLoF2DQNbZj/tQlLBkW4UzNFgT8JITSO8FecS
 bM5MBJFm/jIZsYBBHksc5WUMpdKUgxzMMKaifFj9DTgISpr95ClFAjllyu/Fyc8REu9w
 qzoiwqRGxmiwHrxiJlcbotJXsIPiY1bPtxfpwXGejtCUYFLXYK5pdTpacLEhtluA5twa
 pyZdl8qV15oGv5aiC91aWdGkqR46GZYz8cRETr5tDlYAeDxJib0KdNTzVRwQMnYXs+Kr
 l4kCGR1/xu+eqxqsuiM2u9SkeL1R+2T+0+xX8nJak7vC1ltwA/Ro0hULPFdLHtUtyxff vg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3d411ru5t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:15:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJOAvFqfKnfDHE0BKTYrihcTzbf/JLUG+lli8jkRPgCLlxoGz218wNamSv9G0sKdUANr31Z2WeKBRovYvSkc3qjcjG40n2evOSGL1w657RD/mno7HGCIp54njK6rMoJiNQssZ5sH0BL1VDQlZo6mClsJ/D5IqzMOt7uis4k0FzXtedl492VfYoS3BWJClxYlBhC0PAiRlPZVaARFX5akSml1wZ0Crvdeywr3l/k16vqt+wORntTKh0z8WxX7uvjZOg2J9n0sK1noJi33VMIMObmBG3LVJixfcAZfo9FBUbtWvnIOG6SCn9QON9H+Hj7cTvSPhM3h7sYMSc4R52BJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B9ve2mpCGnaBjtQAIGf5JYjG/1v1jS1oXk9hKYF0LI=;
 b=mzFpjknxOJD8obEjFK53xSx7WhLgSpDSTnHNR70wnUsSfY+lbLxW+PA3zsb1mc8WsMW7H2V1fq62F6gXb8G8de1ko0fChpDKSnavOcjJR4odWHnDej2cw4t70mBAlOAtWHveNGsma0JvOFUPyzcV66xxrZU2Yoyu6bdCOnXqr/CHIMa3vVS8Kuu9/bJnme1tQQ+MHjL0S1BfrZBD/QTsBX32xtguXVNyTMignFGDNRdJ+pSntD1iyvnJXR/tCAyP6RNzf9ZXxviqqg7pToD/6NH68IMb66Zi+YF+RJ3axQKbn9eyKdFEvaZ8SLEIVsrcYVYtGkQw5FNxjikbsDynIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B9ve2mpCGnaBjtQAIGf5JYjG/1v1jS1oXk9hKYF0LI=;
 b=VdNA3b9ihOR6fiyJbwh6dwEIThVGrYYTlScfmB/YBSJcoHV5YYAAfCpHpenizNgVfskXbODaCuiN00zeD4GvaJO7EMLfVR5UnXbrNcoBIJOyXio94nzH7amxOdRzwj7fDAH97R1eLtNJL2PckM/NEKT3f0cMZ8+B6hc1WVP/PeA=
Received: from BN9P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::18)
 by BLAPR07MB7505.namprd07.prod.outlook.com (2603:10b6:208:298::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 06:15:44 +0000
Received: from BN8NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::1f) by BN9P223CA0013.outlook.office365.com
 (2603:10b6:408:10b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Thu, 23 Dec 2021 06:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT040.mail.protection.outlook.com (10.13.182.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:15:43 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6FhPn019446
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:15:44 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:15:36 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:15:36 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:15:36 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6Dxek018506;
        Thu, 23 Dec 2021 07:14:32 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN6Dxht018505;
        Thu, 23 Dec 2021 07:13:59 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 08/15] phy: cadence: Sierra: Check cmn_ready assertion during PHY power on
Date:   Thu, 23 Dec 2021 07:01:30 +0100
Message-ID: <20211223060137.9252-9-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea8a6fbc-d113-48c4-94bf-08d9c5dba6d4
X-MS-TrafficTypeDiagnostic: BLAPR07MB7505:EE_
X-Microsoft-Antispam-PRVS: <BLAPR07MB7505342FDBC6E63D2C647A06C57E9@BLAPR07MB7505.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zX5/t0mkhqD0+s2hi0ZfTpInUe3Yr1aHKj9EgWRnYP56eROdxzLa6KPR7tv7jOpP2aOsr2svRGcktdv4dVgoZHD88oaJypVv93sGc1o6CdKdZJDz6cq5Y26mAszyHeShL65C/fEozAyVwFEgjrJ6yGLBfuAtdPbBcSYRahu3B2geYUOfDwYRi69vmn3dvfvHa7oaUtzd2hJFPXtId8L0ZPpDQjHuhsTCPQzcNnwTMqFj/zjwKhDI/dKX+385IDJdexFHGJyh7cTdG57HUibRAYVVP4VBsaktz5CwwwUzGcsJD6uZbl86wYx3X9dGZwR4oqTF9SjHidqzoq0tjTdYirbY8PIGc8agccruqsrBT9H88CucHL430TVUAUrGaBf0nhaJRI5s0AIjotQ41KfwNfUPmXTGtjCJXnBFHSmOjeTLHtyirnaumy5xk7ZTZltNdi6JJIybpPkFOhL+JCtouLA5KnUTkV96PcVvkjiAHSicgXM3rl+9wOZxPM2Qd7ymzrBr3YAPFaoq0TzaiI3piZd7IX5NOr25lt1cwQt+/Jj2lF45hvsHy+7a5pjYRo9gsxE2L7VDoyegOrIA+H/XO7MJGCgbegzgqBuFSITGvD2rXt7THdUPdKJWJF+ppmEp7LGBSA7M9OJtw5PGZc5n31sgAw21TTl7Bd6tYZpJsXXBn+XBYCDVpMOqy7TzYP6cv1epLub9vFp37ANoT+GyPl2a1wyXO6qTMpEpI72z0HEpi7KJjjrk9tnwxoqyirHjYImE8k/uqyUC6ycIPZSxRJvVZ0gTxfrD35nMAlgScE=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(40470700002)(46966006)(1076003)(5660300002)(336012)(508600001)(4326008)(36756003)(70586007)(70206006)(7636003)(356005)(83380400001)(8936002)(26005)(426003)(186003)(6666004)(2616005)(8676002)(47076005)(54906003)(86362001)(110136005)(42186006)(316002)(36860700001)(82310400004)(40460700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:15:43.5688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8a6fbc-d113-48c4-94bf-08d9c5dba6d4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT040.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7505
X-Proofpoint-ORIG-GUID: RYXEj5WGxxeP6Dd0EKnpDhTVC94uuoWv
X-Proofpoint-GUID: RYXEj5WGxxeP6Dd0EKnpDhTVC94uuoWv
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

Check if PMA cmn_ready is set indicating the startup process is complete.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 0bfd13843f2e..13176208e6d7 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -151,6 +151,11 @@
 #define SIERRA_PHY_PIPE_CMN_CTRL1			0x0
 #define SIERRA_PHY_PLL_CFG				0xe
 
+/* PHY PMA common registers */
+#define SIERRA_PHY_PMA_COMMON_OFFSET(block_offset)	\
+				     (0xE000 << (block_offset))
+#define SIERRA_PHY_PMA_CMN_CTRL				0x000
+
 #define SIERRA_MACRO_ID					0x00007364
 #define SIERRA_MAX_LANES				16
 #define PLL_LOCK_TIME					100000
@@ -172,6 +177,8 @@ static const struct reg_field macro_id_type =
 				REG_FIELD(SIERRA_MACRO_ID_REG, 0, 15);
 static const struct reg_field phy_pll_cfg_1 =
 				REG_FIELD(SIERRA_PHY_PLL_CFG, 1, 1);
+static const struct reg_field pma_cmn_ready =
+				REG_FIELD(SIERRA_PHY_PMA_CMN_CTRL, 0, 0);
 static const struct reg_field pllctrl_lock =
 				REG_FIELD(SIERRA_PLLCTRL_STATUS_PREG, 0, 0);
 
@@ -280,9 +287,11 @@ struct cdns_sierra_phy {
 	struct reset_control *apb_rst;
 	struct regmap *regmap_lane_cdb[SIERRA_MAX_LANES];
 	struct regmap *regmap_phy_pcs_common_cdb;
+	struct regmap *regmap_phy_pma_common_cdb;
 	struct regmap *regmap_common_cdb;
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
+	struct regmap_field *pma_cmn_ready;
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
 	struct regmap_field *cmn_refrcv_refclk_plllc1en_preg[SIERRA_NUM_CMN_PLLC];
 	struct regmap_field *cmn_refrcv_refclk_termen_preg[SIERRA_NUM_CMN_PLLC];
@@ -358,6 +367,14 @@ static const struct regmap_config cdns_sierra_phy_pcs_cmn_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
+static const struct regmap_config cdns_sierra_phy_pma_cmn_cdb_config = {
+	.name = "sierra_phy_pma_cmn_cdb",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_write,
+	.reg_read = cdns_regmap_read,
+};
+
 static int cdns_sierra_phy_init(struct phy *gphy)
 {
 	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
@@ -435,6 +452,17 @@ static int cdns_sierra_phy_on(struct phy *gphy)
 		return ret;
 	}
 
+	/*
+	 * Wait for cmn_ready assertion
+	 * PHY_PMA_CMN_CTRL[0] == 1
+	 */
+	ret = regmap_field_read_poll_timeout(sp->pma_cmn_ready, val, val,
+					     1000, PLL_LOCK_TIME);
+	if (ret) {
+		dev_err(dev, "Timeout waiting for CMN ready\n");
+		return ret;
+	}
+
 	ret = regmap_field_read_poll_timeout(sp->pllctrl_lock[ins->mlane],
 					     val, val, 1000, PLL_LOCK_TIME);
 	if (ret < 0)
@@ -712,6 +740,14 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 	}
 	sp->phy_pll_cfg_1 = field;
 
+	regmap = sp->regmap_phy_pma_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, pma_cmn_ready);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PMA_CMN_CTRL reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	sp->pma_cmn_ready = field;
+
 	for (i = 0; i < SIERRA_MAX_LANES; i++) {
 		regmap = sp->regmap_lane_cdb[i];
 		field = devm_regmap_field_alloc(dev, regmap, pllctrl_lock);
@@ -765,6 +801,15 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	}
 	sp->regmap_phy_pcs_common_cdb = regmap;
 
+	block_offset = SIERRA_PHY_PMA_COMMON_OFFSET(block_offset_shift);
+	regmap = cdns_regmap_init(dev, base, block_offset, reg_offset_shift,
+				  &cdns_sierra_phy_pma_cmn_cdb_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init PHY PMA common CDB regmap\n");
+		return PTR_ERR(regmap);
+	}
+	sp->regmap_phy_pma_common_cdb = regmap;
+
 	return 0;
 }
 
-- 
2.26.1

