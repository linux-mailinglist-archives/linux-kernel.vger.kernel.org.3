Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F7358FC3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiHKMbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiHKMbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:31:00 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C029E72;
        Thu, 11 Aug 2022 05:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLBE9YWJIjVfvZl/E7ukixR6y21OZ/HJg+gDXqbYXIC2OAHB6FM1zKOLmxG+PwCZJ5DsguBELeaaNr2tVAUR03YcLTlGDduslsVR+J0EmERDs7gDgtPIF60/UUhjBSZdrXZP7uOVOn+x+LXEHyu57ceZ9s2w8Qok3xvnXApuO/gwgweiaD/WBQuWP1lZhsiWOIR5aeiDYXdaICX4VKwcCo7lEDL1N/hlXI4Gr8Nj5GbeJmiQkn9TaWG79IxHBGUuic4tawReAobZPQHptCdFWTr9b6cNZkcwbXqtirVGRuiXeqwS2Ty1GVEXwVel9rXb2KsAz5o9Y3b1dlH5ZKtypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PDyvUjd85V4Oo0il6+awqRFkkUjo7vgpY27O48QY50=;
 b=mwf8R1CM3b2kcZl/7waMYkbtWdf+vGLAnjCXHf2LDWaLGTZ9G4F/SGrE8+pGRk/tBNi/KN51OfzL3iwR8IVx4rnvD91SNvF+5BTrIyvLHpbdNviLtmoD7m/25PD7z2yRTsm+LliCJEuVK059GvcINv+BvsTdXFvTvyzRCNmBEOuRIQ/qulI1TcB8/M+qtZATi6EPY0cKHq9LOVYj1LZPNtujUkHKR7O6jgBQ3OpNcl+pONqTp8j4pieBQMVTp4wndZP04L8UUCtGHOzD1lOTCNwpQNWgm+FPDyfV2heYNVuPR7vh221t9luR1QfnMs0oF++82yqllkV8P2QNco608w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PDyvUjd85V4Oo0il6+awqRFkkUjo7vgpY27O48QY50=;
 b=YYzlRbltQI5vqzFRJL9PELUJ6RSTVI06q15Lpu78Qb5u+j6K3+twUMwIn9A13xey9OshuDWArwIpgd2t2n4JjyTB93ycV6Bdl7weALxtkY2otm0l971j9iuVbrJ4hsknF8wbrC1N1dfkRWNKtcfB1Q6Gyj2+3IJPY3VzZvTP4yQ=
