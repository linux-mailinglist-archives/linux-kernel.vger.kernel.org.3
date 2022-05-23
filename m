Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38348530825
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355712AbiEWDl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355604AbiEWDlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:41:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A282FD3;
        Sun, 22 May 2022 20:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ok8FgDc/IwU7352l1K0ioUSNaAz1tcHBcQa68lLKNLu7OFzrTBPO0stM/knHICVBCjXzoRaqj9WkvF6qfIHVzgqr0mNumpPrZMMCwv9EX4o8xhxKTWrlmhSqh/TxfonELy0X4+RyqUtpGO6mtFiqOkLWWiY0yx58VXn2NfH9sXQlThniJvEX8KrEWYMYUPjQrVsHi23TmKD0Lgl2buADSh0Tk2fDAva4d+H9r61iEYrNAmsgBHh01zCwxkAi/ZS4XkyJ6mVy0BVY072s+2NYNemlRdvWRSXOU1sKIYZoVCC/3M+4s2GzSGFr99iskt1q4kDZMzoPA9fEPL8V1E14vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENgn8+omoEhMK3iILyBQxGAX+iDfdi2Upi/IMDFWqgw=;
 b=bNeEurw7r24cvCbDliO7gNL+W7Onxam2ZSVohECAUGFRcFuVFY1364oAx7PDTQc1F1zxajlSZDdE1oxj3VmHd4IpRJWk1RZh4zToMQ6jHjBptcLStINvJkuD1C1eitMjvBEwjDZCc2TlcwKXeSvlwYICvaiqOaprnZHQEgQZEypS0Q1nLQrfirQ7Kzrs2mEhLvQozdLWaH3iUfEeYmVU8UgkFQpXNjgiNoRA0CQqwZAv67geuXBeteqxqTBxQUzSR7dfcVkwnAI5B5OLoFN/F4jwj/tXQE3CnX7B9VfLaoxZtYN5t+iJKBKUwbDY4WncVBr3NXq4CkmuZHrjZrYv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENgn8+omoEhMK3iILyBQxGAX+iDfdi2Upi/IMDFWqgw=;
 b=SHtfg7+YvPV7Zo1/2HN6UWKFZ3VQSDSL2Iq74L4fOe7xtSFmPP/Bd2ykwqRQ5Fc9FGsUzsaTNNH3IPcQI6WjVYAKu/cW1rg81rL6ZxF81Hu1EhTtZQASl6tXfTs2xpwinR++V/SOKyEoTnzVUKk2knkDG8O9ZQeu5dvtvl+98qw=
Received: from DM5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:3:23::25) by
 DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.13; Mon, 23 May 2022 03:40:55 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::10) by DM5PR13CA0015.outlook.office365.com
 (2603:10b6:3:23::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.11 via Frontend
 Transport; Mon, 23 May 2022 03:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 03:40:54 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 22 May
 2022 22:40:43 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v4 4/5] perf tool ibs: Sync amd ibs header file
Date:   Mon, 23 May 2022 09:09:44 +0530
Message-ID: <20220523033945.1612-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523033945.1612-1-ravi.bangoria@amd.com>
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde91316-28b1-4959-d235-08da3c6e0abb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4060:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40603AA9FEA32B7E5B0FF422E0D49@DM6PR12MB4060.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5QF8Lr8zbTxb0xRLr4ZM1GtHLudKT9DbZwo0X1pd7G3f1GsZMGQGEnPQcr+KVEFVM9rV7RoPGno0AOiZl/LJ366F+/0BeGncuoQzIZFMeUnCR+NEhxyuAXYjJHSKpxPmb8PGpXLkC+aNzSES9fbJEtE/e3Db8W23V2dZkZMHA4A5qa6ejGNTkENXYTYcksKrduh1fKbkwNvLHpnI/0cNKSJoT+R/2R4YX8aqgeFzhX9hqHBCe+17CHPKVs3MjmBud603QyPBOLwH0uUbfK0LNAB+tVZjKrTMgY2cVdHSMo+QrEeK2T4rWIJVB7vHwhcWSk6FVOIixoJQ2GqX86aHkxju5t5iYSjHWTRGvURqR7V8knyBLEcu8gdeEBGuKffeTdsXQL1us2l/3xvXdseAMUJOWoEFdsoJ+nY/tho/C5xPjZsVTu8+3Jy/vk/YrZk8dZNnrg+1kGnq31bVwtfUQZ9IkJc9kf8xpmeUHiRWI+c9ENfW5y5It/SIZ05G6oIkk9Ffvyulb2NilstHRxnH91PIKryjQSobJv/tR0yybI6xkRrbPb+22nkpS3vzGsiNkkfW3RtiVcZgNVzf+JpyQI1OAZl+Yl7IidgOK9EfY68n0qhGh6z7TFoef8SnLUTqLnY8q4ZkYeOMAshG/tZp5slVxU7T/PqloPrPVuB1HN858CrbYCXaeuHLlcAUOWoheFgnRsuN5mglglGlY31og==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(2616005)(16526019)(1076003)(26005)(316002)(336012)(54906003)(83380400001)(6916009)(186003)(426003)(47076005)(36756003)(70586007)(70206006)(36860700001)(8676002)(4326008)(2906002)(8936002)(508600001)(5660300002)(7416002)(44832011)(81166007)(40460700003)(82310400005)(356005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 03:40:54.9403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bde91316-28b1-4959-d235-08da3c6e0abb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
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
header file. Also rename existing ibs_op_data field 'data_src' to
'data_src_lo'.

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
2.31.1

