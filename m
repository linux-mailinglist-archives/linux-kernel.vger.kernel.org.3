Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AFF58729D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiHAU45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiHAU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:56:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4079C42AC1;
        Mon,  1 Aug 2022 13:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf88UgBpnzaQXrnEhotQyYE2LiEBGvIWuhrtK0YmG8bf0O0oG6k7QEwxKeEDSTnn1qB/+OmR3bU2v9yK+x3khwu7wS09v0RJWs/Iz0f7/Mafm0iZjR5cWBaXWE1lv3wzVuS4cNfd/aCHSs4eyeZgCWLfiOQg6pRkFpuNRBmMybmmHq35HkfCOsGBlhnDWsxJ7ne/GXt1fVmmUEwtE+OG6hXIVpf6KfBad8b8HZiWb1ZzoLvymim9O3YK3buVbbHpQ+Zqr1qL1zRrGYoH+15QVFa2P9nFdyY2rjppST6zEjUUIz8esuM/M5Az4jVbaC7tqG/sgHkmwgSD67hzhADtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQ5T8HnBOEposxGk63tLWEyPKZ/lSiXWL/XTli2xPs4=;
 b=FhY7BSC+guQpSZkIiYpWW8GiJKSEwEeOPjtdoaDrZOVonZtvVfNSimN6dcq03M7DsdYZ2SNa01w/b4Vbaeru+WG2hL7IddDREVnOtPncZM+41Bawd25diUOpzUJv2SA5cjxOUrQSzg0X9EjNuQ9hSEo87tyWsy+McSjh0XGZBav/+RmpPcdyWuyHU66M97IKl7CGPrG6AM1+Qx1VT7Mc29yPH/Q6dNyONJEuODTLz4KFXRuVAq1JAbTL9+IMpKTk1kIMDy/XjJ0IlcX4rJz2sztzzkQEGfHaRZBJvn7YuwpQ0ysYaYaE9Rvk47Ep0i/eSSQ18kdb5bI5JJouDT5Lhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQ5T8HnBOEposxGk63tLWEyPKZ/lSiXWL/XTli2xPs4=;
 b=nkvlZZ2VCNYbbgXCAIqu7noULC5oyAgWts3G76aW9eBNjtyT6Ra+1S7v90r9vcxLecTguZGbeokAIXk8jhnPJ6Hn8mQn2rvCThHs9TkdMoEpK4sJM+VpGvAOwS8rgSmiJCdMm7grCU4l75S8H8Zl8veDJOvenULK0+4xEvVw4oY=
