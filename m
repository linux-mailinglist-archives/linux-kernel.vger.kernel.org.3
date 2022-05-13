Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47F2525D63
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378420AbiEMIhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378297AbiEMIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:37:07 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02812631DA;
        Fri, 13 May 2022 01:37:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgeQ+4usPyCCRKXEGpmCIFxsIbauNQ+9/ssP1hUAeycHNawpUuRP/gOI3eybOCaC0fVqR7mpFaXdzoZfol2Eyr6P5OZ/VmhckWcarUfHJwUZFok6ynvnrn0V/plvoU067+ATfQolxVqac1s3HRjuHJL2jLQIwm3ybkV0JosivdNGyeAKljIj7XNoHZ5L+fkCSWwZJu6qIGVjRZjCRiXYyYLdHVvd5bnyx4kCbijUmvJJAz0FD/d+fDT/ZZfU62qf8jxwHZOx1GKAwx4FYugKsL5NElITgqfmKQaYRTY/NbIe4NQPRlJi1/INapE/kLHDPEbby8WD3hDE5F7ZINsBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7j44S2xYRBxXRq+XJyqczwUz0cTeeyfC4foTiE0zbE=;
 b=nKXRy26dwywogRgxh7BAdl+l+egXf2f2BarujZppspe1ws07oxV5dyg9TMYz15dOZvtmjpptbb+lzU4zfYiXCACcEkx2jOmMpU6fZ4Tqyx7w5MKsx7gldvCNJDXsJoEhY6xKlE79WeXzoWJo5EY1IAR6OW/4o1pOyDIVOFFRKETpcVcvIwS0+H009a+jpC89srrSwJ2REA4EVPe6gHpZdcfUISWPMK9/vPuljpDNlgLl6FGLEYPZVHwolfgwm2mQhMJ36yFIIkb/JUDnntfo3q1YKrBpPmHPK6HTp3KgKbihMnlwO+v3w05JE4fsOh/8DD8CHH/4YTeYa+Ux5g/lGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7j44S2xYRBxXRq+XJyqczwUz0cTeeyfC4foTiE0zbE=;
 b=QUXZcxpoFptuZq3sqFW0KeWor87BREPcV4Av+LvKro91D0BqRzr1CXojW1GxbHtGTaLx1zuKNCgdzdvT/cWTNhY4F/OS8Air04GzCLhq5lHeFtW0atdLSv8PwSqdDDcrPZbP/Whh/f+V8G2tPcgzC6JSMNIYy8IqebGcchSOtYGiDwSvXRtZpQzP12NOK6VnXvYco/8QB3Y2nXN/m9+yIgYMKnf/IZvvJLzT3FeQAYBj+MuMycxbrJBjsLZIm0AkvIyWpmW7yWfl3EZTvMPX/taAqC4RrwF9gjaXLMwWArDHk8/J1AHrbDX+q/IIg0gZPo1bqK0edrL8opTlbotNPQ==
Received: from AS9PR06CA0756.eurprd06.prod.outlook.com (2603:10a6:20b:484::12)
 by VI1PR10MB3662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 08:37:04 +0000
