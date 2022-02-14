Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9187D4B4D24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349263AbiBNKvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:51:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350208AbiBNKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:51:12 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4297BC0856;
        Mon, 14 Feb 2022 02:15:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh+hPIfzNbiQ6Vb8LYU3i1MHmV4pFsbDd8mJlWwm/O7aagnGR1oizujm3NmvnaZTOLrKoJJ6b89p4F+OhCwNa0OKi2IvVQRwbZctjsUUPfMh3SEXROUlZ6O1+LcwYoJHTa3HbOM7XdxFgn3uOg6aBqn+51iQV46uritf0dckNEzZZD4kpdWBCLb407HER7vjvnmperjo8p8f3DsT82LrkTytrdxbH0uEIyRj2JYUqMUm34KYtkfav4UaxRSM/iwym9Csmkmw9HtztyzI214pJBtJbwjgg7m3VKvdoaoXbeLUqRlR6KJfuoDpqGfOnbYLov5rO4D+0WRoXP95vo9ALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPUrtHrY6l9SV5qiNIJagpflLiCnn8P9tSXYd3+Fi44=;
 b=Z9AhIV3tGit7APptwF5opO0lE0wSWsSJ0nE6SWm3Wrm9V8OLuDduRlGge9KgJ5jzPzAmVLPsvJ6qCnned0Hh7ES93C8jQF/UaN3xSVbAmRhI1U4vX8e4rrYlHfFdQqSja0PLQcPLycQD/V65QcB66CUVEcXFbsjGfWIhq+rb3kpcVpHN0btk11EMOvkLY5DwPTapajNz8da4dYKs+8FB7E2LHQ2GZ305CSwBT6RN2yclXCKik7PPp7wniwa5/8Cp1dmp/df/pK8KiC6t0He95wQ+1V9B31nTCHW93h00dJYL3TfPT8eF3lsgetgwskSHSH8u8L5Emb+1+CZW4Fi2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPUrtHrY6l9SV5qiNIJagpflLiCnn8P9tSXYd3+Fi44=;
 b=rfC1/iZj4he2UFBvh8h7EX10XVDoi7sXz/Mr3xv99O6rK1s2CJdR+L+QUYb1VDjvqehPK5y7ON8Q8O6PV0jEvrsUnWR0LGETL8p3imnb9rBzGKsqu/FFRpSOvf4bcOEozNMVS31XbKVFDYo376Ta+uC9+6BaAX++Tz2+vZJixy0=
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 10:15:27 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::11) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:15:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:15:26 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 04:15:22 -0600
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
Subject: [PATCH 4/4] x86/acpi: Move init_freq_invariance_cppc into x86 CPPC
Date:   Mon, 14 Feb 2022 18:14:50 +0800
Message-ID: <20220214101450.356047-5-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d4bc049d-d84e-4457-9cc6-08d9efa2eb66
X-MS-TrafficTypeDiagnostic: DM6PR12MB4299:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB429972201C4DDC2E36578C92EC339@DM6PR12MB4299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixNVc46Ycy0RI17lxDk01HNLxFQteUWguPCmVeahe0vq6DIvm1OGIIf73eFwCZu8fEwGFT6OdSsU9dgmvwSMH6HyG1jQfvsdnHbepG/x2azaSVEpSgIp15syHHC0I2QgQ5lIJjSEmvnsH8X2wkQ5AaRWheiVQhv1IhRmZP9jBopAJIZB+JIwWEpqZhGkXdCebRYQhMfnnvqB9j4Xx0nolS5V1uzMwd552JtNNK5xXzpIwUfGvbbUQy70s+kKjh09+gNeWr/2yKfSu9Q+C7BvMzjpRNf1NFQ9pE757MgMoePtkKrb24chtlj4dZSBcp74pKx4i6cJeSs8HgoLXo2PI7NZwywcZIALbxImyD8EwNKuZzchWhGjnFrZPFMlbad2/F6fsDJg1+45KwEERp5jqPMb8ZO4QRghyh3v3EA9JxdPShHl3ApgIJuU3a8I8t47h6HskqbBDwpp828EePWTcRXA1tmGCzmcg7fiNgYkV5GO8Z3+15fjwcQ6PLrONh69QsviAt0b0DF8ddohAzrf6synv5ch9tDWyz/junU46499quEIflLouQMeYNy2T4NlMHqUHnaJJWNFr5JvnKixfqd2oqixkQTuAHDKUgl2zweXjacMpe6qdhWFI+PavTKXp5dwsFkeBxWW9UQJH6MN2AmlPX0h4Gnq1HNhL8NnqXrblCFaZ6fWNBeeBhz32Fj1/dACMbZI6PdvZHvw2v9Z+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(2906002)(2616005)(83380400001)(82310400004)(356005)(81166007)(8936002)(5660300002)(86362001)(40460700003)(508600001)(70586007)(47076005)(6666004)(36860700001)(4326008)(26005)(186003)(7696005)(16526019)(316002)(54906003)(110136005)(8676002)(70206006)(1076003)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:15:26.1809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bc049d-d84e-4457-9cc6-08d9efa2eb66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The init_freq_invariance_cppc code actually doesn't need the SMP
functionality. So setting the CONFIG_SMP as the check condition for
init_freq_invariance_cppc may cause the confusion to misunderstand the
CPPC. And the x86 CPPC file is better space to store the CPPC related
functions, while the init_freq_invariance_cppc is out of smpboot, that
means, the CONFIG_SMP won't be mandatory condition any more. And It's more
clear than before.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/topology.h |  4 +---
 arch/x86/kernel/acpi/cppc.c     | 14 ++++++++++++++
 arch/x86/kernel/smpboot.c       | 20 --------------------
 3 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index c35005a03768..9c73d62f7276 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -225,12 +225,10 @@ static inline void init_freq_invariance(bool secondary, bool cppc_ready)
 }
 #endif
 