Received: from BN0PR08CA0017.namprd08.prod.outlook.com (2603:10b6:408:142::24)
 by BN8PR12MB3492.namprd12.prod.outlook.com (2603:10b6:408:67::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Mon, 1 Aug
 2022 20:56:15 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::87) by BN0PR08CA0017.outlook.office365.com
 (2603:10b6:408:142::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15 via Frontend
 Transport; Mon, 1 Aug 2022 20:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 20:56:15 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 15:56:12 -0500
Subject: [PATCH v2 05/10] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 1 Aug 2022 15:56:12 -0500
Message-ID: <165938737200.724959.7329082251366107356.stgit@bmoger-ubuntu>
In-Reply-To: <165938717220.724959.10931629283087443782.stgit@bmoger-ubuntu>
References: <165938717220.724959.10931629283087443782.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c95c3c4-d690-4509-1b62-08da7400464f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3492:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o14qc0mGK9ygmyfcd/vIbALYVogK5QJEITS8D5qbxauBwzr6k347mJOe9z36WEYAxz0es5/gQy31HrK/w07LfertEG0xn+81h6rD9GN7RHsfM7WT+VJcLRssLcbDW7q1Y5C9wBPphzsu5exO6mzV5oQPu4jeS69i9hY108yzYsPMARZPFdDJZFPkbLt1Xkixk015Y2NaAD4M+DYsACU+1oxQPyOgiAhmh7bHCZVKHuKezHHZHksxrdhA5t7xEAyGJxjR4BQggKfV/w1GGg8GsS8yg/sR0DH8/B9ntjVRlV97DoYQKP7JcKesPpHv8VGORPdM9ongni1zY3E3zkFcXO33JkUU1bOly1zPJ1zqzpNTSq96fRBLgGPUReS/85n2wijuzEFrw85Qzq2psChMDxcxo0JqrS4EG8dSt4CHmzwp1dpJ/sZDUmL99W3CU/aKkBzdkU7sxXxIpFTIxT4+2MMm3woVWqc07ANednlpm9pGB7llxzXceCrNo6+27DDHGrTvN0XAjmZgvrQ4pmEUnViTzxGUjKrS2vGXcaDbMPrx94+K1kY+5YLyejLBfY5PVAQSLJ1UCtxPBemsmF+1evdQdzQmb1viDHMyvNr9DXf+rQNQtoINH5lOZLTqAj6qfOn0bIbuOBfHicyddcmufsumtVZIVrOxN/1iMwNiX9ZTPdo/PGqcWUFL0GoGoPz8SFw2N9OTEtkQn8HzS+ud21G4Rl4NRHqS7WFx89vvfPMhXFsivVDVvvv3SKRK6n029OqTpaLxhCg22J5faTs/rBW+HSLMpOU6ic6H8wqJmmjW1AoPu27RHSgnfGaT/73Y89IVwsRTX5I008vYoT8MT/oqDWe8qWLJoCJ9ul/HsmC2SPHRXKmNM+fbydr2Ik4TF9CTpbl2XIIeFzP90Tw2vZa5tHO5aVTb0NvbZm0JmKweJ9/drKcuOdbMDAS3FiXB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(376002)(346002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(82310400005)(356005)(16576012)(81166007)(82740400003)(316002)(2906002)(70206006)(70586007)(33716001)(4326008)(8676002)(110136005)(54906003)(336012)(966005)(5660300002)(40480700001)(16526019)(186003)(8936002)(478600001)(40460700003)(7416002)(36860700001)(41300700001)(47076005)(426003)(103116003)(44832011)(83380400001)(9686003)(26005)(86362001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 20:56:15.3976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c95c3c4-d690-4509-1b62-08da7400464f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3492
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer AMD processors support the new feature Bandwidth Monitoring Event=0A=
Configuration (BMEC).=0A=
=0A=
Support of this feature is available via CPUID Fn8000_0020_EBX_x0 (ECX=3D0)=
.=0A=
Bits    Field Name       Description=0A=
3        EVT_CFG         Bandwidth Monitoring Event Configuration (BMEC)=0A=
=0A=
Currently, the bandwidth monitoring events mbm_total_bytes and=0A=
mbm_local_bytes are set to count all the total and local reads/writes=0A=
respectively. With the introduction of SLOW memory, the two counters are=0A=
not enough to count all the different types of memory events. With the=0A=
feature BMEC, the users have the option to configure mbm_total_bytes and=0A=
mbm_local_bytes to count the specific type of events.=0A=
=0A=
Each BMEC event has a configuration MSR, QOS_EVT_CFG (0x000_0400h +=0A=
EventID) which contains one field for each Bandwidth Type that can be used=
=0A=
to configure the Bandwidth Event to track any combination of supported=0A=
bandwidth types.  The event will count requests from every Bandwidth Type=
=0A=
bit that is set in the corresponding configuration register.=0A=
=0A=
Following are the types of events supported.=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits    Description 6       Dirty Victims from the QOS domain to all types=
=0A=
of memory 5       Reads to slow memory in the non-local NUMA domain 4=0A=
Reads to slow memory in the local NUMA domain 3       Non-temporal writes=
=0A=
to non-local NUMA domain 2       Non-temporal writes to local NUMA domain 1=
=0A=
Reads to memory in the non-local NUMA domain 0       Reads to memory in the=
=0A=
local NUMA domain=0A=
=0A=
Feature description is available in the specification, "AMD64 Technology=0A=
Platform Quality of Service Extensions, Revision: 1.03 Publication # 56375=
=0A=
Revision: 1.03 Issue Date: February 2022".=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/include/asm/cpufeatures.h |    1 +=0A=
 arch/x86/kernel/cpu/scattered.c    |    1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h=0A=
index 14b5cc8da75c..2608416f5d0a 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -304,6 +304,7 @@=0A=
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */=0A=
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime =
firmware calls */=0A=
 #define X86_FEATURE_SMBA		(11*32+17) /* SLOW Memory Bandwidth Allocation *=
/=0A=
+#define X86_FEATURE_BMEC		(11*32+18) /* AMD Bandwidth Monitoring Event Con=
figuration (BMEC) */=0A=
 =0A=
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */=
=0A=
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */=0A=
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c=0A=
index 885ecf46abb2..7981df0b910e 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
 	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },=0A=
+	{ X86_FEATURE_BMEC,             CPUID_EBX,  3, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
 };=0A=
=0A=

