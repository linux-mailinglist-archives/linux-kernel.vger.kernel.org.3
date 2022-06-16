Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5D54E028
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376903AbiFPLk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376844AbiFPLkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:40:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664255EBDE;
        Thu, 16 Jun 2022 04:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2ALMc8VqIFoZGoYueNeURUbLKMAVJCZCyBSzHvkflq6Sz5uXULYA0gWNfmGlHUa6GX5Q+Hb4QmQ7CDNENX+qBZ30yx4Ilw9BUngByIrTvYxf1Mp0T71S6vQ7RkuH7Kwg0g7z1RAjmINDzjLuYAfHxP6THSCHEaEhDd4pMoTvMTf9Mmj0xEu5lrd0nUoKLgap44N/yfC3jZE4RS6vBbBfPep3uXxI66ffWOB7yNcEhcKt1i26HdY3en4Ixyy3axALhDQhZEgj7tfY11dekPA8Xr+lC/3O8ePYmhjTaYn09HsKAms4nhcCB7Ihr46GMIYc63eOYsM8ma6RqAyUuW7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KG/zn2yxtQbyxKTAi5LWZHqFAxPtY9J8mw27R3U5/o=;
 b=MgUGIyP7GmkmVNVlyrwWi3NgTgkXLd0I9O6Hbi8CZgWQN7CIykUJ/IBPKSsZMCyxkrx3+I9aq8/CWpjKHYqbMp/S0v64ViPZk4I0fx30Jwu3ctrAjsDQTtj/832flBD8J7hLedkDLHULj9auf6xBbT83B+erx2qJGMsRlWPcVly+0GPUSK9urBLUFMewohU1fl9ZFGJ+6ftilVC3+KKmheC/s2LXgNZX/eX9TDcWSA63G+M9H/PDWFTiGRjGNIDAnslelA+HLg5/l7KVrXhR4vo8GsCLyx/nRucugbpGK8nft/g2YLnqf/amfIqHLIomgN2e57SgylWg2RX2a7A35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KG/zn2yxtQbyxKTAi5LWZHqFAxPtY9J8mw27R3U5/o=;
 b=PG0P9mcKUb2eJrYqHjdjCGyVhGpFCoSUENmssiJVx7sQ+X239oI/uQWBlND7ZaZEgD1pzmkuBruPZM6lPfyGr3w6lA8/PtHIf0MSA3Z+KXDuiZrQ2OGd9oqQGTlt5z5rIxSTFE+h/+9leq6tqHnQ/xvIDBp9vl6NbVVRT58rWPQ=
