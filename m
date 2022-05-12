Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197D05250C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355663AbiELO6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355657AbiELO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:58:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA515DD1A;
        Thu, 12 May 2022 07:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9os5EzGtZAuOcpPUd8HoU7n1vLmWHGLRUXARM703cbC7UlKzUJmBTf2+enNkU21DBCi/gKfPtPnOVrUCoNmQU9u8IYLlUo57mmqNFNJoPzwwMy3LkEtyLlvRY6MQyIlU9SkvY1S9qNzIJZVq7GPiSv4ALy7up0JSwNC/n3vn1H5slLXQ3sAmkm3hA5AKGG7zs+3xXvMO6+ZEYmevG2iSUP6ul4lLlOnLDdrLgq+R4UYUkXQgjWB4XFKVLdf6xEFYE5OCeKnEBgzvLYhKuWv5aMCeZxclptVszjGSIiKOi5hiEqqfWNz8K7Tg1o8q8Q2iWRbZpsrER5MOdqA1UEnIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNy41tQCDBbdlakHQNi2dRFqe8lrnP3TzPVJ9fgtrwA=;
 b=fxS5oiumyf2yXUC4aiY07cV+ukOBy/GhQnGMRt6lOvEJqRdvoUVzZcs+WFNcozyMNZ4N+d542EqgWj8JBwSMWOOjntK5gk8bfavEJS4hRuiHfy+4ymSDzD5NHvILybugmWZo+m9Fa0Cu3MpMXmbTLKraXzN2yW9k6jB1SaKw8a3kzDb6o3KUPyeHyFY0R8ck8derCKFkb4Vgnr5PF7s1XBBMyDBEjmfpzLaNXxiFODhdQbQaqd+69Ce/liWN8I3P/GNGRyA2454q+47vvpWT2GpD8gLGX6v3tpaFIW6k9wVUDZs/xgAMZuDqYpHFEHJ6zKJS383Jeh5qcMlWXEvA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNy41tQCDBbdlakHQNi2dRFqe8lrnP3TzPVJ9fgtrwA=;
 b=kXKaEXg3S7rVvOqS6uWMFPZCzzQGuyR6wkKmy0HgxUoNfppcw7lhJe0GOSkJtsGx632EawjFHUsqXWTjkBWpF2yK4lGlv5vwmMcAetkv2FFVyD9evNFnsmC5CmoG5DEw5KhE7L8YnA+pdt9PG0gwTv8bXlsBYbOgsILGT2ZxPNs=
