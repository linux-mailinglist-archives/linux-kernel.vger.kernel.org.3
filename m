Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE0559FCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiHXOEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiHXOEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:04:16 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3104B97ED8;
        Wed, 24 Aug 2022 07:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNIGL66POaQirop0pZMBsOORAZBO5u6g3Oo8joRtbNXmqbWP3HwHpPdoE8Vy8tZYosHPGjGuz3zZqbwswLoIWS3XOwpupQt56UVEcUolpUEs+8Y5CCGvKQEkbx7Csg1SXHTkBPLFReLcd9w0mxrP24fllK+7hRduTHWcMVj7ToMR3H1bu6RFVg/biilPTSxcp2s34qNNAgNVjPv/jqYFC0Q8L+zTyR4I8gllZJ4VV1FgGdus6QQj89sO7rlCKhuo8j8Jl7++YxIOiwia4rGDa/sz/809rfuQsdVBRkSm7poiVM+HQOSm6nw25UJl1ySWZCF4Ks/ZueijeE/OU8pW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoeqWO5jn+/1Y3EBaDcSz5dtAsOK/vG3RHWEKr4jE9U=;
 b=LAROHh8yR/8PZUlb/bu4o5a4nTGHv4FVyFFtEBJymeelD7bZmQIEUmXFoZ8GgIHAfYsNwpXES/Buhg3+24qi9McuNl0oBOC34Dnms8VhRt7sBjUZF39DYvihEOOsIPG0l25wsiGYC1fiPfbLySn0l888hgYqd2KHqzPMzQQeV08FQG9rWEwax3nL8A0VlM9bNwQmDLgmlnzRJtfwrQjc2mGVw1t+SWnxNrRZJw1ZySbgYnhWuC+2WgEK48hzkenIG9LpAN/JqlmOF77a/YqQt/u1S8gfhTQddhI6zhmYFTWckKCsgK+odSjmSm1DFnSWggoojDe7+p2ly2rJztB6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.74) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoeqWO5jn+/1Y3EBaDcSz5dtAsOK/vG3RHWEKr4jE9U=;
 b=EYnMIq/ibSsMys2xC7qQ9zH6fgMaAu+zXuWJhD2CWbJMUVuge8kj1BLT9BqASu4tYlg9NzwBg6II7miAZ8CyObJcvy3WKsQAKMqsbVHrcguT6eGCJ07s/I6yYPJcuufFomKiQndLp9jimInhGKyLE34U1+JA07oHm+dMcXtfxfdVBj8wDfbcDwTnEeYBNTBEAOskv8+CAW51XJPcSm88QZJ4NIm4v7MuYgF2HPLroBfsGR/7R1Vcyo02j9yN/3d3CWlxe2dqeTGAFgLfijfc2NDGCDpgMsek/wHeEa3uv/zscUudyDu5H1KNL1NuUHdTVM7l09AJ9IkcSRAAqwQyWA==
Received: from DB6P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:6:28::28) by
 AM0PR10MB2289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:dd::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Wed, 24 Aug 2022 14:04:12 +0000
