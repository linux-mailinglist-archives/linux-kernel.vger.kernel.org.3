Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C649B6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389105AbiAYOuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:50:23 -0500
Received: from mail-vi1eur05on2110.outbound.protection.outlook.com ([40.107.21.110]:48836
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1579934AbiAYOpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:45:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4Ehsa8DTOVCbm1CCspIjCdCTggRPxQ3T0T55bFQ0wKRWuUjpeM7uPaTnZgzJIawGdvy4Fi1iPb3Xa2F6b5yaQZrmzB8k0nCUClDzJun/1NSGhkKxfVnOX+fqdmTwhYPHI70ef2AwC8L6uVpsYpk34CYa2lJdgqlr4+kPCPubw8PqXEXWYfgoKOOUdl1yt985e8B65/HYPLl1lVFuXmKkKpGWozfSxr7NRvmDaQpxbWt8YIDzbRb6Xd2zdHe2X9Hx33at9/A1iCR0UDI4jUIbL5Lks6B+tr8/a2YH84Eoq5drJPw32A0a2eZApsM/MThUJNrvoi2gAF/UMuncV4S4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p57bgbqHsjsgGqk169a8KxqDwxH/DLCZD/O8vQZ+dL8=;
 b=W/ti5G8O/nktDh8cMcmTGeyAmPslF6ASeEWTykUvIGlB3pSQ7Cy35C3LJngBoU6Pi3tmcF8TeHqi2wCz4oGUB4vQ6X/gs1ZOqojEJC5NBVQwlCyJlE0JzrxCNxW4H9V8+KdX1hbf4RHMJRJOcMPM7K3NL/zSgtAQrH6bUMZGk/37vxR0JAP9LcqNJ3Hl9+AHcCN0CRSpv4c/ZYD18A800I/t9fpmn1ZDkXMyRU3Q7nLIvEGy5s6r5jxIv184VAzjqU4ugATCyhd2BDf1l/IX7E5V0orq6DyD36mLugEXsfSGVZnDkajQWqWoe7zzsnO5xZvX5IddgQPrzGkPxqV19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p57bgbqHsjsgGqk169a8KxqDwxH/DLCZD/O8vQZ+dL8=;
 b=cfvlO64LdPWMZ60QaFJaxoGtZ4i+s+Jgmu5KWGFPaxGt+aFA6M2iNOOl8vpk85ts/Ed7BP5MbC7x1AwKRdYAgzbGVkRvQxWpFDb3guSp8ZyLUMno2vSDw/yY8hYvT5UMfpPRx5N3FOT2P+yhdN5rze+kcnWLiL+wnPas3qN3kVA=
Received: from AS8PR04CA0016.eurprd04.prod.outlook.com (2603:10a6:20b:310::21)
 by AM0PR07MB5841.eurprd07.prod.outlook.com (2603:10a6:208:118::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 14:44:54 +0000
Received: from VE1EUR02FT007.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:310:cafe::10) by AS8PR04CA0016.outlook.office365.com
 (2603:10a6:20b:310::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Tue, 25 Jan 2022 14:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT007.mail.protection.outlook.com (10.152.12.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 14:44:53 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 15:44:52
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
Subject: [PATCH RESEND 2/6] clk: imx6ul: enforce gating of gpmi_io clock
Date:   Tue, 25 Jan 2022 15:44:37 +0100
Message-ID: <20220125144441.17750-3-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125144441.17750-1-ceggers@arri.de>
References: <20220125144441.17750-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c739e69-60f2-4e98-595e-08d9e0113fc3
X-MS-TrafficTypeDiagnostic: AM0PR07MB5841:EE_
X-Microsoft-Antispam-PRVS: <AM0PR07MB5841757E9494E5D674F49C93BF5F9@AM0PR07MB5841.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iFKuXdVXx/L2AsSn3qTFZurKn8rlJhsf44heoApHfv/S2Lk+ZuaoL2KTCXd+39Ag1VY4gWFNEEOCeteYRbBtz3GPy+cagQamIg0dnKA9bfAf4WOW6dEMXfu/3rx679hRzjjaY3kThjLrJXwOqSVb+gR4npekSHl3WwRkk5ffSAe+Fvx+IfN9shQG462WccgXs7d0sisQHqnChPUx1sPuO+JUwVRdkPMw6Y+pO+ulEXLqK1hgdZquLm6ZfLKLVFKyGlgHbQNY0LwOhDJg8DvQDzfM1UyWAmt5KXMrDtktcGcL+VJmQv1J7QRFdi4bx8gQQK3I0ELGturTAZWyjdKoEZHTzDdELm1Sxx/EFW6Yz8svc0fs3eJ4xfFsaa+gZVR1/Qju3gSoVhHegcXWoGqSfcR8IO+EFlcVUGXgV2W5VfyyPeC/tGNOFWIN/mlfpEi7hO1ypOsW1MI/BxwT3T51a6dXnET73Y8ofq82c2/7IZUENkgvPjqKJKa5SaPe3dCL9nuzNOk0l650kAhOAx1zg1Q63Ersq7LFeR7p9D6wybMKHj02qkhWDEgL/iJ0JF0c6GSNE1uZWfBHCFH/buMj9DcH77llUtbDBm/hh7jTQHo1hbw4pTa97abt6UPBhfk986nY9CeawlftNKjWk7Qj8aI1ogakT0LmPpyk4KB6dBx2xlaUOFsoziZUaNrbSCrqALoGvSRa/P6aPAkHGO2zHMsdD0bIQdG8SO4HturqJ8=
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(83380400001)(2906002)(4326008)(82310400004)(8936002)(70586007)(6862004)(8676002)(70206006)(86362001)(356005)(81166007)(40460700003)(1076003)(107886003)(36860700001)(54906003)(336012)(2616005)(36756003)(26005)(16526019)(186003)(426003)(316002)(508600001)(6666004)(47076005)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 14:44:53.5993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c739e69-60f2-4e98-595e-08d9e0113fc3
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT007.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB5841
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

