Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184D749AF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454630AbiAYJAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:00:18 -0500
Received: from mail-eopbgr140123.outbound.protection.outlook.com ([40.107.14.123]:36351
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1453599AbiAYIzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:55:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr5lWzYbEooJlDd8iImmNYSKLEQlYmwvtDyLLYzWht9Bq2oln30kifsUaxztC7yRodfAOd5xANUiQXYx0ZLRk7rb4T8vCKiNnftTAHbYvMYQXn4x8WdUM2GA66jW7QtCdLTbnffo6Myq6Bu3EuGI5BS10OtSniERm2s/4Gq+o86DGVQuF6insDnaEw36+SdXYxAWK3T28tKD5sYei4CMXNtn0YF5aLWax9qSzjYXblBxeqJaf84mU6uc76iYQontN4M59rgAN+RhycNhGbtHMiOeW14X/gDJei16JYpGwXwwRC6YQZFmHYDzTQqbPRKiP7QDbSND2gHATtYrXsIdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tblyRKADO9du4XsWnSMGOoyEq3SULBJGzRcqQ9gqb7E=;
 b=TAJhcBaHkS7yzyyM64lNpDsrrvKZyqr4QFapNT77bAKjSec4OSJmUjj8x+046sgRDmKFUSD7adOSMuerAnQn4CMrMNe/xHG9eEc+CMP5oLXFXRcmkU4c8g1DMA31dVvIbZ2NBrlkVoD+Daje9cjDf45ztm6MUo9U3Gg0WhULYkVG8mK2VFe0ERLeIKN2buMqrgI5pl2+RklhxFXRgSrP46XNrF3BQ7YSblDzqvLWTJBj8I1hwX8zg8u/sSOuBMRXxJcGtD/tuZj9yHWcLLbxYaKjIfOrk9uVQgsMi+21rH+366/wy9Gr3JBSvje6v01ZUVtkuFMY318IMl/dCEcJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tblyRKADO9du4XsWnSMGOoyEq3SULBJGzRcqQ9gqb7E=;
 b=I6nXsLzWwfCIN54xrLTaLhYgLmVlRfs6DfQmptmbmGsmCQ+G7Fnwi+eH9ORSa+rbHfGCqCWLdRCq3S3HQUFSkxElV51YbjmsPjeVGvgzpsTIyJsWcw4YSX/dO/la59a773vimS5/T0vFw4PMjuWRcsubOyEomdQ7nRSw9xELr3E=
Received: from AM6P193CA0123.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::28)
 by DU2PR07MB8287.eurprd07.prod.outlook.com (2603:10a6:10:279::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.6; Tue, 25 Jan
 2022 08:55:00 +0000
Received: from VE1EUR02FT062.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:85:cafe::e1) by AM6P193CA0123.outlook.office365.com
 (2603:10a6:209:85::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Tue, 25 Jan 2022 08:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT062.mail.protection.outlook.com (10.152.13.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:54:59 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 09:54:59
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
Subject: [PATCH 5/6] clk: imx6sx: disable gpmi_io clock before changing parent clock
Date:   Tue, 25 Jan 2022 09:54:39 +0100
Message-ID: <20220125085440.8768-1-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085206.8508-1-ceggers@arri.de>
References: <20220125085206.8508-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb9a6737-be89-4134-cb35-08d9dfe05e7e
X-MS-TrafficTypeDiagnostic: DU2PR07MB8287:EE_
X-Microsoft-Antispam-PRVS: <DU2PR07MB82875D168FC1764955A24631BF5F9@DU2PR07MB8287.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xURhriQ+p0xQLZypQZCF3456+brP67WBfPHXUVXvpRnuzT5TakEUTp2PCVj0piWFuCyCU0L9zcevOxv1T5u/NdZBzZXc1gPCoIx1pnK2kRE54nbWl6s9Otr2JksKEz6bdC4LEZ47zqV5w8kVj81fYb10IQvXttmVJ1c0xGRaG773TVbGIb1Qd0nEpovwUnFxowqyX+g0EvDU0sZz2QqD/vnAgMYr5Aw5awRDNQ3e1j1qmppuUVReT4tiH2PEmhurrwhsl1G9FBrguveGOa4hdnjoI3Mtt6Gp18QyQTpkF41QVpCP6TfBdQKJlvG6oKZ2epwJQilR7X4DyGH7x5x5Sd5vWficQXQFIX09lcFWIh/Ax5711cSXYDYKdRgh6YzEflwbp2BnwI6RuePqLgMBjUYAeXt5Nm2gzgYxHlYOTwJoc3I436mIny/c9uAAGDx70yxDNXA3/HJhDtwg8xNfxKBMamkeY6IuTFER4kulCSwh4VOvd88ONoSF+hRFHNTcwRZk1f6YRC31CwHLkYegYTZaJFEM9cpvTEcFfnFDfNgKL53mt/1l8Scm++slNu1WBwLcXNvIVTByaxXs3yN0WaZ1CQ8XRTmkfFUj3e/kQuolFjvYllRVQ90Mbo6pkZufOTkV7wyAs1BM2s2dlrJwA8F2N2gcGeVK3TfHO9+j2aobjDBs27JzOuaHtIjFTqwN3Hcrd0U+Zz5NzZWVdYTwWW2/LLQcUGvy2gMq3BtrhViNGaCZxAPBHQuwYf4OSHr4h8+s33a+vmEgxeohz0Na94qycXCF1xqJvBB99Z29JI=
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(81166007)(2616005)(508600001)(16526019)(1076003)(336012)(2906002)(36860700001)(5660300002)(86362001)(26005)(186003)(426003)(107886003)(36756003)(356005)(54906003)(47076005)(316002)(6862004)(4326008)(8676002)(70586007)(8936002)(82310400004)(70206006)(6666004)(83380400001)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:54:59.8172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9a6737-be89-4134-cb35-08d9dfe05e7e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT062.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8287
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpmi_io clocks may have been enabled by the boot loader. All children of
qspi2_clk_root must be gated in order to prevent glitches during parent
change.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/clk/imx/clk-imx6sx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index fc1bd23d4583..cf1c1fad45f9 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -546,8 +546,19 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clk_set_parent(hws[IMX6SX_CLK_GPU_AXI_SEL]->clk, hws[IMX6SX_CLK_PLL3_PFD0]->clk);
 
 	clk_set_parent(hws[IMX6SX_CLK_QSPI1_SEL]->clk, hws[IMX6SX_CLK_PLL2_BUS]->clk);
-	clk_set_parent(hws[IMX6SX_CLK_QSPI2_SEL]->clk, hws[IMX6SX_CLK_PLL2_BUS]->clk);
 
 	imx_register_uart_clocks(2);
+
+	/*
+	 * gpmi_io clock may have been enabled by the boot loader. All children
+	 * of qspi2_clk_root must be gated in order to prevent glitches during
+	 * parent change. The task of re-enabling is left to the gpmi-nand
+	 * driver.
+	 */
+	if (clk_hw_is_enabled(hws[IMX6SX_CLK_GPMI_IO])) {
+		clk_prepare_enable(hws[IMX6SX_CLK_GPMI_IO]->clk);
+		clk_disable_unprepare(hws[IMX6SX_CLK_GPMI_IO]->clk);
+	}
+	clk_set_parent(hws[IMX6SX_CLK_QSPI2_SEL]->clk, hws[IMX6SX_CLK_PLL2_BUS]->clk);
 }
 CLK_OF_DECLARE(imx6sx, "fsl,imx6sx-ccm", imx6sx_clocks_init);
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

