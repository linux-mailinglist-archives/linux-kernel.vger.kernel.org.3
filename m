Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658B847DF02
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346600AbhLWGTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:19:14 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:14676 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234232AbhLWGTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:19:12 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN4Isni005574;
        Wed, 22 Dec 2021 22:19:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TAFnHh/GnRl6A449G9Sz3vHV4YhKmXiqqN0hUP9aG5w=;
 b=hDCTUakxYmXXpUJQEi8WKZLtb+XQbh+I4Ij0AFHuTeNhlDztw/TOk9ewvTpBK5GFdFAV
 J3SLVrd3DY8HEHWdhDD6F0+Njge53UDEvWM6FGMuJhotIfr3/8g9H1QNfNq2rGFka3bw
 e7pQSoPBQYsCcT7rv84tepU2FVLb/bgJs0fsAqAJ256GL71qIN7mo5v0k6BWkAtqZnq8
 VEJ8SltVvexmUwKBbnpUuUIEnh0OMQj9q4VXBAhaD85GFJ6JOYT8qW7SveX6+TtP5bz1
 JZjHZI8iCTYwZBR7jDUA4o+fNbTrhhxP3PrcVZMRbYBhcI1Yr594c/p3PwZHHCrPnXDJ cw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3d3rwxvkvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:19:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XveKFi4kVdqqzV7xfekLFDUrYa+tZl3hJLA0tmyJgf23SzktRBekpqEtmroTrBmMfu9R6fWGUBBdMF7LcJR7BmsONUU0EYxAuEGkFrfwQhIXWLuttbLcFm+ZClePtmU16eUkdK1Ouq0X8iAOzmuoONP23E3QXN10+wL9h9Gx+NEG6eYxpy131KaBngJtz9SfrR2hKd7k2c5xMHydEKlg77BP5ADpA2ebXsH1xZdJ/6eptgd5cEoxhZ+UXIFxCvF57r8dqVaiZxi5DvOLWBIkjomoL8mTltakGYNzbvZAVWZMXa+e7RCtk66sHpzjOtxAU4ARVb1eAypLKJPOKsogVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAFnHh/GnRl6A449G9Sz3vHV4YhKmXiqqN0hUP9aG5w=;
 b=h8k5VRVDNfmMFVvnkLTSlZmjHhFY1xWDS8iEdUHmyVljVsGp4y8wJOMB+9nSYb0yHW0R3UEOURnrgBjknr33kVOd0+HHvF1jyjdxcGDFrVNlc0bHakfnwbBuQw2n0VaVj406c07CyIGJxkL3/w50Ox2kxQHsKAltej9NKZKnaDhl/ors9qtqZnFrz3rYU5ajEVtzlN5wRQveoekdQflEA1EKmkZAsJ9HiI6rdvc07b7X8Uv4ywpbpipDYE18T3IM9tOlw6BbsoMlYf3eTXNEITQ3ldKQNXEAexoIgS+lOlBmQ1mrSt8G+vtWVpZPwtulh35ukFxHJnqHZs7hi6HT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAFnHh/GnRl6A449G9Sz3vHV4YhKmXiqqN0hUP9aG5w=;
 b=IqVYkSynaVQbvlfwVQ98/p3Al7F19aFO9wWOlMcEQkTVXFiA9BRWXIkrsb8WXaPEISU8QQ8RAvtuXk2aNoHer3qxPPtDreZYDsnBRoujiZJp2jtqA3LtMHcmDpdbe47KXq2gXQMVqcuEh2074mzfclcf0S2Wb+lzFEwZIHRucTE=
