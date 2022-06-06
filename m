Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809D753E1CF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiFFGZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiFFGZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:25:36 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5527CE0;
        Sun,  5 Jun 2022 23:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9M+b6mLXFwTuFsHjCBkmdbQgIibQrQcCkwzkYGUcO1JrXJKMGBOGKU/ZTIktBxVTPlKR4DycJ9xDEefN/0KqvCyFx6fM5lI65mTbSCutgKU9pkYuDI47sHbnMP7Q6AHY3RRk6UDJIUqg3zsBRfzyjfCYpiusowOFhjwsoBthgdhpy73Y0UL8J+0pDUU/3j9sBC0Zf5YtZWAs2Avk4TEq2jInQ16AxF3yOxHoE/euyyEaWCplvYn3FWnQM0CeFvCJqPGUBNsZlYnrga/3/o+KXMe6I1IkELMrjo9FhjaLZxrPk1RY4tgnDWPF1Ap4Dgr2wj8uune4lp1ipr1GDJMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9d+CR7WUEhe4icN5ji3Xa14Ku0gFC459XBB6TTv1Hc=;
 b=PdE7VFNvqfmlvF3pfnFIjta7GFDDD2xa7P5jn/lE1txJ7LEZJJ6DQ+cM5iVbDFBjEgdueW0XdL7xx+zUjlgiGA+eiIsU6hzUryJeo9SWj05upHx6ls3yc2Xf6YE2dNhwWAQ3BR+DwLYw8aimMnddkoHVX4P+HeM983F3FQbF1xlnhOtvPr5K1OBEB20lPHxTXbBSU/jj9bucjDyOoWHFRDkyFU35TK8PDPngxUyHkfXBMejBHAKItVPj/jP0xDrx+E+J+fHoWVW2JFkXUzMwiIVOFQSBZv4Qm1vFL2U3PBs74rJ5X7w4WXHV0QllHEi5qkJovBEkBvGi/0Y5c3IJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9d+CR7WUEhe4icN5ji3Xa14Ku0gFC459XBB6TTv1Hc=;
 b=EfYzKXYqqK7fNo4xxnS8+3h/f32q4UvCh8v+7RRcXA7snuQtrFjArr6mzVYMyqWpGqNyGYu4AB+QlN2J2wbcs021lRX4+ZESdwK02b3vTgruwCJ/cD0NdrstuU40D6HU4xO1upgoLJTlWwWg9hRGE446NYhwJyXnkrCxpMGL8sg=
Received: from DS7PR03CA0288.namprd03.prod.outlook.com (2603:10b6:5:3ad::23)
 by PH0PR02MB8550.namprd02.prod.outlook.com (2603:10b6:510:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 06:25:31 +0000
Received: from DM3NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::23) by DS7PR03CA0288.outlook.office365.com
 (2603:10b6:5:3ad::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Mon, 6 Jun 2022 06:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT050.mail.protection.outlook.com (10.13.5.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 06:25:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 5 Jun 2022 23:25:30 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 5 Jun 2022 23:25:30 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=43118 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1ny6B8-0007aL-1H; Sun, 05 Jun 2022 23:25:30 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <git@xilinx.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH] spi: spi-cadence: Fix SPI CS gets toggling sporadically
Date:   Mon, 6 Jun 2022 11:55:25 +0530
Message-ID: <20220606062525.18447-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ef5f96d-bd3d-474d-b299-08da47855b79
X-MS-TrafficTypeDiagnostic: PH0PR02MB8550:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB8550ABEBC7C195CD5156D6F6BAA29@PH0PR02MB8550.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sxpsj1eneA0qCPcczWhle8U2qvQd/1wuZ4yzCe3SZEGdhI+swKVKYk7Cbc+QI9t2sdcQerZC6KJzwjS9uVCm4wPvR8O4urol2k5gmclAHfnTg/XGbDFYEpg99Ks4lF9T8l5Si/CgrXTUGR0gyaoxpok+gNsuB9zzHdsvBiHt9kRe21SOPhHB2L60+Sobmy03YQbOBmFGE8O8Pmv6IO6O9SoGlSZYEWGiMQw2HVSfXey3+ky5rhlB01aUG6lTdJUWOnRSEgTxKuI79pLHZKoXfNDs9XKHEkEPLrLsjO/Bz33HcQsx0f6UcVeGrWBSr4VhWkYPNLLX8tb8fzbhDw9tX2Og6GtcbEXCv6yh/o8+z8RE2ewZllLiVJRzH2eAmTD7QQKg3Cs4RLxs10NXCenBcCVnR5P+WESUYkyDb1dlmRZ8T+BQUhh9nzkaF+vjXjauZp1weWOiICm6pwRBrYwu6KfQvfkpTrSlF6nwRVCYgAVXoEw3+7ztJ4DAY+qJGkpJkQSpXo/r1zzXHBhqNEPdKdn8SWqHCzz9xqiq8/TIDlYPj9f5SlAzsBQuBW3VdeXu428ud+a6plkRyaixQ1MZ6HPJc35ujVifhE49i7LrE1QK0+pAXe71jcgkvweHv2emLyCV6aYGUf0cyIeQjag+bltfr5m1qZzeN4L46xeccBwphschNWkrCXds/BjY6Tyu4MRQLjTSOoc+X+k7EtzbLw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(6916009)(7636003)(54906003)(508600001)(9786002)(356005)(83380400001)(8936002)(316002)(5660300002)(26005)(107886003)(2616005)(2906002)(70586007)(1076003)(186003)(70206006)(36860700001)(8676002)(47076005)(336012)(426003)(4326008)(40460700003)(6666004)(82310400005)(7696005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 06:25:31.6333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef5f96d-bd3d-474d-b299-08da47855b79
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8550
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

As part of unprepare_transfer_hardware, SPI controller will be disabled
which will indirectly deassert the CS line. This will create a problem
in some of the devices where message will be transferred with
cs_change flag set(CS should not be deasserted).
As per SPI controller implementation, if SPI controller is disabled then
all output enables are inactive and all pins are set to input mode which
means CS will go to default state high(deassert). This leads to an issue
when core explicitly ask not to deassert the CS (cs_change = 1). This
patch fix the above issue by checking the Slave select status bits from
configuration register before disabling the SPI.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
BRANCH: mtd/next
---
 drivers/spi/spi-cadence.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index b509eefe16a8..e832ae09e0cd 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -69,6 +69,7 @@
 #define CDNS_SPI_BAUD_DIV_SHIFT		3 /* Baud rate divisor shift in CR */
 #define CDNS_SPI_SS_SHIFT		10 /* Slave Select field shift in CR */
 #define CDNS_SPI_SS0			0x1 /* Slave Select zero */
+#define CDNS_SPI_NOSS			0x3C /* No Slave select */
 
 /*
  * SPI Interrupt Registers bit Masks
@@ -449,15 +450,20 @@ static int cdns_prepare_transfer_hardware(struct spi_master *master)
  * @master:	Pointer to the spi_master structure which provides
  *		information about the controller.
  *
- * This function disables the SPI master controller.
+ * This function disables the SPI master controller when no slave selected.
  *
  * Return:	0 always
  */
 static int cdns_unprepare_transfer_hardware(struct spi_master *master)
 {
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	u32 ctrl_reg;
 
-	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
+	/* Disable the SPI if slave is deselected */
+	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
+	ctrl_reg = (ctrl_reg & CDNS_SPI_CR_SSCTRL) >>  CDNS_SPI_SS_SHIFT;
+	if (ctrl_reg == CDNS_SPI_NOSS)
+		cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
 	return 0;
 }
-- 
2.17.1

