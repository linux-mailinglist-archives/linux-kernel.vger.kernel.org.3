Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12EB523782
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbiEKPjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbiEKPjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:39:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4770295DFF;
        Wed, 11 May 2022 08:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9nJiINBTK4EudjPL0xx4sxfvXj2uZ4TleAZU37IT8cPwdrj7Ktx47rqndMUvQU2ginnf6BPNS7Kt+Qx3AvWFlLhQcpcZkU581WvtjHD8GEzxdRNn2T6rUgmAhhEgwoWpJy5w3xPmx3XqRRdsq9oF2R7zJt1beyL9/LJkmljDLrHaLSS1YT4kARLd6FOOCCtFCSVwRXSaICx0G3mIS+rixT9Z8JjKKH8bj8Jy1lbxQprDOk48vc+w8kGBZdtiZEw/LnqiE8N6DTRjGFNuKAjywQbl8+rcfJo7Tgf/+L13f1/R0eG77EPdTlJ6F0/CIAx6ksrHdzyKc/1lRmMNWkWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3RfU7qtgvXYTPWJ/5Zn3IiuPsAHXx5jxj2HKLH5RhM=;
 b=EAZ+GFj4SLuLXALJVJRHpxbMYTbD6UBRjaxdbyonrqzlglEPYex5n9tBgOvaJPUVZeBr/9LPZLSwOgt9VW3htp2QR/ve/YTnXSjs9Hn2tX+FZkyE+rrITxYT3JE2LJfHZP7DpUYUBL9812MKMqttQZxZBZAQt1ikre4gwn0Vb7lU/U1avz4Sx4oLOrK90Iltrm+MWqQF41uK3vRLjo++167Fpp8E3v5xUSE20rvXuM+YlAzKngJDPfu8fG7P5mHZloDFYRGL1QnPGgnIZHmn1140FxFr4wzD8JRdYv1PSh4vr7Ow2KubuEJYM1yQ6zui7PBxrXfrezOTDnaf0eh24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3RfU7qtgvXYTPWJ/5Zn3IiuPsAHXx5jxj2HKLH5RhM=;
 b=i1e3mVCxsAkcPkL1Sm6jT4Jk56/R8jRRUmqX1iBMB9y65yyFpKjvTqojAVUHn6quTqxC2EiNmq7sD8aLAzZaJV43vQ715E7p5FMXskuQ4MBaY8oc1WlzMTFvpVtXxrm72ndcBVjtAfJGHBDSyna/hhwI0wR30nCE75JAu3J+GgOf00k8VD/kHg+9EA90aeecQEwFVz+gxJ/QJ6m1wJtKvIad3aCVvJWSFep+jpe0RStGp4BhUPE5kG+cKFfT+HRjcNJi4lAByI4oNgB3jqDUVGHQlSM5wNVzTBANUibLeUjiODmZHMzarRixNRCt2FjC9IevchmRVWYwqE2kB6PV2w==
Received: from DB8PR03CA0033.eurprd03.prod.outlook.com (2603:10a6:10:be::46)
 by VI1PR1001MB1359.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 15:39:18 +0000
Received: from DB5EUR01FT056.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::5) by DB8PR03CA0033.outlook.office365.com
 (2603:10a6:10:be::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 15:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT056.mail.protection.outlook.com (10.152.5.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 15:39:17 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 17:39:16 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.210) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 17:39:16 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 2/4] watchdog: simatic-ipc-wdt: convert to use P2SB accessor
