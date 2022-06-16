Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9096854E035
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376924AbiFPLpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376933AbiFPLpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:45:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933785EDD0;
        Thu, 16 Jun 2022 04:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpSWbL5A8hwy0L9Ox1yuG3D/piJqBdbhPeu9hZ1Cgb+D0EPOr0VkOMNM56hIAuMIhHxtv5qiaNeLQQ6gm7gi0IznEox/MdTmohrH/ymZtBVQTC/3536sbDi8a0n7fR0oRN88zYGDJmrTTiSHKxk+7lJOU8wKAV2BOhVtrY3pzqEjPvDZO4IMY60ff5QTHKX3aqdLVT1eRXBTkbmcwAtkMImfxvTvArXaALqxj9/ZOMnTZoG6Jnbg/Tv6K79Ei/Qv2vbzxfzZvnVFPOWkyJ/IwhRmxkndTT0SJfeeCd/tO6RV4U1w60zI3XzdoiEG+WCHPM6KsuutkMCJP3Cn7B7rmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaBH13viACOldfOgZlhiSiXXekX1SE2U9MLxIT88mgE=;
 b=I4DhvHrRn77C3S6Fc9axKzPZTzNjmt6xukTZ2JnGqCNXfieZ5sDzp0pHwuiN+DxLgNeJ7AHjEWwV0Vgsj3YiPe3i3INb7B4OwVksCmEVcCRLqSrP5uKsAjIGj+xAwgEZThLYDUAIcRwYeVjTHIVyD3INGeJUOvms4dy5fQiCV1REk6hHzB9Mg0TVx9yLsqHlqXxrZTHFHL51Jk701m+EZymltIvPkAEIt0IobImPC+J88t9ZbLXaDgxiMAJrgBVhIj4WM8C0vV/iPd+neXwP8Qb7KHJobSNIaE5T3zMFKi+zk9VaV6MqtJ9dCgDycXnJvv2L2nYREjyriAqXEipvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaBH13viACOldfOgZlhiSiXXekX1SE2U9MLxIT88mgE=;
 b=TKh0JFuhRmyvqJVW6X3s7jPjaNfAeSRZ56eea7kn3XI1eXIwEjJ43u1UW9x984j52hQ+YOSMCOZSisLur+Dc8Qz4fcs9RgGSGWECu3x6b6fWdFxp/Z5MDUQXcMCBeq1q83bCilb0KRoKv1qZNbh/XJI10R1BqUhR/PBwwpIag+I=
Received: from CO2PR06CA0054.namprd06.prod.outlook.com (2603:10b6:104:3::12)
 by SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Thu, 16 Jun
 2022 11:45:28 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::cb) by CO2PR06CA0054.outlook.office365.com
 (2603:10b6:104:3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Thu, 16 Jun 2022 11:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:45:28 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:43:56 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 06/14] perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
