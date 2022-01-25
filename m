Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E2149B6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580680AbiAYOvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:51:46 -0500
Received: from mail-vi1eur05on2116.outbound.protection.outlook.com ([40.107.21.116]:26080
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1580091AbiAYOpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:45:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/OGwhw8YtyWn2O6wVhk3XA7MDfQ2NmR3aXYH+v1N4n+DqbEZqtaDWU3j+mVFW3+6fPjUO6N4FT8MhhXlQ+5WuLNSaZ9YGiw2p+uRxSQWqKYbLALVcA6GcUhENu8dF8yxFPlKSDPc0cYhdiVQjrIy5OHNrjbdR1yDqqKEuoq2Z/F9nmXGTNYy1NNeABgSzcLhhFlEnSoeIu5xCbDso3mWYgLnYYbfk+UWgv2hfzGSwoLUT7ac/7QmffXPOP6XUC0FJ6DSEDUJ1FkSafNDcpxlgKMhO1DF6EN0k5UTnDcd9PS/6RAVLdACbEo6RGNRAPqgRewPp7d8EmBNgC6N6RQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvCIEDy7zITFx2byS8YSNhKS1oqfqrc1QYpvQ5k/QlI=;
 b=nhLClu2L6bpIk/hCdEgmxwpr18B2kr/IYe+e+rTu5KGqnjHBC6JUO/KA7PqYitqjLhU1gY6deTjzvmFEjp1kH8Ep9dn8bHNte50XBIL7Li0GbZiQhgaMhL3vtATwHQ7ZJrXbI88nS+RgDyHTvyf9xCZ9MuHiArt6meBUiih6kI8+getYMcH3QjE8znIQ8Bhok0Dv1tseyCz2xotckBci4b9kpAmLnCdRXtHH0RSgPX93AUuVn7qlsiYxmLYshDhvJsKNrpoxdAB38b93YL1nps7VtXRKifhw+Q4IVdoKLmb7HuRxc5kBILS1iJnZbfCM4sgNyur+/ZeQo0UBst5aPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvCIEDy7zITFx2byS8YSNhKS1oqfqrc1QYpvQ5k/QlI=;
 b=MEePc4rBV3OYIDMFIOMOU7AoahaNa5zLzN2S0vex5w38n/8KrYqi7H9LzyeKyyjuCgrg0ZupGT5QXaZ89MlmJlTmE05Ofz8xBErBEYuUelTsNttF6IIuZGIx16y44UYdRNHJS/3i6+vbIZXEW/yXdHT6kPL9dKYGHoo/s2JVsJc=
Received: from AM6P191CA0065.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::42)
 by AM6PR07MB4501.eurprd07.prod.outlook.com (2603:10a6:20b:24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.4; Tue, 25 Jan
 2022 14:44:57 +0000
Received: from VE1EUR02FT015.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::29) by AM6P191CA0065.outlook.office365.com
 (2603:10a6:209:7f::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Tue, 25 Jan 2022 14:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 217.111.95.66) smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arri.de: DNS Timeout)
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT015.mail.protection.outlook.com (10.152.12.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 14:44:56 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 15:44:55
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
        <ceggers@arri.de>, Stefan Riedmueller <S.Riedmueller@phytec.de>
Subject: [PATCH RESEND 3/6] clk: imx6q: disable gpmi_io and ipt_io clocks before changing parent
Date:   Tue, 25 Jan 2022 15:44:38 +0100
Message-ID: <20220125144441.17750-4-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125144441.17750-1-ceggers@arri.de>
References: <20220125144441.17750-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4dff9e2-0b75-4dd4-9fc8-08d9e0114145
X-MS-TrafficTypeDiagnostic: AM6PR07MB4501:EE_
X-Microsoft-Antispam-PRVS: <AM6PR07MB4501127DFE3DF7F0AB81BAFCBF5F9@AM6PR07MB4501.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FznDAkh4sNjEFM/jEMDSo/bqVhr/hZXabn5cuXglc9atBbGAhGf7/Kcbq7kklYv+uPwOtXq+FRP+h1/R9VuJLCM7O/JgrT0PxFp5dgEdM3ceZ1OoxZDjdJVsxyk2VOjR3sIdOZdTySedTVQuo28OaKhvHPjgYb//VAZFJWNPW5FSaWSyPfx9rydsmqK8OEACsPiwhka5mfArd7MRASavALcwGEu2A27bTrOP/7yeJs2o/xv4p6T/+3FYpG6rkh/vOZUT0fj/chtY2PgbvHnhH8u51WCo2fIDXsMkM1RYNHUJUZbGYTQjKR4l9Ivb2CU3WhAQ84Q2u3lmRlyAZhR7dy3CLVVtez34daCsgzhvB+Nf5jKGy9EVuwonSA5ZTq0hDfysEOO10gZsLXUdemg4p+aBTjKR45314fNBXvyPjDMNCQtkHEpEEKLiy07dZu7JgBmKRze1+9vAYWc8kUgsNJ3dskH+z4bVcpApCts0ChkYKqMVis1rMtbP/GGjdzaGaPdu/OmRbHAUUxr29Hk1irGyxGJqqguPY4ns28cny6TEuey40h+Zq/TJOWleo0/dOLPAbV6WTDo9tkJRvvNgfSvR/3t1sgp4wjueqeGypw5rNLylYkMVdUw92YHM2LgfUGAQLHPdHgiFS1Ngiir7+1XtULp5OePlMU1WyiG49vCa83YoBvpWix7yW4eeQNft1PUOmfXvulBKkkcsuIFLCe3Sq8JMyYc2cqEOiR+DvHo=
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(86362001)(54906003)(81166007)(70586007)(5660300002)(2616005)(70206006)(4326008)(6862004)(47076005)(82310400004)(316002)(356005)(8936002)(8676002)(426003)(508600001)(36860700001)(1076003)(186003)(16526019)(63350400001)(40460700003)(83380400001)(336012)(107886003)(26005)(6666004)(36756003)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 14:44:56.1283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dff9e2-0b75-4dd4-9fc8-08d9e0114145
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT015.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB4501
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpmi_io and ipt_io clocks may have been enabled by the boot loader. All
children of enfc_clk_root must be gated in order to prevent glitches
during parent change.

Reparenting of enfc_clk_root may disable pll3_usb_otg. In order to avoid
immediately re-enabling it in imx_register_uart_clocks(), the whole
section has been moved to the bottom of imx6q_clocks_init().

Signed-off-by: Christian Eggers <ceggers@arri.de>
Co-developed-by: Stefan Riedmueller <S.Riedmueller@phytec.de>
Signed-off-by: Stefan Riedmueller <S.Riedmueller@phytec.de>
---
 drivers/clk/imx/clk-imx6q.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index de36f58d551c..fd5c37095ed0 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -927,13 +927,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk_set_parent(hws[IMX6QDL_CLK_IPU2_DI0_SEL]->clk, hws[IMX6QDL_CLK_IPU2_DI0_PRE]->clk);
 	clk_set_parent(hws[IMX6QDL_CLK_IPU2_DI1_SEL]->clk, hws[IMX6QDL_CLK_IPU2_DI1_PRE]->clk);
 
-	/*
-	 * The gpmi needs 100MHz frequency in the EDO/Sync mode,
-	 * We can not get the 100MHz from the pll2_pfd0_352m.
-	 * So choose pll2_pfd2_396m as enfc_sel's parent.
-	 */
-	clk_set_parent(hws[IMX6QDL_CLK_ENFC_SEL]->clk, hws[IMX6QDL_CLK_PLL2_PFD2_396M]->clk);
-
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
 		clk_prepare_enable(hws[IMX6QDL_CLK_USBPHY1_GATE]->clk);
 		clk_prepare_enable(hws[IMX6QDL_CLK_USBPHY2_GATE]->clk);
@@ -975,5 +968,25 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	}
 
 	imx_register_uart_clocks(2);
