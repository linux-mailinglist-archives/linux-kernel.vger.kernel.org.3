Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9D49B6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580966AbiAYOxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:53:30 -0500
Received: from mail-db8eur05on2110.outbound.protection.outlook.com ([40.107.20.110]:53501
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1580353AbiAYOs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:48:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFTaCluS5o8rQnfeRpl9GPolXaajW+sck2f05H8MwGAid9FAhXV4jL2yB3E0fg7upKO7+2U9RoAIRQrOinBMl1O6+h3iHDdLO7HtY+XiseQk0PWzQCicoK4wU6VvSdb9wGnWC19oSSMzh3C3IZWq0yDk0RxdL6//mwoUUlcrRbXBQyzGWDRGKnwZzypop+laus1B5q06QlOofQVit7yG7bU59tsEHEhKueWRsCrlPtDdEii7T85rgE8o258PdeduXf7mXEvvE7O6R0bCPSdxRFoT4hLT+zkL45KM1F6CezNXdwhlC8sp9KZS0u1r9DkfY9V11lIQ6Xnbjho4Et+qBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MUXi3GP3jwU117h9vbCj7WYECEimyoTDiQdzXMRMSY=;
 b=NPrgocyYrdkX36sJALUUf0ksFymvKvEFNV6Lyg9sWJSGzzrGGWuFQzGBM4QujQ2zcfSgYGttk5LolyRnJSaeVfi93LXDBWOz/Tt35ihGo9jmP1d9y1fLwm0MbzPOdEyZaj23D10MMX+nV1ne6j4rKm0QW7Ctx3eZ7MJewOsYLryB1gsRYDjDlyH0lsDL8eKBIfUp/SF67HggB0qlVBF52VG6u5DVNbmd03aZWz3xMwUFukOtpdzGEYz8wgvIXIn5IUOyvkcI4Q8p+TvJE/Tv/ZTs3x7LmMHrubdk17jGlju71OYPvsIg+4w0rKUf1J+hsCvuG2TRNPoxxPlRWKeWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MUXi3GP3jwU117h9vbCj7WYECEimyoTDiQdzXMRMSY=;
 b=mZDW33RNafee50b+cSL30S3DRNlbBGVhiZylKELWr9S/84xjjhCgH27Q9PwXyO0dawFf38U4vR7bBsZ4t6YFFbDCKpchISRgrNptejcexbcinKY3NZQ6Og7e5AolPmgpiR5Ftr0hNH7ox1BAzCIAIgqbcutSJ9WEnvagSPbjIlU=
Received: from AS8P250CA0006.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::11)
 by AS8PR07MB7687.eurprd07.prod.outlook.com (2603:10a6:20b:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.2; Tue, 25 Jan
 2022 14:48:18 +0000
Received: from VE1EUR02FT050.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:330:cafe::fc) by AS8P250CA0006.outlook.office365.com
 (2603:10a6:20b:330::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Tue, 25 Jan 2022 14:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT050.mail.protection.outlook.com (10.152.13.198) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 14:48:18 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 15:48:09
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
Subject: [PATCH RESEND 6/6] clk: imx6sx: enforce gating of gpmi_io clock
Date:   Tue, 25 Jan 2022 15:48:01 +0100
Message-ID: <20220125144801.18158-1-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125144441.17750-1-ceggers@arri.de>
References: <20220125144441.17750-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29754e65-6799-4362-dd80-08d9e011b9a6
X-MS-TrafficTypeDiagnostic: AS8PR07MB7687:EE_
X-Microsoft-Antispam-PRVS: <AS8PR07MB768730DCF1F231AC71382E8BBF5F9@AS8PR07MB7687.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/gctByeXbyyScdxoOIpSDoMN+n7UR6OSDN8p9W0rSujNjqIapoTr8stzN9gOBUbzqZnFVobf1nF/Islm8HoTYMgfop7ZEmRL/1OLQypsk8RnFJ7qOaW0jgwIboGbtYYcNZKlzP7FmjN0ue3iQjFO5FKl8Vjg+GhiRbV+i567AIKyRJuFMF86NLOszOWhknBFlqxNeIMxWhuGdKzQcw4jTzysoq9oS1Mygf3ijfC7p/dl757fSLnf5zlumbGb8bqFYB05m7w2Af+vpKPpLhTtuUMYXjSE8eEJ+M2N64I/7hR4IxIYdnut5A8sn4pr+nIXPBrPJ54KN/sqDOn0AcC10khT3TP3JegQPF5XBqOZpD1GmgV/jIUyfi+j3ykNrxwqeQkCpZwzRHPb7KpWUKliEojpW+ZwBKME62lPLCASwauecnaicoI0509jyExcNE+DeEpq7YVpbVZ9CtZmEOtvcHoTpQoZNVBnMHTlyhmiwi1T7UDsfMDmeZkfEQSx0S0JMQ64AhuzudZhk5a9jr/zKBBkqpFSznmOlhDdtPzCcLSP2ea6vWB7LJv9yCDYrFbnE5lRHqnifdhOPzH14BWpH287eliN50/MWuN74uUSGrRWLngjTw0lMmC5kggxxS4HAPHDr3+rK55DR6UeUeDsnVDcOKF4qFun9DFvR2BMakBLiQlziMRcQYyqgte9S5CQkmfNMKQB0IlNHVN9aqnNikb2p4pKOFEtQ5es0p+0TA0cjvN4oktvv+uX6ysKUmDBCkynN/Hsu7Q1FlBWBoqcLU5f/XlO2i3R06Yrx71jeA=
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(86362001)(186003)(54906003)(36860700001)(426003)(336012)(16526019)(5660300002)(107886003)(2616005)(1076003)(8936002)(82310400004)(26005)(6862004)(47076005)(83380400001)(2906002)(8676002)(4326008)(70206006)(70586007)(6666004)(81166007)(356005)(40460700003)(508600001)(36756003)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 14:48:18.0766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29754e65-6799-4362-dd80-08d9e011b9a6
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT050.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7687
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock parent and divider changes are both glitchy for qspi2_clock_root.
Enforce that the child clock is gated.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/clk/imx/clk-imx6sx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index cf1c1fad45f9..023a18594ebe 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -286,7 +286,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	hws[IMX6SX_CLK_ESAI_SEL]           = imx_clk_hw_mux("esai_sel",         base + 0x20,  19,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
 	hws[IMX6SX_CLK_CAN_SEL]            = imx_clk_hw_mux("can_sel",          base + 0x20,  8,      2,      can_sels,          ARRAY_SIZE(can_sels));
 	hws[IMX6SX_CLK_UART_SEL]           = imx_clk_hw_mux("uart_sel",         base + 0x24,  6,      1,      uart_sels,         ARRAY_SIZE(uart_sels));
-	hws[IMX6SX_CLK_QSPI2_SEL]          = imx_clk_hw_mux_flags("qspi2_sel", base + 0x2c, 15, 3, qspi2_sels, ARRAY_SIZE(qspi2_sels), CLK_SET_RATE_PARENT);
+	hws[IMX6SX_CLK_QSPI2_SEL]          = imx_clk_hw_mux_flags("qspi2_sel", base + 0x2c, 15, 3, qspi2_sels, ARRAY_SIZE(qspi2_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
 	hws[IMX6SX_CLK_SPDIF_SEL]          = imx_clk_hw_mux("spdif_sel",        base + 0x30,  20,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
 	hws[IMX6SX_CLK_AUDIO_SEL]          = imx_clk_hw_mux("audio_sel",        base + 0x30,  7,      2,      audio_sels,        ARRAY_SIZE(audio_sels));
 	hws[IMX6SX_CLK_ENET_PRE_SEL]       = imx_clk_hw_mux("enet_pre_sel",     base + 0x34,  15,     3,      enet_pre_sels,     ARRAY_SIZE(enet_pre_sels));
@@ -441,7 +441,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	hws[IMX6SX_CLK_PWM4]         = imx_clk_hw_gate2("pwm4",          "perclk",            base + 0x78, 22);
 	hws[IMX6SX_CLK_GPMI_BCH_APB] = imx_clk_hw_gate2("gpmi_bch_apb",  "usdhc3",            base + 0x78, 24);
 	hws[IMX6SX_CLK_GPMI_BCH]     = imx_clk_hw_gate2("gpmi_bch",      "usdhc4",            base + 0x78, 26);
-	hws[IMX6SX_CLK_GPMI_IO]      = imx_clk_hw_gate2("gpmi_io",       "qspi2_podf",        base + 0x78, 28);
+	hws[IMX6SX_CLK_GPMI_IO]      = imx_clk_hw_gate2_flags("gpmi_io",       "qspi2_podf",        base + 0x78, 28, CLK_SET_RATE_GATE);
 	hws[IMX6SX_CLK_GPMI_APB]     = imx_clk_hw_gate2("gpmi_apb",      "usdhc3",            base + 0x78, 30);
 
 	/* CCGR5 */
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

