Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC2853D595
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbiFDEr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241988AbiFDErw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:47:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED04911815;
        Fri,  3 Jun 2022 21:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvnigBbPM10/92bV9+TiS4BDbfRFaEptmaPDcpISoPPo4d9QybkQx5pXN0+QVpPaEi2Qi5chdQUELNeWT5kzgR/5gV1BK/6IRNnUy5DBHOk+NHVA/JP+Cfzjh+WxOdVGNO7Wc8VSZnRa9Lv2bRuWWqZTI5cGw8IyCmarYnUF10jMGWDm6nG6BfN3236S7ASLoYHQT0YWMZ1VOQhHkq9gdl/nD9YfcmXA1r/v/HMPrS7QJ43xy218iJB12owf0KphRfK/MCQkQpEUBfA6/iuMOojsdaPS7fW9fQnpfupvKrUodMglNWs/HFnGbqoMGeZyh3Xg6H6NFZFcLE5z+Emh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENgn8+omoEhMK3iILyBQxGAX+iDfdi2Upi/IMDFWqgw=;
 b=iJ7Bwlu87Otng8WWNJAmt6wBn1znMjfpTQ+k/0JwGLXGQxklpt2Vt1xdQfZynZelV0Q0cEXPeURmIMUWdKsn7cc3GZzWL3alPCtv+0lllZ4CrF8DTXmJYVDXWUfwOObLYz5GqvlHKVkzKZFSDSntGvUqWEwE43kvg9BagaPXB5V+PAHQgy/9j7INMvLvwsPuQ7SefYeLCcxCZO9+yPIameH+YY22aBcJ696IQfcrgUk+rU9jmZNarllG733j2oR6Ls9ptwc3nmY8yL2YJC//4wdq2vuG++qj5hH9IPa3WnQf2NYaHbehDhculNuS9OvpA1yDnm95+imwdV4e6zCxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENgn8+omoEhMK3iILyBQxGAX+iDfdi2Upi/IMDFWqgw=;
 b=MXQn9h3iVkC6bDtyo0o6KXtKgNblgWTUP9D3TsX2pNIMfp/d6f1xifajGHr2i3AZRckziUR9pUtBBjF2HD+L8JTYd0IAL7nORGJVeN0J4cqy+ZbogkgF2/XWq1Aaz1S7PGZqVWxkcF3R6KIRCpF1UlA+8DIcJyemYu0O1rnz4GI=
Received: from BN9PR03CA0314.namprd03.prod.outlook.com (2603:10b6:408:112::19)
 by BL0PR12MB2337.namprd12.prod.outlook.com (2603:10b6:207:45::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Sat, 4 Jun
 2022 04:47:45 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::fd) by BN9PR03CA0314.outlook.office365.com
 (2603:10b6:408:112::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Sat, 4 Jun 2022 04:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Sat, 4 Jun 2022 04:47:45 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 23:47:34 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <kan.liang@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <james.clark@arm.com>, <leo.yan@linaro.org>, <ak@linux.intel.com>,
        <eranian@google.com>, <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v6 7/8] perf tool ibs: Sync amd ibs header file
Date:   Sat, 4 Jun 2022 10:15:18 +0530
Message-ID: <20220604044519.594-8-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604044519.594-1-ravi.bangoria@amd.com>
References: <20220604044519.594-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6492742-2587-4b4e-b69f-08da45e55e2b
X-MS-TrafficTypeDiagnostic: BL0PR12MB2337:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2337D356FDFBFA939F30ED45E0A09@BL0PR12MB2337.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ghQdve+BGOC9IVKnUOuDP51G0alqrnXZg2+/j5n90+sZ2xDpEYQCv/JWDFGiscOtsoAjpFFC6v+hSMaePaz1bcp7dyVFA+Ld8y6RQZhf+wYPwpOE6keE0uiC43JD5TIiuv95VH4VEcPd12Jz3NuFphjwmt6mJK7uTROLnVfEyKDGb9gHecK0dKQsnHKQBTUwNXSe3eEjRGooFlI1Az7Bpe/3XT+1JxhjZeizlO1bOVSwb2ZE9KYNdPuAiCGlchJ+G0NRsIkKpU+sDiP3a1EfJqpWCYYmcQS/F0Qcox1ZZK6LFOn8FbWsWNVAAHfM+pJ8dUE+qpOWBgo8XNiz0lCKyz1UDEXuLfxD5AQMslFaObLFnOEpgubsAbL7/7VtKOiUXH6w//546NAd8EDld+ixSbHU0ylTVWd3rhdPy/EQbMsm/FV1rpPMptIfUoztmVu91a/8s+v1ltLyJo0JhaIJIshOybIrcPkd/wzrv6OKzYQmBCVd4eyDlIvVtzhE59CBmXstETAlugeX9c4F1a7ArJ5Uj4s8uy8uGRjufrsTT7e8EGnjedfENqyugGul6ITyr64O8cOVU6CkVvF3SGLl+hagS8flzhU2gjSBWOl1l//2ZMrCUutvAi5HJ2OmMiNZnd416qLHqylIN+CDW+1Qgg8RosQ3SDDsKeLThu3kvhbODVMgBXWUorOTQLPQ+BUqfC8VMd7vNyEQCtwZh6jInA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(70586007)(1076003)(40460700003)(186003)(83380400001)(26005)(47076005)(16526019)(336012)(426003)(82310400005)(86362001)(36756003)(6666004)(36860700001)(508600001)(6916009)(5660300002)(54906003)(81166007)(316002)(2616005)(7696005)(356005)(4326008)(8936002)(7416002)(8676002)(2906002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2022 04:47:45.5471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6492742-2587-4b4e-b69f-08da45e55e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2337
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

