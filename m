Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89575AE19B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiIFHxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiIFHxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:53:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60134.outbound.protection.outlook.com [40.107.6.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74D46E2E6;
        Tue,  6 Sep 2022 00:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpdb0Dh12QER15CC/oqr9YrJt7Z9pJTCUI31C1nWgz0awDafp1g3RJD4ip4mxxO1TDdySUnFGbdpOEBm2cBHr9m6Wf4vb2JeLrp2mCgplLQo93mUDJRrNqbncHJIgcPGjyGCQ2K4StIkLsljgYd/ylb3uaBgvT4Ork/EVDKJPEveQ19nXqkqCnT4MOfYiCc/NWt7JfhldRAf28LgpbZ7v/yJ2XlQ8U74yV09Il8Mplc5NjPRF8Rj7oLPzqrSwgd6s2j3dlDmT+GvkR3VJK3apVBqEugV/Dr4IE2rmjWbcYKmA6Y74EvOKcEc0BEnvJkfBn1KLZEymFD1jqLdU3kCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyaL9Vlenws6UoDe8EeQ3rKlFuo/E78yLHtwX7zw65Q=;
 b=buP0vgpy7fcVjSs06HzAzhI6Y27XiMLDESJ6CcA5kLxkrvqjR5jASSMmanEiqK4jFEfaccnUBqHwvdUIQ5Mb0xLYfPXk/cGDxLz+wR2NWkvFgq4biTBd1SsyKQKQezZKZ9xcHxpeVMzC8GpAUEg5EU/a6ah86KF4FezTtwpeCILtsuO1BbIySWCgrwZOfra+6DG+AYE8FC6q+y8cQCwqaPFYNHrZBAVkLnsVeVQwX3VcRUadIj1uIr+hq1c8r/Q+i5sp9II0ePx5Ym4W0cAKGOq5y2Y+CvEY4uieS/GYjHSXLuSI3qJWI5P2t9LxUT8ZufcHskQ6Ri3moqTKkf6hug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyaL9Vlenws6UoDe8EeQ3rKlFuo/E78yLHtwX7zw65Q=;
 b=bVUxeAJI5gDOT8o2HUIt7fKMlr9F8n1X+ivTu6HPyOyauZMf6vRMTK+nkfOOMDvHvYDgSvcPWzRv9Cm7e7Gzu6e1mRpHQnCedy/4FkgHh1+T0W5lClcHiTSOqQHas7IdoU2ylCj2zAfyH92pkEnaZeucUcJ4eBfbL/55klc4OtM=
Received: from FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4b::13)
 by AS8PR07MB7541.eurprd07.prod.outlook.com (2603:10a6:20b:2a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 07:53:00 +0000
Received: from VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:4b:cafe::1) by FR3P281CA0063.outlook.office365.com
 (2603:10a6:d10:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 6 Sep 2022 07:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 VE1EUR03FT050.mail.protection.outlook.com (10.152.19.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 07:53:00 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 2867qu2L008123;
        Tue, 6 Sep 2022 07:52:57 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     Yu Zhao <yuzhao@google.com>, Joe Perches <joe@perches.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: octeon: Get rid of preprocessor directives around RESERVE32
Date:   Tue,  6 Sep 2022 09:52:53 +0200
Message-Id: <20220906075253.28491-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ca52c7c2-9393-4400-5e01-08da8fdcd1db
X-MS-TrafficTypeDiagnostic: AS8PR07MB7541:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4wO6/6b1O9hibATrTblotxgsFpyc5RXFFblXJt3Jx5M982v39WU8PBwwdJWg904KyBozhsNJhrhEQvBDe2ligjpREW/wxEY4m7027hCBLbWYMS78U7y61DbizPJ5QaJ2dNLvQZ2XM4we9xsogzJn+0te3Yn70Koru1FsRp+N1AIf3s0/DNJPsMY2+9ipEmmRenHCno3N2MBd9eOQ97SDgWJnRjsHVOh4HSIDckej5ITiOpJN487f16Rh5VR81SHF+TdD0oqW4gUsQaRIodZNrPHr6x3p/Vu1LUhLJ151HekhamipbN552dWRoravZjvNYv9f2/NxOO5KSAsWmvL6tEAhb8ivH54mjsCxQprz2flIXXCv4T3vi8Crcn2ZvUxrugsVX6ak4bC7g7GpvDBAP09vmoB/2mwCxTX11zCET5VXCYD0OzeWyJSbQ/R63yx7cM4EfmE1H2MWsot67YucHyDArayHM2jakti1QbM/1yaEPLDILyLGem+ck6uJ1nFjHTY7jyWL6PPds609RjJ91b4buQVUTZhONNd9sCOZ1sAiZSTmMSeT5eAAxpvHdmmADSWpwvL6a+xSo1XeDM0iaeiEx8rqP7rkNku81Y+2LmoXTVcKmH2AF3T8iqTyUsftxv51rzYRGPZu6gArAMDoVPF+WvcvigVrquV7oOMJgUCn7NsiJq27C70u8a732mDmwvsW5yiAcATLEXmXoNIQIYX7N+LZwX52/td0K3aUYJo7vU4rv9prbzYGwZ1UqnLkFWY8nPKRCGciGJNVck+ZwO27IbuqZ5pFtna+zQWxX0PkoRRIxlANeIoQXYfAeBO8mBQjV4mKPWE6BwaJpZdp/TLvWQSfL9mOEcpgTTRdXavASaY3XRpCRKbzWeK147yzZoLrQyusZwz7meFjCbLSQ==
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(36840700001)(46966006)(40470700004)(336012)(1076003)(47076005)(2616005)(186003)(40480700001)(5660300002)(8936002)(26005)(36756003)(86362001)(966005)(41300700001)(6666004)(478600001)(40460700003)(2906002)(82960400001)(81166007)(356005)(70586007)(316002)(8676002)(4326008)(82310400005)(110136005)(70206006)(36860700001)(82740400003)(83380400001)(26583001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7541
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Some of them were pointless because CONFIG_CAVIUM_RESERVE32 is now always
defined, some were not enough (Yu Zhao reported [1]
"Failed to allocate CAVIUM_RESERVE32 memory area" error).

Removing (in contrast to proposal [2] though) the directives allows for
compiler coverage of RESERVE32 code and replacing one of [always-true]
"ifdef" with a compiler conditional fixes the [cosmetic] error message.

Couple of variables doesn't justify preprocessor ugliness and none of this
code is in a hot-path.

Link: https://lore.kernel.org/lkml/20220830030259.3503212-1-yuzhao@google.com/
Link: https://lore.kernel.org/lkml/d5f8d6b58a32cdbf6326ccef7d46a58ba753edc7.camel@perches.com/
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c |  4 ----
 arch/mips/cavium-octeon/setup.c                    | 25 +++++++++-------------
 2 files changed, 10 insertions(+), 19 deletions(-)

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
index cbd8320..df45f76 100644
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
@@ -666,9 +664,7 @@ void __init prom_init(void)
 	int i;
 	u64 t;
 	int argc;
-#ifdef CONFIG_CAVIUM_RESERVE32
 	int64_t addr = -1;
-#endif
 	/*
 	 * The bootloader passes a pointer to the boot descriptor in
 	 * $a3, this is available as fw_arg3.
@@ -783,7 +779,7 @@ void __init prom_init(void)
 		cvmx_write_csr(CVMX_LED_UDD_DATX(1), 0);
 		cvmx_write_csr(CVMX_LED_EN, 1);
 	}
-#ifdef CONFIG_CAVIUM_RESERVE32
+
 	/*
 	 * We need to temporarily allocate all memory in the reserve32
 	 * region. This makes sure the kernel doesn't allocate this
@@ -794,14 +790,15 @@ void __init prom_init(void)
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
+		addr = cvmx_bootmem_phy_named_block_alloc(CONFIG_CAVIUM_RESERVE32 << 20,
+							  0, 0, 2 << 20,
+							  "CAVIUM_RESERVE32", 0);
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

