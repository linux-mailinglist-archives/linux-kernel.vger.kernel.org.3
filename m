Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7204E4AE96F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiBIFm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:42:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiBIFfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:35:22 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2081.outbound.protection.outlook.com [40.107.96.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32560C0302CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:35:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i066eOzf6ePeMwO7qZBCmmTRL5frCAVUH2Q+5bUWxDP+L39cjTS1HhRLmlVdxPY2/OJ/OZV2nq08sAvWJyM+V1yyC5x0jpK1RXfSA8NJriz3i8O58jzWsa7DA7+L8TinBik0ExIO6jXpmNYfuViXOrWJhBZrO7uicBp6VDUzhi4xTmzz/J48lILvbUy+ZMuFxxdChma1CPb7t3zxQV7YIQYOb43VhF7UtlYfGJYsiJBv+OndJXutjC7daXQfU4BAy0hmbLs9Gch19IXIYltSSl1m65Ozoqwd8XGI32D+G/oIiD9968OKH4qmBdgJrtRfpV3h2z3yoGMHZT06n8Qoiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU96ABsEwkCOAk2k+gW2zoCe4zQsiyREY4XgHyCEBjg=;
 b=bO95c8uL/ZqYY41ne78g+R0lvV0zmm+rjlRpNIiYY8px0Z8oXtXyFeHnb8FI8DnX5MPcTonUMk12Ngo9+xxQeSc8VVwmcTmxT8cWQ70KX6tpU5ps48G5wgAqXObH1IlFveLTJEsRIMW6/g7yQEtIrKx3U9MPLcpP3PLWozulOKdOm/kFftpYeAItHn75XXEWnuwtEsoostgbCQluriyDAvJy4k3DiF85vRcZpgwNSjO0U66wFhNQPQcefNVfqiYV8ZsRiEWc8vIVmWztfr3PaNSUqosFaaKstrHACwEuEwxX+TYmNuXKpxnaJNaWVeLpLIItZ99DU/3NlEWDFpPNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU96ABsEwkCOAk2k+gW2zoCe4zQsiyREY4XgHyCEBjg=;
 b=jg3cdPcg515O3GONQzTcvw0pLkBOK5kq01n8h7zE9w4A8ps539akIei/kUlB6IVX0X4AvyziRk5c5xIC1G18rPohNtU/KwhOrkuGT7qqEpWlPuW7ADpjuhfk82up7dem+gXSxNCO1e3kBqS9mrUREBStNrUIoLsWJQ3v6UgZzV0=
Received: from BN8PR04CA0026.namprd04.prod.outlook.com (2603:10b6:408:70::39)
 by BL0PR02MB5393.namprd02.prod.outlook.com (2603:10b6:208:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 05:34:35 +0000
Received: from BN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::f6) by BN8PR04CA0026.outlook.office365.com
 (2603:10b6:408:70::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 05:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT031.mail.protection.outlook.com (10.13.2.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 05:34:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 8 Feb 2022 21:34:32 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 8 Feb 2022 21:34:32 -0800
Envelope-to: git@xilinx.com,
 miquel.raynal@bootlin.com,
 vigneshr@ti.com,
 richard@nod.at,
 linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=58200 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1nHfcd-000CJW-JI; Tue, 08 Feb 2022 21:34:32 -0800
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <miquel.raynal@bootlin.com>, <nagasure@xilinx.com>,
        <vigneshr@ti.com>
CC:     <richard@nod.at>, <git@xilinx.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v2] mtd: rawnand: pl353: Set the nand chip node as the flash node
Date:   Wed, 9 Feb 2022 11:04:27 +0530
Message-ID: <20220209053427.27676-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7044c44a-c3ba-47cf-5e51-08d9eb8ddb11
X-MS-TrafficTypeDiagnostic: BL0PR02MB5393:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB53932330A7224987BB2D76E9BA2E9@BL0PR02MB5393.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hucCXKOSFUAlK9vgvgiFDOV2zRGIRkaAJvrAGweyiT1BIjuXOWiIcCRzMmFjuKfa9Vkt89sl8VnooKl3tHQBsGabSkJiM9MwJ7DTiE475OSSJkT3tXGsS9mewbWisgQ23UHpNeqLVaCvaPsRfaZ5UrRHo+O6KNA+Cm8gGwb/i1DnBzFJqBLDTQnraVErGU+6LwoIIP8PkshjymR3DIl4w0/aTuCP2yvlRWObS2cXxMnJSrmQCG6wb0SynzPkzsrqRWy4qjjqc07aPx78AMnoIuJM/Zw2Jq/Q1l3JWDoHkZsNH7pTvlRbZfTWlhOpAC7XHha5DOszJ3xoO5J3yfIqOygHoyTvwtU6gztykPgQg9dY2H2DYObZCeH5+4pwf7dl0GUw1VJz+WqhaM8QLIWpeAnorjsrm9hD3Kk9GKIFQ9CdPcyzyRIgRRUE/HhH1Jhpu9jE39cPnV5kKx9v0GVjWuxCa6oAXfGdc2JxTVPhTjtKVu8sz2q3UH9EvwOSN1/pGEHwBjJE9ECGAZMV4eUIgE57RLqxtVKdBN8WPGvU7jfVhmbuM6tQpfFvCB731CyHK6ZTg9kJItj8AMrbWse3AVScqjnc0SXfElYruH6CzC040LKahmAT4Z5P2eFcLydJUrViOvWSIsyFgY2CrNWP6vWkd8XSrWnTNgaCkK/JcDihOqm3ehhh8GjAaKIWgUGf
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(4326008)(1076003)(426003)(336012)(186003)(83380400001)(356005)(110136005)(2616005)(36860700001)(26005)(7636003)(107886003)(5660300002)(47076005)(316002)(7696005)(9786002)(70586007)(8676002)(70206006)(8936002)(6666004)(2906002)(82310400004)(508600001)(36756003)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:34:34.6338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7044c44a-c3ba-47cf-5e51-08d9eb8ddb11
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5393
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In devicetree the flash information is embedded within nand chip node,
so during nand chip initialization the nand chip node should be passed
to nand_set_flash_node() api, instead of nand controller node.

Fixes: 08d8c62164a3 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
BRANCH: nand/next

Changes in v2:
- Added Fixes tag.
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 8a91e069ee2e..3c6f6aff649f 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -1062,7 +1062,7 @@ static int pl35x_nand_chip_init(struct pl35x_nandc *nfc,
 	chip->controller = &nfc->controller;
 	mtd = nand_to_mtd(chip);
 	mtd->dev.parent = nfc->dev;
-	nand_set_flash_node(chip, nfc->dev->of_node);
+	nand_set_flash_node(chip, np);
 	if (!mtd->name) {
 		mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
 					   "%s", PL35X_NANDC_DRIVER_NAME);
-- 
2.17.1

