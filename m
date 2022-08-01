Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D51858729A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiHAU4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiHAU4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:56:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941F241D39;
        Mon,  1 Aug 2022 13:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bumQroBIVw+7xw7KyWYrnI2EZiV47+zzm19ZdqHc2LkpMkdMh3JNgs8TcnXokjRInBKYYugtYI9J/Qpze8zNwVasyPpC6wADxGZi6s6VJ9zoUn4BoFsZ+ndAY84fLQ+cM+Bjf5rUqSDNLwN9EroUmQ2u+oHY5GlTdBQkWD2Ttz8hJ4sbAseJOIbVVue3rj4Gax68klmk1dqca+Bhfzz9o+UEQsnpuQAlXonzs6iCzjUyiNDg8D92DyqTLEX0zkuRGIpDJiSTLpeMdL1YV/iKDPvbnKGJ2VOWfhqp73I8/EH/joJcznIzxSWgjG5OauJyS83rU6BfRyLOFE59nxRVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TodA1u0FOCd/e37Ph+m2LOFY1m4jVoPBDU/dKbuSAoA=;
 b=cPjAZqysBx88D1gS1nv1TxB4+r9ZrII8vM1MmE3ehQQWqUYx+vzpmgUrFrZBMypckC6sHMQ5wSGxqRq4gywrYJ1Pbw0A7GkvmNWtE+MwpZjIDFkvu2RJM0olMrhiTSA66EBxNBItDnhZsYUupuqtAjWxkYsUUmY11Tic78LzjR2RQn5fGofAjQbiUZoEkK/glaQk31GhaT7DQ487xmfSdj4B6KSsE5/T5s7TwLsn2wLZMHmBr1mmYlCaO1sj6ev0aRncmnF0EGFk7AO+wYx1O7paF8x5E+ReHZ3YTlwV97ZWtZcRJzFydQMzxjeB8HrKm8RYiGhKDPk72Jyzx4js2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TodA1u0FOCd/e37Ph+m2LOFY1m4jVoPBDU/dKbuSAoA=;
 b=FrK4ocHE2J+cDpCYHl1xEvlXfAuPN2Xq24c852y6WQhlJ/zGyqOcMm8Th8wdOrCCbQ1daJVGjScXp5HB/HsZiNHz74ebTIQqJgyH5LNqvRWcL1sMBiF7nbZmx4Z0J3WN75KYiwudzrVjm8z0ZjjdOf1cIRKk6w8N6p3ciJR7ZC0=
Received: from BN0PR08CA0017.namprd08.prod.outlook.com (2603:10b6:408:142::24)
 by MWHPR12MB1166.namprd12.prod.outlook.com (2603:10b6:300:7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 20:56:12 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::87) by BN0PR08CA0017.outlook.office365.com
 (2603:10b6:408:142::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15 via Frontend
 Transport; Mon, 1 Aug 2022 20:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 20:56:11 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 15:56:06 -0500
Subject: [PATCH v2 04/10] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 1 Aug 2022 15:56:05 -0500
Message-ID: <165938736577.724959.8916617946994540883.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: d8c1f5b7-6ee7-4888-2d90-08da7400440e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1166:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4fPuaNtU+z+cwMTH/cD4hJ6Xji47KQeTsY6BLVaLbX3jBSaQYu+T1sgQYve8eTqPdx003IPrMBiKL9B4l/hkkj3qbwDiPDk4kCibQRz7wY3ehiIUbzzKc7EKjW57By9XTIvLOLOzUbll2HM7EsYx6gTsR8QPE0vrzPdz5YyRo6kwhbTdvlDPHd7d2vI1VDH8PW/i4IzySAy6zQXDhuMpDxFGmnAigFcmvm+2vluaaEZ8f6j2/SQ5F9OTiFuBeWxbOjZix47l8NcRX675pe7AAzWQ4ftwk0jtN/E0R7BZrjFPyZFmvWWCIQADpDUTGv9+3B1GBI3w7xgSYt3jx84ueG5OQWeT7/+zkOpg1k316wdkzL1WtDQRcfhgRsiQpI9MkBiZ9lxVz/lXeVJD4hO6O5MG8fsTcSJTltxMLY71Mln9txnmVHXNVas60lR5o9Xa71KRjoreCUwDrXwcJEF/3iXPyChWUpCv1JRPAukTe9KW+QlElvodNwmskX1h752MqQRyjuS8VH9/olqRVi+wjN1PXhZYf1cAZrk2UsNsZe2s9H+3QMbz+EMMqpD7SttFmdgpnyta6or0rkcc3IC6dfRN0lPpRFlAxTri1YZamH/knp1amZFtj0SxRcCtnyB07JrBaX2gVQtFmF0D7PcAICkkCyq5xzLK13y2a4pPTBOEhxCUtoxeBnwxYIdms/QP1e6fiSXFgErbCTKO7t4Pu5g/P99Mi9vHEcRXCI7vGoF4fMPIcyDYBI+dgZ+GNaNZRUWd7II+Z6b6bKzJxvZ9os2N40/U5d/7sOiLvNLQH39y9t/bqrTJgpiRLnIBebqyGuqRnm+BN6y0bGnch5HeS+g22KC5FOKOmKFiNiMPlI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(46966006)(40470700004)(103116003)(70206006)(2906002)(8676002)(4326008)(70586007)(8936002)(7416002)(83380400001)(16526019)(186003)(9686003)(40460700003)(26005)(41300700001)(478600001)(16576012)(336012)(40480700001)(81166007)(47076005)(316002)(82740400003)(44832011)(33716001)(356005)(86362001)(110136005)(54906003)(36860700001)(426003)(5660300002)(82310400005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 20:56:11.6323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c1f5b7-6ee7-4888-2d90-08da7400440e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

