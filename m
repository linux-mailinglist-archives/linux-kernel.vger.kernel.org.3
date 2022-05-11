Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D365E523788
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbiEKPjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343835AbiEKPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:39:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ADE985B1;
        Wed, 11 May 2022 08:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKjZQxmJQ91QIE3UrM02HcFXkq+kQefm4LOAWHHP+XEgly7baWqX25fAnHAqWp3eh9fl0ayhFZ/DElbUWRr+3M6mbC9SyuwcWwe9qO0FIEldHFHiPagFL6rv+mZBp6xsWgfLRwe5eYODiq4bQm8LcnYuKmyqyHK7TkDtOxK5hLuizmDAGCaHLVzGI7VH3me1kPbf3oKgSwxHhH8pTEI8bDGagedjDGAA5Ve4E0gBch8TXF0FUIvz9ZjGP5pER0zNq2kDkxCz7g3EUbBToilrZ8McWmyf6ARONxSZEau212IKcVU7EoNy0lzk1lnp81ssWS3PAheR1jrO4or4q4rjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXb1Ul8YIVAW0UgrIv39CjhPnheGZruVTP2NTPcNEXo=;
 b=goqs5nfPXTf8qmYTd+8/Rla2kcCsSbeJedL60jY2PdLRnWgNSiZ9Zbb3/tnrbqoa0XrCzx5WG0kD36qceaMdAcwVfQqjR33T5QbT7XAM2G+GcG9xuJA+c3d1cG2YdSVH1ATXSEgRvmmdnB6q2QQ64G9ggjQg6ilPdfe2PJF1fEcWlaAzShjgeN6UuoTfs24ai4UD4DqJtdfNLgAgV9ITA9VfHo4vp99hB5pqhMpLq47s5axLKfngKXeud0cDMkQFuSrme4I+zzzX0VoyNhRTve/Pz5BQJdoe2wXYXODdavt/UAxVHWZbZcpmePzNzc/jKfPy8YgO4q8B3y/4F6/byQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXb1Ul8YIVAW0UgrIv39CjhPnheGZruVTP2NTPcNEXo=;
 b=OA3PHT7/wTblU7+kyMW8+0kz7lJCq+hmhxGuspN86T80BBCVnuoJNfk24x7Lu9Sfv6ac60IxZQCsUdhN44gInUyCsHe4+THCF/kPpR+qmKStkA7PPg8aP7oCm5K6ywl+sj11U929EPYjdQBs5JkDNiMSyIXIR6GQeKyZt1PA003RWDZfZ/+IAwhV7NLI1kgR4W9nqSg+DOGe3zktIjaHbdQXYyiAQWnYTW0+yQ0FDjiBi3+EWc463cosA2oMJcHfU3nM1tZzrbXzIdwONdQ54mKq92alw3OmwKLxL4o488djsYxLZBqT6Gu5382P8EH5vj8jKjINsPSzOozMDzl2Og==
Received: from DB7PR02CA0017.eurprd02.prod.outlook.com (2603:10a6:10:52::30)
 by AM0PR10MB2321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:de::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 15:39:29 +0000
