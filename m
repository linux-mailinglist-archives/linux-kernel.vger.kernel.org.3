Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EA847DF09
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhLWGXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:23:51 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:41680 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232444AbhLWGXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:23:50 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN3qOR8005437;
        Wed, 22 Dec 2021 22:23:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=AYcAo/izBFzA+7YDlOxlteToCyJvJyUp7sDLyvMrcBw=;
 b=dDih7RbYvZ/qthXXEsZBy33iPpnF7VsyvmStgrxee7AwCSF1L/Cp4k89t8urgZuF88ND
 iNniM4B6EDtt49zkrzJEpcQQo9kJLk7YSgGH/jZDUMaAGDAxRC0S5I1RI7vW7rnY5XTG
 AtxZ5Dh0Aah893sL7s4LWlpTxqMOOoKD010GIHoVlM6NukcIyAYuZvHx3ADZobf8qVrh
 Oi4QADN8Klf/ndJuikIrkZxj+f39KYaf8PfiYI971L+CxCxFqKzhBKXXqnlSx4MQ2pM3
 l1zpmxMTk96rNc1sgNJkFnLmVgGox3LleXB5rAe3m6taKzg4ojUh0qTLJtOIsJwqdEjD 4Q== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3d3rwxvm8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:23:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2TC2mR5Ir/sewzXNzGhmTu8qdzJcnyiqfpSjCDRAi7tfEMnYRAdcf+D8DA6IBAOLsTqvgMgtRmnUCfGvEa1o5o3fbb1YgTUh2ib1glUFc8BVZ/gvOHcp3Q2VjmJD4+hugmpi9KHUjwFdsHNlkBPTuj/E2P/vPUivGHk1ONUShCrpo8rGcYfxxUrCGNOLusdXZW6jaLd6NRNULVBmMVgMwim5x/VfSoGxqRfBTJ5z014IHA8f3nuNqCv9avaimgulEFpWeJR09lZ0YoRwLdxcT4pVgDGOkWiZjFjCh93+Y9j2dQNztDqWv+FtNnf3iK7iO0MmbWRGvHxO1b1zb0jXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYcAo/izBFzA+7YDlOxlteToCyJvJyUp7sDLyvMrcBw=;
 b=jN+2hW+ytiH8bdneNaiNzQibmgEI2KuvlPzIDF0dEXINgXDyA/NFkyuHs7FS+N0Fc64IUvZqEvOB4ni9Vu1rROL5BL/llDe/aA1fwSxrSQ3W2+luXPCTeSoVSvo9uvfemLXSE2DrwX/wWjUW0NA8ppDuahBIgnN080F11qoTxHQAi9zRidtuvUam0H/+xa3H/ej7fUg68aYXJaBeSxCW4Xn88P8eT1ErjfHDOsx3b6RxfCiqKx7FcYGrvQNZmFwdlAE7IPBJ4pH0SF4/j4ybTAyNHE/oggytzHKP9ENPXNxGR+68FRlBIRz4CKBBI2Uq+JsGw/uHM3OkkahD4UJpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYcAo/izBFzA+7YDlOxlteToCyJvJyUp7sDLyvMrcBw=;
 b=NgwCJlL6F4rhKGRJV5tK042soctaxtt+fBnuIi607CN+ynXvKLayVH/h9PuuqK23c/9Lpcv9ropmYrgj3Kg+Tpka28rr9OUI7o35fDqitRuDqU66t9u0Je4ndZCcWFSbEqxU9I2ut1HGpZhxwU9r1sw/1VvwWiBDcg28KGveOJE=
