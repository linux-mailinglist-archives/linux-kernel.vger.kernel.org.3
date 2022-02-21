Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F624BE68C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380188AbiBUQXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:23:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243235AbiBUQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:23:06 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20072.outbound.protection.outlook.com [40.107.2.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1072A27149;
        Mon, 21 Feb 2022 08:22:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a85jPvYUNyLH5Lzf3+IoGCndQQVZI+fchNO65ZxFwAioLEIzmfu1Z4rVLTrmQcBwiEKRLEW0w/UUO1gSQtSN37XyS773njDeDhx6x1JgigoCDsexfkUYDzKWEOvbgkh9A3St1gKOZLGwr2EbPp7f5gNG+waO+8jhknfEefv7JPvJhORuPtq6+uGOc+BwTq84WsZLD9vGeC6fdPUjEgoD8j0fJoHP+EoxpWppxLhsLoC9UtYEtVSlLFVyx/kvguoKthpHmYy7/zOrYz31a8u3iqMtGYtUznw0/m4Gi4JWgml3OKZHw1BcwTI1TDSpNsG3kWVwTAcYiBbc6RjUsnjATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEWWyS0NCKV+6Ta84DyWEp1yCU6hKuLx6RDIItH5aBQ=;
 b=IgR1SO29C2nb9Cnz5tA5MBujTT1dvM3f+ov1BbQJaCbVzfeFaXWyYn7MeGugagy4NdtI8+t6csouba9MLE34jHO/rRwL6RDbBOPaMU2ZldX2zCIn0/adEV4CYLouTqpSIYvP573jRtQnjT2sAQuKku9SpM1cxO9KPVq5zf/iba8qfUTyLCjuBrutPLCg4bdAumrvF4MIjn11v9cZDhiPv4ynxe6q6tY0LHifnkK1FSm9yVmiRPz32fAGRo+k7+QmBBE20vb+62XMdFVtHOyRF1o2O3Popuh2STAVWm6aMZjyTIWzlshTuUMsFTn13fVmWFgR/X1/7KQQexZeqUfc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 194.138.21.72) smtp.rcpttodomain=ti.com smtp.mailfrom=siemens.com;
 dmarc=temperror action=none header.from=siemens.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEWWyS0NCKV+6Ta84DyWEp1yCU6hKuLx6RDIItH5aBQ=;
 b=M0fZDI2h2zlRu98DPhb39dor2XJFf8Pgp2eRvBihH6s2FBPrSVld8pf/bPWqD43JIlG7WXu2q6RgFbopxQWL86N2aG6ViEUD3MzgPmNNhG5H0a3zqukX5JMeqoLychY0QHVTafpUQVv1X4IHrdHOQRCz7M04UA+3XvRDZVQ1AkMhAWO8illGFoMq+4ykgL0NMMH3KoRSzGYZTCReGrWCEOaMod57+aC/NRXUT68d2lXYnU39EHztTFOJBGX0vE5LCNRkEAhNzHeuzvRyk89bAgxjMNR9D1mjeB/SwMyCYPxUNUhLbUxCS4MDZ1ZAH7ycYICPvkBZs/K5X1sNhdW0gw==
Received: from AM0PR03CA0107.eurprd03.prod.outlook.com (2603:10a6:208:69::48)
 by AS8PR10MB4663.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:333::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 16:22:40 +0000
Received: from VE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:208:69:cafe::36) by AM0PR03CA0107.outlook.office365.com
 (2603:10a6:208:69::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27 via Frontend
 Transport; Mon, 21 Feb 2022 16:22:40 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 194.138.21.72) smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=siemens.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of siemens.com: DNS Timeout)
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT022.mail.protection.outlook.com (10.152.2.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.20 via Frontend Transport; Mon, 21 Feb 2022 16:22:39 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 17:22:39 +0100
Received: from [139.22.139.231] (139.22.139.231) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 17:22:38 +0100
Message-ID: <6a4b54ac-9588-e172-c4c7-b91d524a851e@siemens.com>
Date:   Mon, 21 Feb 2022 17:22:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] watchdog: rti_wdt: Fix calculation and evaluation of preset
 heartbeat
Content-Language: en-US
To:     Hari Nagalla <hnagalla@ti.com>, Nishanth Menon <nm@ti.com>,
        "Wim Van Sebroeck" <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <linux-watchdog@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.139.231]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e46a0eab-69c3-40c5-70fd-08d9f5566116
