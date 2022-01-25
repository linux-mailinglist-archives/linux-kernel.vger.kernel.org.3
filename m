Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34F349B6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580746AbiAYOw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:52:29 -0500
Received: from mail-eopbgr20111.outbound.protection.outlook.com ([40.107.2.111]:47233
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1580325AbiAYOr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:47:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlRzzS5rhYQOVq/64vf6uYcHBChddIvpU6ZS0kiqEpVDLxPzPHdthyi6JOHKo4r/WJ1E+5j0ikwqf5eAFpt4uNK6SMI3bfHWflG+MATIG7Wj9SB2NIdo4ipoKQYT1fOGPSjXkxetIQJIwijpvc6r6pdBM9n7b7W3IwKKL7YSilFfFxuu9Xp31fYEzqbVuF5jiOXKVYu/gtaJ+vsXBIQhhKLL+y7jrQqEHiu2GG3oE8amMSR++ODwydrnESskZAl390z+djt/eoaI/UyNyrLgrPsTfi3bmGLjPEImy6NvipUaDFrQeJWNs6IM+l4TAHxjLljXyGozjO3lcmS88WqSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tblyRKADO9du4XsWnSMGOoyEq3SULBJGzRcqQ9gqb7E=;
 b=n53ED9uE/kGPQgr3gQFsVf0ym2e2zag+9daxXCHJjFKYPfsoMH68+UHSD24xOCHL6uHNy4Ynu2nhqb4mzz2RjzrP4Zp+EFM76PRYISgE0Fy/dHnnVGN0u/ra2lnCJ2d+bf8rsmmT801fQlfFJENCZYlcYWrf+Ics/quEnCpRISL2BMUjhA5b3ijv8YPKMr+EEN1Dutm47SZDMyoCFUR8MqQKgiFmUuWDBZe52C0pwyLvil9TOP/ZYCP82LtpK7DjoBQHGcdSPxeyjET+RYWLkY5U1d4tVLxO8qj4SnYZngZAVr7pJURMv0pz42mqqJun4usrW2fE1M8yJQS+JGvCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tblyRKADO9du4XsWnSMGOoyEq3SULBJGzRcqQ9gqb7E=;
 b=OkgXCL1fBrJcujpYCSrHtrMgqbbd3OgZRGCi6KrbNMdDDZQNUA6B3E0Q7lYoDgRNN8/mvRh4Iz7Ny4kEMxITQ+w68I2Yl22jvCGajKJi+ZRAoaIuhp48S28btx3JwYC7Xj2qT8Ej8aXBp2Xeq5s2+q8nbK1VzK5IUwbHznR1Gv0=
Received: from AM6PR08CA0043.eurprd08.prod.outlook.com (2603:10a6:20b:c0::31)
 by DB9PR07MB7881.eurprd07.prod.outlook.com (2603:10a6:10:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.4; Tue, 25 Jan
 2022 14:47:52 +0000
Received: from VE1EUR02FT041.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:c0:cafe::64) by AM6PR08CA0043.outlook.office365.com
 (2603:10a6:20b:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Tue, 25 Jan 2022 14:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT041.mail.protection.outlook.com (10.152.13.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 14:47:51 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 15:47:50
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
Subject: [PATCH RESEND 5/6] clk: imx6sx: disable gpmi_io clock before changing parent clock
Date:   Tue, 25 Jan 2022 15:47:35 +0100
Message-ID: <20220125144735.18091-1-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125144441.17750-1-ceggers@arri.de>
References: <20220125144441.17750-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c876eaa-c37b-4eb0-8eec-08d9e011a9a7
X-MS-TrafficTypeDiagnostic: DB9PR07MB7881:EE_
X-Microsoft-Antispam-PRVS: <DB9PR07MB788192D285A58173A9328F82BF5F9@DB9PR07MB7881.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aa+qblL5BtDAFmfgUQ6Plv2UiX+veTc6nwnMxkF3OrHBM4dCHnqmy8RG2OQvLv2v1XUcaZbrjWfSzKnWbSVEHla1qtSRJDqd7WtXLDSFMVdfs6WxzDGrnGBoVSBAg0bLt4uv1920kAjwh426W5jG8tMKEJrJkU/2T/P/hXu7J94ZadoqvDBtWSj89Cop3QxVAlOXeAFLCnZ6V30RkY610iNvHuVFUOARp58IP6cEsSn6u8meHGz4GiyjTHFe2R44dNdU0cIHdNPHap06Tx1FKJVToZfSQfVvdnEVY+2ugoTSAiPuHKyt0hH+NO+TuQeBAvEhg6K0tPCI93QwoekFvnjOyTnK0AhKjPqETAJBAQ0lGueNsIvdRJV/T4bzfMx2sQ8drHSQKEnoksWW66OvVqtl5Ufh1mHihrOCldSy5JxO9PYTYJ+rlTnwj43A32oAUxgiaKe0EWGGG1DGP12/NJn61X4IXgC6W5JJvrceDu6zHDx70Z+N5811ccLbpQEBtIoaBFG3m0lRUxJKjxoN2Wk0wznw3gEE23X9QytAILBaxIIF+EFU0238PYE5tTDqu4sFgG92+2kqxGp3NWZmQjPmTN58IMsX0jLD3Asw2zIHPGvtGGa3DZDxOeaQ01boKab1dGupmdIDKVSlauyVFuAKKVqArATkTn8SvGmbXu6pY9ng/g6J7VEyJe4e57pgUQNAuixV5Z4rnQ7SJqup7mmYKsCpa3AZWYre9aCyRJl43WoT0w9hFCHSvfbt0SP5VkGq7K962lgaCj0Deh66LBpV7YnHN5BDpZOJptVBVVc=
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(40460700003)(83380400001)(4326008)(70206006)(8936002)(2616005)(70586007)(6862004)(5660300002)(8676002)(508600001)(86362001)(356005)(2906002)(426003)(186003)(54906003)(26005)(107886003)(82310400004)(316002)(47076005)(36860700001)(16526019)(1076003)(6666004)(36756003)(336012)(32563001)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 14:47:51.2511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c876eaa-c37b-4eb0-8eec-08d9e011a9a7
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT041.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7881
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

