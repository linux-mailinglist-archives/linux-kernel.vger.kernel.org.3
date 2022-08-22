Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823D559C0D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiHVNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiHVNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:43:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91E613E89;
        Mon, 22 Aug 2022 06:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4bDsKfUrYV4vTL35EWb9ecKQtaHwE841S90MCcSAEVnlF1LABjvcKZpL7DR4S49A7H7ApiCM6jRABK1Jn/hQgwQ4laL1fVT6oguCg9TkHrkw5IAxw/8EZ0C2uhoA2LRggmBwdvemBvCUfdC84iSuzrh16cBXgj6r+mSG0FyAe1WHHertpHFUpNB7rxu88nxesv2sY0IZR/9bs7lrE5Xv0EqymRHlTmNUqvH8XqDTi2UO73BjHVFwBaJSXOkYQExEZwMy0RHrAF3+Sm7rAfHeQdsCYIHKq2od1md05pgBBWzFd75MvnspLFP4HLoCgOCaO73oZ9w9OHcSO/aMQRi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cyteGhoki/wcvYgrsAsUHZdIz+hhdCQWyVKH9/axps=;
 b=kUzQKHq7T+bkrK0a8WyDvTgohfBBFHNuHatOSbPRvgyi72nQA7+K/369A7KrvO+dbiOqz7dUmHhw4zrMWjaoklY4YrfCGJtVfzVgajH31QyVc8/pDGQrDcx31o7ykSNGLwfzBHG9+ZbbekdPEuyxwIr7DuRjfgomePyLdnyVnbZvo4G4pPeRajoVqF+7N6GrGZwZ7X/d2i/7g1AtPmyD1vQa3GUDVhQpi25ujGgeA9kDyXIJCoQkgpQCRr9j9jCcVpLUrvlm9IbEELmL51w1JWVLI420bgZWYvz9DlB0950DjZas6v3FEdYep0gqvU8se+L5GX04hzRhzOR9ZtXS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cyteGhoki/wcvYgrsAsUHZdIz+hhdCQWyVKH9/axps=;
 b=BI+yA7hD4OZDc38ELe4c7HVgRevd9i8YCYZXNn+JOA5+ujZIhJVyNzJ6E6uqcfw/Fr2YtxaAZbFtdRt02vcFU8DuhXdxBY61Hp5U3Cvr/fEJHTknf8NpLgQBHKjuF2qlzL0Z9T4NfluQzKiUzQouqdpKtrJJ2tf7hIs+ViQdZ6E=