-#if defined(CONFIG_ACPI_CPPC_LIB) && defined(CONFIG_SMP)
+#ifdef CONFIG_ACPI_CPPC_LIB
 void init_freq_invariance_cppc(void);
 #define init_freq_invariance_cppc init_freq_invariance_cppc
-#endif
 
-#ifdef CONFIG_ACPI_CPPC_LIB
 bool amd_set_max_freq_ratio(u64 *ratio);
 #else
 static inline bool amd_set_max_freq_ratio(u64 *ratio)
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index f0be5058e3e3..df1644d9b3b6 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -87,3 +87,17 @@ bool amd_set_max_freq_ratio(u64 *ratio)
 
 	return true;
 }
+
+static DEFINE_MUTEX(freq_invariance_lock);
+
+void init_freq_invariance_cppc(void)
+{
+	static bool secondary;
+
+	mutex_lock(&freq_invariance_lock);
+
+	init_freq_invariance(secondary, true);
+	secondary = true;
+
+	mutex_unlock(&freq_invariance_lock);
+}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8f2ff9be0fcc..2ef14772dc04 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -83,10 +83,6 @@
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
 
-#ifdef CONFIG_ACPI_CPPC_LIB
-#include <acpi/cppc_acpi.h>
-#endif
-
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
@@ -2156,22 +2152,6 @@ void init_freq_invariance(bool secondary, bool cppc_ready)
 	}
 }
 
-#ifdef CONFIG_ACPI_CPPC_LIB
-static DEFINE_MUTEX(freq_invariance_lock);
-
-void init_freq_invariance_cppc(void)
-{
-	static bool secondary;
-
-	mutex_lock(&freq_invariance_lock);
-
-	init_freq_invariance(secondary, true);
-	secondary = true;
-
-	mutex_unlock(&freq_invariance_lock);
-}
-#endif
-
 static void disable_freq_invariance_workfn(struct work_struct *work)
 {
 	static_branch_disable(&arch_scale_freq_key);
-- 
2.25.1