Received: from MW4PR04CA0053.namprd04.prod.outlook.com (2603:10b6:303:6a::28)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 12:30:55 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::85) by MW4PR04CA0053.outlook.office365.com
 (2603:10b6:303:6a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Thu, 11 Aug 2022 12:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:30:55 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:30:48 -0500
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
Subject: [PATCH 01/13] perf/x86/amd/brs: Move feature-specific functions
Date:   Thu, 11 Aug 2022 17:59:49 +0530
Message-ID: <b60283b57179475d18ee242d117c335c16733693.1660211399.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95f2f9ba-a382-4816-d76f-08da7b95567d
X-MS-TrafficTypeDiagnostic: DS7PR12MB6007:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuGm2iycyH8nbhAtGRwEvAzVCV/ewxoaSf73E356AV4eC+Ht0dmTmqMD5Rdm9SY3s3UOQ4ssgpI0toAYekpm7A9bhL6//3ByvZzN+BC1NcIBjhc/KSl05ExFBEdnuab/PnXoMoKfOa8UlgXQj4WGNZZChnq3Fi7aU/sWm8BT5U/erQ/LkYtXHL38JALQjlgxtG8l87V/k5B22ZmrCQ+h8Hf/c0fnxvbMdHy0gbjmM+nN0Oqu8zTVeVWbzubeXQ/RsCFD+fpSv/YrCQqRHt7W+RLxcqh4PmNgZmMPVT+SrA3LaEGv7rkndki8k+NbW63dscLq04wmOBlG7qX3vsDvue+wf+vmGh0w410mU0456XAVhrZZu08CV2l/3O1pO6X60VziFnyJndYD2oHitVof0t5jdQ8qjHb9URr1MOi06cckqKdpn5Gb3aHi+mw/OtWNlSLsVtCt27aRqmRvPbAIQbttK+04EBfcr6h4GyOyUk+JCQZV/DQpFAfsoXh1z4Ot2KOqVuC2oePHMuXqWN4W43ngQrhJPiaCKa/246jaTUFJgUF8J3sV7PPHtC2mLYPaPn33EvTgubVY4++/zZK00W93L32FqWgLgba8bBr3wg5ow8BP8RfMW5+xmtDpqHILjQJIWkoRJsovsVe0bYlJLxh7JLWZcPiVci2NQVCnI0/S1Wz7GzbyY1kgUqK/PcSstpDoPka9phldNLCquiagp/OVUYW7G3koINGmSi0hmViOlL68jyKayk8sYNsd/wzSjxsZjTVR5AKAqG7RThFCHRVETwHbmwb1uRAK7NZ5Jn0Wo4e1mDbZhid4F/efT5SiQ8eXotXK5tqgbXgyNXjKjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(40470700004)(36840700001)(46966006)(316002)(110136005)(54906003)(478600001)(41300700001)(7416002)(40460700003)(40480700001)(2906002)(82310400005)(70206006)(4326008)(8676002)(70586007)(5660300002)(8936002)(44832011)(36860700001)(82740400003)(36756003)(356005)(86362001)(81166007)(186003)(16526019)(336012)(2616005)(426003)(47076005)(7696005)(26005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:30:55.4496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f2f9ba-a382-4816-d76f-08da7b95567d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some of the Branch Sampling (BRS) specific functions out of the Core
events sources and into the BRS sources in preparation for adding other
mechanisms to record branches.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/brs.c    | 69 ++++++++++++++++++++++++++++++++++-
 arch/x86/events/amd/core.c   | 70 ++----------------------------------
 arch/x86/events/perf_event.h |  7 ++--
 3 files changed, 76 insertions(+), 70 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index bee8765a1e9b..f1bff153d945 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -81,7 +81,7 @@ static bool __init amd_brs_detect(void)
  * a br_sel_map. Software filtering is not supported because it would not correlate well
  * with a sampling period.
  */
-int amd_brs_setup_filter(struct perf_event *event)
+static int amd_brs_setup_filter(struct perf_event *event)
 {
 	u64 type = event->attr.branch_sample_type;
 
@@ -96,6 +96,73 @@ int amd_brs_setup_filter(struct perf_event *event)
 	return 0;
 }
 
+static inline int amd_is_brs_event(struct perf_event *e)
+{
+	return (e->hw.config & AMD64_RAW_EVENT_MASK) == AMD_FAM19H_BRS_EVENT;
+}
+
+int amd_brs_hw_config(struct perf_event *event)
+{
+	int ret = 0;
+
+	/*
+	 * Due to interrupt holding, BRS is not recommended in
+	 * counting mode.
+	 */
+	if (!is_sampling_event(event))
+		return -EINVAL;
+
+	/*
+	 * Due to the way BRS operates by holding the interrupt until
+	 * lbr_nr entries have been captured, it does not make sense
+	 * to allow sampling on BRS with an event that does not match
+	 * what BRS is capturing, i.e., retired taken branches.
+	 * Otherwise the correlation with the event's period is even
+	 * more loose:
+	 *
+	 * With retired taken branch:
+	 *   Effective P = P + 16 + X
+	 * With any other event:
+	 *   Effective P = P + Y + X
+	 *
+	 * Where X is the number of taken branches due to interrupt
+	 * skid. Skid is large.
+	 *
+	 * Where Y is the occurences of the event while BRS is
+	 * capturing the lbr_nr entries.
+	 *
+	 * By using retired taken branches, we limit the impact on the
+	 * Y variable. We know it cannot be more than the depth of
+	 * BRS.
+	 */
+	if (!amd_is_brs_event(event))
+		return -EINVAL;
+
+	/*
+	 * BRS implementation does not work with frequency mode
+	 * reprogramming of the period.
+	 */
+	if (event->attr.freq)
+		return -EINVAL;
+	/*
+	 * The kernel subtracts BRS depth from period, so it must
+	 * be big enough.
+	 */
+	if (event->attr.sample_period <= x86_pmu.lbr_nr)
+		return -EINVAL;
+
+	/*
+	 * Check if we can allow PERF_SAMPLE_BRANCH_STACK
+	 */
+	ret = amd_brs_setup_filter(event);
+
+	/* only set in case of success */
+	if (!ret)
+		event->hw.flags |= PERF_X86_EVENT_AMD_BRS;
+
+	return ret;
+}
+
 /* tos = top of stack, i.e., last valid entry written */
 static inline int amd_brs_get_tos(union amd_debug_extn_cfg *cfg)
 {
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9ac3718410ce..e32a27899e11 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -330,16 +330,8 @@ static inline bool amd_is_pair_event_code(struct hw_perf_event *hwc)
 	}
 }
 
