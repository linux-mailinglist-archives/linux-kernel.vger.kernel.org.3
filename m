Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEA4539BA9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349427AbiFADae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349465AbiFADaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:30:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEC772E3A;
        Tue, 31 May 2022 20:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhwkVgOlhrGFPh4jycXofzMQSsSIKjUGEIF/Spocbc3XZJx/JJL2AihrOurpKAY4bHUAp6NYC9+NZGR8ig5S3HHyL4oeH9caela108MsPqYglytIpWr12QrtGiaqpyzD9IIus8Mqqt+j0h31tY7ZuIgcGVd4Q2MGJvI6sYkStuq9IbgMgm0XuzvTea1wgthGl0vUXNJfnfIPUPF9lOJtVeAaMzfX5eyqTj7XTMBIF+QAfI36BI0v6Fkl6zdClOCNt1FPzaFOv2FNF+JS+TIYJBfkrtcKS8zTWVillbcm5XZa2Sx0IFQ1/m5y9KMFYLEPCXE7p0p5nJcik9r/NQehrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58OUnmftGccIflpVRC3kry/dTTF/1fMLkNTsUzjZkiY=;
 b=I0cg9U/Tyj6myHuvSJtKWgrvQXR9eKk/W6tqDpuOAgzOeJCFdXi1XYeewohXZecihTkt+1yCUafYKBSL1Uq3PEj/1mSiy1t3FOmwFQ7gvheP6DDs0sB9JulZodMSFQ8EmBdOzoAUUaw9saV32DcSGC7fzzkuitnWqpqEjfgO7OExwRdsd1XkB2z2vnLhM/wSZZNuupYlr90Gl9bq+KFUwkrUjNtGZ5R/+RofFoYS1ZA0OY4hBoG1O6SSLRpkxCjPhFi3I1Rrw3n2HP6a3Kq2mpjsqe0uamx8KsRp+Bk135S+nhHwRrX3QBvUTY5EVcd1hGkviPACswRbESEVjZdw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58OUnmftGccIflpVRC3kry/dTTF/1fMLkNTsUzjZkiY=;
 b=sPcdTg9885QkGpvLuf12NOiTPwjUdLh5vzYLNwjlLVa1OqoNYnzNFq44dIhVbcxChHE8G9hX4y24IZgoDWAYDvAShDhNXwmNdZLM38Vf+b91ioQcflII/unNeRrMcQBkSuJfDBsd6gJTdr+aldRDrvNV50fqz+olin0ClchDFDY=
Received: from BN6PR11CA0067.namprd11.prod.outlook.com (2603:10b6:404:f7::29)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 03:30:20 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::89) by BN6PR11CA0067.outlook.office365.com
 (2603:10b6:404:f7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 1 Jun 2022 03:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 03:30:20 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 22:29:32 -0500
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
Subject: [PATCH v5 6/8] perf/x86/ibs: Add new IBS register bits into header
Date:   Wed, 1 Jun 2022 08:56:06 +0530
Message-ID: <20220601032608.1034-7-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6bfb2dd0-2baf-47d6-7242-08da437f0e63
X-MS-TrafficTypeDiagnostic: DM6PR12MB4121:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB412126160C69C1326DC3CCEAE0DF9@DM6PR12MB4121.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZY5w1KQBH0wnLxDyDkjCMTCe9skLl4O0qAF3zgxRwDzJ68uMcjyoT3Boit3X5to7+9RbXfed7fjWPp7TivMpiPuItY+yCka84hRSl8x9Zs8z+fq0gmDsnL8XSeCR0ZJ96jWks4JmpfOobmn27qe+/rDE8N/8CyLKWSKkh8Q4u3QSkkPos7zbm3RJ9HRbNWv5WgTW3ihVI38us+M5+fXT3PIBfCNnj7IxNC2PLK7Lk9rNq3TVOU7gUL1BsG1GOycfbbihxFvhfNA4J3wThS4ajfIqnQz2UHIRd4eZslOSwYB1DH65O3iTuzQx8aYhTcsXfQO0K3C25sYN5gTbdyYyS4aY51JK9nxR/Fe8FobZ/+G97i9aePa90zw6Cl+yOL4WDisBbARo8tl4wmM31NfCmzqmBibv5/lnSrlDEePBl3TIIxnR8QSMGTZlh/j1WOmoZBijnAMLHwtf5NcxVfHNqaH2uLKBnlH7VaDRrTGxXE/fvALHStpepSiQfFlpQwA1CJH88uVbiEVID3Oj51I8STyaQFD1dgn71Zpy8nKS5/q24/Jo8OaTQRYP8qRQj+OU0BPVStpjpfRWFu9TW/BxLb2TpENXU4ee+Xr/qdjYIDb4FocSBOxxw7+6fOx8UkMtdxTv1jJaPeRK/dD1b4q/StgPHZjNpXXEU8TZWNOlfyObXFgm97AxqaVPXWGCPxcv3DvPTZ7xf0GUTbyf28O/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(6666004)(86362001)(16526019)(40460700003)(336012)(81166007)(70206006)(7416002)(7696005)(5660300002)(1076003)(70586007)(4326008)(8936002)(36756003)(426003)(83380400001)(316002)(44832011)(2616005)(54906003)(8676002)(2906002)(110136005)(26005)(82310400005)(508600001)(47076005)(36860700001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 03:30:20.7027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfb2dd0-2baf-47d6-7242-08da437f0e63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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
has been introduced in IBS registers to exploit these features. Define
these new bits into arch/x86/ header.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 arch/x86/include/asm/amd-ibs.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index aabdbb5ab920..f3eb098d63d4 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
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
 
-- 
2.31.1

