Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624C659B8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 07:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiHVFlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 01:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHVFl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 01:41:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8752D25C64;
        Sun, 21 Aug 2022 22:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0yif5RKkApyEAAGXWl3UNLwjEyOA6prkvskR0aMNOxVoJVuS+ADVGKhzYJw+VQOdoVV27W0sqBlYWiC1wn181UGYPvYU2xnGRpzZnIq+gtfOfl6Mb2/2D38nWD+AwLcYlTcPJ1l7xwOIAs2NOszrLoxVzgJHgKWzMR7R6PckXrJDB+PZ5J0KmNZyZJx1lNUp/aGDtQTTShdbPhmGj0rf+gG5N1/g+uWMfNPtE4va608MnDv4zS3YwwmN1a1ZU6dyVkCEmw8A5HFHIaY6n0FCJiUDQXWQZtTA6ligMkunoOIA7mmqfXsicrFjPLYTgZ3XY8rwnqfJyfJSjiCw83B9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr1uUX3YkyrHqwu+/HKqe76wncQXcdXuqPupaV2KgkE=;
 b=encarLn99JXbvyB0bk4l7mQLsykn/7NrqveYuoZ3aWzyAOlgG7Aj+/1BzpFYdqURzzhaCrc0XULmu4GkESvwEe1T30xrMSTsnKhLLgfv0wKuiwvcq3k0GSYmENv0Stz7i4mZN29qvV3DJUhrMeoR8F9cvswW6GCTCyX5yCyrWRugDlLmM4zDsje633zJ+U/wi8/3wHH1tDPDK7Tgg4RvHBg0THVQuWG2Bx1p4DB59qAH0uxs2pOuPVDKOnq3PBHKE5Xcv+svQCbEdGxb+hWCLrxfXQIjyO/ZQepA+8FX7QzmwXXy2EOO9oHSXO7GtLhVrkN5EdLH7jf6dSIMQU/kBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr1uUX3YkyrHqwu+/HKqe76wncQXcdXuqPupaV2KgkE=;
 b=wDinTwfURXwPX7hV7ZmobhLg2+S5wVAidUu+Jn22rWhdX3E4qAP9AStitNyBbXgOxaftbBWy2TiZ48a3DBZb6xtl3PW0T1zrfTpwv5a+sRYrz9bfs+9lLOoS3lsY19X5ncfHmej1BaeO9iTY/5nOtugGVpjLGbtcrYSJAMB8jxo=
Received: from MW4PR04CA0175.namprd04.prod.outlook.com (2603:10b6:303:85::30)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Mon, 22 Aug
 2022 05:41:24 +0000
Received: from CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::f5) by MW4PR04CA0175.outlook.office365.com
 (2603:10b6:303:85::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19 via Frontend
 Transport; Mon, 22 Aug 2022 05:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT073.mail.protection.outlook.com (10.13.174.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 05:41:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 00:41:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 00:41:18 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 22 Aug 2022 00:41:15 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>,
        <radhey.shyam.pandey@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] usb: chipidea: Add support for VBUS control with PHY
Date:   Mon, 22 Aug 2022 11:10:51 +0530
Message-ID: <20220822054051.2941282-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 258b8611-c3e5-48a4-dbd2-08da8400f323
X-MS-TrafficTypeDiagnostic: IA1PR12MB6530:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKv2nCya6tm+9FeC3mOH7YekPTZY0Q5GVmnEPlJohz4Wu/y5/fh0ziF77BuVJTOrTaWLZJgDXl9G51nAVjzrwhI6qeKu2BcFon9s7yG0eNwBHlyL1eilYXMy4jrkd5JrsVmHpvR1qIAqMcDaDQI85hb8mU6gGdAAsOMjp/4UoE9z8MHfjAWVciQ97gCxdS83oFJGQb1wdU9JIlN1Zoo8M76FG4i7gZjDlvq+DyFKkQfefbckccDpMPNSxkM02UPUNtrhoGPCrN23/OGA827MBN6ZOgZUKbQk0ihDOlVDUx5v4yDSX7ys8DorBdf5VJVt4nteaJdJdaljEy9mVWynTLLstd30Na0OuIBb+k6KICGRQFIuLDypvc6GS1uFvj2yR4xwlac5Yk5g6bcILqUrdCJ3wzudmvr2AoUF0VwdyyuIkBTRocZmEiiAjkNSzPjdqvMT0sGGI4/cC9ibZSYop2q5tQcgtUj4vxOW0SSw2twd/naw+dLOzvCK04VWe9oHDePLAXXdljD+NrxyJnagZFprGREyvxDnFfhmUyz8OsMTG0nl98Ag3BvRfqqa9s1Er2rV/FsqOzrdR7/0DMMY5xFSAEDmJXTXepe6XCzqsHMPHF1jwFTdd8XmVvBfS/hRsiR28Nejbzo+8a/GgrdzdjwXVa/ceI0kMNa0tmsiw435xZoyDRlaLURlvpsmFJkKPokyRNEqHYzNhBeEL1yrJ3A4mkhtuaOUHWVIhlS+lrxaUKNZQowx7+prNXvIu5+CpPi80Kud/irQh8ffzXM5a1j547QKRXdh6o5+t3qEUmMZU+7o8QJ4yZkGTGlDJXEd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(36840700001)(40470700004)(46966006)(36756003)(83380400001)(81166007)(82310400005)(1076003)(110136005)(40480700001)(316002)(356005)(36860700001)(54906003)(8676002)(47076005)(426003)(5660300002)(41300700001)(70206006)(478600001)(70586007)(336012)(8936002)(2906002)(4326008)(40460700003)(186003)(82740400003)(86362001)(6666004)(2616005)(26005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 05:41:23.8551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 258b8611-c3e5-48a4-dbd2-08da8400f323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piyush Mehta <piyush.mehta@xilinx.com>

Some platforms make use of VBUS control over PHY which means controller
driver has to access PHY registers to turn on/off VBUS line.This patch
adds support for such platforms in chipidea.

Flag 'CI_HDRC_PHY_VBUS_CONTROL' added to support VBus control feature.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
---
Note: Due to email sending issue, I am resending the patch with peter ACK.
---
 drivers/usb/chipidea/ci_hdrc_usb2.c | 1 +
 drivers/usb/chipidea/host.c         | 7 +++++++
 drivers/usb/chipidea/otg_fsm.c      | 7 +++++++
 include/linux/usb/chipidea.h        | 1 +
 4 files changed, 16 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index 89e1d82d739b..dc86b12060b5 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -30,6 +30,7 @@ static const struct ci_hdrc_platform_data ci_default_pdata = {
 
 static const struct ci_hdrc_platform_data ci_zynq_pdata = {
 	.capoffset	= DEF_CAPOFFSET,
+	.flags          = CI_HDRC_PHY_VBUS_CONTROL,
 };
 
 static const struct ci_hdrc_platform_data ci_zevio_pdata = {
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index bdc3885c0d49..bc3634a54c6b 100644
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
index 6ed4b00dba96..5ed9164c2a0b 100644
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
index edf3342507f1..ee38835ed77c 100644
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
2.25.1

