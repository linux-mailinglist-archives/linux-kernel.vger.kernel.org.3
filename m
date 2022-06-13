Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1535490C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbiFMPYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344931AbiFMPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:22:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D868134E14;
        Mon, 13 Jun 2022 05:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bN78CyO3E8gkbrjHR+FZKG7fKuxmwE4yOb0XTXoycoxg7s3Wnc4R7b6jqBVequ4wLoNpcsbkzUY0JJMFNIxp9vZ5sfjCLWMP+tpK4gqC//qNlU8NYeoQfWk4rF4sxgjF0tfOWdEM5qMaAaGuDGfg4zuGOraTYVkw4IGBB3AfOCZffIknTVPygCy/2tmqK/ny9Dr2eWK/khswWHZ99EszMno+ttnC0899qt4PHAmApYq1Rlx4QMiyppas9hr51w1TTvORihglKglutNTY9hCBwi56frPIYcc5OhIG+ZKhwuyldHNu9KfGNu5h4xMsnF/LFQ29W8BMTPLDkNV8lDiqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pKvlrH7EySADPgK8hGccZXgaNUi+eD1UkNtbN2kINc=;
 b=A7xpdMpnsmyVwGUfpJA4KsoH4sZVp0eZgU75zRu5ELZZ1iUm9L/tVsqk6kNSWDG1xmCPDb6nv1a4QL4XlExUHGZcid9TPxcG6xpQiuFcZ8WXSdauHOvpkp1AUwignNIiPgwxhaDE4o3EShnQAma6A4oMp/6CfxBhrxWTIVIbzuNU5n5Fsr2T0mcnb1fiUfYW8nldkRXaY/6Ncf+rUMy6ZiY8f/0jolpt1J+HrSYPnBDC6/MvP/qFqZFRkHrhYFxhaZaWgSprr7gGzYhCVXgEgWZkYYGaBYW/KAvQIdAeaLZ6718TIuzQKkabD4tk3V3Xyk7FKkGJSFZAV9h5dm3wOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pKvlrH7EySADPgK8hGccZXgaNUi+eD1UkNtbN2kINc=;
 b=L8dsLzwYBBL5GL0tUSAx+rOXthts49kHjC06dqiXb0zwIa2oMRT3ChzodL+3eWQA5n06Z8PwehjzJU9I4JyP6r3nxQEntWsgM/+gVACCLjAWoxz1cPuCdDxtWdL6NFB/Gsn4iD/tqMdjC+0QhgDye0L8sVngbWc39ljRmUtK4YM=
