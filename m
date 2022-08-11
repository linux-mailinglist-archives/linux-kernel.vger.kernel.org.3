Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192D858FC49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiHKMcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiHKMcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:32:22 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9469BB491;
        Thu, 11 Aug 2022 05:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIt3g4W+/oAtx0jkVSJK2L0VnZUHga+SpMvsCnPSTTvapFWZI2LXy+snZlNcJjI8GV3+/yYW7JZ9lba93erEBhVJ0mMV5jOUrMoyeY4MoY01eQVMXHeB/JcWkPzvL7M91h7pfcpuYGzRFC76A6SDDYLgWPkGDUmyIBpDC4ImMQ/b36MZZgeGeRL+/Vvo+sIeVqDol97jVHzNMzzmRU0rc95qH72/B52MRbVM8kr/fk1JezWSnU0bDeKnuJsyL5AcF2faB1kxtzuSuU5ApbwcM4FAT/w4r7WTggauFi+Qa5culek4A2Ov43B//52UKMfQPXcD6xwfmFI1Z/6s7au3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0IEXx4iXNil1YsgW5Mqt4/KBc1p2ELClA/FeVZ0S9c=;
 b=ZJ/lHp5ihFm8DxW7pNcSITRN0wJGKMGC2OoGvoNyD1GLdSClKyn7zANa/YwA0euZHnQ4n7GEaYAgYhpjwzWGl5PekOe+vd9GY8auFEBT5aISLQ9NTZgIafzzMDs0s6XVXFKeaiyZQzedI1Ei+u9V9jDOZ4QwsbamX0zvcKuPcwVi7UPtfE8LOUK4VR262CLZSyuFAWQ6QVed3cvjK836pmlaacizkcmOVrf7+HO0LXv4/GbfJzxK7dohbhx0H0L6kKqX1VWx7CY3bIdEJbhFL5rfMrDgwbt9xF3gHI5lGCfUhwVL18gc0ZYEkMdi5Gl9Fl7oPHA9J72KSST8LcgkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0IEXx4iXNil1YsgW5Mqt4/KBc1p2ELClA/FeVZ0S9c=;
 b=Os/YBDWCPRNCxsweXEf8En3/Kq3NbrzOY5x1i93qZ55kKs2RHcOH2axtlQQAVule38ST/o8scx+j9L/qanSK9pRBIpzoWjqAPXjRf4v8pLZN8G9QCesI8lcH7B5OqE4gdiv/vEoPU8dUGc6o0XXpipb7UcjXYKnphpMTkZ0YJQY=
Received: from MW4PR04CA0233.namprd04.prod.outlook.com (2603:10b6:303:87::28)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 11 Aug
 2022 12:32:15 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::da) by MW4PR04CA0233.outlook.office365.com
 (2603:10b6:303:87::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Thu, 11 Aug 2022 12:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:32:14 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:31:41 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 03/13] perf/x86/amd/core: Add generic branch record interfaces
Date:   Thu, 11 Aug 2022 17:59:51 +0530
Message-ID: <b75dbc32663cb395f0d701167e952c6a6b0445a3.1660211399.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1660211399.git.sandipan.das@amd.com>
References: <cover.1660211399.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0c05e44-f7e8-46ad-bf6e-08da7b9585c9
X-MS-TrafficTypeDiagnostic: SA1PR12MB6822:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwN7csurmqROEWHIKfi+5vfkjirlagh5CqyqmiD106JzmxT8ikDRSEeudrXTKn6LdxhOdY0+ptLwe65uWwR9+C3Jw1Rnwp7XMMY8kp5mpwpTscHKansLWrsAHaFJ2Mmzt8uWM0BMZb1gkewHIgsVwivK7bk3Xbue7YzLJp49vWyXt2j6zFLvSesnyCMuFoR6JwETVMWGaNZ41q5zSC+jtwt+K8mS/+0Ta93zy4mfham5MPTInNuMvaI/02iYTZmJNWx729sB/Z4s5xL75s7DoTBpBGlP5Tqmt5ojOA5QAvoC69siex+uGIgb8gbnHyeXHNJ3zxMkt1Uv2AG29fTGIE+wUnMQpP8mV/yRY9ANQ/cS9o+6gqYhRoI39zyV9R9Y4zAwVBW60zAjuhwo27VwEca71eAeyBNT0O4is9GhH2Lw1rIUu6i7XwKofZLiuxvefdpoUtK8aMjLnzGD1/KAvuDQ0RIW8Hbs+HxA2sSZ3LfA/RO26QYLzQp3KFNXeP/aPcn9c46VKvaGSlQcVUduroKLKtmSJm+JtzXp2hne7+a24KTF3hpvgYMOcqjXv9gNxaorts7/w4V1hJvrv4ZlePTNLzc0ph72YxI5SB9mJI2ty4U/DlOIi84EeCubsU94jx/t4G6r8gHo6pX00RpYioVchYQXK6R9wlukqDleEdHuia107nf6nWUJEL47vVCK4IOkn268kdPOQveBD+UwcJIstjk6qbgaW3t3BdvzALYi6rbxJPVlq2pkY2Xul/yxwNcwT1M51ZEVFUht/G//rxOQBnmmuyD54EQxRbp6d19QKLueRIA0+HabDJqQye9s+6VcBE+EIxRnrs/V4WWsrLJf9XQgG/iie8+wUZk7zlY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(36840700001)(40470700004)(86362001)(6666004)(426003)(336012)(26005)(41300700001)(83380400001)(47076005)(82310400005)(7696005)(40480700001)(2906002)(36860700001)(5660300002)(7416002)(54906003)(110136005)(316002)(356005)(4326008)(8676002)(70586007)(186003)(2616005)(478600001)(16526019)(36756003)(70206006)(81166007)(44832011)(40460700003)(8936002)(82740400003)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:32:14.9406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c05e44-f7e8-46ad-bf6e-08da7b9585c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD processors that are capable of recording branches support either Branch
Sampling (BRS) or Last Branch Record (LBR). In preparation for adding Last
Branch Record Extension Version 2 (LbrExtV2) support, introduce new static
calls which act as gateways to call into the feature-dependent functions
based on what is available on the processor.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 2f524cf84528..ef3520731a20 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -330,6 +330,8 @@ static inline bool amd_is_pair_event_code(struct hw_perf_event *hwc)
 	}
 }
 