Received: from DB5EUR01FT085.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:28:cafe::1e) by DB6P191CA0018.outlook.office365.com
 (2603:10a6:6:28::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Wed, 24 Aug 2022 14:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT085.mail.protection.outlook.com (10.152.5.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 14:04:12 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Wed, 24 Aug 2022 16:04:11 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 24 Aug 2022 16:04:10 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        <simon.guinot@sequanux.org>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v5 5/5] platform/x86: simatic-ipc: add new model 427G
Date:   Wed, 24 Aug 2022 16:03:47 +0200
Message-ID: <20220824140347.1842-6-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824140347.1842-1-henning.schild@siemens.com>
References: <20220824140347.1842-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1a8de5c-7eeb-4bf8-a132-08da85d985ae
X-MS-TrafficTypeDiagnostic: AM0PR10MB2289:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEeF8rjMJe7EMwGhe1ttdhbZPVouO5OBbzyBMFPBf1KpnpCZpNupiEw2Z9qdXz6FUThNp6x/dph4C8FzrzP3MPD5qYPgDjQv30/syWi6xYBVK5yx/3l/H7KQpU5xEBc9F2OUZlaTZrbDaFtKvPDYulk6d2LZpQQjzclgiOlu5J/gVT8603P3ezn8EHg+jY0aGNyJoyoyu69tn54bkaSO75b2hCWfxGB+0LFGmY2LsPk8+QtbkXbz8dWnqxF6UOuI/SGcNgTttYLOWzJUOSMGJDp8hIrgGTzesAFubepyMxg6XyzFLR4KbGqCTBLZegLWr3WtTh5yCXJcdOi/PJQ6Ge3asVxEoc9gQtjyGA7ZOibLLEO8A01G0Z3CA7ZyfKuH4006aitZda3azvteQQEiopuoW/JDWhAH6t6RdZCED0ODKFobXyAFY+2AcIiQbOaqFwSk4cLvvk2QSz95c8iwp6m2dATdGywiPl9Sq5YS5kgj0LfTd+ELxcqUAS/GUlcgeNvoxwC9jyncol+xbj6WGDzXX18qRth6v3SzMXDT+xk774caH2ywypha8Zh/MPBi0k7XyWopuHPZTtZu1793VrJy26Z9nEijI+NRsQ13ah9nOHwUGehjyC+edoqK7TCncC+Pxob6uSzozENh12Jp2oOEh9A+ATSlI3LX5FeGkvA7b23T3MKU4eefCpAb9COOtZrDvM5Q3Pq7+TtvLkSt3/++10YfVmxo2rSuHBcjOZhC0+20bDs1ZFxr0jG+Usg2aeupXcG9WMgIJ6MOpM+8mfPQmAiBj4dKG35ODVWH+xVMxgV3TWqFPFPy1pL8/VQRYcl6vMFp8aWIfMKBp4qA7iiM6+bu52EKoIeOINuS7uM=
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(34020700004)(86362001)(36860700001)(40460700003)(82960400001)(7596003)(356005)(7636003)(82740400003)(921005)(70586007)(70206006)(54906003)(8936002)(316002)(110136005)(2906002)(8676002)(44832011)(4326008)(1076003)(40480700001)(956004)(107886003)(336012)(16526019)(83380400001)(2616005)(26005)(82310400005)(186003)(5660300002)(6666004)(47076005)(478600001)(41300700001)(36756003)(7416002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 14:04:12.2776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a8de5c-7eeb-4bf8-a132-08da85d985ae
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT085.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2289
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Siemens Simatic IPC427G. A board which
basically works like the 227G added in a previous patch. So all there is
to do is to add the station_id and make it take all the 227G branches.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c            | 11 +++++++----
 include/linux/platform_data/x86/simatic-ipc.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 8dd686d1c9f1..ca76076fc706 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -41,11 +41,12 @@ static struct {
 	{SIMATIC_IPC_IPC127E, SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE},
 	{SIMATIC_IPC_IPC227D, SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE},
 	{SIMATIC_IPC_IPC227E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E},
-	{SIMATIC_IPC_IPC227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_NONE},
+	{SIMATIC_IPC_IPC227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
 	{SIMATIC_IPC_IPC277E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E},
 	{SIMATIC_IPC_IPC427D, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
 	{SIMATIC_IPC_IPC427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E},
 	{SIMATIC_IPC_IPC477E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E},
+	{SIMATIC_IPC_IPC427G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
 };
 
 static int register_platform_devices(u32 station_id)
@@ -82,6 +83,11 @@ static int register_platform_devices(u32 station_id)
 			 ipc_led_platform_device->name);
 	}
 
+	if (wdtmode == SIMATIC_IPC_DEVICE_227G) {
+		request_module("w83627hf_wdt");
+		return 0;
+	}
+
 	if (wdtmode != SIMATIC_IPC_DEVICE_NONE) {
 		platform_data.devmode = wdtmode;
 		ipc_wdt_platform_device =
@@ -96,9 +102,6 @@ static int register_platform_devices(u32 station_id)
 			 ipc_wdt_platform_device->name);
 	}
 
-	if (station_id == SIMATIC_IPC_IPC227G)
-		request_module("w83627hf_wdt");
-
 	if (ledmode == SIMATIC_IPC_DEVICE_NONE &&
 	    wdtmode == SIMATIC_IPC_DEVICE_NONE) {
 		pr_warn("unsupported IPC detected, station id=%08x\n",
diff --git a/include/linux/platform_data/x86/simatic-ipc.h b/include/linux/platform_data/x86/simatic-ipc.h
index 7a2e79f3be0b..632320ec8f08 100644
--- a/include/linux/platform_data/x86/simatic-ipc.h
+++ b/include/linux/platform_data/x86/simatic-ipc.h
@@ -32,6 +32,7 @@ enum simatic_ipc_station_ids {
 	SIMATIC_IPC_IPC477E = 0x00000A02,
 	SIMATIC_IPC_IPC127E = 0x00000D01,
 	SIMATIC_IPC_IPC227G = 0x00000F01,
+	SIMATIC_IPC_IPC427G = 0x00001001,
 };
 
 static inline u32 simatic_ipc_get_station_id(u8 *data, int max_len)
-- 
2.35.1