Received: from MWHPR12CA0062.namprd12.prod.outlook.com (2603:10b6:300:103::24)
 by PH0PR07MB9236.namprd07.prod.outlook.com (2603:10b6:510:117::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 06:23:33 +0000
Received: from MW2NAM12FT064.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::5) by MWHPR12CA0062.outlook.office365.com
 (2603:10b6:300:103::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Thu, 23 Dec 2021 06:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT064.mail.protection.outlook.com (10.13.181.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:23:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6NWQ3023168
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:23:33 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:23:32 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:23:32 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:23:32 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6Ld9M021300;
        Thu, 23 Dec 2021 07:22:11 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN6LcGq021294;
        Thu, 23 Dec 2021 07:21:38 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY multilink configuration
Date:   Thu, 23 Dec 2021 07:01:35 +0100
Message-ID: <20211223060137.9252-14-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e660427e-112e-4664-ce22-08d9c5dcbeb7
X-MS-TrafficTypeDiagnostic: PH0PR07MB9236:EE_
X-Microsoft-Antispam-PRVS: <PH0PR07MB9236744B12CEA7030A128336C57E9@PH0PR07MB9236.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: io/SsNQCdsO2mMkEf01eNYHZmRFui3FhkGzUHUpL0cGtgLD4wTXzkaSgah18KLjiJwgBa6WswY46Q4Iw/Kn28iTOGkD63nA7yh2H+ml6Sih86e32zbh8P2f38abKEaD+9eHDmLnE8KUWxKvVwbUoY+lyknzQGJtzoH+pdAkuGk0M1Cr3pqTZr6Q4VqlGRfJko6SBO0pCGIvX1KUV5Hmr7L4C/k2Y9pFMzp9bFpbNM8bF/uhiECi1y72sJ1ZWcMT5j3FjGTDN8pDj5B60QBAw5Scm52NaaPXglZb0hOvZafXCq/l+epkuFm2MWXmVlTGqt3vXMdsbvw7kNImzCZYljk/PSeW+cQvqAviaHJ+c9g9DPOIhDbEvOXrQgyxVk2QpcVG7dL5RqeTwNELPXOtInqBM2GHvqWykFGWNPYAZVS5PSb7ESOdO82gmIVG6W+v2oIeJ6NaGXagA27yq0tkOQ2Ca7REx3vSpDGR2QCoMRvq/i9QMBKX270kxr9RKMUSRNzhYIMXyra39oXZV2O5KffAqhheJPciM0V2DAUAXPdfjxOGSWHQI7sam+nCj25oSnfRODsJM0fQjSXd5zSOeECkmToY6fxuaW5OYIY+MHK2femfYhoWM+Dbe/KOs9xQImjpc4lNK8FIwUaYc6BVHcBlzvYcOW5GHQPSUhcCgXDjyzDF1dj6wqSrrvPuCQrQ9WUP3skbG4zh+E5WurTae4mF/gzaIoWrkthFT+VzJzcnYBvBNii5wXrWtXNNpgTb1HpsChKincHrSUc+Uv8RYHSdK4U0Ecyj3sBolgLsu118=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(40470700002)(19627235002)(47076005)(70586007)(186003)(26005)(336012)(36756003)(6666004)(2616005)(508600001)(316002)(42186006)(70206006)(54906003)(110136005)(4326008)(2906002)(83380400001)(426003)(1076003)(8936002)(36860700001)(356005)(5660300002)(8676002)(86362001)(82310400004)(30864003)(7636003)(40460700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:23:33.2361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e660427e-112e-4664-ce22-08d9c5dcbeb7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT064.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB9236
X-Proofpoint-ORIG-GUID: XJD0r2plUEbF961jH8sOy8tXweL6hisr
X-Proofpoint-GUID: XJD0r2plUEbF961jH8sOy8tXweL6hisr
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

Add register sequences for PCIe + QSGMII PHY multilink configuration.
PHY configuration for multi-link operation is done in two steps.
e.g. Consider a case for a 4 lane PHY with PCIe using 2 lanes and QSGMII
other 2 lanes. Sierra PHY has 2 PLLs, viz. PLLLC and PLLLC1. So in this
case, PLLLC is used for PCIe and PLLLC1 is used for QSGMII.

PHY is configured in two steps as described below.

[1] For first step, the register values are selected as
    [TYPE_PCIE][TYPE_QSGMII][ssc].
    This will configure PHY registers associated for PCIe involving PLLLC
    registers and registers for first 2 lanes of PHY.
[2] In second step, the register values are selected as
    [TYPE_QSGMII][TYPE_PCIE][ssc].
    This will configure PHY registers associated for QSGMII involving
    PLLLC1 registers and registers for other 2 lanes of PHY.

This completes the PHY configuration for multilink operation.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 377 ++++++++++++++++++++++-
 1 file changed, 376 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 8f356bf38be8..e2b0530ca04c 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -45,6 +45,9 @@
 #define SIERRA_CMN_REFRCV_PREG				0x98
 #define SIERRA_CMN_REFRCV1_PREG				0xB8
 #define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
+#define SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG		0xCA
+#define SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG		0xD0
+#define SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG	0xE2
 
 #define SIERRA_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
 				((0x4000 << (block_offset)) + \
@@ -59,6 +62,9 @@
 #define SIERRA_PSM_A0IN_TMR_PREG			0x009
 #define SIERRA_PSM_A3IN_TMR_PREG			0x00C
 #define SIERRA_PSM_DIAG_PREG				0x015
+#define SIERRA_PSC_LN_A3_PREG				0x023
+#define SIERRA_PSC_LN_A4_PREG				0x024
+#define SIERRA_PSC_LN_IDLE_PREG				0x026
 #define SIERRA_PSC_TX_A0_PREG				0x028
 #define SIERRA_PSC_TX_A1_PREG				0x029
 #define SIERRA_PSC_TX_A2_PREG				0x02A
@@ -68,6 +74,7 @@
 #define SIERRA_PSC_RX_A2_PREG				0x032
 #define SIERRA_PSC_RX_A3_PREG				0x033
 #define SIERRA_PLLCTRL_SUBRATE_PREG			0x03A
+#define SIERRA_PLLCTRL_GEN_A_PREG			0x03B
 #define SIERRA_PLLCTRL_GEN_D_PREG			0x03E
 #define SIERRA_PLLCTRL_CPGAIN_MODE_PREG			0x03F
 #define SIERRA_PLLCTRL_STATUS_PREG			0x044
@@ -150,6 +157,7 @@
 #define SIERRA_CPICAL_TMRVAL_MODE0_PREG			0x171
 #define SIERRA_CPICAL_PICNT_MODE1_PREG			0x174
 #define SIERRA_CPI_OUTBUF_RATESEL_PREG			0x17C
+#define SIERRA_CPI_RESBIAS_BIN_PREG			0x17E
 #define SIERRA_CPI_TRIM_PREG				0x17F
 #define SIERRA_CPICAL_RES_STARTCODE_MODE23_PREG		0x183
 #define SIERRA_EPI_CTRL_PREG				0x187
@@ -272,7 +280,8 @@ static u32 cdns_sierra_pll_mux_table[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
 enum cdns_sierra_phy_type {
 	TYPE_NONE,
 	TYPE_PCIE,
-	TYPE_USB
+	TYPE_USB,
+	TYPE_QSGMII
 };
 
 enum cdns_sierra_ssc_mode {
@@ -807,6 +816,9 @@ static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 	case PHY_TYPE_USB3:
 		inst->phy_type = TYPE_USB;
 		break;
+	case PHY_TYPE_QSGMII:
+		inst->phy_type = TYPE_QSGMII;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1199,6 +1211,9 @@ static int cdns_sierra_phy_configure_multilink(struct cdns_sierra_phy *sp)
 					regmap_write(regmap, reg_pairs[j].off, reg_pairs[j].val);
 			}
 		}
+
+		if (phy_t1 == TYPE_QSGMII)
+			reset_control_deassert(sp->phys[node].lnk_rst);
 	}
 
 	/* Take the PHY out of reset */
@@ -1376,6 +1391,72 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* QSGMII PHY PMA lane configuration */
+static struct cdns_reg_pairs qsgmii_phy_pma_ln_regs[] = {
+	{0x9010, SIERRA_PHY_PMA_XCVR_CTRL}
+};
+
+static struct cdns_sierra_vals qsgmii_phy_pma_ln_vals = {
+	.reg_pairs = qsgmii_phy_pma_ln_regs,
+	.num_regs = ARRAY_SIZE(qsgmii_phy_pma_ln_regs),
+};
+
+/* QSGMII refclk 100MHz, 20b, opt1, No BW cal, no ssc, PLL LC1 */
+static const struct cdns_reg_pairs qsgmii_100_no_ssc_plllc1_cmn_regs[] = {
+	{0x2085, SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG},
+	{0x0000, SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG},
+	{0x0000, SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG}
+};
+
+static const struct cdns_reg_pairs qsgmii_100_no_ssc_plllc1_ln_regs[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x0252, SIERRA_DET_STANDEC_E_PREG},
+	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
+	{0x0FFE, SIERRA_PSC_RX_A0_PREG},
+	{0x0011, SIERRA_PLLCTRL_SUBRATE_PREG},
+	{0x0001, SIERRA_PLLCTRL_GEN_A_PREG},
+	{0x5233, SIERRA_PLLCTRL_CPGAIN_MODE_PREG},
+	{0x0000, SIERRA_DRVCTRL_ATTEN_PREG},
+	{0x0089, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x3C3C, SIERRA_CREQ_CCLKDET_MODE01_PREG},
+	{0x3222, SIERRA_CREQ_FSMCLK_SEL_PREG},
+	{0x0000, SIERRA_CREQ_EQ_CTRL_PREG},
+	{0x8422, SIERRA_CTLELUT_CTRL_PREG},
+	{0x4111, SIERRA_DFE_ECMP_RATESEL_PREG},
+	{0x4111, SIERRA_DFE_SMP_RATESEL_PREG},
+	{0x0002, SIERRA_DEQ_PHALIGN_CTRL},
+	{0x9595, SIERRA_DEQ_VGATUNE_CTRL_PREG},
+	{0x0186, SIERRA_DEQ_GLUT0},
+	{0x0186, SIERRA_DEQ_GLUT1},
+	{0x0186, SIERRA_DEQ_GLUT2},
+	{0x0186, SIERRA_DEQ_GLUT3},
+	{0x0186, SIERRA_DEQ_GLUT4},
+	{0x0861, SIERRA_DEQ_ALUT0},
+	{0x07E0, SIERRA_DEQ_ALUT1},
+	{0x079E, SIERRA_DEQ_ALUT2},
+	{0x071D, SIERRA_DEQ_ALUT3},
+	{0x03F5, SIERRA_DEQ_DFETAP_CTRL_PREG},
+	{0x0C01, SIERRA_DEQ_TAU_CTRL1_FAST_MAINT_PREG},
+	{0x3C40, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
+	{0x1C04, SIERRA_DEQ_TAU_CTRL2_PREG},
+	{0x0033, SIERRA_DEQ_PICTRL_PREG},
+	{0x0660, SIERRA_CPICAL_TMRVAL_MODE0_PREG},
+	{0x00D5, SIERRA_CPI_OUTBUF_RATESEL_PREG},
+	{0x0B6D, SIERRA_CPI_RESBIAS_BIN_PREG},
+	{0x0102, SIERRA_RXBUFFER_CTLECTRL_PREG},
+	{0x0002, SIERRA_RXBUFFER_RCDFECTRL_PREG}
+};
+
+static struct cdns_sierra_vals qsgmii_100_no_ssc_plllc1_cmn_vals = {
+	.reg_pairs = qsgmii_100_no_ssc_plllc1_cmn_regs,
+	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_plllc1_cmn_regs),
+};
+
+static struct cdns_sierra_vals qsgmii_100_no_ssc_plllc1_ln_vals = {
+	.reg_pairs = qsgmii_100_no_ssc_plllc1_ln_regs,
+	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_plllc1_ln_regs),
+};
+
 /* PCIE PHY PCS common configuration */
 static struct cdns_reg_pairs pcie_phy_pcs_cmn_regs[] = {
 	{0x0430, SIERRA_PHY_PIPE_CMN_CTRL1}
@@ -1386,6 +1467,233 @@ static struct cdns_sierra_vals pcie_phy_pcs_cmn_vals = {
 	.num_regs = ARRAY_SIZE(pcie_phy_pcs_cmn_regs),
 };
 
+/* refclk100MHz_32b_PCIe_cmn_pll_no_ssc, pcie_links_using_plllc, pipe_bw_3 */
+static const struct cdns_reg_pairs pcie_100_no_ssc_plllc_cmn_regs[] = {
+	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
+	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG}
+};
+
+/*
+ * refclk100MHz_32b_PCIe_ln_no_ssc, multilink, using_plllc,
+ * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz
+ */
+static const struct cdns_reg_pairs ml_pcie_100_no_ssc_ln_regs[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
+	{0x0004, SIERRA_PSC_LN_A3_PREG},
+	{0x0004, SIERRA_PSC_LN_A4_PREG},
+	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
+	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
+	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
+	{0x8055, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
+	{0x80BB, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
+	{0x8351, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
+	{0x8349, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
+	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
+	{0x5624, SIERRA_DEQ_CONCUR_CTRL2_PREG},
+	{0x000F, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
+	{0x00FF, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
+	{0x4C4C, SIERRA_DEQ_ERRCMP_CTRL_PREG},
+	{0x02FA, SIERRA_DEQ_OFFSET_CTRL_PREG},
+	{0x02FA, SIERRA_DEQ_GAIN_CTRL_PREG},
+	{0x0041, SIERRA_DEQ_GLUT0},
+	{0x0082, SIERRA_DEQ_GLUT1},
+	{0x00C3, SIERRA_DEQ_GLUT2},
+	{0x0145, SIERRA_DEQ_GLUT3},
+	{0x0186, SIERRA_DEQ_GLUT4},
+	{0x09E7, SIERRA_DEQ_ALUT0},
+	{0x09A6, SIERRA_DEQ_ALUT1},
+	{0x0965, SIERRA_DEQ_ALUT2},
+	{0x08E3, SIERRA_DEQ_ALUT3},
+	{0x00FA, SIERRA_DEQ_DFETAP0},
+	{0x00FA, SIERRA_DEQ_DFETAP1},
+	{0x00FA, SIERRA_DEQ_DFETAP2},
+	{0x00FA, SIERRA_DEQ_DFETAP3},
+	{0x00FA, SIERRA_DEQ_DFETAP4},
+	{0x000F, SIERRA_DEQ_PRECUR_PREG},
+	{0x0280, SIERRA_DEQ_POSTCUR_PREG},
+	{0x8F00, SIERRA_DEQ_POSTCUR_DECR_PREG},
+	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
+	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
+	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
+	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x002B, SIERRA_CPI_TRIM_PREG},
+	{0x0003, SIERRA_EPI_CTRL_PREG},
+	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
+	{0x0004, SIERRA_RXBUFFER_CTLECTRL_PREG},
+	{0x2010, SIERRA_RXBUFFER_RCDFECTRL_PREG},
+	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
+};
+
+static struct cdns_sierra_vals pcie_100_no_ssc_plllc_cmn_vals = {
+	.reg_pairs = pcie_100_no_ssc_plllc_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_100_no_ssc_plllc_cmn_regs),
+};
+
+static struct cdns_sierra_vals ml_pcie_100_no_ssc_ln_vals = {
+	.reg_pairs = ml_pcie_100_no_ssc_ln_regs,
+	.num_regs = ARRAY_SIZE(ml_pcie_100_no_ssc_ln_regs),
+};
+
+/* refclk100MHz_32b_PCIe_cmn_pll_int_ssc, pcie_links_using_plllc, pipe_bw_3 */
+static const struct cdns_reg_pairs pcie_100_int_ssc_plllc_cmn_regs[] = {
+	{0x000E, SIERRA_CMN_PLLLC_MODE_PREG},
+	{0x4006, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
+	{0x4006, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
+	{0x0000, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
+	{0x0000, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG},
+	{0x0581, SIERRA_CMN_PLLLC_DSMCORR_PREG},
+	{0x7F80, SIERRA_CMN_PLLLC_SS_PREG},
+	{0x0041, SIERRA_CMN_PLLLC_SS_AMP_STEP_SIZE_PREG},
+	{0x0464, SIERRA_CMN_PLLLC_SSTWOPT_PREG},
+	{0x0D0D, SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG},
+	{0x0060, SIERRA_CMN_PLLLC_LOCK_DELAY_CTRL_PREG}
+};
+
+/*
+ * refclk100MHz_32b_PCIe_ln_int_ssc, multilink, using_plllc,
+ * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz
+ */
+static const struct cdns_reg_pairs ml_pcie_100_int_ssc_ln_regs[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
+	{0x0004, SIERRA_PSC_LN_A3_PREG},
+	{0x0004, SIERRA_PSC_LN_A4_PREG},
+	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
+	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
+	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
+	{0x813E, SIERRA_CLKPATHCTRL_TMR_PREG},
+	{0x8047, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
+	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
+	{0x033C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
+	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG},
+	{0x5624, SIERRA_DEQ_CONCUR_CTRL2_PREG},
+	{0x000F, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
+	{0x00FF, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
+	{0x4C4C, SIERRA_DEQ_ERRCMP_CTRL_PREG},
+	{0x02FA, SIERRA_DEQ_OFFSET_CTRL_PREG},
+	{0x02FA, SIERRA_DEQ_GAIN_CTRL_PREG},
+	{0x0041, SIERRA_DEQ_GLUT0},
+	{0x0082, SIERRA_DEQ_GLUT1},
+	{0x00C3, SIERRA_DEQ_GLUT2},
+	{0x0145, SIERRA_DEQ_GLUT3},
+	{0x0186, SIERRA_DEQ_GLUT4},
+	{0x09E7, SIERRA_DEQ_ALUT0},
+	{0x09A6, SIERRA_DEQ_ALUT1},
+	{0x0965, SIERRA_DEQ_ALUT2},
+	{0x08E3, SIERRA_DEQ_ALUT3},
+	{0x00FA, SIERRA_DEQ_DFETAP0},
+	{0x00FA, SIERRA_DEQ_DFETAP1},
+	{0x00FA, SIERRA_DEQ_DFETAP2},
+	{0x00FA, SIERRA_DEQ_DFETAP3},
+	{0x00FA, SIERRA_DEQ_DFETAP4},
+	{0x000F, SIERRA_DEQ_PRECUR_PREG},
+	{0x0280, SIERRA_DEQ_POSTCUR_PREG},
+	{0x8F00, SIERRA_DEQ_POSTCUR_DECR_PREG},
+	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
+	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
+	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
+	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x002B, SIERRA_CPI_TRIM_PREG},
+	{0x0003, SIERRA_EPI_CTRL_PREG},
+	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
+	{0x0004, SIERRA_RXBUFFER_CTLECTRL_PREG},
+	{0x2010, SIERRA_RXBUFFER_RCDFECTRL_PREG},
+	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
+};
+
+static struct cdns_sierra_vals pcie_100_int_ssc_plllc_cmn_vals = {
+	.reg_pairs = pcie_100_int_ssc_plllc_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_100_int_ssc_plllc_cmn_regs),
+};
+
+static struct cdns_sierra_vals ml_pcie_100_int_ssc_ln_vals = {
+	.reg_pairs = ml_pcie_100_int_ssc_ln_regs,
+	.num_regs = ARRAY_SIZE(ml_pcie_100_int_ssc_ln_regs),
+};
+
+/* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc, pcie_links_using_plllc, pipe_bw_3 */
+static const struct cdns_reg_pairs pcie_100_ext_ssc_plllc_cmn_regs[] = {
+	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
+	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG},
+	{0x1B1B, SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG}
+};
+
+/*
+ * refclk100MHz_32b_PCIe_ln_ext_ssc, multilink, using_plllc,
+ * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz
+ */
+static const struct cdns_reg_pairs ml_pcie_100_ext_ssc_ln_regs[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
+	{0x0004, SIERRA_PSC_LN_A3_PREG},
+	{0x0004, SIERRA_PSC_LN_A4_PREG},
+	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
+	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
+	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
+	{0x813E, SIERRA_CLKPATHCTRL_TMR_PREG},
+	{0x8047, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
+	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
+	{0x033C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
+	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG},
+	{0x5624, SIERRA_DEQ_CONCUR_CTRL2_PREG},
+	{0x000F, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
+	{0x00FF, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
+	{0x4C4C, SIERRA_DEQ_ERRCMP_CTRL_PREG},
+	{0x02FA, SIERRA_DEQ_OFFSET_CTRL_PREG},
+	{0x02FA, SIERRA_DEQ_GAIN_CTRL_PREG},
+	{0x0041, SIERRA_DEQ_GLUT0},
+	{0x0082, SIERRA_DEQ_GLUT1},
+	{0x00C3, SIERRA_DEQ_GLUT2},
+	{0x0145, SIERRA_DEQ_GLUT3},
+	{0x0186, SIERRA_DEQ_GLUT4},
+	{0x09E7, SIERRA_DEQ_ALUT0},
+	{0x09A6, SIERRA_DEQ_ALUT1},
+	{0x0965, SIERRA_DEQ_ALUT2},
+	{0x08E3, SIERRA_DEQ_ALUT3},
+	{0x00FA, SIERRA_DEQ_DFETAP0},
+	{0x00FA, SIERRA_DEQ_DFETAP1},
+	{0x00FA, SIERRA_DEQ_DFETAP2},
+	{0x00FA, SIERRA_DEQ_DFETAP3},
+	{0x00FA, SIERRA_DEQ_DFETAP4},
+	{0x000F, SIERRA_DEQ_PRECUR_PREG},
+	{0x0280, SIERRA_DEQ_POSTCUR_PREG},
+	{0x8F00, SIERRA_DEQ_POSTCUR_DECR_PREG},
+	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
+	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
+	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
+	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x002B, SIERRA_CPI_TRIM_PREG},
+	{0x0003, SIERRA_EPI_CTRL_PREG},
+	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
+	{0x0004, SIERRA_RXBUFFER_CTLECTRL_PREG},
+	{0x2010, SIERRA_RXBUFFER_RCDFECTRL_PREG},
+	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
+};
+
+static struct cdns_sierra_vals pcie_100_ext_ssc_plllc_cmn_vals = {
+	.reg_pairs = pcie_100_ext_ssc_plllc_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_100_ext_ssc_plllc_cmn_regs),
+};
+
+static struct cdns_sierra_vals ml_pcie_100_ext_ssc_ln_vals = {
+	.reg_pairs = ml_pcie_100_ext_ssc_ln_regs,
+	.num_regs = ARRAY_SIZE(ml_pcie_100_ext_ssc_ln_regs),
+};
+
 /* refclk100MHz_32b_PCIe_cmn_pll_no_ssc */
 static const struct cdns_reg_pairs cdns_pcie_cmn_regs_no_ssc[] = {
 	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
@@ -1723,6 +2031,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.pma_cmn_vals = {
@@ -1732,12 +2045,24 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_plllc_cmn_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
 			},
 		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
+			},
+		},
 	},
 	.pma_ln_vals = {
 		[TYPE_PCIE] = {
@@ -1746,12 +2071,24 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &ml_pcie_100_no_ssc_ln_vals,
+				[EXTERNAL_SSC] = &ml_pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &ml_pcie_100_int_ssc_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
 			},
 		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
+			},
+		},
 	},
 };
 
@@ -1766,6 +2103,20 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
+		},
+	},
+	.phy_pma_ln_vals = {
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_phy_pma_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_phy_pma_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_phy_pma_ln_vals,
+			},
 		},
 	},
 	.pma_cmn_vals = {
@@ -1775,12 +2126,24 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_plllc_cmn_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
 			},
 		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
+			},
+		},
 	},
 	.pma_ln_vals = {
 		[TYPE_PCIE] = {
@@ -1789,12 +2152,24 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &ml_pcie_100_no_ssc_ln_vals,
+				[EXTERNAL_SSC] = &ml_pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &ml_pcie_100_int_ssc_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
 			},
 		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
+			},
+		},
 	},
 };
 
-- 
2.26.1

