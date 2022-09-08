Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E95B150C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiIHGrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiIHGrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:47:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2056.outbound.protection.outlook.com [40.107.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41035D2905;
        Wed,  7 Sep 2022 23:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceSyAX1h3ctul7XjSGxxsKdypivZgB4DbY8x1INBTA7yBW9mjtCGGCwbCSbbpPDDlYcKAKgTFqj46rMtPU9Sma4vxEMZzdZwQmmPjIgW8E+We3dcAmzZsBlTj+1WhyJ6l0hiLlPBy8GBjM9dGxeAybupgkvW7sMMOVHDw66BZH6lmrHQNux8U3N6L/dTVRZuPTlw7wi3uYP1jTufMtTe75xDc0pvHInVeel/n5WHeEb/0KDZhwR2eY0Jw9TXeXdhLL+mARYxJJorLp9dQpWk2uy8DB7nGoPKPjDQIbVmNi0NzJqWpneGQUobJC7pVJgNbr0qpKe1FTuvHaYEn7nsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F182Zqhi0qv226zU0R4UFPD8MwTnUo++qTwERxPY6dk=;
 b=WgBEmcs5tpBXzr2hP1+puh6PozZooph2AVZSCLUpd1+vUZhG3q/eNAsor5iDTaOlcQviMi7MsswLg9lT5Lber5TFzNRNPK2dXzawe2kIuGPTs1+OrMWARIZCrqItfpJMQPkZaOcnw/nfD32UXyx5UplcU/fzwMWvpmt8OP++zgBJwqjusuvevI1Tm5S1nEmNlOkbGFHT7LkmWA5lP78R6lklUnl8i6iZmDHOYz4dagM8L3n9ypugFOzwbUPYaTJHQcT3zR+A0YWr5Kk8EcONFVztuw4R8XhkGvDmNIKC288KKFh9N7O8ffIuJYxZZeHR36+fLZ5sdJQvQDihOr6l2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F182Zqhi0qv226zU0R4UFPD8MwTnUo++qTwERxPY6dk=;
 b=Uw/mxfwHWgWdIsSR/nKyP02ndD1KY9BtdIjTYUlpxh+1XNEiYI4bRppbU6XOSoeY7YxJB+/jE3UcPD/xw2sgj4Yp/V9+BGSKuXOD5G3Drgl4hANh+fpqfjnSsS1STphSVPlKdiSkzBvMESRxmGRAVnIPYL9J4Q8WzVuUM8UHwI8=
Received: from MW2PR2101CA0016.namprd21.prod.outlook.com (2603:10b6:302:1::29)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 06:47:26 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::a7) by MW2PR2101CA0016.outlook.office365.com
 (2603:10b6:302:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.6 via Frontend
 Transport; Thu, 8 Sep 2022 06:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 06:47:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 01:47:20 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 8 Sep 2022 01:47:16 -0500
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
Subject: [PATCH v3 2/2] mtd: spi-nor: Add support for flash reset
Date:   Thu, 8 Sep 2022 12:14:28 +0530
Message-ID: <20220908064428.2962-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220908064428.2962-1-sai.krishna.potthuri@amd.com>
References: <20220908064428.2962-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|CO6PR12MB5475:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b5fdb2-1992-42f1-a424-08da9165fd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ni3y7kUNjp4lfyw9pEWio1ehK0cvmqUoAHhh1Thu98OoNf4fGVCksWxq3Z7D2Fz/KfmHwS0MYQtViW3epk73AQ+w1EWNcu9ZN+d7kFP47nNBI3Urs77GLmrd5awCFYVq2ffDjRnY0mX12uD2d7olmSC1raQbP8sCAS/sER+qA0LwoLwfqhyn6y0YgBeLHlv5ZQ7FtAJXZY0QdymukF9Lq49Ww0g6GFqr9nCev7esBcctAuqXWPHZTBjwFeaih3UxRztKiLTMLlJR0x9YzCaQ5SOt7ehXCrV5VFftHeRu50F2JGi4lGzIRCVA7OD6BpDYfUnl9BM4Ln74JA1Cmh8fqh8RXIN5bXeJDb7vVA3jurza5+Q+oK8UHMBSbDwINbZPMJDRtO6lzqWS+dI20cI9BXFGsRI5JnlpBp0UXY6QJ3JFhTtecEGvuGcHV68tq6UtwHc9pAtPKGArfj95TXvW68jU0zv9moZ4OnZs0AxmhAIP1ioL5ml/oXuyccyXrrPXWkWGKU8DRM2DWZzAFDii7QaBsqJCR6RDRFX+g/ZfBcVxNKljtAHVaTJ289re8u9FWtuUSO9UZlhlnCHLfjfXBOiQhAc5HevDw6w+AWDhh2V5rr7hVUh8OEtqeSjk9Q5D/CkEp8wbQow9p2eTTjrQloTZvy+oNfWb/B0uGoBa6gr1XilLrMah7CZF/DpU0gWv6Ucd2qXepkMpPeEGdGjNCvlqK/hdits7uZdIbSZXf7WUutQE0GP9hjQm9DsF1YU9ivT37F4QS3U9FHtaLxfSKaVOPAQs9rVLvAERrFF7wRmy6cWcqWxmcQcCe97uMPyp
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(40470700004)(46966006)(36840700001)(8936002)(7416002)(5660300002)(336012)(2616005)(186003)(1076003)(40480700001)(47076005)(2906002)(26005)(6666004)(86362001)(103116003)(426003)(478600001)(36756003)(41300700001)(40460700003)(82740400003)(82310400005)(81166007)(4326008)(8676002)(70206006)(70586007)(110136005)(356005)(316002)(54906003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:47:25.5721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b5fdb2-1992-42f1-a424-08da9165fd87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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
Reviewed-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f2c64006f8d7..a78ab9bae2be 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2933,6 +2933,27 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 	mtd->_put_device = spi_nor_put_device;
 }
 
+static int spi_nor_hw_reset(struct spi_nor *nor)
+{
+	struct gpio_desc *reset;
+
+	reset = devm_gpiod_get_optional(nor->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR_OR_NULL(reset))
+		return PTR_ERR_OR_ZERO(reset);
+
+	/*
+	 * Experimental delay values by looking at different flash device
+	 * vendors datasheets.
+	 */
+	usleep_range(1, 5);
+	gpiod_set_value_cansleep(reset, 1);
+	usleep_range(100, 150);
+	gpiod_set_value_cansleep(reset, 0);
+	usleep_range(1000, 1200);
+
+	return 0;
+}
+
 int spi_nor_scan(struct spi_nor *nor, const char *name,
 		 const struct spi_nor_hwcaps *hwcaps)
 {
@@ -2965,6 +2986,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (!nor->bouncebuf)
 		return -ENOMEM;
 
+	ret = spi_nor_hw_reset(nor);
+	if (ret)
+		return ret;
+
 	info = spi_nor_get_flash_info(nor, name);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
-- 
2.17.1