X-MS-TrafficTypeDiagnostic: AS8PR10MB4663:EE_
X-Microsoft-Antispam-PRVS: <AS8PR10MB4663D2817A83F7249E23639D953A9@AS8PR10MB4663.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhpMF4ebaKf8fre+iOJjLSFZzT1+tB6C1vfFc9eDCJIo14ONDjKPucDTQaeoBXJal9un66Hc0ACTGnqjzkqWDiZtHl2hE6r4utdHulEVuHFopVTyLJ1DWJzbvELdqGL/RRRbxwuM24THF0vlVuebVFD7xkTnD3GDtzyLHTCxzz87+zrubDxfv3OGIwseFzbeFdJRjZrhkSlR1/O0YeECogolM55ncQhISpwjR1w0vxWa/nHoWcIMaNjkTXVfYjdCLLoK328G6qPc4UvB+pUbmRBXfoZzhyXxv+Ksi0fN7a0HQhvLeb8X5CJm6lfMJqnZ3nFjKKtcgNJxIZjYlStcqy0ZvQeBhc6EN+ie/QfKCYaxqupwWZN8kp/hYviyVa1Agn4YOj3Ai+QeQN7WDnPFmFWQyXtR0zx9XQ0UdcYhCGu/Y5jW82jng5dT9o4oYvT4wnmZWDdeZ/94i84BpbgOrmA/9ajFUNKzYKV0mkbV+8TbQwTFmui+7QknGsle6QeoYgZ+IGkKMoq3IlZsHCKpx3VlIED1XjOfh/YDLhmnltw2jDqfHIdH548QZ+j//ZG25Zba5+uRWq5MaWtXkWTuWjUjfQ55n2s0r0kka8j85YtTtbEcNlbattV3MCeSGVNlDXyVe8fbGkEF69s2ywars6iM+47iqU0L4QonuG6+6ALjSynV7nMJG6vB/rsGzYzp6AHfg6SNJ0GjZQkxzftZFSOApDz7GdV/fK+KuaSYCARyXahhmxESTq9SyiE4J6YFlVWhPCm8E/KDW2djSS7HmNyHsGMnu0I2s0nz8+gziD9NhoJiAUuaAAYaHOqj34f0G1agnHMHVfdA2mI3+EGC11SjeWd41/mwgXJ5U4iV8WM=
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(508600001)(5660300002)(8936002)(82960400001)(44832011)(36756003)(2906002)(31686004)(186003)(26005)(86362001)(31696002)(4326008)(8676002)(966005)(110136005)(54906003)(2616005)(16526019)(83380400001)(63350400001)(63370400001)(40460700003)(82310400004)(70206006)(70586007)(81166007)(316002)(16576012)(6706004)(956004)(336012)(356005)(47076005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 16:22:39.4020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e46a0eab-69c3-40c5-70fd-08d9f5566116
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4663
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This ensures that the same value is read back as was eventually
programmed when using seconds as accuracy. Even then, comparing the more
precise heartbeat_ms against heartbeat in seconds will almost never
provide a match and will needlessly raise a warning. Fix by comparing
apples to apples.

Tested in combination with U-Boot as watchdog starter.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

To fully work, it also needs a U-Boot patch to add the same 10% margin 
to the clock frequency:

https://patchwork.ozlabs.org/project/uboot/patch/9b3603a3-1bf4-eb57-c378-20d5c2accc34@siemens.com/

 drivers/watchdog/rti_wdt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 117bc2a8eb0a..3ecd14e180fb 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -252,6 +252,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
 	}
 
 	if (readl(wdt->base + RTIDWDCTRL) == WDENABLE_KEY) {
+		int preset_heartbeat;
 		u32 time_left_ms;
 		u64 heartbeat_ms;
 		u32 wsize;
@@ -262,11 +263,12 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		heartbeat_ms <<= WDT_PRELOAD_SHIFT;
 		heartbeat_ms *= 1000;
 		do_div(heartbeat_ms, wdt->freq);
-		if (heartbeat_ms != heartbeat * 1000)
+		preset_heartbeat = heartbeat_ms + 500;
+		preset_heartbeat /= 1000;
+		if (preset_heartbeat != heartbeat)
 			dev_warn(dev, "watchdog already running, ignoring heartbeat config!\n");
 
-		heartbeat = heartbeat_ms;
-		heartbeat /= 1000;
+		heartbeat = preset_heartbeat;
 
 		wsize = readl(wdt->base + RTIWWDSIZECTRL);
 		ret = rti_wdt_setup_hw_hb(wdd, wsize);
-- 
2.34.1
