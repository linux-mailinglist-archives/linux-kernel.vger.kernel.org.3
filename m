Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AFE47DF00
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346594AbhLWGRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:17:53 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37488 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232070AbhLWGRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:17:51 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN4F4TK005438;
        Wed, 22 Dec 2021 22:17:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=MNcgEWJb/bpq9GsQM+jl493xbb2dyFyWZjgAPs7dybA=;
 b=j2Ge1BGw2FeCcv78JQbF/9hxgBrFm5G2xb+e3y1M2IIF5p4Qy/Vj20rDYgiyaTvU3akA
 dScTrPdY84mVqhI5vQQoVpfLPdWQu/+7RX2v9i4FYOacCTRLcHyGjPUkcZlsE9SThq48
 u/sPpqQS2dcov83MkPTbKM8kmKqPQ9nl5kGkhi86y6SOIa/wqo5BI5wflpGBsz2oDskM
 ecg4DENLgUyj5QEeHluo50NDLO4WnAI8LYv4jpHchodfJBSPlP3mryA1GcQIt+qwHALV
 RGLC6rjR3KirUD0/lL39HKrz5WpzNmRCOYFcn12ObLVRnxlrNZOQfitTG79HiYfl+ckv 6Q== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3d3rwxvkry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:17:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXyO1zxZbfDjgKoNDQWdO8fzGxAbdx9tpCoQ5j79pL7EJpl7kModenRI6MxT1jpVsAo2tIJFDgGy5ykMXHvtya5i+XhgYjL+GTk9Yz3LF8RzUm+od/tp1v5RtTK8KgzVwaR/Os+LbgBSi4lOLz5eMssMZVkOUv3Rl+UL2oq5cvebQz6pnKTvNeJsCxcYKNbbxgx5VL+9uSPKaOWbO5/I8ar3NDlAA2x4GNgD+zK2tQHbwCiEF9z+c2Yrkgyka0HOyGArnYT155DVqJluD3o9MdP1OvQB7WmD24of4vBRBEHnH3EVxE1SbwRpufGnMjAXGcPWfeUb6/vq5mop4iTljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNcgEWJb/bpq9GsQM+jl493xbb2dyFyWZjgAPs7dybA=;
 b=DQN+95uMv11bPG27021ZyvQYh9OWde/5u0GuNQQEGvHqoCrtznKCQPz3Ya93Gy7f8/aeU5EUp+jYw0MEBfCitDp3XBsvhyajx9k+pg0KR8igS94XTrFitu+zEHIePwcwBUvKT0ZoBc+4YgExpKcJ0IjkzegviK8D1XBiz77R/tRVi9mEAtw5dS3xv6oLsfIgVIfcfmwV/aCYUiuoTSxti5fZR8nysoGqhFoUboZCU93cDIwo4xtYZCLQcLI/5diFf9a2jpcwyB3Fny36A1jKAmkloIBwkocmGdtGI7ePa1HVY7gPLUv82KOV0bQ33obLBA0wzvZlgGJWXFx0rVNF1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNcgEWJb/bpq9GsQM+jl493xbb2dyFyWZjgAPs7dybA=;
 b=EUISdJrC1HZhqCWh3nye1WYURolsyjGO8WPDXypQdTxw06+nVnMk+YRKUwL392F/9VTwKM3jU+q87p1wn53KRYTDI96t0ND47VwKc5le6IeO/flyVZxDuzr6wcfHrtNAc+87pEF3wngtKpRu+7e3LT21FA1RhuOg+gqm6EDa2Ks=
