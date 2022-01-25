Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2AE49AEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454081AbiAYI5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:57:39 -0500
Received: from mail-am6eur05on2127.outbound.protection.outlook.com ([40.107.22.127]:22496
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1453277AbiAYIxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:53:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktz3DAs/B7FtCHnU1zzn93bDtXWluBCSKblrWFZRdsG5EVfJ/UdnGzc9nLa4jVfRmqZ0hmCs0bXZQk+Tcb+iX4SCbJ7qoofsz4QE30eG2GcyLewD9YQlWlGPS/500x62A0/0KaXPs4rwR30CveQdKWsffFuIHhMhEVGPajCajpMzw2B3dId2bUOksTbslwj2RKifLDYAPPGcgVWpQxpLIc/YydSlvHqFq69ls+ZHLFsaTS1+jYPACSFzGR+agyKdsoGoVAPSaO687AIozw4A+MNkT8p4SzSu11T8QfrcDC/0Nra94FJOdbBKOKbV0bpuzBpdY3tSnJlTUvSSIgVBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvCIEDy7zITFx2byS8YSNhKS1oqfqrc1QYpvQ5k/QlI=;
 b=gN7Exk+Kb93Tow0h/rtV1t0E0U1OMhMU+uCpAYJs02bcQ30bmkFvXxyhHmHxpRaD9kd2ZE96O4iHA9Bmn0ZxApZf+ny2Hp9IZegAFJG/5drWdQGKS1e0581EfGxcKyLtN3r9GZWIDQZzwyKT8hWqvPjjb0bMxSRkVyLeumnGKhulOGYztt9D6HMmL1YucaIUycbAbxKWQ3vMsjk6pkxrS3fs+SfFekAcj1B0F2EV68DKDJ1cGbQvvYQlh/8suF6kJqJT2rH/fp0VZuHumuAF+n/jeuGkzSs8T3d2u0eYwOeCxb7KCw2lYHguWAeKrSDXL4VS0GiIw1we6FB3OQtJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvCIEDy7zITFx2byS8YSNhKS1oqfqrc1QYpvQ5k/QlI=;
 b=M8NPkG6u8CyfnEoD6AWTbUthGArXq6ab3nbSp23J7aiaRRwf9ivYielyzWKJqyssW4SadyEvZFxDl3p4XsJ5IuinNNOViKHgB9GRmT1o1Q4b30am9d08UWy8zS6lNCPjZ/i60+DYwE06jhIgH3sRUnDm6b/eWWOykXQX4r64sJo=
Received: from AS9PR06CA0346.eurprd06.prod.outlook.com (2603:10a6:20b:466::21)
 by DB7PR07MB5835.eurprd07.prod.outlook.com (2603:10a6:10:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 08:53:06 +0000
Received: from VE1EUR02FT030.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::fe) by AS9PR06CA0346.outlook.office365.com
 (2603:10a6:20b:466::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Tue, 25 Jan 2022 08:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT030.mail.protection.outlook.com (10.152.12.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:53:05 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 09:53:04
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
        Christian Eggers <ceggers@arri.de>,
        Stefan Riedmueller <S.Riedmueller@phytec.de>
Subject: [PATCH 3/6] clk: imx6q: disable gpmi_io and ipt_io clocks before changing parent
Date:   Tue, 25 Jan 2022 09:52:03 +0100
Message-ID: <20220125085206.8508-4-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085206.8508-1-ceggers@arri.de>
References: <20220125085206.8508-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35d1cbe1-4d77-405e-fc56-08d9dfe01a62
X-MS-TrafficTypeDiagnostic: DB7PR07MB5835:EE_
X-Microsoft-Antispam-PRVS: <DB7PR07MB5835B5BDEE9D74A506F54200BF5F9@DB7PR07MB5835.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+JibGlAPZecFn6OqoJ+bkYFhW51qwHWP6o0l3oqowCUMr2kgZ9UDnqQ7ybMrkJZXeeeeKETco0NokDKcg4gXrHdLYjxNr3YGEAWWR1ti2vFhAAdhH87QaIqaVYSYxGUD2bqipQjF5g7oghuRSx2uYid3p/tH/DrJVuTsjeJiU75ABalUOJu/9EPcEZbdZBwS+Y9WlgqypeLnd1fytd8gqkp6oRhWOzMcmc7Dg5x5a5QrTOxKDlrnH+2eBdffvuhjKIH9iX7K1UG0foJ1Q99owo9Uc3mtwwjrRxXMEYqiGXmcZH7QR0dXkVfRHHo8J09/1h1Bgwe1UnX7IRCMOB1upY3Q0QC+X2bVSPdsUG7/zUv0yWGJrWkOoWTYdzm7ZYH7XQwxLrdfkHZo/IE3rDy2BALamoxmYJArZVnKwuLN8PJjssEe6PEWgAsd0PD139FECJQG8XPiV1DaQBo44YyXhRtrB5bi35AjK4bTWyeJ//cx2yryqkZMDiG5ndKvS2OzUZH9gZT/6Ih0x1vKmHNXbfpbwT3Y0RcBs+2EepboR2RQr/9cIFpwzOaC4Xwkphphz7RGw/Vih2Knd+hFXZvHxA4G2x9VC8l31mRQ3v9sPSK5oFdybnglUtrAJupLXnGg2c4F1LVR4Rg2O2qfauAT/XHuR0ah/jT64c4BTRG3jSmR/6CyZrg/Lp/lNtpFOxQrKwbwxtL5NhwiVFpasihiS+j5g/D3/py6lfLwQ0HT2I=
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(82310400004)(6862004)(8936002)(4326008)(8676002)(5660300002)(2616005)(1076003)(186003)(54906003)(316002)(70586007)(70206006)(426003)(16526019)(508600001)(336012)(83380400001)(47076005)(36860700001)(356005)(81166007)(107886003)(40460700003)(2906002)(36756003)(26005)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:53:05.5499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d1cbe1-4d77-405e-fc56-08d9dfe01a62
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT030.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5835
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

