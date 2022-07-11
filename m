Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0361A570CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiGKVjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiGKVjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:39:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AD5820C1;
        Mon, 11 Jul 2022 14:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHYZ4Fuld2i2B7HvN1reONWgAU62qsYJJjaRBVLFz+p2P0TVkh94jPUXRpVWcNHvau65knmBLtFLawCpW9DuNXBhA3BMZ0wwarXKbvGiTMwUoFcsWw4C5JBZdCe+9YNfR9601SXBj7rf721AGL6gekjvBB5v+ZUxWX+Mrr1sxzGr8RN3x24pMyZK2HPam5ne+P9Uz8kCNJDUXfXD5eK0tOWoL0WCXmNRB+pGZ3JiyB821Vyt5cuT1Oq4TRc3RathA0H3gDdsQcMTKOG2wozumyTWWjJsydH11HUl3aWfbl1qFNxppfnv17n1L6oqeMmdOEwK1oD3qDmJ+NzUYIO4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68xiRkQBoAk7unH5La+w52ocY7zrfZGJvnR8n8NZ7Ik=;
 b=GaHi8IxrWd4ys+brvqm7uI6Q+dfqYh9PfryTuglSUNSMHDUUpRWRGnEgCZCzTwc9o1wWGHOso7knegpJJmLZZMSnkaMNMGLnaKIDjtjzN4LHVm/MOXNYB+F3DRFD4QI9f0ozzKH54crU1x/+R/KajLBgnfzuWV9p+SoUs/RUYKpj3Uj5u5h1BpOt/vUaUxoTbeqJ9B4IjMJPY/h6CURWc5HVQoLHMlKtNnudEyz7G9t4CKLs7ruS/byU2zMs8GH0zV8OFpbE8g7mL0IjJ019XkpUcE0I8/y/I/xzj+0HArSFCT2G5woWuUYz6kjWr3VdP0Bv4Or4zfHBjDOkouG2EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68xiRkQBoAk7unH5La+w52ocY7zrfZGJvnR8n8NZ7Ik=;
 b=PrNByzwf63FqPelbPeIsOysB7DD9lRHKXwkoQBSdWPVDhLYIXBbCTxaliIG6TzPSzMX0t00WGI/Ogk8194iGi1OSlh5jiB1Luerg8HV6kAcWv4jwwshwiHTuuNMKLfE8nLvyNQlt5EDElhrxQkTPRFxPYenUztgYIXO62oO+hgY=
