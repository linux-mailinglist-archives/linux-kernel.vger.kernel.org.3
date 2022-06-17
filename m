Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A342854F084
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380071AbiFQFTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379708AbiFQFTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:19:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BCA66ADA;
        Thu, 16 Jun 2022 22:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbBLmWz5O5WrwXvWq603KvuQULtkmBRZm7HmKwc9Dn+8EMBC8Fyt5Y8vWUTYWu1rplWjAMXwCOqgEz9MtvlkFLn/Pu5oxnbiDqUUNpd6R6wL43L6zM5cXa6pw/UHlw4zEHu5v6nmW0mSkKxBBzpgBTUsq8g1qozNdfY6IUmU/+qMUfs2Hl6Y75dXjYPT3BHhlfAnTeYX6ukeBeOw7Nk+F8lpENfSkLDFTbrRa9hU/nDOCSQf/3aI2QAx6nsg2qYm8TEg+uO3xyycaVXyZ/QdHoy08PhfremEwVv3ma/xSV4kulWrpDgKoGGW04hsyki663mcQhaS2jngvQazHxDO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0l8R/le4LsHqFokvaHVS/vNOCwp2qTDoLGHw4wjkBw=;
 b=ZtGFIqjB0MWosIM0SZ6hICnTqOSDDbvfxf5rX+LQTBJhGg4lBCbWGOK0VPq01KwogT9OGmuiizocu7MXY8JljQ9gzS2H71iqiwtwzX5A00ggiE1FF12KaHdQKUU9E/jXYXtDUtKkphOjdvB1WHX20iz7PATaeDIt9O5r11jOXRxxjbyuZknsUfjVzTOOo+OGHf6OvNo8DYf3Ca/8sv2QUUx39q3Du59qDLnmp9Gs7pdXar6ebjE8JCBeSALWHtZvdkvBdg1jqERZXSgvtams4+ebxDvKb6nLUwcqhG91VTHMCkVcxbhL/GMeMUYXUbctGwwN2Ygmf2svffZpxbCB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0l8R/le4LsHqFokvaHVS/vNOCwp2qTDoLGHw4wjkBw=;
 b=icaLcPmU4/OCQ6AAXnwfzsxvLjKAsjVFkF5Wb4BEIHkn9YKNYEWYWzNykR9B0e0A+ODSTnlLkdcFbVUbYX+xwHixWPJE6BmnKtu2riKJlyPh7EHOnfC1VByaUf9EBjD0OTBo6NkuxwmCV5/A8XNpzftfIgydXjPj5X0W7gf8oHA=
