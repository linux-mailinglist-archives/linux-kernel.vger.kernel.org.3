Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6271A54E037
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376933AbiFPLq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359774AbiFPLqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:46:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439715EDC2;
        Thu, 16 Jun 2022 04:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElqVGCCRP3Jp+y9C/zN/yWo73ANI3oXFFmPVwV1zyYq7sL/uNdC2kHsvbQzPF4Lx8wcufe3tGaXTS7nUBt3oBMqe9O+wvxf65OoHRohsh9J+5a+NG+NEdToDK14hGkMi/RGUfbK0i2YEFu5EYB8FU5fUScjQSTcefi45FaOT9BYhJQIYKWr4DF4DpnF+KZWSBLHuWU9IQ2ea5CzSnTeE8ty0gck/62+YddFhGZ0kr7FxzBApiU+nsP0x2cgytZIhvfh9P1WeT9I0z6fLisTayNRQqPDQ284v8tYtEJp/TXnpvX2FMYr916j3GnDLSe1zx3R0jOsPbGHSPNambnZGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd2LhvrT6oRCNF9O5MS5WrGx+t2+1nwM2bIaiXUL18Y=;
 b=CkcJelOWPCJTR6THvfRGBZ9Yq9KDd8yeStvn37zVaGFBWqnvzE+XElfHkWVP0YrIU9nY3wVtiKMzJu5R8H9VovRFHg5uuJr8ig+FyDhcOYvNsVVX268lzVfkRcScFDyE/o5FcbKQguMcM5PXl/q7QYizOLbEm6Dec+kj/yrHByogbeNnbs/2HN3SBl7n7+TOlTGtzZkdrtQjWz9d3q1lDlZV1us2LvzILuR/pUeeXQFRMh6k5QVzQSf026K2FesPZQRXLt610HJx2dK5oaMjbn5OrhsJsKCr7VskouZ9va7Z+cJrllnHt7da2HioJb1yrZrjvpsxgNJI7W8XKRGy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd2LhvrT6oRCNF9O5MS5WrGx+t2+1nwM2bIaiXUL18Y=;
 b=VrqvYERFjNpB8dCO0s82FwYTIdKv8ShUXqiKmCOn6o22rG56I5YpaTGuOFiew0Qg3HQwfwVNvsWX2TYNxcGYRMDZ6bHy59gCEoekGcY715kk2BHkDGF0xnHdMLI6l39+434v1TrCNuozYRSogw6h6iQhuoz/wYTHfLTtltmGyoM=
Received: from MWHPR21CA0057.namprd21.prod.outlook.com (2603:10b6:300:db::19)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Thu, 16 Jun 2022 11:46:20 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::2f) by MWHPR21CA0057.outlook.office365.com
 (2603:10b6:300:db::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.10 via Frontend
 Transport; Thu, 16 Jun 2022 11:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:46:19 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:45:27 -0500
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
Subject: [PATCH v2 07/14] perf tool: Sync include/uapi/linux/perf_event.h header
Date:   Thu, 16 Jun 2022 17:06:30 +0530
Message-ID: <20220616113638.900-8-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9a24a9fb-e592-4832-788b-08da4f8dd48a
X-MS-TrafficTypeDiagnostic: DM4PR12MB6112:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6112026C5F33D870EE9D10C6E0AC9@DM4PR12MB6112.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9IuY6MQT8CAxqhsmIzuE/Ijtz6MaSj/LZ59syCq7368kYN8nD8mb2Gmmfanq+KqH5LQ0P1n7b2fEzPWBLFK16ydQ1Hu54ZIs9SqaGK408sYGs5vS/rP8Cd+piikyOrR+5YuLn8SvpMbEpVE41S3QpKS1ZyTRA+Z/PgYg9cg2ArPee8BBTNXvJVK5oeEean+YUMduU4U+FFjSiUeybtDiycmtRpyS63Yt6UBwAjfawKdjgYvbAld2JICoXCvcqabcN3sOasdtWAbj+awtoWZp8YHoI9jHPqLkH0yQKH4ICU8XW6LZH4joLDJn1lC3Pm/seLID4VqFikDt83ZsfDRiF2irQsfbrhaP2FDILViyR8O6JY3FiK3yHQWMdayylyoVvSJsWKAWZr5e1o65bbAyiD5YtJQ9XwE0eZGgVGoPNGzR6vsacfPROpofr79NDufLamrOjnsMKupQpjS7VUB7OZ3Qk7nRhROJ5uqvDzNOyibSFn+/SXCPbIL/Ct762bT8NTp6EBNvuLK1T1GkLQR4iThoBJd3G+k0mmvPMOgxuJK/0EeuUTZ8a3UoMD0lhSlC8MJb8eWlgwtRqt9Qg48zByjpJbp+Swl5c4Ajz8YV6vaSRvYBp8VaIwSg5z+04J8433OV9bJC/qm17Pzh5W3NZSuvao8Am2le0L9dhFQuQWuS/WIjIuHtTingyKqyLCT0lBlsCLLCftPyvTaJwGs8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(8676002)(6666004)(86362001)(36860700001)(82310400005)(7696005)(7416002)(5660300002)(8936002)(44832011)(40460700003)(81166007)(356005)(508600001)(2906002)(70206006)(426003)(70586007)(83380400001)(336012)(26005)(47076005)(316002)(36756003)(1076003)(186003)(4326008)(2616005)(110136005)(16526019)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:46:19.9299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a24a9fb-e592-4832-788b-08da4f8dd48a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two new fields for mem_lvl_num has been introduced: PERF_MEM_LVLNUM_IO
and PERF_MEM_LVLNUM_EXTN_MEM. Also, __PERF_SAMPLE_PHYS_ADDR_EARLY is
introduce to be used internally by kernel. Kernel header already
contains these definitions. Sync them into tools header as well.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/include/uapi/linux/perf_event.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index d37629dbad72..daf7c337e53e 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -165,6 +165,7 @@ enum perf_event_sample_format {
 
 	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
 
+	__PERF_SAMPLE_PHYS_ADDR_EARLY		= 1ULL << 62, /* non-ABI; internal use */
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
 
@@ -1292,7 +1293,9 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0xa available */
+/* 5-0x8 available */
+#define PERF_MEM_LVLNUM_EXTN_MEM 0x9 /* Extension memory */
+#define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
 #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
 #define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
-- 
2.31.1

