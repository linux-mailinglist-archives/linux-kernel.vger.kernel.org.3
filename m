Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E828749B6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580471AbiAYOuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:50:12 -0500
Received: from mail-eopbgr60092.outbound.protection.outlook.com ([40.107.6.92]:23918
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1579949AbiAYOpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:45:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixNNiH+nd1DE1b51Y4Dg47/fk53b0z2TfJfEkp633CCj384ZFi1EXKigw2XEmpRUKMizkF0fAv128taNy23tvZ8Yr+wzEGENu5M/N6K2EB9+kTLkdd9b+uFFJApgi4hrd0W/C5QmOCpwT4W7Tu5mv9OrRTeFS5PtOfmPNzpVAyMyDY4MaA8GTNw8X79Ip9CFCJSoRY9GHq+5Gs7CA9NuNC71CilHFgko44M5irkih7fo4rR7zoiJSlmpIL/CfCYqLd08yl3v9Y7NrruJASQktOlD1L+0f9esYjsmkWnrecvN3gnP1+861jkzuoJSZ62beo9O3RT3NFhQntnLej26YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95tvLBYtNx6EZinWxIaRXkWwHcP0exDvIX5U712Wm0U=;
 b=baVB8Z6tQlRjIKBhTdqm95Viz/ImxtQy2ZTQ58J53DVPS9oW4cSS0Bqjmzu+gm9TDXlqE03+TnwgivE0Sq+5R9IOwYdj/lK4iZTV8Tzb7IOUysNVKGRm+OpehVhGAZK0hzaAeUVGnFmqzv815N9cfU7gG9wPCW2h/Wg4G1V4qwnAZtK8eXrj/Da9vtucjQrv1WFDpYQBWnSD0aLgL7k9Qu8JsdqDI8skeRkbu0QsG+D2hzxPSq3DUV0ry5k2wdMpSrALZSSFN9fNIeKMeAw62kj3eS29KFQ/p6nPo0cBMXNs87jRRvoemVZ7t/y+NevVr+xey1nhQ8kcu9azbXNQTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95tvLBYtNx6EZinWxIaRXkWwHcP0exDvIX5U712Wm0U=;
 b=s5jgq3EkR1rcsnWU5oq7YCF+zc9J+0HnBeKRJFkVbB7eCdtMwANRioyP+apUtgIleWKcoSiP41GNuUsXxy3UanFcr7RLrqNuqOKQGmFNRiAujw8aFBhZ8i3INi2qIRB81BjI4ezf6ZkpOb2JflMQF5J2svPzvwngLjQCzQp80t8=
Received: from AM5PR0701CA0013.eurprd07.prod.outlook.com
 (2603:10a6:203:51::23) by PR3PR07MB8097.eurprd07.prod.outlook.com
 (2603:10a6:102:170::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.9; Tue, 25 Jan
 2022 14:44:52 +0000
Received: from VE1EUR02FT018.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:51:cafe::f7) by AM5PR0701CA0013.outlook.office365.com
 (2603:10a6:203:51::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Tue, 25 Jan 2022 14:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT018.mail.protection.outlook.com (10.152.12.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 14:44:51 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 15:44:50
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
Subject: [PATCH RESEND 1/6] clk: imx6ul: disable gpmi_io clock before changing parent clock
Date:   Tue, 25 Jan 2022 15:44:36 +0100
Message-ID: <20220125144441.17750-2-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125144441.17750-1-ceggers@arri.de>
References: <20220125144441.17750-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ef2385d-fe42-4621-b69a-08d9e0113e98
X-MS-TrafficTypeDiagnostic: PR3PR07MB8097:EE_
X-Microsoft-Antispam-PRVS: <PR3PR07MB8097F6431BB3A99EBE1F6555BF5F9@PR3PR07MB8097.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Kvn5/hRFSHxHYn15kkvMty9n6pkyfCnh4UINWNaHK5Gcr705fhFQK2iS7WpjFfB+YY7PrfjVRv8gk5d64c5ZTJLt9ssYhMBBgDQH77PAHrjwV1ZP+yYBtjCwuBc08LD6/SiZHxQTmzyjTELI64bsiZQEtB1P+pn3KHXT6gedvEDb/xOQb57ZFovNA+AgATP/uBQZN6xJ/FaSsv7aGCspSEDpYXbwkTH+saAG3PmVOxnp4j8tvoP9XaEY1+2JytKnMs7Q60XmeJVM+7bEqYW7OdM0dh2RaNZ0LWVEnHeeNUgtKMUtsp1WhYHi5+RmbJ710FPa8NXdU7gMZpsHxrHkP8J6H+elhT3YG4F65kuZWdY2XPLT7y7xWOc1lKI6i8ClkH7Taorj0nomsZyDdvNBawmb61q9Vzgd7p8VVuBA9N7fAMqfkvoRMfdU+qQ53MgEQpgEKdkDhOkbzU0NdQx+gTQcbkbLQwZcJAVAhAtx8iaEiuw2AD1Tv37K6j+8GSMH6OPHUII2rwWAtOcqxN6kHUYMVYewpDtgqXmTsZGaZ5DfcKotF5D5ADetMzuq/FSZ917Za3LupHK6zsU68OOd2jCY8u9GRXuN56yS5aqUOd6ARiX22wfQtA9tjE4NmTmwdVTCHo/mXRwsvun8dLDHM4Gf6gZU7uaqHXq8tzz3J+rs1KVvd+KtAJbSw2l4xqC77lsmWSPbu7ooGXkUMWf75GgV0iNqOC3ZepiVUtwlcAJTrpn8F733RPuHhS85K5zRuEwMMEUZauWJgVdcMQ3bg==
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(6666004)(86362001)(81166007)(2906002)(356005)(82310400004)(26005)(36756003)(4326008)(1076003)(40460700003)(83380400001)(508600001)(8676002)(70586007)(70206006)(36860700001)(54906003)(426003)(186003)(2616005)(6862004)(336012)(8936002)(47076005)(16526019)(107886003)(5660300002)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 14:44:51.6397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef2385d-fe42-4621-b69a-08d9e0113e98
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT018.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpmi_io clock may have been enabled by the boot loader. All children of
enfc_clk_root must be gated in order to prevent glitches during parent
change.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/clk/imx/clk-imx6ul.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 520b100bff4b..f599ae50dd9f 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -514,6 +514,15 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	else if (clk_on_imx6ull())
 		clk_set_parent(hws[IMX6ULL_CLK_EPDC_PRE_SEL]->clk, hws[IMX6UL_CLK_PLL3_PFD2]->clk);
 
+	/*
+	 * gpmi_io clock may have been enabled by the boot loader. All children of
+	 * enfc_clk_root must be gated in order to prevent glitches during parent
+	 * change. The task of re-enabling is left to the gpmi-nand driver.
+	 */
+	if (clk_hw_is_enabled(hws[IMX6UL_CLK_GPMI_IO])) {
+		clk_prepare_enable(hws[IMX6UL_CLK_GPMI_IO]->clk);
+		clk_disable_unprepare(hws[IMX6UL_CLK_GPMI_IO]->clk);
+	}
 	clk_set_parent(hws[IMX6UL_CLK_ENFC_SEL]->clk, hws[IMX6UL_CLK_PLL2_PFD2]->clk);
 }
 
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

