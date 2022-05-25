Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54842533A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbiEYJnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240393AbiEYJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:43:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F5E6574;
        Wed, 25 May 2022 02:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQkwgg8/IKc2jAvzjGuOuH9Vgi5PnwC/Mn8fr0trY0IKYYRXiu+clbPnJvijuqFJWUxwCcciNJiyIvvWfzZ4ggL/5EW1C+jF1xvYgtTOGRMyV3iNiWZ/lKmm1WJB5oPFb9HuWAikngnMc92nW0LGM/B1dNia5K0RdU4H6FNyrQFVjT7cYdksmRzDWPsz5KRPhW+RTH60DTqP8RzN2JlZYw4NtRJKTX/8l1nOEMk9ZpzEidP9s5RLNkjOXgBjIHh0x3dHuXEmKqHeQN9t/6u4iMdBfjAEN9gFVHSR+/1HEs0VSvA3MCWKFLKYbpJdok9ngo5IfTT8nrZWjGfHrewPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmxCLra9A/+apIrP5YOKzIN03BAZr1wcsnoF806PkEk=;
 b=D+SwR8nmAVH0PoODkdZ3FcMQqTm4fNRm1CrZUHVkxdt9k1EclT2EIkqAkvWR+OaT7Sn1NEFjGCyoarFUU76N0nJp2R1uzruFmyMu8cCgJRQNtZ/xt3Fhi0FvE+m7Zgw2Kd1sTEvCgwBozgAyCUrAahoYW+MvN1mfBno3LlXIU2ZSnmjnnpDrENJcROO+9l+sIsXrwulXevMTTgvtn9pAGQ8R2gGFac0pHZPgdD49jZba0vtbRskdbrDCcVbtm9fWcV8Spf5u2ZgyPVm6w3/U1v9O3ylYJQEGpeooUPfMwPYCgEmcSCmRpD12YAdm555kZfA9ZYvPRnAKpU+Zsb3S7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmxCLra9A/+apIrP5YOKzIN03BAZr1wcsnoF806PkEk=;
 b=3CyU7VnLd1d1o89kb14jJ/mKLGTiG+EuPNOFlt+eyqPzkahruwA+CN9J3ss0FO3rBtp12YRfBdAQQYxM3X8Tj/PL6ISdUcp35ngpzM/FFCmh/sP1ts8D5kSDOuFnYDVMLUkc2apBuxOpCSX6hMlgPl8EeQXLejGowL+UAOzBX5o=
Received: from MWHPR07CA0024.namprd07.prod.outlook.com (2603:10b6:300:116::34)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Wed, 25 May
 2022 09:42:59 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::f7) by MWHPR07CA0024.outlook.office365.com
 (2603:10b6:300:116::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 09:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:42:58 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:42:45 -0500
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
Subject: [PATCH 05/13] perf/x86/amd: Support PERF_SAMPLE_ADDR using IBS_DC_LINADDR
Date:   Wed, 25 May 2022 15:09:30 +0530
Message-ID: <20220525093938.4101-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525093938.4101-1-ravi.bangoria@amd.com>
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e52838d7-24b1-4772-fa2c-08da3e32f3d8
X-MS-TrafficTypeDiagnostic: CY5PR12MB6324:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6324FED2B65E6069A617445EE0D69@CY5PR12MB6324.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGIzb1mrBYZJyGby0zq+4H4n62zSSyAkFlBNQPua9aTBCt0sAiqoougsZYOidYLt5KlbOQqWE9li/XNQdOtXj+Y5SvwJU8pJDTp4dDGxtwCJdv2DUCaY8lKL/UD6DIZx5ykq3hjhytF7tblpDQgxcIowKycA5DTqdURPI5OL7JD82nIOcx9fqU7a6hHq2gXIgw+q8JTvmiodc5AzemLmyXGmfKCng4hqqeL0Qm4Ugtp7pZGcVBjZyXm8UBcXpJ8nKsxEbFWMeQSnRH5TqAtiTZubyeVidyDQMeZGT9RCM7xaTh8qbVS5wZp+ejJMz1I+v6z2XcMh9sLHSr0kK2Q1/07Q8P2LxOAxT8c3BWEYFAeUSWuHPyQT3VYGq1MJUc1sjZ4suFi8ZxBbh9ZL5jF6O6++9VlmA0CBljL41Z5mhsEB3L46cTdSNMF0B8hdmdM5K37XIgy7UUVIhiI2K71auIz9vc32yrUeHFMYJP7LYY3zQ19bT54U2zP8uPW2YAjORKUSWhC5X2Li/iOfyPL3I9mCd3gynVfbTNbnJSe+hhl8JQaxxSwe8kBxxuJ1CDjm9lLk1pH+aHLqu+M6maRq4dBdCLrhcq1x/15Eouml/LSnDvnl6AiyxTuZjrTF1Pd344bpNMfy3U8mUkikbSaiemsq87/qC/F59qgoAY3BwSVay9CuRRdRERpkjS8sGYk87IJzNaYVAbWnJyv7O1lt2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(6666004)(7416002)(8936002)(44832011)(40460700003)(508600001)(5660300002)(336012)(47076005)(16526019)(1076003)(426003)(186003)(86362001)(70586007)(316002)(7696005)(70206006)(2906002)(110136005)(356005)(82310400005)(81166007)(4326008)(83380400001)(26005)(8676002)(54906003)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:42:58.4685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e52838d7-24b1-4772-fa2c-08da3e32f3d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324
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
 arch/x86/events/amd/ibs.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 5a6e278713f4..b57736357e25 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -965,12 +965,34 @@ static void perf_ibs_get_data_src(struct perf_event *event,
 	perf_ibs_get_mem_lock(op_data3, data);
 }
 
+static void perf_ibs_get_data_addr(struct perf_event *event,
+				   struct perf_ibs_data *ibs_data,
+				   struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+	u64 op_data3 = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+	u64 lin_addr_valid = op_data3 & IBS_DC_LIN_ADDR_VALID_MASK;
+
+	if (!(event->attr.sample_type & PERF_SAMPLE_DATA_SRC))
+		perf_ibs_get_mem_op(op_data3, data);
+
+	if ((data_src->mem_op != PERF_MEM_OP_LOAD &&
+	    data_src->mem_op != PERF_MEM_OP_STORE) ||
+	    !lin_addr_valid) {
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
@@ -1082,6 +1104,8 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	if (perf_ibs == &perf_ibs_op) {
 		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC)
 			perf_ibs_get_data_src(event, &ibs_data, &data);
+		if (event->attr.sample_type & PERF_SAMPLE_ADDR)
+			perf_ibs_get_data_addr(event, &ibs_data, &data);
 	}
 
 	/*
-- 
2.31.1

