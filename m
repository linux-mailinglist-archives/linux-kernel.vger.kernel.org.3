Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF68852D012
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiESKFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiESKFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:05:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98CB9BAC6;
        Thu, 19 May 2022 03:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikisLBrMlVo3Pf6wJeaj+j1RRie/Aba4RWCQUjcDxPXOogeWclN3Kqy0kfzgFOE3Vp/gXVMxAut0IYGOzfRvdrLb1KQo3LX1DHvV5+0J5ewNywOrcIAQBsn018toNDpm00mnTeSjcq6qCoM6Gj0fa64v7+t+6sq+msrzs2xjRTgdi8/cXqlAuQsWiLgC2oGAIRQ/8DAFGF3r5Q9lMzqX6H5C3+RmU/3PUZLgTK756P7t5BlOMtcRrTAiBFx55nbbmNJuuv0fieWYWc6AiyVwKOBMgeay6K0dSFNMT0qdRH39E9eu2i5K7zvOptjgfLMPLsPF4Bta+BtFQw+uxYr84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qcam57OPjUwwohv50Om0NpMgDKA0h4Ajs7CIW9S1emM=;
 b=Mn2YULPz3AaTr3NyQ8JSFZrbn5xV1T4gd4decKRMeuCIpLyCYd+rcBfHcsuYe2+0vTRzPg3Z+m7a16nZJiD7/izJz42BnBOgG8YV/YHhfEhmihyCcyISx7Z25CQseizJ2Cq9YUftjUqFwFnIr1lmukXyEqyaIiqYRCC5sEZxOK9pY+vIhvgGBnLXs1/8V3u6JXv3p19oA/J187KbELJeInuxmFi4ihRi7dqWHsHygMxqP7IiLfyi6lm0l+PTZFwuN83XSalkPeLHfi6mliafh/iOcuc1bPAV+YNxeUKA903hbLbOp/RBR61U88+zAE0uPZ0YV+dSx2FmTOuAvhb5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qcam57OPjUwwohv50Om0NpMgDKA0h4Ajs7CIW9S1emM=;
 b=zg/affJ6N2SRf3a8pKpYmKXRFSfuD5Fykr5oQA8Sxpx0BIiB3kp/mn3wTW1ZBoh8uQK/8yQ2Dc6l8Tis+a/QxXPM7krhKTeGWVk2pNI//G3/sis33uthMLCSSQVbXLwF7EeHtWpcjkwzJ3lMtbzGPTTy/Omzzjz0lZ9msvmLFUk=
Received: from DS7PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:3b7::16)
 by MW2PR12MB2363.namprd12.prod.outlook.com (2603:10b6:907:f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 10:05:02 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::31) by DS7PR03CA0101.outlook.office365.com
 (2603:10b6:5:3b7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Thu, 19 May 2022 10:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 10:05:01 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 05:04:55 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 4/5] perf/x86/amd/uncore: Add PerfMonV2 DF event format
