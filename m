Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F97659C0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiHVNnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiHVNnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:43:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF89B175B1;
        Mon, 22 Aug 2022 06:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh1e390Gc9LfZB2Lpo/B9nK43U/vGh0drHssIoYr0jMMFjQVLzyho/QB64iipQXry83qs8x4lZlqCt4y8iLjzESQnYKr5v31jnS9tBitXHu/yuYPU4HE/Y7j9f49uXZWep+Cv9BO7yhLkqAF47uQEkZWoDmL+YmqwwOHPuxqF7IoVkg90wVAYwMbcygCq6uXvC06bLN2wfEafqB9H8KpaeseSiMGCq1m1wHv806ERDThmmSwDmpx4Mr48Mz4co9CvdruT0vzgdIKzoNhgucW8oFIvB5Ew2572VwTj2Y+vgGbGm9jnztPtgDLVcJ6Ocs8p7141e1EHne6Quo/QGTgfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRxAsomwRTgKLL4/opMVY3nlt0pONth4Um0z7NtFaJ4=;
 b=T4HvmNSB/lH9nsmoc4oZquEk/v84NB5ZDQF0yeQwvqFSv3PeTlTkKF6SA0ic+zVb2T4l49jtm8QjQ9gtKTXq6kE+2UcFEU4WSkPGKmCBjQ4+EuqdJC5fmgxDVlawC8L5pVA8KM1rk1HDI8192QhLNiuBM8EH9zn3fuAkE1rgYG+RRQpfZGDiCv/zvLgqDtiJcUNoS8YwzwSJOeIzpyhD/es3bay720JB5FGqy9TB/QO6W4RPSb5g2IYBISlYQNE6HS74o05+MAffJsGLbzIQT93/xDHlpFZL4B1+7raYkWicBPoq20JX1goVriPRITIRm5K+GJMIKavPXKgFu39L/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRxAsomwRTgKLL4/opMVY3nlt0pONth4Um0z7NtFaJ4=;
 b=1Ba1Eco73n/IcLp8qELeoLGPd4SXam51fhOKKIh+Wu5zk9F39CbbQTuvyU2mT9WtCsN0N/rtI9LmUCo1H6Ma4Odr7evvygboqWP3pbXc+7wwOAWfekLTijWHpaeJyNVULIm28/mFr58VErusQkYuJXeuutcdIP3yRU/LPTFJSuI=
Received: from MW4PR04CA0180.namprd04.prod.outlook.com (2603:10b6:303:85::35)
 by DM5PR12MB2552.namprd12.prod.outlook.com (2603:10b6:4:b5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 13:42:59 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::c4) by MW4PR04CA0180.outlook.office365.com
 (2603:10b6:303:85::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Mon, 22 Aug 2022 13:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 13:42:59 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:42:57 -0500
Subject: [PATCH v3 02/10] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bagasdotme@gmail.com>
Date:   Mon, 22 Aug 2022 08:42:56 -0500
Message-ID: <166117577662.6695.15496626554784059239.stgit@bmoger-ubuntu>
In-Reply-To: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39caa58e-10d4-47c3-ca86-08da84443a1b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2552:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKS+XRRDmk1fccVDhl+nrK3KBJWp5wTDQl7PaE/imGkd9jRYV9nNmS9Gp4GtaRrjsPO0YReS3IPxkTXCtWrrsgBjqQeg/Ns+3G+zr83f0GyykGHVtJLTKJl8iPyTmfT4TuPvd4v/ILmccXcnweQzKKXatER1avEIndzjGdtK9LVSAlAXvf+C3jCPhsoyZD1htvtZ+vR6Jio6Y/z/t96s/ZzNeaouo64bwshdJrQZaaia3dJQZMvi/H3z5Rt6Nai4pLTkbcg7Egt4lEvYUvF7jydQFDxgxiRU2ZZfws25ZuoP6/KEb/eOup+esrcTwxfr+FEEoQ/+4UT3cPpADSfxqiwtsYk3FDom77MP0QTnGSbQHLwC1JN2sfbavyyDFfJpNZ3fj5BgcRfQtTyXc/H+2xYzZe+fjT0zfEpGA5YPMseHsCAkRvQPN14QCfR7XODynjUu4t/SAzYqzmFUpwdDazGY+peO9SwlI4Sws3z3r9stHlINpIJ/9S8szp1lDqrrLscT84/IRBq+d+Y0mWOLryuOj6bVMb+ap0tbmM4gCv2FNdLxYEi/SD56Iq7/CdW6e0kCAZxP3X/UFtGzKnURq9BgwJ4TOboNtT6YiE+nrlEa7ZrbdT5HO4tK3MNTQ4iLCt1+41hP/u+GspTxEaNi7gRaYZzMs0CD67rYcmPiIp4tMajsCoWBSz/+M1dM7HnP2xTZEMJntftGlv7VPNMrQaTK9U9fGOcls8gYbEWGbP1JGqM3+WdAG01JkfDOQiTZlcWGSFugV2GNCGcp2gOTlfUBc8NKZP5y0xQCA43Ikx+hN2IEqJW4UUC9nGFv4JcbsHfAVbM0aOMUK3h2TBA3s1TGZKkGsBF4XJZOXFk8cESMerUWqFYXWZhY5llZO5BOvzkp17EsPygmSrixbeQmkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(40470700004)(356005)(16576012)(316002)(54906003)(81166007)(110136005)(103116003)(36860700001)(86362001)(82740400003)(82310400005)(41300700001)(83380400001)(26005)(33716001)(40480700001)(966005)(9686003)(478600001)(2906002)(70586007)(70206006)(8936002)(44832011)(5660300002)(8676002)(40460700003)(47076005)(426003)(7416002)(4326008)(186003)(16526019)(336012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:42:59.2014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39caa58e-10d4-47c3-ca86-08da84443a1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2552
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
Feature description is available in the specification, "AMD64 Technology Pl=
atform Quality=0A=
of Service Extensions, Revision: 1.03 Publication # 56375 Revision: 1.03 Is=
sue Date: February 2022".=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
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

