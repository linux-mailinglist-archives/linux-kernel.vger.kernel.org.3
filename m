Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742E8539BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349426AbiFADbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349448AbiFADbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:31:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57639CF62;
        Tue, 31 May 2022 20:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jhcm/nHNE6pyyOKCkGXYGplDxVafDixSPWGd9sKm348IWxL7FO2vnU0UUxS1YBLpXNYeWapP/2CDseQa7jrExvGPwxi0bNZUBEZmAheyAtKlHgpomng8H+ftjnsJA0cZlpdHBONDmBGPMU7NxQAL+y3r/ykyBQA696mXrOVbmdp0QD33WsHmFH9HTFbeuzdgUtFSTuFYKJWnxYjVbGoWNmRcy4tig8oHenyJudOUCVB55emVJT/FhhzC48viYqquDaVBX3f3bhKsO7H6Ag28WEVxro2rXmd14uVgmXtopVvovAfgGjyV1hQnTGMBlNh2VENZliTgzWQtZY0rW0uHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENgn8+omoEhMK3iILyBQxGAX+iDfdi2Upi/IMDFWqgw=;
 b=m+uO9INE5Xlsh0M2sl9a8jRGRFBqKGCGgJma0yim9lXN+M3oqt9EifVa0pYVRGv/YA9S3JmtGErqpw6nKZsDn2B5wIC9CbSOYCcQp7+KMn5Z5F0+vCOL1M3faAspuIZ94zXF0Z6UKqOS84JZjYgfTXvH9H5QAQXqlBZwHjFesAz5mtnWOqj7qR2aMZSN21ce6QM+o8TjnObr+rpijOC9ryD7loalH4TpPXyfnBkVDbWA0+uUMWorW5NXVALvveY8nFMAgn9UMmGZ4TrO03ttbwvZUt9s80bkLMS4h1XCqGJgau+24tO5d6XfLvAiNsHOb7MUaqC8r5+Ynf8+8L4vnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENgn8+omoEhMK3iILyBQxGAX+iDfdi2Upi/IMDFWqgw=;
 b=uhw/RHmltdQH84jKBw55jVdKfvtZGg0A8dl9/PQKtJTuMGIhXUBL2OQDhDD2wk05wdhk7mLnxF9UIJH8r3aSXiiVikBDtkaKx9cE/t5Fn0C1Bw1oNTwqHs/q8Ko9q2LGiM+Q+dZC1oIwzrVODHwTlaxuTEsHSOUnqhW/WehCSJs=
Received: from MW4PR03CA0360.namprd03.prod.outlook.com (2603:10b6:303:dc::35)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 03:31:06 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::9e) by MW4PR03CA0360.outlook.office365.com
 (2603:10b6:303:dc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 03:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 03:31:06 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 22:30:20 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <kan.liang@linux.intel.com>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v5 7/8] perf tool ibs: Sync amd ibs header file
Date:   Wed, 1 Jun 2022 08:56:07 +0530
Message-ID: <20220601032608.1034-8-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601032608.1034-1-ravi.bangoria@amd.com>
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0194db5-179d-4666-8a4e-08da437f297f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4548:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4548BEC35956B6D90A7DC470E0DF9@DM6PR12MB4548.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgifHaTsyrVitUoVRcwAeH3rNm+IrHg0PjuMLMsaqi7giHWnWwaFWPE3OgG2hgpKKEChwDX06LkVDR4/fmCYzdyodbpuwbLLcF7gGKG8jdWK7MzqV89IBFcWLYxXjDnDu+1zgVQm5FiMpPibETlvu7T7vE+oa8fDlMq0tEzLkO+qcnT17ZwiVkc/5t6OEj/EzTkBAda/kclCdg3zIfXAmVLKVxv5GQhPN6ryRk4Xq4vCc96JmKPnzyiHini2Ph4XKq5auRQnqjebMaWiGJctuGFuTk6r7yA5PZbgbBwbhGIUdYKYQJEeSHbYk6KifgUkyx0BAbHVe8vDhX9vO6YrvqoFrL9dIYROKbSysSHqoBvBTnkNAw70q4i6IGcsChXoJ/AmdBA3ocYaT+a3FmFIn/xYmJwaTVMM5adDUVyFU3+H5V/wBLKN1W4pLDviHuwHBL+mIecuMo0Q+SSJR5OVvNhpvfTsWEvttaCY9NZvbOwQQT80bC+VxkC02I0wZSMk2DlhSGvegsBKhVZ5di5S4dSoI8AQrdEQPdh5XQdYOkq5b3M/TlZDphmm1oBQk8ViQtyoMwMBIi/RbAZBMViIHrIMeOqLgcQKIRYib0dPT6g8th8yESnPMSfsgPP1ZOWwYIvdn5UxD5rPHlSFhmsKj/ilhgCjc8/tflJnVc/6Mo9PwHLZgoFn57snVRHozqooG1YpnFaRYn94vneJj13afA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(54906003)(82310400005)(6666004)(5660300002)(7416002)(508600001)(44832011)(47076005)(8936002)(1076003)(2616005)(86362001)(83380400001)(336012)(40460700003)(426003)(36860700001)(7696005)(26005)(16526019)(186003)(356005)(36756003)(316002)(70586007)(81166007)(4326008)(70206006)(8676002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 03:31:06.0759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0194db5-179d-4666-8a4e-08da437f297f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548
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

