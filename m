Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F145B0BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIGSAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIGSAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:00:09 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA2678224;
        Wed,  7 Sep 2022 11:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQxEvm+q0wnv43jM3oDi6jVrTZ4Ak7py99ENSaC5TNFcCqx4Z1f0wjx9VbB4vrDB3A1+x92C9CQvhSWC/mRQzDTRmJqJLpxDpw1Xz5AG6fDOzafJfJqKJBaA3PdYb/Bf8n3Pc0bnqBTxqR+YRoPdDy0lEVvuciFeEY0r8HAQKb3wgr5u7Gr5JRSz6+9nGaO+KL/DVmYKGijb23/e5OHhQidLmmcpGf99QqvLLsEVSwNK8odwbJn43KzvAk7t/YkEA4ddXtwi8CYQ4K6iUyzBgls7BXXnb1/lUlShrNezKjH2jnC6lVnmLvkfUxSHAgM9VtP/o31GXhwsA4jaNIL7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/t+Jc3psbsQucTs7puPKoowsJP7IkPRJ0wJMYwIAsw=;
 b=PEBmPcaeVqqRl79AtM4whB9JFEe9A/ZYj3DL4jOwm4Qw6plSVkVevxio9HiRyNjUODFxsWtkIDPVqkjMNT0sCQoCm7rTDhLmf+Vpa20PyyAyTD696zbQKSW3EejfXjBoc9+htKnT907hKvvW3cpMu0uYAbn+pVsGix+xsYDoacg8lJg3gqUu8YK7csrCD6gy4zlsTZfdJ782mIwZbhR1g6cNuhdDVwU9Mma8X+3HW97IFwKYCKkq6J8oQo4g8DMyIVO4gK4l+SKrGdGNqfN5df1TbwOoulpmLHYvjz8+eIW3vEDuT4zVeOtU44FtjnmyO29WXZ6xXLEn7ruSXi7m2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/t+Jc3psbsQucTs7puPKoowsJP7IkPRJ0wJMYwIAsw=;
 b=rWJZBMkbFNB713fXs9P2s55D0rR8dEG1tU/13Jk59ok4l3HhRcGWYCbG7ucVOfPWhpdEuqNropWicAl6ENEN3peqd8GMRAulpb02dTgHFw2vC/QY3As7E5j4/he3H7MLY35Kf4BHWvSrwfdtUUZxTrQW9Fr49Z0N2awtWBXrFsg=
