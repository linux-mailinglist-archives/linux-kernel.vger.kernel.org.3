Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D350502E39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbiDORIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356125AbiDORIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:08:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0D623150
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kObF+EcmxuiVrFRIyYzSjytjenZc4fJQXu1hEOXQuZfZ0mq1vSQx1U3jNM8dFDZqw+q3uhi07V9zxkpny74vFijjcWdlwNzniVwka5hjIiBBcs8cg26+qG+OIYFYJzuJ/CqLECkeyowdxdxKUOihrqeP+cUEy5V8+c17q1j51LuseVATdzyHkT8B5+lcrEPYTStyK313HmRiuy/I1jOBzvO5QAWxbpNuivKJ5jxToVyAFSNzk9FcPhhftPpJQNaUu1qLMWePDBwrnod7Zv30c3d2mE6FNJoRR6iVqoQxVv1lEiX00+itcXfK7gfffQXsvwHltD8QzMvHK9C9QJb4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX11lBMIJ7N5GjwmlzH/h4wfGGxqjYHZujiFTK5xqPM=;
 b=Tz2rQ7KP4tfQ+eY8BoYlvvzLlqHPAmTNGQNr0SXR/WzCHOHQUeZ3yTsxX8uBZS23rAQl0FNCHbCtlvRxJ98kBp1du1Mnwg9EO8QJG+xITpNja4ISKEPL6yDjmbQAR85f6TCskWWqs8ZJqEN9D04ByuxJ4uBOH6hjv/Y+yo9SLf0H26nesU2s/9opqk9TfJ1JRm44M9/Q4Y0xcEunAzWnJD8Z9LR8Qvw5Lk8vUhceo942igPiCeiNuSToSfE7JDSiHdR6H/cgpH2CZNoiJL4/u14evbtpDxerSYz18vb3gkps2kCYXTh3ilpNLeIkepoWEzOnhMF1d3qdrSzpa+5P6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX11lBMIJ7N5GjwmlzH/h4wfGGxqjYHZujiFTK5xqPM=;
 b=qoXTg52Ja/r4AIZBrWsTFabqziWRebiBBkAZq6AiOwaz25ROX8I4sXkMZoHTu/N1QfzLnu5SW91vf3B4lLJ2PETw9nnstBSfJatBQEvmvGrneQ0toC34CGJ9B4FIOLyTfm/2KvonIfg8ZZEJzHvbXHbWxClyjQZlkWXb2ucyuSQ2Yr7vOFpR/CocsV/b9aXvgFfnGZC+knZvsMA4dWdweTkqwKSNoEq7yhOPGU0M46FWXSOLnZBeaJYT6xebDExLEYBWP58qcuy7UPMpghA/epTIiUua1Gifat9rQsfo9hz+iFyvrmppNwOVwH7hqFk7LQs+21rFhXxHhoCk2EVebA==
Received: from DS7PR03CA0332.namprd03.prod.outlook.com (2603:10b6:8:55::19) by
 DM6PR12MB3228.namprd12.prod.outlook.com (2603:10b6:5:18c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.30; Fri, 15 Apr 2022 17:05:39 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::c) by DS7PR03CA0332.outlook.office365.com
 (2603:10b6:8:55::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Fri, 15 Apr 2022 17:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Fri, 15 Apr 2022 17:05:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 15 Apr
 2022 17:05:37 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Apr 2022 10:05:35 -0700
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
Date:   Fri, 15 Apr 2022 12:05:03 -0500
Message-ID: <20220415170504.3781878-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a65fdd-159a-4a02-73d0-08da1f022a8f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3228:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3228D4D86993D6186D8223FBC7EE9@DM6PR12MB3228.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRKWwWEF+XPk1xNHG5WfgmEiOU3cAkCeKl8ekn/rBoIXmHpxriHNhqRzqbwn2ifJTJq2hIkBPYCVP+MX2iPdGpANWhDGA/IY88JQIZjyao1M69uFXIByzSgGWk7EuDI58brqOwlDw2S4Jj8Fm4yHOUml/TKsiCBgMxsxCSdZTHPmRr3bqfujflI0KrNcv1IbCArxwGkXjMgeU1x6Lcf0nIYr0y7EGSgIvUcMflUjfBB3v+sOXBs438TuM9TMqL20pJ6aE0nYiNvIRY3C3fPtNMHGFVtXExWtbrMl7ckqVWdPZuVVdbncTHsHBR9iPvw9URfqXEf0PTnepCKGp2muQsB+RXHUBGc2kG27jjycUeu8mAtAGqCpnCM9NHUl7lOtgLogcPzeSCGCFNyJSQd/Nvi1BqVAuwz0hPprACk73ZlsQdVkHC2eiV6iEpkqKlfMiXGioYsBZtohZX9jufBBiSdQ0Y4pKZn/vadC5qg4s5IfWJmY5KfosUxp21Yx2RvFEqT2w4Ex066E+pPSSE46SYVD2KC3RkxVM668lRv9TTLjbDFrgRQfVQQZ9P6iIcGWx4HyDvETpmTQYKxxoL5h9gw0esI170BIzDp4d9qsHc9/1OnmKwsLCFZ4dYiDLfjmRBMMlvl2X9d/WOVGbJ+fALblUwNV6PkEVrnS0gcIxxkyu+8qsp/W3+1ZpytirAl+glk60C+ooIuLTDCLPUfOEw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(8676002)(86362001)(1076003)(70206006)(36756003)(336012)(107886003)(8936002)(2616005)(81166007)(54906003)(110136005)(40460700003)(7696005)(316002)(6666004)(356005)(70586007)(2906002)(47076005)(16526019)(26005)(186003)(83380400001)(82310400005)(5660300002)(36860700001)(508600001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 17:05:38.9224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a65fdd-159a-4a02-73d0-08da1f022a8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3228
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