Received: from BN0PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:e8::18)
 by BN6PR02MB2625.namprd02.prod.outlook.com (2603:10b6:404:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 12:48:17 +0000
Received: from BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::59) by BN0PR04CA0043.outlook.office365.com
 (2603:10b6:408:e8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17 via Frontend
 Transport; Mon, 13 Jun 2022 12:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT027.mail.protection.outlook.com (10.13.2.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 12:48:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Jun 2022 05:48:08 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Jun 2022 05:48:08 -0700
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 balbi@kernel.org,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=39406 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1o0jUF-000A8B-UT; Mon, 13 Jun 2022 05:48:08 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>
CC:     <git@xilinx.com>, <sivadur@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH 2/2] usb: dwc3: core: Enable GUCTL1 bit 10 for fixing crc error after resume bug
Date:   Mon, 13 Jun 2022 18:17:03 +0530
Message-ID: <20220613124703.4493-3-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613124703.4493-1-piyush.mehta@xilinx.com>
References: <20220613124703.4493-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f14ed4ed-9c3a-408f-ceb1-08da4d3afcf0
X-MS-TrafficTypeDiagnostic: BN6PR02MB2625:EE_
X-Microsoft-Antispam-PRVS: <BN6PR02MB262554B161E8FFB217190EC2D4AB9@BN6PR02MB2625.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGH8V7Wv4m7GNz+n0Odmcshqv/BWpr5shajwSot+7g9hWT9evHg4HZbNaKDTVds6uIW5L6BAonMUvj30QiSm+UnjQRWf0tfTvxBrLZ6jfVJkQMKo0gXuWmtl/EKLn0NZYCtC8uz0WYmJsMHJg0d92ftuEvG473pG0shU7zw+m3qYSWax3gIXUyRDI5Nf6cHpanGyCSmJClGxpQE5AleXhP6+j8as6cmKMr5wzw+MHOXDjwOFprN/KbzpYcnxeYphjVwbW137nSGxvCBiPjtZnC2ncs7N6lFg0jQn8DlrF/muC+wAyTx2k4+rh/qobdoOls80N68zSlQjDiBCYSMx2x7+fYIDZurAqHGqmXSB8sT6HaocqTtQrYcpHPfeWnCC+haSTcqQewwI/5hfjWesL4hgIAJicuUcFHbnvtkKmMBOZQPoc8fb0taDjKakU9qq8Kf1CRUJRDgMIcBY1vbGmWK0lg8m3IjsJy1noUIfo/bknkxCKyViPi9mkZPDeBzEsedx3aayTgbVkpY1ltYGa3jIGY6zVI5UFQu4VxJh7T9Va7nlcBgUtkyjIiFLp1Y1uvwSc+uh2pWWjXt+bQQEetLFOkZAr53yF4PSCXKus9WHk/XpI/RIw1hf+4f7Sc2JnCgWhM+BdpX+oRYU+84BTVwJhjPOhn0GVbVa3KP5P5IwzZhWOVQK5tvsMUeKJsMvxSdDSuUMhqDFDjU0cNRG9A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(508600001)(9786002)(316002)(70586007)(70206006)(8676002)(8936002)(2616005)(36860700001)(5660300002)(6636002)(44832011)(110136005)(36756003)(40460700003)(54906003)(4326008)(2906002)(7696005)(6666004)(7636003)(26005)(356005)(82310400005)(83380400001)(426003)(47076005)(336012)(1076003)(186003)(107886003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 12:48:17.2022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f14ed4ed-9c3a-408f-ceb1-08da4d3afcf0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2625
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When configured in HOST mode, after issuing U3/L2 exit controller fails
to send proper CRC checksum in CRC5 field. Because of this behavior
Transaction Error is generated, resulting in reset and re-enumeration of
usb device attached. Enabling chicken bit 10 of GUCTL1 will correct this
problem.

When this bit is set to '1', the UTMI/ULPI opmode will be changed to
"normal" along with HS terminations after EOR. This option is to support
certain legacy UTMI/ULPI PHYs.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 drivers/usb/dwc3/core.c | 16 ++++++++++++++++
 drivers/usb/dwc3/core.h |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e027c0420dc3..8afc025390d2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1140,6 +1140,20 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
+	/*
+	 * When configured in HOST mode, after issuing U3/L2 exit controller
+	 * fails to send proper CRC checksum in CRC5 feild. Because of this
+	 * behaviour Transaction Error is generated, resulting in reset and
+	 * re-enumeration of usb device attached. Enabling bit 10 of GUCTL1
+	 * will correct this problem. This option is to support certain
+	 * legacy ULPI PHYs.
+	 */
+	if (dwc->enable_guctl1_resume_quirk) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+		reg |= DWC3_GUCTL1_RESUME_QUIRK;
+		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
+	}
+
 	if (!DWC3_VER_IS_PRIOR(DWC3, 250A)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
 
@@ -1483,6 +1497,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-del-phy-power-chg-quirk");
 	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
 				"snps,dis-tx-ipgap-linecheck-quirk");
+	dwc->enable_guctl1_resume_quirk = device_property_read_bool(dev,
+				"snps,enable_guctl1_resume_quirk");
 	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
 				"snps,parkmode-disable-ss-quirk");
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 81c486b3941c..e386209f0e1b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -397,6 +397,9 @@
 #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
 #define DWC3_GUCTL_REFCLKPER_SEL		22
 
+/* Global User Control Register 1 */
+#define DWC3_GUCTL1_RESUME_QUIRK		BIT(10)
+
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
 
@@ -1093,6 +1096,8 @@ struct dwc3_scratchpad_array {
  *			change quirk.
  * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
  *			check during HS transmit.
+ * @enable_guctl1_resume_quirk: Set if we enable quirk for fixing improper crc
+ *			generation after resume from suspend.
  * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
  *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
@@ -1308,6 +1313,7 @@ struct dwc3 {
 	unsigned		dis_u2_freeclk_exists_quirk:1;
 	unsigned		dis_del_phy_power_chg_quirk:1;
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
+	unsigned		enable_guctl1_resume_quirk:1;
 	unsigned		parkmode_disable_ss_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
-- 
2.17.1

