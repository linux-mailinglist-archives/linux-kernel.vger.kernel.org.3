Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97921587296
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiHAU4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbiHAU4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:56:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B303F324;
        Mon,  1 Aug 2022 13:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPcKQmOrP2R3a0QiITew3kg6dyK6j4reHT8QIuBOLiPFKFAePTkoXcIrbwB3O2+TSezPIrsgJfqBRlR/Wnm3rByou9HNwcybFkWtYtnG/zo+XIJPhV3UggY1CNzzSjWtloCwldpBEFfwNWsz9y5ZHRUW6gES9uNETnELqS/XNC4Z3OC9/VaGWBJw56FE4jSxdzFpc30AKmP3Wb9U4TkSlalHOuHL0Kjf9nBdR3CCJB3EXWN3howmWhPoEZeDR8+VBk5eKh0sv6ZQfzgnw6v3RSGaysBHW2KCByFdZVQzZ+kotFeRV1JV5cmMvtTGShZbY0obprpF2cN7w4PktSre0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGcR8Bn9Juihll8qkfXWCv6P5+f9yNxBdpXQUmyEYfI=;
 b=D1XoyseBIjdOsiHZ1iKyiS8qaNaskwe+svHJ4zb8UeHtxzosSvJZ2IfBabkX2bvrYreUdYNQ9SoC1WijKRavIntvA+rFuy10wCA+oPwOwv8W91zu2NjkxIYKO88kHFIQFJ72hxXcbe+JyzmNAS9cQNkJo76fvNtIC7AqpH4C8GCfZaHA/5ldqIF24ZV1lbc3Ry0mnYXNAfrwCQYbgI50rlU9kxfrTu7b/sWWImBVnLxK4NkCsmKCXxIFUl2zTiR1FTnvoIDXm9Xsv04SoC74kobSFwNHmQ1o6OJS+ywhk0qTLQj5d/8rn1Zy1Cq2PY9Blzkm9cL39Q6bC+l+amFZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGcR8Bn9Juihll8qkfXWCv6P5+f9yNxBdpXQUmyEYfI=;
 b=IMp2MuJw7/dP8iPIZN6x7ohNRvdGyuC9ayOdJtrSUKxTbeZeOJjYpDtxyCG4bjcpKM3TFxJDvZeECg8cBvddr/BBvBOWyQJ0cnbPhgHDtClcbbeOo1hFgbf24udQ997xGS3V6/cWPlPD+Hy/ifwemSR521d2L59dcx8MKa4tjMo=
Received: from BN8PR04CA0004.namprd04.prod.outlook.com (2603:10b6:408:70::17)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 20:55:56 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::e) by BN8PR04CA0004.outlook.office365.com
 (2603:10b6:408:70::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.13 via Frontend
 Transport; Mon, 1 Aug 2022 20:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 20:55:55 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 15:55:53 -0500
Subject: [PATCH v2 02/10] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 1 Aug 2022 15:55:53 -0500
Message-ID: <165938735329.724959.1672436410988441536.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: 317209df-5955-4412-c360-08da74003a7d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4193:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkq9Xt9lrI7mkHX6JposUxItAepU9yTtWNNeNbInyEa69IlweP1ehDe+OoFL2Ow4SO7uuwluTk7HVwHofEgbKOIRVxziQ/ODx21N4yBz4e2IZWlFfAdfKGGLjy0olHlO0SYYVLGfSePKVW5r4PyM62Qp4y2yW+/LPfX2VSR+lyYDu2yjWS2998uIOn5vcIYyU+1id878uQkZm6prk9F9PokgPjZTpjik0emSu4SaNnTuTwsh59MaxNyaOAESs96dLoX0Yo07yz1iCEPjFrah4yH3BBqnDNV+83udZBtLuyPT92ih8oe6vd9KLvjivR85zXJgmjfvdjLlqLJP86KURmHsbNFm8n4pi3Y/KhzqWMojS+F84He19bhfgWcsT5HZypEjrrhfEiqUkmS5u3w9E6P4y3zs6DNWstDjLdBiR8V72XARVTeNArgRBV3OGd3ckcLkKZjPZskXzd6JxRviT6xFEW57mDuW2mVhuynmz/d4edMgQ3sSBeRyqk9sxBla/jozMpNGFp/Kdfc0qXOxQ8CWTv52b+Y2FTPLdJG0gXtVV0IF4xebCFJONmRBvBPqFIwkonh3na86/2s4iofQkpmlKKP7qRlPzdWHGlAyhNYEMVCeJCTmV5pIgRjBKdm8QoaQ3+uk4VAjg78IqzVvcL0+dlDlDlcpo4IzUnnFUSeYJJD2rdqvcMCd4juGvj/hmHdAQXgSDH3fK9t5SpDTh/QauiS7MYu6n0p6WoKDtzV+YgMn9k8ufzz8VPq8dNXVCfrPhDp8yyBTfaSxCIL/XAfKgOfD/qqjBnBM1noaYcVl393yyini4H/zHgD0gZ80fP+eHmJz6OAXNm/UMer5gxW+kx/2tM9/gHfD08UCqb+KR0rOsRLpJ4d5OKkgHsP0pIIG58RYHhM7U5kyae/hZAW3lgUKnrpgWVQ5pGqF8OzrCK7iPbTN9crnF3gDI6ba
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(376002)(39860400002)(346002)(136003)(36840700001)(46966006)(40470700004)(103116003)(36860700001)(81166007)(82740400003)(356005)(9686003)(86362001)(426003)(336012)(47076005)(26005)(83380400001)(16526019)(186003)(110136005)(2906002)(478600001)(41300700001)(54906003)(16576012)(316002)(966005)(7416002)(44832011)(70206006)(70586007)(40460700003)(8676002)(8936002)(5660300002)(4326008)(82310400005)(33716001)(40480700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 20:55:55.5707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 317209df-5955-4412-c360-08da74003a7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---=0A=
 arch/x86/include/asm/cpufeatures.h |    1 +=0A=
 arch/x86/kernel/cpu/scattered.c    |    1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h=0A=
index a77b915d36a8..14b5cc8da75c 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -303,6 +303,7 @@=0A=
 #define X86_FEATURE_RETHUNK		(11*32+14) /* "" Use REturn THUNK */=0A=
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */=0A=
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime =
firmware calls */=0A=
+#define X86_FEATURE_SMBA		(11*32+17) /* SLOW Memory Bandwidth Allocation *=
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

