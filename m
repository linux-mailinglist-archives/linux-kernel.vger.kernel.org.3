Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F8559FE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbiHXPZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbiHXPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:25:03 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C7D9837E;
        Wed, 24 Aug 2022 08:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtgK0YF1O7Jsbp2ej+DI4Qj9Q3ocLw2azemJGEDrA2mXCohvNb868anSMtOg/92MWSAIgGimnkGyC0Nlqi7B7i9+1JCu7jbPBayBj1ykvpjW47tsBMmpQ9PVUhWroY12RPK7Ho18Ldl3o9ucmwiFKNm96vNjRmNeW1meBdvm4M37LAqaWp4JaD1hB7qYRmDIaTOCJpvWd+lN1ryqZgTSHPfAj61hBMvovj35OtAetJzl2tthkuFLFNd8jDHr7/AgLsbX/ulSjZCJz74ymhhl58J8JbrD+lvNamNuj5oAwy/ojThdbc8yETVjEdZpEY3Yu4Y4t/MYNIxzdpEk8qtz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI28A4FrPeOP9dqo7iEHeN5Xaz0ogKEewQ8CZW2bDy8=;
 b=R649zuY0U1QjteLIzFO6Hei+mu15PG+3GfLZhr/s0DBdpIlf+TS7lNQ8TH8BcTjfqiH8BlAfxPE07WZ5gePoPpHMeCNByOeP4aEP5153MYOAXSrKWWtpH6H2NQ0KAWDp7z7ylcS9ud90Usks+9fMKgqnqXOD1YpdAOZj7rbY5PIESf8n05zZv1jl/zI7A7UXTIN0oTguFBdCgUx7zYjVvTDzbdmO9coeh7oZZjMYg+1BYSYp9QSDkMMhF6zR5Ludb1wbK1hEnI8g8+J1d2nrfAdtajLKn98QWiGobF0hgfQUZ7uudZOhWayoCBUyjJZnXDHcq2ttEGm248/slNIprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=linux-watchdog.org
 smtp.mailfrom=siemens.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI28A4FrPeOP9dqo7iEHeN5Xaz0ogKEewQ8CZW2bDy8=;
 b=S+8AQlCegdKzrCnHIO4T4c60/7ar7YeWHfAJ/ekw4Ot1wI2sbX2XAaHWmySjIlKwtQUBdlBitznLqqd/ICPgpbr2+ZUBaeDlbEUl9QMJ3S67OQ+xlZbv5O+3xdRq7AMStMa97SHV+bn9knrNZwA6SApQL6CfZDL/2W2nq9aVD5nYTdy5iHj7EmEWSF3x/00nzVJeDoTA2vHbdSjs6mS3Gm2u+lRNElXcnHjMwoB8Bm9qTlIUJH4xbe+1muoNWjE3cTPwVJqPC2wnPjC4qe0JUNpKCBEx2sHZv6cmqcM3DeSI5NslacF3Ob5K3/RuaiugrmDAagOaFhkmMR+8UXNmKg==
Received: from FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a2::10)
 by AS4PR10MB5576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 15:24:59 +0000
