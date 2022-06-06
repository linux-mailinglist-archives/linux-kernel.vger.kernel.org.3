Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95953EA1C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiFFL0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiFFL0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:26:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0395112DBC5;
        Mon,  6 Jun 2022 04:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4vBQtp9Xw9ZKcVheCUk6g4D571irGG/gSlaXzDmUHsHR3ecYi8JyqE64NipAMh2VuKD7zApNauzN4GdWCqzLDlt9LxQhGZy27GMkQWfPoZ/2RbdsTNtGRiJraktLmiaR+MniuiHomBsz8wsegHjSNRRzd4KWGff3Nkqw7b8Y3DdvAZTVW4sCiGVPZvGxBdreTG1g0e/6NbgLhGbupdBKrHl76kWtkQzCkKaex5MMacr3RoAtihVfeayEQQ0W5EazNauhRkABLVZJ99GqKVmdcn3pzRUGFNPP9pJAjJoD/J/iIWA3F3lOcJ3gJRYWMlS3RyZEjk535+qbVtmnPgdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTw0GOAJ5U4D8/h4SvBhXXjOBPiraVH2nLE+I5hcXWQ=;
 b=IRYWIrCkZ83Wiy2EomqY6hZcb+9TbOiVAB8/o6i22wtox/TE9NW7h/W4+Lz4pewyUCtERw8jMXbgIGSIOFqENeisWNAzjcxzrzrA9LFP7oA1Xe+Lckw1NRTs1v2ysAq2AIH1ewil7IGUjc78xZP6KZFHAzhO/ceICDcd7fKn++2IGm4FTHne0Gnr5zOTGyDUtZb8tDtlo6OQBiI7vyoiz4MKYNwxDhhI1/Vcc8EIST9NTP9ZTCtnuzLo9Ztg3uJMIh2qzmbsSCQTTAEIImhb+V9ZTNUbgGQMTDqIn3l5nuOnWQx2ilENou6yj6hnVRI8WH0IcX6WZcM7IW7HVIG1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTw0GOAJ5U4D8/h4SvBhXXjOBPiraVH2nLE+I5hcXWQ=;
 b=NWZZ0PvuIBPZPCXPpnuOJ2YQSXhHBcdByMNqu/I4WFHnzwRF4NqnPDGGfHo1UPCZae1IPF7yzrvJ7vpATLP4WZ+I6SDjE6uWSOpCp8tE5/z7FZ8pbMX98K72tU4JwanmQxffv0eOO9L9PZy4qVOvycz9ADjXT9qERjRe0M9BmvE=
