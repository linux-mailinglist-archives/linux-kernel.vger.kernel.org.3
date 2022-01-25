Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C95549B6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580396AbiAYOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:51:33 -0500
Received: from mail-am6eur05on2137.outbound.protection.outlook.com ([40.107.22.137]:32563
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1580149AbiAYOpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:45:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJRMHZ+s+QC4qozTfa7Frq9WZ3Jw8zkEBRmZzxWmIxIK3GoYZF85hC8+NvZ/OCID2wAXfBiXNuGW+zKOoTrcnEUdUTkcYc1CGAnaoXDDvGnxGHFUi9Pd/VKVskFG/inNt31mRNr3qbQawUvHNnEEX1o8drvWxRsJGCmiSTsHVJ2FpOArdjmnZOTy2SF1cZAW3zWVvcRhxBBH8KGERFdiP5bFUDJY0Aa/vsQM+NyZpOZtEkun3ev8pHRvaTvfMzfwYu3Y0eFO45WkVa0BGS3FUiG4yyrwwVA4CPIP2wlcwvv4zqjoWcWQJczP7BN3fX1Ebm8NOgUAi8A3mB79+cwAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByWN0Qk3Ljn5cedVXgSfce3ekHQs1g4SygzOZcN87rM=;
 b=aeL5f0KDOtwDVaeRrVjUGYrN9VE/ydYb3o5XtcMU15+2Lmk86SIjevxJTtC3wSkV/D4UZxfZfhBSF1GWFEVXXIq63jo0xxv3cXgRtML4vs9egGn52PWGCWhK5+t9CkvNzaXBig6axM85xK4OpmGHVY6FOVe+sRdNktXRr+waBwdsYZPc3fWgJ09hcuPFH+x/Ux2q9hRoaSBjLILyeWrGXJB7b502qtR7OFULXNMBrVTNYOYgwxLXUYM224wGvcun7yESgkKHWQxulKlO2rN6YS6LZWCEDhFZUNOXf7jPqy+c2+GVgN6k+7D7dLYGrFIVIwgJXuMlvvs3Q0kmGkfVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByWN0Qk3Ljn5cedVXgSfce3ekHQs1g4SygzOZcN87rM=;
 b=tu5lTRR3qcKo+J5unULDzg5Ui/wol7n8WETld9tWu+SMtxU7V5+50dq1bza9sqYmN0d1i8xUM8qPS1mj4rPf33J1bScduc8392gjfBsy1lwweT5AxN8m4U8D2j/yYOyNqLBXCQh14EmWpPL2WIU0NGl1bmQHvC/f5Zx6Mu6EAhk=
Received: from AS9PR06CA0372.eurprd06.prod.outlook.com (2603:10a6:20b:460::26)
 by VI1PR07MB5679.eurprd07.prod.outlook.com (2603:10a6:803:da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.4; Tue, 25 Jan
 2022 14:45:00 +0000
Received: from VE1EUR02FT017.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:460:cafe::dc) by AS9PR06CA0372.outlook.office365.com
 (2603:10a6:20b:460::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Tue, 25 Jan 2022 14:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT017.mail.protection.outlook.com (10.152.12.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 14:44:59 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 15:44:58
 +0100
From:   Christian Eggers <ceggers@arri.de>
To:     Abel Vesa <abel.vesa@nxp.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>, <ceggers@arri.de>
Subject: [PATCH RESEND 4/6] clk: imx6q: enforce gating of gpmi_io clock
Date:   Tue, 25 Jan 2022 15:44:39 +0100
Message-ID: <20220125144441.17750-5-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125144441.17750-1-ceggers@arri.de>
References: <20220125144441.17750-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2037096-983d-49b5-682f-08d9e0114343
X-MS-TrafficTypeDiagnostic: VI1PR07MB5679:EE_
X-Microsoft-Antispam-PRVS: <VI1PR07MB567906BD28F029756D912961BF5F9@VI1PR07MB5679.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:190;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYMpaKmmSapYTKeg1vbexEcYCuJNV41OtpBOVHHxnBS/ToLQUdkfNyQ5l2RoOyjJ/bMU5Fev5wUzf4ZOIn5tglJKfTJtar8MaeDOYaSxZ4zhRFsQ3CJFPvS+tyRVSG+BEyS1DE48NVonKU2CRhkZmb7zfvEPPqvvBE3uRDNVpia7uAy/Xw9ekpSqk97Tm6xvauTCb4kFQX9WK9l/zcUPp54+H/b5xtTtBLHzcbqES9QqV2QD186SEbxAfyhAde5ngAUcR1QVP0tJBk0XUpLW/nBQVyVPN0E2ehMq1tZpfv+sLBUTehbI9+4FAK4HZ7M9Nexa+WZsFnrqoaJlJUpXXbDdmPdVzlZP6UJoLs7SPAzghJYbTxnwNygYsOnla9Z5rR4fFtYToCNnxio3OuhEapvjSVhm7boMPooMF3rXjKzleDp+xv9sfYqUro3D7mQZyLbyKxSIns/ZsxNoYMDsj2gpyfg8jwMPsThnwGnZ1Ltn6uuqD5Wq4zpyx6hy7VriQHLo/Q+Xys/0vD/XKtLzJRwx0srlJfj1KjZDvTF0n7WBZ3rSfLdeyj6glyMIkX4vbMUc+q7FmOK+KDOwQxRtoywmGtrWnL43HDMYmuE273STY8WqJE2Sz9wCK2WBynbThrWDWm9PEdhUf44/feP1licZUjSe9eUeQY0sFl2K5+n5ixT9RFVEDQLBTjb0GEx/URfMSeMpbW0/343l2dxQgp+0w0JZSYtLzl+rdAOUtBRjhkGTtxSpoKnTS40mJFldI7iqYSBLE6saMAp1AkhFFxklOL8jempsb17LlkHmGXk=
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(426003)(186003)(2616005)(2906002)(86362001)(336012)(26005)(82310400004)(1076003)(36860700001)(6666004)(81166007)(356005)(16526019)(8936002)(316002)(36756003)(5660300002)(70586007)(83380400001)(107886003)(70206006)(4326008)(8676002)(6862004)(47076005)(54906003)(40460700003)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 14:44:59.4536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2037096-983d-49b5-682f-08d9e0114343
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT017.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5679
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock parent and divider changes are both glitchy for enfc_clock_root.
Enforce that the child clock is gated.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/clk/imx/clk-imx6q.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index fd5c37095ed0..390566fca054 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -674,7 +674,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		hws[IMX6QDL_CLK_USDHC2_SEL]       = imx_clk_hw_mux("usdhc2_sel", base + 0x1c, 17, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels));
 		hws[IMX6QDL_CLK_USDHC3_SEL]       = imx_clk_hw_mux("usdhc3_sel", base + 0x1c, 18, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels));
 		hws[IMX6QDL_CLK_USDHC4_SEL]       = imx_clk_hw_mux("usdhc4_sel", base + 0x1c, 19, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels));
