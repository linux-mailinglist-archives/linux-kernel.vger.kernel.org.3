Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D073054E032
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376913AbiFPLon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiFPLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:44:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2DC58390;
        Thu, 16 Jun 2022 04:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afk1nvmdl6Ah3V96cZHJ2RQ2gDzw6Xc/XT4sry1hGoeJl3XIoBBcgOPKQtpUb/NSiUHS/sjdDXsY58wD/N1Y2vdLg1KUE3S/Gm83CiC6F2dmvb0CoYZdkpBiCja+MpFNjtnjgkG5dnxQ3VgZZoWSB1TqnFoPgkcWYAa09upOkxtHEI2XNdjPvhmRl1ZvuC7UIctffbZ/bw2jJCYfT1VEBJbgXOgedfU1cDnkejAGraeik3e4b4wA4+es1LPItfxH8A1lftQ8VmNNIxMUOPSqSm0X+1pweszVkCJo+cXaRH64SL78L6cPQyIZA4SvIkdVOh+cnz/ErA75J39EGQwnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VGT8GpNZWS63i1fneg/obA+kaE6/v71B2G5DcOAsDM=;
 b=DEDfEHsWS1tMuiUe8qbmUtTjVIjWoOf5e1UrjJtwdB+klngYEkoUCLgcUbTRKMxlt0BLg0/CytDbT9WmPRYkYVGkVjQc+HUzuc18GGGCznYnAP7XJ4x5Uf187+DuxDIFyUuq/wt3dG3VegqBZ/OliwqNwpeRCOFNzN5/xfTjimiQWMVupTksBU7+/RhxVYOGGsEdWqtjzioXE2kCdPLbIvejciBObykGZjki81NeGhDKwk3IRdaSQ+AKs6cGScK1/XHc3OaEqMHGdUwItDLy5PHBoA3ca/82Tem1YGQYf5sVtfgn1+I/dTgwk2xZAa1SAvUUZegBb1SUizmaHXnKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VGT8GpNZWS63i1fneg/obA+kaE6/v71B2G5DcOAsDM=;
 b=IL6Nbsdi4YCDR62mxFUf1tWBEnCD/viXfDmWdhTIhR8+W6TTF5z549QIW5w6801/VYBLPCfZ1ZQFP9y/lH/rQVsHNLDJu99Xmx9Oz92vIRQ5naVxYjwI8eVeJnpLV4BvwiDTC95W0sRfEKh6jboto1RMyJuldotaDxpssU+EYfw=
Received: from MWHPR1201CA0017.namprd12.prod.outlook.com
 (2603:10b6:301:4a::27) by BYAPR12MB2934.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 11:44:37 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::2b) by MWHPR1201CA0017.outlook.office365.com
 (2603:10b6:301:4a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 11:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:44:37 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:42:31 -0500
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
Subject: [PATCH v2 05/14] perf/x86/amd: Support PERF_SAMPLE_ADDR
Date:   Thu, 16 Jun 2022 17:06:28 +0530
Message-ID: <20220616113638.900-6-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e0db07f-addc-45e3-d139-08da4f8d973f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2934:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2934EF641E2DFC6C06618355E0AC9@BYAPR12MB2934.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRbIRpB0zYEVYECp/o+6W8KgIuIdrfptBmvG/kAbv52OePtLtqPS5ssT6GPFXjAnbnO6YShFFA3wGlrypOuwt4AaOWDSWywJUzDpOoCYtQtdtgcLp9ctK+vPXqaxEbfriVrD6Jcv0Y7WXiieaOryua0+YdYk+xM7B8PelHBIytZVSCzZ4c3QVkBcAbJqm2JVyixxr1Hcrov25U7ejTTazRKGVFlzftJueux0aoscSY6IYx3gVLQkzPuPtk+f6rfGPpuTRtyx57Ub8mfQeF4hSrONk46wKhtOT9aOiX5C+oCd5hFA3t/L1yw6kcnDRX45W9jw/6UUtrCtxqKrFGv4SuQ9kdo/pMLd1BlYycYG9hD82SJybxQ/sbTs2SoRT9sFfBAiBZP+HKBf/mYOipwSWm5n+u0hKwISltA1+dRjajbwLC2nfe5M/0AoK77kAYS/LO3vKIoxuw/csf34zA6eSV/BdsXdp+GnBnHYWxAPBnWgzXg87Q2npEeP2IUJkwjco/oSeP0FN/mpJohBiPpgtUUYlku6BP3BF6kC6qqm4fh0Q+J5f+rxiZDagWEMExl61i1aRbWIcy0/LQrogvLM9fJqO+WIvvlBukWNzHAciONAR+GGkkbYW+fXMnySBg4jNuvY/mtsJwBWxSQpFI+4ADH+cxsQee2iANdf/PUvZITtQ4tn4z7sNyC75eiXJltrZiRkPw8180PXjXtW4W1+Gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(508600001)(86362001)(186003)(7696005)(336012)(6666004)(36756003)(426003)(8676002)(316002)(54906003)(70206006)(110136005)(16526019)(70586007)(2616005)(1076003)(47076005)(81166007)(82310400005)(40460700003)(2906002)(26005)(4326008)(44832011)(5660300002)(7416002)(8936002)(356005)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:44:37.0996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0db07f-addc-45e3-d139-08da4f8d973f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS_DC_LINADDR provides the linear data address for the tagged load/
store operation. Populate perf sample address using it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 830e527a29c3..9b3e265a9fed 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -977,12 +977,35 @@ static void perf_ibs_get_data_src(struct perf_event *event,
 	perf_ibs_get_mem_lock(&op_data3, data);
 }
 
+static void perf_ibs_get_data_addr(struct perf_event *event,
+				   struct perf_ibs_data *ibs_data,
+				   struct perf_sample_data *data)
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
+	    !op_data3.dc_lin_addr_valid) {
+		data->addr = 0x0;
+		return;
+	}
+
+	data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
+}
+
 static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
 				   int check_rip)
 {
 	if (sample_type & PERF_SAMPLE_RAW ||
 	    (perf_ibs == &perf_ibs_op &&
-	     sample_type & PERF_SAMPLE_DATA_SRC))
+	    (sample_type & PERF_SAMPLE_DATA_SRC ||
+	     sample_type & PERF_SAMPLE_ADDR)))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
@@ -1094,6 +1117,8 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	if (perf_ibs == &perf_ibs_op) {
 		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC)
 			perf_ibs_get_data_src(event, &ibs_data, &data);
+		if (event->attr.sample_type & PERF_SAMPLE_ADDR)
+			perf_ibs_get_data_addr(event, &ibs_data, &data);
 	}
 
 	/*
-- 
2.31.1