Received: from BN9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::27)
 by BYAPR07MB5109.namprd07.prod.outlook.com (2603:10b6:a03:68::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 06:17:37 +0000
Received: from BN8NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::71) by BN9P223CA0022.outlook.office365.com
 (2603:10b6:408:10b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Thu, 23 Dec 2021 06:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT040.mail.protection.outlook.com (10.13.182.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:17:36 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 1BN6HZdj025555
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:17:37 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:17:17 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:17:05 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:17:04 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6FSFs019105;
        Thu, 23 Dec 2021 07:16:00 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN6FSgG019104;
        Thu, 23 Dec 2021 07:15:28 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 09/15] phy: cadence: Sierra: Check PIPE mode PHY status to be ready for operation
Date:   Thu, 23 Dec 2021 07:01:31 +0100
Message-ID: <20211223060137.9252-10-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24391159-504f-4886-8c46-08d9c5dbea32
X-MS-TrafficTypeDiagnostic: BYAPR07MB5109:EE_
X-Microsoft-Antispam-PRVS: <BYAPR07MB5109B402F5F9132011D1258BC57E9@BYAPR07MB5109.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGtFQGxSzrODSZiQOA/XW1YL01tMtphu/h6ruVuhNkSlHbKAdzDjmSOTqO0Snji/Oe3yMU5dS8V9nxHIed2DXlyfi5W8quMCZH75G1JaJbf6M+HqmOioCTanqEmTXwBXjGEkWv4SnZKXd8u2mmWsg0LYRcC2eGpc7cncJ8qEkmmt65ELNrVMJqz7XNnO9ySQT5aWfyueQVUhA4deHF0BhLg2gVKU1AMPeUg5Rd17iOTaJDRicYKQUwB6Waf4UwKVEp8yju0EbEVuDObUS4lPY0czbUCGTZbYWZ/kRCPy5OE701gjndPjyS0NwORZHxXNJHmmUU2WadT7nTgdNRrUZ3PiguSK2OuDc7/UixM+gtOQRqL26Oc7kd+suLAJLHXK1osr1QCuBxeqGd4n7GtX6s8Kr+kpjPyZg2IECVRUewKy+P/RHIhOsl9lJmLPCkzqQdrEeV2X3pxjoHAYNahhmq4Uw3j4OCwcpfHI2uuEEl9dWy6ixDeczK2/+s0Iqwy5W6V9JLVSHNK36GMXsdi33eQi1iHeClNaofnEMHP3GdHmDsuoJJh/WohIvC5EXD6hEwNFV4Ep+xyXKNbD7CAux7AJELOjxSGS3GZ+MJaRQDcBQXzqnuC8EsQxRxQKCHgw7xIGOvXrL3x/8+D5SQ87iyFuKWZUqGNEeFF1bEDPUEvWkNMwQYAjPvqZny3s9WJAcjojhdppLLtrNJzUHwr+KXp5Awno9/AOrdrmLN+/To4dPB3pRUru92pB9w/99kAphZF7CmDiPau6qQYP9PfMVyI1H2+zH13+Gri495aVaW+BWZHSjGyQNqERbx0h4DfkeaHK3jr5PgG1jY2cR0BPJw==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(40470700002)(46966006)(336012)(42186006)(316002)(186003)(6666004)(83380400001)(54906003)(508600001)(110136005)(40460700001)(2906002)(5660300002)(2616005)(1076003)(36756003)(4326008)(82310400004)(356005)(86362001)(47076005)(36860700001)(426003)(81166007)(8936002)(70206006)(70586007)(8676002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:17:36.5764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24391159-504f-4886-8c46-08d9c5dbea32
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT040.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5109
X-Proofpoint-ORIG-GUID: kzyn6rhH5sytD_fEJiXc-Ca4CkWDgUux
X-Proofpoint-GUID: kzyn6rhH5sytD_fEJiXc-Ca4CkWDgUux
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

PIPE phy status is used to communicate the completion of several PHY
functions. Check if PHY is ready for operation while configured for
PIPE mode during startup.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 73 +++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 13176208e6d7..59458388a855 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -151,6 +151,13 @@
 #define SIERRA_PHY_PIPE_CMN_CTRL1			0x0
 #define SIERRA_PHY_PLL_CFG				0xe
 
+/* PHY PCS lane registers */
+#define SIERRA_PHY_PCS_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
+				       ((0xD000 << (block_offset)) +	\
+				       (((ln) << 8) << (reg_offset)))
+
+#define SIERRA_PHY_ISO_LINK_CTRL			0xB
+
 /* PHY PMA common registers */
 #define SIERRA_PHY_PMA_COMMON_OFFSET(block_offset)	\
 				     (0xE000 << (block_offset))
@@ -181,6 +188,8 @@ static const struct reg_field pma_cmn_ready =
 				REG_FIELD(SIERRA_PHY_PMA_CMN_CTRL, 0, 0);
 static const struct reg_field pllctrl_lock =
 				REG_FIELD(SIERRA_PLLCTRL_STATUS_PREG, 0, 0);
+static const struct reg_field phy_iso_link_ctrl_1 =
+				REG_FIELD(SIERRA_PHY_ISO_LINK_CTRL, 1, 1);
 
 static const char * const clk_names[] = {
 	[CDNS_SIERRA_PLL_CMNLC] = "pll_cmnlc",
@@ -287,12 +296,14 @@ struct cdns_sierra_phy {
 	struct reset_control *apb_rst;
 	struct regmap *regmap_lane_cdb[SIERRA_MAX_LANES];
 	struct regmap *regmap_phy_pcs_common_cdb;
+	struct regmap *regmap_phy_pcs_lane_cdb[SIERRA_MAX_LANES];
 	struct regmap *regmap_phy_pma_common_cdb;
 	struct regmap *regmap_common_cdb;
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
 	struct regmap_field *pma_cmn_ready;
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
+	struct regmap_field *phy_iso_link_ctrl_1[SIERRA_MAX_LANES];
 	struct regmap_field *cmn_refrcv_refclk_plllc1en_preg[SIERRA_NUM_CMN_PLLC];
 	struct regmap_field *cmn_refrcv_refclk_termen_preg[SIERRA_NUM_CMN_PLLC];
 	struct regmap_field *cmn_plllc_pfdclk1_sel_preg[SIERRA_NUM_CMN_PLLC];
@@ -367,6 +378,34 @@ static const struct regmap_config cdns_sierra_phy_pcs_cmn_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
+#define SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF(n) \
+{ \
+	.name = "sierra_phy_pcs_lane" n "_cdb", \
+	.reg_stride = 1, \
+	.fast_io = true, \
+	.reg_write = cdns_regmap_write, \
+	.reg_read = cdns_regmap_read, \
+}
+
+static const struct regmap_config cdns_sierra_phy_pcs_lane_cdb_config[] = {
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("0"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("1"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("2"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("3"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("4"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("5"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("6"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("7"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("8"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("9"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("10"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("11"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("12"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("13"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("14"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("15"),
+};
+
 static const struct regmap_config cdns_sierra_phy_pma_cmn_cdb_config = {
 	.name = "sierra_phy_pma_cmn_cdb",
 	.reg_stride = 1,
@@ -452,6 +491,15 @@ static int cdns_sierra_phy_on(struct phy *gphy)
 		return ret;
 	}
 
+	if (ins->phy_type == TYPE_PCIE || ins->phy_type == TYPE_USB) {
+		ret = regmap_field_read_poll_timeout(sp->phy_iso_link_ctrl_1[ins->mlane],
+						     val, !val, 1000, PLL_LOCK_TIME);
+		if (ret) {
+			dev_err(dev, "Timeout waiting for PHY status ready\n");
+			return ret;
+		}
+	}
+
 	/*
 	 * Wait for cmn_ready assertion
 	 * PHY_PMA_CMN_CTRL[0] == 1
@@ -755,7 +803,17 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 			dev_err(dev, "P%d_ENABLE reg field init failed\n", i);
 			return PTR_ERR(field);
 		}
-		sp->pllctrl_lock[i] =  field;
+		sp->pllctrl_lock[i] = field;
+	}
+
+	for (i = 0; i < SIERRA_MAX_LANES; i++) {
+		regmap = sp->regmap_phy_pcs_lane_cdb[i];
+		field = devm_regmap_field_alloc(dev, regmap, phy_iso_link_ctrl_1);
+		if (IS_ERR(field)) {
+			dev_err(dev, "PHY_ISO_LINK_CTRL reg field init for lane %d failed\n", i);
+			return PTR_ERR(field);
+		}
+		sp->phy_iso_link_ctrl_1[i] = field;
 	}
 
 	return 0;
@@ -801,6 +859,19 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	}
 	sp->regmap_phy_pcs_common_cdb = regmap;
 
+	for (i = 0; i < SIERRA_MAX_LANES; i++) {
+		block_offset = SIERRA_PHY_PCS_LANE_CDB_OFFSET(i, block_offset_shift,
+							      reg_offset_shift);
+		regmap = cdns_regmap_init(dev, base, block_offset,
+					  reg_offset_shift,
+					  &cdns_sierra_phy_pcs_lane_cdb_config[i]);
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "Failed to init PHY PCS lane CDB regmap\n");
+			return PTR_ERR(regmap);
+		}
+		sp->regmap_phy_pcs_lane_cdb[i] = regmap;
+	}
+
 	block_offset = SIERRA_PHY_PMA_COMMON_OFFSET(block_offset_shift);
 	regmap = cdns_regmap_init(dev, base, block_offset, reg_offset_shift,
 				  &cdns_sierra_phy_pma_cmn_cdb_config);
-- 
2.26.1