Received: from BN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:e6::9)
 by BY5PR12MB3780.namprd12.prod.outlook.com (2603:10b6:a03:1a2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Mon, 11 Jul
 2022 21:39:11 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::90) by BN0PR03CA0004.outlook.office365.com
 (2603:10b6:408:e6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Mon, 11 Jul 2022 21:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 21:39:10 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 16:39:09 -0500
Subject: [PATCH 4/9] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 11 Jul 2022 16:39:09 -0500
Message-ID: <165757554924.416408.8349826854010563682.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: e0ae4334-efe2-4b60-fad5-08da6385cab1
X-MS-TrafficTypeDiagnostic: BY5PR12MB3780:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQFvQt3gpnDZqvTgKpKFogWPwdHjNBHKkitY/CWpP/Nt27D22G5Q+qolFbST4gMt0dNShN3zZHq9kTOzZla/93/ghMw6dr7sZ/3z1HD77fE4S1AcLVEawnIHG1bvUoqPzC+CNvtCCumx+JL7kWXK99BLPXQECH3TnmyTpwIl81M+uxJh23K5ayXWIEkv8NPMaF9xZvy5ly+4lO9CA5VjkiTakV1Xl2HOmjO6rsy9dp+WImBtNInodU3B/xdRp1Aw53SvG1WRQ4s6DCl/AhPOjSCs88OHs30t6SyT72pEsPjObXxuTdI7d24pXg13/sY4dWAew8avp+hJJp4szaFW4R7T7FrdN72DPMxFcOaWqFD9K4aY1HVqlcnH/OmuPyyNkgMHUuqJ2VmBB92DbYkbCLNpNv3ptj/qjcnUhCsNVEvfbBnenn15mR0B01EPm2Z0oIHr349n3m0pAK7Dv/ySXvnUA2gPZ/LwTB8xChnm431Oq1KEX60ddQP7K2AeBb9OJJvnRC48y1+KqvPXfX3KrwemQN7cjiuHL/843CFeSCvFDtJNFv90hfIpCRRFZ8dmIbsmre6pn1dYOfZSHuRY9CC5oe2pJdv33h7nGlkQ7hroSCKzUN6TLuWZo5W9inMZbqUX7tY2UomVM1wWWD8mMd5meTiVj6XI/FdtponHNQTHPMN8i7S5qYpE6tLSNdzsmax1bDo0BPt7jyIY3rUvTECirzLli50RsTAGN7MxU+Gm93yJp8CBICmD8duU8xflACOl6h6qcfssTe7qUuqsgMpC2CxsccFt94y5pkX/3Bk2KWklCLrq+VZYA6Tq9ZtYP1ygTwZmqbWKONYn5rx36hZzCJut1gFOOfjiPMkzTieskxIZF7cBcW7zH+UPenlx9AiygVXee+01itiqzMYLnquzgPox2b1kQ/dPTZSCPTM3mTHh5V5gnNK2pbtEU3Wa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(46966006)(40470700004)(16576012)(316002)(70206006)(16526019)(8676002)(2906002)(426003)(86362001)(26005)(966005)(478600001)(186003)(47076005)(5660300002)(9686003)(336012)(40460700003)(70586007)(82740400003)(7416002)(83380400001)(82310400005)(356005)(44832011)(81166007)(8936002)(110136005)(33716001)(36860700001)(103116003)(54906003)(40480700001)(41300700001)(4326008)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:39:10.8027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae4334-efe2-4b60-fad5-08da6385cab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3780
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
Currently, the bandwidth monitoring events mbm_total_bytes and mbm_local_by=
tes=0A=
are set to count all the total and local reads/writes respectively. With th=
e=0A=
introduction of SLOW memory, the two counters are not enough to count all=
=0A=
the different types of memory events. With the feature BMEC, the users have=
=0A=
the option to configure mbm_total_bytes and mbm_local_bytes to count the=0A=
specific type of events.=0A=
=0A=
Each BMEC event has a configuration MSR, QOS_EVT_CFG (0x000_0400h + EventID=
)=0A=
which contains one field for each Bandwidth Type that can be used to config=
ure=0A=
the Bandwidth Event to track any combination of supported bandwidth types.=
=0A=
The event will count requests from every Bandwidth Type bit that is set in=
=0A=
the corresponding configuration register.=0A=
=0A=
Following are the types of events supported.=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits    Description=0A=
6       Dirty Victims from the QOS domain to all types of memory=0A=
5       Reads to slow memory in the non-local NUMA domain=0A=
4       Reads to slow memory in the local NUMA domain=0A=
3       Non-temporal writes to non-local NUMA domain=0A=
2       Non-temporal writes to local NUMA domain=0A=
1       Reads to memory in the non-local NUMA domain=0A=
0       Reads to memory in the local NUMA domain=0A=
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
index 1db319f3ce71..bbc1db70ad27 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -297,6 +297,7 @@=0A=
 #define X86_FEATURE_SGX1		(11*32+ 8) /* "" Basic SGX */=0A=
 #define X86_FEATURE_SGX2		(11*32+ 9) /* "" SGX Enclave Dynamic Memory Mana=
gement (EDMM) */=0A=
 #define X86_FEATURE_SMBA		(11*32+10) /* SLOW Memory Bandwidth Allocation *=
/=0A=
+#define X86_FEATURE_BMEC		(11*32+11) /* AMD Bandwidth Monitoring Event Con=
figuration (BMEC) */=0A=
 =0A=
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */=
=0A=
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */=0A=
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c=0A=
index 08e9c78f65e9..13b6763bd767 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
 	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },=0A=
+	{ X86_FEATURE_BMEC,             CPUID_EBX,  3, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
 };=0A=
=0A=

