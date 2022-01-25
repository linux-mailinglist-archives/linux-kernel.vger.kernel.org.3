Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6249AEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454052AbiAYI52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:57:28 -0500
Received: from mail-eopbgr80105.outbound.protection.outlook.com ([40.107.8.105]:26668
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1453260AbiAYIxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:53:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn8cynacdXU81UpPhgUb8c9uMbeP2Ll/zAI7nmv79gVB828yG+q0z1OFGM3/hbIWfq0p2evQM6dYGz6USMGgWuA+DSV9hqle1Z2Bij5YcU0iLARt+OFtahb4QWECxUQru5jlZg1DACYV0qnV4j8ZUCWwIoa33/IUY+QNJ/VfrYu3wZONv9cYLH2P3TND03jV5OTenWLpdgoIgS9dRPALcoDIPahVT1q144YLS0FIOolMHNiSeWdAWTYC9CVD//ZTeK0Mbsu4mHR4wfer67P6yjOHm6KsWCwqajqFNSdItB+sO41FW7MAKkght8N8R0zN8X8OrlSaqn2B+dstdvx7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p57bgbqHsjsgGqk169a8KxqDwxH/DLCZD/O8vQZ+dL8=;
 b=FnWYROrMNbXn4IyvPqDADFnTJ8Y+KFG/9+qfFunMIpEw4CwTJBqPpbMtHodC7VeE6H1YN+8ftDn7qPwPv73jGjKbC5WDT+KIYrIYgJomzGzvpMlac9OKlUiog3iVc6IfmliFpaBHx30iETlmQxn5/hjaCuMEoWRYDiGkq5fAOM1mesU4O+1dSIjjXskyPP2MVfbYmoWkgHmreiTTDA4hx6gIuNNFdLiw/4xVIIi3Vxd0rqmDoa8y6DSx+ndPlyDHOn/h9hyeWFVAfjEnq5lSLUfWDe3daE6BzR6nBvO1h/xVsTnZ4SrTxWC2yk66MysDqbZeF0wcJs28FF7ZkcDu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p57bgbqHsjsgGqk169a8KxqDwxH/DLCZD/O8vQZ+dL8=;
 b=AfK50w4D5fjR4WgNAlYLle3mt7mylQniDtdYhEmDFkLR8wWZNz3dZclsgPKl3uxXGd/6jwSZHteOn262KQLySp06PflHwUTSMXaQMRk+oHK8xPt81M6QKpPTugGvwu8DwTC5D4z+4uozemoAAfSvjLfmsuTeH75id2I+i0UkM4Q=
Received: from AM6PR10CA0085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::26)
 by AM0PR07MB5505.eurprd07.prod.outlook.com (2603:10a6:208:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 08:53:04 +0000
Received: from VE1EUR02FT034.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8c:cafe::3d) by AM6PR10CA0085.outlook.office365.com
 (2603:10a6:209:8c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Tue, 25 Jan 2022 08:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT034.mail.protection.outlook.com (10.152.12.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:53:03 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 09:53:02
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
Subject: [PATCH 2/6] clk: imx6ul: enforce gating of gpmi_io clock
Date:   Tue, 25 Jan 2022 09:52:02 +0100
Message-ID: <20220125085206.8508-3-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085206.8508-1-ceggers@arri.de>
References: <20220125085206.8508-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e36446f1-c0a3-413d-6849-08d9dfe01926
X-MS-TrafficTypeDiagnostic: AM0PR07MB5505:EE_
X-Microsoft-Antispam-PRVS: <AM0PR07MB5505E46E82352FF1C610FF47BF5F9@AM0PR07MB5505.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQumSZfduxv/gVIusJefYFJXKPAgSumcbevPkZ0aQQsIDlYQgOeK2zDn/MD8zEsjwy3NywRv3ZbALNA5TwdtltZFlk4tOsvqe591/g6KFA9bIaPyIwH1d+L114LVYoAv9bsNinkDOcFkhynG3fPCltPpxOImnYJL2eMUntto8sebrcPTt92UdWmvTYd54aQP0SLvo7VbnMZbj4yjGK3QjcCgaM9UTZedeW3k3wJ1dxv5Brj0JhH7pb3XqLhaagKHuznI5bkEg+SdD9NjPWPveGOHa4iegszorLStdS0hPi7+s9kwzcYllQ58KtuPqFV/dAcZh9WBQcaxIzOGD56o85/yfsgIbnHIamjUoIktR7gTY2In3GgOAidMVezSxHNEdZsqkgKxVh/PqpvtYgIdNvaRG5heoRcPjgK+5HZOk+QAkHzO83R7HpRpIW8+3jRcMIIouEA9puExBqvsuMmzbrTYlz78fpkFfoJH198nO2deg+ZuyEi/xL4s55ejmUJEfnWBIPu1uEuKn3UotHYce2ZWsVLU4PexkSxRX5VZnewKoob0rxfQZdXvKD9W7gQXy/rn4Q3QKHNYxG2JhF+eZttmHQJQWVkeljkk90CTHOo4E5HVgGC6YwY6yTn12OnoszTl0G+xexRaszPLUh1qvOxxyE5NBP05EcSqNQxbXBYDBPN4dgDGrFA0QYC7YXuT9EPIYG5LDyryAg1J2jbT60BIBklgM5O0FfiZ7cca3BJ8E7EIJPcGEy/lYpi3vY7Qa1ZtgbCYYIyE4LbWHjhDIzp/gQfgWVliOtkNNDzAoYo=
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(107886003)(2616005)(426003)(1076003)(186003)(336012)(16526019)(26005)(86362001)(5660300002)(40460700003)(2906002)(83380400001)(508600001)(47076005)(82310400004)(36860700001)(8676002)(6862004)(4326008)(8936002)(54906003)(70206006)(81166007)(70586007)(356005)(316002)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:53:03.4595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e36446f1-c0a3-413d-6849-08d9dfe01926
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT034.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB5505
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock parent and divider changes are both glitchy for enfc_clock_root.
Enforce that the child clock is gated.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/clk/imx/clk-imx6ul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index f599ae50dd9f..5443b5a0dc75 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -256,7 +256,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	if (clk_on_imx6ull())
 		hws[IMX6ULL_CLK_ESAI_SEL]	  = imx_clk_hw_mux("esai_sel",	base + 0x20, 19, 2, esai_sels, ARRAY_SIZE(esai_sels));
 	hws[IMX6UL_CLK_UART_SEL]	  = imx_clk_hw_mux("uart_sel",	base + 0x24, 6,  1, uart_sels, ARRAY_SIZE(uart_sels));
-	hws[IMX6UL_CLK_ENFC_SEL]	  = imx_clk_hw_mux("enfc_sel",	base + 0x2c, 15, 3, enfc_sels, ARRAY_SIZE(enfc_sels));
+	hws[IMX6UL_CLK_ENFC_SEL]	  = imx_clk_hw_mux_flags("enfc_sel",	base + 0x2c, 15, 3, enfc_sels, ARRAY_SIZE(enfc_sels), CLK_SET_PARENT_GATE);
 	hws[IMX6UL_CLK_LDB_DI0_SEL]	  = imx_clk_hw_mux("ldb_di0_sel",	base + 0x2c, 9,  3, ldb_di0_sels, ARRAY_SIZE(ldb_di0_sels));
 	hws[IMX6UL_CLK_SPDIF_SEL]	  = imx_clk_hw_mux("spdif_sel",	base + 0x30, 20, 2, spdif_sels, ARRAY_SIZE(spdif_sels));
 	if (clk_on_imx6ul()) {
@@ -424,7 +424,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	hws[IMX6UL_CLK_PWM4]		= imx_clk_hw_gate2("pwm4",		"perclk",	base + 0x78,	22);
 	hws[IMX6UL_CLK_GPMI_BCH_APB]	= imx_clk_hw_gate2("gpmi_bch_apb",	"bch_podf",	base + 0x78,	24);
 	hws[IMX6UL_CLK_GPMI_BCH]	= imx_clk_hw_gate2("gpmi_bch",	"gpmi_podf",	base + 0x78,	26);
-	hws[IMX6UL_CLK_GPMI_IO]	= imx_clk_hw_gate2("gpmi_io",	"enfc_podf",	base + 0x78,	28);
+	hws[IMX6UL_CLK_GPMI_IO]	= imx_clk_hw_gate2_flags("gpmi_io",	"enfc_podf",	base + 0x78,	28, CLK_SET_RATE_GATE);
 	hws[IMX6UL_CLK_GPMI_APB]	= imx_clk_hw_gate2("gpmi_apb",	"bch_podf",	base + 0x78,	30);
 
 	/* CCGR5 */
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

