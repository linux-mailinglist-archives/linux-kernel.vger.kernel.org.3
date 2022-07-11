Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924FF570CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiGKVjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiGKVjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:39:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D2820CC;
        Mon, 11 Jul 2022 14:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+1FHBC0+m/i/k8G/3oloi2IsLrCkGPiC+kHflLDghMDEYR1M3SpMktahAGiBV5eGuRBHpdLaw+4k1S6hhzl/xOvQKNgTgIK5a9v1/fxAXr38KVBjwpMvZ7AB6ZR2oxvI8W1DwloTduEP0fofjIR+KF3rPKCRnC0YUkepuwjh3ar37AFi0UZ1nd7n2SCRZIKeBdVg/GwXL+XcMuV/cnNWW/YGCkNPDNcGUm3D4MRuuD4o6KAzqFui+RDQn53hYPL429QVXDGIJepzwm9YKd6CeV9I3vrxpb/xa83+NgujKO2Ry3VRtBezzuCcSiFDUPZccgX+J+HMtYJ/DvqiYqKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFfgMuYkADALOBUFl88SwOIHqs3XC6t28Gu6oy2MR1s=;
 b=YjsOVXHVUIcBMMlr9e0swIZC2ftDantbRvWAQ6rnvexFMRideKT0Uo2DEemOAtqJCuNwS5n+P8V8ZpAiKGB5S79q43U+VXpDfmzeDPCI83vZ+9tK+7XPQYlIcKvF95kCJlU91E9iVjc9wiaB9A1O7TiYBAMyA4YxtXeDoI4BMuyvLyYM+mDry28WSyQaEYU7k+yVL/PKrO2DXWoGd0wp9r317ltxal80B46L6UmIsiqcjZ5r889VBMs8W5kRkP4r8Dqly4eN/fq+rPKHNJ5pf+wI3ICA30hRe5X11HV1tjQikM2wfc/2Aw2TyLWOJlC5Smu3ib5/Fw3xJOf8ttNgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFfgMuYkADALOBUFl88SwOIHqs3XC6t28Gu6oy2MR1s=;
 b=tKLVmNvX9ccUFtSoMNAVWYJ3OQHOPMAFdXNc58TDWl4IYKtqN2xu/L8aFj9gJ3/zPy+XYNJfmgykA9jlzW9ZrWotWlIoNuvLu25zjzio/Q5Io4ljSC3L1Csd7X8Rr27CG0lh0cQHAwymb2tEYcj93HxlEw1K3Raw0mlR+IrAJ3o=
