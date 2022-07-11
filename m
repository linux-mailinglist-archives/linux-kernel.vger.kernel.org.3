Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053EA570CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiGKVi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiGKViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:38:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91898053C;
        Mon, 11 Jul 2022 14:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddLWuGOiN2P/92+9QvkfpLxLu1tNEeY9z+k9JnuE9mmMKrXvfirvT1/tMOkCLffGZ+FyNnNAJvd2FbfaSWLVUJ38W1QzkTzaaNctm2TrU7ZK9HOlex1O1OKlAvHPpNIstDzV6c+AEO3/2hWaB8BBKPR/pdaPd9CHwo3u1hlig+HZqzWzniGWgOnDMbzcjIvxYIGAlMyqqnvEQ3wnQuivmvKfDvJBN4AzXnev38dLRWpPlHJ2EnHF2LyOE7MNk2hiEWokcjE+uhidZPr5ZZ/EooECkhxwsdueh1e8rKsdwLTzVyQ3xG6wte0AWVZ9C9Oih4jNlgYadA0ZO14ZXDrLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZGnTrbimGFtsYyt4O1WLDmtwYwjwML65fYW/EoszZU=;
 b=Vx6JYIHvnqg/P60IaSgY0uVCcArA+eDlJxb9beFHw7UlBG43uXU3F1vZS4dMxTMA8H9bcsTaVvXEZaj5eQdGG0EeI042ncohLH8HTepuPGe8badRbNkqmwA4ITr17rtp9erE+hcZ2R1hW2mqSSJ0jw8WYOD3N12G+EiNSEGA9rBI8c+phzFNPntGwFUtwui/je+TPB3Enkec/50h6p7vxIUjNosf3LCRKFFPnsBLajJfkFwXktyGXssHwMuT5q4jsh3AyXrq7mwTV4Es0rp5THx0h66e4dfRleHxhc82oWEUbAgAm2FCk3op/fzdfyNJRGLUflXuafRcVHPcvS6wHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZGnTrbimGFtsYyt4O1WLDmtwYwjwML65fYW/EoszZU=;
 b=X5Enw/NRWF97qyyA7d1kf6abCdWcMYuepObt3ibqM0TeDiVULffPRmBF3v270XHDmk1/zCBpL0oFQ2K1gVfUoJ/Swika9MAFXqgfPvGDcri+IZsWv0UZiZkj6N4AMke6S/xgVoZFcDmyW/K/XNiHTOFF8g6CApPwsINbBA7NkWg=
Received: from BN9PR03CA0942.namprd03.prod.outlook.com (2603:10b6:408:108::17)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 21:38:51 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::ea) by BN9PR03CA0942.outlook.office365.com
 (2603:10b6:408:108::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Mon, 11 Jul 2022 21:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 21:38:51 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 16:38:49 -0500
Subject: [PATCH 1/9] x86/cpufeatures: Add Slow Memory Bandwidth Allocation
 feature flag
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 11 Jul 2022 16:38:48 -0500
Message-ID: <165757552870.416408.15207014474202893147.stgit@bmoger-ubuntu>
In-Reply-To: <165757543252.416408.13547339307237713464.stgit@bmoger-ubuntu>
References: <165757543252.416408.13547339307237713464.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51c01ed9-f32e-4a36-901f-08da6385bef3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5182:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChFY3FM0L+qZPQhPD1NNo4Em6r0wzdD5M5BrYsDAxAjoNoCThXV/RDOpoGVIhk0piYzDNWqeiYtA+mydyt81TwUloklmmFCyyZJmeD8cZx2KNmjwNV+lg44TbfrZ1RoTrZ0P2XPmvxSdIZg5Mgo4gWTEjWcspfdaGK+su8tKbE7Wz/tCsoOua4BTJSxbvL78X6PkL9aRTZHwkWLGd3foF3fLiZ2Rchy6NiDv7rw+8oaN5JjM8+UdwFubZcKuVXWNJFELsGucql4Mu0eRf8L+5C9kKgxQTP1X0ZaF7x47C0xL5AdaGSR2xfdZ7l6ZmqTw+xeUCaGzFebgz3py3n2KOxgwBZMO9bG7IW8K6WHR0vZaBS6nthzV3veCnGPTTAN+jnKN87uoWewjkBe3z255Nu87q69tAZIWHopKrliNS3fQF84x+r9BFHV8Clz2RHvOj2VtOj24+jTTc8xKmwiJuP4YU8oOO278052uLrFzLxfr8DzOESvXPrOxHUTNOIHKaMv82Jxd1EAY66DSiA6Ss6ymL/18WQUZn9X+cmY1Dkb4fD1h9kFNuLAIyd0uAjbHcPhoEQkSrjq3PCjrWMJOvSuRQhDN7dZHAslVP0JxFr2ozzlHX85CKBYYoOojx1T878XkEh1W7sE00XtOjDLDh5J4DD48XdUdZuwEeaawR4vuG/6h2HSooz7NYuEitaLhBOKn7ZICu45YH36RYGNoUcjvfekKC8fy7eE3Fj0umy3wpDbkddVHMYXhqPkofFIeUq+485DEFo4qFIr9oT3tlXz1t0oY7USzUkt0YyODZumSVVmo+FCE3lYhF8hd+mLNthAhy8ZEIfOO4bia/cpycctjDcR/6m7FAHxSH0wL5js7k1vc1uWcWIQ35pgwe6gVpMUtnoQfT+mhzSBGwIXwlU6m/APAAhEqKnjHfUs04i7oLlSjT4QcVXtpLOZJMEwa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(40470700004)(356005)(36860700001)(103116003)(81166007)(82740400003)(83380400001)(336012)(86362001)(186003)(26005)(47076005)(40460700003)(8676002)(16526019)(9686003)(426003)(54906003)(16576012)(110136005)(316002)(41300700001)(478600001)(966005)(2906002)(7416002)(8936002)(82310400005)(44832011)(33716001)(4326008)(70206006)(70586007)(5660300002)(40480700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:38:51.1154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c01ed9-f32e-4a36-901f-08da6385bef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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
Feature descriptions are available in the specification,=0A=
"AMD64 Technology Platform Quality of Service Extensions, Revision: 1.03=0A=
Publication # 56375 Revision: 1.03 Issue Date: February 2022".=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/include/asm/cpufeatures.h |    1 +=0A=
 arch/x86/kernel/cpu/scattered.c    |    1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h=0A=
index 03acc823838a..1db319f3ce71 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -296,6 +296,7 @@=0A=
 #define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread Memory Band=
width Allocation */=0A=
 #define X86_FEATURE_SGX1		(11*32+ 8) /* "" Basic SGX */=0A=
 #define X86_FEATURE_SGX2		(11*32+ 9) /* "" SGX Enclave Dynamic Memory Mana=
gement (EDMM) */=0A=
+#define X86_FEATURE_SMBA		(11*32+10) /* SLOW Memory Bandwidth Allocation *=
/=0A=
 =0A=
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */=
=0A=
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */=0A=
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c=0A=
index dbaa8326d6f2..08e9c78f65e9 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -43,6 +43,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
+	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
 };=0A=
=0A=

