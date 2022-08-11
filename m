Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469CA58FCBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiHKMsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbiHKMsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:48:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC37725E95;
        Thu, 11 Aug 2022 05:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dREKmV9hR6CmYaXcaOlLP54Gavx1W8wO32yzmx1NVzLsKdP/NsTecZ3VNEmtvxdw0qavxubytorqemvYFs5qyTWM++bWuEipkUpFHfk2MDdkMTfDAalhRpEZEes2sllz/RUxTT2zSYw/SSUBf4g8BDXMIpAe2BOBNqOEBVpWdTX0wpPsjuMQEmbpxp0uIruCW+4XgIDsLWDZVrtqlXFngdG2bA0sN2gJAL6DCF+6w41cFTP0N0mlGESBuZRU9nWGyGlIOfXSNRaIpX/aTkkK16qD0uP+lbb2Ntw3eNb7TOMgKH28IDyXaMPDRvEcTFPt1c4vCwXKJIcaMVNDEI2Kpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNmzjyRa6YTdqe5tMgCK0JcjTGGmf4j2RAriBhe8P6E=;
 b=Nv5rnYIJtGKP9BpDf8ZQ30ScBgxtqrTod6ubIlYnNaq80u3GpYfYbYUwAjPxOknP8VDmCw8sr1djXke2TXSBA0TV0k6LGcFLxNpCLSdKnYSfno4uEW1Pr4iHN7VohP608LzOYgi9ELPYiUyKNt/UMzueYIae8uWaxkQ3Y7JSNlXmUjzERj+gDfCGChnZWGviuBhHx7hgC7MIpnsSAG6NHkD8FP5vV/7lTWBNoCTSiIU8uoPeMHQsFc0IBouWAKtZhL2/sgb2itdb3g51KvwGmLXMqj0KDvDFRYd+JslCMrRHNdFAStXPT1Ppi/mI9rHg4liNgLa0qRNyOnqgfhXe0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNmzjyRa6YTdqe5tMgCK0JcjTGGmf4j2RAriBhe8P6E=;
 b=I7YXS/qCMBkurhAwNvuz5Lr3PQnCyN0Nbts8xe4Q+mW318j4wjbkv/vqqxuvDj8N+7qcBj6jRwBw3KnuKQUo/ZfuObIyAj0wExcS94j8u+VuqhnrLP9mODGYe/2Tmp6qx4Q9pQ1NCGzyLIrH+6vRIpE/SrsCOtcDXVH7m/tAImM=
Received: from MW4PR04CA0119.namprd04.prod.outlook.com (2603:10b6:303:83::34)
 by CY4PR12MB1335.namprd12.prod.outlook.com (2603:10b6:903:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 11 Aug
 2022 12:48:00 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::d0) by MW4PR04CA0119.outlook.office365.com
 (2603:10b6:303:83::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 12:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:47:59 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:47:53 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 2/4] tools headers x86: Sync msr-index.h with kernel sources
Date:   Thu, 11 Aug 2022 18:16:47 +0530
Message-ID: <ffb9a9f0aa46a4339bb61282e26810112700ae97.1660217326.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1660217326.git.sandipan.das@amd.com>
References: <cover.1660217326.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daf7b358-37d8-4450-9232-08da7b97b8ad
X-MS-TrafficTypeDiagnostic: CY4PR12MB1335:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpo50ZGG6VgF+m6VEX09DYT9xxuf9ani7jl4QLUyaRJfmV6F0C3bFa20Pr8fYjW8npscJGFFXYJh2ySfn/LAi+rMqm3dxTKlxGg2XWRDDXEKMl7YkL6vKSazMx/sKm5EekAIZm3YujDMDF6L+9CCIedbJbJ3NiOoLbEobHV8IeUS7JYyCXit/MZbE6jdp7wNmXlywtRtjHrjrzTxTLFZLS2EYfUux17z4b5jQgieQFVvgibBYStwrSxb/CB+Ea+LZaWCxk8kipgDGiFrhkRQ7jVWWTxQ4qSFKN2ltuaRe4VSX2gABCoQ2FZ5a09yPEEagRdhGB2hyi/HQpEYkHOr39YLF7MOHocmzL284ZW1ZrlmZNA/SRPxBYXXFeo7kqxYGXvUSifSpLwLrMyJPpw9G3mWwO47GldkplRGhwSItzTOnEB49yd/TnYbQXvx0b870clywOWb1hiHPQApUUeVMZc17AFm6Cd3dtrb5sAHm+DWIZ2nv8L7B7GHgi4G3HNsuneFusZu3SPY+g0XDD0EopZ8PCaRYH6VddtwC7rZAJVZ+UoKwBHC5iPJaB5nVFAzFFu2Id50cY1Q1sEQSXOa0j9EmkEvUQkZLXYwjFUNNTVHeLPSVuPaKAwdR3daPQs2Bj++uwNaK4FfQ/xvUSNVhlxXbNq6YT/zMd7Q7oUwJfCZTqdUPQ7gUm6F42+20qpqaWnZBqxPbqp8QRh6NWKbO86UAn3vO+1xxr3XoJ3Yc+dKL6VXdmogZ2eoBYbO6detQzdWI7gQv8gNIFWH3Dg52t1nbXAR4s/85ZQ0Pbz/C79tVLIH8MQ3YyxTWjBnUiwyEUXh4kmSWFp9A4V3WxEnFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(40470700004)(46966006)(36840700001)(41300700001)(110136005)(36860700001)(54906003)(40480700001)(316002)(6666004)(82310400005)(47076005)(36756003)(4326008)(44832011)(40460700003)(2906002)(86362001)(82740400003)(70586007)(7416002)(8936002)(70206006)(4744005)(26005)(5660300002)(336012)(81166007)(186003)(2616005)(7696005)(356005)(426003)(8676002)(478600001)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:47:59.3132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daf7b358-37d8-4450-9232-08da7b97b8ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync msr-index.h with the kernel sources by adding the new AMD Last Branch
Record Extension Version 2 (LbrExtV2) MSRs.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index cc615be27a54..7f9eaf497947 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -574,6 +574,9 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Last Branch Record MSRs */
+#define MSR_AMD64_LBR_SELECT			0xc000010e
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
@@ -745,6 +748,8 @@
 #define MSR_AMD_DBG_EXTN_CFG		0xc000010f
 #define MSR_AMD_SAMP_BR_FROM		0xc0010300
 
+#define DBG_EXTN_CFG_LBRV2EN		BIT_ULL(6)
+
 #define MSR_IA32_MPERF			0x000000e7
 #define MSR_IA32_APERF			0x000000e8
 
-- 
2.34.1

