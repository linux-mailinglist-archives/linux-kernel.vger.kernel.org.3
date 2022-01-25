Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1967549AF04
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453681AbiAYI6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:58:41 -0500
Received: from mail-am6eur05on2122.outbound.protection.outlook.com ([40.107.22.122]:13153
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345299AbiAYIzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:55:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEAAjj0jEJU1sbZsRpmtfNDPoTPXJYYJIcA1N2Js8PEhGLjx18a+fWMcSOP3xxnegxm1E9U2tS0+JTB8qUl3u32th9FRLRnhXOLIS/qTF6gF5zfKVz9/6WX+B6X8X+c2MsSqzBow8NUCJtSb3oPszaG+dBpQJEOujqTdKAndMjJtBiZxKcmOhew/8Aab6nKaxHEgPlkJlqS0epcZkd5z+IID2AAbB95kkpEq2ytXDe+x0dKF3w+tn9/nJeDURqSkfhB04RbifL9fXUvHWD0msUnWRek8aDClm8mTEaO8a10SLOjll8RgVeOOTdqd5cPduxixesmllsNyrKeVEGrGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MUXi3GP3jwU117h9vbCj7WYECEimyoTDiQdzXMRMSY=;
 b=N+MKCx8Mo5VX2kSBdojR4XRDPVjE5VEOy7RuSzZgqg5x+nAxAU/XgA9c9fEFdDzc2e7UrtFp9btazIVVxzHParO+0n1KApA9W/OzCIAwxwkWVOTF+3uhmK+gEKJt4wFgl6yj61RjOVAeEPxKPLljr537sITs/IwAZAQRJ+BTILt0N+6MhRsw4ZJtCUZaTikX5bFxSlH59EkSIXbXUZMCIvQ0dLpf6FoCTa5bRP1ZM1rdZKsPYOqHWaCdJ5Mu5tw6Og0au1Cii5ARCnjB+/jJ1Z0GxHE4UaPGKK0Z7T/JX9jetFPXcFBzS0EdTbX36EhE+fei+VSOMag2Cl7GhKnufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MUXi3GP3jwU117h9vbCj7WYECEimyoTDiQdzXMRMSY=;
 b=g4nSll5o/t9im+Y9+lV/h1gyNjd52ImNQk5Cm489ch50vrVBsBkOPQP3FXRpxJkTuFVlZz24KwUBOIxX0z8e8pc2VLChg787cUwG+xJK1t5Fw5gfeVl/kR03O0nGi2fg8MKabyzNTANzSwpnX3T3lWAXdRTQmjHrsVQu6POOrBk=
Received: from AS8PR04CA0120.eurprd04.prod.outlook.com (2603:10a6:20b:31e::35)
 by VI1PR07MB5936.eurprd07.prod.outlook.com (2603:10a6:803:be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 08:55:07 +0000
Received: from VE1EUR02FT033.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:31e:cafe::bf) by AS8PR04CA0120.outlook.office365.com
 (2603:10a6:20b:31e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19 via Frontend
 Transport; Tue, 25 Jan 2022 08:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT033.mail.protection.outlook.com (10.152.12.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:55:06 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 09:55:06
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
Subject: [PATCH 6/6] clk: imx6sx: enforce gating of gpmi_io clock
Date:   Tue, 25 Jan 2022 09:54:40 +0100
Message-ID: <20220125085440.8768-2-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085440.8768-1-ceggers@arri.de>
References: <20220125085206.8508-1-ceggers@arri.de>
 <20220125085440.8768-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f6c8192-9676-45de-f4be-08d9dfe062bd
X-MS-TrafficTypeDiagnostic: VI1PR07MB5936:EE_
X-Microsoft-Antispam-PRVS: <VI1PR07MB5936F3758823DED6E1686336BF5F9@VI1PR07MB5936.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CH1XQ8GLBGsna/xHp8l+Kw1moy9rT8/DU7zwhk+u8Dz5Vv4+MSeLSJLEEVZgR5hAEe1H08yQk3cJ6JXqm+z7+SmUgqG32SBLsQ/Yr8SWWHwE+keT8N9J3azyMYGNqXWyTBdZsblhAOEAbE+FWY3eoMBCryWeQuy+EIe7zfywkNBrCrieyEyx4AO08XjJnrFLvIs8NW26qaElOuav0xtektgegfzvEip0uvrbLGtLZhAUJfO4cxry1NBIintdCZWAA702ZlM0vymaP1A5QD93P+u1nQPTAgk37fxdr+xYu1S333dlc0s+uGKdetC45e4ZWqZxsaMuSeQ+67QoAgvFRRjg9tnTNYaGGe4jKjYTJ4bppOCi5QdnbIVSEO/A1s7apNM7M0P9kannwofqnUIOYJBJC+ySwuuPVHNZ1dBN6N5hMsQGJvbh8wbpZ4PUu13LhSPJc5mogT6fsrFIe+WtJIdVZ5F7ieVdC/Vx+wELd9PjYQKGcnkRX++D6WR5LlHbTzjAJBaLRW6qvk4YUdUc4FPSvAqelA1zGJWD0Kgt1Sn5u76pKhLYU2ISjFkhAbY5/3TvS0+xwm5lOmqibHCx3ndqRdmXOxoNbZ0elQWv/y2jJ5oJnf95SkeCsWSq8Z8ge9XsKwEzoJckVORoyMiIsX8reGPzfGymJXB/I/1JE536eUv8yuHSNcm9FlPiPO9v6DdyB7XYg58sROBQDTKeOeLpQpxgqUwjfTGCn/mf3jo=
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(16526019)(5660300002)(426003)(1076003)(36756003)(82310400004)(47076005)(2616005)(2906002)(186003)(26005)(336012)(107886003)(36860700001)(508600001)(54906003)(6666004)(6862004)(4326008)(70206006)(356005)(70586007)(86362001)(40460700003)(8936002)(316002)(8676002)(81166007)(83380400001)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:55:06.9420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6c8192-9676-45de-f4be-08d9dfe062bd
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT033.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5936
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

