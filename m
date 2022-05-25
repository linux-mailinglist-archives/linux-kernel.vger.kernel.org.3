Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B342B533A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiEYJms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbiEYJmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:42:40 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9F8AE7B;
        Wed, 25 May 2022 02:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8yt43fpI+vRQm71ps/8mH/T8bDBzOEkqKCEzBPTLw3H6hWOJvj7RLPaswtyOBC9cqr399coxgbTxbpmOhVCPqTQ4k8gQWYNCjhkqGArYfALmu1fgkJu+ccJr/ajoIigrwi0BHGBjtspy+yti5nXlmOu7DKlCe+MICYtHRlpXTxBs/VCOpbdoQKnumFx+oGAuowmnd1bDY/AsAlV2Sls6uhsftOvBSUo4aFN+14lyA3z3H/qYGM+NhAkcJjpXEQn2v4cF10M/ehiDaf5r5LVEw7V+2KU2uuTFg3HNiUOZPUS0ApsOmbMhSG2EU6Y7ipgWAYPDcFI9GEX4BtaoJ2smw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YJPnu+/ryBq9CO7JYZXgLCx6ovvlbA81wAP2C9M1O8=;
 b=OFqARmtUD34bF9vHVzBeoEJJU8C00sWdWqHyRjaWEnfyzPKgUxR+nRMqpOkohf8LH0y/RLx+JQVZPBKqt7WT08rg8iHUf+zqhjCXAhcVqbx0ZMk53oNuhLpHHxvK9Oe5vWsLvIYTJ88rM2C3Odf8pq1PA012WT4AFA96gELPXc/PZ78wCdFyjswB2nUEraBl1+b8ALv7CfvrzoY6kDswppVms2q3jmEPf3tVDJ+Bspif8vuM+lT8vuCMy+RQdI/6eZt8KlwEONhWLmnYMdA4IBxF3JC0AjyYrwh56k5assBlOg5hUa0vb1F7MqBaIHeP5VrFhnFLqRpU8a6tBTX09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YJPnu+/ryBq9CO7JYZXgLCx6ovvlbA81wAP2C9M1O8=;
 b=D7MIcexEqNziNiaXbdRe7KwRVafuf2sWnhY7ZfzPrpEsdaUVqAk2v7Vuf1PKHgj5g4e3bebaw2UHdnYDFEcZShs6VcSTA7VEHiX4oyeuRyYx/GKUdUVAdrknWZQI5zJBLE/+nb8PZTlXav1zVENo9O3Nwz9LteoNHcyfi8BXv3U=
