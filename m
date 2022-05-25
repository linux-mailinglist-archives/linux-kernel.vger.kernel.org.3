Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791DF533A21
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbiEYJn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbiEYJni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:43:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E7F6423;
        Wed, 25 May 2022 02:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8chP5p0Uv8IMfQPeg1FGFbZCBvfpe7l03IarILJaI5Dp5VNdaZ7DvMS3vN/OwQPJi0bsocpuJLcYYWQ/17Ffgr3YCVB62fciDt42yhCSwIf/7StxFwSIS5xUybN2gxcSoQb72QMKfupYAhPiFJQknT/LlW3DMv4/Lxlk1hchyusdCNhjcXd7M1ZDIgN93XmVXzolpdnidXqKQwb+s+hTq2Mos4jSOzJhdbKiyqWa66ZxUSzTWRl8VacJJD3hoU/0aJGYp/WMgyReci/eRaYbyN/KhGJRqS8e4y9gnJrKRdZCyM3b1l6yEWDKK5mpn1c6Ys7Ager5mIz5UWWt1TPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOQbbCrCq1oj6rR2mCmOv0EpYneRHwD92+Nx+s5gpWA=;
 b=KWAt6RIMTZG48HN0wiRIIG8T8Szz82N6mV9r75R76YuvyV1eCfrCWKHjiSrXmhokmG6mhaRHjIbzBWnt+1HrWhaJjp9a7qsONU3zeQJu9AIxfE09JN32It3giqgHhBhVU2pjEOqAfLaHcZpjpz0KxOIvLEL2HaPGrgz5hjmimT3Q9GHAIwfYMetAm7FGoprx0xI930eL5CCWfktXadMsinmWYCkKPoFJbPWXM1IHIeXp/xSuR1OaroZVtUp9Ws2nUrTgXFlu0I4DXtlv0Jq8P3SRiUbljTlA8HOyul/mOtGyU5VoJ3ZhAJ0USpDIDaOts19r0rwcvRNE6/2ZB/NDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOQbbCrCq1oj6rR2mCmOv0EpYneRHwD92+Nx+s5gpWA=;
 b=2NCOusFqBnJI8fly0sj9FmeH4hSThkzJV9wuEy7T5L5nzqEIvTCsMksqdMpiLdCzVgvacX8NoHnV4ogCdmH/R1BsWBKxZX7y2N61oFmwR0hOrmxolJaIA4R6xrk5ofyyphRPL/tAEMUw39NnSeoUsnSkqpGGs/sfNFW8FpID7Hs=
