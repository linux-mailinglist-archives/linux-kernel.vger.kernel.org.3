Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA3A525F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379139AbiEMJsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355822AbiEMJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:48:18 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140125.outbound.protection.outlook.com [40.107.14.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C574200F71
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVp9oy31Vvu7o1I8rPSbyyPdHKRktM7omOINOgKQ1TlkEin9DA8C8BbDExqr8XLMkEEIBDgdhnerUQJQDnlPKGeugFAugsPUqxOBF/qz2fa5N9X4JFqWuuRkI4+qliBHcE+O/NNeCSp2Uo96Z2E0q86LK9AbEmrIOq/6DRzVJcwM5W4LjgPS8G/+M1HmFgjuHtCPZfgiaQIMx3vH5GhYw8CO/UZpIupGd8G/e3u30xXILDUzvS/SkHMKqmxd9/Qikae8+0vM33ipKdeB0W9YdoyGgzGylCVWxwKLFhgHLNr4kNpypJy4CBaz/obxhZ1q+9ICsBtmuMaEaUtic2hmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJKw3le/DXTx7hmHQK4wnN7e2Qjdq5ip5UN/3aSoJsI=;
 b=ar8ZaMegsto4q3deTW02UpqUlfxTsVeLJ2aPS/a891JCLf9UbXLSvoMGsMRW2oqb5rxPtzwADnJFlh4HTBZ3/C8uOvhDWjy0Qcu6sMw7iF1f/p6vligj+JJqYqkHo0qmCBqLZCXBszeH1e1IX75l3y8aG2PCxBZYiBLAvcycik9pmDz1vSnortgk8fq0F1CDqjjftZvZGdhlO6ZRkZndOatW9/iVTPwHy8UmGJ9idIMKWBBrUD5qSTmSOVR0f3yDOU8YWZwTeSysJQJOh5FKJHZrbQxde4dx6V8wxyVhG/OV2FDYItDjSiviGLcm/U4tv6wwVzBsH3tsbn4+DhoXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJKw3le/DXTx7hmHQK4wnN7e2Qjdq5ip5UN/3aSoJsI=;
 b=omHjmW+9GHrhlsFBFW/MDG/eCuiGISeUPiwKSzXtUIUyFRI20LE5TH+et4dddMFxIV/0ktvEvMZiYRYSZUU2Fh1SbELjXW+/uld/7DADdlkNaA4o/ZXyJlayHcnQWPEogs9r5Rn95Ew8KhkOAnsfaUWo6/orijs38kRGZOQjydc=
Received: from AS8PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:20b:127::13)
 by AM0PR07MB6049.eurprd07.prod.outlook.com (2603:10a6:208:11b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5; Fri, 13 May
 2022 09:48:15 +0000
Received: from VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:127:cafe::f9) by AS8PR04CA0128.outlook.office365.com
 (2603:10a6:20b:127::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15 via Frontend
 Transport; Fri, 13 May 2022 09:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 VE1EUR03FT050.mail.protection.outlook.com (10.152.19.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 09:48:14 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 24D9m8WC023390;
        Fri, 13 May 2022 09:48:08 GMT
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
Subject: [PATCH] mtd: spi-nor: Support Dual and Quad Read on Macronix mx25u25635f
Date:   Fri, 13 May 2022 11:47:59 +0200
Message-Id: <20220513094759.44185-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 57a17b7a-eead-4372-4816-08da34c5b368
X-MS-TrafficTypeDiagnostic: AM0PR07MB6049:EE_
X-Microsoft-Antispam-PRVS: <AM0PR07MB6049035DED7D77C7CDBD4A4388CA9@AM0PR07MB6049.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7WAwVGOoyzTVEVbBAQPbG7fkHJ+7P5cbbyL6Gn+U9peeQLIfbN086iyoMorVIzek13124Z82lqCImAolvq2vAjkIdyfAvl0xKFFT2ZBhXOcISnltUNoCC/ua5i4ZdSIqNrpYycqVSx88HXi8LuBQnRQR0Ho3BOssVhzOsy6hUn+Tk6jL1YY1Y0B0kQHcGHW88QsF3UoFmE9W1N54ofaKwUfQ4Q/somsr7hkd5a+IZey1OGbc3SCOvt0ZPa4QuI22LCHwY+bBDpL3iKopBQfCpg2JkVBqd6nVnljnQC+SfMXKigjfwDz94ubEobAs+4Upg8LjlsffiyRlPH0IhxEeCKKAnVKh4cnIoG3EW6eneH57OAUmTM6Q/kLU+DPGSlglQjrjR0+tOisN5xXt8vesAGF13QDyWw9XekdUlaoDEIkhroWtNOcmwFhm2WaMWIUPK3JBxW+xOD123KFja81pow82CuInmGi4tUty65be19lWvVjQobrNX5chdxgFMaHh8P7xBl8CTkNx+1cTuc2eRaWpDCxUwht5l4ipf2IpIp2X9aFF3AonRrsbkc5wG6ytHYdMj7DPCyM702cQfuA8Pyk5B0xsSQ+zwh0mKMk1mXmC42wG7RddXpM6wBs1KjhThB/WB4YzHZwJXo6wrmJ4srqhv8yEknfNHwqJGaldmzAyq6qFaGOEnWieB31FPm7jgdpmnnbgxFVxZJWdfn3RQ==
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(36860700001)(36756003)(26005)(356005)(6666004)(81166007)(8936002)(1076003)(40460700003)(508600001)(83380400001)(2906002)(316002)(4744005)(82960400001)(70586007)(70206006)(8676002)(4326008)(2616005)(336012)(186003)(47076005)(5660300002)(54906003)(82310400005)(6916009)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 09:48:14.8722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a17b7a-eead-4372-4816-08da34c5b368
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6049
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

According to datasheet both Dual and Quad Read is supported. The read test
shows x3.8 speed gain.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/mtd/spi-nor/macronix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index d81a4cb..cad9112 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -77,7 +77,7 @@ static const struct flash_info macronix_nor_parts[] = {
 		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		.fixups = &mx25l25635_fixups },
 	{ "mx25u25635f", INFO(0xc22539, 0, 64 * 1024, 512)
-		NO_SFDP_FLAGS(SECT_4K)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 	{ "mx25u51245g", INFO(0xc2253a, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-- 
2.10.2