Received: from BN8PR04CA0034.namprd04.prod.outlook.com (2603:10b6:408:70::47)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 18:00:00 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::4a) by BN8PR04CA0034.outlook.office365.com
 (2603:10b6:408:70::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 17:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 17:59:59 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 12:59:57 -0500
Subject: [PATCH v4 01/13] x86/resctrl: Fix min_cbm_bits for AMD
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
Date:   Wed, 7 Sep 2022 12:59:56 -0500
Message-ID: <166257359679.1043018.9253512972611409799.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 682b66a4-f66e-4acc-bd0e-08da90fac793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: im2eXXON/Vba435Z8YapsOWZXgC6wjj0RgxZiJwSkTrzxiBZ6rhh2zvp0A40FV8f4E6Dy1robmEqqg1Zp03xrb0y+cEa4z5jXc8eYurmoQip4wOw0mLjd4F6nbf35nHtJXeMCvTqYylvHS4RrMj2HY/niDtqe61ly2HfOih74wmRtbEpcQ+EKtb8TGgN4NSqjo6r/i0hep1i8Bi1dQyc4I0ekAEmTJpeliepN/gi64dkQVW2XdO3lGwU6AzhsYOX8OkXZlFwXCFqWNSH229XrdOLJNBKYdv+p/rjxMzSUWFRvuIsrivIdoLG1adOHXK2j+rtGaPoWqr0eOv73uiEascBQSRXAen6f1E2k6mtYQMUtaSE7NY8UIRK6JLfM9hyo8rMgLuNX0ghKrt3ZSc6K0hVnuCVqtQDM2JgqPz5+EbnPs6dG2WDZB9Y0ZUglrcTfoOLT0UP63Dp3LPwdxSXnt6YDjSI/VWR7wCnRYmZQBzDGuyCDEEeEMhU2+1umvkg1tWkYizi4atgZLRQndZxIphl+A0jCi9ctmTXG3N5sEUPPQTx4W4ARa0kKC7B3SwHoxoE5b/Sb1rGdmdq0BlcGxmx+Aumc8HXouFVP8mm5HwlRtS9RiVGdB1ol17J4aVyc49g1+pE92Yqt8+I0s6svWhdB4lR2ZC86aTE/8PmsL1xvmkocjj3tPKwitHdBR7+tg8j8RtJ4aUHtCErca/ocVClsRZQsDm+rK4wHkZny2qoGtkpkcPFRsSXEf3VRcO+KpEuW8Zoj0hdtoxx+GI05UAifx11Dc2ECV+Oe1DHLapTuofbcKL0Te/ZLSoctTQbUFRBdze7PWgZXAVNNikLSTIoblgFkixWUqE05jYc7hJ5sVU9ArmoDsvgAzh2DVDJzXkVMcptGLAI9wq4/6ya7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(39860400002)(136003)(396003)(376002)(40470700004)(46966006)(36840700001)(26005)(426003)(16526019)(336012)(186003)(82740400003)(9686003)(81166007)(36860700001)(356005)(83380400001)(47076005)(5660300002)(103116003)(8936002)(8676002)(33716001)(4326008)(40480700001)(7416002)(82310400005)(2906002)(966005)(44832011)(70206006)(316002)(478600001)(40460700003)(41300700001)(70586007)(110136005)(54906003)(16576012)(86362001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:59:59.0293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682b66a4-f66e-4acc-bd0e-08da90fac793
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD systems support zero CBM (capacity bit mask) for L3 allocation.=0A=
That is reflected in rdt_init_res_defs_amd() by:=0A=
=0A=
	r->cache.arch_has_empty_bitmaps =3D true;=0A=
=0A=
However given the unified code in cbm_validate(), checking for:=0A=
	val =3D=3D 0 && !arch_has_empty_bitmaps=0A=
=0A=
is not enough because of another check in cbm_validate():=0A=
=0A=
	if ((zero_bit - first_bit) < r->cache.min_cbm_bits)=0A=
=0A=
The default value of r->cache.min_cbm_bits =3D 1.=0A=
=0A=
Leading to:=0A=
=0A=
	$ cd /sys/fs/resctrl=0A=
	$ mkdir foo=0A=
	$ cd foo=0A=
	$ echo L3:0=3D0 > schemata=0A=
          -bash: echo: write error: Invalid argument=0A=
	$ cat /sys/fs/resctrl/info/last_cmd_status=0A=
	  Need at least 1 bits in the mask=0A=
=0A=
Fix the issue by initializing the min_cbm_bits to 0 for AMD. Also,=0A=
remove the default setting of min_cbm_bits and initialize it separately.=0A=
=0A=
After the fix=0A=
	$ cd /sys/fs/resctrl=0A=
	$ mkdir foo=0A=
	$ cd foo=0A=
	$ echo L3:0=3D0 > schemata=0A=
	$ cat /sys/fs/resctrl/info/last_cmd_status=0A=
	  ok=0A=
=0A=
Link: https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.=
com/=0A=
Fixes: 316e7f901f5a ("x86/resctrl: Add struct rdt_cache::arch_has_{sparse, =
empty}_bitmaps")=0A=
Signed-off-by: Stephane Eranian <eranian@google.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c |    8 ++------=0A=
 1 file changed, 2 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index bb1c3f5f60c8..a5c51a14fbce 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -66,9 +66,6 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.rid			=3D RDT_RESOURCE_L3,=0A=
 			.name			=3D "L3",=0A=
 			.cache_level		=3D 3,=0A=
-			.cache =3D {=0A=
-				.min_cbm_bits	=3D 1,=0A=
-			},=0A=
 			.domains		=3D domain_init(RDT_RESOURCE_L3),=0A=
 			.parse_ctrlval		=3D parse_cbm,=0A=
 			.format_str		=3D "%d=3D%0*x",=0A=
@@ -83,9 +80,6 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.rid			=3D RDT_RESOURCE_L2,=0A=
 			.name			=3D "L2",=0A=
 			.cache_level		=3D 2,=0A=
-			.cache =3D {=0A=
-				.min_cbm_bits	=3D 1,=0A=
-			},=0A=
 			.domains		=3D domain_init(RDT_RESOURCE_L2),=0A=
 			.parse_ctrlval		=3D parse_cbm,=0A=
 			.format_str		=3D "%d=3D%0*x",=0A=
@@ -877,6 +871,7 @@ static __init void rdt_init_res_defs_intel(void)=0A=
 			r->cache.arch_has_sparse_bitmaps =3D false;=0A=
 			r->cache.arch_has_empty_bitmaps =3D false;=0A=
 			r->cache.arch_has_per_cpu_cfg =3D false;=0A=
+			r->cache.min_cbm_bits =3D 1;=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
 			hw_res->msr_base =3D MSR_IA32_MBA_THRTL_BASE;=0A=
 			hw_res->msr_update =3D mba_wrmsr_intel;=0A=
@@ -897,6 +892,7 @@ static __init void rdt_init_res_defs_amd(void)=0A=
 			r->cache.arch_has_sparse_bitmaps =3D true;=0A=
 			r->cache.arch_has_empty_bitmaps =3D true;=0A=
 			r->cache.arch_has_per_cpu_cfg =3D true;=0A=
+			r->cache.min_cbm_bits =3D 0;=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
 			hw_res->msr_base =3D MSR_IA32_MBA_BW_BASE;=0A=
 			hw_res->msr_update =3D mba_wrmsr_amd;=0A=
=0A=