-#define AMD_FAM19H_BRS_EVENT 0xc4 /* RETIRED_TAKEN_BRANCH_INSTRUCTIONS */
-static inline int amd_is_brs_event(struct perf_event *e)
-{
-	return (e->hw.config & AMD64_RAW_EVENT_MASK) == AMD_FAM19H_BRS_EVENT;
-}
-
 static int amd_core_hw_config(struct perf_event *event)
 {
-	int ret = 0;
-
 	if (event->attr.exclude_host && event->attr.exclude_guest)
 		/*
 		 * When HO == GO == 1 the hardware treats that as GO == HO == 0
@@ -356,66 +348,10 @@ static int amd_core_hw_config(struct perf_event *event)
 	if ((x86_pmu.flags & PMU_FL_PAIR) && amd_is_pair_event_code(&event->hw))
 		event->hw.flags |= PERF_X86_EVENT_PAIR;
 
-	/*
-	 * if branch stack is requested
-	 */
-	if (has_branch_stack(event)) {
-		/*
-		 * Due to interrupt holding, BRS is not recommended in
-		 * counting mode.
-		 */
-		if (!is_sampling_event(event))
-			return -EINVAL;
-
-		/*
-		 * Due to the way BRS operates by holding the interrupt until
-		 * lbr_nr entries have been captured, it does not make sense
-		 * to allow sampling on BRS with an event that does not match
-		 * what BRS is capturing, i.e., retired taken branches.
-		 * Otherwise the correlation with the event's period is even
-		 * more loose:
-		 *
-		 * With retired taken branch:
-		 *   Effective P = P + 16 + X
-		 * With any other event:
-		 *   Effective P = P + Y + X
-		 *
-		 * Where X is the number of taken branches due to interrupt
-		 * skid. Skid is large.
-		 *
-		 * Where Y is the occurences of the event while BRS is
-		 * capturing the lbr_nr entries.
-		 *
-		 * By using retired taken branches, we limit the impact on the
-		 * Y variable. We know it cannot be more than the depth of
-		 * BRS.
-		 */
-		if (!amd_is_brs_event(event))
-			return -EINVAL;
+	if (has_branch_stack(event))
+		return amd_brs_hw_config(event);
 
-		/*
-		 * BRS implementation does not work with frequency mode
-		 * reprogramming of the period.
-		 */
-		if (event->attr.freq)
-			return -EINVAL;
-		/*
-		 * The kernel subtracts BRS depth from period, so it must
-		 * be big enough.
-		 */
-		if (event->attr.sample_period <= x86_pmu.lbr_nr)
-			return -EINVAL;
-
-		/*
-		 * Check if we can allow PERF_SAMPLE_BRANCH_STACK
-		 */
-		ret = amd_brs_setup_filter(event);
-
-		/* only set in case of success */
-		if (!ret)
-			event->hw.flags |= PERF_X86_EVENT_AMD_BRS;
-	}
-	return ret;
+	return 0;
 }
 
 static inline int amd_is_nb_event(struct hw_perf_event *hwc)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ca2f8bfe6ff1..6d23e88d232c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1231,6 +1231,9 @@ static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 int amd_pmu_init(void);
 
 #ifdef CONFIG_PERF_EVENTS_AMD_BRS
+
+#define AMD_FAM19H_BRS_EVENT 0xc4 /* RETIRED_TAKEN_BRANCH_INSTRUCTIONS */
+
 int amd_brs_init(void);
 void amd_brs_disable(void);
 void amd_brs_enable(void);
@@ -1239,7 +1242,7 @@ void amd_brs_disable_all(void);
 void amd_brs_drain(void);
 void amd_brs_lopwr_init(void);
 void amd_brs_disable_all(void);
-int amd_brs_setup_filter(struct perf_event *event);
+int amd_brs_hw_config(struct perf_event *event);
 void amd_brs_reset(void);
 
 static inline void amd_pmu_brs_add(struct perf_event *event)
@@ -1275,7 +1278,7 @@ static inline void amd_brs_enable(void) {}
 static inline void amd_brs_drain(void) {}
 static inline void amd_brs_lopwr_init(void) {}
 static inline void amd_brs_disable_all(void) {}
-static inline int amd_brs_setup_filter(struct perf_event *event)
+static inline int amd_brs_hw_config(struct perf_event *event)
 {
 	return 0;
 }
-- 
2.34.1

