Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972924CB6E7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiCCGXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiCCGXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:23:35 -0500
X-Greylist: delayed 1826 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 22:22:49 PST
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4348911E3C6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 22:22:48 -0800 (PST)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222NViSk006265;
        Wed, 2 Mar 2022 21:51:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=lljh0nmx0hEko7FVnmyRi43erlh+PvJOByRRwrsPDVo=;
 b=m9ap69mMPzoNOA+VKF55J3AeIQimZRuHyO7UB04+PDsn1Miqt7/Pd6vnxGnD+KGZiMjR
 EQJpnRCV/v+RPOI8HSxcm/K2wedzSIk51H45u59zmI9H683K3xBlEcOoj0qclLJAl4QX
 LN3w7amMPLjZYAgrvCGSlaT8JpIjpT6IlAE0970QCiJrF6ZifuO1dWxapofWI1Gg91Ir
 Pn42jB/knM70dgXdp54ZuNe7pBSQnVhNC3u+Eylblgvp3iaPZ5DRUnlT+86vWEJ1rSSR
 3qt0BIE/HPpxlrcwE5X+aFc9IouqVPn0A5ZuPGSO9gr7QgC0qB3tWxmgHVY11BTFtRLc uw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3eh6udqn2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 21:51:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OV62bwPx7Q85yI9f6M6dnVDgaTlkaCnVxuGefIxVLSJwRh02OQ1BZAxhlNTuXupwPgzEhnpFeDSVYnUH236S0IIgrTSQvQUM96seABqa9gu+iCjVx0G3YsUDQPA7ik+SprbP3QFHvUng27C88Onl9YVLBsJ+XuqtXPvgmSvkIGf5pwXwYWJ60njkYOxO2YxufMKGxV9FrZYPsLeAsWCFHb4gPJdaodwFrq0y27W3jVf3HHksNuNnXnCvVuuZMWME6yfSk/ZNgC3ICLTfHE1X0fNVj1uDcrgVxYcBjjPUWwpzAJTqL3LDeoaKfb41HbG79nkNDbdE0mHIqln3970huA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lljh0nmx0hEko7FVnmyRi43erlh+PvJOByRRwrsPDVo=;
 b=FC0A1wLef5tew3b8NPGq6Wjq4yIyMW6R3fvFjonDHEuud9hAdjlEQekcBDY0iExCfzM2MoOsCg2lupXCF7eMSQ7akG65a6iA+ZnOfNRcrsVOCOky/qRoim59ORv7cqUNRn5qOkHur6oMkzSRxWPnqf/MhKYgHAKo3J4S2cmSKtV6tMxaPwJf8k+6NPyi7TcoCzmWHpFJQqnZW5FzMAPdpKURtDo1yf6dNq3dEN0u7xJyhBiLu4bgmYvxlTaLY7cEdemCxG2kHuSZICgiEBzRH8AZs9LCDxwAf+3nJpK9iyxMzdVAMznV7MMe1vCLG7QM+LpKzm2egFzfbulaABtmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lljh0nmx0hEko7FVnmyRi43erlh+PvJOByRRwrsPDVo=;
 b=jKUc6r0yq2XT2SXc640pHyg8eNbjh8Q6LHJ4bphKq4TMactN02jVBYYRvxqXNJHJuysQ6Q5MmkZmN4GR5BARK4phImN9xhd7Z5ir5MlRMNyXBtYUOx/UBL5CS7GdbjtcPTfEjjK4NUhJobQ+WWPZkddqWdAdlWZl8XPm/RCAKGw=
Received: from DM6PR06CA0059.namprd06.prod.outlook.com (2603:10b6:5:54::36) by
 BYAPR07MB5429.namprd07.prod.outlook.com (2603:10b6:a03:5a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Thu, 3 Mar 2022 05:51:53 +0000
Received: from DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::aa) by DM6PR06CA0059.outlook.office365.com
 (2603:10b6:5:54::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 05:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 64.207.220.244) smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT016.mail.protection.outlook.com (10.13.178.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.4 via Frontend Transport; Thu, 3 Mar 2022 05:51:51 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 2235pmva176699
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 2 Mar 2022 21:51:50 -0800
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Mar 2022 06:51:47 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Thu, 3 Mar 2022 06:51:47 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 2235oRrE024948;
        Thu, 3 Mar 2022 06:50:59 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 2235oRTt024943;
        Thu, 3 Mar 2022 06:50:27 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH] phy: cadence: Sierra: Add TI J721E specific PCIe multilink lane configuration