Received: from MW4PR03CA0060.namprd03.prod.outlook.com (2603:10b6:303:8e::35)
 by DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 25 May
 2022 09:43:34 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::a1) by MW4PR03CA0060.outlook.office365.com
 (2603:10b6:303:8e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Wed, 25 May 2022 09:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:43:33 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:43:20 -0500
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
Subject: [PATCH 08/13] perf tool: Sync arch/x86/include/asm/amd-ibs.h header
Date:   Wed, 25 May 2022 15:09:33 +0530
Message-ID: <20220525093938.4101-9-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6279a4b3-9bc2-4aa8-d9d6-08da3e3308c6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2469:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2469D1D00437AF1208C58F83E0D69@DM5PR12MB2469.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1KQ0V4vmTJbnws6fEch4z0wmzHBfZ3vWYZ26VEle3GHifnHGSZdUNrCVn3RnEX5QWkz3br8Ojv8KNKDu1k/LH9hTWtMO3VXfWlqwiEcrI0tasqaHxb0Cy1RvQ161Ookp+BCkBoguFtvRruHwcjQV9PwKNY9qLPt7yze2vLKeXRMZ6x1wK4R2Yo6m1UVr/V7mxHAVFe424vN3IvxGF296rus6uR94paDGNk7BJl+6UVLSPuOEgR+yV+H/uShN0sBeP4FeRqgn3Jy5L/EfnDCEX6NP3cfiIEIm8ARCfUEilsT53sHg3JyewouHVS461puiLPA/5D8wZmGlX4OdU4wag51sOJO+0OSQKJj8dQykQuXuCOgmWN+4VnDeFiA466CWYOHnGf+nIWDPx/Gk+GxjWV5fy1lbOAnMeXP5KT0qFXlKUg6/dt9HAz+5WkWcD6LKUHAxuYx17uqfgQs2QGwvTLtOsjz+BFFboBZmx/e7O2cQIKrXinKIuHi7a9V0MKvGeoKaKillWewI0BioCxxlyxCWsO5GP6/5S5rrRFcKWtqaUN13REGg6nGUfOxqe6/n+61/xFOB571neSHtuMhAWBKnyEzFNzAjHAJIoFl4rjf9Fa2X1cY/ld6amfSCJS7JM83+v1RejrR3kiCZno2TM7LMNmwtfJjFGUM0fL461SFMBXUH6IALX3kpAalXzYOgKxTwSDB4frfvX5Xf5ULJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(36860700001)(7696005)(2906002)(110136005)(81166007)(5660300002)(54906003)(6666004)(82310400005)(16526019)(356005)(40460700003)(336012)(426003)(8676002)(26005)(8936002)(316002)(4326008)(70206006)(1076003)(70586007)(44832011)(186003)(86362001)(508600001)(2616005)(7416002)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:43:33.5975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6279a4b3-9bc2-4aa8-d9d6-08da3e3308c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although new details added into this header is currently used by
kernel only, tools copy needs to be in sync with kernel file.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/arch/x86/include/asm/amd-ibs.h | 76 ++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
index 765e9e752d03..c6f5f5f316ad 100644
--- a/tools/arch/x86/include/asm/amd-ibs.h
+++ b/tools/arch/x86/include/asm/amd-ibs.h
@@ -6,6 +6,82 @@
 
 #include "msr-index.h"
 
+/* IBS_OP_DATA2 Bits */
+#define IBS_DATA_SRC_HI_SHIFT			6
+#define IBS_DATA_SRC_HI_MASK			(0x3ULL << IBS_DATA_SRC_HI_SHIFT)
+#define IBS_CACHE_HIT_ST_SHIFT			5
+#define IBS_CACHE_HIT_ST_MASK			(0x1ULL << IBS_CACHE_HIT_ST_SHIFT)
+#define IBS_RMT_NODE_SHIFT			4
+#define IBS_RMT_NODE_MASK			(0x1ULL << IBS_RMT_NODE_SHIFT)
+#define IBS_DATA_SRC_LO_SHIFT			0
+#define IBS_DATA_SRC_LO_MASK			(0x7ULL << IBS_DATA_SRC_LO_SHIFT)
+
+/* IBS_OP_DATA2 DataSrc */
+#define IBS_DATA_SRC_LOC_CACHE			 2
+#define IBS_DATA_SRC_DRAM			 3
+#define IBS_DATA_SRC_REM_CACHE			 4
+#define IBS_DATA_SRC_IO				 7
+
+/* IBS_OP_DATA2 with DataSrc Extension */
+#define IBS_DATA_SRC_EXT_LOC_CACHE		 1
+#define IBS_DATA_SRC_EXT_NEAR_CCX_CACHE		 2
+#define IBS_DATA_SRC_EXT_DRAM			 3
+#define IBS_DATA_SRC_EXT_FAR_CCX_CACHE		 5
+#define IBS_DATA_SRC_EXT_PMEM			 6
+#define IBS_DATA_SRC_EXT_IO			 7
+#define IBS_DATA_SRC_EXT_EXT_MEM		 8
+#define IBS_DATA_SRC_EXT_PEER_AGENT_MEM		12
+
+/* IBS_OP_DATA3 Bits */
+#define IBS_TLB_REFILL_LAT_SHIFT		48
+#define IBS_TLB_REFILL_LAT_MASK			(0xFFFFULL << IBS_TLB_REFILL_LAT_SHIFT)
+#define IBS_DC_MISS_LAT_SHIFT			32
+#define IBS_DC_MISS_LAT_MASK			(0xFFFFULL << IBS_DC_MISS_LAT_SHIFT)
+#define IBS_OP_DC_MISS_OPEN_MEM_REQS_SHIFT	26
+#define IBS_OP_DC_MISS_OPEN_MEM_REQS_MASK	(0x3FULL << IBS_OP_DC_MISS_OPEN_MEM_REQS_SHIFT)
+#define IBS_OP_MEM_WIDTH_SHIFT			22
+#define IBS_OP_MEM_WIDTH_MASK			(0xFULL << IBS_OP_MEM_WIDTH_SHIFT)
+#define IBS_SW_PF_SHIFT				21
+#define IBS_SW_PF_MASK				(0x1ULL << IBS_SW_PF_SHIFT)
+#define IBS_L2_MISS_SHIFT			20
+#define IBS_L2_MISS_MASK			(0x1ULL << IBS_L2_MISS_SHIFT)
+#define IBS_DC_L2_TLB_HIT_1G_SHIFT		19
+#define IBS_DC_L2_TLB_HIT_1G_MASK		(0x1ULL << IBS_DC_L2_TLB_HIT_1G_SHIFT)
+#define IBS_DC_PHY_ADDR_VALID_SHIFT		18
+#define IBS_DC_PHY_ADDR_VALID_MASK		(0x1ULL << IBS_DC_PHY_ADDR_VALID_SHIFT)
+#define IBS_DC_LIN_ADDR_VALID_SHIFT		17
+#define IBS_DC_LIN_ADDR_VALID_MASK		(0x1ULL << IBS_DC_LIN_ADDR_VALID_SHIFT)
+#define IBS_DC_MISS_NO_MAB_ALLOC_SHIFT		16
+#define IBS_DC_MISS_NO_MAB_ALLOC_MASK		(0x1ULL << IBS_DC_MISS_NO_MAB_ALLOC_SHIFT)
+#define IBS_DC_LOCKED_OP_SHIFT			15
+#define IBS_DC_LOCKED_OP_MASK			(0x1ULL << IBS_DC_LOCKED_OP_SHIFT)
+#define IBS_DC_UC_MEM_ACC_SHIFT			14
+#define IBS_DC_UC_MEM_ACC_MASK			(0x1ULL << IBS_DC_UC_MEM_ACC_SHIFT)
+#define IBS_DC_WC_MEM_ACC_SHIFT			13
+#define IBS_DC_WC_MEM_ACC_MASK			(0x1ULL << IBS_DC_WC_MEM_ACC_SHIFT)
+#define IBS_DC_MIS_ACC_SHIFT			8
+#define IBS_DC_MIS_ACC_MASK			(0x1ULL << IBS_DC_MIS_ACC_SHIFT)
+#define IBS_DC_MISS_SHIFT			7
+#define IBS_DC_MISS_MASK			(0x1ULL << IBS_DC_MISS_SHIFT)
+#define IBS_DC_L2_TLB_HIT_2M_SHIFT		6
+#define IBS_DC_L2_TLB_HIT_2M_MASK		(0x1ULL << IBS_DC_L2_TLB_HIT_2M_SHIFT)
+/*
+ * Definition of 5-4 bits is different between Zen3 and Zen4 (Zen2 definition
+ * is same as Zen4) but the end result is same. So using Zen4 definition here.
+ */
+#define IBS_DC_L1_TLB_HIT_1G_SHIFT		5
+#define IBS_DC_L1_TLB_HIT_1G_MASK		(0x1ULL << IBS_DC_L1_TLB_HIT_1G_SHIFT)
+#define IBS_DC_L1_TLB_HIT_2M_SHIFT		4
+#define IBS_DC_L1_TLB_HIT_2M_MASK		(0x1ULL << IBS_DC_L1_TLB_HIT_2M_SHIFT)
+#define IBS_DC_L2_TLB_MISS_SHIFT		3
+#define IBS_DC_L2_TLB_MISS_MASK			(0x1ULL << IBS_DC_L2_TLB_MISS_SHIFT)
+#define IBS_DC_L1_TLB_MISS_SHIFT		2
+#define IBS_DC_L1_TLB_MISS_MASK			(0x1ULL << IBS_DC_L1_TLB_MISS_SHIFT)
+#define IBS_ST_OP_SHIFT				1
+#define IBS_ST_OP_MASK				(0x1ULL << IBS_ST_OP_SHIFT)
+#define IBS_LD_OP_SHIFT				0
+#define IBS_LD_OP_MASK				(0x1ULL << IBS_LD_OP_SHIFT)
+
 /*
  * IBS Hardware MSRs
  */
-- 
2.31.1

