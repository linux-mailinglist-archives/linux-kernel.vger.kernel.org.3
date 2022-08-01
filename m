Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07D587294
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiHAU4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiHAUz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:55:59 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1D0402E3;
        Mon,  1 Aug 2022 13:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApBo0oy10rxg+jlf6HG/rlQzcQtE3XK89l2qMZlr686ykGithH+nQii+wPdLo71sXjGhK3dmsjpuJMxxALErjHilz89ZKTImb+htnhQbLy5TQkeD6shWSgoPGHZIdCcmFEk29gHlLKLwta/8ZRMHVlcoiAu30izoKvlSQRyX7SIBLzGFqvPwvzKI/IZWQ8gP3M1kHDWuznJ79wg4BWbGpj0uiDlyGAh21yvhf8vbD6Zd7l8/YzT3CCWfpdjmto96en6YEjY87yg83F3EzQIrB1evq68clGcB3J/w0+zuyIbJ33LQgG45QfWpBXvNXGXmXAc5Zns+0fG1FzDGG+kE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUTJaVFr9zeTUfYJTGvwQ3bqgyfIjbUmjqlPaaPRahU=;
 b=fnPvWiziYtd/CGm4S3fuM09gDu7XWFR+lGhr9yMCUMs3hHZTzGKzNLEjNJtM3Ojv4xM15qPEWEl/UuKYmZCDQO9MaQlT7BN1B++ZjF4Phgk26RIAZI/wibVkrh285FfAbIgtLbL+RDy6LEiOQBnJ6uzoF2xQx6mwf7AEDj4GKId6txhAiLOlJMQfhxbj0wxSZfP7yCIlUjZFd9GVoRdtpbg8LMO6uH9pQXrk+POqavbRuCjvcmwqSVmKNTeAdfikoVZs/9tVvaQWcJf/8nKRn6XbQbuJaI/wOg9sqQV66/P5ubcmoy5KLiGYMuX7sfM6EIVwE2vwBTrwO4i+Zu7bEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUTJaVFr9zeTUfYJTGvwQ3bqgyfIjbUmjqlPaaPRahU=;
 b=Ae5HRwchn6q1uod0YxCRY7Fef6NEOqh2Q2WMGOI/F9y4a1zZy9UGHw+kXaLj+vM8iz6tJbcedS6CQsxone8aUHJ3dnMp0PTVivCPqNpbfKZqfaoF0U5x2ha2mG6Y66UqWh7fxkK1dFc/cMfS6E0hmzG7MI4wATYHNudVkCCCnHw=
Received: from BN8PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:70::36)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 20:55:53 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::a8) by BN8PR04CA0023.outlook.office365.com
 (2603:10b6:408:70::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12 via Frontend
 Transport; Mon, 1 Aug 2022 20:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 20:55:53 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 15:55:47 -0500
Subject: [PATCH v2 01/10] x86/resctrl: Fix min_cbm_bits for AMD
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 1 Aug 2022 15:55:47 -0500
Message-ID: <165938734704.724959.15776618190142591928.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: fe049a26-5ce4-4afa-b409-08da74003902
X-MS-TrafficTypeDiagnostic: DS7PR12MB5885:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRpp4jD9kHBoCoCUtkhvCfxL7unNUGLTad3WPZi7vQR3AGv6ollZnbjiDM+zx+vxMGSiQeFFl74TlfCQwIn6YFHk2X3P+DucWDZWNFGrICVrIncfNTkq8Nez2DYrlRBqZsVgQ7TUtQNJ3c3ddm2cPMOHD1LIfF+n06ca076mC24O+t7ZGEV7q9H1W6hDL1kswjrSCRLLcFEcf6AFNSV0gYIeKsXE+5FI/+4GClqyZHrXsu1tYlqfhdemCq7uW2V7ocJNLmBJEjESX6FnITy58iVDf5pwFYNYSLb775b+w38CXi8LkWCGaYI1LssTcGdGv2hZZ1fVyg95V3hfgtgToh+Iqxo+V4DzCzF/vdbVHUJOU4ui2epm61X9v/L0g9O+aKQuvr2zN5SWQr2M45/sXNJsUCtbBRjmNxKeLjLKhiFxrnb+zbDI27aFmmSs1fGTM11YOyBTuwh7VF5rmI/bdTnhSj4ONkdPXm7wXEWSzUI2z6Z9otTQCwS2/UpHJm7jzOtOpZeWbP5dXRdUiHMHizpIEUPy8GkysfPxHDj481+Wr8mixE1BHlrAWUKp4Hkir0HNUi8NYw6VmYk4RPFNHj6Cql1qlcC3sbPmQZ+pebP6f84hbvDatbOihC6JZssMfRBq0LSlBW8sAf0K4NiJxxLsCdiGP2Gl2lLCJmClm2pHoB7TNZjdi2a/fvBw+UfhmS0IG1sdCzMt0Onma9C1ik0oEX3EJfoTF3u2hyadVLSNSSbC/o+1F1eV0vYW+kBH1tBATbwJbz14C7nDavMf2NTE/i4tlAvjZaSHaxMappp0C1pFBBNN/Zc5Q7aUZ/uiwqT8K7at6iCfZIr7v/n/4f4ojKYa9xhopLsc7DaQbibnSz+I54Zuv04oc8TVdQefExKXvZyMRQaAjGeAGzhrpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(40470700004)(46966006)(5660300002)(7416002)(8936002)(70206006)(33716001)(186003)(16526019)(2906002)(40480700001)(70586007)(356005)(40460700003)(4326008)(36860700001)(44832011)(83380400001)(82310400005)(82740400003)(103116003)(86362001)(966005)(81166007)(8676002)(316002)(426003)(54906003)(110136005)(47076005)(41300700001)(336012)(26005)(9686003)(16576012)(478600001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 20:55:53.0865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe049a26-5ce4-4afa-b409-08da74003902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Fix the issue by initializing the min_cbm_bits to 0 for AMD. Also remove=0A=
the default setting of min_cbm_bits and initialize it separately.=0A=
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

