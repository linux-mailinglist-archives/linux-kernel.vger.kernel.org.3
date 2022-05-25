Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6707D533A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiEYJmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239250AbiEYJma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:42:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050B963E4;
        Wed, 25 May 2022 02:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJG5DgfH0qHcvFhAYkRr77eaWGmHlPg9CIX5A7ixdks4+097GQo8YgEdMjk5mqFfoNqqZh2SpOhXDIlwBAllPdHNbLRxAiuplKQn3+kTUU2EE9sWGdFBmCMiFBqGvPhxJBS5/RB4KXKVnfxjF46njn/i785zm1Cx0Sh6R4b5Ig/iIfamvmobhH0qrGyiM40olb3HK5pSbaYUShGSF9+tMt3sOQO8VC8lccvpm3uR8lFNdHm4Goy0kax6p57DHTYCAz+Gag8BKEt/EWYvqeaOxmAadk1QL/ThStd9RP0BXM6tUDdQ9ECgOkAd5CegZflvueHOE59jw0IAOJDN+tXnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aRJZifvG96NThxdAQFXCrkd1/IJ4Kr/DO3T+yZ0EcI=;
 b=RzOfDTHE+W0yUICJRDqetd8jslHxqlVgIB70SoDakA8l4KbuWX2O8p9n7ckAPUzgK4yAglxhLpRkVSHvN6rhTOChztDENmb78dSkN4gvIgo7oLQdvBEbaUzJSN+M2dKH0eAdnGLSzNiYdOZJwNq32GqhnHfTB67220ABNEQFg6onHiAdnAfvAy+sYhZWiU7jDL/RK8IKNh8YmqUsqWQF40aiGB327088e7/8tRTTqgOzWwY9AvzcRsU0WG/O1qP+CtAf4jckW7xPug9kOx5lsac/DmsCmCePEx9f8gEaSqALqH6zdlhvMXsn+G8DkkFbpZxTTj2nv5RcedMi1OxQ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aRJZifvG96NThxdAQFXCrkd1/IJ4Kr/DO3T+yZ0EcI=;
 b=E3Di5ZxaN19Q8iF3K4vho+V41mM+MxSnH8p67n1tOuSE2HzlF+Jd4n7cQRpm5sveUE3nvXLzvL1buokLlU4Wvq2FsDdwOXmSjpCqs8OuPQ48tvE+pJbLytDlyeEYpGj6/dtQFVi9L26uSAWq5XVa6d9Jzm52oaV+G0j37Od09so=
Received: from MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::19)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 25 May
 2022 09:42:20 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::19) by MW4P223CA0014.outlook.office365.com
 (2603:10b6:303:80::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 09:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:42:20 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:42:05 -0500
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
Subject: [PATCH 02/13] perf/x86/amd: Add IBS OP_DATA2/3 register bit definitions
Date:   Wed, 25 May 2022 15:09:27 +0530
Message-ID: <20220525093938.4101-3-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ad10555-e877-4a5c-192f-08da3e32dd00
X-MS-TrafficTypeDiagnostic: BL1PR12MB5779:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB577993D4D30365BD2C4A9821E0D69@BL1PR12MB5779.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuYPDcackQmgw84AHXY0frVa6BNr5ZZc5nLSKZoWujad2XJN8E9iCapZKrAMAuk4Sje0rClDkO4ahVbE25th9J71IMk8HZGpgNUq9Swno5GUd/AT5nRQ0T+GvvMDH+QzU6VPKbY4rh2EVURnYxf9Y4DVacLml3BPckneIUXW67gf0TF8zVu/DVa31ys9hdIRpQiSfWBJs3Mg7qirqh86M20HOocm0yd5s9SNAeoDeSDhTnvnAq6CYROePaYEZEsIug+PrjG+CDZyJXNwRPZ+UbaRLV+b01ztVUTJlQIlgMylTc4A0K7oojkxGdpEGTrNJ4+9N1AuF+sgVMj6k2YY/1g7UgX6d4ylJJaogyttUh0N9eSKzOw/ofZM/hG2zadX5Q+AV5oGhFVCIlZ6qu2vs26QriiGgHelaAU3fTcoWWBc1gdl1XvfF293J9kStccr+Q6yyEs/S5VocbPRZR55sZTn51GKqeCYpNxZD63s1uXPpKU1IgZuDv8X+KzIl5JCJPDp1HVqfZIp6vw9JvuUQ26ke8HH//go2Etyx/7rg6FjcAJ7eZPfrpMuYrEqtv+B0tqWd2Ah62OYaS+kD2PlZYmKAUHw8716tPwMkQrBqgqzexzm+vIoOjRv3bzCuIH+MV1ZsGr7yU/tKHxVloPYjqtsUM4GSYKXp15xskgrORM54vnXncAkbqG1ZyQR6M1SRjx0CISwdA2cy+lP856zzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(316002)(40460700003)(2616005)(44832011)(7696005)(36756003)(426003)(70206006)(8936002)(356005)(8676002)(47076005)(26005)(336012)(82310400005)(83380400001)(5660300002)(7416002)(1076003)(186003)(6666004)(81166007)(86362001)(36860700001)(4326008)(508600001)(16526019)(54906003)(110136005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:42:20.1529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad10555-e877-4a5c-192f-08da3e32dd00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD IBS OP_DATA2 and OP_DATA3 provides detail about tagged load/store
ops. Add definitions for these registers into header file. In addition
to those, IBS_OP_DATA2 DataSrc provides detail about location of the
data being accessed from by load ops. Define macros for legacy and
extended DataSrc values.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/include/asm/amd-ibs.h | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index aabdbb5ab920..22184fe20cf0 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -6,6 +6,82 @@
 
 #include <asm/msr-index.h>
 
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