Received: from DM5PR07CA0144.namprd07.prod.outlook.com (2603:10b6:3:13e::34)
 by PH0PR02MB8630.namprd02.prod.outlook.com (2603:10b6:510:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 05:19:31 +0000
Received: from DM3NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::7) by DM5PR07CA0144.outlook.office365.com
 (2603:10b6:3:13e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Fri, 17 Jun 2022 05:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT003.mail.protection.outlook.com (10.13.4.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 05:19:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Jun 2022 22:19:29 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 16 Jun 2022 22:19:29 -0700
Envelope-to: git@xilinx.com,
 linus.walleij@linaro.org,
 brgl@bgdev.pl,
 bgolaszewski@baylibre.com,
 neelisrinivas18@gmail.com,
 srinivas.neeli@amd.com,
 linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=47594 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1o24OG-000DMd-B4; Thu, 16 Jun 2022 22:19:28 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <bgolaszewski@baylibre.com>, <michal.simek@xilinx.com>,
        <neelisrinivas18@gmail.com>, <shubhrajyoti.datta@xilinx.com>,
        <srinivas.neeli@amd.com>, <sgoud@xilinx.com>
CC:     <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH] gpio: gpio-xilinx: Check return value of of_property_read_u32
Date:   Fri, 17 Jun 2022 10:49:21 +0530
Message-ID: <20220617051921.3801832-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43c92f3e-4b16-4f4b-f23f-08da5020f55e
X-MS-TrafficTypeDiagnostic: PH0PR02MB8630:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB86303ADEE6C1B5D4C1E61C22AFAF9@PH0PR02MB8630.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQ/0j7CU6OR/Mwzf4tgL3FkflU894zxXanVV5cHlsIY3yQTSbBPW2NcDJ6eEIpZiENA/U8yO+Och87XdV4gMUY7mVUmdOMnx6zsZhF73RixoWZxB20jGknhPRGRn9QO1N6TQX8/xb9CdF7QWoAVSQVDTC7gTOiMl1hhaysyvEqy1S8aelny81XAyWNuCXSiEfuGAKQRqR9T75Yz89jJJAnV5KT26jXhIlSpQ0v8KaeML5QKZKK4AmCRRc01jSff1zD4nOKmWfzhZjIpDgLVt6Xe0kN5NgXD3QlMWO7oUtwMPC/GLLqESIz3IKZ2pZeEXUJW2g4UoKoi12/THaNTUEgE684gJsicPKkF/ogFfgAufgd3JjGPq1GaJ3zS7Zw2G6xQ3U6jsXMxkD24PnVWvuqsr6dlbBcqm81H2yosHJ0hhYXn2sIGauau66GqxJ9RhP7p+qKjmeWIj9bJhJjMWtmdgzb9di+kWHKqKM9H/wILtGKJkWCrPaGdndozd24sJ2nsgjdPluxOzhlPIQOp0jxoebhGag7+yTBK3CAkGIrtjIWzpvDjLRsHMP7/ytHNlmQR5SkVjxHhRyIrlCMKXGC3iBm1k/xXeLtFPzQIN8DRa+ioTKRBYspHShQDuNqzMJVwSGGYqW146YmNpT6vjjsbwmx4WuhjB6rpvB3YBvZrGTIhq2fR6Gm7/Rhp+BP7yVlplrmplsww9raaItpG7DKxBJ/luyOaUtvmpzp8ngYc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(70206006)(4326008)(40460700003)(44832011)(2906002)(7696005)(82310400005)(498600001)(6666004)(426003)(6636002)(54906003)(26005)(7636003)(2616005)(1076003)(36756003)(83380400001)(70586007)(316002)(110136005)(107886003)(356005)(186003)(36860700001)(8676002)(8936002)(5660300002)(9786002)(47076005)(336012)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 05:19:31.1381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c92f3e-4b16-4f4b-f23f-08da5020f55e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8630
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In five different instances the return value of "of_property_read_u32"
API was neither captured nor checked.

Fixed it by capturing the return value and then checking for any error.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Addresses-Coverity: "check_return"
---
 drivers/gpio/gpio-xilinx.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index b6d3a57e27ed..268c7b0e481d 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -570,7 +570,8 @@ static int xgpio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, chip);
 
 	/* First, check if the device is dual-channel */
-	of_property_read_u32(np, "xlnx,is-dual", &is_dual);
+	if (of_property_read_u32(np, "xlnx,is-dual", &is_dual))
+		is_dual = 0;
 
 	/* Setup defaults */
 	memset32(width, 0, ARRAY_SIZE(width));
@@ -578,14 +579,18 @@ static int xgpio_probe(struct platform_device *pdev)
 	memset32(dir, 0xFFFFFFFF, ARRAY_SIZE(dir));
 
 	/* Update GPIO state shadow register with default value */
-	of_property_read_u32(np, "xlnx,dout-default", &state[0]);
-	of_property_read_u32(np, "xlnx,dout-default-2", &state[1]);
+	if (of_property_read_u32(np, "xlnx,dout-default", &state[0]))
+		state[0] = 0x0;
+	if (of_property_read_u32(np, "xlnx,dout-default-2", &state[1]))
+		state[1] = 0x0;
 
 	bitmap_from_arr32(chip->state, state, 64);
 
 	/* Update GPIO direction shadow register with default value */
-	of_property_read_u32(np, "xlnx,tri-default", &dir[0]);
-	of_property_read_u32(np, "xlnx,tri-default-2", &dir[1]);
+	if (of_property_read_u32(np, "xlnx,tri-default", &dir[0]))
+		dir[0] = 0xFFFFFFFF;
+	if (of_property_read_u32(np, "xlnx,tri-default-2", &dir[1]))
+		dir[1] = 0xFFFFFFFF;
 
 	bitmap_from_arr32(chip->dir, dir, 64);
 
-- 
2.25.1

