Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2384B8612
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiBPKm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:42:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiBPKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:42:28 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130110.outbound.protection.outlook.com [40.107.13.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C24219233
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:42:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huEDEHkf5SYnPzrTJEvKGo1U9tqzUVjOJQy0mAuXQZ+2KcNPDfOt7dRRAh/CWo9mDDOl719FDcL9/8IPl3dfU5OYzYrcm4pwh6K+RyVlm29CZSff7Nbd+nEvCKJ1s/VUP5rFt79agw5BUwrGL/Rt4a7DNehLwkjxhaIUgfVl/RPewgnNoORereeAyrTUh+Nvd06QlDaeUouA+lmKxAbJIUyUo7rduc518tgJpcLVU6YBj4tqNEH+FbF8w01+bywR/FaihDHAkb3nCQveFllCT03Uw/ljOpGShhB9Gt7ymFgyI0t2HLjypM8k4O9XuVhhYIGuX8HM6guzU7DBqa/L+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbp6VbCklCPB3fvnZP3v0i3TGVe3sB+/Mjvs0Kw5Pqo=;
 b=drYKkWyEGiaX5Vm0tMU4tB4h5fazN+L+6JancCPZ3JOB/mBuwMZXQytHn24/qMLukrL7rjuUyBuBRQ7R+zBhOPMHQAAyCwm0/ULgNJEnn5qH5ccHYF69H2wEOg9LaJOIQmNnou48JJLtGRn+fjPgHQsHJkz7zpdSARh8HGIgPpoOOp0D5TMatsggcNDKC05yph0fsXexcEgwFor51Dd5jxsuGeP+oH/TNjkFvjWlupqUPuBxJ6zLcET5WfpxFlqvuDIX0GrlAZkqAgAG4nctcfT5Dj/lu536BoG1Wa/V4EPS3ABqtEm6uQn+FQXImvU93/oNP1W4wpEUJkHEebAXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 194.176.121.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sma.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=sma.de; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sma.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbp6VbCklCPB3fvnZP3v0i3TGVe3sB+/Mjvs0Kw5Pqo=;
 b=aSJX3v+82DY90i5T7th00+b0P2feGHvhFoNTOPpD8xzoon951nY2LYD2fQK7CTthXzhgp/cz5ssZcFiWaNpucNczoGWPOeBG+3W6aNYAPgGcdTAB1jfd6v1Xw+vEi2ol5sIHsXuU8NBcrorfLdss5mbkZctOrcv0w4vMDgMtmFc=
Received: from AS9P194CA0011.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::16)
 by DB8PR04MB6442.eurprd04.prod.outlook.com (2603:10a6:10:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 10:42:12 +0000
Received: from AM5EUR02FT044.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:46d:cafe::ea) by AS9P194CA0011.outlook.office365.com
 (2603:10a6:20b:46d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 10:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 194.176.121.59) smtp.mailfrom=sma.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=sma.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning sma.de
 discourages use of 194.176.121.59 as permitted sender)