Received: from MW4PR04CA0113.namprd04.prod.outlook.com (2603:10b6:303:83::28)
 by DM5PR1201MB0058.namprd12.prod.outlook.com (2603:10b6:4:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 13:43:37 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ca) by MW4PR04CA0113.outlook.office365.com
 (2603:10b6:303:83::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Mon, 22 Aug 2022 13:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 13:43:37 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:43:34 -0500
Subject: [PATCH v3 04/10] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bagasdotme@gmail.com>
Date:   Mon, 22 Aug 2022 08:43:09 -0500
Message-ID: <166117578936.6695.16882887771401229703.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: 5706aad3-6123-41c5-749f-08da844450df
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0058:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2MqgUCXrKoqrvQ3i5wrZrUfRTX8gw3ZEkVoeuaN9z7CaK6qYY2VDEEYAczX00RoCf6Tz0E19sDX5qNLAeUI3thvSZYS6A0LcrpkJ98L7u3lceKmDTA8y5vFOWxpI8PBKvxQbgEVqSnO2lpEm0yluarJFb1Zh7KtULGFDMaVXy2yts9raDmyX+2TC0zVxjzb7agGbuq6OgS1THtQVxSS0rzrXF9TaT0+VRcq6fqMOIo+94rdzeVTwIlSmoNP8eL10kI/AUlnOWeN4O3zm0riI6jlquisIY+ViQhw/dQlpn2yQqUQHwmRLK0IKqZAu4yGEcwD+E9MmKpnamnbGgzT11+/7QPBJ38+G88B9TCCtHLtC9ScKLlHlyIJuzJ7KnuNJGTFOLQ8Kl1Pr/qNFE+IjHMfBFBHr727hMdAWIrXaRS7o4YeYhQLU6giqQKzP+4/5a00KZ8iHdapfTI1sMbS2GKiNEEDfXlMonIKEIQz3lHWKV5BxaM0c7lGOw3v0ltCONJ46d7cOjwzpZzz9PnkhlAO1J9Rxow1+5NcQg5zgw3ypxTY0HzJ+FyRDnVc4auWJj9fkd4D/ODNPpUB7d5ZC1/3PYrKLaRLRn18WjivJPtt/b1Qli7b7XdxToyXlMbR6IT2t3k8wJ+9X4kdZ0+/Ihew8+ZZuH4lIjkP8VCNxomRIobws59grW5usPg6Zx99UiaFgz9UXCQlchNB9uTG7SJ0tOJIho7g76V9ySpJ42LpJai+fLJFfXNTewcVkntOjCChXvNs876BYUdMcDxEUtCEAcew/zVBgv4f7rWZKNsY1vDeWQf5FyAMxHPJ9YLaDpC8Xq2Elh29rbDrZE9Usg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(40470700004)(46966006)(40480700001)(44832011)(54906003)(478600001)(9686003)(26005)(33716001)(82310400005)(110136005)(47076005)(103116003)(41300700001)(6666004)(36860700001)(83380400001)(16526019)(426003)(186003)(336012)(16576012)(316002)(82740400003)(356005)(81166007)(5660300002)(70206006)(70586007)(2906002)(4326008)(86362001)(40460700003)(8936002)(8676002)(7416002)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:43:37.3935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5706aad3-6123-41c5-749f-08da844450df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QoS slow memory configuration details are available via=0A=
CPUID_Fn80000020_EDX_x02. Detect the available details and=0A=
initialize the rest to defaults.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c        |   50 +++++++++++++++++++++++++=
++++=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    2 +=0A=
 arch/x86/kernel/cpu/resctrl/internal.h    |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    9 +++--=0A=
 4 files changed, 58 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index 6c38427b71a2..36ad97ab7342 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -253,6 +253,37 @@ static bool __rdt_get_mem_config_amd(struct rdt_resour=
ce *r)=0A=
 	return true;=0A=
 }=0A=
 =0A=
+static bool __rdt_get_s_mem_config_amd(struct rdt_resource *r)=0A=
+{=0A=
+	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
+	union cpuid_0x10_3_eax eax;=0A=
+	union cpuid_0x10_x_edx edx;=0A=
+	u32 ebx, ecx;=0A=
+=0A=
+	cpuid_count(0x80000020, 2, &eax.full, &ebx, &ecx, &edx.full);=0A=
+	hw_res->num_closid =3D edx.split.cos_max + 1;=0A=
+	r->default_ctrl =3D MAX_MBA_BW_AMD;=0A=
+=0A=
+	/* AMD does not use delay */=0A=
+	r->membw.delay_linear =3D false;=0A=
+	r->membw.arch_needs_linear =3D false;=0A=
+=0A=
+	/*=0A=
+	 * AMD does not use memory delay throttle model to control=0A=
+	 * the allocation like Intel does.=0A=
+	 */=0A=
+	r->membw.throttle_mode =3D THREAD_THROTTLE_UNDEFINED;=0A=
+	r->membw.min_bw =3D 0;=0A=
+	r->membw.bw_gran =3D 1;=0A=
+	/* Max value is 2048, Data width should be 4 in decimal */=0A=
+	r->data_width =3D 4;=0A=
+=0A=
+	r->alloc_capable =3D true;=0A=
+	r->alloc_enabled =3D true;=0A=
+=0A=
+	return true;=0A=
+}=0A=
+=0A=
 static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)=0A=
 {=0A=
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
@@ -787,6 +818,19 @@ static __init bool get_mem_config(void)=0A=
 	return false;=0A=
 }=0A=
 =0A=