Received: from BN0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:e6::34)
 by BN8PR12MB2963.namprd12.prod.outlook.com (2603:10b6:408:61::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 21:39:17 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::4) by BN0PR03CA0029.outlook.office365.com
 (2603:10b6:408:e6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Mon, 11 Jul 2022 21:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 21:39:17 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 16:39:16 -0500
Subject: [PATCH 5/9] x86/resctrl: Introduce mon_configurable to detect
 Bandwidth Monitoring Event Configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 11 Jul 2022 16:39:15 -0500
Message-ID: <165757555546.416408.18035193047484698923.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: a07513ee-d1b3-448b-6bb7-08da6385ce8b
X-MS-TrafficTypeDiagnostic: BN8PR12MB2963:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAzfKfkDs9GHxNzxQERYIyZjQyBRbC3ssVm/y2VTUIrIdnYOGuA1JSgl7SgSNaSq3ln4BfIFWz1bzEitKPEZg2pFyAlZ3IOb8caItCDK1x6TLldjEfHK4Nnta5bg3t1mx33g7/5lkvdUEVDMwUb+sI5t9PVCpNlME61bLcDQSjkrBFlPguLOcErEyXJdPPVg+flSHCGCzmvmD6IGTUSsiUbQaOXL1J9U0THybq8BSzB+mj9MT1E2wixvLXkGGpQZWkmU4J3jInRdFYej3iK7twWBLZJxU1EKmwg5qU5ov41JRb0/TVbn1xd4iYt8RR3iz1DYw78G7r2QShvVCPllgVJWZM2+pfgISKUozGog/Xic48Uvqm4kMRlXQZs1ty56gMZjzRQE3RJyAHm7zWzjpLfUKwdDHX+06l/WB0Rbh0/7j642R1FbNoRQtFrttT5y3+saAKS3LHWDeQ6cO9lwUFgNoUQAi+wRydt2R0TSNO9VMMbR22O0qGCsYmTvUOqAHNLnLR2gtGkebJK7nwF+o8i9fykeQwtjgr+ZTLONlf8rKMScCLCSKM2xDkBxQ4XN2pYmOhs1ShkFpX8fNpFRPZkB6Q4O8v0b/8afgq7f2wgm6Qe4x5p+ybHRjGL7pjLYzhGhoz3zDtMZqSgRpwcFkIrTh8Ap4AJ81LjfRD6MIfOMDAAOCF7YS+zXXZAURB9sC6903JQcisdlS4+jM9SE+f0PyGwoJxhy0n9s5skmC/sKW2vFm/HgB6YvZLLpa5stgf8zT9XXNdjc85+xIJbdqGdDJ/+cFue/57odUxWBiu4Yys1fjSc6O5nCCWa/4gDhZXVzvt5EwqbVD7VIlzVu/0W1lKmxdp/Su/vcfV4ndtuId8d1REbDMRla7ATZoi4+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(478600001)(103116003)(36860700001)(336012)(47076005)(82310400005)(426003)(356005)(33716001)(40480700001)(44832011)(16526019)(5660300002)(7416002)(316002)(4326008)(8676002)(70206006)(81166007)(8936002)(16576012)(54906003)(86362001)(70586007)(26005)(110136005)(82740400003)(9686003)(41300700001)(186003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:39:17.2765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a07513ee-d1b3-448b-6bb7-08da6385ce8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2963
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
Configuration (BMEC). The events mbm_total_bytes and mbm_local_bytes=0A=
are configurable when this feature is present.=0A=
=0A=
Set mon_configurable if the feature is available.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |   14 ++++++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   17 +++++++++++++++++=0A=
 include/linux/resctrl.h                |    1 +=0A=
 3 files changed, 32 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index eaf25a234ff5..b9de417dac1c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -682,6 +682,16 @@ static void l3_mon_evt_init(struct rdt_resource *r)=0A=
 		list_add_tail(&mbm_local_event.list, &r->evt_list);=0A=
 }=0A=
 =0A=
+=0A=
+void __rdt_get_mon_l3_config_amd(struct rdt_resource *r)=0A=
+{=0A=
+	/*=0A=
+	 * Check if CPU supports the Bandwidth Monitoring Event Configuration=0A=
+	 */=0A=
+	if (boot_cpu_has(X86_FEATURE_BMEC))=0A=
+		r->mon_configurable =3D true;=0A=
+}=0A=
+=0A=
 int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
 {=0A=
 	unsigned int mbm_offset =3D boot_cpu_data.x86_cache_mbm_width_offset;=0A=
@@ -714,6 +724,10 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)=0A=
+		__rdt_get_mon_l3_config_amd(r);=0A=
+=0A=
+=0A=
 	l3_mon_evt_init(r);=0A=
 =0A=
 	r->mon_capable =3D true;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index fc5286067201..855483b297a8 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -995,6 +995,16 @@ static int rdt_num_rmids_show(struct kernfs_open_file =
*of,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static int rdt_mon_configurable_show(struct kernfs_open_file *of,=0A=
+				     struct seq_file *seq, void *v)=0A=
+{=0A=
+	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
+=0A=
+	seq_printf(seq, "%d\n", r->mon_configurable);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static int rdt_mon_features_show(struct kernfs_open_file *of,=0A=
 				 struct seq_file *seq, void *v)=0A=
 {=0A=
@@ -1447,6 +1457,13 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D rdt_num_rmids_show,=0A=
 		.fflags		=3D RF_MON_INFO,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "mon_configurable",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdt_mon_configurable_show,=0A=
+		.fflags		=3D RF_MON_INFO,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "cbm_mask",=0A=
 		.mode		=3D 0444,=0A=
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h=0A=
index 21deb5212bbd..4ee2b606ac14 100644=0A=
--- a/include/linux/resctrl.h=0A=
+++ b/include/linux/resctrl.h=0A=
@@ -154,6 +154,7 @@ struct rdt_resource {=0A=
 	bool			mon_enabled;=0A=
 	bool			alloc_capable;=0A=
 	bool			mon_capable;=0A=
+	bool			mon_configurable;=0A=
 	int			num_rmid;=0A=
 	int			cache_level;=0A=
 	struct resctrl_cache	cache;=0A=
=0A=

