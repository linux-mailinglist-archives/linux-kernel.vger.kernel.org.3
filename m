Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D7154E030
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376886AbiFPLms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiFPLmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:42:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A91B12D0E;
        Thu, 16 Jun 2022 04:42:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaeAMVH5PsKchE+4AHbEMa+znmpaKN7MEMUnICd2y6Cgrw55l7Wk9OxApQB8pn+8OFfadDHbC2pqpTgQXAKC6pfP64x7lw+mZ9YRF9UfYgIw/OLIcUhz1THlQj4Otl68J4yQl4wXa0E69lQbDzrPtY/JgPlutuQAcpklTMI6AlfvcHBokf6hksmMky/19zmy8MI1NEAp4Rlhzit9iUpmeEebNmiY05SSpB1g45oWpXIsuoP4Rzlw9abWAJTU9vppb6z3Bdxd+lkvuWN4wKLTf00klXFkdvcRRy8B2o2hkGDgNs7CSqRyk41jS89MB7Xl6GdLXD5oo2CEnTFqOUiUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKBoy89Cxn0zy0tJ8vNblFuHyrEGy/NrLjZ6yaKBIFs=;
 b=AfZcL+is2QjEWCO27ZGGBRaEymFULSrlOCikF1EACAOiNB+dxd+X1OdCMjcgId/b1zXzgIFzB4yYTLzVfrrAUptcEOuj7eHm/3t7B1zy7apFOhi4X0YSsJRJ0Vqn+/W1qoptYin7BvFq1YDJubOjuA7jyrbBIcCZbwh6EcY7HzPkUygvkXtvRpvetRrs8PYSI59X7uvhHTzn8F/nrylLgUqLb3HFMTMO12V23qZK4yabrH689QfTRyOO4FJg5e0g4KwGZBs30lVla5UJUihKl8eZ6zR9VhAOniNoYS7WscRpkJfbA0G1ivDf01h3vGW953PZIXzhUhByJIb/15eS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKBoy89Cxn0zy0tJ8vNblFuHyrEGy/NrLjZ6yaKBIFs=;
 b=eECzRqro5mOnloy21LGpcS9+lFUqmxcpdhLjWQiGGxn8EuXv/xfq5L9rmc1Ss5pOK9jokRn6i9Q4OJwHUG1kfombgTzAtSgkIWqQNO0uv/VBuQM5ChbthXHPiVsrSyaBbwux858jYVMTtrwjcL1V1SOX9zhdTrYbwAtCOUz3CMA=
