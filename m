Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D545329FD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbiEXMIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiEXMIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:08:35 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FC766FBD;
        Tue, 24 May 2022 05:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlcpnL6gEs2kvybR/OJl4QmLIgBEQ8PuenVZkmR2lGQU6XcaRQOc3w7rGFnaOTcBixXOvIX5GbgZwmOItYcoBf/s08BJler6n0n8CX/HmF6j51v8g2zDT5lEroDbzw6eMT65WLmGJlXgauSsMkHfRkzZsstZic3oeb3cU3ykSOPXYouTiksQocT9RCbsDf1CogOZ8N6gE/PN9JmOEWDJ7mM6xei1CZ+54d0TLCUE/CEAOPKRPG40K4LUhb2Z/c3SC0Rkf1CrfaIdM2W5ev3c8+/a9dHNGERPVtn8NqPrqWpvTSlsTpZOglELfaS7Az6isycXVchQ9m/TFQBEChcCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5InqNb49U9Xs62/gdu5N/aUh+3x7HgWek/4hGaUBa+c=;
 b=fmLQ7q47Bv8QfNJrtQ7s2+Zm+Won9pog8CiKiIIbg4hWQVmwDETgjoCR1jnGVs4gMP+FSua4pd+D2pLXD6ra4VXE23+OlhQshGbhHUMAgajK424cg7YdaRaO/Tu4YLKNEdlWU7gi+99AYNW6x9awxsY3H12OXKze3jKz9fwnmMsgU73L7pXpPeArO5wQQr6hOMZdaPX2+mpBVdU2A0tS0iGMYDjPWX08BrmF6MycHhdOLCwrhsS84nNkxz+0kfaoA3du2aHVzjhs6IPM35RWR/nqtcalCggJUmIp3PX2u+FdR+0UGozWjSFAtlTTm7Btibk2zuJ2JqTRSNbu2F89DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5InqNb49U9Xs62/gdu5N/aUh+3x7HgWek/4hGaUBa+c=;
 b=sln9AtR2leq0IDvvqKKzToV8b0rh1HmY8U7MK/APSIVj4hP9osaDjgZiVC+2BMLnWgKxCcdVAc/CIWtsmExyTBaDk0nf4AUuPLfVLCfejjyo0FfSmxsuzDUPjUvNYY/31UQKu/Wt+Ko6c8t7AiFxCcfyZeULeBR8HqsZTtynwIs=
