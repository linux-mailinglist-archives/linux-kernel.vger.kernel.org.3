Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCEA52CB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiESFp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiESFpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:45:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF67BA57B;
        Wed, 18 May 2022 22:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+s+gWPaYicmz+rb/7Nj1WcKTSip24kl8VwfazGuLY35JoU8JW029HCHxFjg1t/80JVDF/3BDT/GYYCg7YnwqNpGbvljMKExY2+s30929hA5/zN0BAg2UL+QaijPajpXX2pzY1lH25L1Z81z0otnqs7LZpfefYS4dxUvdMTHZJCMMslet9xvS8Biux66O3Alx+yxH50F77XWYlEISMR/WFTGMkJKrD7pi+9OVRxw0bMAQE/CSjVlBTFVSSacdKOm9Z+j5doCEQApVuzt98qz/LZeiQp3tYMcTWxfMy6BpT8bTAZdL2fDLslFQfGUD8BtdoOEIOdwuXflMJ3kaQIBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3WXt9TZvoLzQeSpcL72uWsMqpgi+HfLUScZakhTIXE=;
 b=m6uUa+K/l7Q+hWvRof87P/Owp2EqkKNjEtyk41fjF3MuJfsvSQ9r/3GxWTFZErE8xwu3xk4B47CaKW2f1VLGEJaqS8JWcIupRPGZoPcSL7g4NqHk+P6rLaCiK1XYEJvn4RTCTOJVND78mVItA+k+tyASiNTlEWNPqjrDw9aIK9HGH25OJHdtns+7LMMc/vmT0r8XdwNHsssut0VwUkofOd71sztPuA4WHwSiTi5iGhT1ISWlKHr+FInL+1MUrXGliHtVaqUDM87GVl1s1oipNhLTTWdvNTphyz2iJDoai2tPk4beny1SGgSFBSqflKDQEijlJWmckVI+2kuPQn1a3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3WXt9TZvoLzQeSpcL72uWsMqpgi+HfLUScZakhTIXE=;
 b=QHROD732JuiJdGBmwWrthB8PX6ntL2iN6YCyoDCon6xgNtKUnCTTGKvzrfgThYz/rgOFH2xF/T3B9gboKQ3YpBps7UvCVzXN7k9TAb9G+JLER3jNW2ELaT62iL6emqo6Gdguf1fmItfxZczElxPcjeSTFQ+Sy8euyYYHa/H/S0w=
Received: from MW4PR04CA0228.namprd04.prod.outlook.com (2603:10b6:303:87::23)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Thu, 19 May 2022 05:45:17 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::db) by MW4PR04CA0228.outlook.office365.com
 (2603:10b6:303:87::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16 via Frontend
 Transport; Thu, 19 May 2022 05:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 05:45:16 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 00:45:06 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <peterz@infradead.org>,
        <rrichter@amd.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <irogers@google.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v3 4/5] perf tool ibs: Sync amd ibs header file
