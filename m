Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123705B0C12
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiIGSDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiIGSCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:02:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E970C04F5;
        Wed,  7 Sep 2022 11:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbZgog2dwLgnEB4Jz6BanuZo5HYTWEObSbjV/rwL/x2V/EN3luN4DnrQTVkiisKQsBN8yOVUQZpM4ETiFDsNl57puAOnfm7wAQWeIsseeVG0LlsWDPU2VXi2Dx5iZOxV1j+OKvK1r7k772GMgcPt2sNgu/OGMBsu6pMhIdBgoGgSXhWR+WrS6rJZa/dIrne1x7h6v6JkHArn/narkO8MGGwx2igTkWPYdrQOXugW8l/KpKM6nAPERyAnVAkt6MqeHvqKilPANtjSTfr4MRyFcgERXB855xEnatTB67WqIh1CZUv6yVojBpOPEXD1obVUW0wjRtXXigC2cz6pWTUAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF7FRy02/dyvea/QbrULnS1jnDl9ehOwwtErPaKSMu8=;
 b=Fhc7CFkWMEFrbqMxr5RFywOCpGQgWqUpzC2XW8DtaIfgxtfPsiYwYJUetKsQGonJfW1K4W0qZFUpex+EX99LIcXFzb94SPeFdy8JFmJ+SAvm8Q/pLVuqx3Cylbs78xyckJFbq3yLJeFrH+RDLUSBfP3ILTv8yuRvygO2nAade0OC3fJePrlnIIjJSwoOsxCnBuRKcPL6LGP7FPYcviiSFRACfaS8rBdESbDyL3fRAG+zXi31/9vR7CVKU3k74y6rofCDTHrAHKv5Si24DXwcz+lU4WYxrg8t8abgC4lV2MgDb0w4e4fAjbpSLGTD9QFDhQZUmkGlpv1goG1aHaejJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF7FRy02/dyvea/QbrULnS1jnDl9ehOwwtErPaKSMu8=;
 b=ch35aEJRFezd6x9oFJR/7UMdJqSSwYamCnZJXjtyD8H6IQs1ekWys4Up5Myn43midKvfmyVfOuWItUsJ7evr++/gN/U0M6AN+hvqILZgJ6YFodxjq09rhBsfHdOdc/2znxf+BOXtRUOUpYnTg2aUw5aqaNcPVHHdLnhDt95UZHw=
