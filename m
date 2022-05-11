Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D42E523780
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiEKPj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343818AbiEKPjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:39:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA6C95DC4;
        Wed, 11 May 2022 08:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNZpduJ76zwVCywRQv5wTuR5wPFZiUl5ysAWwAkvHdJs0wzCNCpn6sbCnmY5ffmA3WwK0AnRnJOE9rtyejvKf5r6qbHMFlDaLFAwTAkil5S6gwn23kBX37m13QH2hejStECm25zOFOOLfQTUk0owsbVFJLZ+45Q+buKLKnM3UAXFsZ3wyv6naDjPbbZ9HbworX0M0WdDPZRIxoGSl1Q8Z23mGX+y2dGCp1s16ZVehlA92LpYq+/Rm5DuA6HM4yoESxIyLnkrSfoTg1lk3VHxZPtdSy0834ZTqO3eJTVbDdFyROhHDmNmEo9aBigPzNi0Pd/GywCVUg+O2A2JnhFqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuytOf2M9EtJUoFZOAAwTVMKOQ8vD32V79Bo/CtPEZ0=;
 b=hwYA6M3MIQ3vv+inPpc0xJWNQiPBom2ZE6Jl9jaBqwF1Kra3DpoGQiXEOV37QoOEejVESbpVQABqxzWrAVdVIHmJKfUFOjNuFxNgCgEN6vH4tTghoPDa+GduERMs5WLARkBOwCuEeeteK1JXSBhlrrs8FYi1ncGJ8BE3Q1x8Dy06EKtmEOCIHjK+qGQ/2oP4AIlhR8FKKmQ0+jWlYHKXyygY2Ep+06L1M1fQlE0CuR6UqSnj+6kLvWQ4HRykuWigs99AlQQyvmw+i3/Pu1b824lTIqfCIyYo03PM/tstFzHB1XwTScB0CVuQs9s8MhBGOrRFHos9k4nIIWZpI25eWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuytOf2M9EtJUoFZOAAwTVMKOQ8vD32V79Bo/CtPEZ0=;
 b=COhDEnXVBl9Ac1J0V+IcDOkwaDZom1fp/ZlhJPsbtn7Pp2eQMe3tZw28MJB0H5Wsu3+qP1O6OvZq6fR6qKKSvMAh52yCjR5WkXkzcbDAPvYm/+RO54dNN8KZ7xr+cg3BBehsqXXBrrAuKcsmjhQapMd/VeT8CxqlmQoTai1M9OESbKniLr8ze3ev78RAUaZ05dWVpqZ5p02KI6Jv4TuG6IvKgd9YLzB48+BEjCrLsdD545G9ItFVERVph68RK7poEDGlb+KtcrtSp/XYbfGkFP9pnIWh9Ntq1SlqhPyBewJtObSZ6zZVYwaZCZqVaXGdpA4y4Rdb8SOTuJQRe31n9w==
Received: from DB8PR03CA0006.eurprd03.prod.outlook.com (2603:10a6:10:be::19)
 by VI1PR10MB2783.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 15:39:17 +0000
Received: from DB5EUR01FT056.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::3f) by DB8PR03CA0006.outlook.office365.com
 (2603:10a6:10:be::19) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 15:39:16 +0000
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
Subject: [PATCH v2 1/4] leds: simatic-ipc-leds: convert to use P2SB accessor
Date:   Wed, 11 May 2022 17:39:02 +0200
Message-ID: <20220511153905.13980-2-henning.schild@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: d08ce2d7-fd0e-4e6c-f0c7-08da3364686b
X-MS-TrafficTypeDiagnostic: VI1PR10MB2783:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB27832BA5F3AC4B2488E6A09F85C89@VI1PR10MB2783.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AeS7qy4Pbw2lxYIhIOgJYU9eAN/KAvTZ8kiKtSzfsXkdc7is4+5QlN2ShSEyPViU1dxciH5ZqilcBI20WWECcDFpZY9U1zlWUf01hOjraHz3Xgj05uI6Qn00mM9OQbGCYyT0wIY5f++BBxORqHtN2xYXpsRpWypTMEXQbhTyVvoBR/XOZUGtOGqrwo0AD7Km8gaPcS7VYcrEyGqiwLrGeonN6v7ejBoidYXyC5i0hH5orJLrhU4R+ZTH0VfJ/uPN+idJAldFqrKirzbDyX5jK263CV/qAdXbdc+AGtWG+rK5DHSYFvpyAahfjWAzsWPp4YUlRJPpyFGWMj6fPOTeUEnFhdWmmX6tkUBuY2QnPBic0l1XWyWKJhe4ks4tdefbYidsqxXnUdEe9d3jri+/yw3zHQJ2RSyx8QpGaaup2/rrhmqAX7TRCJuHyYBUxjs0hrZf3ISxench+U5cTkWD8tvoME1tn81hHcouv7ZVIGlIz+vbuPWe7pN7pXYp9YLDR0yoKj5aWRAL0greerMVPN+2bd0Qorpyg6ZnRgYxh0uiluAX5OuB+jvkADaWlxruLVY5y1+0O64w9G5s71Tx4T6BW8fjLHKYB9Vfr/u98YGM1v0TYbdsgnq75gz/IzSnx6oN8fbTKEPIFiMI7p9ylJqw37tqkbCqPsZ8p0euSvZpj4jMB+E/gbd9iTRvgPfNIih9GxVLG1qxoHYQgYyKFQ==
X-Forefront-Antispam-Report: CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(16526019)(36860700001)(186003)(6666004)(356005)(336012)(956004)(107886003)(2616005)(26005)(1076003)(44832011)(2906002)(36756003)(47076005)(82310400005)(40460700003)(5660300002)(82960400001)(86362001)(8936002)(54906003)(8676002)(70586007)(70206006)(6916009)(4326008)(81166007)(316002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 15:39:16.7258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d08ce2d7-fd0e-4e6c-f0c7-08da3364686b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT056.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2783
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
 drivers/leds/simple/Kconfig            |  1 +
 drivers/leds/simple/simatic-ipc-leds.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
index 9f6a68336659..9293e6b36c75 100644
--- a/drivers/leds/simple/Kconfig
+++ b/drivers/leds/simple/Kconfig
@@ -3,6 +3,7 @@ config LEDS_SIEMENS_SIMATIC_IPC
 	tristate "LED driver for Siemens Simatic IPCs"
 	depends on LEDS_CLASS
 	depends on SIEMENS_SIMATIC_IPC
+	select P2SB if X86
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

