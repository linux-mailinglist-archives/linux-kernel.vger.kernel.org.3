Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8755046E648
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhLIKMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:12:03 -0500
Received: from mail-eopbgr130110.outbound.protection.outlook.com ([40.107.13.110]:23271
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233163AbhLIKL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:11:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km80ZZ3UAXvK+KO+TP3zGDt5Hie5XY/IIqKTXxoZhmGvX/AqgWZg4sy9CHxA/VQbbWJAv4CQIVTy+CQdyuibS8sTTlXrZGPSu+5kYDDQWCc4mf1g2NyKhm8NnUYbglonB1wYCnCXfurX+CRWOG/b9ZEFX3IT+5GjcNaJDFOrsaTgi4mjDuCfHS7aP82dlCtuzhWM8iw7wAQlj4BXWluZSuVIw8XprhuFHCuyB3HeuSmQB3BiGHUdcxkGVN+Q6YswlxOr8h8PA03sIdnGAvTCte7xFJ3D/AjHZM25Q1PTD+Re4GF/OI70nCBZ63+d3NvLaxKt4yYrIlOnPVo0IKPfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIGDkm+XX0RwKVhcNI57y2sTlIQBCcvKIfcL+VtKeCk=;
 b=nqT9/ah3xF+t24Vyoa4WBhcnW4nA/zGyhAr4EbyS7e6NfNJlGoCRICsCCkGdEsYGYlF7RvfrojF3TohcThY3Cm0oPSC1WGOBZv41kJhPJd35gNtBE5u4WWMporVoUCPWeO15PS/KVOlvEsHvmVHkulIat78+AF5I/ezmM5KBQfkn6AvnuPqnP55Dpys8AsRsATVRD7kBGn9t3afSosUZ/Nm1z3jYSNC5Fl8lUfrRHV5EXTHusSRFFWKlXjwKSntvkrM3cXK5oOm+TSd9DqM2KgKbP0VeB525D/TENYPl8a6xuYz4dqXWO9XvL/o8ZFuj0hM5vDjJcarH8lw3XTsSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIGDkm+XX0RwKVhcNI57y2sTlIQBCcvKIfcL+VtKeCk=;
 b=yF/5+s2Cyso5gA8FnCt4Z2W2yYngoAbPZQ1apt8rzDE9v644NxiX9U/vvop5F5dQXVOHjynINgZ3Vl3Nw+Q19Dd+XGBawHYnVc1akJ/JiRwDl1f0MJHOF2Jo77eyjMowSzvSs+ApseFnL+6qlfjPSj3oxAbSkPhM6LywsMyS9ts=
Received: from AS8PR07CA0049.eurprd07.prod.outlook.com (2603:10a6:20b:459::30)
 by VI1PR0701MB2413.eurprd07.prod.outlook.com (2603:10a6:800:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 10:08:23 +0000
Received: from VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:459:cafe::a6) by AS8PR07CA0049.outlook.office365.com
 (2603:10a6:20b:459::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Thu, 9 Dec 2021 10:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 VE1EUR03FT035.mail.protection.outlook.com (10.152.18.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Thu, 9 Dec 2021 10:08:22 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 1B9A8HIZ012620;
        Thu, 9 Dec 2021 10:08:20 GMT
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
Subject: [PATCH 2/2] mtd: spi-nor: micron/st: Hardcode erase_proto to 1-1-1
Date:   Thu,  9 Dec 2021 11:08:13 +0100
Message-Id: <20211209100813.61713-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20211209100813.61713-1-alexander.sverdlin@nokia.com>
References: <20211209100813.61713-1-alexander.sverdlin@nokia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 69eace52-6816-4594-7c36-08d9bafbd538
X-MS-TrafficTypeDiagnostic: VI1PR0701MB2413:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0701MB24133327F9BBF75423C4AC9288709@VI1PR0701MB2413.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hjFBoENe52jmTQ1LH5HpZ/Z4xIoexLJbYnjl2meVBJ7IZdmODZzxG40A3FYhyOHB7IxRnVHIe9yH/rBbcddN+8bAB0T5E2cyz+tnDZQrkKtU1+K3aOIC78RqK6TWR8w2WLMFRfaq2xYmxxrvH4UTqgfOt07b8nPp6YMHCVbPrH6rSduDAAtMPF2AHx6NUltUzqmPL9XrGzfr7BwBapD2uMFsMfa29ICr1iQIp47k81ZaFZzipYcPNVtipvwZuAcj3D+6U/xZQY2yTJanPqETh0l9Axlz4HduDKe5OtpOlaWBKvflZ13x5VrPo9sumicN6j7P0IVjXsO7xGGavqWchgAiNR4Uzy5aeKQX6v1vgKwSwBfnwf/lX0zypve7jttumSlZrqCDolOYVQrStP66DZ19v/RkSVqkr3mpg6OrOeSbYku0y13X/U71lE2TFbgmtTbC81Zb225A1mjMtJ2R5xb5pfqn7+EeoWdkw0287cW2yOCGuhb7pADb+sZIX6fowKFhjaCBRlxGXOyC1r2GaeLZEWVPss+D8qCnBw0+f6Mt4vZ7kBRhdJbgnIrAOwe9UbuguqkzOi8LVWXupxpuJwBbdwaSRm9+L1gIhtlOlsNiKmQfiCoNe3BY2SMJGjK6uM1+S7ysBHoCjONrNyx1gHXjvevVj2iFsTBal5zc07wvmezPtwqgo0pHew/3oj5ISJxQQQ7x2zFZ6UdW/1IaN791yo7dkWOYTzMuNpS9DIKpKJm5VlDjGjiJYavnxhzHXZWqKzfLc6surN57VhBHLLG1ZMzJeyFML/TlSAGgkS6LpUPNamQTKqP9tHC6tQUzEardosjiSegtRSfPoIIRQC5t3IuHH5ODLRAME3RPoY=
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(26005)(82310400004)(8936002)(356005)(70586007)(6666004)(70206006)(82960400001)(36756003)(316002)(40460700001)(2906002)(6916009)(54906003)(8676002)(81166007)(5660300002)(508600001)(86362001)(4744005)(186003)(4326008)(336012)(1076003)(2616005)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 10:08:22.5504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eace52-6816-4594-7c36-08d9bafbd538
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2413
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

This fixes sector erase on mt25qu256aba8e12-1sit.
Looks like others like mt35xu512aba could be affected as well.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/mtd/spi-nor/micron-st.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 2f3054b..058bbb7 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -267,6 +267,12 @@ static void micron_st_default_init(struct spi_nor *nor)
 	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
 	nor->params->quad_enable = NULL;
 	nor->params->set_4byte_addr_mode = st_micron_set_4byte_addr_mode;
+
+	/*
+	 * mt25qu doesn't support all possible write protocols for erase, only
+	 * 1-1-0, 2-2-0, 4-4-0.
+	 */
+	nor->erase_proto = SNOR_PROTO_1_1_1;
 }
 
 static const struct spi_nor_fixups micron_st_fixups = {
-- 
2.10.2