Received: from CY5PR13CA0022.namprd13.prod.outlook.com (2603:10b6:930::32) by
 BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Wed, 7 Sep
 2022 18:02:06 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::13) by CY5PR13CA0022.outlook.office365.com
 (2603:10b6:930::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Wed, 7 Sep 2022 18:00:54 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:00:48 -0500
Subject: [PATCH v4 07/13] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
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
Date:   Wed, 7 Sep 2022 13:00:48 -0500
Message-ID: <166257364828.1043018.1517644566865821019.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8ED:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: f980c5b0-d8c4-42d6-82f2-08da90fb1171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kU/LJk4liqAo8Otr9y0QwWtgkSpRV5t+86L0qorxHhOjcnAnEB9Oh0tLWS5+r7wSaEFpdZJxfga5IxFCWLi1ikEjny9NUzbg7Y2+n8YU+YLuQzXhKwLAP7yWLmoBvaXhL/PyZgrOqwcGsV1iy6Si7LT6+pMhFHYhE4bebeScsmXt7yLOLQGJ8s+aqnxYKYdWpOxh6YNvAJM0Gws6UfxL5wXgvBWgm3bQmUpd5SxjVIyz/cDBsb76EFCgmF+c/Ax5vUBEyuz8C3JeMbnrqramgEz9I1FCmp2AWylmsHVS5XUj/SQbnjL07vi+9hoDBsltXtqWQRcT6c8v0Rnzvnsd+vjnBNuDP6nQyh1qNU/nUt4lVS7fMdKCkeQJqBAH/wAMbi7Knu0TpgVcAxlQyBYIUDB5Yb/kmkLaJSe0tUj11keck6zP8izL2faZIOeXDhfD1lo5NY3sSnZ8oOM4g5y/6DHvMNr4ScE4EaSoPIkm1e515lxbyVifxAe+Ys8e4u7n9koZ2m9j/ugE9EW3K1JL6J5smSSIGAYAwV9dgnV9ED03MO+9sgAfr0D6ibbSE8vEQUKzS7WWH576ztXUgVAo66P2uMpcUiTXont/43rF/l1hq9V8TRLCoy2tdtTXbTJFSDTseM2YAkPzmBpssBR8aCF/N8ZMxzEFxdJHWk8sSKxWB3u2pvuvSp51uQRwy85SN8KK0eUgmagPHdMa+wKXKjsrXR4CPoc4Nebj8W0Gvrkn3qCcxnqDSHNZEDv/L/P/EU9ZJCcm5+Ays+JCrwXJ+EzgSkA+axgWbRp3SFc/RrCfvDI0b2V+FczL/ALiRucCbrXVTFPU/zBi4VqB+oPH9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966006)(40470700004)(36840700001)(41300700001)(7416002)(82310400005)(8936002)(5660300002)(40460700003)(103116003)(9686003)(44832011)(26005)(2906002)(40480700001)(82740400003)(86362001)(36860700001)(186003)(33716001)(47076005)(336012)(63370400001)(356005)(16526019)(81166007)(83380400001)(478600001)(63350400001)(426003)(8676002)(4326008)(316002)(70206006)(70586007)(110136005)(16576012)(54906003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:00:54.0666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f980c5b0-d8c4-42d6-82f2-08da90fb1171
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
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
 arch/x86/kernel/cpu/resctrl/core.c        |   29 +++++++++++++++++++++++++=
++--=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    2 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h    |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    9 ++++++---=0A=
 4 files changed, 35 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index 53fbc3acad81..56c96607259c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -227,9 +227,15 @@ static bool __rdt_get_mem_config_amd(struct rdt_resour=
ce *r)=0A=
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
 	union cpuid_0x10_3_eax eax;=0A=
 	union cpuid_0x10_x_edx edx;=0A=
-	u32 ebx, ecx;=0A=
+	u32 ebx, ecx, subleaf;=0A=
+=0A=
+	/*=0A=
+	 * Query CPUID_Fn80000020_EDX_x01 for MBA and=0A=
+	 * CPUID_Fn80000020_EDX_x02 for SMBA=0A=
+	 */=0A=
+	subleaf =3D (r->rid =3D=3D RDT_RESOURCE_SMBA) ? 2 :  1;=0A=
 =0A=
-	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);=0A=
+	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);=0A=
 	hw_res->num_closid =3D edx.split.cos_max + 1;=0A=
 	r->default_ctrl =3D MAX_MBA_BW_AMD;=0A=
 =0A=
@@ -791,6 +797,19 @@ static __init bool get_mem_config(void)=0A=
 	return false;=0A=
 }=0A=
 =0A=
+static __init bool get_slow_mem_config(void)=0A=
+{=0A=
+	struct rdt_hw_resource *hw_res =3D &rdt_resources_all[RDT_RESOURCE_SMBA];=
=0A=
+=0A=
+	if (!rdt_cpu_has(X86_FEATURE_SMBA))=0A=
+		return false;=0A=
+=0A=
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)=0A=
+		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);=0A=
+=0A=
+	return false;=0A=
+}=0A=
+=0A=
 static __init bool get_rdt_alloc_resources(void)=0A=
 {=0A=
 	struct rdt_resource *r;=0A=
@@ -821,6 +840,9 @@ static __init bool get_rdt_alloc_resources(void)=0A=
 	if (get_mem_config())=0A=
 		ret =3D true;=0A=
 =0A=
+	if (get_slow_mem_config())=0A=
+		ret =3D true;=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -910,6 +932,9 @@ static __init void rdt_init_res_defs_amd(void)=0A=
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
index 7f38c8bd8429..480600b8e4cf 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
@@ -202,7 +202,7 @@ static int parse_line(char *line, struct resctrl_schema=
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