Received: from SA9PR13CA0173.namprd13.prod.outlook.com (2603:10b6:806:28::28)
 by SN1PR02MB3887.namprd02.prod.outlook.com (2603:10b6:802:30::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 14:58:27 +0000
Received: from SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:28:cafe::74) by SA9PR13CA0173.outlook.office365.com
 (2603:10b6:806:28::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 14:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0034.mail.protection.outlook.com (10.97.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 14:58:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 12 May 2022 07:58:26 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 12 May 2022 07:58:26 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=54504 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1npAGo-0008kD-0P; Thu, 12 May 2022 07:58:26 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <michal.simek@xilinx.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH] spi: spi-zynqmp-gqspi: Add two chip select support
Date:   Thu, 12 May 2022 20:28:20 +0530
Message-ID: <20220512145820.20425-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42e68ffa-29a0-4e0a-2f26-08da3427df25
X-MS-TrafficTypeDiagnostic: SN1PR02MB3887:EE_
X-Microsoft-Antispam-PRVS: <SN1PR02MB3887D91E2914D1704C07CBA8BACB9@SN1PR02MB3887.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vlI9z4G4TenbQPNhT+f1wWxnYBYiIKXgpBPv7yemu2Ohd0MzF4zi58IgV7foi5ISTehlRpuvXAIufIzNkdbOWCphsmoT+CPzkzEaU5NPT2FmPMahDKnQi1nyH1C/1Cg2upeP3UVuFZUQMWbuutaA8Bg7uBVKMteWpEPw7H8zHKbFDLqRhIsleVNjpqOYmZlzoD5GnJqbwo6/Y1+D8A9cb1ePFe/PXzdnWtJqOIy61b2x0VcPkuLNqHijpixXCjp/9ZsWXJDphzcFijCxWwlgEqYf3+PX6te/xZqLVYQviHtNVT8XjuhcJHB+/An7tNmHqGENGDCmBUf2ViB8Yw8MDcMA2qHi1Tsl/FqBxRjIW/+2VsI77YqYfLoIQsZRNorZp7ebTULLWikaZLWypeccElDo8eSY/6AGmeU+YZSmPqK3ZBfcCmLd1gKJ1ndM+IkiJZnYKkD5qkN+kZ6sPRIskFyFCw8BNGbl4KF+Am0MQk6e1ROCCsnQD2z7Zc4zGWO9MJvIGy+uGKVCL8SefUy2Cnga7fyxyzMadppuhDXIVucjBXatXaX7gseHsQdEp9Qi4if1e7bNKadxmux7vSzadtY1E0cW4gY/64jKa2SsseVJZSX2/T72xJGOE+aKn+V1H8PYCpJ4YYhWfMlgorSQrlMNnOlqDm51/LZ2h72jGLnNE+AXBlvda4yIHe+GLNLgkNdRSOMm3g9NtI5o8LNbw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(2616005)(1076003)(82310400005)(5660300002)(6666004)(36756003)(26005)(9786002)(83380400001)(8936002)(107886003)(70206006)(47076005)(70586007)(316002)(508600001)(426003)(4326008)(54906003)(8676002)(336012)(6916009)(7636003)(40460700003)(2906002)(186003)(7696005)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 14:58:27.7690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e68ffa-29a0-4e0a-2f26-08da3427df25
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3887
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP GQSPI controller can support up to two chip selects but the current
GQSPI driver only support CS0. With this update and num-cs DT property set
to 2 GQSPI driver can now support two slave devices each connected to one
chip select.

GQSPI driver configures the Lower CS and Upper CS based on the reg DT
property.

Changes tested on ZynqMP board with two SPI-NOR flashes each connected
to a different CS.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
BRANCH: mtd/next
---
 drivers/spi/spi-zynqmp-gqspi.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 2b5afae8ff7f..c760aac070e5 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -134,6 +134,8 @@
 #define GQSPI_DMA_UNALIGN		0x3
 #define GQSPI_DEFAULT_NUM_CS	1	/* Default number of chip selects */
 
+#define GQSPI_MAX_NUM_CS	2	/* Maximum number of chip selects */
+
 #define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
@@ -363,8 +365,13 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 	genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
 
 	if (!is_high) {
-		xqspi->genfifobus = GQSPI_GENFIFO_BUS_LOWER;
-		xqspi->genfifocs = GQSPI_GENFIFO_CS_LOWER;
+		if (!qspi->chip_select) {
+			xqspi->genfifobus = GQSPI_GENFIFO_BUS_LOWER;
+			xqspi->genfifocs = GQSPI_GENFIFO_CS_LOWER;
+		} else {
+			xqspi->genfifobus = GQSPI_GENFIFO_BUS_UPPER;
+			xqspi->genfifocs = GQSPI_GENFIFO_CS_UPPER;
+		}
 		genfifoentry |= xqspi->genfifobus;
 		genfifoentry |= xqspi->genfifocs;
 		genfifoentry |= GQSPI_GENFIFO_CS_SETUP;
@@ -1099,6 +1106,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	struct zynqmp_qspi *xqspi;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	u32 num_cs;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
 	if (!ctlr)
@@ -1176,8 +1184,19 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto clk_dis_all;
 
+	ret = of_property_read_u32(np, "num-cs", &num_cs);
+	if (ret < 0) {
+		ctlr->num_chipselect = GQSPI_DEFAULT_NUM_CS;
+	} else if (num_cs > GQSPI_MAX_NUM_CS) {
+		ret = -EINVAL;
+		dev_err(&pdev->dev, "only %d chip selects are available\n",
+			GQSPI_MAX_NUM_CS);
+		goto clk_dis_all;
+	} else {
+		ctlr->num_chipselect = num_cs;
+	}
+
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-	ctlr->num_chipselect = GQSPI_DEFAULT_NUM_CS;
 	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
 	ctlr->setup = zynqmp_qspi_setup_op;
 	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
-- 
2.17.1