Date:   Thu, 19 May 2022 15:33:33 +0530
Message-ID: <ffc24d5a3375b1d6e457d88e83241114de5c1942.1652954372.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b2f5ca5-f2c5-4c8d-bde6-08da397f0a0f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2363:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB23632EB1331F04138C089A858BD09@MW2PR12MB2363.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XkkMHA66kGOwAepisjImiLWx2VYBSHlJHpGG83ps0qOv1ktjLUYh58PX0qxntbPWM7Hr06WTp/nUKMydtkmlhXnQvoEEy3arfj8pZU+DpKUtCRrmNkWvJtoeb2vkMCBVsXgc0S5avilZ45bfYnIzVERiaVBY3SXwt7xQFahBiYX1ePzN2XIcZ8wvoA4ZbNgmWwiUdK519kUPs7HefX05EB8Hmo2AaPeiANEYMZHAldEMNoFyjQrvR3/LYUrbxMX+hHglslYJ/WEhitPn37VvxAGJgW0fpd4KPGJxT2DjP+ffo/UOpVm0GmNfEuCRQiB3me4C6rSjYltx+bZ3ObyccZgXTDznSYW4MKMYKPHjEEDqbdlLGy2v8+sPpIoEJxRkk1idmQyh1emOUSGwI+URefHcjtKBT4x7zotwvZp34rYFIV9pOXb0EBa49jyum7xE1Rrestly2Qgbiu7rixQ+3wWHkjXxTYp8gY6rclx1dWkFDAb8e9B3eRPe1VzetUhuyaiHonzII2tC6K2uShHJT7Zv8WIqNaKy2uwJGUSKMVyxyy28nSt6/NBYNlnYajxTS8HdVB7yn6qEulXCfZBeUovUBX2rcw1B9aR0T8c+vuOOsMzCkkVV24ILUx5uvs1WELxdKxcEdf0y/oqaOyIQSgVDDh+uLOMxZBU5rh9veJt+cjjfWPC3B3LlfHNplWAtDIoWZKvMd5w22BVNGU9pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(8676002)(6666004)(356005)(4326008)(36860700001)(5660300002)(26005)(7696005)(36756003)(40460700003)(86362001)(316002)(8936002)(2616005)(16526019)(186003)(2906002)(54906003)(508600001)(83380400001)(7416002)(110136005)(70206006)(70586007)(44832011)(81166007)(426003)(336012)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 10:05:01.7686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2f5ca5-f2c5-4c8d-bde6-08da397f0a0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2363
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
supported, use bits 0-7, 32-37 as EventSelect and bits
8-15, 24-27 as UnitMask for Data Fabric (DF) events.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c      | 24 +++++++++++++++++-------
 arch/x86/include/asm/perf_event.h | 13 +++++++++++++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 233dd405dd06..ff4238eff087 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -209,10 +209,14 @@ static int amd_uncore_event_init(struct perf_event *event)
 {
 	struct amd_uncore *uncore;
 	struct hw_perf_event *hwc = &event->hw;
+	u64 event_mask = AMD64_RAW_EVENT_MASK_NB;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
+	if (pmu_version >= 2 && is_nb_event(event))
+		event_mask = AMD64_PERFMON_V2_RAW_EVENT_MASK_NB;
+
 	/*
 	 * NB and Last level cache counters (MSRs) are shared across all cores
 	 * that share the same NB / Last level cache.  On family 16h and below,
@@ -221,7 +225,7 @@ static int amd_uncore_event_init(struct perf_event *event)
 	 * out. So we do not support sampling and per-thread events via
 	 * CAP_NO_INTERRUPT, and we do not enable counter overflow interrupts:
 	 */
-	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;
+	hwc->config = event->attr.config & event_mask;
 	hwc->idx = -1;
 
 	if (event->cpu < 0)
@@ -300,8 +304,10 @@ static struct device_attribute format_attr_##_var =			\
 
 DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
 DEFINE_UNCORE_FORMAT_ATTR(event14,	event,		"config:0-7,32-35,59-60"); /* F17h+ DF */
+DEFINE_UNCORE_FORMAT_ATTR(event14v2,	event,		"config:0-7,32-37");	   /* PerfMonV2 DF */
 DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3 */
-DEFINE_UNCORE_FORMAT_ATTR(umask,	umask,		"config:8-15");
+DEFINE_UNCORE_FORMAT_ATTR(umask8,	umask,		"config:8-15");
+DEFINE_UNCORE_FORMAT_ATTR(umask12,	umask,		"config:8-15,24-27");	   /* PerfMonV2 DF */
 DEFINE_UNCORE_FORMAT_ATTR(coreid,	coreid,		"config:42-44");	   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(slicemask,	slicemask,	"config:48-51");	   /* F17h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(threadmask8,	threadmask,	"config:56-63");	   /* F17h L3 */
@@ -313,14 +319,14 @@ DEFINE_UNCORE_FORMAT_ATTR(sliceid,	sliceid,	"config:48-50");	   /* F19h L3 */
 /* Common DF and NB attributes */
 static struct attribute *amd_uncore_df_format_attr[] = {
 	&format_attr_event12.attr,	/* event */
-	&format_attr_umask.attr,	/* umask */
+	&format_attr_umask8.attr,	/* umask */
 	NULL,
 };
 
 /* Common L2 and L3 attributes */
 static struct attribute *amd_uncore_l3_format_attr[] = {
 	&format_attr_event12.attr,	/* event */
-	&format_attr_umask.attr,	/* umask */
+	&format_attr_umask8.attr,	/* umask */
 	NULL,				/* threadmask */
 	NULL,
 };
@@ -659,8 +665,12 @@ static int __init amd_uncore_init(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB)) {
-		if (boot_cpu_data.x86 >= 0x17)
+		if (pmu_version >= 2) {
+			*df_attr++ = &format_attr_event14v2.attr;
+			*df_attr++ = &format_attr_umask12.attr;
+		} else if (boot_cpu_data.x86 >= 0x17) {
 			*df_attr = &format_attr_event14.attr;
+		}
 
 		amd_uncore_nb = alloc_percpu(struct amd_uncore *);
 		if (!amd_uncore_nb) {
@@ -686,11 +696,11 @@ static int __init amd_uncore_init(void)
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
 		if (boot_cpu_data.x86 >= 0x19) {
 			*l3_attr++ = &format_attr_event8.attr;
-			*l3_attr++ = &format_attr_umask.attr;
+			*l3_attr++ = &format_attr_umask8.attr;
 			*l3_attr++ = &format_attr_threadmask2.attr;
 		} else if (boot_cpu_data.x86 >= 0x17) {
 			*l3_attr++ = &format_attr_event8.attr;
-			*l3_attr++ = &format_attr_umask.attr;
+			*l3_attr++ = &format_attr_umask8.attr;
 			*l3_attr++ = &format_attr_threadmask8.attr;
 		}
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index af157aa74f4e..34348ae41cdb 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -89,6 +89,19 @@
 #define AMD64_RAW_EVENT_MASK_NB		\
 	(AMD64_EVENTSEL_EVENT        |  \
 	 ARCH_PERFMON_EVENTSEL_UMASK)
+
+#define AMD64_PERFMON_V2_EVENTSEL_EVENT_NB	\
+	(AMD64_EVENTSEL_EVENT	|		\
+	 GENMASK_ULL(37, 36))
+
+#define AMD64_PERFMON_V2_EVENTSEL_UMASK_NB	\
+	(ARCH_PERFMON_EVENTSEL_UMASK	|	\
+	 GENMASK_ULL(27, 24))
+
+#define AMD64_PERFMON_V2_RAW_EVENT_MASK_NB		\
+	(AMD64_PERFMON_V2_EVENTSEL_EVENT_NB	|	\
+	 AMD64_PERFMON_V2_EVENTSEL_UMASK_NB)
+
 #define AMD64_NUM_COUNTERS				4
 #define AMD64_NUM_COUNTERS_CORE				6
 #define AMD64_NUM_COUNTERS_NB				4
-- 
2.34.1

