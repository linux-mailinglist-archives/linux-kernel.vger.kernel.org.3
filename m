Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A252D00F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiESKEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiESKEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:04:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A6B9C2C7;
        Thu, 19 May 2022 03:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG8mdo8lBsTxJTsrO9vmUg/MCZHLPoZuJ4zSttd3GQ5IMs2uXSzoVp0hvaB0gNVJMVUAeMChQO/J0z4tLim5QrKjqFL3ULoCMw9wZy9QevzY7haQU1xExjqei94EbvwxY61yy1NGYJ9yFUUXmrT/j7iWMR1SyISJ3ldmS6Bcotnwmsk1s31TfdsSPIdP4ZDEwFJUy5SoSrydtXYE1DcFVH91i1nk3k7ExI8Y2wRDykiHG9fpB46qkJKik4Q7LIgojnt5m8QSJB7pom0X8liWJ0g2wPDyLb1qX+l0XUnUqvy+0SKESGrXCK2dAXIWR1/aLH/38aCmj5uxJOrsrCoyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+sNLBwxgzJbKyfEFGPAwlsHQ3w4xhNl4bUfSNwxI84=;
 b=V/fv5Mnew9BtxUkwOa1ybkFfbLwoQgSQYgsVdBVRV6tNEdJ5YpQerhv5cYf3OA7cXAucHO0Um4ZlO+Edge7uvYoyOcLYQrS66qsKiupJ5j+qjzl8TV6cDUcG/BZzVWa9gHyAKxGaDaAq9ld0+Yw2WuEXBFz8yHM1HTKgFgGnyqANXYbEtHgsKumTg+v//IgVkMQSW76wx+W0bO/aNr0JuzP466mmSGX8OSFOB+c+0+UfgZLKHc2ebUAbKQCFXnQYURVh8zHGdpjLr6axSKITAyFkoUbpNN6nQdVmIM4rLbFq7AqzZB1bx3HOFhi8EfYiLKjeO+5HaxCPcNIXg0UFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+sNLBwxgzJbKyfEFGPAwlsHQ3w4xhNl4bUfSNwxI84=;
 b=fRYbLIO/Ud+wArzOArWASGcMu4+HiM5wtmu8/0R2RFi9jeazE4OYq5wsk3s6LcYNRerXVKuAN5V4KaD7cWqStnUWHyoahzUpw4wlB1cXQEBS1n1OwJjTJ7DsU8KQpNrcdkhznpv5SAX/wldtCAD81k4XyliVrbL3ktXhmpZsggo=
Received: from DS7PR05CA0085.namprd05.prod.outlook.com (2603:10b6:8:56::15) by
 CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Thu, 19 May 2022 10:04:07 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::3) by DS7PR05CA0085.outlook.office365.com
 (2603:10b6:8:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.7 via Frontend
 Transport; Thu, 19 May 2022 10:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 10:04:06 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 05:04:01 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 1/5] perf/x86/amd/uncore: Use dynamic events array
Date:   Thu, 19 May 2022 15:33:30 +0530
Message-ID: <21eea0cb6de9d14f78d52d1d62637ae02bc900f5.1652954372.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652954372.git.sandipan.das@amd.com>
References: <cover.1652954372.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88390489-fc49-4a9d-088e-08da397ee963
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4199C3A4363DE37F172A515E8BD09@CH2PR12MB4199.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1gTD/JhA5IjM8JdkyjqF6dSdvnFwbiwAEcwQHltB5ng/2v+ZhFqAJyrbQDlNtVtGGAIvRE0w6FpDaCNxgdJmSZkr8ShZWp3mgjTjq6lMxio+CPFtib7avmNjSTZNbQ/Y0HL9F4O72gIu1fNLJnjpUdXOfTRjPKmXddogDF2fQdOFeiLtQsUDLHrqMhTeDpZq3iPwISSxgwHA4HXCiUQIb0YziINKdU56tChNtWdGx+MZg5L2gWwyRgh5eCvp526yjVXGWEZFVsV30+SWcvCiamLviDmpWZ95hQQut6BXc5LQyniqEZ0rqeRhacSCrVrd435uEnfWLNeCzO2Q/OHZpS6r+IqxhjEWfK+m1PnATRXMiY8yIhvzfYV2umatwOrdu9Z9iqpCZ9SvEL10UmRZXXuyrlm+9n/UglzgEEkO4UqH9keAsUNJpBE3v1bGrMW6KiB6RCHCD7gSQraWNDE4RXlREgdYv8NioYDAvPP3oUKgqCOTIfrlB34oRYhfRKucFwGh/MN9uKp1wWz1hSmdPQ3j/9J6Wg1aEi24Irgf/7P3edy4brdrv/YqAQ6L8rzPBOVQ5527V7J3m1USTqOqbsoVgF/x9gmZln8c2JjgDTZYqusIEP2hdBm0ZIm6WdM7N9qee1N9+Vdjo1jKNLueDd3/5bFFrDoXO/XN4nZwpa9BvPrxuXHhFp9DJI0Ds0LcRLVyeVjjxP/2ezjF/c5yA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(426003)(83380400001)(6666004)(336012)(8936002)(36860700001)(7416002)(2616005)(5660300002)(44832011)(86362001)(82310400005)(110136005)(40460700003)(70206006)(16526019)(81166007)(186003)(47076005)(36756003)(70586007)(54906003)(316002)(2906002)(4326008)(356005)(26005)(8676002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 10:04:06.9496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88390489-fc49-4a9d-088e-08da397ee963
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, the number of available counters for a given
uncore PMU may not be fixed across families and models
and has to be determined at runtime.

The per-cpu uncore PMU data currently uses a fixed-sized
array for event information. Make it dynamic based on the
number of available counters.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 38 +++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 0d04414b97d2..8dfcf93711ab 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -21,7 +21,6 @@
 #define NUM_COUNTERS_NB		4
 #define NUM_COUNTERS_L2		4
 #define NUM_COUNTERS_L3		6
-#define MAX_COUNTERS		6
 
 #define RDPMC_BASE_NB		6
 #define RDPMC_BASE_LLC		10
@@ -46,7 +45,7 @@ struct amd_uncore {
 	u32 msr_base;
 	cpumask_t *active_mask;
 	struct pmu *pmu;
-	struct perf_event *events[MAX_COUNTERS];
+	struct perf_event **events;
 	struct hlist_node node;
 };
 
@@ -370,11 +369,19 @@ static struct amd_uncore *amd_uncore_alloc(unsigned int cpu)
 			cpu_to_node(cpu));
 }
 
