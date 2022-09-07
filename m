Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5CE5B0BF6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiIGSAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiIGSAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:00:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B053BB6030;
        Wed,  7 Sep 2022 11:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LawXg6GIZ4ZS8q771YPcdL7i3qhdlvwgtvwNrJo3gJch54zYf4wv28JTwzUoTObWqlwNT8pF4JpEOjm7cWv7DbTLQf010OtFBFvFBRUYGnmxI1HltSQr02IApv2F55lu+1Ngvf8pX/iZjxQN/R9BmEnWWXSdJXNb0wsBlaY5bh4/YgZ4TQcH5Ega9NIwJFZgvE12H20XTPSAHjepK0oEEq0Stfr6qg+tdBtUCRkXARaUYo/zVUa+j8aumfAgFIsD8Q0pg8iH8qoUhiuwVLyIXVabbClZsu1Ej3RLQw7pKrlhIP6oUV5wCWhDx+NR9O6ihER5W4iXl/CKqtmhFk3Qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtW0vBB+7AiNcRnvNndUWCwm7KWhMXDn6samTQF4xhk=;
 b=YnFbGGWnmkpbDxC+G7vtMORR5RCEwve2jAP8zQ5Km02VUdV915M01kdzSYiCsuwrIZBg8W/n+D9O6FHQyeVmxXMPKOgBVxd7MaWak79EeL1asT7b3dTHyn8v/J3rs1iWl2YElwjg+MGrEbCtMkRWrMxz13WS4YikOM2Z3Byp6U4uSt7gdAwEtkSd3yuIWeD/nCML/Hdx23vY2m12Hfp30y9lvGEADO0Dzy+AHuDa6d8nKC0ntwGn9YifJAeU2cSOtma0nHTSjSdkTplfXzSi4xhoWb3+7v7bzJKtAWDM+/g9ASL5m+NO9KIBor7Bb3wvIjG6BWczqIEmJCSYAyjqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtW0vBB+7AiNcRnvNndUWCwm7KWhMXDn6samTQF4xhk=;
 b=aLd+ri6lxYQk+wFrdWp05cvHAfEqqdam6bq8R6kptNvBPLmuVmWSomVaM7RdwhdiVytWYFkvL0Y1h7/+xBJL4JU4ThSVVBm53CyEqI18FhaXaQH0KP0VnlX4zJM297VwUAwBaGzKAVjMhl1fahxAz9jEALw21xLPypv9msfXfEY=
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 18:00:23 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::5b) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 18:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:00:23 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:00:21 -0500
Subject: [PATCH v4 03/13] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
Date:   Wed, 7 Sep 2022 13:00:15 -0500
Message-ID: <166257361558.1043018.12046795385220064687.stgit@bmoger-ubuntu>
In-Reply-To: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ccbdb9-83a1-44b0-e734-08da90fad631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0iZsal5CxwT5erUhf4CsSXTY6hIQECUjDdN8R5rKVC6tFXt5Z7+OX4HLzyvi1hOu9Mz43Txs7ZzlHuZ3ezZ8okPS1dJEAvlE4RuEMrxa+xxvNXHW3XNQ2yfyFAwBpCditStnYm5uW9wZ2buVz+Jt61w7pJB3nnl1Jr9Y6HmXhphpq/jED/3hcIt77aWQkBWhsTi4YBJRvWjr4JIdGLkkM2OuaPGn0W+ccN4Gk2S1k5uM8b4JTs8YKd8INRpNvSPEmBpW6mQPTkaTrtK1e+bOE+7/IF60KwKlbIBxRyN6ULnxxyxCkKMxaUzVEusd4yruFW2LtIDRBKoXlRKUB2O2UEOokWpvexQ3HMg84CgcCHxRhV4J9ileq+NXhxC4V6b59f+6h4q+L6hsRt843h8JHL4qmYWtPiPfEi+LjJSTzNKMqZIry3VoVZBIn2oKOESYBZl6wm4uiq+tSoM2nY0RI+wCzma7SFE7CJiEm1FaG3yU9yC0hy1Vkn0pfdLD+SLN/GIrTe6YsiwItF3ilyq+lsoz1vXO4BiDTnSQQHDli+0ImaaghxYO7yy0OvE5ifj4TS2g99qwtMctSkItU0vYFb4iSoFa0W3Sa76vaHU1st+XoTES1vYt64ZIPQWDRv1tOI60ilZ2YSxp9VM69f5KJkTf9nqmr20ok8fT5yYbFai+CiDECOiPaaDE773UXogvcxJADn4yBFm4o5lFUhOsSu2yx38KMiK05fy4q/Ngv8q9DpsSKxwkIYCiBLqOoL+hTnqQYdv+2Gng9SMLJ07ERNJnXzQAM8vZhosKEk0T1Ta6aHONi4XQHBi1Mm3fGseuR5mVaXh4RLvThp2hjfV6gBAvwmrhorfLlOVYHgmnQ44w/gg4F0YdJuLudieMyD6usrmMJWRCSqohXV0vr/igA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(396003)(376002)(136003)(346002)(40470700004)(36840700001)(46966006)(70586007)(4326008)(83380400001)(33716001)(16576012)(70206006)(8676002)(6666004)(41300700001)(316002)(82310400005)(54906003)(110136005)(186003)(9686003)(86362001)(47076005)(426003)(26005)(16526019)(103116003)(336012)(5660300002)(40480700001)(7416002)(356005)(36860700001)(44832011)(2906002)(81166007)(40460700003)(82740400003)(8936002)(478600001)(966005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:00:23.5539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ccbdb9-83a1-44b0-e734-08da90fad631
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS=0A=
enforcement policies can be applied to external slow memory connected=0A=
to the host. QOS enforcement is accomplished by assigning a Class Of=0A=
Service (COS) to a processor and specifying allocations or limits for=0A=
that COS for each resource to be allocated.=0A=
=0A=
This feature is identified by the CPUID Function 8000_0020_EBX_x0.=0A=
=0A=
CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature Identifiers (ECX=
=3D0)=0A=
Bits    Field Name      Description=0A=
2       L3SBE           L3 external slow memory bandwidth enforcement=0A=
=0A=
Currently, CXL.memory is the only supported "slow" memory device. With the=
=0A=
support of SMBA feature the hardware enables bandwidth allocation on the=0A=
slow memory devices. If there are multiple slow memory devices in the syste=
m,=0A=
then the throttling logic groups all the slow sources together and applies=
=0A=
the limit on them as a whole.=0A=
=0A=
The presence of the SMBA feature(with CXL.memory) is independent of whether=
=0A=
slow memory device is actually present in the system. If there is no slow=
=0A=
memory in the system, then setting a SMBA limit will have no impact on the=
=0A=
performance of the system.=0A=
=0A=
Presence of CXL memory can be identified by numactl command.=0A=
=0A=
$numactl -H=0A=
available: 2 nodes (0-1)=0A=
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16=0A=
node 0 size: 63678 MB node 0 free: 59542 MB=0A=
node 1 cpus:=0A=
node 1 size: 16122 MB=0A=
node 1 free: 15627 MB=0A=
node distances:=0A=
node   0   1=0A=
   0:  10  50=0A=
   1:  50  10=0A=
=0A=
CPU list for CXL memory will be emply. The cpu-cxl node distance is greater=
=0A=
than cpu-to-cpu distances. Node 1 has the CXL memory in this case. CXL=0A=
memory can also be identified using ACPI SRAT table and memory maps.=0A=
=0A=
Feature description is available in the specification, "AMD64 Technology Pl=
atform Quality=0A=
of Service Extensions, Revision: 1.03 Publication # 56375 Revision: 1.03 Is=
sue Date: February 2022".=0A=
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
index 235dc85c91c3..1815435c9c88 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -304,6 +304,7 @@=0A=
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */=0A=
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime =
firmware calls */=0A=
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit w=
hen EIBRS is enabled */=0A=
+#define X86_FEATURE_SMBA		(11*32+18) /* SLOW Memory Bandwidth Allocation *=
/=0A=
 =0A=
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */=
=0A=
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */=0A=
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c=0A=
index fd44b54c90d5..885ecf46abb2 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
+	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
 };=0A=
=0A=

