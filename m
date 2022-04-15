Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D66502E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346166AbiDORIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356160AbiDORIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:08:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3783EB94
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2E5+P6YLj3NwgNUgGAsR9ZHiFJ/V+5Shb1rlXoUe/gHLP0yHeqNE0SyV1utcyqklmXXCRBpf0RhVPFyk83/0Y51Htz8I4hR3npc8zxzcAwYsM9I5QXE0hfZS99fz7js9YZrxL6AD8/Tf9MQGVMYUjlYjJj0P73IWU2RNscXX1scLjX+JdcqMx5i+CDN6avQBZWPeaSijoZlZSaUdIAtjLBh/92CCRtixwESXR63uCtI2Vz1oxGkyzQtOd/m8qlIDuNXXhJ0Rl+wcIIt/4+IY2Bu4T/phFqfh8BgFqak4KIOsSm2rRSKdQFNvqtyZE+f9t4v+RiYaSKpaCyAyRZl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX11lBMIJ7N5GjwmlzH/h4wfGGxqjYHZujiFTK5xqPM=;
 b=T7UQNXyLmZKFrATgdrhLzK7tEPENC5jKAbZ+HqkEDX0WQspetRVnCI20Vk8Hysoa4tk7CAdwSijZ5EqOvlyZkC+LhZARQjQyhHYyJbBkhpybytlaiOFjKsLVE1mvPlzx8FSyfO2E6tjygey+YWlNPeFnm5MzsCH4LL6lUGaSGUN7DstaFLQWN6rh+Hu381NnHA3wQOlNlryJESK5wciarC7q8seX81PgcjZnVmH88LSMXiIKDg3Blg5ejDGLKt+jql9cy9j/SKe7geKNLU/QFeSxlcdUJ0TbC1zOIbAaOIQ0cgpZvsibQPfKT/g7VtTHHFOHH3ywhuhFTREjYZ0TAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX11lBMIJ7N5GjwmlzH/h4wfGGxqjYHZujiFTK5xqPM=;
 b=aS4OJMX+efGIeNmmZLh6GOCPtAueEWYOrtMY6AZBV00gY+iee1GOTPBVyRdXkhwnP9sxYZygKBrLkTWNUtYfVS/CMUWf+hK2kOxjZwee6ZVOssA+qIMgJlvwETXpyFgje7KK1fnNaIiAGzFa/HGHfluyTf7764+pF8enQ4KBbFBcTI8Pc/Sm60ZV+4NdG6yr26HY+HlRrMNe/hr7FFDTBjdZtxRrHurRsZ3CXn7UYZ8rb97pQi6SxIkdapyeDE1BFT9cS7TZMx3rkPeW1QsDH7Sr0mIH5hSlLZhcsL9gu/PogwJGyESFmWNLZ7ewyt9zFe7z2rKEpc6aFUaR1lh/yA==
Received: from BN1PR10CA0005.namprd10.prod.outlook.com (2603:10b6:408:e0::10)
 by BN8PR12MB3299.namprd12.prod.outlook.com (2603:10b6:408:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 17:05:44 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::f4) by BN1PR10CA0005.outlook.office365.com
 (2603:10b6:408:e0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Fri, 15 Apr 2022 17:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Fri, 15 Apr 2022 17:05:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 15 Apr
 2022 17:05:39 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Apr 2022 10:05:37 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        "Thierry Reding" <treding@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH] arm64: head: Fix cache inconsistency of the identity-mapped region
