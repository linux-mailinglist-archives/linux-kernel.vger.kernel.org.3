Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A775A45BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiH2JH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiH2JHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:07:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290225A3E0;
        Mon, 29 Aug 2022 02:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7E31BTVROVBkKuFghetz0LsruS56JBY7bMaj97RghYOYpCOC/U9uYf+cSSTf1M0tm2p5Iv6JmnL35xxMbONNiI4L/aQv38X/Elmed/eu7ANHyeSHlw+QxbHbO2lHgmPxDTjVgjcVkDMS1/qcKudZAVHho4pw+jKBYkNbjAlk60cRXRflqBU9THPZ7xjlP/ZSI8XfZn9+PN1plT8Td8CYLH6avXQk3B203xcavAmPRZ8V0Kas21K7YMCPICiu71gxUdLWRwoAmmxsey8Bq735BYodDns7IKmsRY26KUjDSoQ4yHKVBhP2o7yZQogucuiHwGHfK65SBgwPRSjbTbpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iricBOBzoY1WwMW7yzfbWUiI0VpUxM2vxiZEsNYkp9M=;
 b=F6xd5TzSqCpRfKB9N1wx97OQ3uERWTf3UdyMk9nD3CIGWx9o5dbuHmyWeoj68jXm50Rm+MOp67HPqEVpwlTKoaJE/DTMVnVM8ZJwVNpznICsf5nXh0AzdSxc9b7o8b9TD1fj0bUDGJXR0VCK3La1sAWuI+GyZSni8j/vbUn/Cq9z05bXnoqVzDX1bg+aWoIQs+iPijOGvepD5wm61K+M7fUzcWuOHrLcTAzuu04MwhVwRc/ghz1W/yFdO0S29NlJNz8BiCY38Q0GXRmwI163c1h5hXSf6KTauIri4rXMPr8NRacqYNr0CTxi+kjshcQbQaVSjFovkYHCpnk/255fTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iricBOBzoY1WwMW7yzfbWUiI0VpUxM2vxiZEsNYkp9M=;
 b=icQWxCyNBYResEsf+JjSdDrjMz/vAvMMXGC3tUb/j41DUxGtE6e41q7kVBNQVuuRjv57F6tNa68tKgXMoRiDaJ6ospfzsoPsUaGtx4qYX9vOnY/b3AKNMs+qGgmUao1rJXlLEARw9FFQ/V0rBbeniAeBHpnf7/OxIw0tMzPgJZg=
Received: from DS7PR05CA0094.namprd05.prod.outlook.com (2603:10b6:8:56::11) by
 BN8PR12MB3249.namprd12.prod.outlook.com (2603:10b6:408:68::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.16; Mon, 29 Aug 2022 09:07:48 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::cc) by DS7PR05CA0094.outlook.office365.com
 (2603:10b6:8:56::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Mon, 29 Aug 2022 09:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 09:07:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 04:07:47 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 29 Aug 2022 04:07:43 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <saikrishna12468@gmail.com>,
        <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 2/2] mtd: spi-nor: Add support for flash reset
