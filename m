Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0840649AF00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454129AbiAYI5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:57:46 -0500
Received: from mail-eopbgr70100.outbound.protection.outlook.com ([40.107.7.100]:23208
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1453285AbiAYIxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:53:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1zjE538EDv9gxupGIJJgqDIMPO3WnSPDezKQoQpMBAVARofYyjYy7trL2lwxY4fh9oI2q+FIqws+iFd+xNcPqlvL7fVL++HA0Is9AgIdACUHtdeX14ujoUcnY3ZXPTOp85t7J9N2e5lgHLmHtBV3vwXywMfq6HWaA/5WRMMIEQjT/Jql7XfUGsYqpzubXgzvOnmJ2G1tcXb7lKe/V0jvhS/KQBqFzhopDENAZthFXPT/1goAJG4yP5ha4NEErgIQSaUlCRLdRptgjvcZ8B89TSb/mvNTC5ly1dMALK7nDaB+cjRoFcyV2zvsESlsKQAu1auq4DhIJEgIPjR6qwa1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByWN0Qk3Ljn5cedVXgSfce3ekHQs1g4SygzOZcN87rM=;
 b=ch571LYBhFbohsV4j5BdR1FuIt3xpc07JodL8E0+a5ZHP9VXTn3mzQVVFeDLrC4UmQ9SBEIoS9zqYOPJcHvRw7aCDSuqJiH3JTQjgw9nhFydoA/R+aQVziNsD00lvlH7VYkRfDZJDFpAMHgBSCUES3Sc+xNbr8/RwIvq7ULBY559NAhSYySwz3sad6pX1ZxDwcLVONYIBSHWEyhkYL6/YuFWntwvO4jRqfMhLIzUUO5KV8eqaKXc2Q1ZICY8dch0RtjE+j5mO3Wv/Y6vGxnItefmhIqIoEVSgjEkpmbSizNOILla5GX4ysNzvRnyNf+se8X6xV6MvhPZkomf5YcxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByWN0Qk3Ljn5cedVXgSfce3ekHQs1g4SygzOZcN87rM=;
 b=BDSild98m+Jycxejpf/bntoOg2ntD8Lr1F2GUIMaA1mwjVWq8/l8LczVSCrmeaSWtWBhubRBpHvgCZR7s7VJ3ZsLw3YFiaVkuKL+06wQEbe9k8xFGt8xkRGCd2sO0vjDMwCa6elzBF92vJKrNYjbZ/wcN2JFzPaPRbflTNb3RAM=
Received: from AS8P250CA0005.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::10)
 by AM0PR0702MB3697.eurprd07.prod.outlook.com (2603:10a6:208:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.4; Tue, 25 Jan
 2022 08:53:08 +0000
Received: from VE1EUR02FT007.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:330:cafe::45) by AS8P250CA0005.outlook.office365.com
 (2603:10a6:20b:330::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19 via Frontend
 Transport; Tue, 25 Jan 2022 08:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT007.mail.protection.outlook.com (10.152.12.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:53:07 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 09:53:06
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
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Christian Eggers <ceggers@arri.de>
Subject: [PATCH 4/6] clk: imx6q: enforce gating of gpmi_io clock
Date:   Tue, 25 Jan 2022 09:52:04 +0100
Message-ID: <20220125085206.8508-5-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085206.8508-1-ceggers@arri.de>
References: <20220125085206.8508-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee5c9276-81db-4932-3b55-08d9dfe01b87
X-MS-TrafficTypeDiagnostic: AM0PR0702MB3697:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0702MB369789D8DD6229DB5D4DDAA4BF5F9@AM0PR0702MB3697.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:190;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIRLTqctqu4/Q3ufd/A8ZefpMsIEjEhRNu2KeZvN89Jy8b9Df3KtyyBXkN7h3NZV09SM292GkwtU+1DSWwaDW/7hb3diyC7b+v3FrglrBI9MKddAyw9WxvQ5t01gQcNMGFfv7byt40hUIuNVaBb1dKHsG9jrTuuoJEBqF7QQkiHAqZjAwPpb/z3LxzNYoUyIOHkmiZ582Bp7bTgYEfttt1nZkohhAom7D27PlYMGwdef0aS8WNyNTGYAOzAtbrn5rRA9hrzLzm9UFMMuDRfShc7DkUKD+bcylyq3XmP/p223py+yN4ni+5KEpn+egUv06ejyJqKBWQPpBjyo4e6n4jnqFeRhDX/0kdV0vEA9c2MJOuXW87GDjo17kbIAfRk5X4JgOqE+VI2xPtczegrTPWHJyFkaRyGMvF07oxbdjqena7LzBHKouX3T0viMFg12IxWDnn3H12HvdcmYIChRNYmhyRBJep72FWeBrooBvyJjy12OVngHndpKuuW3bMs0ibqzcx8qB2zVjE1e6ZiLbVod4PdmL//+L74ieXSnE0cZTIvOP2A8H8jSthtfvosQvarn9mwF2L9wFMoaA++JoC6VM3oPS4z7PPDp1ogYC8mydv5+h1NRwQ1kCxKMj3ZapNIOlmQQ02WuA+y0UvJ4x/POZjczIBiiho6O8LnuHWd7NDhEgI5l7Lr0ZHP6+u9KfU1qAab56jfxU1hSKdaw+T/eeyJWAYeSsCWOFczXHUv1OnTsrzBwiP+TviXYF2xmqgw7ILZUO0AnO9dxciJUT01T2uEc+aQyUTk+A2sEZhM=
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(83380400001)(36756003)(5660300002)(316002)(86362001)(70586007)(107886003)(26005)(82310400004)(426003)(186003)(336012)(8676002)(16526019)(6862004)(70206006)(54906003)(2906002)(2616005)(1076003)(8936002)(47076005)(40460700003)(508600001)(356005)(36860700001)(81166007)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:53:07.4665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5c9276-81db-4932-3b55-08d9dfe01b87
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT007.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0702MB3697
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

