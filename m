Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E839557FC30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiGYJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiGYJRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:17:54 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2114.outbound.protection.outlook.com [40.107.22.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81271583D;
        Mon, 25 Jul 2022 02:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJGir8ekJVKA4fXVDLr4lbGhCp6hlEJpZ1yi8K8N/O2arwYrdZXgwz18YJ8TGzUe1NgFV4+4Y7F2Isx7QOQYHXCUcfy/b8wjWDg15rbBQkiR/aEEHyOdEo6TI2g7zvn9Da7f8gsUqCEsm19qxeL9H8Z4DnjeegSe0hzpJhriQan/R+RD+3kFxGIDe0C4XuiFVIl7uuDhbP/7Ah4MmfeMxZ37nIoVIsAtvdy5+PHyD3phvBjnz6gsVk5S5+xub759sLIputiISKIJpqA7PnwwSAKijFUCRP9xT5uyK4Kf7bu36vpdMMPCYiGXHse0qoPBsfwezeGdVyUbYIjniJLh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDDHpKTQZsSdqUMw5RvD1JgSMNMi21L6dQ1pctS65wo=;
 b=Q++utMuaHsLSRAGKNgTEM8Ot58cAwSCF2evZ4GLlYoD/r3kFD4gubHQbDyLrG24oqEi2yat2qyaCh4WnBpQS0+6SqVlrkL1bycERudjJg3pFNjit0/yDZ3V2IstIwGf9CveRNkG3JKTJqvkBkOji4dA6BxC28DrHueAJCuJ6ZFeeFrGBAxCkcWjf3KMiAcRyK7fV+PV1JGoGdSKzLaFcXHcag3Otc7a97MsqNAxpuTIMTkZ4g9E490cx6JlFiD3A3L2MxwyIXVHizi59Xjc3FOOstADiVWEJcyThOWA+HPLqaHvvtRVrOoCaxix/AwgLqyTLOeAVCpmtcFsW2RXnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDDHpKTQZsSdqUMw5RvD1JgSMNMi21L6dQ1pctS65wo=;
 b=mX0LN7dYG255S5y3yNd7QTRanfWvtVn4opxdechvwH+VyZ7+KnZb3fZ0tTd4ozIJZ2dyjBHTWt33OmTQ1aoFVcstUmV6/O+BI7ayV5/Sr9ieJWY5z9jLpF1/9i7U1EDz8h3d6iHykfZ6uSDYcH2MKwlzIcUW8Ed/GZDpqewqEw0=
Received: from DB8PR06CA0023.eurprd06.prod.outlook.com (2603:10a6:10:100::36)
 by PA4PR07MB8551.eurprd07.prod.outlook.com (2603:10a6:102:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.2; Mon, 25 Jul
 2022 09:17:51 +0000
Received: from DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:100:cafe::c2) by DB8PR06CA0023.outlook.office365.com
 (2603:10a6:10:100::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Mon, 25 Jul 2022 09:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DBAEUR03FT012.mail.protection.outlook.com (100.127.142.126) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 09:17:51 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 26P9Hl2O027302;
        Mon, 25 Jul 2022 09:17:50 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mips@vger.kernel.org, Joe Perches <joe@perches.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Revert "MIPS: octeon: Remove vestiges of CONFIG_CAVIUM_RESERVE32"
Date:   Mon, 25 Jul 2022 11:17:40 +0200
Message-Id: <20220725091740.28188-3-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20220725091740.28188-1-alexander.sverdlin@nokia.com>
References: <20220725091740.28188-1-alexander.sverdlin@nokia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9ec3f4fa-f957-41fc-4970-08da6e1e8cc6
X-MS-TrafficTypeDiagnostic: PA4PR07MB8551:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNL+WVM4nk8+NIyathS//zNlPpL3T6zT6pJBfWyDRa3/HVGLNwz0Fq4zi6yiS/FqSvOWGHPPjUWt7m+pVrAPzrA83C0rGrLRVrLeM05w9HRW3AuZdN+vFv7i6ZP5SxW7XoOHS9DRbW1Ui3A1Ap5381jDIz/GwD92tT9bMnRlgkddlBUeXAsp35NZcgTEiMV2yl8c87S6NXEnXzvAiljxmmHtHCH+kymp1WSulIZa68kXHN0oD0Jo1EVtH++3Bf49pByBfbyCG/kw6lXiY8voBCZXmhAwECYIO15UW9KBpV9vUtG4DHowh1Q9Ad/aRAjJsbBoKJCGn/ds2PrWUMD+gGXoD0NWd8He66Fn2CN5sehb7HV+ZBr4D1pGZEwEspg0C7pmA2dqJXnVyKwvl8Ko4ntAtVwCnxp6b4Kg05hcjui1uTK/IGzOEb6/0zJB2Fr2acUJO9zxTeL1qMcdqfpXWbEU52tGGn40j6nEC3Qsx/uZG07GLsNems9FEAQB8/KzwErT5G1vnEaOhhnPTDbl++6sc+6Lv0yD7rsVv8aH7cgG3iqS/1kz4qq03oXPvx5/Cb6s7ZvhcqCRZyTq/cO06454TZARFFTjAPobJKsXCHQ0zDmvxLOCFCh4MLHNgU4wU5KogGC3Qw2x5CJk9pz+CBWHSemOTr57VSEMu6mrsb5txtjtYQ1f5iUQMUEQntXLGJ4III0JI/28Rq5fcq+3zJngNsEklHQ6NwVwTtC1sa6/x9Fg9iA5IxtxW6gsAGyMvOroJiL/8WEwwzu9V7zIkPpshcF56AYFVhqgTiSswptsGqxYRL2E8l0hEK2kiMAjjmQeP9VY27zRtnDP3yPrDstVGZVxmgt1wNH3ue4Q7t1vyfroJxqGulGLeu4PtDAv0gA1EYCXHKCmChNY4C/yxw==
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(36840700001)(46966006)(40470700004)(81166007)(8676002)(316002)(36756003)(4326008)(356005)(36860700001)(83380400001)(40480700001)(1076003)(26005)(82960400001)(82740400003)(6916009)(40460700003)(54906003)(70586007)(70206006)(41300700001)(478600001)(8936002)(5660300002)(6666004)(86362001)(2906002)(47076005)(2616005)(186003)(336012)(82310400005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 09:17:51.5288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec3f4fa-f957-41fc-4970-08da6e1e8cc6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8551
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

This reverts commit e98b461bb057aaea6fa766260788c08825213837.

We actually have been using the CONFIG_CAVIUM_RESERVE32 and previous patch
defined it in the corresponding Kconfig.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c | 21 +++++++++---
 arch/mips/cavium-octeon/setup.c                    | 38 +++++++++++++++++++++-
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
index 20189e9..bf13e35 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
@@ -57,14 +57,27 @@ EXPORT_SYMBOL_GPL(__cvmx_cmd_queue_state_ptr);
 static cvmx_cmd_queue_result_t __cvmx_cmd_queue_init_state_ptr(void)
 {
 	char *alloc_name = "cvmx_cmd_queues";
+#if defined(CONFIG_CAVIUM_RESERVE32) && CONFIG_CAVIUM_RESERVE32
+	extern uint64_t octeon_reserve32_memory;
+#endif
 
 	if (likely(__cvmx_cmd_queue_state_ptr))
 		return CVMX_CMD_QUEUE_SUCCESS;
 
-	__cvmx_cmd_queue_state_ptr =
-		cvmx_bootmem_alloc_named(sizeof(*__cvmx_cmd_queue_state_ptr),
-					 128,
-					 alloc_name);
+#if defined(CONFIG_CAVIUM_RESERVE32) && CONFIG_CAVIUM_RESERVE32
+	if (octeon_reserve32_memory)
+		__cvmx_cmd_queue_state_ptr =
+		    cvmx_bootmem_alloc_named_range(sizeof(*__cvmx_cmd_queue_state_ptr),
+						   octeon_reserve32_memory,
+						   octeon_reserve32_memory +
+						   (CONFIG_CAVIUM_RESERVE32 <<
+						    20) - 1, 128, alloc_name);
+	else
+#endif
+		__cvmx_cmd_queue_state_ptr =
+		    cvmx_bootmem_alloc_named(sizeof(*__cvmx_cmd_queue_state_ptr),
+					    128,
+					    alloc_name);
 	if (__cvmx_cmd_queue_state_ptr)
 		memset(__cvmx_cmd_queue_state_ptr, 0,
 		       sizeof(*__cvmx_cmd_queue_state_ptr));
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 00bf269..cbd8320 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -284,6 +284,11 @@ void octeon_crash_smp_send_stop(void)
 
 #endif /* CONFIG_KEXEC */
 
+#ifdef CONFIG_CAVIUM_RESERVE32
+uint64_t octeon_reserve32_memory;
+EXPORT_SYMBOL(octeon_reserve32_memory);
+#endif
+
 #ifdef CONFIG_KEXEC
 /* crashkernel cmdline parameter is parsed _after_ memory setup
  * we also parse it here (workaround for EHB5200) */
@@ -661,7 +666,9 @@ void __init prom_init(void)
 	int i;
 	u64 t;
 	int argc;
-
+#ifdef CONFIG_CAVIUM_RESERVE32
+	int64_t addr = -1;
+#endif
 	/*
 	 * The bootloader passes a pointer to the boot descriptor in
 	 * $a3, this is available as fw_arg3.
@@ -776,6 +783,25 @@ void __init prom_init(void)
 		cvmx_write_csr(CVMX_LED_UDD_DATX(1), 0);
 		cvmx_write_csr(CVMX_LED_EN, 1);
 	}
+#ifdef CONFIG_CAVIUM_RESERVE32
+	/*
+	 * We need to temporarily allocate all memory in the reserve32
+	 * region. This makes sure the kernel doesn't allocate this
+	 * memory when it is getting memory from the
+	 * bootloader. Later, after the memory allocations are
+	 * complete, the reserve32 will be freed.
+	 *
+	 * Allocate memory for RESERVED32 aligned on 2MB boundary. This
+	 * is in case we later use hugetlb entries with it.
+	 */
+	addr = cvmx_bootmem_phy_named_block_alloc(CONFIG_CAVIUM_RESERVE32 << 20,
+						0, 0, 2 << 20,
+						"CAVIUM_RESERVE32", 0);
+	if (addr < 0)
+		pr_err("Failed to allocate CAVIUM_RESERVE32 memory area\n");
+	else
+		octeon_reserve32_memory = addr;
+#endif
 
 #ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2
 	if (cvmx_read_csr(CVMX_L2D_FUS3) & (3ull << 34)) {
@@ -1053,6 +1079,16 @@ void __init plat_mem_setup(void)
 	cvmx_bootmem_unlock();
 #endif /* CONFIG_CRASH_DUMP */
 
+#ifdef CONFIG_CAVIUM_RESERVE32
+	/*
+	 * Now that we've allocated the kernel memory it is safe to
+	 * free the reserved region. We free it here so that builtin
+	 * drivers can use the memory.
+	 */
+	if (octeon_reserve32_memory)
+		cvmx_bootmem_free_named("CAVIUM_RESERVE32");
+#endif /* CONFIG_CAVIUM_RESERVE32 */
+
 	if (total == 0)
 		panic("Unable to allocate memory from "
 		      "cvmx_bootmem_phy_alloc");
-- 
2.10.2

