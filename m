Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEBF570CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiGKVjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiGKVjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:39:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E4082448;
        Mon, 11 Jul 2022 14:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsnKlob87+ST3JACNrhbwhjk1vosVmVFJ0a9ApyHKd98R5t3QpFVu/3mm+UanHIkLMzqESEiuixY8WyYhBSjH3oTZn4xpP9n2x2M4oXMMbSq8+qKDSWMssMQVCT2yaNuQNNEmeRv4wCLlIiYZpSuwGLt+YpJ9AitL4yJex77qb1BhlYRLl5XDo7YWz98Jk/qrCZ6PcwJ5QKrV5Z8OhHeGp0lugQLNs00gUNcKzgqhLE64aInE8zvIPdMquYBh3btw37/rq4X5c4DAkhZj8+HpRCB7nnZaZB0tmtvzx3fZSvmn6vps5zmFC1F1oGQmh2v6xS/Pni4klq/YjdoexEmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBlbgPQIUhU3819N5xr+cxrPlWG+JpJnpwv9nWAI8Rk=;
 b=DqoiM1irIBDRjBGeV9XW5MaU/UvanPzp5tvzrssVcx4PgFgGmPpODb2D+Mdz+iT0il/zo8emd0pkvmJVkfRLdt0jYeP09d1TLFAQD/uzVI5k1gYxq5zP9t+gF2P7ZEzzxb66do5RyzL3PePznOAkap/aDnfZwr3TfQK3hpKXldKsibKKimlGJmHkgKJymdoiVlW7NQUFf5dn0GTD5DWnoI833jzQADP9CK27C/gvp4OEQijzBhSJSV/0AjAr5Cdm4OE0tvbNyvhAXThVWAmiqjavvTSuTOMZXx1zxkaVcub/m85HAybDMKQZ7JaAr/67wIssuRQoH26OW0XJGtrW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBlbgPQIUhU3819N5xr+cxrPlWG+JpJnpwv9nWAI8Rk=;
 b=fvaAdh8VYSXBHooQq+sFRIteKZxuDJXOhxkcgtV8bzm/yeIr/jqea1PLEvWZjOxDLKFTepADoKQWXH9GHs58MCzK+2fKLwUU/vNqlJzh5Qj8RZh9XlRiOOduzxxtieTOTt2R+nrASXEmuIwnJNrxpj5a0i6iNe76PVGmBoeSVqs=
Received: from BN9PR03CA0170.namprd03.prod.outlook.com (2603:10b6:408:f4::25)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Mon, 11 Jul
 2022 21:39:05 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::b4) by BN9PR03CA0170.outlook.office365.com
 (2603:10b6:408:f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Mon, 11 Jul 2022 21:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 21:39:05 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 16:39:03 -0500
Subject: [PATCH 3/9] x86/resctrl: Detect and configure Slow Memory Bandwidth
 allocation
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 11 Jul 2022 16:39:03 -0500
Message-ID: <165757554305.416408.7233306354670176238.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: 0ef86907-2b41-4fdd-54e6-08da6385c751
X-MS-TrafficTypeDiagnostic: CH2PR12MB4309:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XN/eyaiA4XXOSkxwxCibgvOEbMVE6U8adLRsSjGyueVjJC3aEPSug79Qsm1oYLKhqmgOYMK4DSTs7iE6TpBjyQUeRPKyLo5/POLnGw3s23DzVe0aY7DnaUOfhPGhh1vLe8B40MupOTPHLP4obq8cifPkGwcbCDOKRWCQzKc+eHLOXdLCEWb2uuOwJtZJxKliYIVPaulRKkFPhMcMMR7I+38xDnItoWBA/SaP8H59sfjRq9bVJZdXYBLweE4oioPKi/hRc8DmCUo1AvtaaAeALMJOxAJMFfh8aiXaZ6pUkeXZGMjDVNLMDMn4ZvR/kJh4PAgF7jKZJY5EatmkeR7ftN2+06peJff+99WFjQIekhRKHlD4l1WByFIgptXieJaF4bibQSCP7OvVPa/VRUQ38OAYY1sphyIsEaaWX/YVXPyrzdQPPLy7KIHZQXzcemLZI8cUgOh6Fo5FSFNn24fFu61v7zkRVlo7eVT9X7hthfJa1kWwKir31xj/xQEw4ep2sd3a2Qov2n0RBekkOiPmJR9eJqqgjB9O6oCAG2L0n/iRhOfANajMjTW2LBSqo/TB2F1C40oPgcL0wHrZqsxefCgrFfXh+DyE28eUDwhHCipdfs8kiH7HyGuOVSluAndoOH5y3PZS2nxc2V+hk5yg1CWFGbF1WIcnXG5jwH6nlNufOgj44yeYkMkCPrajBVBMSz16JBo2MZsVb0A4XBgL1LSrnAAYmRy5ClC3Wh04IOtcZGis1drJEf7HhmM9Q/8ykiMyrWs0oBArdhMpTC3CNKlGtpw3QVxNxJEbqMPZMUovL3lzPO4gcuKKMnIJEFO+nfsRR9+iNvCeeMGhVjkWBUoMxIck0osrCCTqzotEhxGGBCzb8hcfrgDZwvmH4K25
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(39860400002)(136003)(346002)(376002)(40470700004)(36840700001)(46966006)(426003)(9686003)(5660300002)(336012)(7416002)(8936002)(478600001)(16526019)(40480700001)(47076005)(41300700001)(186003)(2906002)(103116003)(44832011)(26005)(82310400005)(83380400001)(70586007)(70206006)(356005)(8676002)(4326008)(316002)(110136005)(82740400003)(16576012)(40460700003)(54906003)(81166007)(33716001)(36860700001)(86362001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:39:05.1361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef86907-2b41-4fdd-54e6-08da6385c751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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
index 004d809ea675..bb5071b91de2 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -259,6 +259,37 @@ static bool __rdt_get_mem_config_amd(struct rdt_resour=
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
@@ -793,6 +824,19 @@ static __init bool get_mem_config(void)=0A=
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
@@ -823,6 +867,9 @@ static __init bool get_rdt_alloc_resources(void)=0A=
 	if (get_mem_config())=0A=
 		ret =3D true;=0A=
 =0A=
+	if (get_s_mem_config())=0A=
+		ret =3D true;=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -912,6 +959,9 @@ static __init void rdt_init_res_defs_amd(void)=0A=
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