Received: from MWHPR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:301:15::22) by DM5PR12MB1916.namprd12.prod.outlook.com
 (2603:10b6:3:112::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Thu, 16 Jun
 2022 11:42:42 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::c7) by MWHPR2001CA0012.outlook.office365.com
 (2603:10b6:301:15::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Thu, 16 Jun 2022 11:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:42:41 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:40:49 -0500
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
Subject: [PATCH v2 04/14] perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}
Date:   Thu, 16 Jun 2022 17:06:27 +0530
Message-ID: <20220616113638.900-5-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e07aacc8-2536-4939-07be-08da4f8d5261
X-MS-TrafficTypeDiagnostic: DM5PR12MB1916:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB19161B7338120F69987F9767E0AC9@DM5PR12MB1916.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33hoyH0puJ841ty88cM0F07u44yQsD2rXmlt2VAOrztlc6esfTuOcq5heJUCzd+OoY0JmqyjF1jlui9eH8bs8JdzKzzcB+cYzUguuW9kJ1V5NKxisCqHjLls/XA9AzD0wIIyCa57wlBmzCCS4sm264WJvY9aNglaZe9tjMb4SwFkpNrNsbDlIYbWSsE68duqxMOwT0wAhNTk0Roe6sgDVELoEc8UKDxjrEefMZ8VwEWvftNiyAJRvxB5qu+POnU25KSZcCMTAXhiB4S3t8H7GfF5+Ckj+/JpAtGoLijzc6EDljJEYOAvf2M36mFQ8fE8Se9OxCrqMLLxebAEyrPBJXuku8qJtpzJYhcDRv6mZC8gS534wW5aj7R6Zi/UXYacWLUlgd2hPK0/CZGtUnyJXmGidyy5myRNjYTgsepaUoJRjBuIZ+EmZiYts4hmOJcGjE4mhVhfbxFNCIlRv18cgfLbH1xEATFssULLcuDN/WDSux10HwuK2Z8+6C7xAqYPFxpWjjFrx3BpuK1tuFajItNI3ph6/QNnSUC2ALUVwRInFdw4gx9sMQSacTX8Siz3s242TbUr1fOI4+i3qv5pqGGCUXvsnGHC/ybA+lQOCkYBG8dHNcLwRJEJ6rJ9ljLQWqIcDcDhFhB9Z0E7kHG+UQFNCvN8XiX544ZMaPRCAXEXJJqWR5PjM5JuMwyZgS7RJxiTByvRJ+2UFBoEkOu+yzLnKFkQBBiHFRf38zz7mJ1chG9Dl76tOKrbfg+ba63XKlcpsjARdV74/uR0YiTRFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(4326008)(508600001)(5660300002)(82310400005)(36756003)(36860700001)(8676002)(70206006)(110136005)(44832011)(83380400001)(70586007)(7416002)(54906003)(8936002)(336012)(6666004)(316002)(47076005)(186003)(426003)(2616005)(1076003)(16526019)(356005)(40460700003)(86362001)(2906002)(7696005)(26005)(81166007)(16393002)(83133001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:42:41.5545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e07aacc8-2536-4939-07be-08da4f8d5261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IbsDcMissLat indicates the number of clock cycles from when a miss is
detected in the data cache to when the data was delivered to the core.
Similarly, IbsTagToRetCtr provides number of cycles from when the op
was tagged to when the op was retired. Consider these fields for
sample->weight. Note that sample->weight will be populated only when
PERF_SAMPLE_DATA_SRC is also set, although PERF_SAMPLE_WEIGHT_STRUCT
and PERF_SAMPLE_WEIGHT are independent of PERF_SAMPLE_DATA_SRC.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index de2632a2e44d..830e527a29c3 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -714,6 +714,7 @@ static u8 perf_ibs_data_src(union ibs_op_data2 *op_data2)
 }
 
 static void perf_ibs_get_mem_lvl(struct perf_event *event,
+				 union ibs_op_data *op_data,
 				 union ibs_op_data2 *op_data2,
 				 union ibs_op_data3 *op_data3,
 				 struct perf_sample_data *data)
@@ -738,6 +739,16 @@ static void perf_ibs_get_mem_lvl(struct perf_event *event,
 		return;
 	}
 
+	/* Load latency (Data cache miss latency) */
+	if (data_src->mem_op == PERF_MEM_OP_LOAD) {
+		if (event->attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
+			data->weight.var1_dw = op_data3->dc_miss_lat;
+			data->weight.var2_w = op_data->tag_to_ret_ctr;
+		} else if (event->attr.sample_type & PERF_SAMPLE_WEIGHT) {
+			data->weight.full = op_data3->dc_miss_lat;
+		}
+	}
+
 	/* L2 Hit */
 	if (op_data3->l2_miss == 0) {
 		/* Erratum #1293 */
@@ -935,6 +946,7 @@ static void perf_ibs_get_data_src(struct perf_event *event,
 				  struct perf_sample_data *data)
 {
 	union perf_mem_data_src *data_src = &data->data_src;
+	union ibs_op_data op_data;
 	union ibs_op_data2 op_data2;
 	union ibs_op_data3 op_data3;
 
@@ -945,6 +957,7 @@ static void perf_ibs_get_data_src(struct perf_event *event,
 	    data_src->mem_op != PERF_MEM_OP_STORE)
 		return;
 
+	op_data.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA)];
 	op_data2.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA2)];
 
 	/* Erratum #1293 */
@@ -958,7 +971,7 @@ static void perf_ibs_get_data_src(struct perf_event *event,
 		op_data2.val = 0;
 	}
 
-	perf_ibs_get_mem_lvl(event, &op_data2, &op_data3, data);
+	perf_ibs_get_mem_lvl(event, &op_data, &op_data2, &op_data3, data);
 	perf_ibs_get_mem_snoop(&op_data2, data);
 	perf_ibs_get_tlb_lvl(&op_data3, data);
 	perf_ibs_get_mem_lock(&op_data3, data);
-- 
2.31.1