Received: from DM6PR11CA0028.namprd11.prod.outlook.com (2603:10b6:5:190::41)
 by DM6PR07MB4585.namprd07.prod.outlook.com (2603:10b6:5:95::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 23 Dec
 2021 06:18:58 +0000
Received: from DM6NAM12FT029.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::56) by DM6PR11CA0028.outlook.office365.com
 (2603:10b6:5:190::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Thu, 23 Dec 2021 06:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT029.mail.protection.outlook.com (10.13.178.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:18:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6IvoN022714
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:18:58 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:18:50 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:18:49 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:18:49 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6Gvce019587;
        Thu, 23 Dec 2021 07:17:29 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN6GusL019586;
        Thu, 23 Dec 2021 07:16:56 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 10/15] phy: cadence: Sierra: Update single link PCIe register configuration
Date:   Thu, 23 Dec 2021 07:01:32 +0100
Message-ID: <20211223060137.9252-11-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62ecc05b-0164-45e0-4c2e-08d9c5dc1a77
X-MS-TrafficTypeDiagnostic: DM6PR07MB4585:EE_
X-Microsoft-Antispam-PRVS: <DM6PR07MB4585E7FB7200B96E8A19B63CC57E9@DM6PR07MB4585.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ho6rP3CzyberNaM2q6jvpC6RSnzujvIg6T4j6eNftpVSJD7qAEBCqpQJFUnWUBzga1Ee6W0USxi+3JzGFgvCSk2sPYJt6WM2LohbADUyLIcbI5AFw21WYg6qFPAlWWvaBbiFjQsI4Ys5bvUKGG2HjVSXYlqCrq1p3ODcKotX/navGLD3y3hHkah4a4lZ2wViN2gq0QLySF0lmbvHhI9dEh1b7W9NadASZfcVC5G7NP5Tod8TtvvC8pO3aygNjOj/ci3wlxdToNIPjFQSyTODDj9C5BrCq89Cwkoigc9irVb0sZz7P4JkK/qxLu7giFX7GJ2vCOofqa8Zzf/I25zRcm/R/pv3uJuCLvjpdmGSe2ssg5E7obkUFmMBqWV6t1c0N6/uob82XqIriYXgd7nniUuJp3CO36Ki2ZYvy7QiTW6ge8blW5pW0cC8ECBQ8PHXZEqz2lVyaNmMGClXsHtRc3wxhsbQSkWROiITTSVvY2Pp6XnkT7A09MRkrDmO14vNA2S53QMg/3tWbkldP8mDQMGLUy3SQjC0EBG4UHUF5ROAXDUAn47YV4GM3NL2y/M/5kuMcE3eC/+1d03wrb+9fun7yxxbshI6/QP97sNunWfc4UFvRI1CZfAUiifeJToUH0hdU+tM9PBKp/p8uVsR5F3ghqxd+na/hqxSB8l+6uahSvrd9tkCumfbBexg2mBYHq6r/is9MfWweJtmnmbC0eKW9Saxyj220ftiEf1Bdm0dt4Vq5R10e77HSSvAKddEzjE2bpYOMroDlTw3nEjR+HNnYbGmyoLIERPt4EJIBII=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(40470700002)(36840700001)(8676002)(336012)(2616005)(426003)(36756003)(82310400004)(7636003)(36860700001)(4326008)(8936002)(70586007)(70206006)(30864003)(186003)(40460700001)(5660300002)(26005)(83380400001)(110136005)(19627235002)(54906003)(1076003)(508600001)(316002)(47076005)(86362001)(2906002)(6666004)(42186006)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:18:57.6201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ecc05b-0164-45e0-4c2e-08d9c5dc1a77
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT029.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4585
X-Proofpoint-ORIG-GUID: T3flE_jhKmbPaW3gl8ST50k4Tw4WzV9u
X-Proofpoint-GUID: T3flE_jhKmbPaW3gl8ST50k4Tw4WzV9u
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

Add single link PCIe register configurations for no SSC and internal
SSC. Also, add missing PMA lane registers for external SSC.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 214 ++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 59458388a855..728abd14aa79 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -36,7 +36,12 @@
 #define SIERRA_CMN_PLLLC_LOCK_CNTSTART_PREG		0x4B
 #define SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG		0x4F
 #define SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG		0x50
+#define SIERRA_CMN_PLLLC_DSMCORR_PREG			0x51
+#define SIERRA_CMN_PLLLC_SS_PREG			0x52
+#define SIERRA_CMN_PLLLC_SS_AMP_STEP_SIZE_PREG		0x53
+#define SIERRA_CMN_PLLLC_SSTWOPT_PREG			0x54
 #define SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG	0x62
+#define SIERRA_CMN_PLLLC_LOCK_DELAY_CTRL_PREG		0x63
 #define SIERRA_CMN_REFRCV_PREG				0x98
 #define SIERRA_CMN_REFRCV1_PREG				0xB8
 #define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
@@ -52,6 +57,7 @@
 #define SIERRA_DET_STANDEC_E_PREG			0x004
 #define SIERRA_PSM_LANECAL_DLY_A1_RESETS_PREG		0x008
 #define SIERRA_PSM_A0IN_TMR_PREG			0x009
+#define SIERRA_PSM_A3IN_TMR_PREG			0x00C
 #define SIERRA_PSM_DIAG_PREG				0x015
 #define SIERRA_PSC_TX_A0_PREG				0x028
 #define SIERRA_PSC_TX_A1_PREG				0x029
@@ -68,12 +74,15 @@
 #define SIERRA_CLKPATH_BIASTRIM_PREG			0x04B
 #define SIERRA_DFE_BIASTRIM_PREG			0x04C
 #define SIERRA_DRVCTRL_ATTEN_PREG			0x06A
+#define SIERRA_DRVCTRL_BOOST_PREG			0x06F
 #define SIERRA_CLKPATHCTRL_TMR_PREG			0x081
 #define SIERRA_RX_CREQ_FLTR_A_MODE3_PREG		0x085
 #define SIERRA_RX_CREQ_FLTR_A_MODE2_PREG		0x086
 #define SIERRA_RX_CREQ_FLTR_A_MODE1_PREG		0x087
 #define SIERRA_RX_CREQ_FLTR_A_MODE0_PREG		0x088
+#define SIERRA_CREQ_DCBIASATTEN_OVR_PREG		0x08C
 #define SIERRA_CREQ_CCLKDET_MODE01_PREG			0x08E
+#define SIERRA_RX_CTLE_CAL_PREG				0x08F
 #define SIERRA_RX_CTLE_MAINTENANCE_PREG			0x091
 #define SIERRA_CREQ_FSMCLK_SEL_PREG			0x092
 #define SIERRA_CREQ_EQ_CTRL_PREG			0x093
@@ -123,15 +132,27 @@
 #define SIERRA_DEQ_ALUT12				0x114
 #define SIERRA_DEQ_ALUT13				0x115
 #define SIERRA_DEQ_DFETAP_CTRL_PREG			0x128
+#define SIERRA_DEQ_DFETAP0				0x129
+#define SIERRA_DEQ_DFETAP1				0x12B
+#define SIERRA_DEQ_DFETAP2				0x12D
+#define SIERRA_DEQ_DFETAP3				0x12F
+#define SIERRA_DEQ_DFETAP4				0x131
 #define SIERRA_DFE_EN_1010_IGNORE_PREG			0x134
+#define SIERRA_DEQ_PRECUR_PREG				0x138
+#define SIERRA_DEQ_POSTCUR_PREG				0x140
+#define SIERRA_DEQ_POSTCUR_DECR_PREG			0x142
 #define SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG		0x150
 #define SIERRA_DEQ_TAU_CTRL2_PREG			0x151
+#define SIERRA_DEQ_TAU_CTRL3_PREG			0x152
+#define SIERRA_DEQ_OPENEYE_CTRL_PREG			0x158
 #define SIERRA_DEQ_PICTRL_PREG				0x161
 #define SIERRA_CPICAL_TMRVAL_MODE1_PREG			0x170
 #define SIERRA_CPICAL_TMRVAL_MODE0_PREG			0x171
 #define SIERRA_CPICAL_PICNT_MODE1_PREG			0x174
 #define SIERRA_CPI_OUTBUF_RATESEL_PREG			0x17C
+#define SIERRA_CPI_TRIM_PREG				0x17F
 #define SIERRA_CPICAL_RES_STARTCODE_MODE23_PREG		0x183
+#define SIERRA_EPI_CTRL_PREG				0x187
 #define SIERRA_LFPSDET_SUPPORT_PREG			0x188
 #define SIERRA_LFPSFILT_NS_PREG				0x18A
 #define SIERRA_LFPSFILT_RD_PREG				0x18B
@@ -1162,6 +1183,146 @@ static struct cdns_sierra_vals pcie_phy_pcs_cmn_vals = {
 	.num_regs = ARRAY_SIZE(pcie_phy_pcs_cmn_regs),
 };
 
+/* refclk100MHz_32b_PCIe_cmn_pll_no_ssc */
+static const struct cdns_reg_pairs cdns_pcie_cmn_regs_no_ssc[] = {
+	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
+	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG}
+};
+
+/* refclk100MHz_32b_PCIe_ln_no_ssc */
+static const struct cdns_reg_pairs cdns_pcie_ln_regs_no_ssc[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
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
+static struct cdns_sierra_vals pcie_100_no_ssc_cmn_vals = {
+	.reg_pairs = cdns_pcie_cmn_regs_no_ssc,
+	.num_regs = ARRAY_SIZE(cdns_pcie_cmn_regs_no_ssc),
+};
+
+static struct cdns_sierra_vals pcie_100_no_ssc_ln_vals = {
+	.reg_pairs = cdns_pcie_ln_regs_no_ssc,
+	.num_regs = ARRAY_SIZE(cdns_pcie_ln_regs_no_ssc),
+};
+
+/* refclk100MHz_32b_PCIe_cmn_pll_int_ssc */
+static const struct cdns_reg_pairs cdns_pcie_cmn_regs_int_ssc[] = {
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
+/* refclk100MHz_32b_PCIe_ln_int_ssc */
+static const struct cdns_reg_pairs cdns_pcie_ln_regs_int_ssc[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
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
+static struct cdns_sierra_vals pcie_100_int_ssc_cmn_vals = {
+	.reg_pairs = cdns_pcie_cmn_regs_int_ssc,
+	.num_regs = ARRAY_SIZE(cdns_pcie_cmn_regs_int_ssc),
+};
+
+static struct cdns_sierra_vals pcie_100_int_ssc_ln_vals = {
+	.reg_pairs = cdns_pcie_ln_regs_int_ssc,
+	.num_regs = ARRAY_SIZE(cdns_pcie_ln_regs_int_ssc),
+};
+
 /* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc */
 static const struct cdns_reg_pairs cdns_pcie_cmn_regs_ext_ssc[] = {
 	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
@@ -1173,13 +1334,52 @@ static const struct cdns_reg_pairs cdns_pcie_cmn_regs_ext_ssc[] = {
 
 /* refclk100MHz_32b_PCIe_ln_ext_ssc */
 static const struct cdns_reg_pairs cdns_pcie_ln_regs_ext_ssc[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
+	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
+	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
 	{0x813E, SIERRA_CLKPATHCTRL_TMR_PREG},
 	{0x8047, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
 	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
 	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
 	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
+	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
 	{0x033C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
-	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG}
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
 };
 
 static struct cdns_sierra_vals pcie_100_ext_ssc_cmn_vals = {
@@ -1316,14 +1516,18 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 	.pcs_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 			},
 		},
 	},
 	.pma_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
 		},
 		[TYPE_USB] = {
@@ -1335,7 +1539,9 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 	.pma_ln_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_100_no_ssc_ln_vals,
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
 		},
 		[TYPE_USB] = {
@@ -1353,14 +1559,18 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 	.pcs_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 			},
 		},
 	},
 	.pma_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
 		},
 		[TYPE_USB] = {
@@ -1372,7 +1582,9 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 	.pma_ln_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_100_no_ssc_ln_vals,
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
 		},
 		[TYPE_USB] = {
-- 
2.26.1

