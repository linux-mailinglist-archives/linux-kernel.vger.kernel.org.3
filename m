Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071914DBF89
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiCQGbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiCQGav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:30:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFBD9BAC2;
        Wed, 16 Mar 2022 23:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maaF1Zl89IU2hEPqu4G+DZ3gY3sGFHx+w71CBT4URPiMpSJzc4op4xk1+Gs+1KZbUg5SO7dOr1orCbNrDqh5B7f8QZKl4ZOgE39nzGru6rddLt1xdMFkJ3Exq4DBHVRtkXJ0VgmMIX75+aN7m5Ws1I67W10AbjcBlAXmpzDX9iQH2O4m9Bd2Cxsre6QufvTVVyCAPUhAVvOM1lXl9uuMM5foENVEEZwIjwT9PRW6/kaxK5s5EWFKCfUDdaGGbrEPpCrdECmkf23yEBTJseMstf5/vyOCKpS6FIk8Ysg7eRpp9H4Pzq5vlG4Ag2+pzPjHMKsjJffOGJ9a7nIKLpv/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzuu74GIY4odsxML0X3LYLbA0l1BfUhGvG6/9rB0Nvk=;
 b=ZmYzNUagozq5feL+NUbXTiSRo1uRj+VYDl7HSjDKpjFuaNZwP4vBmt6zXUHdT8iEIdTxONH7BMtUGAMIOPjlKf5l0rDjO2yrUmLyt67WMr/3HXBD8CjsDxz/VmLnSsUTnKuoni7oivNPOvo5TiIAK/v1uNbuPkAf0Buk9Sgjwjk4gJfuM/zJX5spbboFwGssMuWtt4/Bg1+hf32qnC1/NbA5YPn/tYAsv/xel+ArqwCxYW4ZJouGJYXIb6rkyNw/30TRaYU9z2FhN5KSLrdpWkHVX9dWVJ8e7Gm+YvpYcvPF+Y1c48Td1anrG2hK5rlDBMjlducdSeOjQph6j4jdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzuu74GIY4odsxML0X3LYLbA0l1BfUhGvG6/9rB0Nvk=;
 b=ZaIJlLazNS04yR/FRMAvvw4EUbyfqGjJu6DtdviXWMsEe63WKNXlmehZvnGleXOFv9wfaoW9FGXiAHW3VTZe1uMRGNVQpBSMANaUJLVQkjkO72/LiiRDfwlcn0lPfg7lQ9g57v/eut6vsBXNG5vvWGwNIqF7qEjUFoNNkaf4rMw=
Received: from DM5PR19CA0039.namprd19.prod.outlook.com (2603:10b6:3:9a::25) by
 DM5PR12MB1177.namprd12.prod.outlook.com (2603:10b6:3:6d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.17; Thu, 17 Mar 2022 06:29:30 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::23) by DM5PR19CA0039.outlook.office365.com
 (2603:10b6:3:9a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Thu, 17 Mar 2022 06:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 06:29:28 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 01:29:22 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 2/7] x86/msr: Add PerfCntrGlobal* registers
Date:   Thu, 17 Mar 2022 11:58:31 +0530
Message-ID: <a5edd2f0caf5389916a08c0378648479c7c31d1b.1647498015.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1647498015.git.sandipan.das@amd.com>
References: <cover.1647498015.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f22849a2-7fc4-4caf-67b6-08da07df7d03
X-MS-TrafficTypeDiagnostic: DM5PR12MB1177:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1177119B2EFA6CC130E775478B129@DM5PR12MB1177.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjfcqPwobJE2aigwu501SVMm9mNuOjCb5vqmzrltL6u86yEinYNGeUqvv02axcpM5gIag7HrVhLcwOW7k2C4uRbgR8/uU/rBLrjrRVPGyPO2SjhjlwA9chJvi2snnKWyoi2ULnY3IGAfnmLn5muRbaGMtZYG1buzcMn20iV+ud5KCSrs4TWQXOPx9g1P/lsXMdRPDzYWe12sIsFsGBMUTDCEpcr8u23dnfYl76OpZI3w/v6d1y3LPpB1HBs7gPXSKClk5HiKHRvnosEUvWRK1zWfm0vvgNcT4ItjvvKektWyAAfApUDyC+wzf2m/wqvBH0FjjmdJ/uk6WXhYtjcfxRPBfRRekLCpeSFaOLmuutaDY06Td6EEfbMV6FayV5SI0xv0P+q6JotIw4ocCP9GSXb4y+dddYY7sNA8m/jtRzH9l8+j3FTN9Nvv5un4Bf2o8QQ0m5n5XQKgsrHw0bTQuRa4Gd3Wn0XYvsTW2nvQqiAJzSd4tF0xAAQ1kNZqFpLpZ1iwx06J9gLkNkt6IgXBL4ryXpKAgelFgg+MwuzSd0H7jhpFx2BvcbQdwQ9AgsV4lqR/ZjEl8dh8Vg+JTb5hNhY5i+CcuCgXkYgksTZxZlWhkwUBu6D5EltVh0yzy0of/eV36mvpbMjAeQldanrNVl2UgPRvHcE7aO/pwCbg1MQl83k68PIxwdvH0yraTrvK3tztrbWqfcbHOGGk3+YojA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(110136005)(54906003)(26005)(2616005)(82310400004)(186003)(40460700003)(16526019)(44832011)(6666004)(426003)(7696005)(336012)(316002)(5660300002)(7416002)(2906002)(86362001)(8936002)(81166007)(356005)(4326008)(8676002)(47076005)(36756003)(70586007)(70206006)(36860700001)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 06:29:28.1729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22849a2-7fc4-4caf-67b6-08da07df7d03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSR definitions that will be used to enable the new AMD
Performance Monitoring Version 2 (PerfMonV2) features. These
include:

  * Performance Counter Global Control (PerfCntrGlobalCtl)
  * Performance Counter Global Status (PerfCntrGlobalStatus)
  * Performance Counter Global Status Clear (PerfCntrGlobalStatusClr)

The new Performance Counter Global Control and Status MSRs
provide an interface for enabling or disabling multiple
counters at the same time and for testing overflow without
probing the individual registers for each PMC.

The availability of these registers is indicated through the
PerfMonV2 feature bit of CPUID Fn80000022[EAX].

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a4a39c3e0f19..61d1a55e15b8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -504,6 +504,11 @@
 #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
 #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
 
+/* AMD Performance Counter Global Status and Control MSRs */
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+#define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
-- 
2.32.0