+
+	/*
+	 * The gpmi needs 100MHz frequency in the EDO/Sync mode. We can not get
+	 * the 100MHz from the pll2_pfd0_352m. So choose pll2_pfd2_396m as
+	 * enfc_sel's parent.
+	 *
+	 * gpmi_io and ipt_clk_io clocks may have been enabled by the boot
+	 * loader. All children of enfc_clk_root must be gated in order to
+	 * prevent glitches during parent change. The task of re-enabling
+	 * gpio_io is left to the gpmi-nand driver.
+	 */
+	if (clk_hw_is_enabled(hws[IMX6QDL_CLK_GPMI_IO])) {
+		clk_prepare_enable(hws[IMX6QDL_CLK_GPMI_IO]->clk);
+		clk_disable_unprepare(hws[IMX6QDL_CLK_GPMI_IO]->clk);
+	}
+	if (clk_hw_is_enabled(hws[IMX6QDL_CLK_ENFC])) {
+		clk_prepare_enable(hws[IMX6QDL_CLK_ENFC]->clk);
+		clk_disable_unprepare(hws[IMX6QDL_CLK_ENFC]->clk);
+	}
+	clk_set_parent(hws[IMX6QDL_CLK_ENFC_SEL]->clk, hws[IMX6QDL_CLK_PLL2_PFD2_396M]->clk);
 }
 CLK_OF_DECLARE(imx6q, "fsl,imx6q-ccm", imx6q_clocks_init);
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