Date:   Wed, 11 May 2022 17:39:03 +0200
Message-ID: <20220511153905.13980-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511153905.13980-1-henning.schild@siemens.com>
References: <20220511153905.13980-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.210]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee13a1a6-52e8-4313-03b4-08da336468fe
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1359:EE_
X-Microsoft-Antispam-PRVS: <VI1PR1001MB1359249187EE37FC89BC540685C89@VI1PR1001MB1359.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ob03LfCVvbI0xqGPB17IpSN3/IhPikOIHwt6J7zAwyM1mzIM/eP2F2L5QnQgntictEY+tgVOi/JpeJuW/h3NOvN/3IVUaqH/pHNQIGh0AM1Oa+4bRR0/f6iukmkIisd+XK2Koas7axReTs9e4+9UP2JTM4hMItyvLsEM+/IwZNb97b4IvL6d/wcnXqaeDxGYKb/h58rW71AGA9J34VxuJRtuI2SE6TGaq2HeiAlNG+1+nqOwFPyv804mGx6gngZsX9SaOBhELtTdRQ8S7MAUvYqZMYLv26qjGp/m+GpiUyB2fC0W0BicNeFPXeM3OG29x7azoLNQzpUY+kbV9Eku+fsaTbzZQ262cR0eIE5/muExHZp2+UqDM0bhqeTZAGPu6NNa/SOVaB2VBkviEkOPOwOG3HoavsV7XvdACpGi6EbORHR8OeT7ezdO9ltMp7MtLWIIZ7feglsmM+2lBIh7iC62k6qP3ROfb0t3RjUQeUMYAkGFlvq5cwcvvBHnBB5Y8qOep9In1uriGjzEZDNq6W7ftMrokYNVWnSxMLNBRK8MjA8v4Yia1sUrc+mWI4hq0e4KQ3trR6kXdRCSROaEkUqEbr0wakKfy1JBMsvKXvqoFIiRy1RX0OxAI9u+5rQnxjSZFO3s/dY8y9D6qK8bQWqjpdNH1/uaLVMXRUyFTWtNj4FRzoMgPdmzEZiV3jA/ZwTIcgFwzVqTMoY87leEOQ==
X-Forefront-Antispam-Report: CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(36860700001)(8676002)(40460700003)(356005)(81166007)(70206006)(70586007)(86362001)(4326008)(2616005)(316002)(5660300002)(6916009)(26005)(6666004)(54906003)(82960400001)(2906002)(16526019)(107886003)(186003)(47076005)(336012)(44832011)(83380400001)(1076003)(956004)(82310400005)(8936002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 15:39:17.6831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee13a1a6-52e8-4313-03b4-08da336468fe
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT056.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1359
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a common P2SB accessor in tree we may use it instead of
open coded variants.

Replace custom code by p2sb_bar() call.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/watchdog/Kconfig           |  1 +
 drivers/watchdog/simatic-ipc-wdt.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c4e82a8d863f..643a8f5a97b1 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1628,6 +1628,7 @@ config SIEMENS_SIMATIC_IPC_WDT
 	tristate "Siemens Simatic IPC Watchdog"
 	depends on SIEMENS_SIMATIC_IPC
 	select WATCHDOG_CORE
+	select P2SB if X86
 	help
 	  This driver adds support for several watchdogs found in Industrial
 	  PCs from Siemens.
diff --git a/drivers/watchdog/simatic-ipc-wdt.c b/drivers/watchdog/simatic-ipc-wdt.c
index 8bac793c63fb..6599695dc672 100644
--- a/drivers/watchdog/simatic-ipc-wdt.c
+++ b/drivers/watchdog/simatic-ipc-wdt.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_data/x86/p2sb.h>
 #include <linux/platform_data/x86/simatic-ipc-base.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
@@ -54,9 +55,9 @@ static struct resource io_resource_trigger =
 	DEFINE_RES_IO_NAMED(WD_TRIGGER_IOADR, SZ_1,
 			    KBUILD_MODNAME " WD_TRIGGER_IOADR");
 
-/* the actual start will be discovered with pci, 0 is a placeholder */
+/* the actual start will be discovered with p2sb, 0 is a placeholder */
 static struct resource mem_resource =
-	DEFINE_RES_MEM_NAMED(0, SZ_4, "WD_RESET_BASE_ADR");
+	DEFINE_RES_MEM_NAMED(0, 0, "WD_RESET_BASE_ADR");
 
 static u32 wd_timeout_table[] = {2, 4, 6, 8, 16, 32, 48, 64 };
 static void __iomem *wd_reset_base_addr;
@@ -150,6 +151,7 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
 	struct simatic_ipc_platform *plat = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	int ret;
 
 	switch (plat->devmode) {
 	case SIMATIC_IPC_DEVICE_227E:
@@ -190,15 +192,14 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
 	if (plat->devmode == SIMATIC_IPC_DEVICE_427E) {
 		res = &mem_resource;
 
-		/* get GPIO base from PCI */
-		res->start = simatic_ipc_get_membase0(PCI_DEVFN(0x1f, 1));
-		if (res->start == 0)
-			return -ENODEV;
+		ret = p2sb_bar(NULL, 0, res);
+		if (ret)
+			return ret;
 
 		/* do the final address calculation */
 		res->start = res->start + (GPIO_COMMUNITY0_PORT_ID << 16) +
 			     PAD_CFG_DW0_GPP_A_23;
-		res->end += res->start;
+		res->end = res->start + SZ_4 - 1;
 
 		wd_reset_base_addr = devm_ioremap_resource(dev, res);
 		if (IS_ERR(wd_reset_base_addr))
-- 
2.35.1

