Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA947DEF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346580AbhLWGOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:14:23 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:18728 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234171AbhLWGOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:14:20 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN4F4Su005438;
        Wed, 22 Dec 2021 22:14:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TLuV1d95SXlzRwf2Jt8/PsQ9w45ubtPbcoD86nL/np0=;
 b=e51l9cjXW0RjE6PICc1L7yTgCwijtQqGi1UP5WF1rADM6pj+EopBfTrEHeT4hZ7ZllRN
 Kth+uXtum0UKFQl2iTnwP7EshV7nIDuo2Jjpb1LNMO8Pvr2khFcI/GCazN9nSsrt7l/o
 V23wAKrbeUgAmN92HxAToI0XOIgBcrzu44UH5rqcsRTkMScNhZf7GhxKg1hGYWMnEOK4
 s9HyeaIm2/xiouqqRXaz9d3muCw+r4Gb/LuYwPcqJzXQN0DAOxTfS2ClDgunh9oIlND3
 C6WY830SG9wtV314b0QqlxzSAJ71sNePl+1tHYtel9WnC5EV93LPM3P5fzog79MJ9AS5 Vw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3d3rwxvkja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:14:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwOuySR2U6sJNJFt9Af6JBNNgPWAM6lybEuOkg/UvD3N26Lo3691LsWNR4okNvNSAnNsvmzNf53LQj4/t/gK2vnV2FQLaN2qJyGRDMQcF911QH3ue0ovK2YDlGmNvmS62/+AAYIexYFx3mAFzBLe9CztgXJ7MjTsuI37JtcLxtH2b2vXllpiFfiHQ15g6c5H1QI63HFRfccBmoC+M0of3yXiKnh7/9fSon9MGBGRY94YGaL4Cc4IJEDz6YZU57d+MzBUToq6R1EwUk8QES427pz9gy6MnzDxMpTYWbCr4ssUZaXzpJOmE/4c4wDlbiofORvD5Tg+nzrquxocIvgrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLuV1d95SXlzRwf2Jt8/PsQ9w45ubtPbcoD86nL/np0=;
 b=UYz/iRKKOys0tYIXtBOTUbOrt+pIGcJVV+Z5ZLEoRbVlBitpveU0AmEnVzCaLU1VSSKNHvB3KNfX+/l92KtT3RHx73nN8+wUlb5E2aAAjy9OAEckgbbqKt/IDCw1JHLgv760SjuFmgRV1J0qYsuGh/txnIHoQ/5rwP0MnExGcB0vA/C1DIKnztpAxD2d1EgqKIVvS+KTnxR+n33GwzHoxe+Rx1yKOvF2YeJs5rRV3XKbeUn//NTexolLd/cznPBVPjgxv5/jl6gLIVctswRgE+zIv2jVUZfH+WjwuMwOVQPoD63pgnneLz/uub9bH76DItNFeeiJxSp9BFB8bYD8zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLuV1d95SXlzRwf2Jt8/PsQ9w45ubtPbcoD86nL/np0=;
 b=2JpMoLFbC5u9aAC4P52tFnhkWvGFjk0wBmfCY7YkDlq0q5H1uVVDWG0i4wUqBVDVzvp/EQB0pIMPGIEI/1a2aCEDitHR8OwibFl2PrCULLezP9qU9Ah/2IDnVDyHMaAeAdBt9HxJp+iNXpn2MyAlgZEsBRHXOZcS7jrg8eUSLAE=