Date:   Mon, 29 Aug 2022 14:35:28 +0530
Message-ID: <20220829090528.21613-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220829090528.21613-1-sai.krishna.potthuri@amd.com>
References: <20220829090528.21613-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ba322f8-e52a-4681-12a9-08da899df1c0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3249:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBHtZNfU7BzSCtxmWKobxvFpCJ/jPTKZpJKfXYp2+HEY+X9kyZX5XyOLUooCGxBnK27IyvWuwcUugeBtf+tOHPKoKhYRlbojLKmoSGAX6qM1Uw5WqipTQMi0eRWZoSXSiznT9X8IsiM4LX6WbF1LhS9tE9A/16X2zigROD8FP6SjhlQcvSY9mGn9mAr/njTtFFyiWxmy+w9xswYkAvSM1hwZYv/QLbfcHZkHlzxMaNv731mLt2vMLESpePOtC/CRbhI0EaLE9jG3JtWZTB/sBUdbuOei22GVbYGIboUe/4kMllBiPj66/BaCxs5/i9bH2/uqmmufVwg269IKcOpQRDsgmHMoA0SCs6j9tHBDqSr5X8CZWgw9CpV3IaX/1WqOSoT7dQqLh9D9vtOrXk+OgyA8gLbB/L+Ut+ZZdzOnMKYbtT0Q7Yffhyni9kjp336SRGoOIuFuY3NXy3gMK4Im4tIGjxT9bgMci2uLlzy6/UCt9CpE1atGNBRHJThzVeFLbluurOFsi9Z9gh1lkFsNHt+ujxGvAsk9Oqo0lfUtLyFElg2fJ+o1YglXH3+NhtCY51RcwzmY3KSLarQ14g0oz/2qO07BOHb4HaUf9cHhYswj6AtdxSzV8SN6fLg9nshVqJd/gVUANyrliyciTJpJDiMkGNal4K0aMbrGr+bi5RpLzH/n1CyMIErWqr6f66xDOZR68Z2wIxpM/5owpYXfQXlirIkGgMt9ommzJjE66VDdN6iSuBR2mx9czzYWahiYLUhWJoXwFzj/7ytc/FVFjPtG2D9jKisxAodyv84V7taSzRiHDXXG58hcbCcS/Aik
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(40470700004)(46966006)(36840700001)(7416002)(86362001)(70206006)(26005)(82310400005)(478600001)(6666004)(41300700001)(336012)(186003)(82740400003)(356005)(40480700001)(40460700003)(81166007)(83380400001)(1076003)(426003)(2616005)(47076005)(36860700001)(110136005)(5660300002)(8676002)(8936002)(4326008)(54906003)(2906002)(36756003)(316002)(103116003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 09:07:48.4176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba322f8-e52a-4681-12a9-08da899df1c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for spi-nor flash reset via GPIO controller by reading the
reset-gpio property. If there is a valid GPIO specifier then reset will
be performed by asserting and deasserting the GPIO using gpiod APIs
otherwise it will not perform any operation.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/mtd/spi-nor/core.c | 50 +++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f2c64006f8d7..d4703ff69ad0 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2401,12 +2401,8 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
  */
 static void spi_nor_init_flags(struct spi_nor *nor)
 {
-	struct device_node *np = spi_nor_get_flash_node(nor);
 	const u16 flags = nor->info->flags;
 
-	if (of_property_read_bool(np, "broken-flash-reset"))
-		nor->flags |= SNOR_F_BROKEN_RESET;
-
 	if (flags & SPI_NOR_SWP_IS_VOLATILE)
 		nor->flags |= SNOR_F_SWP_IS_VOLATILE;
 
@@ -2933,9 +2929,47 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 	mtd->_put_device = spi_nor_put_device;
 }
 
+static int spi_nor_hw_reset(struct spi_nor *nor)
+{
+	struct gpio_desc *reset;
+	int ret;
+
+	reset = devm_gpiod_get_optional(nor->dev, "reset", GPIOD_ASIS);
+	if (IS_ERR_OR_NULL(reset))
+		return PTR_ERR_OR_ZERO(reset);
+
+	/* Set the direction as output and enable the output */
+	ret = gpiod_direction_output(reset, 1);
+	if (ret)
+		return ret;
+
+	/*
+	 * Experimental Minimum Chip select high to Reset delay value
+	 * based on the flash device spec.
+	 */
+	usleep_range(1, 5);
+	gpiod_set_value(reset, 0);
+
+	/*
+	 * Experimental Minimum Reset pulse width value based on the
+	 * flash device spec.
+	 */
+	usleep_range(10, 15);
+	gpiod_set_value(reset, 1);
+
+	/*
+	 * Experimental Minimum Reset recovery delay value based on the
+	 * flash device spec.
+	 */
+	usleep_range(35, 40);
+
+	return 0;
+}
+
 int spi_nor_scan(struct spi_nor *nor, const char *name,
 		 const struct spi_nor_hwcaps *hwcaps)
 {
+	struct device_node *np = spi_nor_get_flash_node(nor);
 	const struct flash_info *info;
 	struct device *dev = nor->dev;
 	struct mtd_info *mtd = &nor->mtd;
@@ -2965,6 +2999,14 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (!nor->bouncebuf)
 		return -ENOMEM;
 
+	if (of_property_read_bool(np, "broken-flash-reset")) {
+		nor->flags |= SNOR_F_BROKEN_RESET;
+	} else {
+		ret = spi_nor_hw_reset(nor);
+		if (ret)
+			return ret;
+	}
+
 	info = spi_nor_get_flash_info(nor, name);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
-- 
2.17.1