Received: from webmail.sma.de (194.176.121.59) by
 AM5EUR02FT044.mail.protection.outlook.com (10.152.9.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 10:42:11 +0000
Received: from SVR-DE-EXHYB-01.sma.de ([10.0.40.14]) by webmail.sma.de over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Wed, 16 Feb 2022 11:41:39 +0100
Received: from pc6682 (10.9.12.142) by SVR-DE-EXHYB-01.sma.de (10.0.40.14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.2176.2; Wed, 16
 Feb 2022 11:41:39 +0100
Date:   Wed, 16 Feb 2022 11:41:38 +0100
From:   Andre Kalb <svc.sw.rte.linux@sma.de>
To:     <pmladek@suse.com>, <senozhatsky@chromium.org>
CC:     <andre.kalb@sma.de>, <john.ogness@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>
Subject: [PATCH v3] printk: Set console_set_on_cmdline=1 when
 __add_preferred_console() is called with user_specified == true
Message-ID: <YgzU4ho8l6XapyG2@pc6682>
Reply-To: Andre Kalb <andre.kalb@sma.de>
References: <YgxtGWh0b9NXTyu8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YgxtGWh0b9NXTyu8@google.com>
X-Originating-IP: [10.9.12.142]
X-ClientProxiedBy: SVR-DE-EXHYB-01.sma.de (10.0.40.14) To
 SVR-DE-EXHYB-01.sma.de (10.0.40.14)
X-OriginalArrivalTime: 16 Feb 2022 10:41:39.0130 (UTC) FILETIME=[C741C9A0:01D82321]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4fee116-a79e-42fa-5deb-08d9f138fd4e
X-MS-TrafficTypeDiagnostic: DB8PR04MB6442:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB64424D5E7746CB1F83E08E75E3359@DB8PR04MB6442.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q98WPEFmOmPi+iorOrfCfesConfAX0eXMgrEd97U+YN8hiL0zqZM1tWfTiGxMJ28WW08Jg9UefUWXOBzirZGhK6u3xD/IVtagr28JSPPybddrrTgcu0W0uWAWvbtPppjo2+nY9fxa3F7MOFMLr92B08tBu8EOez660c/G9RLxFP+R68lbG51qQwtgg7uK/I1X0WnjC04ZLZkODJdJpeh+SuQkHQkQoLtdfHEqAtb6WJAN3jQSPVWbVuqAdjQL0HXQDxoxpWP60pR3FeP8A2HMQn9vCZW1CzZdIEFiZN+sSsD1tKI3EYl9u3MVwFeSpGWpHfVYpkXcB21pTKsZjiNLAnQPMVJHLNbAVrAagZPdUnKKztMlojnEx4Jo5Q3zW5wxA7hYUbDv2XEhZzvFtc0tyF1dM2OQkvg2kzlpuGJ3yzFe3rU8VRgTgXGLLrzcpkDJnjt+34vNyndKLr0NRTFmt1zHPqlTLHH0AE8mETzAA8eN+iGunjgTGUBPtBQLnkKXfK5DtSAbNIvFXySPJKEmYYGRLzjqVWgXwCdimfLgWqyz8bWPeBpEV58+5qsednh1qiw3gpRrcpqbMR0IdPnn/6V6fF9eB1YmzJB37AqtimiCSGmqXldCVUPTrhtGiPOU14ArjUHTtts4+PF8f4LBtM7wneBaAM48PHgw4cRLe204mboAbDW/B9J54y3uRaUbPPdc1frQ3zwqO3ei/ek+B3aXmajFSnNDqwaKhO0DIoQhdmggQ67JtBIl3IUqmgR1fAl1R6RmaVaowfK/30M1w==
X-Forefront-Antispam-Report: CIP:194.176.121.59;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.sma.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(8676002)(8936002)(9576002)(16526019)(70206006)(70586007)(26005)(186003)(82310400004)(81166007)(356005)(5660300002)(2906002)(107886003)(9686003)(33716001)(47076005)(36860700001)(54906003)(110136005)(55016003)(83380400001)(426003)(336012)(86362001)(316002)(40460700003)(508600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: sma.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 10:42:11.9557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fee116-a79e-42fa-5deb-08d9f138fd4e
X-MS-Exchange-CrossTenant-Id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a059b96c-2829-4d11-8837-4cc1ff84735d;Ip=[194.176.121.59];Helo=[webmail.sma.de]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT044.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6442
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Kalb <andre.kalb@sma.de>

In case of using console="" or console=null
set console_set_on_cmdline=1 to disable "stdout-path" node from DT.

We basically need to set it every time when __add_preferred_console()
is called with parameter 'user_specified' set.
Therefore we can move setting it into a helper function that is
called from __add_preferred_console().

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Andre Kalb <andre.kalb@sma.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
Changelog v1 to v2:
Move console_set_on_cmdling into separate function set_user_specified(), which is called from
__add_preferred_console().

The old patch v1 could be used to backport to stable 5.4 and lower.

Changelog v2 to v3:
Add comment to explain the less obvious behaviour.
---
 kernel/printk/printk.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82abfaf3c2aa..e4e1a5266108 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2324,6 +2324,20 @@ asmlinkage __visible void early_printk(const char *fmt, ...)
 }
 #endif
 
+static void set_user_specified(struct console_cmdline *c, bool user_specified)
+{
+	if (!user_specified)
+		return;
+
+	/*
+	 * @c console was defined by the user on the command line.
+	 * Do not clear when added twice also by SPCR or the device tree.
+	 */
+	c->user_specified = true;
+	/* At least one console defined by the user on the command line. */
+	console_set_on_cmdline = 1;
+}
+
 static int __add_preferred_console(char *name, int idx, char *options,
 				   char *brl_options, bool user_specified)
 {
@@ -2340,8 +2354,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		if (strcmp(c->name, name) == 0 && c->index == idx) {
 			if (!brl_options)
 				preferred_console = i;
-			if (user_specified)
-				c->user_specified = true;
+			set_user_specified(c, user_specified);
 			return 0;
 		}
 	}
@@ -2351,7 +2364,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		preferred_console = i;
 	strlcpy(c->name, name, sizeof(c->name));
 	c->options = options;
-	c->user_specified = user_specified;
+	set_user_specified(c, user_specified);
 	braille_set_options(c, brl_options);
 
 	c->index = idx;
@@ -2417,7 +2430,6 @@ static int __init console_setup(char *str)
 	*s = 0;
 
 	__add_preferred_console(buf, idx, options, brl_options, true);
-	console_set_on_cmdline = 1;
 	return 1;
 }
 __setup("console=", console_setup);
-- 
2.31.1