-		hws[IMX6QDL_CLK_ENFC_SEL]         = imx_clk_hw_mux("enfc_sel",         base + 0x2c, 15, 3, enfc_sels_2,         ARRAY_SIZE(enfc_sels_2));
+		hws[IMX6QDL_CLK_ENFC_SEL]         = imx_clk_hw_mux_flags("enfc_sel",         base + 0x2c, 15, 3, enfc_sels_2,         ARRAY_SIZE(enfc_sels_2), CLK_SET_PARENT_GATE);
 		hws[IMX6QDL_CLK_EIM_SEL]          = imx_clk_hw_mux("eim_sel",      base + 0x1c, 27, 2, eim_sels,        ARRAY_SIZE(eim_sels));
 		hws[IMX6QDL_CLK_EIM_SLOW_SEL]     = imx_clk_hw_mux("eim_slow_sel", base + 0x1c, 29, 2, eim_slow_sels,   ARRAY_SIZE(eim_slow_sels));
 		hws[IMX6QDL_CLK_PRE_AXI]	  = imx_clk_hw_mux("pre_axi",	base + 0x18, 1,  1, pre_axi_sels,    ARRAY_SIZE(pre_axi_sels));
@@ -864,7 +864,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	hws[IMX6QDL_CLK_PWM4]         = imx_clk_hw_gate2("pwm4",          "ipg_per",           base + 0x78, 22);
 	hws[IMX6QDL_CLK_GPMI_BCH_APB] = imx_clk_hw_gate2("gpmi_bch_apb",  "usdhc3",            base + 0x78, 24);
 	hws[IMX6QDL_CLK_GPMI_BCH]     = imx_clk_hw_gate2("gpmi_bch",      "usdhc4",            base + 0x78, 26);
-	hws[IMX6QDL_CLK_GPMI_IO]      = imx_clk_hw_gate2("gpmi_io",       "enfc",              base + 0x78, 28);
+	hws[IMX6QDL_CLK_GPMI_IO]      = imx_clk_hw_gate2_flags("gpmi_io",       "enfc",              base + 0x78, 28, CLK_SET_RATE_GATE);
 	hws[IMX6QDL_CLK_GPMI_APB]     = imx_clk_hw_gate2("gpmi_apb",      "usdhc3",            base + 0x78, 30);
 	hws[IMX6QDL_CLK_ROM]          = imx_clk_hw_gate2_flags("rom",     "ahb",               base + 0x7c, 0, CLK_IS_CRITICAL);
 	hws[IMX6QDL_CLK_SATA]         = imx_clk_hw_gate2("sata",          "ahb",               base + 0x7c, 4);
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