+DEFINE_STATIC_CALL_RET0(amd_pmu_branch_hw_config, *x86_pmu.hw_config);
+
 static int amd_core_hw_config(struct perf_event *event)
 {
 	if (event->attr.exclude_host && event->attr.exclude_guest)
@@ -349,7 +351,7 @@ static int amd_core_hw_config(struct perf_event *event)
 		event->hw.flags |= PERF_X86_EVENT_PAIR;
 
 	if (has_branch_stack(event))
-		return amd_brs_hw_config(event);
+		return static_call(amd_pmu_branch_hw_config)(event);
 
 	return 0;
 }
@@ -518,8 +520,14 @@ static struct amd_nb *amd_alloc_nb(int cpu)
 	return nb;
 }
 
+typedef void (amd_pmu_branch_reset_t)(void);
+DEFINE_STATIC_CALL_NULL(amd_pmu_branch_reset, amd_pmu_branch_reset_t);
+
 static void amd_pmu_cpu_reset(int cpu)
 {
+	if (x86_pmu.lbr_nr)
+		static_call(amd_pmu_branch_reset)();
+
 	if (x86_pmu.version < 2)
 		return;
 
@@ -576,7 +584,6 @@ static void amd_pmu_cpu_starting(int cpu)
 	cpuc->amd_nb->nb_id = nb_id;
 	cpuc->amd_nb->refcnt++;
 
-	amd_brs_reset();
 	amd_pmu_cpu_reset(cpu);
 }
 
@@ -771,16 +778,20 @@ static void amd_pmu_v2_disable_all(void)
 	amd_pmu_check_overflow();
 }
 
+DEFINE_STATIC_CALL_NULL(amd_pmu_branch_add, *x86_pmu.add);
+
 static void amd_pmu_add_event(struct perf_event *event)
 {
 	if (needs_branch_stack(event))
-		amd_pmu_brs_add(event);
+		static_call(amd_pmu_branch_add)(event);
 }
 
+DEFINE_STATIC_CALL_NULL(amd_pmu_branch_del, *x86_pmu.del);
+
 static void amd_pmu_del_event(struct perf_event *event)
 {
 	if (needs_branch_stack(event))
-		amd_pmu_brs_del(event);
+		static_call(amd_pmu_branch_del)(event);
 }
 
 /*
@@ -1184,13 +1195,6 @@ static ssize_t amd_event_sysfs_show(char *page, u64 config)
 	return x86_event_sysfs_show(page, config, event);
 }
 
-static void amd_pmu_sched_task(struct perf_event_context *ctx,
-				 bool sched_in)
-{
-	if (sched_in && x86_pmu.lbr_nr)
-		amd_pmu_brs_sched_task(ctx, sched_in);
-}
-
 static u64 amd_pmu_limit_period(struct perf_event *event, u64 left)
 {
 	/*
@@ -1375,8 +1379,14 @@ static int __init amd_core_pmu_init(void)
 	 */
 	if (boot_cpu_data.x86 >= 0x19 && !amd_brs_init()) {
 		x86_pmu.get_event_constraints = amd_get_event_constraints_f19h;
-		x86_pmu.sched_task = amd_pmu_sched_task;
+		x86_pmu.sched_task = amd_pmu_brs_sched_task;
 		x86_pmu.limit_period = amd_pmu_limit_period;
+
+		static_call_update(amd_pmu_branch_hw_config, amd_brs_hw_config);
+		static_call_update(amd_pmu_branch_reset, amd_brs_reset);
+		static_call_update(amd_pmu_branch_add, amd_pmu_brs_add);
+		static_call_update(amd_pmu_branch_del, amd_pmu_brs_del);
+
 		/*
 		 * put_event_constraints callback same as Fam17h, set above
 		 */
-- 
2.34.1