Received: from VE1EUR01FT073.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a2:cafe::b6) by FR3P281CA0165.outlook.office365.com
 (2603:10a6:d10:a2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 24 Aug 2022 15:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT073.mail.protection.outlook.com (10.152.3.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 15:24:59 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Wed, 24 Aug 2022 17:24:58 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 24 Aug 2022 17:24:58 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2] watchdog: w83627hf_wdt: add bootstatus support
Date:   Wed, 24 Aug 2022 17:24:48 +0200
Message-ID: <20220824152448.7736-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.833600-8.000000
X-TMASE-MatchedRID: k5wM/XNuONYqFSncf8X1z/6cU5Ag0q/uACdiu6hUOTkrT6V6InEuV3qL
        r3o+NE+IB2QWi8BF5SiKW8BvXyLiE1OPRqTK0eJu09kDLefQujqGFN7r+9GAixo8wYJxWb0OjX0
        BChis2L2eEPi9wVyFrl8vPNhBIHcIKFlUUoQgfyuAMuqetGVetsgO3bswsOnS3QfwsVk0UbuGrP
        nef/I+esTZHiN20dwX/gKBLX9WFbKCN8k+5Dteqs09lNSVgfSqVuGAHHweLts=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.833600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 028F728188360FE64F2DDD1BD65EB077DE3CA1ACCFD2E48DEF974D170D6445212000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c82e0d6-d8b6-44a3-48db-08da85e4ceae
X-MS-TrafficTypeDiagnostic: AS4PR10MB5576:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogaXYwMeJ0wDdjJSBBikJXeTKX3B4pVvcMCYcE7s+dhLPgo9R5ghWAVjc7jbnpnUuHtZad7DkAwOlEhzF27c7jJCwH1c1YIbTwiEkkUp829hya3SHGV7D3LwfjLiQwByFcoAHEcouQEVtbn9VNMh44f/EvAaGizHZfv1cnhb4oNQafSHrREPmdhzv8oCRqLRH7nMcaSr4H2p5hpzkkOVvQQ40S/kfvJO1HNCB9PvcLibu11/cJHW3bh65nFk9FgSeXGGCWMXHWGAYz/qiPnjgQ8dDJwlB6L5I+Fy5/bYZ3Ff/GZA/KJa8+Grz9YDIBp+sUoLPW05GX5Q6C2Nh8qaClcrD8bGPjXJI6Hl+XaVDZNIeeJSvpgYAvwvJX/1iQ4J6jVm39tcslS2FDwZH7ynEa/U30fwRJjt8byO2cJura5wk/1Z+FT6zK7x2j0lQeal0DPM0zyp9hYcpIFiRlObTGWGaGvWoQOcsoh9GSLkNZinGlGPkUDOXk8ggc9IQEy6QI8LQiH9yqCwpFEGLpa+jK1x8+RANCL6ZZsfi+bu6UHcDZkqZ0ZM2WzCEc3FfpXEIHmv3EMXd4QXf+6RodgbgiDBd4kshLHOG1RVaBuDNePGN5F2wDHRrZLaDr7uSibvOUcHLEc8Vm4jfwycP0EBdeiPaPzL7hkivkM4tTCHVpyIPg3vT2SOZlcAEeGAvto+oH10LWYzuRl4V0rysjajusPxrhjkLyJJIF0p9SjCGHs+mv8DA5XXMfAU1JO2V0etkBXpaRIFETjJex1XzljPr90UYJJd/XvV8Qjx637afyVp2rZy0VSQZ1ciNnLs1GIjZ0Go+FATGvPfhLXAysrEszIP53zoY27Fmd1nuTgupDI=
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(40470700004)(36840700001)(40480700001)(2616005)(956004)(82740400003)(36756003)(83380400001)(5660300002)(47076005)(478600001)(356005)(44832011)(82960400001)(316002)(40460700003)(81166007)(110136005)(2906002)(6666004)(26005)(4326008)(70206006)(8676002)(336012)(16526019)(82310400005)(70586007)(41300700001)(1076003)(186003)(107886003)(8936002)(34020700004)(36860700001)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 15:24:59.2443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c82e0d6-d8b6-44a3-48db-08da85e4ceae
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT073.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5576
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

The status bit in the status and control register can tell us whether
the last reboot was caused by the watchdog. Make sure to take that into
the bootstatus before clearing it.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/watchdog/w83627hf_wdt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 56a4a4030ca9..bc33b63c5a5d 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -113,6 +113,10 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define W836X7HF_WDT_CSR	0xf7
 #define NCT6102D_WDT_CSR	0xf2
 
+#define WDT_CSR_STATUS		0x10
+#define WDT_CSR_KBD		0x40
+#define WDT_CSR_MOUSE		0x80
+
 static void superio_outb(int reg, int val)
 {
 	outb(reg, WDT_EFER);
@@ -244,8 +248,12 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	t = superio_inb(cr_wdt_control) & ~0x0C;
 	superio_outb(cr_wdt_control, t);
 
-	/* reset trigger, disable keyboard & mouse turning off watchdog */
-	t = superio_inb(cr_wdt_csr) & ~0xD0;
+	t = superio_inb(cr_wdt_csr);
+	if (t & WDT_CSR_STATUS)
+		wdog->bootstatus |= WDIOF_CARDRESET;
+
+	/* reset status, disable keyboard & mouse turning off watchdog */
+	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD | WDT_CSR_MOUSE);
 	superio_outb(cr_wdt_csr, t);
 
 	superio_exit();
-- 
2.35.1

