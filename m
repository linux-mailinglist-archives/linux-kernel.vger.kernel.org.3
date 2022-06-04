Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3589A53D590
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350610AbiFDErn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350601AbiFDErj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:47:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878DE10FF0;
        Fri,  3 Jun 2022 21:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJHIlzJ5KfTy0P+xhAmYM6Ugs80kspQx3TAV/eO+y27RC1G6PnobaVDipS2alfWiy8XiZl675T9DgR3y3Ym9e6/zxbFdwO3KTXX2WLVlYmj1poZ+hl48fTgaV2FfGUqMne7si99FtxghpAWBQPj7iYC48VPH+2XjY9WLiLLPIzwuBVdV5W3T2dTzA8yAHxuUX/GDsObhX+ZODUxZydtlHttV8G9xlhzQaKHMwpkDvUu42jE8+1KiClgdzKft1xr2fdkUBgA6hWFYxK51gGcH8/HjeD7qLdDWpOeHSnXVA7CEE8I0f1iBzn4icbFHtHnNwgeyvDV2hcu9ks5CXZ8pAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58OUnmftGccIflpVRC3kry/dTTF/1fMLkNTsUzjZkiY=;
 b=EM7ADoY8xJdWvqCfNnQ9r6yu+Icw2kKGJVHfubPl8Z6LeQyQVEe5jnQPuJk7BhKhrIp5QI0vNgCCedKFgbZpFR7cwOkX0waZadzUrDzXCHA2IBEIfchTkIVbk0oPH5LJY673kaszFl339zmV3c5mk45RbXJzXXtAWhzFykg3FBQp2O/Om0dPX4U6V4SQrFhl9uUvvDXe7eUwSv0eblwsWk+WflGT51Dsj4SAmSBgpjP08OpfMvgTa5LnF5kB1iUQNoCuFnwe1EkhYXQQvXgCFEoDE8lcnwU+QOCn9JWqKZpXSKTNt95ocQUme25NrdJXJ+CAzWfaW74GeZ+m0U1bRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58OUnmftGccIflpVRC3kry/dTTF/1fMLkNTsUzjZkiY=;
 b=1C0NVDi7eSShAmR/exLlzOS9zwoq9UTeE4Vax3L45fUGq9yfCvebisPsLu3n2UYH3bL0hCu6Txked/3JuNtZxkVHqY8gRRhSQ8qyQrMASAlZaJbYCMA9IoqLzwnpfSI9kYeZIKeb4zigsI4Xdbsfhp/Nq124/RK1PRUVm6KmITw=
Received: from BN0PR04CA0119.namprd04.prod.outlook.com (2603:10b6:408:ec::34)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Sat, 4 Jun
 2022 04:47:36 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::de) by BN0PR04CA0119.outlook.office365.com
 (2603:10b6:408:ec::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Sat, 4 Jun 2022 04:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Sat, 4 Jun 2022 04:47:34 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 23:47:22 -0500
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
Subject: [PATCH v6 6/8] perf/x86/ibs: Add new IBS register bits into header
Date:   Sat, 4 Jun 2022 10:15:17 +0530
Message-ID: <20220604044519.594-7-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3fdbf4ab-6f1d-4fed-bd50-08da45e557a5
X-MS-TrafficTypeDiagnostic: IA1PR12MB6353:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB63536DFCB70E887F1AE0588DE0A09@IA1PR12MB6353.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sa23r3sjFNNtjgcOHhS7f+xkn85mtBkZOUr3CwMWct6VPBLkHvbpf4tfmNVWnGv5KGneMTN3Ev3ZtPrQWKN013yKuuozTNNURIChqJSPwcuoxJmQctTeF2ikt8P8fSa3yHq8U/U0QCzd0hXMaZ/IP0BfEfc2ZgLOXSC/L4k6tKmo+VJXbgVRJme43Kezi0REoAwnLMzfoO6HYE2D/UUvQp4IXa/+cUJyCBB0c1uxAqc+sPN/ORt0+rYIO4LH3SkFOLXOuLVNsbGNyVhHuwNOP5HBx7HVziOrLHsn2rkpXO0+ooxQ4pEEUZLL0eroA+vzroNe4wDkwUFgzB9+Kkclz468k+r3TJFvvwSaKwxJowSnsgxZbwK1dcBFczmVNIlHOUmPnvJc58LgY7VcxDmca6MJwLz7N2FhFDBcZAK0gfiKhpb6gPfO9gpko+rEz4mf6VD8OhpMkBRL6BjpI2lCEQ6MOk8AQK3HNW4d/POuX59dEhWtzXZNRTAlG6fQHapZwWrqtAOGx7HhfnrDf/aG08p8ZJPTdR5bv6ypGHWNyYgGDaFkN08QsAJJjUfzuFXnKmmc+lAbJtgUF7mjOxcT5paY4KbesxH7wvlRnMQa6uVUMjiJ9hw4s3D/qOU29xuxhH9vMazQ81fvjcLcQAOLh6zSPbDwGYNEWaLjFAp3InK2fqr9uwLIXSR1FHl508ypTtUGWmcJa7pHlyYs9C3TJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(26005)(5660300002)(2906002)(2616005)(16526019)(186003)(83380400001)(47076005)(82310400005)(7416002)(426003)(6666004)(336012)(8936002)(36756003)(1076003)(44832011)(4326008)(86362001)(8676002)(356005)(316002)(70206006)(70586007)(6916009)(54906003)(508600001)(81166007)(36860700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2022 04:47:34.6028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdbf4ab-6f1d-4fed-bd50-08da45e557a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
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

