Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6393949AEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454041AbiAYI5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:57:25 -0500
Received: from mail-vi1eur05on2111.outbound.protection.outlook.com ([40.107.21.111]:13152
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1453252AbiAYIxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:53:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE3leHl187t6NbQ7/vmX4qQcaYzLWN8W9jTAPHovcIhskS+5B7vUMqorWlEHpsWO3Gl50FNC0Ckl/PaJGx+Xgh2NnN12SNa6/JQU+BP5/GDutWILFg534yc9EySwpADeN1xofVsUlHIIjp90GUgahhJePpy8QVpFpy/wWHV00LK0+4f9ZY3fN6DoUTwvYk54RP+NmZK0mDRWXBidYdd95tMFnuv75hZcvxhavxsG/HmC60CBvr3y0hYg1i8FomDyoOJyvBOgNGBJD0bg6OAlKI0ujIZRoaEjoIVgteOVzf2UMN9AvgeKQIPgi0kHYUUJ8gEN9Mf7IReQisvrYaX6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95tvLBYtNx6EZinWxIaRXkWwHcP0exDvIX5U712Wm0U=;
 b=aK2NBrvsfCcjFRrJpqmd3PB59RoLpZSucnQRt9feAMPHd0m5CKP0J0kvJjE7jeBesoGW6uUayXYUurq0i8lk3SlPEDi0ZaoHZZcX0gpfPVqlpUjuXGjp25wvdTap0dELEy/vewGSX3K1+NYQgDiQ8IxKhA6wwj6TaIucB/TjUzi7rWmEbnR7zyms6z8uiCY1LPh/zx3kF3U9I7lmp/9jAQb+djVd6s9hLHsibKNUXV+nV9a0XruO2tUcGavKDbeOU+YOT8rOdUA8mZXvZkxvBoiDyMmvnMa0TSdI6TlCLL7UryV+2zdp4Dtz4Q2puItxwnMaDSgWa+xLga2qZ6aelg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95tvLBYtNx6EZinWxIaRXkWwHcP0exDvIX5U712Wm0U=;
 b=VHNR+2WbSI5ULV6vIE/sc+9ioCpm/TbkDr0FneirIEwMaS9ePQ19DsIiFT69qrAwHxKFFeuRvMF7cWpMc7FcUkPQpAjyfAG8Iz8FCu1gtCxwHo139y8aGP1TA8rpJmXbkJ3YUkO6ZTPXzY/CyPThlNx/krN9vBFx1iBPJosjPoc=
Received: from AM0PR03CA0031.eurprd03.prod.outlook.com (2603:10a6:208:14::44)
 by PR3PR07MB8066.eurprd07.prod.outlook.com (2603:10a6:102:14d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.6; Tue, 25 Jan
 2022 08:53:00 +0000
Received: from VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:14:cafe::43) by AM0PR03CA0031.outlook.office365.com
 (2603:10a6:208:14::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19 via Frontend
 Transport; Tue, 25 Jan 2022 08:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT054.mail.protection.outlook.com (10.152.13.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:52:59 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 09:52:59
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
Subject: [PATCH 1/6] clk: imx6ul: disable gpmi_io clock before changing parent clock
Date:   Tue, 25 Jan 2022 09:52:01 +0100
Message-ID: <20220125085206.8508-2-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085206.8508-1-ceggers@arri.de>
References: <20220125085206.8508-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33be8509-9ec0-499f-bb56-08d9dfe01705
X-MS-TrafficTypeDiagnostic: PR3PR07MB8066:EE_
X-Microsoft-Antispam-PRVS: <PR3PR07MB80668F6D1B2FFDFE49D3B301BF5F9@PR3PR07MB8066.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIy3D42itvJOPS+P8n53vK2Hya3uHOqAknQvXVYqBAJQ1DgoJc3HO0v+ufD2T1w23rIdTyHXjAL5vUBLISmrbgjfCxKNkxaabKFLRMfzV0JPqNFKQA2fdaMiWilz6jqoszJHRRbglol4zOiyT763R75i5PzkuiFmfmbLhjwBVjHOrG1zwRUY7jxGw4t069L5SUDAoPwRpkFY52NyOaWhWBQ943RpqCwKXHJwa93oVWFY67WRRirHm4cCD47mHcrekG8yMvRHZQfia01RMSbOAcfUjHU13Cm7BzfgHObq1or5OSzt3+XuO/Onl+qwdagAD2qgAzEGFCn4fnP/41NbsE0lJQlF2hLYxiHo1fTrh6wa+KGMvJ21awr7mq6cVu3k0cejdSejzKS/qxyWdWkzRwKgRZVTOKijQUsSFtCxi9obYjwqQGqfVIBNcJe3zASvQfRD2Lcz7YXtwciWrCea+xe6V5ZIkhDLeb3/+zfITEtBUUB032WwdrRdpM23KehkthVz9YxFNft1h3ca2IvSdRy83WnxU4UpvGPNxBp52zYpV7fhLWbqaKUYvWiGBi93DE07fHM9O2MZDWVCWQphO0q50CC1GfpQ1XK4YRjYdyWQtnm5wTznqAyECAO26MQWgWbFSY1oExYIGHLvjOD9E3g5veJ+p72TfLutDmeoz43MkHWrG6lalpj3WvTErypjimGOvUV/2EsvuWOigxp5JQXvIYsWrjx4aBYr+Xnkn9s=
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(426003)(36756003)(36860700001)(86362001)(70586007)(2906002)(6666004)(16526019)(336012)(4326008)(186003)(26005)(1076003)(70206006)(2616005)(6862004)(82310400004)(107886003)(8676002)(356005)(81166007)(83380400001)(8936002)(508600001)(316002)(40460700003)(47076005)(5660300002)(54906003)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:52:59.9056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33be8509-9ec0-499f-bb56-08d9dfe01705
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8066
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