+static __init bool get_s_mem_config(void)=0A=
+{=0A=
+	struct rdt_hw_resource *hw_res =3D &rdt_resources_all[RDT_RESOURCE_SMBA];=
=0A=
+=0A=
+	if (!rdt_cpu_has(X86_FEATURE_SMBA))=0A=
+		return false;=0A=
+=0A=
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)=0A=
+		return __rdt_get_s_mem_config_amd(&hw_res->r_resctrl);=0A=
+=0A=
+	return false;=0A=
+}=0A=
+=0A=
 static __init bool get_rdt_alloc_resources(void)=0A=
 {=0A=
 	struct rdt_resource *r;=0A=
@@ -817,6 +861,9 @@ static __init bool get_rdt_alloc_resources(void)=0A=
 	if (get_mem_config())=0A=
 		ret =3D true;=0A=
 =0A=
+	if (get_s_mem_config())=0A=
+		ret =3D true;=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -908,6 +955,9 @@ static __init void rdt_init_res_defs_amd(void)=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
 			hw_res->msr_base =3D MSR_IA32_MBA_BW_BASE;=0A=
 			hw_res->msr_update =3D mba_wrmsr_amd;=0A=
+		} else if (r->rid =3D=3D RDT_RESOURCE_SMBA) {=0A=
+			hw_res->msr_base =3D MSR_IA32_SMBA_BW_BASE;=0A=
+			hw_res->msr_update =3D mba_wrmsr_amd;=0A=
 		}=0A=
 	}=0A=
 }=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl/ctrlmondata.c=0A=
index 87666275eed9..11ec3577db40 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
@@ -203,7 +203,7 @@ static int parse_line(char *line, struct resctrl_schema=
 *s,=0A=
 	unsigned long dom_id;=0A=
 =0A=
 	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP &&=0A=
-	    r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
+	    (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE_SMBA)) =
{=0A=
 		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");=0A=
 		return -EINVAL;=0A=
 	}=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 24a1dfeb6cb2..c049a274383c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -14,6 +14,7 @@=0A=
 #define MSR_IA32_L2_CBM_BASE		0xd10=0A=
 #define MSR_IA32_MBA_THRTL_BASE		0xd50=0A=
 #define MSR_IA32_MBA_BW_BASE		0xc0000200=0A=
+#define MSR_IA32_SMBA_BW_BASE		0xc0000280=0A=
 =0A=
 #define MSR_IA32_QM_CTR			0x0c8e=0A=
 #define MSR_IA32_QM_EVTSEL		0x0c8d=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index f276aff521e8..fc5286067201 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1218,7 +1218,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgr=
oup *rdtgrp)=0A=
 =0A=
 	list_for_each_entry(s, &resctrl_schema_all, list) {=0A=
 		r =3D s->res;=0A=
-		if (r->rid =3D=3D RDT_RESOURCE_MBA)=0A=
+		if (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE_SMBA)=
=0A=
 			continue;=0A=
 		has_cache =3D true;=0A=
 		list_for_each_entry(d, &r->domains, list) {=0A=
@@ -1399,7 +1399,8 @@ static int rdtgroup_size_show(struct kernfs_open_file=
 *of,=0A=
 				ctrl =3D resctrl_arch_get_config(r, d,=0A=
 							       rdtgrp->closid,=0A=
 							       schema->conf_type);=0A=
-				if (r->rid =3D=3D RDT_RESOURCE_MBA)=0A=
+				if (r->rid =3D=3D RDT_RESOURCE_MBA ||=0A=
+				    r->rid =3D=3D RDT_RESOURCE_SMBA)=0A=
 					size =3D ctrl;=0A=
 				else=0A=
 					size =3D rdtgroup_cbm_to_size(r, d, ctrl);=0A=
@@ -2807,7 +2808,9 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgr=
p)=0A=
 =0A=
 	list_for_each_entry(s, &resctrl_schema_all, list) {=0A=
 		r =3D s->res;=0A=
-		if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
+		if (r->rid =3D=3D RDT_RESOURCE_MBA ||=0A=
+		    r->rid =3D=3D RDT_RESOURCE_SMBA) {=0A=
+=0A=
 			rdtgroup_init_mba(r);=0A=
 		} else {=0A=
 			ret =3D rdtgroup_init_cat(s, rdtgrp->closid);=0A=
=0A=

