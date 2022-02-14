Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B674B518D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351554AbiBNNWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:22:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiBNNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:22:21 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2139.outbound.protection.outlook.com [40.107.20.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B10C18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:22:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiGlS+34G7RlkEdjUC/8Fb3BB6U/MIgKHBMb74klgxCLWTb0fVsTC/yPeQZ30wD6g2Ic/Y/H3iJKbSeYRGe34QC9+t0L2twJznUFUrJSnsgLSR8oko/B8YJjxzxLiMmJCFa8/1bbLIgnlWUBH/4zdTntPpWLzaLtML4Pjxo5tjhq+6R6o+G/D8dv58Bs69LbfdKeliZ0GxNzaWXwBb/sNmpWSok29jmqAAJfjPSsRHTHJQEI81SktsZTOoXgCaSVcoK5yzGfvI0kc0EqRlfaPcE3Pm/Z7mKkZndP0OGFHgZLKGsGm09s2AqlSGethF3UdNVUDSBb95aDm97V/bdEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6srtl+LZ4IVPDKLUqTNU8l3DNO4sFIKX8nViemEogrE=;
 b=XvLiaQksT+rVqN8hferzMpBZI6es6E6wldbDl+10vy6XHJutnsX60O6HbRggiqiR3zkCqQsB3grTszuBDnxYC+3Kn2cssdJMLdDqtQ1OMygryEN9t9zt/ZrWG7RsSixdcfBuuHZX3Wp9hz0mIl2V0/wrO4zMvVSu2wHEU1sSuakQxQ706K2Kmm78Dg46/p9Sp7OdyZC0YMsNk710azRFdo+v+rgLRVFlCwxo2CVAg23U2NUpzvqyjYrvp0+Kpax2jELE3pu2XnBCS1zpjFWKuQB/XIT4K48D3KEI6+9sTa+Tv/wR5EPO5y04qYD3xgyfKYk/Nqb6utrXnLyvtP0Yfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 194.176.121.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sma.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=sma.de; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sma.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6srtl+LZ4IVPDKLUqTNU8l3DNO4sFIKX8nViemEogrE=;
 b=k8vP0zUp956g9I+/CPSouYBs4PwXKSjrjxiS18jeBcANOs0GFUlUguqjFUx8XkuU6UMg5CeuEwc/mtu2f2FvPY8sisDQZc8KUeA7bP4tBEPndN4xrjxiLwk10KGCBHu5kjbYzuF7NY8yJLU7hbSkd+WRDGtLD2mP0qvNhQ2Yy80=
Received: from AM6PR08CA0011.eurprd08.prod.outlook.com (2603:10a6:20b:b2::23)
 by DB6PR04MB3061.eurprd04.prod.outlook.com (2603:10a6:6:a::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Mon, 14 Feb 2022 13:22:10 +0000
Received: from VE1EUR02FT011.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:b2:cafe::19) by AM6PR08CA0011.outlook.office365.com
 (2603:10a6:20b:b2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 13:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 194.176.121.59) smtp.mailfrom=sma.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=sma.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning sma.de
 discourages use of 194.176.121.59 as permitted sender)