Date:   Thu, 19 May 2022 11:13:54 +0530
Message-ID: <20220519054355.477-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519054355.477-1-ravi.bangoria@amd.com>
References: <20220519054355.477-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 498d621b-2dd7-47a3-4b7d-08da395ac0c8
X-MS-TrafficTypeDiagnostic: DS7PR12MB5886:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5886E4D48B1D5447D540DA78E0D09@DS7PR12MB5886.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lcbpXayuf74DQW/F/swLbruGVMR0uk8nI6dHsXjGKFNSjubo+dgkvbGqmat3IPymvnT4zXXgzh3tCqMTgmlnBbyVTq4Sig/35Vq7C3U6YsgYRke/YuznADY1LkGT4OS+Qjq8HUQ0PSB3zrF3ryhHBQR7hRLyTRGnn7mygvfWN4mhr443rl/leimdZrGDoMkvsQ6ns9MowpsLvy8OG+hx25eQCEnoEppA5dnOT0FFnM2pCu7oC3Y1GBbk520IyTFQhlyFth8cJ1HVnY8kx6OlrlPu5QMVbqPRLzkt0m4KTxYrIrq8GfSeX2XZyBa4Rf+uSHP990YKPK9+y+D/w8l+W2s7h1RY5wECJB2gSiHqCSWJwmDbT6jO8UbS3aPGRyBZpC5Rc58Nml4l79fJ8pnwWaB7EjwZl+Cbv21JN3OJaRkS0Vi2BeMKWQcjZzWF/hUtCpUVrNr3u/9BMMFrtwYKqw2xPgQ/ib4YNB42qebMn1U8nVDVF5yhoquY6ZAZ+fD7K9+qsNvA4dIouaFUV6d03/beLvnNCHOA4S96CutfuPH5UF/wGhMXiditw9N1Ag3l0siDTUKFiQaKsK9e80NMn8dKYgoYu9uIY88et0EF/RSMSviiBl2rtNF2dizLZ/D5QA8OHVD1SCrSeYiKKUKdokEq9q5yotforQxZg+zh9AIHu77K4whJH3turzj5CfnfS0yzewhhi4NDnd0mttNBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(70586007)(5660300002)(83380400001)(40460700003)(16526019)(36756003)(1076003)(316002)(336012)(47076005)(54906003)(36860700001)(426003)(356005)(82310400005)(6666004)(2906002)(2616005)(81166007)(4326008)(86362001)(26005)(44832011)(8676002)(70206006)(508600001)(8936002)(7416002)(7696005)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 05:45:16.8663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 498d621b-2dd7-47a3-4b7d-08da395ac0c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS support has been enhanced with two new features in upcoming uarch:
1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
has been introduced in IBS registers to exploit these features.
New bits are already defining in arch/x86/ header. Sync it with tools
header file.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/arch/x86/include/asm/amd-ibs.h | 16 ++++++++++------
 tools/perf/util/amd-sample-raw.c     |  4 ++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
index 765e9e752d03..9a3312e12e2e 100644
--- a/tools/arch/x86/include/asm/amd-ibs.h
+++ b/tools/arch/x86/include/asm/amd-ibs.h
@@ -29,7 +29,10 @@ union ibs_fetch_ctl {
 			rand_en:1,	/* 57: random tagging enable */
 			fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
 					 *      (needs IbsFetchComp) */
-			reserved:5;	/* 59-63: reserved */
+			l3_miss_only:1,	/* 59: Collect L3 miss samples only */
+			fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
+			fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
+			reserved:2;	/* 62-63: reserved */
 	};
 };
 
@@ -38,14 +41,14 @@ union ibs_op_ctl {
 	__u64 val;
 	struct {
 		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
-			reserved0:1,	/* 16: reserved */
+			l3_miss_only:1,	/* 16: Collect L3 miss samples only */
 			op_en:1,	/* 17: op sampling enable */
 			op_val:1,	/* 18: op sample valid */
 			cnt_ctl:1,	/* 19: periodic op counter control */
 			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
-			reserved1:5,	/* 27-31: reserved */
+			reserved0:5,	/* 27-31: reserved */
 			opcurcnt:27,	/* 32-58: periodic op counter current count */
-			reserved2:5;	/* 59-63: reserved */
+			reserved1:5;	/* 59-63: reserved */
 	};
 };
 
@@ -71,11 +74,12 @@ union ibs_op_data {
 union ibs_op_data2 {
 	__u64 val;
 	struct {
-		__u64	data_src:3,	/* 0-2: data source */
+		__u64	data_src_lo:3,	/* 0-2: data source low */
 			reserved0:1,	/* 3: reserved */
 			rmt_node:1,	/* 4: destination node */
 			cache_hit_st:1,	/* 5: cache hit state */
-			reserved1:57;	/* 5-63: reserved */
+			data_src_hi:2,	/* 6-7: data source high */
+			reserved1:56;	/* 8-63: reserved */
 	};
 };
 
diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index d19d765195c5..3b623ea6ee7e 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -98,9 +98,9 @@ static void pr_ibs_op_data2(union ibs_op_data2 reg)
 	};
 
 	printf("ibs_op_data2:\t%016llx %sRmtNode %d%s\n", reg.val,
-	       reg.data_src == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
+	       reg.data_src_lo == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
 						     : "CacheHitSt 0=M-state ") : "",
-	       reg.rmt_node, data_src_str[reg.data_src]);
+	       reg.rmt_node, data_src_str[reg.data_src_lo]);
 }
 
 static void pr_ibs_op_data3(union ibs_op_data3 reg)
-- 
2.27.0

