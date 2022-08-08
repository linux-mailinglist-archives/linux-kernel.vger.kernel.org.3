Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92A958CB0A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243164AbiHHPNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHHPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:13:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF06BF7B;
        Mon,  8 Aug 2022 08:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J28HJjOvjJVbK57bJ5sI24lx/N96//uieWB/NiQrRgW7KGZ2hj8NFFLA7zeIcJddsCE0zskqDmGVzko0Lsd1iD/PU5We37W1kW2XjSgzc4xkVB6k0V214+rlBWq1kAWeLyn0Z8QagHoUnwdnH5VIPozsT2RvhGeUMDLXUSL7cV76VJS/ZVtUurqkLiseMwCELTMhs/vDKs5Bfi0qZkjicQNu/yz0qkMd+k30/3uLW0Kz6YV16wbdnnW+1uK4M7ItNY7Ln1xybhxJXxyFB2J1cDTIQM9CR7J1dcHUNLDfaBXBn5DFAzByUKQLILbOW7aul4qKOIr3dNzYe0dRi0n3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxzeoB6v9hBhUXDCgy2PhOnqTT3CGYJXYu7rZIFMAA8=;
 b=bnWcbHdmkYlz23sQYWQB5kMmEIZpD5+4YupmjShg67Xkw+DS8u5C91TmWifVDtXKM2H0zhirqER0H8ghJuHUhnC6tiJY54NWw1AWPttSVLSdZfhfERrPqLimzTPwJh7sh3DAaA4vgBtHMuozUukusjh4vCjsrmkOW24Rct2qZPLLCOi2tMYW1mBXFUgkzqLLAge8qeOLZSU5c8L2DO4fAOYre7hVCkhk+odgi94bNKLSMqIg6NtENxxDKyplzVOs6NDhnuLwyAE3FKniG7xOSdu4EGGApNxlhDfBl4qWuQH+uzk2UONb/X2HrsEUnSxTGc9RTD6dPenRvDjUYIp/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=linux-watchdog.org
 smtp.mailfrom=siemens.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxzeoB6v9hBhUXDCgy2PhOnqTT3CGYJXYu7rZIFMAA8=;
 b=jXA1OSxOpcErRHtoHLgVWUWJtmt3w4UpxLkGHWWYAfW+qbNH6c+SrG6bekb/w6V5hIxaAzxzkgfGtB6gd5gRzkR2q67lMK1A1DFiH1uavjaRYQPm7IdldhTuMK+6nrGcvH87hEnKv4biO/6PWmy9PK3XSTrC3RK/g/e9ZFi9kjWWyZlshqM8hZmydhjlfDy2udEjad7c5P17AXh9GfgTbx4MvLopfCw0afyW81IOdnQK2DKJuu8NaEBEoev9uiAG7XGDDE1CP69MBCABdELwkcZd0AXS6tyx7TR4ja8It3EYHUwo1b5Yx8yybbkeSLI36MJBfHcLzQSSqb+lfBeJfw==
Received: from AM7PR03CA0014.eurprd03.prod.outlook.com (2603:10a6:20b:130::24)
 by DU0PR10MB5776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:323::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 15:13:06 +0000
Received: from VE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::ae) by AM7PR03CA0014.outlook.office365.com
 (2603:10a6:20b:130::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Mon, 8 Aug 2022 15:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT026.mail.protection.outlook.com (10.152.2.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 15:13:05 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 8 Aug 2022 17:13:02 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 8 Aug 2022 17:13:02 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH] watchdog: w83627hf_wdt: add boostatus support
Date:   Mon, 8 Aug 2022 17:12:47 +0200
Message-ID: <20220808151247.14893-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.932400-8.000000
X-TMASE-MatchedRID: ThXY+5ucIBwqFSncf8X1z8TdRbTaatC1LGmmJTL2jhwD2WXLXdz+AUcA
        1Ouvduu8SMg2Oe/b8EyfUDMAh2QVUQE2DjEevfnaKH2Br16x0Mq0Tit9+Kk6btWxbZgaqhS0a5K
        GiIX2maqbKItl61J/yfJvocwUrWp7XWPmaFoiyJsgBwKKRHe+rz0KLOdseNrKf0VfpLZx4hR80j
        R4aHVLSnNnCd3Hrhuwsuv6xiRRKlw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.932400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 96E14921677BF4E3118BFA88D896A8377F521B2EE24455B78E1F4B0C4AF3201B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9da6581-b56f-42c9-0d78-08da79507e98
X-MS-TrafficTypeDiagnostic: DU0PR10MB5776:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVJxbeuTQHsGrfdIjefgdt3EGWODN8613pIXMZcrgIPncRzTgvX7kAC1XJ5mnUmNzXBGVktn1RW1D00XCSDwBRr4BcrC+vT+mn6FQI3bc84x+qwfweyxDH92CkuDaf3z6iymbWrH60zX4KCccBQFLZ443V7ubfLHn0w2JeDeEzD4NeJhpuSl88q5dm5KaMSYPtUGfMDL7rEimHT93LDqNimHHSBscFGzqAoFsFvB13oBjXNbyj+vd1a78JdXkGuMta+VJkVw0st0PBSWne2hJ+yDYG+ShklJ1P2VDShrSaYazAtMsrDZ1mT47mTaODqtrCnJjnqwXDSR/6OA5Lu6VHurbKsdGncJnM9vadMYsQNNg9oxjpgpmdg5TE3dl786US6uGAaATB1LXHGSomZgR8nmp4fTaTPaeY+czo0Q4y2/XN3q3J7empFEbZo6fGxKZRaRC+DLEPdu8j9LArWhpLyXNZBKu/wtrgK7MhHiuqZRy6ZQPQgGt04S+qdKDlvBXe8S7LqrNeqNmm2KzLoPP/pnrxcjrY2rVJu5lWkGfoH3I/GPQ99y3PCsHR7yuUaJkiORjBLTZ9Z/VJvck0Wh89SgtN5XwEN23G7K3IM2Pb0z1GwHw/2sWpzJ0txRAP9bALsaLGRjMlVcSrVzqMFtNEWBLfa/Ib46ST1MNUCY9lcec5JL8J+Kj24bB12bJQfohwbBkXkRhQPfGfbDuaO7YUlwYYqmBp+yYqv8h+41Bw73YJiLV/Q/mzByXX74ylMR+mg6X9inidk+Yfo5KFhTBMcaQn2cNQrPUEXyZFPMp7JqjbkcWJqYhjr8gNv/ikENiPOtuSkM0Dz4o1ad6pj9PodX4h2CQ4k4OPFWByFpbI0=
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(40470700004)(46966006)(82960400001)(1076003)(16526019)(956004)(2616005)(107886003)(47076005)(82310400005)(186003)(336012)(316002)(5660300002)(110136005)(70206006)(2906002)(4326008)(8676002)(44832011)(70586007)(8936002)(478600001)(356005)(40480700001)(81166007)(6666004)(36756003)(26005)(82740400003)(41300700001)(86362001)(83380400001)(36860700001)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 15:13:05.4116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9da6581-b56f-42c9-0d78-08da79507e98
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5776
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status bit in the status and control register can tell us whether
the last reboot was caused by the watchdog. Make sure to take that into
the bootstatus before clearing it.

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

