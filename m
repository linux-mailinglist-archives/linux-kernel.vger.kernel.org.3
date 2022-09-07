Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B885B0BFB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiIGSBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiIGSAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:00:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CB18B2F9;
        Wed,  7 Sep 2022 11:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D64C/WXre9MIJNp3d6U0VIqMwTJyv6/+43HmVC20IBOqwrs/jQvd6UVivQVX2ORaZHrRVzPfrHaTNdaV8UNt1F2tz7s1Vs3tRP1IAUmlGoDnXoIZvIXttfYdiRPYbS6D0L0fW08gM2xQSpuqFOrgwgf0jEcn5rOsPoJxnnDAJAgPi2wJEa+w5CKue19E+WiHp4PKe9AVPZCR2K4gr/3lNsGMa48ngYzR3WxkAuOUOHHkkncZzxeG6zmXyYoafSxpI4jcn37K7TTcq79zfWgpXxWFjk31Ygo//F4AAMv4N/rHlBeQlmfqYPtPsqQfgll2eexL/a01+Mb3K1cmA6ORfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iiMtt4Yzok+WlTQJ/wmcZ2gX1D2kL8TGTNd5ktC4ko=;
 b=KyYBf8i8i+UlI+ZiA3gB/mLqhKBdQyT82/fDoMy/9qvgp0pdF2Hay2kGPNr3fa71otETLLUyF9BAT2lUq6FrkAEqZ/cvYLuQ04HInGJIunNQVrAANm7ctgNa7YP5lVCxcVsuxWrwBQIHaeSk8hRI1Vtipq52v+I6gsSUhdM1I/7wVBCKJeQeGMocCsoRJaYHFzwgfWRpdFAeIkUyTKs84lGwgWtrIl5FWOE9h2So4Wm9zlfXhK4zj/m+Spv5mXWnwVJ/3lLfSUfI/lVrv+MlL2Ek/xIAhblbzZtBViyHFh5fUiuVe8muv06HN7nFCZPoSFzSbU4nMyomsAUV6WGcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iiMtt4Yzok+WlTQJ/wmcZ2gX1D2kL8TGTNd5ktC4ko=;
 b=fYExSBX/k4i6ez/C1C3AoyFNI8O2m8Ulj3Dg+A8zqa7PJTJJsHclXfbtne2XG2gfSJz1N3mzUu8PHNi/dZissh7BLvNdj1pYQ0CVZdbfVU8A7Z5FJaGYiHrolc2FA8IAhvjON84dgX8/rKFyDGvQaNFgpCveXA9yp81BQNewyV8=
Received: from BN0PR02CA0059.namprd02.prod.outlook.com (2603:10b6:408:e5::34)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 7 Sep
 2022 18:00:36 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::2c) by BN0PR02CA0059.outlook.office365.com
 (2603:10b6:408:e5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:00:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:00:34 -0500
Subject: [PATCH v4 05/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
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
Date:   Wed, 7 Sep 2022 13:00:34 -0500
Message-ID: <166257363444.1043018.17384356050516925226.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|BY5PR12MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: 31371517-703d-4b48-bffc-08da90fadddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4QahFTe6E10NtHdpXEbDVnlSoR62gGEQ8wiPB2S/o/A2higBT/k1W/zNvb7aBX4NwYCTeVVynLW7IpmufOFcfukZO3wy6rgH1adZDWU1ZoVfSbBirWeTP7VSDb/AsOw68bOzupXYtz5B7S2MzRJdJerApSjXUF85aQm6nH7snEArlPDvGmQn2LAAhBX8MZmz38loxMVWBKuAYp6Uuoh2b063Xd+mS5CfLc15FGxR/WelhS3R3vGy7fJlj8FbcJGhAkwu/V4MziKsmze4p3vnOXlP1rFanmsghlJD95RyW0a9Rt8GLzA8AtDJx6DcR5axAKzu+m/SDNW0V0U6YOMQtM163hMB5E8ZF7C53kfz+XWw1AD3/SUhmdrYzVniLBG6uAXLq95kmdOzP+1f4LFPpkGrqMstO02PDIbbUw8m6yyYjtqR0W/mkfCoMwwcfKsvTlx3TJLV6sYtB8H7KFtekTSVeXYVvyTq0mIXmJ/MX6NSg90No4jHvv3g1SpJ/kIiMUg7fTf6trLiSoT8XaXKQp3lW/AvdVltDPP7D7/Ffi7WlwJlcx6BF08i2LN7vqEpAK9uDPqxGZuZ1OkJxSM5UWpKafYE0hjGPSG00Ucgbr4U3/PU6V84KkblO+yJBh8Wfung98tSasQeb6YNklpj3rT4VEYnxBTvwXJZ/319LRW/4OfxGXYlO1J120m0wfCFQLqVIwSplDVqx/5DKSef3JG3bUhoD5jVYOTGVbR849yaRb0EeHElIliv1MI+gUkdWYhHN4kHbCTn1Lpu9P3+GEKz70fA+tXPyElyZxXdZ8+RocYrNSJIhgHmi2Yicf+e2iMA4x8XrjnHhmlbvwM1fx0IXeWSaSYFAGKZNvd6wOqgDjXIWTpYfzeYqC0OPg0ywt1OBfhfe8niJH8I+RidmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(40470700004)(46966006)(186003)(82740400003)(9686003)(81166007)(356005)(2906002)(4326008)(82310400005)(316002)(110136005)(54906003)(16576012)(26005)(8936002)(478600001)(40480700001)(86362001)(426003)(8676002)(44832011)(7416002)(70206006)(33716001)(36860700001)(103116003)(40460700003)(83380400001)(47076005)(5660300002)(966005)(16526019)(70586007)(336012)(41300700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:00:36.4242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31371517-703d-4b48-bffc-08da90fadddd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
to configure the bandwidth event to track any combination of supported=0A=
bandwidth types. The event will count requests from every Bandwidth Type=0A=
bit that is set in the corresponding configuration register.=0A=
=0A=
Following are the types of events supported:=0A=
=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits    Description=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6       Dirty Victims from the QOS domain to all types of memory=0A=
5       Reads to slow memory in the non-local NUMA domain=0A=
4       Reads to slow memory in the local NUMA domain=0A=
3       Non-temporal writes to non-local NUMA domain=0A=
2       Non-temporal writes to local NUMA domain=0A=
1       Reads to memory in the non-local NUMA domain=0A=
0       Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
By default, the mbm_total_bytes configuration is set to 0x7F to count=0A=
all the event types and the mbm_local_bytes configuration is set to=0A=
0x15 to count all the local memory events.=0A=
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
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
---=0A=
 arch/x86/include/asm/cpufeatures.h |    1 +=0A=
 arch/x86/kernel/cpu/scattered.c    |    1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h=0A=
index 1815435c9c88..a4ee02a56d54 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -305,6 +305,7 @@=0A=
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime =
firmware calls */=0A=
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit w=
hen EIBRS is enabled */=0A=
 #define X86_FEATURE_SMBA		(11*32+18) /* SLOW Memory Bandwidth Allocation *=
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