+static inline struct perf_event **
+amd_uncore_events_alloc(unsigned int num, unsigned int cpu)
+{
+	return kzalloc_node(sizeof(struct perf_event *) * num, GFP_KERNEL,
+			    cpu_to_node(cpu));
+}
+
 static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 {
-	struct amd_uncore *uncore_nb = NULL, *uncore_llc;
+	struct amd_uncore *uncore_nb = NULL, *uncore_llc = NULL;
 
 	if (amd_uncore_nb) {
+		*per_cpu_ptr(amd_uncore_nb, cpu) = NULL;
 		uncore_nb = amd_uncore_alloc(cpu);
 		if (!uncore_nb)
 			goto fail;
@@ -384,11 +391,15 @@ static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 		uncore_nb->msr_base = MSR_F15H_NB_PERF_CTL;
 		uncore_nb->active_mask = &amd_nb_active_mask;
 		uncore_nb->pmu = &amd_nb_pmu;
+		uncore_nb->events = amd_uncore_events_alloc(num_counters_nb, cpu);
+		if (!uncore_nb->events)
+			goto fail;
 		uncore_nb->id = -1;
 		*per_cpu_ptr(amd_uncore_nb, cpu) = uncore_nb;
 	}
 
 	if (amd_uncore_llc) {
+		*per_cpu_ptr(amd_uncore_llc, cpu) = NULL;
 		uncore_llc = amd_uncore_alloc(cpu);
 		if (!uncore_llc)
 			goto fail;
@@ -398,6 +409,9 @@ static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 		uncore_llc->msr_base = MSR_F16H_L2I_PERF_CTL;
 		uncore_llc->active_mask = &amd_llc_active_mask;
 		uncore_llc->pmu = &amd_llc_pmu;
+		uncore_llc->events = amd_uncore_events_alloc(num_counters_llc, cpu);
+		if (!uncore_llc->events)
+			goto fail;
 		uncore_llc->id = -1;
 		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore_llc;
 	}
@@ -405,9 +419,16 @@ static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 	return 0;
 
 fail:
-	if (amd_uncore_nb)
-		*per_cpu_ptr(amd_uncore_nb, cpu) = NULL;
-	kfree(uncore_nb);
+	if (uncore_nb) {
+		kfree(uncore_nb->events);
+		kfree(uncore_nb);
+	}
+
+	if (uncore_llc) {
+		kfree(uncore_llc->events);
+		kfree(uncore_llc);
+	}
+
 	return -ENOMEM;
 }
 
@@ -540,8 +561,11 @@ static void uncore_dead(unsigned int cpu, struct amd_uncore * __percpu *uncores)
 	if (cpu == uncore->cpu)
 		cpumask_clear_cpu(cpu, uncore->active_mask);
 
-	if (!--uncore->refcnt)
+	if (!--uncore->refcnt) {
+		kfree(uncore->events);
 		kfree(uncore);
+	}
+
 	*per_cpu_ptr(uncores, cpu) = NULL;
 }
 
-- 
2.34.1