Received: from webmail.sma.de (194.176.121.59) by
 VE1EUR02FT011.mail.protection.outlook.com (10.152.12.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 13:22:09 +0000
Received: from SVR-DE-EXHYB-01.sma.de ([10.0.40.14]) by webmail.sma.de over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Mon, 14 Feb 2022 14:21:30 +0100
Received: from pc6682 (10.9.12.142) by SVR-DE-EXHYB-01.sma.de (10.0.40.14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.2176.2; Mon, 14
 Feb 2022 14:21:30 +0100
Date:   Mon, 14 Feb 2022 14:21:29 +0100
From:   Andre Kalb <svc.sw.rte.linux@sma.de>
To:     <pmladek@suse.com>
CC:     <andre.kalb@sma.de>, <john.ogness@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <senozhatsky@chromium.org>
Subject: [PATCH v2] printk: Set console_set_on_cmdline=1 when
 __add_preferred_console() is called with user_specified == true
Message-ID: <YgpXWQqjfJBISG1v@pc6682>
Reply-To: Andre Kalb <andre.kalb@sma.de>
References: <YgKSbe9d3haHKMid@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YgKSbe9d3haHKMid@alley>
X-Originating-IP: [10.9.12.142]
X-ClientProxiedBy: SVR-DE-EXHYB-01.sma.de (10.0.40.14) To
 SVR-DE-EXHYB-01.sma.de (10.0.40.14)
X-OriginalArrivalTime: 14 Feb 2022 13:21:30.0437 (UTC) FILETIME=[C74B9750:01D821A5]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32e1be44-be6b-4bbc-b58c-08d9efbd0138
X-MS-TrafficTypeDiagnostic: DB6PR04MB3061:EE_
X-Microsoft-Antispam-PRVS: <DB6PR04MB3061F80265E2CD359BA2B44EE3339@DB6PR04MB3061.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E94A74AXcdLAcqUrrRqG2KQ83cSuJMtYMvnjdcHxFcTASsIdXnFrQVGfTYZeVCVtITJgsf/ttsuqHrpYmM2E/Krufzqu5IfSgGGnkS7Rne5e/r/2pjZeDb/7csU122sVIgUM+zakGHH1HCfyP53diIZXrhHIXu5XQGsV4LmaaIXMQAnVwMolgK6k8sG0TadJCLgFLtiddniKHUx7ChHsIT6EzoDCCEB11aWj9h7vPg8dnQTwyxU9DYMFxnRL6JEexrgKFJ0YAOyylSGktKMAhEyxV6fQo8OEoFrTkS9TIn04JDCYPEu5c/F/BorNGK5LWiuLh48fj+IlODQshb0R17DzogdpHBmX+inVsNVXo41To9EMNN2axtKnyewCiAiFWEtR1UElA7FUFaPK1hxbHqtx5rEFmBdm6q1R+mcl5ka85za9HOlgCCe39rz7Wkv3Ws4DqC0Oj/+77ZLXMaCxFmMDTYabNcVP/9e7fKA03r8/XHd0VrRhaW2lXQ65vG2oV6ZwDlpNEBgI6J/eeJ2B8FqRMtaWQTfjRTqLe3hKLED5R9NsuRoIfr2U20nMIIm6l79600jQ4XYn6SsE5KQDdPMlUTHjyqAMV4PjxKgpbfj8tra3Br8Hm9IHh72Qe382qjo0jPc04mPElahDC3r6EI3B+yGXH5Ha43ugxuMTOch74X2PtUL81u23nZkFc8QS
X-Forefront-Antispam-Report: CIP:194.176.121.59;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.sma.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(8936002)(9576002)(8676002)(356005)(6862004)(4326008)(2906002)(5660300002)(81166007)(316002)(54906003)(70586007)(70206006)(107886003)(82310400004)(83380400001)(426003)(336012)(186003)(16526019)(508600001)(86362001)(33716001)(55016003)(9686003)(36860700001)(47076005)(26005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: sma.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 13:22:09.7205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e1be44-be6b-4bbc-b58c-08d9efbd0138
X-MS-Exchange-CrossTenant-Id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a059b96c-2829-4d11-8837-4cc1ff84735d;Ip=[194.176.121.59];Helo=[webmail.sma.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT011.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3061
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
---
Changelog v1 to v2:
Move console_set_on_cmdling into separate function set_user_specified(), which is called from
__add_preferred_console().

The old patch v1 could be used to backport to stable 5.4 and lower.
---
 kernel/printk/printk.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82abfaf3c2aa..3654695ca5d2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2324,6 +2324,15 @@ asmlinkage __visible void early_printk(const char *fmt, ...)
 }
 #endif
 
+static void set_user_specified(struct console_cmdline *c, bool user_specified)
+{
+	if (!user_specified)
+		return;
+
+	c->user_specified = true;
+	console_set_on_cmdline = 1;
+}
+
 static int __add_preferred_console(char *name, int idx, char *options,
 				   char *brl_options, bool user_specified)
 {
@@ -2340,8 +2349,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		if (strcmp(c->name, name) == 0 && c->index == idx) {
 			if (!brl_options)
 				preferred_console = i;
-			if (user_specified)
-				c->user_specified = true;
+			set_user_specified(c, user_specified);
 			return 0;
 		}
 	}
@@ -2351,7 +2359,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		preferred_console = i;
 	strlcpy(c->name, name, sizeof(c->name));
 	c->options = options;
-	c->user_specified = user_specified;
+	set_user_specified(c, user_specified);
 	braille_set_options(c, brl_options);
 
 	c->index = idx;
@@ -2417,7 +2425,6 @@ static int __init console_setup(char *str)
 	*s = 0;
 
 	__add_preferred_console(buf, idx, options, brl_options, true);
-	console_set_on_cmdline = 1;
 	return 1;
 }
 __setup("console=", console_setup);
-- 
2.31.1