Received: from MWHPR13CA0048.namprd13.prod.outlook.com (2603:10b6:300:95::34)
 by BL3PR07MB8802.namprd07.prod.outlook.com (2603:10b6:208:351::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Thu, 23 Dec
 2021 06:14:09 +0000
Received: from MW2NAM12FT045.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::ac) by MWHPR13CA0048.outlook.office365.com
 (2603:10b6:300:95::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.6 via Frontend
 Transport; Thu, 23 Dec 2021 06:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT045.mail.protection.outlook.com (10.13.181.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:14:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6E89p022258
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:14:09 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:14:08 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:14:07 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:14:07 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6CEIp017729;
        Thu, 23 Dec 2021 07:13:02 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN6CEbU017728;
        Thu, 23 Dec 2021 07:12:14 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 07/15] phy: cadence: Sierra: Add PHY PCS common register configurations
Date:   Thu, 23 Dec 2021 07:01:29 +0100
Message-ID: <20211223060137.9252-8-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3183f8ac-53da-4754-1104-08d9c5db6e7e
X-MS-TrafficTypeDiagnostic: BL3PR07MB8802:EE_
X-Microsoft-Antispam-PRVS: <BL3PR07MB88027E35DFF604A3FFD8C89EC57E9@BL3PR07MB8802.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EGqZnPIPXYm4h0WSmHFWLab8kL2LRKqBAjaevMa6Syl4VLxdj1c8A4t6FiiG4qo+YVPVs1PGWe65EvWcaXJCF7vz5Bu4qPYeQAuekEp+1vSH2PNcqUd2g08ePOMQYn0t4jGBgJrR3nx1VMTmSgozgJIxVc0UWKj3wyy9Y32RJ3CYBNyAHBpjMbP0jj3zz/MEfMs8TLb8UPANttz0ja0b5CuLQY2ce4LKRZTThGqgam4sHRcDSEtqi1vx4po00K8FuLXMRj4/mCa2nLZIW+q70W6IKC7UtlTqVdGZl5gC63NU9wFFHWy/RTJTp99cAB6635vMrjStVvU+0IXIVC0+7sa/WdM0WBql5CRRicQjSptQBiBlAu8+Phha/G7GjOiBYqr5wlfW4o3U2zgTUt2jBLHY9NVDf3Oeo26TnyPamqL6dRzk2T2YXwuZlp0HAA8nDObR3NtpQleZV0d7j41jRyjwMV+G2+z6AA8wXq5X5NTctaI/BOPd15o4dcRkWk4IJ5mdKME8tSN1DzK6h7UZvoGNdVPympD17fCAeUUC0b3br6b5OY57nVMPd6RW3UVnZDJICZzPEcnsNG8WsVcZ7qZhZulEUMuRmaEmni75W0bhW1VOwsU14ArHyygiiLIsLulrhiNNftGdI/AEla+zOJSTKgv55TJLoy81Uo5PG8mTQ69gAGKiXdHVKyn5eAkqQGziBAj4sxkRy3Y5TcSbsA4GcZIYPznozx4++9eZkU6ECrfNt3BJ1WRGC4mFmKL1cy5vZ7ZUU9ZbYxzdu+Ux8FmPNzT4L4d+41K8nDvSrY=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(40470700002)(46966006)(36840700001)(42186006)(110136005)(54906003)(316002)(8936002)(36860700001)(19627235002)(40460700001)(508600001)(4326008)(186003)(26005)(6666004)(2906002)(2616005)(47076005)(426003)(356005)(83380400001)(7636003)(36756003)(8676002)(70586007)(1076003)(70206006)(336012)(5660300002)(86362001)(82310400004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:14:09.1276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3183f8ac-53da-4754-1104-08d9c5db6e7e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT045.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR07MB8802
X-Proofpoint-ORIG-GUID: 90RrYHm4CwmfM4jASZTWl7Bijg4Vp34l
X-Proofpoint-GUID: 90RrYHm4CwmfM4jASZTWl7Bijg4Vp34l
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

Add PHY PCS common register configuration sequences for single link.
Update single link PCIe register sequence accordingly.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 9f2b8aefee9c..0bfd13843f2e 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -148,6 +148,7 @@
 /* PHY PCS common registers */
 #define SIERRA_PHY_PCS_COMMON_OFFSET(block_offset)	\
 				     (0xc000 << (block_offset))
+#define SIERRA_PHY_PIPE_CMN_CTRL1			0x0
 #define SIERRA_PHY_PLL_CFG				0xe
 
 #define SIERRA_MACRO_ID					0x00007364
@@ -256,6 +257,8 @@ struct cdns_sierra_data {
 	u32 id_value;
 	u8 block_offset_shift;
 	u8 reg_offset_shift;
+	struct cdns_sierra_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					     [NUM_SSC_MODE];
 	struct cdns_sierra_vals *pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					     [NUM_SSC_MODE];
 	struct cdns_sierra_vals *pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
@@ -364,6 +367,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	enum cdns_sierra_phy_type phy_type = ins->phy_type;
 	enum cdns_sierra_ssc_mode ssc = ins->ssc_mode;
 	const struct cdns_reg_pairs *reg_pairs;
+	struct cdns_sierra_vals *pcs_cmn_vals;
 	struct regmap *regmap;
 	u32 num_regs;
 	int i, j;
@@ -375,6 +379,16 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
 	clk_set_rate(phy->input_clks[CMN_REFCLK1_DIG_DIV], 25000000);
 
+	/* PHY PCS common registers configurations */
+	pcs_cmn_vals = init_data->pcs_cmn_vals[phy_type][TYPE_NONE][ssc];
+	if (pcs_cmn_vals) {
+		reg_pairs = pcs_cmn_vals->reg_pairs;
+		num_regs = pcs_cmn_vals->num_regs;
+		regmap = phy->regmap_phy_pcs_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
+	}
+
 	/* PMA common registers configurations */
 	pma_cmn_vals = init_data->pma_cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (pma_cmn_vals) {
@@ -1022,6 +1036,16 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* PCIE PHY PCS common configuration */
+static struct cdns_reg_pairs pcie_phy_pcs_cmn_regs[] = {
+	{0x0430, SIERRA_PHY_PIPE_CMN_CTRL1}
+};
+
+static struct cdns_sierra_vals pcie_phy_pcs_cmn_vals = {
+	.reg_pairs = pcie_phy_pcs_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_phy_pcs_cmn_regs),
+};
+
 /* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc */
 static const struct cdns_reg_pairs cdns_pcie_cmn_regs_ext_ssc[] = {
 	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
@@ -1173,6 +1197,13 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 	.id_value = SIERRA_MACRO_ID,
 	.block_offset_shift = 0x2,
 	.reg_offset_shift = 0x2,
+	.pcs_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
+		},
+	},
 	.pma_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -1203,6 +1234,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 	.id_value = SIERRA_MACRO_ID,
 	.block_offset_shift = 0x0,
 	.reg_offset_shift = 0x1,
+	.pcs_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
+		},
+	},
 	.pma_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
-- 
2.26.1