Date:   Thu, 16 Jun 2022 17:06:29 +0530
Message-ID: <20220616113638.900-7-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616113638.900-1-ravi.bangoria@amd.com>
References: <20220616113638.900-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7424dd2-6522-40de-b65b-08da4f8db5d9
X-MS-TrafficTypeDiagnostic: SN6PR12MB2685:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB26857C737FFACCC8E48FA8E3E0AC9@SN6PR12MB2685.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+EicBwxEDn4LSDsFHGeEz0mFQXnqtpOjIRMX4PMHROzDPPmnVuXIAMxQVSiVaYLspBTsl7QzMzTYtoQk3cNqWtxnlFr2KMACOJiHTo58iTO6apnYfHp2CsYwIsaT9g3yLiig/dvF1nj54o9MCUrTnMDBh441TKzFaa26KS6Er8UopP2xn6Ox4p4b4dzPukK4H9J0A3eISS89sXZPu5yZ8diU9ml4l3gz9mMDklen3SOTiYCNIUEp5eU08uKhCAgSG3XbJk+xLKwvQDjOUU8meZjm36kYudJSlYbwixwUfI/s9JJARO6V8BC81VUOQClUkjQbScVp4IcN49dtfBagUOxjCAa8tTYhbzTLSWOMWlu8Bhy1Bph0sM/q1CIQ231tY/jPAk4sFbyvY72MpYPj+AOvuxt+jXvn/d2tXQFHnnUtZ4R3yrDUIiHFfV84HM1dF5ibsZ0QxPwAoRNwqxg5BcRAuOJLiSCGGnd/MY0jzb1+01ju8oFLhYFmYXfWptKwPp1gGw/7cppLJFR5kS3NQ39Qt756/21QOqBTdejcddKeHxt/hntdt76UjXixdNle0TTFnh8sUPK0PPLzPbmU2h/pL7BXFf9dJbbvVxS572qNisIE7EwYcFjYn+xZRoV12EMSbbkZjOujWJcR4R4xinuymisP796kHoJHjw5EeGJpHTpMN62ZydvA1TYtFhdrE0KJRNBU39c4AkmbJlWCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(26005)(426003)(40460700003)(47076005)(336012)(81166007)(356005)(36860700001)(7696005)(2616005)(186003)(86362001)(16526019)(1076003)(8676002)(54906003)(2906002)(70586007)(83380400001)(4326008)(316002)(7416002)(110136005)(5660300002)(44832011)(8936002)(508600001)(6666004)(82310400005)(36756003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:45:28.4398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7424dd2-6522-40de-b65b-08da4f8db5d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS_DC_PHYSADDR provides the physical data address for the tagged load/
store operation. Populate perf sample physical address using it.
Currently, physical address is unconditionally overwritten by generic
perf driver. Introduce internal only __PERF_SAMPLE_PHYS_ADDR_EARLY type
to notify generic code that arch pmu has already set physical address.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c       | 34 ++++++++++++++++++++++++++++++++-
 include/uapi/linux/perf_event.h |  1 +
 kernel/events/core.c            |  4 +++-
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 9b3e265a9fed..d224abddc3af 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -310,6 +310,13 @@ static int perf_ibs_init(struct perf_event *event)
 	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
 		event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
 
+	/*
+	 * Setting _EARLY flag makes sure generic perf driver does not
+	 * overwrite physical address set by arch specific pmu driver.
+	 */
+	if (event->attr.sample_type & PERF_SAMPLE_PHYS_ADDR)
+		event->attr.sample_type |= __PERF_SAMPLE_PHYS_ADDR_EARLY;
+
 	return 0;
 }
 
@@ -999,13 +1006,36 @@ static void perf_ibs_get_data_addr(struct perf_event *event,
 	data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
 }
 
+static void perf_ibs_get_phy_addr(struct perf_event *event,
+				  struct perf_ibs_data *ibs_data,
+				  struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+	union ibs_op_data3 op_data3;
+
+	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+
+	if (!(event->attr.sample_type & PERF_SAMPLE_DATA_SRC))
+		perf_ibs_get_mem_op(&op_data3, data);
+
+	if ((data_src->mem_op != PERF_MEM_OP_LOAD &&
+	    data_src->mem_op != PERF_MEM_OP_STORE) ||
+	    !op_data3.dc_phy_addr_valid) {
+		data->phys_addr = 0x0;
+		return;
+	}
+
+	data->phys_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
+}
+
 static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
 				   int check_rip)
 {
 	if (sample_type & PERF_SAMPLE_RAW ||
 	    (perf_ibs == &perf_ibs_op &&
 	    (sample_type & PERF_SAMPLE_DATA_SRC ||
-	     sample_type & PERF_SAMPLE_ADDR)))
+	     sample_type & PERF_SAMPLE_ADDR ||
+	     sample_type & PERF_SAMPLE_PHYS_ADDR)))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
@@ -1119,6 +1149,8 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 			perf_ibs_get_data_src(event, &ibs_data, &data);
 		if (event->attr.sample_type & PERF_SAMPLE_ADDR)
 			perf_ibs_get_data_addr(event, &ibs_data, &data);
+		if (event->attr.sample_type & PERF_SAMPLE_PHYS_ADDR)
+			perf_ibs_get_phy_addr(event, &ibs_data, &data);
 	}
 
 	/*
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 1c3157c1be9d..daf7c337e53e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -165,6 +165,7 @@ enum perf_event_sample_format {
 
 	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
 
+	__PERF_SAMPLE_PHYS_ADDR_EARLY		= 1ULL << 62, /* non-ABI; internal use */
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80782cddb1da..f1b486410d0b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7403,8 +7403,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 		header->size += size;
 	}
 
-	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
+	if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
+	    !(sample_type & __PERF_SAMPLE_PHYS_ADDR_EARLY)) {
 		data->phys_addr = perf_virt_to_phys(data->addr);
+	}
 
 #ifdef CONFIG_CGROUP_PERF
 	if (sample_type & PERF_SAMPLE_CGROUP) {
-- 
2.31.1

