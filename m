Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3BC49EE60
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiA0XBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:01:42 -0500
Received: from mail-eopbgr00091.outbound.protection.outlook.com ([40.107.0.91]:27635
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229801AbiA0XBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:01:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuDXK/pSLbRMKMlYyhgldqjHezfpHur0FqelCOXDS8tlCZPOAgr/olF6617O+O+fKx2krYgTY/eU5lkk+D/U2Bwzr2Y/aPfhx8wcxKKeXD8Ble8410pMapCKe/Nb8BBN5w0lkxvDzxAZXPkGFaEDkNk0/Yjx/BDV6z+5nHJgusHKc8g9bZ8WTSH4RN6vjisIyY2vPjdMe+sfA7n892i5FqxvSt5mZIPApf8Y1xKL59Faukqov3oJ7X+mavB3GBKhrd2ZAZDXjrf2d3ruH5m5IOouZxkTUgq8CrLYMCvJYuDwi+clIHAC9kkNuxidcImOms2+LiGVHToFZJn2t1UXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV70892ULfZC4D2rutOz/ZTCtFW5DrbHovlS24aUWag=;
 b=DrZ4TM1SNeTNmZw3Bl6LBaeyu3kwqxzYp+33P8q9O6o0HPlK6dFfYzXPYvERacRVjKfNqLpJQ48nE2LTw3Qr+MRZ1lnsFHUH995D14IlwN5dXOPDUgQfWgWtZUxG2dlTlnSjCrBBAQXbNGhHNid6qxL9F6wktWmQ2/lLqtA3OAEQVFqu6IFA/8i5pLSGQ0qsq00xxHtBEV7WbIhllcDjZJtJaaHM9od9VLfiGaUMJciAqjDCW37QUNz4TezslW1z4LJ55Fjsm+PDEQa+Fjnq36phtLyz08JE38IW53mXqo4fGORz/+ETuW8uwEqj/TfDXnhGdejvl+DqkP0EpDPgVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 194.176.121.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sma.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=sma.de; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sma.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV70892ULfZC4D2rutOz/ZTCtFW5DrbHovlS24aUWag=;
 b=QgqOEEC3PY5vt5LcsmGhTKe9xIH5YfivtdOj7xMFsGu/ElQsznm4KJ+vJPRVIR3XdHD3zFv5CiOZAVi3fk0mx1sWYaTbC5lsThMfAFiP+xp5jjwEGY86uhEwc3JJ6VLOPXLVV4bm8AFQcYnmMNFVYeifQhWKwC9i1mCuhd7uTGc=
Received: from AM7PR04CA0028.eurprd04.prod.outlook.com (2603:10a6:20b:110::38)
 by DBBPR04MB6107.eurprd04.prod.outlook.com (2603:10a6:10:cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 23:01:38 +0000
Received: from AM5EUR02FT057.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::83) by AM7PR04CA0028.outlook.office365.com
 (2603:10a6:20b:110::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Thu, 27 Jan 2022 23:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 194.176.121.59) smtp.mailfrom=sma.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=sma.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning sma.de
 discourages use of 194.176.121.59 as permitted sender)
Received: from webmail.sma.de (194.176.121.59) by
 AM5EUR02FT057.mail.protection.outlook.com (10.152.9.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 23:01:37 +0000
Received: from SVR-DE-EXHYB-01.sma.de ([10.0.40.14]) by webmail.sma.de over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Fri, 28 Jan 2022 00:01:05 +0100
Received: from pc6682 (10.9.12.142) by SVR-DE-EXHYB-01.sma.de (10.0.40.14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.2176.2; Fri, 28
 Jan 2022 00:00:53 +0100
Date:   Fri, 28 Jan 2022 00:00:52 +0100
From:   Andre Kalb <svc.sw.rte.linux@sma.de>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] printk: Set console_set_on_cmdline=1 when using console=""
 or console=null
Message-ID: <YfMkJKUuGBwyT611@pc6682>
Reply-To: Andre Kalb <andre.kalb@sma.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.9.12.142]
X-ClientProxiedBy: SVR-DE-EXHYB-01.sma.de (10.0.40.14) To
 SVR-DE-EXHYB-01.sma.de (10.0.40.14)
X-OriginalArrivalTime: 27 Jan 2022 23:01:05.0552 (UTC) FILETIME=[C3718900:01D813D1]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6ae6ab3-463a-48c1-fd60-08d9e1e8f901
X-MS-TrafficTypeDiagnostic: DBBPR04MB6107:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB6107F1038CC013F7B4E02780E3219@DBBPR04MB6107.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9PrFx3/agpVhAScpoOP+80f5x4smaBa2f22TS+HUgUeFNjkPHBxEFNV5nWH8QkYS1bg2byEyQ7AAqE/t7I4Kjd7Jelo8KecM6EpYOsza+ayxqN42wmGV17/EaV9OLsOLFi9k5jzKRM/QejndL7xiwrgOzJrrSCjxQdn54y/n8rqnDpIDVzDEzIsS2fTAdCfFDCsIFROEU3Ex2DWmTe76jh8UM4erZqrQBjzT1t/ZDhx7qZERATqmhPYhEMhNj5ved6PLpQregKOBgAfBJnLSR1n0a7bcU4pX9YzJhUZhZ/LlDFKr+/gjg4T/Y1/4pN4wkZ0UGzhqqa8ql7K/WMO5OvqoCm8B7GUU5AAjCB8OdBhbBHeQDMOt3IxzC6Tg7ejdJq4NOi5oLHkkCXFq9Mz7uppJwrAObt886DBOfNdQ69dVAvUoox9WpOvCbTHvq7GvhbDyZirLg0Fbz0dT6IrT0ZjiSw+ePO9Wv4K+piZ/b3G8WgiTOZsqPaKK92c12Bn2d/cDOAzqMPQPxQ40SmtjqV0V5a9d64c+wYjNuxHErIw3DnaNT/BFZZl1tmnuzecxgxgyzfReOHRGi6RCZnQ3bPPVisr/2nAP4Mc/uaiGB2M9QxkEaM6rpUsAviC38Oln4zaK71kS7QpYOVJ2svib1m4XYcFT7RuVVK0gMUvS9CXwCQnYGzLBQCAOldt3hZQIlPbLeK1FuhZlbWk60Cc3g==
X-Forefront-Antispam-Report: CIP:194.176.121.59;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.sma.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(26005)(110136005)(4744005)(186003)(47076005)(36860700001)(316002)(9686003)(508600001)(16526019)(9576002)(82310400004)(356005)(5660300002)(70206006)(70586007)(81166007)(8936002)(55016003)(426003)(336012)(2906002)(33716001)(8676002)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: sma.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 23:01:37.5642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ae6ab3-463a-48c1-fd60-08d9e1e8f901
X-MS-Exchange-CrossTenant-Id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a059b96c-2829-4d11-8837-4cc1ff84735d;Ip=[194.176.121.59];Helo=[webmail.sma.de]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT057.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of using console="" or console=null set console_set_on_cmdline=1
to disable chosen{ "stdout-path" } node from devicetree.

To jump out from drivers/of/base.c, line 2087 of_console_check function
with false.

Signed-off-by: Andre Kalb <andre.kalb@sma.de>
---
 kernel/printk/printk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82abfaf3c2aa..df5ab35b8af2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2385,6 +2385,7 @@ static int __init console_setup(char *str)
 	 */
 	if (str[0] == 0 || strcmp(str, "null") == 0) {
 		__add_preferred_console("ttynull", 0, NULL, NULL, true);
+		console_set_on_cmdline = 1;
 		return 1;
 	}
 
-- 
2.31.1