Received: from SN6PR16CA0041.namprd16.prod.outlook.com (2603:10b6:805:ca::18)
 by DM6PR02MB6137.namprd02.prod.outlook.com (2603:10b6:5:1d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Mon, 6 Jun
 2022 11:26:28 +0000
Received: from SN1NAM02FT0021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::2a) by SN6PR16CA0041.outlook.office365.com
 (2603:10b6:805:ca::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Mon, 6 Jun 2022 11:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0021.mail.protection.outlook.com (10.97.5.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 11:26:28 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 6 Jun 2022 04:26:26 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 6 Jun 2022 04:26:26 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 p.yadav@ti.com,
 miquel.raynal@bootlin.com,
 richard@nod.at,
 vigneshr@ti.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 michael@walle.cc,
 linux-mtd@lists.infradead.org
Received: from [10.140.6.18] (port=43350 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1nyAsM-0000SR-2B; Mon, 06 Jun 2022 04:26:26 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <p.yadav@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <git@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RFC PATCH 2/2] mtd: spi-nor: Add support for stacked/parallel memories
Date:   Mon, 6 Jun 2022 16:56:07 +0530
Message-ID: <20220606112607.20800-3-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
References: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae01345c-a822-463d-a509-08da47af65fc
X-MS-TrafficTypeDiagnostic: DM6PR02MB6137:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB61370E484CA7B7646B381ADDBAA29@DM6PR02MB6137.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xz0wtkHYcID9lGKG1VNxbOFnvIbY0AkeXAf1nMBgexNoywbd6WvT6HQlNhlCOsneePRA/jVlEFDMRC+nZNj4Awqtk+uop/4Q4/dn2eXKmOkWMdIo56GdddpjYe2H1b7IiYVVM+7aE9cIP9t4ZnoJS3DugwuLET5NdLRKfyr7y7jZjlvefS1t3YJabZyFF13LkutPDI/1Zg873v+fvjoRNqB8u1+ZQ2LP/qFbTlGtuwuJ4o3xOB9uHrWp5tL8Po4B3gUS8lq3ymV5JMICTc7KF8ThD6UfG9OXUrL8g+GoIS/0qqlvtkuHDlN0V/7HRf7797cZaax4X6H2bG77NnIkhVDYP0A+AZXB1cHbv74Iq85xaOz/TcF7C1C0QgTfhkMLKDq0xTNN/7knX3uugTHiZ+68Wu7uIH+bX8FRTVRGwKPdxrCS3xFpD4QvQJtGBIHfDd1IjKTuo9aCbvlG7/JDzIdFh+hq2LO53a6Vajv1BUvQvMqPQyeuJ3bEfyGasxUMFtIXbB7upK2uWufPonYGesBxtFCRjqq+kkB4RzzHQLqnmxVad9r6ocxpZjuUvi8OCxiRctWHCf6k6TL2XUS+MAIl5kW2UPEa7GVhn5QJvVF0LVxd8dMb+rR2sgr6EX1j1dZGdSnG3ikg5oZ61N79w9Djr3j4y+ltcjQIlOQBdv91Ewc5maAnaHyV5O8Nd7ntc5etxCM4W47SsRsG/4quug==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(36860700001)(110136005)(83380400001)(40460700003)(70586007)(8676002)(54906003)(26005)(70206006)(9786002)(8936002)(356005)(7636003)(5660300002)(508600001)(7416002)(47076005)(4326008)(426003)(2906002)(186003)(2616005)(6666004)(107886003)(316002)(82310400005)(1076003)(7696005)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 11:26:28.1470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae01345c-a822-463d-a509-08da47af65fc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6137
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While initializing the flash parameter structure, size of each flash is
updated with the values coming from "stacked-memories" and
"parallel-memories" DT properties.

Two new nor->flags (SNOR_F_HAS_STACKED and SNOR_F_HAS_PARALLEL) are added
to distinguish between the stacked and parallel configuration.

In parallel configuration all the operations need to be performed on both
the flashes simultaneously, So during each operation SPI-NOR needs to set
0th bit(CS0) & 1st bit(CS1) in nor->spimem->spi->cs_index_mask. The GQSPI
driver will then assert CS0 & CS1.

In stacked configuration the SPI-NOR, with individual flash size information,
will determining the flash on which the operation need to be performed and
it will set the appropriate CS bit in nor->spimem->spi->cs_index_mask.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/mtd/spi-nor/core.c  | 104 +++++++++++++++++++++++++++++++-----
 drivers/mtd/spi-nor/core.h  |   5 ++
 include/linux/mtd/spi-nor.h |   8 ++-
 3 files changed, 104 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 502967c76c5f..5d9bbb28659a 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2463,6 +2463,9 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
  */
 static void spi_nor_late_init_params(struct spi_nor *nor)
 {
+	struct device_node *np = spi_nor_get_flash_node(nor);
+	u64 flash_size[SNOR_FLASH_CNT_MAX];
+
 	if (nor->manufacturer && nor->manufacturer->fixups &&
 	    nor->manufacturer->fixups->late_init)
 		nor->manufacturer->fixups->late_init(nor);
@@ -2479,6 +2482,27 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 	 */
 	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
 		spi_nor_init_default_locking_ops(nor);
+
+	/*
+	 * The flashes that are connected in stacked mode should be of same make.
+	 * Except the flash size all other properties are identical for all the
+	 * flashes connected in stacked mode.
+	 * The flashes that are connected in parallel mode should be identical.
+	 */
+	if (!of_property_read_u64_array(np, "stacked-memories", &flash_size[0], SNOR_FLASH_CNT_MAX)) {
+		nor->flags |= SNOR_F_HAS_STACKED;
+	} else if (!of_property_read_u64_array(np, "parallel-memories", &flash_size[0], SNOR_FLASH_CNT_MAX)){
+		nor->flags |= SNOR_F_HAS_PARALLEL;
+	}
+
+	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
+		nor->params[1] = devm_kzalloc(nor->dev, sizeof(*nor->params[0]), GFP_KERNEL);
+		if (!nor->params[1])
+			return -ENOMEM;
+		memcpy(nor->params[1], nor->params[0], sizeof(*nor->params[0]));
+		nor->params[1]->size = flash_size[1];
+	}
+	return 0;
 }
 
 /**
@@ -2614,8 +2638,8 @@ static int spi_nor_init_params(struct spi_nor *nor)
 {
 	int ret;
 
-	nor->params = devm_kzalloc(nor->dev, sizeof(*nor->params), GFP_KERNEL);
-	if (!nor->params)
+	nor->params[0] = devm_kzalloc(nor->dev, sizeof(*nor->params[0]), GFP_KERNEL);
+	if (!nor->params[0])
 		return -ENOMEM;
 
 	spi_nor_init_default_params(nor);
@@ -2677,19 +2701,51 @@ static int spi_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
  */
 static int spi_nor_quad_enable(struct spi_nor *nor)
 {
-	if (!nor->params->quad_enable)
-		return 0;
+	u8 idx;
+	int err;
 
-	if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
-	      spi_nor_get_protocol_width(nor->write_proto) == 4))
-		return 0;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		if (!nor->params[0]->quad_enable)
+			return 0;
 