Date:   Fri, 15 Apr 2022 12:05:04 -0500
Message-ID: <20220415170504.3781878-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415170504.3781878-1-sdonthineni@nvidia.com>
References: <20220415170504.3781878-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee613615-18c3-406b-e561-08da1f022dd3
X-MS-TrafficTypeDiagnostic: BN8PR12MB3299:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3299C3440B722159C2CE48AEC7EE9@BN8PR12MB3299.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bubznelLPXk0QSE47JduUL5DNu6QKjLELB/J1lT2QSIe0uEen+BOXza14JjYulnpmsvvTP+IrAsBcmo/aWB/OTx3v5iDDGfep0rLehuC7spNaluoA+lJ84WaWY72ua9TTMOX0T9a2B+YXdpKfJOQUfc951S/F7m7aa97IPfgGHuD9hwe7tDH0EkBIGq+6+1LozotBNmvzyEkzArpeslDw6jNqGnz5mROVk9gRFy1uirRkgCTmzXe9kE+bj03BTNzOl9smm1Ko0JXasqg3tjvVtdGeV25HWUwUNe5NttAWWUnp15JzSL5QvtM6NMPMzSEjVeFIfCWFa2eVl/QtkmXXOgdq5YBgN5Pe6CAaV7l9NJFbkCnXQBZPiUfTKXcNIXqmKAwZBSSX/QPnAe8wCP5G7R/CUhSXezhcn7oH3zw0e9VH8VBp5t+62Q10iKqnosOlTLoTnOvIqQy1g41kTUZd0jMVAB0INnGvwNrDHpQeU6h/XhZx9BB+/VaWaDiRJEXqWM+hioEd7MyE8CtmH5CsvEE/yUkp3tYGY9LblCcqLYY1AJAZKU+IoNOcUKVCB+aZo56TGIO/8V059x542XWy2lujNnFHFnjk4kZknfRGh87crfK3pCMHYhqNPGlYEHuPwmlhq3yycfiDpUbkXURNjIpYVeF4AoOW/132Pwf4MJK42doPN5WbOb/zePynDk+kIL9HRc0x4McuGeVmDyJ2w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(508600001)(16526019)(186003)(426003)(86362001)(2616005)(336012)(107886003)(1076003)(70586007)(81166007)(36860700001)(36756003)(7696005)(6666004)(2906002)(316002)(70206006)(356005)(82310400005)(54906003)(5660300002)(40460700003)(83380400001)(4326008)(8676002)(26005)(110136005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 17:05:44.3728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee613615-18c3-406b-e561-08da1f022dd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3299
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secondary cores boot is stuck due to data abort while executing the
instruction 'ldr x8, =__secondary_switched'. The RELA value of this
instruction was updated by a primary boot core from __relocate_kernel()
but those memory updates are not visible to CPUs after calling
switch_to_vhe() causing problem.

The cacheable/shareable attributes of the identity-mapped regions are
different while CPU executing in EL1 (MMU enabled) and for a short period
of time in hyp-stub (EL2-MMU disabled). As per the ARM-ARM specification
(DDI0487G_b), this is not allowed.

G5.10.3 Cache maintenance requirement:
 "If the change affects the cacheability attributes of the area of memory,
 including any change between Write-Through and Write-Back attributes,
 software must ensure that any cached copies of affected locations are
 removed from the caches, typically by cleaning and invalidating the
 locations from the levels of cache that might hold copies of the locations
 affected by the attribute change."

Clean+invalidate the identity-mapped region till PoC before switching to
VHE world to fix the cache inconsistency.

Problem analysis with disassembly (vmlinux):
 1) Both __primary_switch() and enter_vhe() are part of the identity region
 2) RELA entries and enter_vhe() are sharing the same cache line fff800010970480
 3) Memory ffff800010970484-ffff800010970498 is updated with EL1-MMU enabled
 4) CPU fetches intrsuctions of enter_vhe() with EL2-MMU disabled
   - Non-coherent access causing the cache line fff800010970480 drop
 5) Secondary core executes 'ldr x8, __secondary_switched'
   - Getting data abort because of the incorrect value at ffff800010970488