Received: from MW3PR06CA0002.namprd06.prod.outlook.com (2603:10b6:303:2a::7)
 by BN6PR12MB1812.namprd12.prod.outlook.com (2603:10b6:404:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 09:42:33 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::f) by MW3PR06CA0002.outlook.office365.com
 (2603:10b6:303:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 09:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:42:32 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:42:18 -0500
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
Subject: [PATCH 03/13] perf/x86/amd: Support PERF_SAMPLE_DATA_SRC based on IBS_OP_DATA*
Date:   Wed, 25 May 2022 15:09:28 +0530
Message-ID: <20220525093938.4101-4-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d13e7d7a-0f1b-4ba6-1d6b-08da3e32e45b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1812:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1812E061FECD53B1E387C1A2E0D69@BN6PR12MB1812.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2j6qB2YeGwMQi7d+lclvt2brIGDlvETrVyq0SUfUg7iO0J2oTFhxvDkrxQN5JRUpe8SsngOsPfaToLtzXEkFo9/Z4cgk8dOpth7XzMRdIMAXLdk4xPkkBVehjasuapKLi/d4W6ZEcuBCuKQU6F2KbxzyPldSossT7mbEhyaCvDPLLRTy/kqeQoHsjP72MS8IApop1he14B5WIlWvqsER98Z9SVJ/iLWUL5HYeZ8yluhftp+LvHrx0J59avlAQci7Ur+bJbKD7Z61ReqW0pMfqUgCac5QmUCw4CTaOrMqISgkHuF7e5YVeWa+XJ3pjwOGlUOIFWWwV0SS9qCN6Z+aF6DZ3ySOqdr8V+d20pEwwy0ik5f40g/Yk2c6rUvIDGvEb8SX7uPzL9R6Mf6utQxhDuF7zUan24NR+sxF8ajsvaSkWSRXxoa+qU834zPc9MgZd1W/dSE/oyeQrAXehb0kKwq5TvgDEwqIIWfLR+F0IifXv4a2k1Mx6pQTsME1vvLn/OfVu2W0Qdorxt9MWl/j/DibSzHV0Vv6bCy+algyZ/Q9ZSa/g/NZ90tOCet1FRNm9pzES0r3tZh+XL1DVyedg4xDCLHZPWdNSzJIlpdAylElBsL1dsaTEkW5vmxzgCw1J038FFW7eYJH50brRTIwIMVdo4aiTIptLkypOEg/z4Fhg8mUTccOLhz01+Iaftn2mksbzpvn97w8Mu9j/lvpgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(26005)(40460700003)(81166007)(1076003)(186003)(6666004)(36860700001)(7696005)(16526019)(36756003)(2906002)(82310400005)(8936002)(30864003)(44832011)(7416002)(508600001)(70206006)(70586007)(4326008)(8676002)(83380400001)(356005)(47076005)(426003)(86362001)(336012)(54906003)(110136005)(316002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:42:32.4778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13e7d7a-0f1b-4ba6-1d6b-08da3e32e45b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1812
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
perf mem and c2c. Each IBS tagged load/store sample provides most of
the information needed for these tools. Add a logic to convert IBS
specific raw data into perf_mem_data_src.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 297 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 291 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c251bc44c088..6626caeed6a1 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -688,6 +688,289 @@ static struct perf_ibs perf_ibs_op = {
 	.get_count		= get_ibs_op_count,
 };
 
+static void perf_ibs_get_mem_op(u64 op_data3, struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->mem_op = PERF_MEM_OP_NA;
+
+	if (op_data3 & IBS_LD_OP_MASK)
+		data_src->mem_op = PERF_MEM_OP_LOAD;
+	else if (op_data3 & IBS_ST_OP_MASK)
+		data_src->mem_op = PERF_MEM_OP_STORE;
+}
+
+/*
+ * Processors having CPUID_Fn8000001B_EAX[11] aka IBS_CAPS_ZEN4 has
+ * more fine granular DataSrc encodings. Others have coarse.
+ */
+static u8 perf_ibs_data_src(u64 op_data2)
+{
+	if (ibs_caps & IBS_CAPS_ZEN4) {
+		return ((op_data2 & IBS_DATA_SRC_HI_MASK) >> (IBS_DATA_SRC_HI_SHIFT - 3)) |
+		       ((op_data2 & IBS_DATA_SRC_LO_MASK) >> IBS_DATA_SRC_LO_SHIFT);
+	}
+
+	return (op_data2 & IBS_DATA_SRC_LO_MASK) >> IBS_DATA_SRC_LO_SHIFT;
+}
+
+static void perf_ibs_get_mem_lvl(struct perf_event *event, u64 op_data2,
+				 u64 op_data3, struct perf_sample_data *data)
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
+	if (op_data3 & IBS_DC_UC_MEM_ACC_MASK &&
+	    ibs_data_src != IBS_DATA_SRC_EXT_IO) {
+		data_src->mem_lvl = PERF_MEM_LVL_UNC | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* L1 Hit */
+	if ((op_data3 & IBS_DC_MISS_MASK) == 0) {
+		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* L2 Hit */
+	if ((op_data3 & IBS_L2_MISS_MASK) == 0) {
+		/* Erratum #1293 */
+		if (boot_cpu_data.x86 != 0x19 || boot_cpu_data.x86_model > 0xF ||
+		    !(op_data3 & IBS_SW_PF_MASK || op_data3 & IBS_DC_MISS_NO_MAB_ALLOC_MASK)) {
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
+		if ((op_data2 & IBS_RMT_NODE_MASK) == 0)
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
+		if (op_data2 & IBS_RMT_NODE_MASK) {
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
+		if (op_data2 & IBS_RMT_NODE_MASK) {
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
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_IO;
+		if (op_data2 & IBS_RMT_NODE_MASK) {
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
+	if (op_data3 & IBS_DC_MISS_NO_MAB_ALLOC_MASK) {
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
+	static int cache_hist_st_valid;
+
+	if (unlikely(!cache_hist_st_valid)) {
+		if (boot_cpu_data.x86 == 0x19 &&
+		    (boot_cpu_data.x86_model <= 0xF ||
+		    (boot_cpu_data.x86_model >= 0x20 &&
+		     boot_cpu_data.x86_model <= 0x5F))) {
+			cache_hist_st_valid = -1;
+		} else {
+			cache_hist_st_valid = 1;
+		}
+	}
+
+	return cache_hist_st_valid == 1;
+}
+
+static void perf_ibs_get_mem_snoop(u64 op_data2, struct perf_sample_data *data)
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
+	    op_data2 & IBS_CACHE_HIT_ST_MASK)
+		return;
+
+	ibs_data_src = perf_ibs_data_src(op_data2);
+
+	if ((ibs_data_src == IBS_DATA_SRC_LOC_CACHE) ||
+	    (ibs_caps & IBS_CAPS_ZEN4 && (
+	     ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE ||
+	     ibs_data_src == IBS_DATA_SRC_EXT_NEAR_CCX_CACHE ||
+	     ibs_data_src == IBS_DATA_SRC_EXT_FAR_CCX_CACHE))) {
+		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+	}
+}
+
+static void perf_ibs_get_tlb_lvl(u64 op_data3, struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+	u64 l1_tlb_miss = op_data3 & IBS_DC_L1_TLB_MISS_MASK;
+	u64 lin_addr_valid = op_data3 & IBS_DC_LIN_ADDR_VALID_MASK;
+	u64 l2_tlb_miss = op_data3 & IBS_DC_L2_TLB_MISS_MASK;
+
+	data_src->mem_dtlb = PERF_MEM_TLB_NA;
+
+	if (!lin_addr_valid)
+		return;
+
+	if (!l1_tlb_miss) {
+		data_src->mem_dtlb = PERF_MEM_TLB_L1 | PERF_MEM_TLB_HIT;
+		return;
+	}
+
+	if (!l2_tlb_miss) {
+		data_src->mem_dtlb = PERF_MEM_TLB_L2 | PERF_MEM_TLB_HIT;
+		return;
+	}
+
+	data_src->mem_dtlb = PERF_MEM_TLB_L2 | PERF_MEM_TLB_MISS;
+}
+
+static void perf_ibs_get_mem_lock(u64 op_data3, struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->mem_lock = PERF_MEM_LOCK_NA;
+
+	if (op_data3 & IBS_DC_LOCKED_OP_MASK)
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
+	u64 op_data2 = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA2)];
+	u64 op_data3 = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+
+	perf_ibs_get_mem_op(op_data3, data);
+	if (data_src->mem_op != PERF_MEM_OP_LOAD &&
+	    data_src->mem_op != PERF_MEM_OP_STORE)
+		return;
+
+	/* Erratum #1293 */
+	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model <= 0xF &&
+	    (op_data3 & IBS_SW_PF_MASK ||
+	     op_data3 & IBS_DC_MISS_NO_MAB_ALLOC_MASK)) {
+		/*
+		 * OP_DATA2 has only two fields on Zen3: DataSrc and RmtNode.
+		 * DataSrc=0 is No valid status and RmtNode is invalid when
+		 * DataSrc=0.
+		 */
+		op_data2 = 0;
+	}
+
+	perf_ibs_get_mem_lvl(event, op_data2, op_data3, data);
+	perf_ibs_get_mem_snoop(op_data2, data);
+	perf_ibs_get_tlb_lvl(op_data3, data);
+	perf_ibs_get_mem_lock(op_data3, data);
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
@@ -735,12 +1018,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
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
@@ -793,6 +1073,11 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
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