Received: from MWHPR14CA0003.namprd14.prod.outlook.com (2603:10b6:300:ae::13)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 11:40:52 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::5e) by MWHPR14CA0003.outlook.office365.com
 (2603:10b6:300:ae::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Thu, 16 Jun 2022 11:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:40:51 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:39:39 -0500
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
Subject: [PATCH v2 03/14] perf/x86/amd: Support PERF_SAMPLE_DATA_SRC
Date:   Thu, 16 Jun 2022 17:06:26 +0530
Message-ID: <20220616113638.900-4-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6eee8822-482a-4edb-da12-08da4f8d10aa
X-MS-TrafficTypeDiagnostic: SA0PR12MB4591:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4591BF673A9C08D9948EC387E0AC9@SA0PR12MB4591.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6O0tUe1hrFpwTtdK4wIFjMd3xsW8s1/8VfcAmifDPxckfX/cIbwn8jtJWDav5m4Zz82wgds2VgDsX9VQc6s+SQFafbb6GGTj9quCEnpV8H2nZ0xXzSq1Qwx+e7/rRAoejSs+lpym0DGxWFiRuBavKZ+Hm3/ujGus2+Qdq7cc0Ei+QQpO8C+szLbmlJGJXZnCmTHjLjEScoU661CilBZkXgwPF+whKCBSz3vk4o62fdkNQVLQg9xeZSJ8PRvFuRYiV41GgF0xUBnPJGOq+DBccwgApujCM6RhykAagJCXY0JZodJVC6MiBAM24ud5hnT4X4fYGlZnOIJaYisW/m7V/Grffr1WxNpEwlUV96BlCfVgxthGRT0y/Bxf4ASfwsBvnIsnr/Ogy+SJ7SjAO4tohqEMK15D+PYQPNsboaW2/nhrOekU0YZ9RZQ0L+e1g8FQZjA2RzescTODVvVP5n4l1nOSErGg1loqLpkreXwJeO80xujCnYjzNhfx4FTKofcmYf2JthGkar6306z6uw0TtFfmZKDklZRbsd++aOv7N7kDT2tO8QvWW7qWtiNhOY4pLwumI1JIZPfZA/9dCnoSiY3yxOAOZRiy1QY8oT57pTSHbPwU1xz775+LwOqKg2A8poejBkmBCABAaKAbiiJq2I86RW3yv2xtaEC1OvCsJ/zPxCsycT/BmHG7sJd5l1yGCMfoxyVeQpH6cXLtPbrBvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(1076003)(186003)(6666004)(47076005)(16526019)(426003)(2616005)(40460700003)(336012)(36860700001)(70206006)(26005)(7696005)(81166007)(86362001)(356005)(83380400001)(8936002)(44832011)(5660300002)(7416002)(8676002)(4326008)(36756003)(82310400005)(110136005)(54906003)(316002)(2906002)(508600001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:40:51.2930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eee8822-482a-4edb-da12-08da4f8d10aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct perf_mem_data_src is used to pass arch specific memory access
details into generic form. These details gets consumed by tools like
perf mem and c2c. IBS tagged load/store sample provides most of the
information needed for these tools. Add a logic to convert IBS
specific raw data into perf_mem_data_src.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 302 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 296 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c251bc44c088..de2632a2e44d 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -688,6 +688,294 @@ static struct perf_ibs perf_ibs_op = {
 	.get_count		= get_ibs_op_count,
 };
 
+static void perf_ibs_get_mem_op(union ibs_op_data3 *op_data3,
+				struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->mem_op = PERF_MEM_OP_NA;
+
+	if (op_data3->ld_op)
+		data_src->mem_op = PERF_MEM_OP_LOAD;
+	else if (op_data3->st_op)
+		data_src->mem_op = PERF_MEM_OP_STORE;
+}
+
+/*
+ * Processors having CPUID_Fn8000001B_EAX[11] aka IBS_CAPS_ZEN4 has
+ * more fine granular DataSrc encodings. Others have coarse.
+ */
+static u8 perf_ibs_data_src(union ibs_op_data2 *op_data2)
+{
+	if (ibs_caps & IBS_CAPS_ZEN4)
+		return (op_data2->data_src_hi << 3) | op_data2->data_src_lo;
+
+	return op_data2->data_src_lo;
+}
+
+static void perf_ibs_get_mem_lvl(struct perf_event *event,
+				 union ibs_op_data2 *op_data2,
+				 union ibs_op_data3 *op_data3,
+				 struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+	u8 ibs_data_src = perf_ibs_data_src(op_data2);
+
+	data_src->mem_lvl = 0;
+
+	/*
+	 * DcMiss, L2Miss, DataSrc, DcMissLat etc. are all invalid for Uncached
+	 * memory accesses. So, check DcUcMemAcc bit early.
+	 */
+	if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO) {
+		data_src->mem_lvl = PERF_MEM_LVL_UNC | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* L1 Hit */
+	if (op_data3->dc_miss == 0) {
+		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* L2 Hit */
+	if (op_data3->l2_miss == 0) {
+		/* Erratum #1293 */
+		if (boot_cpu_data.x86 != 0x19 || boot_cpu_data.x86_model > 0xF ||
+		    !(op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc)) {
+			data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
+			return;
+		}
+	}
+
+	/* L3 Hit */
+	if (ibs_caps & IBS_CAPS_ZEN4) {
+		if (data_src->mem_op == PERF_MEM_OP_LOAD &&
+		    ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE) {
+			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+			return;
+		}
+	} else {
+		if (data_src->mem_op == PERF_MEM_OP_LOAD &&
+		    ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
+			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_REM_CCE1 |
+					    PERF_MEM_LVL_HIT;
+			return;
+		}
+	}
+
+	/* A peer cache in a near CCX. */
+	if (ibs_caps & IBS_CAPS_ZEN4 && data_src->mem_op == PERF_MEM_OP_LOAD &&
+	    ibs_data_src == IBS_DATA_SRC_EXT_NEAR_CCX_CACHE) {
+		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* A peer cache in a far CCX. */
+	if (ibs_caps & IBS_CAPS_ZEN4) {
+		if (data_src->mem_op == PERF_MEM_OP_LOAD &&
+		    ibs_data_src == IBS_DATA_SRC_EXT_FAR_CCX_CACHE) {
+			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
+			return;
+		}
+	} else {
+		if (data_src->mem_op == PERF_MEM_OP_LOAD &&
+		    ibs_data_src == IBS_DATA_SRC_REM_CACHE) {
+			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
+			return;
+		}
+	}
+
+	/* DRAM */
+	if (data_src->mem_op == PERF_MEM_OP_LOAD &&
+	    ibs_data_src == IBS_DATA_SRC_EXT_DRAM) {
+		if (op_data2->rmt_node == 0)
+			data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
+		else
+			data_src->mem_lvl = PERF_MEM_LVL_REM_RAM1 | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* PMEM */
+	if (ibs_caps & IBS_CAPS_ZEN4 && data_src->mem_op == PERF_MEM_OP_LOAD &&
+	    ibs_data_src == IBS_DATA_SRC_EXT_PMEM) {
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_PMEM;
+		if (op_data2->rmt_node) {
+			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+			/* IBS doesn't provide Remote socket detail */
+			data_src->mem_hops = PERF_MEM_HOPS_1;
+		}
+		return;
+	}
+
+	/* Extension Memory */
+	if (ibs_caps & IBS_CAPS_ZEN4 && data_src->mem_op == PERF_MEM_OP_LOAD &&
+	    ibs_data_src == IBS_DATA_SRC_EXT_EXT_MEM) {
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_EXTN_MEM;
+		if (op_data2->rmt_node) {
+			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+			/* IBS doesn't provide Remote socket detail */
+			data_src->mem_hops = PERF_MEM_HOPS_1;
+		}
+		return;
+	}
+
+	/* IO */
+	if (data_src->mem_op == PERF_MEM_OP_LOAD &&
+	    ibs_data_src == IBS_DATA_SRC_EXT_IO) {
+		data_src->mem_lvl = PERF_MEM_LVL_IO;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_IO;
+		if (op_data2->rmt_node) {
+			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+			/* IBS doesn't provide Remote socket detail */
+			data_src->mem_hops = PERF_MEM_HOPS_1;
+		}
+		return;
+	}
+
+	/*
+	 * MAB (Miss Address Buffer) Hit. MAB keeps track of outstanding
+	 * DC misses. However such data may come from any level in mem
+	 * hierarchy. IBS provides detail about both MAB as well as actual
+	 * DataSrc simultaneously. Prioritize DataSrc over MAB, i.e. set
+	 * MAB only when IBS fails to provide DataSrc.
+	 */
+	if (op_data3->dc_miss_no_mab_alloc) {
+		data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	data_src->mem_lvl = PERF_MEM_LVL_NA;
+}
+
+static bool perf_ibs_cache_hit_st_valid(void)
+{
+	/* 0: Uninitialized, 1: Valid, -1: Invalid */
+	static int cache_hit_st_valid;
+
+	if (unlikely(!cache_hit_st_valid)) {
+		if (boot_cpu_data.x86 == 0x19 &&
+		    (boot_cpu_data.x86_model <= 0xF ||
+		    (boot_cpu_data.x86_model >= 0x20 &&
+		     boot_cpu_data.x86_model <= 0x5F))) {
+			cache_hit_st_valid = -1;
+		} else {
+			cache_hit_st_valid = 1;
+		}
+	}
+
+	return cache_hit_st_valid == 1;
+}
+
+static void perf_ibs_get_mem_snoop(union ibs_op_data2 *op_data2,
+				   struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+	u8 ibs_data_src;
+
+	data_src->mem_snoop = PERF_MEM_SNOOP_NA;
+
+	if (!perf_ibs_cache_hit_st_valid() ||
+	    data_src->mem_op != PERF_MEM_OP_LOAD ||
+	    data_src->mem_lvl & PERF_MEM_LVL_L1 ||
+	    data_src->mem_lvl & PERF_MEM_LVL_L2 ||
+	    op_data2->cache_hit_st)
+		return;
+
+	ibs_data_src = perf_ibs_data_src(op_data2);
+
+	if (ibs_caps & IBS_CAPS_ZEN4) {
+		if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE ||
+		    ibs_data_src == IBS_DATA_SRC_EXT_NEAR_CCX_CACHE ||
+		    ibs_data_src == IBS_DATA_SRC_EXT_FAR_CCX_CACHE)
+			data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+	} else if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
+		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+	}
+}
+
+static void perf_ibs_get_tlb_lvl(union ibs_op_data3 *op_data3,
+				 struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->mem_dtlb = PERF_MEM_TLB_NA;
+
+	if (!op_data3->dc_lin_addr_valid)
+		return;
+
+	if (!op_data3->dc_l1tlb_miss) {
+		data_src->mem_dtlb = PERF_MEM_TLB_L1 | PERF_MEM_TLB_HIT;
+		return;
+	}
+
+	if (!op_data3->dc_l2tlb_miss) {
+		data_src->mem_dtlb = PERF_MEM_TLB_L2 | PERF_MEM_TLB_HIT;
+		return;
+	}
+
+	data_src->mem_dtlb = PERF_MEM_TLB_L2 | PERF_MEM_TLB_MISS;
+}
+
+static void perf_ibs_get_mem_lock(union ibs_op_data3 *op_data3,
+				  struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->mem_lock = PERF_MEM_LOCK_NA;
+
+	if (op_data3->dc_locked_op)
+		data_src->mem_lock = PERF_MEM_LOCK_LOCKED;
+}
+
+#define ibs_op_msr_idx(msr)	(msr - MSR_AMD64_IBSOPCTL)
+
+static void perf_ibs_get_data_src(struct perf_event *event,
+				  struct perf_ibs_data *ibs_data,
+				  struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+	union ibs_op_data2 op_data2;
+	union ibs_op_data3 op_data3;
+
+	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+
+	perf_ibs_get_mem_op(&op_data3, data);
+	if (data_src->mem_op != PERF_MEM_OP_LOAD &&
+	    data_src->mem_op != PERF_MEM_OP_STORE)
+		return;
+
+	op_data2.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA2)];
+
+	/* Erratum #1293 */
+	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model <= 0xF &&
+	    (op_data3.sw_pf || op_data3.dc_miss_no_mab_alloc)) {
+		/*
+		 * OP_DATA2 has only two fields on Zen3: DataSrc and RmtNode.
+		 * DataSrc=0 is No valid status and RmtNode is invalid when
+		 * DataSrc=0.
+		 */
+		op_data2.val = 0;
+	}
+
+	perf_ibs_get_mem_lvl(event, &op_data2, &op_data3, data);
+	perf_ibs_get_mem_snoop(&op_data2, data);
+	perf_ibs_get_tlb_lvl(&op_data3, data);
+	perf_ibs_get_mem_lock(&op_data3, data);
+}
+
+static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
+				   int check_rip)
+{
+	if (sample_type & PERF_SAMPLE_RAW ||
+	    (perf_ibs == &perf_ibs_op &&
+	     sample_type & PERF_SAMPLE_DATA_SRC))
+		return perf_ibs->offset_max;
+	else if (check_rip)
+		return 3;
+	return 1;
+}
+
 static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 {
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
@@ -735,12 +1023,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	size = 1;
 	offset = 1;
 	check_rip = (perf_ibs == &perf_ibs_op && (ibs_caps & IBS_CAPS_RIPINVALIDCHK));
-	if (event->attr.sample_type & PERF_SAMPLE_RAW)
-		offset_max = perf_ibs->offset_max;
-	else if (check_rip)
-		offset_max = 3;
-	else
-		offset_max = 1;
+
+	offset_max = perf_ibs_get_offset_max(perf_ibs, event->attr.sample_type, check_rip);
+
 	do {
 		rdmsrl(msr + offset, *buf++);
 		size++;
@@ -793,6 +1078,11 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		data.raw = &raw;
 	}
 
+	if (perf_ibs == &perf_ibs_op) {
+		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC)
+			perf_ibs_get_data_src(event, &ibs_data, &data);
+	}
+
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
 	 * recorded as part of interrupt regs. Thus we need to use rip from
-- 
2.31.1

