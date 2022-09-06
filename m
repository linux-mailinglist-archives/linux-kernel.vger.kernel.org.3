Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA05AE2AF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiIFIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiIFIct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:32:49 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2100.outbound.protection.outlook.com [40.107.104.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7BC55;
        Tue,  6 Sep 2022 01:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHzi/EgYHOnm65WWLFDjGU507q35qxU/kd9bfpNQma8v6nbdIiEwYHdv63Pv4Pu3jM+8Or+LzuGgUuisZMrkzcjKGcjPilaNGo9MQVRpDuByuJBSfCjgnAKK7hB4p59PYUs5t/L65Npm9HWOpju50gaTdqTFp9aB61HUVfdltfjibpv+xJY/pZW7EmSV3+Ka35vdjLPq8hNxI8yauQ/l14EMUB5SxU448I7vVw/mr+JEJGwaltBRB1Y2AIlFiRmIem7/POcVUvaA/+ZECWSbzosyihctUki45WpbHrUApbuuSVYlhMFa0PObK5ziKm43fKsGkWwzU6PIrXDmAREYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQtaHzLtdhz66TPXw+teJLdow93P14cRI2Mx/loWZu0=;
 b=UUP3AnQg4FIVDE4msoR+s/ck28/LBvplVRI17XdP0cQFANByN7XDLvKPZ2cTOcmRBF4OAUKd7rC6D+5vPQzArI0xt7T2dA0jNFXqOU4X87PGj5ESJ93i6wqUY0pidAQgZg/hzNMQl9tbeWlPC5rW7s9WWx5AMtaoGOZqSfMgRmRQrLafN70JJ6nHCqe67hxKq+I7P7cazrUCJU3eVh3/yUHB4U2S5mRMW9ZQcrruITjritYgruEs+hOs/gY3XzoWbS/gzyp76VQns+Ov2bwflWLbEDzOBmk76JztGr3svYlqszufwErqjamKx2sgWdlXbWdnzEWq89TSttR7EF+m8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQtaHzLtdhz66TPXw+teJLdow93P14cRI2Mx/loWZu0=;
 b=DfZX2847XxU89TmzprObv30HuaeQHLcP05EIbijg4FxJ4a6q8DfuS+45lxIcfsUDrHgvRzJz5FrJnNwMfhzEP96xL9WToXkBi+FqTJLHh/WFfMb5g2KxI3HYQHSGkahJGIaRy9mD++u/SA/dc7mgbn5GQUm/xEgcJUi7J22X2R8=
Received: from AM5PR0701CA0052.eurprd07.prod.outlook.com (2603:10a6:203:2::14)
 by PR3PR07MB8209.eurprd07.prod.outlook.com (2603:10a6:102:174::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.11; Tue, 6 Sep
 2022 08:32:45 +0000
Received: from VE1EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:2:cafe::ca) by AM5PR0701CA0052.outlook.office365.com
 (2603:10a6:203:2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 6 Sep 2022 08:32:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 VE1EUR03FT013.mail.protection.outlook.com (10.152.19.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 08:32:45 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 2868WfQp010192;
        Tue, 6 Sep 2022 08:32:41 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     Yu Zhao <yuzhao@google.com>, Joe Perches <joe@perches.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] MIPS: octeon: Get rid of preprocessor directives around RESERVE32
Date:   Tue,  6 Sep 2022 10:32:39 +0200
Message-Id: <20220906083239.10163-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 061ca4d3-def4-4348-ab08-08da8fe25f58
X-MS-TrafficTypeDiagnostic: PR3PR07MB8209:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roYfsdMEI/bC5FmamQUXQ0T9G2iK15+z2q1rHeTWXW0hYAgCAPrnRGnYLbIVabfc2z0MVgMMCwjmZX8yiSSEvq7Aqjtb9PRWA3CP2NG6XrwkucV8whvbrRHpmgxIhydtHddMNPAab5/luMqiGH3mr9Tl1FynHsY5xl1JvmHeGKDrYg4iGpxeE7pG2lMWHuNM4tF/d8t6shQU25dsyBRnybc5GcS2DioNXRL43idLzHJevK/xlAv1ZnLpNFxLyEc8RBEYQUS27Ed8muHrgVGCMfesND19JzC3Ahca8UupLny9heC21tuQvEBxEP34JztqDdK2kRaKcvAgWVt0MZeMi/srx/5NQPwyC7dgTPc6IVt4PtfogFwIfG3I4mLZH2rVdTzB5NywYEi5MSWgLTdNp0Sri8G/3/JpuycJ7XDhWqWq5zkhNh9BPkhEFJ1qgn0auEHhqrficpEe15O0yum9syt/Th4nDeH/jQ31GIMj4iPHV/z1mYV3WEoKD28Ac32aqaqDnxc5MW8Ghsf8pn9IfiwQEYBpoTy7oFNF+Dtg/SmDOsgtsDv0ENNjg9ezNVmT2JnMNbcLZ4H7EKOhWtFvO9XOkr+Qup5XLsbVQXscOCHxSW2lkRcPawy8nSK+NL81/5BVLL+XkG0mUnlhCoiWfgh++eYHZ9bdh+bJbpQXMUEFvxXDDvkrrRnH/5EhAKycRuXz6UZplWdRqH0Pkw1DiGkvmGO8x6H/C4ILfSyOLb7vxccRRTAwkOujncTpSqIV3TNAiedRImt7Mu/eaWcha9lJsdwayfpdGHi8AzUyitLJIyzv0JwQ9Fp8EEZQS9/wfolNY0yd962IBkr0dHI+8w==
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(40470700004)(36840700001)(26005)(316002)(36860700001)(110136005)(36756003)(5660300002)(2906002)(8936002)(70586007)(8676002)(70206006)(4326008)(478600001)(41300700001)(40480700001)(1076003)(186003)(2616005)(82310400005)(336012)(47076005)(82960400001)(81166007)(40460700003)(82740400003)(356005)(83380400001)(86362001)(26583001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8209
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Some of them were pointless because CONFIG_CAVIUM_RESERVE32 is now always
defined, some were not enough (Yu Zhao reported
"Failed to allocate CAVIUM_RESERVE32 memory area" error).

Removing the directives allows for compiler coverage of RESERVE32 code and
replacing one of [always-true] "ifdef" with a compiler conditional fixes
the [cosmetic] error message.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---

Changelog:
v2:
* Reduced the scope of addr variable

 arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c |  4 ----
 arch/mips/cavium-octeon/setup.c                    | 27 +++++++++-------------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
index bf13e35..aa7bbf8 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
@@ -57,14 +57,11 @@ EXPORT_SYMBOL_GPL(__cvmx_cmd_queue_state_ptr);
 static cvmx_cmd_queue_result_t __cvmx_cmd_queue_init_state_ptr(void)
 {
 	char *alloc_name = "cvmx_cmd_queues";
-#if defined(CONFIG_CAVIUM_RESERVE32) && CONFIG_CAVIUM_RESERVE32
 	extern uint64_t octeon_reserve32_memory;
-#endif
 
 	if (likely(__cvmx_cmd_queue_state_ptr))
 		return CVMX_CMD_QUEUE_SUCCESS;
 
-#if defined(CONFIG_CAVIUM_RESERVE32) && CONFIG_CAVIUM_RESERVE32
 	if (octeon_reserve32_memory)
 		__cvmx_cmd_queue_state_ptr =
 		    cvmx_bootmem_alloc_named_range(sizeof(*__cvmx_cmd_queue_state_ptr),
@@ -73,7 +70,6 @@ static cvmx_cmd_queue_result_t __cvmx_cmd_queue_init_state_ptr(void)
 						   (CONFIG_CAVIUM_RESERVE32 <<
 						    20) - 1, 128, alloc_name);
 	else
-#endif
 		__cvmx_cmd_queue_state_ptr =
 		    cvmx_bootmem_alloc_named(sizeof(*__cvmx_cmd_queue_state_ptr),
 					    128,
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index cbd8320..e7f9943 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -284,10 +284,8 @@ void octeon_crash_smp_send_stop(void)
 
 #endif /* CONFIG_KEXEC */
 
-#ifdef CONFIG_CAVIUM_RESERVE32
 uint64_t octeon_reserve32_memory;
 EXPORT_SYMBOL(octeon_reserve32_memory);
-#endif
 
 #ifdef CONFIG_KEXEC
 /* crashkernel cmdline parameter is parsed _after_ memory setup
@@ -666,9 +664,6 @@ void __init prom_init(void)
 	int i;
 	u64 t;
 	int argc;
-#ifdef CONFIG_CAVIUM_RESERVE32
-	int64_t addr = -1;
-#endif
 	/*
 	 * The bootloader passes a pointer to the boot descriptor in
 	 * $a3, this is available as fw_arg3.
@@ -783,7 +778,7 @@ void __init prom_init(void)
 		cvmx_write_csr(CVMX_LED_UDD_DATX(1), 0);
 		cvmx_write_csr(CVMX_LED_EN, 1);
 	}
-#ifdef CONFIG_CAVIUM_RESERVE32
+
 	/*
 	 * We need to temporarily allocate all memory in the reserve32
 	 * region. This makes sure the kernel doesn't allocate this
@@ -794,14 +789,16 @@ void __init prom_init(void)
 	 * Allocate memory for RESERVED32 aligned on 2MB boundary. This
 	 * is in case we later use hugetlb entries with it.
 	 */
-	addr = cvmx_bootmem_phy_named_block_alloc(CONFIG_CAVIUM_RESERVE32 << 20,
-						0, 0, 2 << 20,
-						"CAVIUM_RESERVE32", 0);
-	if (addr < 0)
-		pr_err("Failed to allocate CAVIUM_RESERVE32 memory area\n");
-	else
-		octeon_reserve32_memory = addr;
-#endif
+	if (CONFIG_CAVIUM_RESERVE32) {
+		int64_t addr =
+			cvmx_bootmem_phy_named_block_alloc(CONFIG_CAVIUM_RESERVE32 << 20,
+							   0, 0, 2 << 20,
+							   "CAVIUM_RESERVE32", 0);
+		if (addr < 0)
+			pr_err("Failed to allocate CAVIUM_RESERVE32 memory area\n");
+		else
+			octeon_reserve32_memory = addr;
+	}
 
 #ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2
 	if (cvmx_read_csr(CVMX_L2D_FUS3) & (3ull << 34)) {
@@ -1079,7 +1076,6 @@ void __init plat_mem_setup(void)
 	cvmx_bootmem_unlock();
 #endif /* CONFIG_CRASH_DUMP */
 
-#ifdef CONFIG_CAVIUM_RESERVE32
 	/*
 	 * Now that we've allocated the kernel memory it is safe to
 	 * free the reserved region. We free it here so that builtin
@@ -1087,7 +1083,6 @@ void __init plat_mem_setup(void)
 	 */
 	if (octeon_reserve32_memory)
 		cvmx_bootmem_free_named("CAVIUM_RESERVE32");
-#endif /* CONFIG_CAVIUM_RESERVE32 */
 
 	if (total == 0)
 		panic("Unable to allocate memory from "
-- 
2.10.2