-	return nor->params->quad_enable(nor);
+		if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
+		    spi_nor_get_protocol_width(nor->write_proto) == 4))
+			return 0;
+		/*
+		 * In parallel mode both chip selects i.e., CS0 &
+		 * CS1 need to be asserted simulatneously.
+		 */
+		 nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_BOTH_CS;
+		err = nor->params[0]->quad_enable(nor);
+	} else {
+		for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
+			if (nor->params[idx] != NULL) {
+
+				if (!nor->params[idx]->quad_enable)
+					return 0;
+
+				if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
+				    spi_nor_get_protocol_width(nor->write_proto) == 4))
+					return 0;
+
+				/*
+				 * Set the appropriate CS index before
+				 * issuing the command.
+				 */
+				nor->spimem->spi->cs_index_mask = 0x01 << idx;
+				err = nor->params[idx]->quad_enable(nor);
+				if (err)
+					return err;
+			}
+		}
+	}
+	return err;
 }
 
 static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
+	int idx;
 
 	err = spi_nor_octal_dtr_enable(nor, true);
 	if (err) {
@@ -2730,7 +2786,25 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		nor->params->set_4byte_addr_mode(nor, true);
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			/*
+			 * In parallel mode both chip selects i.e., CS0 &
+			 * CS1 need to be asserted simulatneously.
+			 */
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_BOTH_CS;
+			nor->params[0]->set_4byte_addr_mode(nor, true);
+		} else {
+			for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
+				if (nor->params[idx] != NULL) {
+					/*
+					 * Select the appropriate CS index before
+					 * issuing the command.
+					 */
+					nor->spimem->spi->cs_index_mask = 0x01 << idx;
+					nor->params[idx]->set_4byte_addr_mode(nor, true);
+				}
+			}
+		}
 	}
 
 	return 0;
@@ -2913,6 +2987,8 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 {
 	struct mtd_info *mtd = &nor->mtd;
 	struct device *dev = nor->dev;
+	u64 total_sz =0;
+	int idx;
 
 	spi_nor_set_mtd_locking_ops(nor);
 	spi_nor_set_mtd_otp_ops(nor);
@@ -2926,9 +3002,13 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 		mtd->flags |= MTD_NO_ERASE;
 	else
 		mtd->_erase = spi_nor_erase;
-	mtd->writesize = nor->params->writesize;
-	mtd->writebufsize = nor->params->page_size;
-	mtd->size = nor->params->size;
+	mtd->writesize = nor->params[0]->writesize;
+	mtd->writebufsize = nor->params[0]->page_size;
+	for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
+		if (nor->params[idx] != NULL)
+			total_sz += nor->params[idx]->size;
+	}
+	mtd->size = total_sz;
 	mtd->_read = spi_nor_read;
 	/* Might be already set by some SST flashes. */
 	if (!mtd->_write)
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 3f841ec36e56..4e8bf3cbe331 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -11,6 +11,9 @@
 
 #define SPI_NOR_MAX_ID_LEN	6
 
+/* In parallel configuration enable both CS */
+#define SPI_NOR_ENABLE_BOTH_CS	(BIT(0) | BIT(1))
+
 /* Standard SPI NOR flash operations. */
 #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 0),			\
@@ -130,6 +133,8 @@ enum spi_nor_option_flags {
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(11),
 	SNOR_F_SOFT_RESET	= BIT(12),
 	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
+	SNOR_F_HAS_STACKED	= BIT(14),
+	SNOR_F_HAS_PARALLEL	= BIT(15),
 };
 
 struct spi_nor_read_command {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 1ede4c89805a..40800e7235ee 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -128,6 +128,12 @@
 #define SR2_LB3			BIT(5)	/* Security Register Lock Bit 3 */
 #define SR2_QUAD_EN_BIT7	BIT(7)
 
+/*
+ * Maximum number of flashes that can be connected
+ * in stacked/parallel configuration
+ */
+#define	SNOR_FLASH_CNT_MAX	2
+
 /* Supported SPI protocols */
 #define SNOR_PROTO_INST_MASK	GENMASK(23, 16)
 #define SNOR_PROTO_INST_SHIFT	16
@@ -397,7 +403,7 @@ struct spi_nor {
 
 	const struct spi_nor_controller_ops *controller_ops;
 
-	struct spi_nor_flash_parameter *params;
+	struct spi_nor_flash_parameter *params[SNOR_FLASH_CNT_MAX];
 
 	struct {
 		struct spi_mem_dirmap_desc *rdesc;
-- 
2.17.1