Received: from BN0PR04CA0034.namprd04.prod.outlook.com (2603:10b6:408:e8::9)
 by DM6PR02MB4204.namprd02.prod.outlook.com (2603:10b6:5:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 12:08:32 +0000
Received: from BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::70) by BN0PR04CA0034.outlook.office365.com
 (2603:10b6:408:e8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Tue, 24 May 2022 12:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT032.mail.protection.outlook.com (10.13.3.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 12:08:32 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 May 2022 05:08:30 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 May 2022 05:08:30 -0700
Envelope-to: git@xilinx.com,
 peter.chen@kernel.org,
 gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=35222 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1ntTKv-0009lk-FZ; Tue, 24 May 2022 05:08:29 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sivadur@xilinx.com>, <radheys@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [RFC PATCH] usb: chipidea: Add support for VBUS control with PHY
Date:   Tue, 24 May 2022 17:38:02 +0530
Message-ID: <20220524120802.9394-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3dafab1-5daf-4d1b-cd7f-08da3d7e1f27
X-MS-TrafficTypeDiagnostic: DM6PR02MB4204:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB4204579DAA30301469C7A9C4D4D79@DM6PR02MB4204.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58F0kxuCx7lU6UaR0l6jXILJ1r+Ine87CtWeLeYpcRXHdRW/oiXdLJR01aQeHdw4KM1+gGsaUUUjiKspkAacxh9zCKF4+Rf5TqDLU5nftgTrSZd6EIkA7Wl4Ma57CXPCWTLuwoER7VfWH/bej4WyCrMs1OIOR+HxaA1tiUlOW0CJ2GWr6chWrJH4xXIJ+/7EGSOY6rWFLGoR93rvZmRpk2g1NtOtaNbVXY9mEqRwdtEWsDEKOJaJmTpjRWCnPZXK2uAz03mvOTR2CCY2UGs70xWKnnODrHZQu1fBIhvF/dmnBWMr6OXT/Z/28mm/4Kg5RvQIKqFEa9znlEQnNbYtAOLCK1F30bqbrWh2pDjwuBEs30tn9EYpljvr8m3fomJrAn5p+NZlL877aN0phFV+sz3RWzn4hZbCYg0Mf73waxYFhOVTTzmyhUlUNdb7XNA3GBM8wdpZFiXyDOZIABytme106M9W4irps3QW4iH4dSQwFjAc6G1CLzK4Stetms0zVxMuVI/4A1DRu+mqT7Mj6CTiUqRyFu/SR2vT6gKMQToQnHifwOn+7nobc8vIsGSqqzcxF6I6R5joH28UUqXnfENLlKsInUKDtK9fA5WCGT7tiueoXSoXB5zhio0+zPr8rULOwSdc6BYp4tKJg2JCflq6BPbs4ORVzc1HPCPzf6eLjhVtt8xNKQPVlQIz9RpBBzXORxGzs1gr157RzNaRQA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(54906003)(426003)(8936002)(508600001)(356005)(36860700001)(110136005)(107886003)(9786002)(70206006)(7636003)(4326008)(8676002)(70586007)(83380400001)(6636002)(26005)(6666004)(336012)(186003)(44832011)(5660300002)(82310400005)(2616005)(2906002)(7696005)(47076005)(1076003)(316002)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 12:08:32.2816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dafab1-5daf-4d1b-cd7f-08da3d7e1f27
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4204
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms make use of VBUS control over PHY which means controller
driver has to access PHY registers to turn on/off VBUS line.This patch
adds support for such platforms in chipidea.

Flag 'CI_HDRC_PHY_VBUS_CONTROL' added to support VBus control feature.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
We have created this patch as RFC, as I introduced a new flag
(CI_HDRC_PHY_VBUS_CONTROL) and would like to get comment if
it's the proper way to check for VBus support for zynq.
---
 drivers/usb/chipidea/ci_hdrc_usb2.c | 1 +
 drivers/usb/chipidea/host.c         | 7 +++++++
 drivers/usb/chipidea/otg_fsm.c      | 7 +++++++
 include/linux/usb/chipidea.h        | 1 +
 4 files changed, 16 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index 89e1d82..dc86b12 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -30,6 +30,7 @@ static const struct ci_hdrc_platform_data ci_default_pdata = {
 
 static const struct ci_hdrc_platform_data ci_zynq_pdata = {
 	.capoffset	= DEF_CAPOFFSET,
+	.flags          = CI_HDRC_PHY_VBUS_CONTROL,
 };
 
 static const struct ci_hdrc_platform_data ci_zevio_pdata = {
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index bdc3885..bc3634a 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -63,6 +63,13 @@ static int ehci_ci_portpower(struct usb_hcd *hcd, int portnum, bool enable)
 		priv->enabled = enable;
 	}
 
+	if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL) {
+		if (enable)
+			usb_phy_vbus_on(ci->usb_phy);
+		else
+			usb_phy_vbus_off(ci->usb_phy);
+	}
+
 	if (enable && (ci->platdata->phy_mode == USBPHY_INTERFACE_MODE_HSIC)) {
 		/*
 		 * Marvell 28nm HSIC PHY requires forcing the port to HS mode.
diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
index 6ed4b00..5ed9164 100644
--- a/drivers/usb/chipidea/otg_fsm.c
+++ b/drivers/usb/chipidea/otg_fsm.c
@@ -471,6 +471,10 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
 				return;
 			}
 		}
+
+		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
+			usb_phy_vbus_on(ci->usb_phy);
+
 		/* Disable data pulse irq */
 		hw_write_otgsc(ci, OTGSC_DPIE, 0);
 
@@ -480,6 +484,9 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
 		if (ci->platdata->reg_vbus)
 			regulator_disable(ci->platdata->reg_vbus);
 
+		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
+			usb_phy_vbus_off(ci->usb_phy);
+
 		fsm->a_bus_drop = 1;
 		fsm->a_bus_req = 0;
 	}
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index edf3342..ee38835 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -62,6 +62,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_REQUIRES_ALIGNED_DMA	BIT(13)
 #define CI_HDRC_IMX_IS_HSIC		BIT(14)
 #define CI_HDRC_PMQOS			BIT(15)
+#define CI_HDRC_PHY_VBUS_CONTROL	BIT(16)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
-- 
2.7.4