Date:   Thu, 3 Mar 2022 06:50:26 +0100
Message-ID: <20220303055026.24899-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed246fd-c1a3-4edc-3bc8-08d9fcd9ea14
X-MS-TrafficTypeDiagnostic: BYAPR07MB5429:EE_
X-Microsoft-Antispam-PRVS: <BYAPR07MB54298F5EA35D9504270956F2C5049@BYAPR07MB5429.namprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8MSw5Fw+QjfSj3ZH2g3Z95r0es+rT7lC3JILdcXRSpodzHZvvC4gcPRzHeLZFWy/UkOE+GoJnk5GgXVvKMTZchP1E789ijDaXYybDEqYa7iXEbBShUEj70o9EtdmZX4kl0cTFREYZIk4o6fvlpOir9zm4OWOBHNIceT8ZoLrdosU+x4TmjtT+y/g5mBAIjLHiomPhZBOEUsuEt6o8fVL1inDHaKrZ9PRonzYkc4VWBKS8UcHASFHeM6UGuV6da3WP2i7bpg9M1RNJmofjpahjm1Jx01VlKZorzYU+GMBmHlH7u3jRkbI9lDDbzhtVW3p1FVtfL4MjdQP2YGh5ZQ844fQS+iV/tbkpTDQPNRuXJZQYaQ5cWsOp/b/NL5bOU+3mjVLvI+JSl3M4mCB/dzx6kBmIbz99RG5HYQOYoN8eumr78Dzyac9U8ROv4GeRhP0LAadJqnAlExjwLVRiqfzDw4T/elaO+4HjhA4BsGhzu5d4HeqS6q4I/+ZhyM4/L+Ry4phwJwmKMCEM6dnLNAU0UW3CnX76FB2CYNL7bzFzHsm9oRup5KaVwhKmTdLQSblUpshlXWTGQgnO25Y7O0mxolDwTqVQxm9yoTHktn0/9FauK/8rYk8Rhd2l3wApqddMClKQhqPwjIVCMIao03OMnlqH07X+sJA4evsdrBYKAV+/jOIZ8VRUGfw4r9C0C9ZmJ7AuV85eoNj+6GyQmJyzUHChoQbPDX5c7MT1q40OZpSxwolBCwjubiPxhq13rgVmxglr2NFQUmc2Je2aCqb7JnC5Od593pqj3rnRUs94Q=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230001)(4636009)(36092001)(40470700004)(46966006)(36840700001)(4326008)(5660300002)(40460700003)(70586007)(70206006)(47076005)(8676002)(30864003)(336012)(426003)(2616005)(63370400001)(63350400001)(36756003)(356005)(81166007)(1076003)(83380400001)(508600001)(8936002)(186003)(26005)(82310400004)(2906002)(54906003)(86362001)(110136005)(36860700001)(316002)(19627235002)(42186006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 05:51:51.3995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed246fd-c1a3-4edc-3bc8-08d9fcd9ea14
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5429
X-Proofpoint-GUID: NmuGXJcNyH6osv1C99-fCrG5mXdhxmqk
X-Proofpoint-ORIG-GUID: NmuGXJcNyH6osv1C99-fCrG5mXdhxmqk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=776 phishscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds workaround for TI J721E errata i2183
(https://www.ti.com/lit/er/sprz455a/sprz455a.pdf).
PCIe fails to link up if SERDES lanes not used by PCIe are assigned to
another protocol. For example, link training fails if lanes 2 and 3 are
assigned to another protocol while lanes 0 and 1 are used for PCIe to
form a two lane link. This failure is due to an incorrect tie-off on an
internal status signal indicating electrical idle.

Status signals going from SERDES to PCIe Controller are tied-off when a
lane is not assigned to PCIe. Signal indicating electrical idle is
incorrectly tied-off to a state that indicates non-idle. As a result,
PCIe sees unused lanes to be out of electrical idle and this causes
LTSSM to exit Detect.Quiet state without waiting for 12ms timeout to
occur. If a receiver is not detected on the first receiver detection
attempt in Detect.Active state, LTSSM goes back to Detect.Quiet and
again moves forward to Detect.Active state without waiting for 12ms as
required by PCIe base specification. Since wait time in Detect.Quiet is
skipped, multiple receiver detect operations are performed back-to-back
without allowing time for capacitance on the transmit lines to
discharge. This causes subsequent receiver detection to always fail even
if a receiver gets connected eventually.

The workaround only works for 1-lane PCIe configuration. This workaround
involves enabling receiver detect override by setting TX_RCVDET_OVRD_PREG_j
register of the lane running PCIe to 0x2. This causes SERDES to indicate
successful receiver detect when LTSSM is in Detect.Active state, whether a
receiver is actually present or not. If the receiver is present, LTSSM
proceeds to link up as expected. However if receiver is not present, LTSSM
will time out in Polling.Configuration substate since the expected training
sequence packets will not be received.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 193 ++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 6b917f7bddbe..73fb99ccd525 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -83,6 +83,7 @@
 #define SIERRA_DFE_BIASTRIM_PREG			0x04C
 #define SIERRA_DRVCTRL_ATTEN_PREG			0x06A
 #define SIERRA_DRVCTRL_BOOST_PREG			0x06F
+#define SIERRA_TX_RCVDET_OVRD_PREG			0x072
 #define SIERRA_CLKPATHCTRL_TMR_PREG			0x081
 #define SIERRA_RX_CREQ_FLTR_A_MODE3_PREG		0x085
 #define SIERRA_RX_CREQ_FLTR_A_MODE2_PREG		0x086
@@ -1684,6 +1685,66 @@ static struct cdns_sierra_vals ml_pcie_100_no_ssc_ln_vals = {
 	.num_regs = ARRAY_SIZE(ml_pcie_100_no_ssc_ln_regs),
 };
 
+/*
+ * TI J721E:
+ * refclk100MHz_32b_PCIe_ln_no_ssc, multilink, using_plllc,
+ * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz
+ */
+static const struct cdns_reg_pairs ti_ml_pcie_100_no_ssc_ln_regs[] = {
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
+	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG},
+	{0x0002, SIERRA_TX_RCVDET_OVRD_PREG}
+};
+
+static struct cdns_sierra_vals ti_ml_pcie_100_no_ssc_ln_vals = {
+	.reg_pairs = ti_ml_pcie_100_no_ssc_ln_regs,
+	.num_regs = ARRAY_SIZE(ti_ml_pcie_100_no_ssc_ln_regs),
+};
+
 /* refclk100MHz_32b_PCIe_cmn_pll_int_ssc, pcie_links_using_plllc, pipe_bw_3 */
 static const struct cdns_reg_pairs pcie_100_int_ssc_plllc_cmn_regs[] = {
 	{0x000E, SIERRA_CMN_PLLLC_MODE_PREG},
@@ -1765,6 +1826,69 @@ static struct cdns_sierra_vals ml_pcie_100_int_ssc_ln_vals = {
 	.num_regs = ARRAY_SIZE(ml_pcie_100_int_ssc_ln_regs),
 };
 
+/*
+ * TI J721E:
+ * refclk100MHz_32b_PCIe_ln_int_ssc, multilink, using_plllc,
+ * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz
+ */
+static const struct cdns_reg_pairs ti_ml_pcie_100_int_ssc_ln_regs[] = {
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
+	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG},
+	{0x0002, SIERRA_TX_RCVDET_OVRD_PREG}
+};
+
+static struct cdns_sierra_vals ti_ml_pcie_100_int_ssc_ln_vals = {
+	.reg_pairs = ti_ml_pcie_100_int_ssc_ln_regs,
+	.num_regs = ARRAY_SIZE(ti_ml_pcie_100_int_ssc_ln_regs),
+};
+
 /* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc, pcie_links_using_plllc, pipe_bw_3 */
 static const struct cdns_reg_pairs pcie_100_ext_ssc_plllc_cmn_regs[] = {
 	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
@@ -1840,6 +1964,69 @@ static struct cdns_sierra_vals ml_pcie_100_ext_ssc_ln_vals = {
 	.num_regs = ARRAY_SIZE(ml_pcie_100_ext_ssc_ln_regs),
 };
 
+/*
+ * TI J721E:
+ * refclk100MHz_32b_PCIe_ln_ext_ssc, multilink, using_plllc,
+ * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz
+ */
+static const struct cdns_reg_pairs ti_ml_pcie_100_ext_ssc_ln_regs[] = {
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
+	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG},
+	{0x0002, SIERRA_TX_RCVDET_OVRD_PREG}
+};
+
+static struct cdns_sierra_vals ti_ml_pcie_100_ext_ssc_ln_vals = {
+	.reg_pairs = ti_ml_pcie_100_ext_ssc_ln_regs,
+	.num_regs = ARRAY_SIZE(ti_ml_pcie_100_ext_ssc_ln_regs),
+};
+
 /* refclk100MHz_32b_PCIe_cmn_pll_no_ssc */
 static const struct cdns_reg_pairs cdns_pcie_cmn_regs_no_ssc[] = {
 	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
@@ -2299,9 +2486,9 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = &ml_pcie_100_no_ssc_ln_vals,
-				[EXTERNAL_SSC] = &ml_pcie_100_ext_ssc_ln_vals,
-				[INTERNAL_SSC] = &ml_pcie_100_int_ssc_ln_vals,
+				[NO_SSC] = &ti_ml_pcie_100_no_ssc_ln_vals,
+				[EXTERNAL_SSC] = &ti_ml_pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &ti_ml_pcie_100_int_ssc_ln_vals,
 			},
 		},
 		[TYPE_USB] = {
-- 
2.34.1