Received: from VE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:484:cafe::e6) by AS9PR06CA0756.outlook.office365.com
 (2603:10a6:20b:484::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Fri, 13 May 2022 08:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT055.mail.protection.outlook.com (10.152.3.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 08:37:03 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:37:02 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.210) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:37:02 +0200
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
Subject: [PATCH v3 1/4] leds: simatic-ipc-leds: convert to use P2SB accessor
Date:   Fri, 13 May 2022 10:36:49 +0200
Message-ID: <20220513083652.974-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513083652.974-1-henning.schild@siemens.com>
References: <20220513083652.974-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.210]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d871267d-68f4-427d-268e-08da34bbc1c2
X-MS-TrafficTypeDiagnostic: VI1PR10MB3662:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB3662D8BD414364589AA6202185CA9@VI1PR10MB3662.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJgQvJ8XGVMWLquLhEiC8WC35nhd4GiZ3Uzgxf2p/VNHsN8q0wI5Xw/wO+xNhQUGqFWKYa2JBJnNpKU85gyv9aQSLTUsZFE2R6hxa6S40o5g44ou47h3Qz3/pkuF54cOouNT3nXFhbsjAB8uRpfNBR7mZ5gTC4f4gujQOTFGBkDoMCE512MwD5EeOfa4wy/JcamgcaIpq2IQ6SXhjuuZxFHzmp4Y3oYoK0k8eZhCJRzXCqLVw9z+ASWjiZplZwPIzP9h2diHkUP/+2vG+DndMe1ge+wlalsebElqWQCjOSlwFrkNbJEKBPcnaj7O9AMtY1p6o5uif6nadHW2rwHuwC/NHb3mLTz+hJD1lZ+5qVfaVO3UzH8OLo+LfvILREuljWFgG9lKhMxDnylZ205JF2Kz0znnQDEKCqvyK1xABuwQfHjqlsIXmU0s0c+gQ7b5UqLBiefcQitgmHoPGkm4bZXeZ8Y/nH7NM9ropIAYfN7gUIB7wm7w1br8xEU8s/XO4DmqVEcf+42BEqjlDuP2rViJHbM1DCU6L2BY+VAEM6SWmpVMh4WxdoRfwS30Q0bNJXqIgAmYcqltL4lyXbYCLEbm7zHNwZvngkL9yu4ru6bm2OwfqXTUVeHmZaORNicql21tM5+OhXN/eqv5HJygnGOJPER0qB62iBPevxYoPRo+3RMX8Pz2UmDj1qtlom0i
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(6916009)(82310400005)(83380400001)(26005)(1076003)(336012)(5660300002)(40460700003)(47076005)(316002)(86362001)(36860700001)(186003)(36756003)(16526019)(508600001)(2616005)(44832011)(70206006)(356005)(54906003)(7596003)(7636003)(70586007)(6666004)(82960400001)(8676002)(107886003)(956004)(2906002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:37:03.9976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d871267d-68f4-427d-268e-08da34bbc1c2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3662
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/leds/simple/Kconfig            |  1 +
 drivers/leds/simple/simatic-ipc-leds.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
index 9f6a68336659..bbf8cff3c3f6 100644
--- a/drivers/leds/simple/Kconfig
+++ b/drivers/leds/simple/Kconfig
@@ -3,6 +3,7 @@ config LEDS_SIEMENS_SIMATIC_IPC
 	tristate "LED driver for Siemens Simatic IPCs"
 	depends on LEDS_CLASS
 	depends on SIEMENS_SIMATIC_IPC
+	select P2SB
 	help
 	  This option enables support for the LEDs of several Industrial PCs
 	  from Siemens.
diff --git a/drivers/leds/simple/simatic-ipc-leds.c b/drivers/leds/simple/simatic-ipc-leds.c
index 078d43f5ba38..2e7597c143d8 100644
--- a/drivers/leds/simple/simatic-ipc-leds.c
+++ b/drivers/leds/simple/simatic-ipc-leds.c
@@ -15,6 +15,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_data/x86/p2sb.h>
 #include <linux/platform_data/x86/simatic-ipc-base.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
@@ -38,8 +39,8 @@ static struct simatic_ipc_led simatic_ipc_leds_io[] = {
 	{ }
 };
 
-/* the actual start will be discovered with PCI, 0 is a placeholder */
-static struct resource simatic_ipc_led_mem_res = DEFINE_RES_MEM_NAMED(0, SZ_4K, KBUILD_MODNAME);
+/* the actual start will be discovered with p2sb, 0 is a placeholder */
+static struct resource simatic_ipc_led_mem_res = DEFINE_RES_MEM_NAMED(0, 0, KBUILD_MODNAME);
 
 static void __iomem *simatic_ipc_led_memory;
 
@@ -145,14 +146,13 @@ static int simatic_ipc_leds_probe(struct platform_device *pdev)
 		ipcled = simatic_ipc_leds_mem;
 		type = IORESOURCE_MEM;
 
-		/* get GPIO base from PCI */
-		res->start = simatic_ipc_get_membase0(PCI_DEVFN(13, 0));
-		if (res->start == 0)
-			return -ENODEV;
+		err = p2sb_bar(NULL, 0, res);
+		if (err)
+			return err;
 
 		/* do the final address calculation */
 		res->start = res->start + (0xC5 << 16);
-		res->end += res->start;
+		res->end = res->start + SZ_4K - 1;
 
 		simatic_ipc_led_memory = devm_ioremap_resource(dev, res);
 		if (IS_ERR(simatic_ipc_led_memory))
-- 
2.35.1

