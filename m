Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190104B4D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348825AbiBNKvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:51:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350186AbiBNKvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:51:11 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05294C084E;
        Mon, 14 Feb 2022 02:15:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibRUknoPRS3g2WdDLxRvQllWlx0Easnulwix0zHZ0JR1vviFLkJTga4e6MPxnftYJL4d63D8XjMtqkqBeL9iioUBAOCnNlahdjuErt2PqYF/A19Wt7EZPX29Xb/n0jXFtkGj9E18hbon2QLd95ZpGN/AU7Ml/fbvXP/cB59bc4Lp+iYYtFvkZqgcwN3SpEDxiARa2JhVNxaElwMJpRGG2axpY7/hDCSz7Z6+n4i/IFtK82zIgGe/ScQl1zoJRtdF4Gh2Mu2uiQfQ6j9EbbKgfB2FswI61tgA0iTwkvfd5RcBhdqm6aonHZ4Ymf1749QhmTinpBAdM0knGJB+MPB1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvYcUDPVfdmkbEVC7vT/3UsnY3wrJxo524uI4cbNrc0=;
 b=MXtYvuYLFYmKHk0CRMIcuqey3fVZKUBkQ+Kx7GsJ26fJm/LUuZYHcMTY/xQvqVCy0HDmhn6fczwfXufX0D1R7e0bWx9kcUQqA0LTl9z+2HUca+ghGDB0pFfeVCJ3ly23Aa7PFhP4EGwT10lrBGN0wETYak6C2daFffzj8wLg68pxaAqfeAYjvD6BxJc+gWC7JEQQCd0GUVgiIaEdxfqHnne99Uazc1rTC3WOTXYqvgvhH6CUf5fJ5hbc8nsHAP2WA4vzl2H/MQBTD2dltj9R1mDbsKT12AnGUaoonHk4Z2OoLoivLcGPlGD7m5xKJHEI3S4mkwaQe+lt8/aym0nkrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvYcUDPVfdmkbEVC7vT/3UsnY3wrJxo524uI4cbNrc0=;
 b=DFEeV4Kv/Dl6cOei5oSxUBTphAQBZQ5z65A08YfiAnyv3DE4sQ0RBbdVt6qYEzigW0SUy7BkpuSWMgGQtktZ0y19UBhhk9FiyKGpdX4sOlWOLMbrOY4dMHS72mIdZ33YsPeRn9QTT/7L5MIXExk/0kY7qRm1pZZOw82Jkf2fkXY=
Received: from DM6PR01CA0013.prod.exchangelabs.com (2603:10b6:5:296::18) by
 PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.18; Mon, 14 Feb 2022 10:15:24 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::fc) by DM6PR01CA0013.outlook.office365.com
 (2603:10b6:5:296::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:15:22 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 04:15:18 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Deepak Sharma" <deepak.sharma@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH 3/4] x86, sched: Expose init_freq_invariance to topology header
Date:   Mon, 14 Feb 2022 18:14:49 +0800
Message-ID: <20220214101450.356047-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214101450.356047-1-ray.huang@amd.com>
References: <20220214101450.356047-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b775440e-79e0-4bb6-3ef1-08d9efa2e97a
X-MS-TrafficTypeDiagnostic: PH7PR12MB5902:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5902E983B8730FC43DAB0AB8EC339@PH7PR12MB5902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+Zir3AG3IoOOs2p42gAqbTQMgRvjd3TOZdsZCGukIIZ7liAvEMpNY6IlLorp+bM5DypO7zRJ/bNy08/zbr4wWGlubti9kEnkt3MwOE3gofbO3e9ihAiBRdIL9Cuqxn4XGsJ2lYRivMqZkBn8NUw296fxIttXGJ4K2Wt0ebi23Qy+8Wv+zMWBds9yEz5wIZ++cwwPsCbQT8cPsGd4BxtS6EhHIaIpAxzNWsjsXu2DMnTnSV/j88E2Cu6zDZc6Omh+ySUjtbX7pjHvYRm4IFuK+B2LFIuTWzZ2ZHa6fXaxocABBItRbtf+Owa3mDrDxHC6lFpFO+rEyy+deGYT+fVnBmbTfNFN15tAbgqlWDzx0TDXJtQsTTkvRnD8UkvJmlcFI+2UmowAR4QTquIgTTs8qtjMHGVWuIE8KphKqCfxMv7ZeZcUl8eRI6IQgdgc9tIey3soPRLERjQv8/zQdyb1sbLz32cJVKyX037KNAw69PvLo7EwNpIY3saSq6uOOjFHnaRpvCOp1z/7RWJgJOO0UQRZnT9jUf6M8cQvXFu5fWPMQdDrtLxsI7LIh4Lj/yh7F6q/yLRMGP0+qfi8brlogBgMXe2HFQEM9shg9QLqylNtbc9VACfEf6f2Vrc0JzLUuuAcMZQUtHG2alvmu2Z2xTItVAhMUcS3X/TAo/oUrIUxb1pjKf3C57KgGZkhHGW2hyYbUVt/y8byCdN05XZOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(4326008)(186003)(70206006)(2906002)(5660300002)(82310400004)(8676002)(70586007)(86362001)(36756003)(356005)(81166007)(16526019)(83380400001)(26005)(36860700001)(336012)(508600001)(40460700003)(2616005)(47076005)(1076003)(316002)(110136005)(54906003)(426003)(6666004)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:15:22.9541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b775440e-79e0-4bb6-3ef1-08d9efa2e97a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5902
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function init_freq_invariance will be used on x86 CPPC, so expose it in
the topology header.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/topology.h | 4 ++++
 arch/x86/kernel/smpboot.c       | 8 +-------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 168ade7d4007..c35005a03768 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -215,10 +215,14 @@ extern void arch_scale_freq_tick(void);
 #define arch_scale_freq_tick arch_scale_freq_tick
 
 extern void arch_set_max_freq_ratio(bool turbo_disabled);
+void init_freq_invariance(bool secondary, bool cppc_ready);
 #else
 static inline void arch_set_max_freq_ratio(bool turbo_disabled)
 {
 }
+static inline void init_freq_invariance(bool secondary, bool cppc_ready)
+{
+}
 #endif
 
 #if defined(CONFIG_ACPI_CPPC_LIB) && defined(CONFIG_SMP)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0718cc7649a4..8f2ff9be0fcc 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -155,8 +155,6 @@ static inline void smpboot_restore_warm_reset_vector(void)
 	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
 }
 
-static void init_freq_invariance(bool secondary, bool cppc_ready);
-
 /*
  * Report back to the Boot Processor during boot time or to the caller processor
  * during CPU online.
@@ -2125,7 +2123,7 @@ static void register_freq_invariance_syscore_ops(void)
 static inline void register_freq_invariance_syscore_ops(void) {}
 #endif
 
-static void init_freq_invariance(bool secondary, bool cppc_ready)
+void init_freq_invariance(bool secondary, bool cppc_ready)
 {
 	bool ret = false;
 
@@ -2222,8 +2220,4 @@ void arch_scale_freq_tick(void)
 	pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
 	schedule_work(&disable_freq_invariance_work);
 }
-#else
-static inline void init_freq_invariance(bool secondary, bool cppc_ready)
-{
-}
 #endif /* CONFIG_X86_64 */
-- 
2.25.1