ffff800010970418 <__primary_switch>:
ffff800010970418:  d503245f  bti  c
ffff80001097041c:  aa0003f3  mov  x19, x0
ffff800010970420:  d5381014  mrs  x20, sctlr_el1
ffff800010970424:  90003c81  adrp x1, ffff800011100000 <init_pg_dir>
ffff800010970428:  97ffffc4  bl   ffff800010970338 <__enable_mmu>
ffff80001097042c:  97ffffe8  bl   ffff8000109703cc <__relocate_kernel>
ffff800010970430:  58000308  ldr  x8, ffff800010970490 <__primary_switch+0x78>
ffff800010970434:  90ffb480  adrp x0, ffff800010000000 <_text>
ffff800010970438:  d63f0100  blr  x8
ffff80001097043c:  d5033fdf  isb
ffff800010970440:  d5181014  msr  sctlr_el1, x20
ffff800010970444:  d5033fdf  isb
ffff800010970448:  940f7efe  bl   ffff800010d50040 <__create_page_tables>
ffff80001097044c:  d508871f  tlbi vmalle1
ffff800010970450:  d503379f  dsb  nsh
ffff800010970454:  d5033fdf  isb
ffff800010970458:  d5181013  msr  sctlr_el1, x19
ffff80001097045c:  d5033fdf  isb
ffff800010970460:  d508751f  ic   iallu
ffff800010970464:  d503379f  dsb  nsh
ffff800010970468:  d5033fdf  isb
ffff80001097046c:  97ffffd8  bl   ffff8000109703cc <__relocate_kernel>
ffff800010970470:  58000108  ldr  x8, ffff800010970490 <__primary_switch+0x78>
ffff800010970474:  90ffb480  adrp x0, ffff800010000000 <_text>
ffff800010970478:  d61f0100  br   x8
ffff80001097047c:  00df10c8  .word   0x00df10c8
ffff800010970480:  000dfba8  .word   0x000dfba8
        ...
ffff800010970498:  d51cd041  msr  tpidr_el2, x1
ffff80001097049c:  d503201f  nop

ffff8000109704a0 <enter_vhe>:
ffff8000109704a0:  d508871f  tlbi vmalle1
ffff8000109704a4:  d503379f  dsb  nsh
ffff8000109704a8:  d5033fdf  isb
ffff8000109704ac:  d53d1000  mrs  x0, sctlr_el12
ffff8000109704b0:  d5181000  msr  sctlr_el1, x0
ffff8000109704b4:  d5033fdf  isb
ffff8000109704b8:  d508751f  ic   iallu
ffff8000109704bc:  d503379f  dsb  nsh
ffff8000109704c0:  d5033fdf  isb
ffff8000109704c4:  d2a60a00  mov  x0, #0x30500000
ffff8000109704c8:  f2810000  movk x0, #0x800
ffff8000109704cc:  d51d1000  msr  sctlr_el12, x0
ffff8000109704d0:  aa1f03e0  mov  x0, xzr
ffff8000109704d4:  d69f03e0  eret

ffff800010961850 <mutate_to_vhe>:
ffff800010961850: d53c1001   mrs  x1, sctlr_el2
ffff800010961854: 370001c1   tbnz w1, #0, ffff80001096188c <mutate_to_vhe+0x3c>
ffff800010961858: d5380721   mrs  x1, id_aa64mmfr1_el1
...
ffff80001096190c: aa010000   orr  x0, x0, x1
ffff800010961910: d5184000   msr  spsr_el1, x0
ffff800010961914: 14003ae3   b    ffff8000109704a0 <enter_vhe>

ffff800010970270 <secondary_startup>:
ffff800010970270: d503245f  bti  c
ffff800010970274: 97dab23a  bl   ffff80001001cb5c <switch_to_vhe>
ffff800010970278: 94000049  bl   ffff80001097039c <__cpu_secondary_check52bitva>
ffff80001097027c: 94000145  bl   ffff800010970790 <__cpu_setup>
ffff800010970280: 90001e81  adrp x1, ffff800010d40000 <swapper_pg_dir>
ffff800010970284: 9400002d  bl   ffff800010970338 <__enable_mmu>
ffff800010970288: 58001008  ldr  x8, ffff800010970488 <__primary_switch+0x70>
ffff80001097028c: d61f0100  br   x8

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 arch/arm64/kernel/head.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6a98f1a38c29a..b5786163697bb 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -462,6 +462,16 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	ldp	x29, x30, [sp], #16		// we must enable KASLR, return
 	ret					// to __primary_switch()
 0:
+#endif
+#ifdef CONFIG_RELOCATABLE
+	/*
+	 * Since the RELA entries of the identity-mapped region are updated
+	 * with MMU enabled, clean and invalidate those entries to avoid
+	 * cache inconsistency while accessing with MMU disabled in hyp-stub.
+	 */
+	adrp	x0, __idmap_text_start
+	adr_l	x1, __idmap_text_end
+	bl	dcache_clean_inval_poc
 #endif
 	bl	switch_to_vhe			// Prefer VHE if possible
 	ldp	x29, x30, [sp], #16
-- 
2.25.1

