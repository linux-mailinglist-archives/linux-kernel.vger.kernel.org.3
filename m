Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0917525DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378415AbiEMIh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378407AbiEMIhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:37:19 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3075D2631FC;
        Fri, 13 May 2022 01:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4aUSk4F1q8EFaLNZW8Fc4ckbLY2U40Pr2WlBscAEVTqcTOcVcWs4qGKyK3eYfBQ8yUSNlWMxaREuit4kjveGJJ8fhiAODciNWSejeHxKdQ5HwnPSx4Cetf1ty5WRSWODTXca+NRKBUgIbuAdUGA2CGb881KXg2zGHqOCb/yALzQA8Cz/GkIXyId2mFUb/lEK+lYBRvk+1ItZEO7qrvkjmhDXVdIYLVKyGE9+k4giBDI/ZGknwzHB2GHiPFB1mMTaKs8OwrQUtCe+BArJ4OMk9eFXvFynLwrH6szGIaFUELLq5HxOT55ROqNdYG5q5NZb9iJ26raVjQe2oTDO78RaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXb1Ul8YIVAW0UgrIv39CjhPnheGZruVTP2NTPcNEXo=;
 b=LcCoEf/WQgFzk2gYGWJjvkr9+6zU0ECya2DNt18R1YMBoZ4I2KNbenQcAGr/bX1kxt7rU7Pb/mbEDmaLOFWbbXaw+XY1lFpRH91mmglQz+dgvHYghuZKYFSatTyvBQArigyGbez/pOXOVQHl+0rRoCGkjx2EK2mvnmItikR7hRazlFa6T21/I0f87aG+4Fi2ad/hgeRhZExlmyJt3NxlhxUXNxkBPExKu6bIvfuWfGnXTSDFiaCx+pd47LLBtzJKPFfFB/+MBSaslc7VBfBWtGeEdzWblUhP8vYJzFpLTP9Whbg/y5P7q91FOuDP6mCJ/LM1c/eMvM8tjpeWTzsuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXb1Ul8YIVAW0UgrIv39CjhPnheGZruVTP2NTPcNEXo=;
 b=BA5WwtYQ84hHyCNHqgXjPAkExDytU3rQaixv+wGQpFZQpoc2e+0M6sVbdurzG/lPYec64oJ7i262j8rzxcMy5yh/7NNex41U+pzaLVgcg5SxiVzMTZFhb1UJ7HTTDaHThM1QYA+6W1pTidVutJAHV4RbEhkrhQkEt55woOwWWuBucI/D6dfhOGiQIY8uBpiYqSzbl/c1vkQhxpFAiwiN3oARNjRmLC4C81c8W9hVmIhpGxzGKiYP//yOIvjcr9/PE8GfeokPotqvNEcQC8kSyL4XFx3OE4yvPo3SVlgXnphN2D8ExUxWitAHYhWjOlWrqbDIu3yz2tn8WpVpiM22VQ==
Received: from AM6PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:20b:92::27)
 by AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:172::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 08:37:16 +0000
Received: from VE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:92:cafe::bd) by AM6PR04CA0014.outlook.office365.com
 (2603:10a6:20b:92::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15 via Frontend
 Transport; Fri, 13 May 2022 08:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT044.mail.protection.outlook.com (10.152.3.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 08:37:14 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:37:14 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.210) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:37:13 +0200
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
Subject: [PATCH v3 3/4] platform/x86: simatic-ipc: drop custom P2SB bar code
Date:   Fri, 13 May 2022 10:36:51 +0200
Message-ID: <20220513083652.974-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513083652.974-1-henning.schild@siemens.com>
References: <20220513083652.974-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.210]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e97dee0-8c15-419b-9707-08da34bbc847
X-MS-TrafficTypeDiagnostic: AM7PR10MB3923:EE_
X-Microsoft-Antispam-PRVS: <AM7PR10MB3923348CACA1C60B22FD6A4485CA9@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2P1eKoN7W+0vvNBD4uMb24W5l/eApqUNf6JmFUuwTOMOflxM2tFi3xtexlhfKTDFnOedzaMOZYgvF4cwENc3E5SDoijoOtED8vSJn5uL4MQhgvb+JtWlnLc7ULFR0NDgAoSgDd6tcX5pDVxzRQP+yvHd6v1Z4m0lPWlUA5+jmkwKygFRF05d/qrYCKUOM0+7mj6Vio4Zofk7r8Lf+/a/yJetfP5fmcfDA2TRTivtvfZpL3+b5mUyyMaHiWM03J6TRhasXKtB2bXkyQggczA+XBSvLuZmPPBd5/PGzAjktfzhgxYYj8OEtQmOySL4mXI8wWh8LOW2G/zkmzIKW7+giKTV4yquBSa4fFebi5CqFYJILDkc9m5DNoLz4BVWlBYhNOmC98GeTdeCs//Z/N0Iw1Af/elaH6Kg8I/yhW7mZPKsaqeq3vExG5TAWNMhuuUYpfLRJhBev8lZI+lAyTgdkj/hLIjbAmH/noR4lUvQgZ8nWaB/Y7liFCa9AHpB7Qm5eAxDxE6VZmMPHMsf0pEpp7qUAmhkHD0ISkPNoy6ns7m8YMaT3pTgUrDWBJeA5vrqWDL6CPLfNbJKvRB1y24jIK1g9BburbanGML2kiwxvSP+/FO1xG+y3stt3HEFf/wdrEWrawnsAgPRmc8ACi5LkG2Wg7nEb5jbo5m1jdAnNLl6JKWBgfZSQ9ULlA7vsCs+
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(82960400001)(316002)(336012)(70586007)(36756003)(6916009)(356005)(2906002)(6666004)(47076005)(83380400001)(36860700001)(82310400005)(8676002)(70206006)(54906003)(5660300002)(186003)(16526019)(7596003)(26005)(7636003)(508600001)(8936002)(40460700003)(86362001)(44832011)(2616005)(956004)(107886003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:37:14.9385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e97dee0-8c15-419b-9707-08da34bbc847
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3923
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