Received: from DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::d0) by DB7PR02CA0017.outlook.office365.com
 (2603:10a6:10:52::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 15:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT096.mail.protection.outlook.com (10.152.5.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 15:39:28 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 17:39:27 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.210) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 17:39:27 +0200
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
Subject: [PATCH v2 3/4] platform/x86: simatic-ipc: drop custom P2SB bar code
Date:   Wed, 11 May 2022 17:39:04 +0200
Message-ID: <20220511153905.13980-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511153905.13980-1-henning.schild@siemens.com>
References: <20220511153905.13980-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.210]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 649e280b-b55a-436c-d183-08da33646f37
X-MS-TrafficTypeDiagnostic: AM0PR10MB2321:EE_
X-Microsoft-Antispam-PRVS: <AM0PR10MB23210F4B1E57522BB7F34B9585C89@AM0PR10MB2321.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKIy7ODJ5OEjyPob3ou8+75W2bgoHi6ETQLuw9txqm+er8pXI4y+6AXqr3X/nPLOq8g+JOnh1epkPXICJmajMoXvu1YqtOt9zGJtNY4PycVPpDMmfr/KARx5Rc7K1BWfITevTSvv3WYNFeotAKKjuIJaHzigUMT7fWsBC1jCUNfq+aMnVU3mRCpYwj32YdhzAB3VfJu01J0G5D5a1r3z+wGghQ0tE1F9OqTY4Wa89xopkYz4klVJxWcO2NGGlwdQWvvZczeWCk0KDaHWDZq9/tY1UOnH0ETLYuQlL15OlmFIo76JB1dWrV3aj7LOhysKR1QO3ug0Y/yc90GpBERcOXGqitJLnNV/L7N/VCAeNB6LgdvgIaaKC7d0MpOs1vGC5jaHzuk6yEs0ieEHqU48kZ+vKFcF57lRooTmlQgL1OyJumSq5hAIP6VkATpVnoCz7Dvuz1HW6DC9XaWut9/WPYW2XWMFRmtPdNNDDoZ1N5HM0nqsCmlA+VjcpjhdwShHJU/yrmTGRDLkgztDa2uxH4SiPzqtKWeL3d3odajDR3fUfd4WdqLJjbcaVGLUTwVEdEC0U+BlhcVzDSsyvv2pblu6zn2F24XgdmmGUBck95ORT+JAKctVdpODrNmCrUmEeqzWgHy23A072CA+sPpJ5NRcgklCLlhHWOji3WC2n2Grf0G7+WaW21W4y1Mr/5X2cNmEULjhK7dXEpXrhgjvIQ==
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(6666004)(86362001)(82310400005)(356005)(5660300002)(36756003)(83380400001)(956004)(8936002)(107886003)(1076003)(82960400001)(316002)(508600001)(70586007)(47076005)(44832011)(70206006)(4326008)(54906003)(8676002)(336012)(6916009)(2906002)(81166007)(186003)(16526019)(40460700003)(36860700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 15:39:28.1317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649e280b-b55a-436c-d183-08da33646f37
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2321
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

The two drivers that used to use this have been switched over to the
common P2SB accessor, so this code is not needed any longer.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c            | 38 -------------------
 .../platform_data/x86/simatic-ipc-base.h      |  2 -
 2 files changed, 40 deletions(-)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index b599cda5ba3c..26c35e1660cb 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -101,44 +101,6 @@ static int register_platform_devices(u32 station_id)
 	return 0;
 }
 
-/* FIXME: this should eventually be done with generic P2SB discovery code
- * the individual drivers for watchdogs and LEDs access memory that implements
- * GPIO, but pinctrl will not come up because of missing ACPI entries
- *
- * While there is no conflict a cleaner solution would be to somehow bring up
- * pinctrl even with these ACPI entries missing, and base the drivers on pinctrl.
- * After which the following function could be dropped, together with the code
- * poking the memory.
- */
-/*
- * Get membase address from PCI, used in leds and wdt module. Here we read
- * the bar0. The final address calculation is done in the appropriate modules
- */
-u32 simatic_ipc_get_membase0(unsigned int p2sb)
-{
-	struct pci_bus *bus;
-	u32 bar0 = 0;
-	/*
-	 * The GPIO memory is in bar0 of the hidden P2SB device.
-	 * Unhide the device to have a quick look at it, before we hide it
-	 * again.
-	 * Also grab the pci rescan lock so that device does not get discovered
-	 * and remapped while it is visible.
-	 * This code is inspired by drivers/mfd/lpc_ich.c
-	 */
-	bus = pci_find_bus(0, 0);
-	pci_lock_rescan_remove();
-	pci_bus_write_config_byte(bus, p2sb, 0xE1, 0x0);
-	pci_bus_read_config_dword(bus, p2sb, PCI_BASE_ADDRESS_0, &bar0);
-
-	bar0 &= ~0xf;
-	pci_bus_write_config_byte(bus, p2sb, 0xE1, 0x1);
-	pci_unlock_rescan_remove();
-
-	return bar0;
-}
-EXPORT_SYMBOL(simatic_ipc_get_membase0);
-
 static int __init simatic_ipc_init_module(void)
 {
 	const struct dmi_system_id *match;
diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h b/include/linux/platform_data/x86/simatic-ipc-base.h
index 62d2bc774067..39fefd48cf4d 100644
--- a/include/linux/platform_data/x86/simatic-ipc-base.h
+++ b/include/linux/platform_data/x86/simatic-ipc-base.h
@@ -24,6 +24,4 @@ struct simatic_ipc_platform {
 	u8	devmode;
 };
 
-u32 simatic_ipc_get_membase0(unsigned int p2sb);
-
 #endif /* __PLATFORM_DATA_X86_SIMATIC_IPC_BASE_H */
-- 
2.35.1

