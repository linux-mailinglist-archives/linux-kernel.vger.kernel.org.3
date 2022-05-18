Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0A52B540
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiERInt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiERIns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:43:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207E193C9;
        Wed, 18 May 2022 01:43:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTK/xRLOhVDDWL47j9n9NewOmhVarZ7jRsqOWc1idJdSPbZlEwl070Lc74EbNEKJ6k77wVl96kkQoW6uoEV9xEOaie2I2NNscXuR/9MdBR+orArI6HiZMlOYda7IJgDpmJI2wSwfJ2pMeqv791J5jwMq3yLxyiovFdmWkjlX54aerxkXnG/adMW8Ft5T8gMGVlihSH4D4jK+DTpA0jWidTA2ZhiHoJXiYlPZk9c8KBc8II3fR2mtplmQ5a3VI9U19a8gXz3YXCoZ3DFRlGLzN9js03hr4E6/CTRgc7ah4kulxCu2gJEDF2iDNWL4S4LzrWgSDtddC2Uqk1XH1oiaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+K8MlNFiQ3xK5n+3w1Nxd8NR9vOobVql8ZPD0Ei1ek=;
 b=NlUSBGRBZIax56DslD2sg0dOX5BtSrH8blGPSkhG+ZcJbcLDSopjY46uu0I43SLm7cCehbeFLRZh7V3sk9YqUFw2o/6UjPvFL5Y0r5USvqx06/SeFAtpzyIVg1LuN/5K1HARPkgxgo00hnC0MgJ98YMYQi6cZ1Zcv7LNuGO88GKz8bwFIM/xbM7D9VbKApfnbNpAP2M7qewYH58FWPBvMPMja710tJymkGHLIDqzmkbaT+kbYoPTAhrYH1Pc4zpVs3ZU42IFbWPRhMnA5CUA+GS1nN4UBjzYMN4tO4qjq+fgY7hrv5zcfNzbHcAsnm7Sx7TwB47GorQTnHwJO7gv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+K8MlNFiQ3xK5n+3w1Nxd8NR9vOobVql8ZPD0Ei1ek=;
 b=W/MG5h5HpB09TGgXbB2ZOMmMogRQL+oeDwsxr0clhjToR38Mw4NQomQ/8F9KtWMh1OcHFAJvjWfAEFY/20Cxa212ZqiLTwnaOusLXI7TkeASrn2RHkahsqZ1GKJOZtEy5rTTU1Ehp/grsbD5k9FRFuSFyJRwfDqS5KhIwcE52MA=
Received: from BN0PR08CA0024.namprd08.prod.outlook.com (2603:10b6:408:142::14)
 by DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Wed, 18 May 2022 08:43:43 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::3e) by BN0PR08CA0024.outlook.office365.com
 (2603:10b6:408:142::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Wed, 18 May 2022 08:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 08:43:42 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 03:43:35 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>, <jroedel@suse.de>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/core: Fix reloading events for SVM
Date:   Wed, 18 May 2022 14:13:27 +0530
Message-ID: <20220518084327.464005-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89b41081-072a-4389-0d60-08da38aa8369
X-MS-TrafficTypeDiagnostic: DM5PR12MB1546:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15464198163AEE64FC405DB38BD19@DM5PR12MB1546.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kAZZhnvo7UXOUGWHAYdcgVFmIwdsnUxH88gKWT8NvH168Hh84c/Y7seYtw8KgyBbX0zljV08gkFANk2fvyNBh0ftSSs44UgiZk7UXN8NjQnNV3f8U1qWPLD6STkbOUZEpZg/MFmrEWMABj71F9ncLJPBHN8UuhxZV9ngA19rRseYc3J6Jut5KVts06mcBbSdbJpP5xBKhnMN7MPsPFa6m3uCFhzuU7S8QaTwUW8wh0rlfgt2dY94cTq90FAJ2z9TclseaQgou0d7+qQacSDEmxhhq/+xb1Fg/5Gdc3nggw+9NvHWfou4g0q+fSmR+nMLgfvbYzOArmi+fFPbOZnVdPSk10YFj4ronw1ODWDjxV5x/+YpsM10psWiVkUiGialWzM20pY1gyMX6FC6NhcvfXfFsY8AfI0LtsLyvWCjGtBbB1Qk/1P8F0OKffS01tOF6UAwya7WRSlFeATe6vGu20HzpRT9Y4D1RGuTM48QFkb6aqxnAQO05ChIE9AE9FtN4GiYqJFLYqefDhMSQSh1aKlsPfgYoeGwGCkX+phWux+yJqAALeuSLaM4BfXYByf1kY6RedEhdT0OoivDtwCJyoBKsA5sHXeJmR6wr8/VK+r563x9olDDvVQVnMglh1rZBrySgssHblkwx7OPTd1M1RIPmiH50r+f+lVjmZfxazTdSwRGNjzs/0Q1AMiFbO7V91feu4dD8i1l6bVwmxkUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(36756003)(4326008)(70206006)(70586007)(7416002)(8936002)(5660300002)(508600001)(8676002)(2616005)(40460700003)(7696005)(26005)(54906003)(83380400001)(86362001)(356005)(426003)(336012)(47076005)(81166007)(2906002)(6666004)(36860700001)(82310400005)(186003)(1076003)(16526019)(110136005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 08:43:42.6017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b41081-072a-4389-0d60-08da38aa8369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1546
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only
counting with SVM disabled") addresses an issue in which the
Host-Only bit in the counter control registers needs to be
masked off when SVM is not enabled.

The events need to be reloaded whenever SVM is enabled or
disabled for a CPU and this requires the PERF_CTL registers
to be reprogrammed using {enable,disable}_all(). However,
PerfMonV2 variants of these functions do not reprogram the
PERF_CTL registers. Hence, the legacy enable_all() function
should also be called.

Fixes: 9622e67e3980 ("perf/x86/amd/core: Add PerfMonV2 counter control")
Reported-by: Like Xu <likexu@tencent.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 359d575c27e2..37b175870ee8 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1467,6 +1467,24 @@ __init int amd_pmu_init(void)
 	return 0;
 }
 
+static inline void amd_pmu_reload_virt(void)
+{
+	if (x86_pmu.version >= 2) {
+		/*
+		 * Clear global enable bits, reprogram the PERF_CTL
+		 * registers with updated perf_ctr_virt_mask and then
+		 * set global enable bits once again
+		 */
+		amd_pmu_v2_disable_all();
+		amd_pmu_enable_all(0);
+		amd_pmu_v2_enable_all(0);
+		return;
+	}
+
+	amd_pmu_disable_all();
+	amd_pmu_enable_all(0);
+}
+
 void amd_pmu_enable_virt(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1474,8 +1492,7 @@ void amd_pmu_enable_virt(void)
 	cpuc->perf_ctr_virt_mask = 0;
 
 	/* Reload all events */
-	amd_pmu_disable_all();
-	x86_pmu_enable_all(0);
+	amd_pmu_reload_virt();
 }
 EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);
 
@@ -1492,7 +1509,6 @@ void amd_pmu_disable_virt(void)
 	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
 
 	/* Reload all events */
-	amd_pmu_disable_all();
-	x86_pmu_enable_all(0);
+	amd_pmu_reload_virt();
 }
 EXPORT_SYMBOL_GPL(amd_pmu_disable_virt);
-- 
2.34.1

