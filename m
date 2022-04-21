Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89CD5096F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384559AbiDUFuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384553AbiDUFuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:50:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DD511C0E;
        Wed, 20 Apr 2022 22:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3RR+6V+b1GMJxyaxVCHiTAMXZ32KrJpX1n8Z4+rGJg02IFcod2uBJPooHY6U0UvQJyu1bryZ4PN27R95aEBJlZKKWIfs3xSaAzJVbzPr2Mw+P7XRLnNjukR1QI5T9nJazJ/U+UNJL2LO5rMqS4KqB2gYTguQKagHqAjjG3jB18Ul/Mg7qSIOxv0cFNe87eSqtzQCrNme/ucZWqoamXNv4dfGoSZyc9fmMMOcA99+mpaZDh1EaF18m5ERBxnd4ZMTBJKz0bRC1XQHFhUWpLrHr7yn5HoAgOXnnHxm/7BbcmfGjG0WukMN6kI0BAyN7R04YupLl1ZBS5guQex1JvNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE0x0HrZ8A4KwXOsCtJjtpl3kwA7L1dxqKoQztr6/Ac=;
 b=U/1gO68VTLV4ZL8hYhnf6Azp8rsAd76fsmRzFR2ezXyoqHPdO5/vL8x8bOcyXDmyo6HT7fS0cAuOihEW8pTf5UlsY+ACX/EQSk+OULF+B5Kqy2rDoXDgV7CG5A4zTP3RTThE6iWoyNZkcgDtXiyd7mIuU4La9pzBauWhWdwsij/jqEmsGnRioM2nr8Bv+Swh25OmZRhoV2e82sEASfdMXqURG1T/oHF7clBxXpE7liaZuh8jRGike5WQhonBK7KFRxyKSAnBFfiZSP6ow85B/Ty7HinTi5k427SCgVlbVZ4gvnaBqhEC1V9GYk5Hj+6iU9p4vnCGy99A0dCcG1bmaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE0x0HrZ8A4KwXOsCtJjtpl3kwA7L1dxqKoQztr6/Ac=;
 b=q5HqQKEHXwJmmWi3H17U+2yQCDsVaaH52tusFwweSg3I3RMU408747tCLEoFXvOHQABmKHCRkbioxpy5VwA2n+adjPRnSQOUGNDUFtIwaf/8kwsF4yq/bCtCTtP70SpGIc25nBfu3MzOjZRG9VrgucwtoVw7kpCSQALZrxlcqWk=
Received: from DS7PR03CA0110.namprd03.prod.outlook.com (2603:10b6:5:3b7::25)
 by BN8PR12MB2996.namprd12.prod.outlook.com (2603:10b6:408:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 05:47:53 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::cf) by DS7PR03CA0110.outlook.office365.com
 (2603:10b6:5:3b7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.21 via Frontend
 Transport; Thu, 21 Apr 2022 05:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 05:47:52 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 00:47:45 -0500
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
Subject: [PATCH v2 2/7] x86/msr: Add PerfCntrGlobal* registers
Date:   Thu, 21 Apr 2022 11:16:54 +0530
Message-ID: <cdc0d8f75bd519848731b5c64d924f5a0619a573.1650515382.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1650515382.git.sandipan.das@amd.com>
References: <cover.1650515382.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 176bfbbf-bb55-4196-1075-08da235a79d2
X-MS-TrafficTypeDiagnostic: BN8PR12MB2996:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2996EF62C82DB77CD50ED3C98BF49@BN8PR12MB2996.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fp2PfGjZGHoxbUen2T4Kn4fvoRsV09OcW4T/FhZ92SVD0pEmMjo6NV5TyhaQGG/I15Vw+Mt+fbFMcSK1MEBWlMWghS+pbaTxRlHco3CI3Tg2PwSaVvvQo92ofrhdwC3JKxFzwTA0OWwHxgD0bmahbKd+c8zQnA9dOx4AsFMmOAbNAxdDFUwC9AZqzoZb+ihyL3Idyx+1kQwAeeTHZ5rBms7C6j2keiYUxyTipxXxE2Gjf2JOiZh/BdUV9lWlQjPC1W2RRi7Ew5LfCN3oyn6h+OixPY+9ppRmW3pMG1H4E4qOlSIrtJ1sOgqD5IkA9MZfiap5M8k40Ro1GlCNTl1iu3ZvVTzNZnseobzDY4v1RlpYRjymt5jUUqjkyOdp7cgXy7CrY/9KBqRul6TsNHIEEi3KjC6F4JmUGpkNeMYzkSvRvJqpZ947ZMzJFEwJTNMcT4LKHC4ESQm/MHESe8P20rcEwdixp4r7IfsYngxTTvzPGEhHCi5DiQLeIvm/ivdCEocD+HIwqaFQiWzKXoQ2su/e30wQbw1aSbp7XrHCdmelthosZ9wkl9HMISvXkZLPD9K9KEm/FJzUeUlevlKIE2OfQQ4nWvEsEMp4aBLYZJDPSNZAsUbak0tXuuCHMVQszxuoHQXxdbizcnnqKeu2hByR8dBgShYPVH/q/Tpu3A6XI0bdluOuNDg2LwX+rfECksjeXseUmp+89Jn6zh4kAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(5660300002)(336012)(47076005)(426003)(81166007)(40460700003)(356005)(44832011)(36860700001)(2616005)(16526019)(186003)(7416002)(2906002)(36756003)(316002)(86362001)(508600001)(8676002)(4326008)(82310400005)(26005)(6666004)(70586007)(70206006)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 05:47:52.3091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176bfbbf-bb55-4196-1075-08da235a79d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
PerfMonV2 feature bit of CPUID leaf 0x80000022 EAX.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 9e2e7185fc1d..a040f4af93c9 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -527,6 +527,11 @@
 #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
 #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
 
+/* AMD Performance Counter Global Status and Control MSRs */
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
+#define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
-- 
2.32.0

