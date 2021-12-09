Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED2746E647
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhLIKMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:12:00 -0500
Received: from mail-vi1eur05on2122.outbound.protection.outlook.com ([40.107.21.122]:58784
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232951AbhLIKL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:11:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/Se2dVX/BPPafKqbW5tvC3UvFyGB7791LYPXDQfafsiCHFJ2t3JO1C2fmGDH8tfpjRESqEuHiPlF5uhh9wwjqjVOyf33NZRErvgCLWSzaVy2gSQs0h7IrOtiZ53MLnhnZxLDmC8g+BPYKBlK2ZnLPtzAFd7JXU8tHwKSR8sRJaRq85bCnuws15WgMmxKcUr3AUSS3f+lCnPjnIj6jFebzKUSVTP22EiSiOmE/Ubj1BbqGZWPfopG7yH6DmRTf7ecGKKDKo6x9/Wo1AnrX6HW9yRCgjQspPhFrRDNhed5cT3v83w5lrqNlNbLH36e5HB4IWnsdPoONpMOEzbdc4Zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9/ad6WY8keWTZzt3EuyWxwhErr+3x6Zpt734Zu3ICk=;
 b=U9sqNf4rCREHUiqUlqSzA/Jqw+8YdGA27eoAkyVA+wPrEShzaD0H/8CWbcWPgCoW4hdtrQT3x2KFM4tvXotsOd77UeO0rfmgyZUZpCb09jcWYwLwcpGh9Nmb9t0FvoFUjGYyFHQM+2y0ymjeL/Ph4wjqOexkxgHigFN+5hcw9Lu2aXaed+0KUVVTmLKP6PZDikiLASxcg4uft/RSVvenyoV4WnbXOLr7RGgFO7NEssCwfoT3TmBJheSDZT64UuFurji+GepLZejJB4uF81go0S7Kf+pfj4MARlaJ+y3F9osp2m5jwKPDO/3B1YoSJWTAIEkO0U/9EIl5DywK5onHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9/ad6WY8keWTZzt3EuyWxwhErr+3x6Zpt734Zu3ICk=;
 b=FsTNqdcY6N62bBV/sjrZ/a+rdAK+kMpp1ZpDjeF/n25pHQiGtgb8NjYdkhutV0o8utr4CaEpLVsbI3tGDUfi91d/HGKrGmHY87kikjbGdX1R8C1OiYw48y+MQWbwcQySJIRXqCbmLECpYlq2/pBnbhSmW2AefZTAdgNEiWbDfJg=
Received: from DB8PR03CA0021.eurprd03.prod.outlook.com (2603:10a6:10:be::34)
 by PR3PR07MB8210.eurprd07.prod.outlook.com (2603:10a6:102:175::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.5; Thu, 9 Dec
 2021 10:08:20 +0000
Received: from DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::8b) by DB8PR03CA0021.outlook.office365.com
 (2603:10a6:10:be::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend
 Transport; Thu, 9 Dec 2021 10:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DB5EUR03FT023.mail.protection.outlook.com (10.152.20.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Thu, 9 Dec 2021 10:08:20 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 1B9A8HIY012620;
        Thu, 9 Dec 2021 10:08:17 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mtd@lists.infradead.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: spi-nor: Introduce erase_proto
Date:   Thu,  9 Dec 2021 11:08:12 +0100
Message-Id: <20211209100813.61713-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 347b749c-9f70-4d0e-b966-08d9bafbd3fb
X-MS-TrafficTypeDiagnostic: PR3PR07MB8210:
X-Microsoft-Antispam-PRVS: <PR3PR07MB82105DC10C85A10E3FE7711588709@PR3PR07MB8210.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XEpVU80b7RNx8A+Te7emiq8w71GG6Mr1HevddWPtjC+MFmEDjmKTbE4F/vJ1uMgcuSnkZtJTaBO01Qr2P/jylX7BclxfCbZylcNj75GhFMiCT38M2G/ri487Y5mDzpyIF9CELw6mVyw6ZMFM8H4bUvqxOXo6Kdic6TSYuETPu1McSg0HIFDU25nGVllFPcBHfdX5yWUtn1xsWuevEOfq01yTAR+vJqswhUnh1saEhTNckIdnPcDRnoq+dQU2SaVLXl6dLQSQ1ZpkX67nwmbdoTdPbwIvra1e3/7Nm+2rSOMcXE2kw1oRwMRtDyJSBZRnQnM3eA0jzvDnVUrXFfgD5zZS7z5VKsfxs+M8MHLdAeY890jYliRn5f8tlv+WlT+vQcQcez0PHNHCyZzcJcxqCtit46pBhISJhdM/+O+TXfRL1llNy2jr26EN+yFl4ZR3+F9tL5XHri5vGqwPaF9/oI5iTj0YJgDWK+yl007yflFZE/aHZMFTe2FJChbAlOW7uQ4l0Q+oocE7mDtpo/ql0QGZXNBr6IvvH5EgzIUkAoZMzlTsl0Gd/XAMEBdazbMLzHuXolkIfCmFwouqLTcxqQNnFq18OjaevetSQGYZOSHkH7MT4ROcI2812ZXl74r3hq3IxD2mvI/RlIRcazloouMQwc7GXvmdJPcFTW714KXNUTTJAo44NzaEE8XWOeJ4JDuf9WRiU3iYAysPuIORuOB7bCzB/gKqDhzCZ054pib3pEYOnMAUbOhZIlWyz+ynFa6IOUfphPXkQs7lpEdc5DuWbYtPH6w0ucQWKbvCs7Q=
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(186003)(336012)(5660300002)(54906003)(6916009)(2616005)(70586007)(316002)(6666004)(2906002)(1076003)(70206006)(47076005)(36860700001)(8676002)(82960400001)(4326008)(82310400004)(36756003)(40460700001)(86362001)(26005)(356005)(508600001)(81166007)(8936002)(83380400001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 10:08:20.4589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347b749c-9f70-4d0e-b966-08d9bafbd3fb
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8210
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

I've been looking into non-working erase on mt25qu256a and pinpointed it to
be write_proto 1-4-4 selected from SFDP while the chip only supports 1-1-0
erase.

For now just introduce the separate protocol without functional change and
leave the real fix for the following patch.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/mtd/spi-nor/core.c  | 9 ++++++---
 include/linux/mtd/spi-nor.h | 4 +++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 2e21d5a..dcd02ea 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -177,7 +177,7 @@ static int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
 
 static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 {
-	if (spi_nor_protocol_is_dtr(nor->write_proto))
+	if (spi_nor_protocol_is_dtr(nor->erase_proto))
 		return -EOPNOTSUPP;
 
 	return nor->controller_ops->erase(nor, offs);
@@ -1186,7 +1186,7 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
-		spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
+		spi_nor_spimem_setup_op(nor, &op, nor->erase_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
@@ -1331,7 +1331,7 @@ int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
-		spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
+		spi_nor_spimem_setup_op(nor, &op, nor->erase_proto);
 
 		return spi_mem_exec_op(nor->spimem, &op);
 	} else if (nor->controller_ops->erase) {
@@ -2727,6 +2727,9 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 	 */
 	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
 		spi_nor_init_default_locking_ops(nor);
+
+	if (!nor->erase_proto)
+		nor->erase_proto = nor->write_proto;
 }
 
 /**
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index fc90fce..23a901b 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -381,7 +381,8 @@ struct spi_nor_flash_parameter;
  * @cmd_ext_type:	the command opcode extension type for DTR mode.
  * @read_proto:		the SPI protocol for read operations
  * @write_proto:	the SPI protocol for write operations
- * @reg_proto:		the SPI protocol for read_reg/write_reg/erase operations
+ * @reg_proto:		the SPI protocol for read_reg/write_reg operations
+ * @erase_proto:	the SPI protocol for erase operations
  * @sfdp:		the SFDP data of the flash
  * @controller_ops:	SPI NOR controller driver specific operations.
  * @params:		[FLASH-SPECIFIC] SPI NOR flash parameters and settings.
@@ -408,6 +409,7 @@ struct spi_nor {
 	enum spi_nor_protocol	read_proto;
 	enum spi_nor_protocol	write_proto;
 	enum spi_nor_protocol	reg_proto;
+	enum spi_nor_protocol	erase_proto;
 	bool			sst_write_second;
 	u32			flags;
 	enum spi_nor_cmd_ext	cmd_ext_type;
-- 
2.10.2

