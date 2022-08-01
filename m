Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E719B5872A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbiHAU5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiHAU4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:56:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C011759E;
        Mon,  1 Aug 2022 13:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvABaBjx1l1jH/NVvjI6zaigKK+mq7nIB9HLdpICuvjIO5oJjyOUaJNwYV3He14dxzLZv4vsAzBjdbN6/2qoh4wNzOMVHkdBDwafhWt4dSP8M3vKGTNuVZP3gvTRInvKOZPchlvFRPit7LwM/zHhtNUABo8XzT6r8VVp/+Oc2Q61OwI3MMm9igj6+4d2Q1rMli5StuEn1uAEELib2vUoiIys+5EXdDJRUj1o0R23y/VA1VcwbSUvf+pPi0590G3oyqTWydJjZFz8HrTKZR1bVwiyznWzgQ4Jo+nA1EmhuBsfUMw5VP/VQSsKoUzmuCNm2AKEVHfcAMrq28frnBCNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfGercsQhgo2O8Rec4uKMMlwFWA1+1hnZNnzZHgBMV4=;
 b=E7WmBGbg2Tj0VHLmmR71Y3uUqyQA2NFk1Coxb7gaO109iEB8Zm8J7HOohyIhk7/sRRaOfgqzGGHdPo4+ukGNTB1xHZ1dxBdxg1EYnpwqPI5bkGi8k0vwiFteYjeBftnk2HgK04nije6A07xSH/rFy5L1sionYRzZcAvaY8wNiSYzUJ6dm9wchZyGylq1WEpH2loaLYYT1ZvMk8tPxvskHMPrG2YmEyhQkbyP2SwxopRIji9vCbwjPjpCU/8/dxQ92NQWo3KysGN2pbb/WC3lmZCt2yUTDdvveIEDA8ypq8chhj/dzxVq4r6StYKz6UwLlH+hn9QUa3XFC8rxBjo7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfGercsQhgo2O8Rec4uKMMlwFWA1+1hnZNnzZHgBMV4=;
 b=OvkDuu6jLzO7Zzpp/X7AUJAIPug7MAvUwWqIzwvbOTfTLFMOluVSFVSfgWqBsYYxwavA+6LwXKCPItwh4VUbS+a2mQkTES0b1sZwloXJwyufW9mFoiEsOkZfUKOrOEjNuiTdm+JLTeRXuLYpyhEKUqjIC51dao09vZV3IDU3NoI=
Received: from BN0PR04CA0182.namprd04.prod.outlook.com (2603:10b6:408:e9::7)
 by MW3PR12MB4506.namprd12.prod.outlook.com (2603:10b6:303:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 20:56:35 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::5b) by BN0PR04CA0182.outlook.office365.com
 (2603:10b6:408:e9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20 via Frontend
 Transport; Mon, 1 Aug 2022 20:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 20:56:34 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 15:56:31 -0500
Subject: [PATCH v2 08/10] x86/resctrl: Add the sysfs interface to read the
 event configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 1 Aug 2022 15:56:31 -0500
Message-ID: <165938739105.724959.5094448646566923271.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: a698e639-51f3-4556-ac62-08da740051e2
X-MS-TrafficTypeDiagnostic: MW3PR12MB4506:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LT2ErsSqbCgnF9Q+1DxMDZHLQfu89RiZmKhQH4zdT/qMojbpu6JnHhvVigXo4yoGOBBrBBe2T32FuITvF81EyqNNvvbEcJvZzwYDTH1DRtFIlSONdn/ETJKTKsRSEnrr9Vujt+81WDU8CGcnXDoBuiRCAx5VqWJwXJT8I6IGS1r6cynCaeyMxe8V2iB3OoU9uaDDqjgScIOpfG4iEj342Q57Wf/zvp8lgnb36YOsoNmyyOdTbCV0C1od9DrV/hAY90Q74zpV+7ouosolQA+Iu/tzvka3FNKc1Scjnd6b6iORKcXXz/Rq0M9jP6ntO2e7/NS6NdLjkgJmP197/B7JVGeGrzuHOvMdf/7GOAZl8/butMtocLLLnVlT44yMAKlmKPTBBC/Zi10dQQKUzAyz+jYHtBMJWKlpv4KdEI2XiEc1kZFjp7b3tLnZMPeR3ZjQcs4nd+pS8l+RmkyT/BkpTwvagzeYV3H36WIsI9NtYBCuQq+ogZWZPbdAezXttvANIcuDAAyHjwwwySOMF0krdJHsSxkQf9B2u7rUqPsLmAWGBPDk5haQIcXF/CYMWw/TidWZ9G3wBddxlxQZO/i5dgSIb4fBEzlSQyaAvFojCQF2RHCJGDaqwLPSdlNrd4E3K4e2ZuTsepC7lFihsntXJpVr0Mz3DSTd/NCo5QQDwFiUb638lM/CfzXFwxuKq4REA1qhi/Vr+VzF2bdW900dnFLVsY9hdA8dEjzl/+h1EuVuALNujEJCo7WmftX/uspGfcpCSnEovyUBwFyruwedS1DrUAG1/JuXN+n2Ih7R4TgbCLwGGASgCWSBi1L4DYg5eA//231XYkfX4EbUKkO8RNn5F38LYifaOcrPv5bbGfc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(136003)(346002)(376002)(39860400002)(40470700004)(36840700001)(46966006)(9686003)(82310400005)(86362001)(2906002)(26005)(41300700001)(66574015)(336012)(81166007)(356005)(426003)(47076005)(36860700001)(33716001)(83380400001)(103116003)(82740400003)(16526019)(186003)(40480700001)(4326008)(70206006)(8676002)(70586007)(5660300002)(8936002)(54906003)(478600001)(16576012)(316002)(110136005)(40460700003)(44832011)(7416002)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 20:56:34.7103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a698e639-51f3-4556-ac62-08da740051e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4506
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current event configuration can be viewed by the user by reading=0A=
the sysfs configuration file.=0A=
=0A=
Following are the types of events supported.=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits    Description=0A=
6       Dirty Victims from the QOS domain to all types of memory=0A=
5       Reads to slow memory in the non-local NUMA domain=0A=
4       Reads to slow memory in the local NUMA domain=0A=
3       Non-temporal writes to non-local NUMA domain=0A=
2       Non-temporal writes to local NUMA domain=0A=
1       Reads to memory in the non-local NUMA domain=0A=
0       Reads to memory in the local NUMA domain=0A=
=0A=
By default the mbm_total_bytes configuration is set to 0x7f to count=0A=
all the types of events and mbm_local_bytes configuration is set to=0A=
0x15 to count all the local memory events.=0A=
=0A=
$cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config=0A=
0x7f=0A=
=0A=
$cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config=0A=
0x15=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |   21 ++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   70 ++++++++++++++++++++++++++++=
++++=0A=
 2 files changed, 91 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index fc725f5e9024..457666709386 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -15,6 +15,7 @@=0A=
 #define MSR_IA32_MBA_THRTL_BASE		0xd50=0A=
 #define MSR_IA32_MBA_BW_BASE		0xc0000200=0A=
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280=0A=
+#define MSR_IA32_EVT_CFG_BASE		0xc0000400=0A=
 =0A=
 #define MSR_IA32_QM_CTR			0x0c8e=0A=
 #define MSR_IA32_QM_EVTSEL		0x0c8d=0A=
@@ -50,6 +51,26 @@=0A=
  */=0A=
 #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)=0A=
 =0A=
+/* Reads to Local DRAM Memory */=0A=
+#define READS_TO_LOCAL_MEM		BIT(0)=0A=
+=0A=
+/* Reads to Remote DRAM Memory */=0A=
+#define READS_TO_REMOTE_MEM		BIT(1)=0A=
+=0A=
+/* Non-Temporal Writes to Local Memory */=0A=
+#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)=0A=
+=0A=
+/* Non-Temporal Writes to Remote Memory */=0A=
+#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)=0A=
+=0A=
+/* Reads to Local Memory the system identi=EF=AC=81es as "Slow Memory" */=
=0A=
+#define READS_TO_LOCAL_S_MEM		BIT(4)=0A=
+=0A=
+/* Reads to Remote Memory the system identi=EF=AC=81es as "Slow Memory" */=
=0A=
+#define READS_TO_REMOTE_S_MEM		BIT(5)=0A=
+=0A=
+/* Dirty Victims to All Types of Memory */=0A=
+#define  DIRTY_VICTIS_TO_ALL_MEM	BIT(6)=0A=
 =0A=
 struct rdt_fs_context {=0A=
 	struct kernfs_fs_context	kfc;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 30d2182d4fda..e1847d49fa15 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -254,8 +254,78 @@ static const struct kernfs_ops kf_mondata_ops =3D {=0A=
 	.seq_show		=3D rdtgroup_mondata_show,=0A=
 };=0A=
 =0A=
+/*=0A=
+ * This is called via IPI to read the CQM/MBM counters=0A=
+ * in a domain.=0A=
+ */=0A=
+void mon_event_config_read(void *info)=0A=
+{=0A=
+	union mon_data_bits *md =3D info;=0A=
+	u32 evtid =3D md->u.evtid;=0A=
+	u32 h, msr_index;=0A=
+=0A=
+	switch (evtid) {=0A=
+	case QOS_L3_MBM_TOTAL_EVENT_ID:=0A=
+		msr_index =3D 0;=0A=
+		break;=0A=
+	case QOS_L3_MBM_LOCAL_EVENT_ID:=0A=
+		msr_index =3D 1;=0A=
+		break;=0A=
+	default:=0A=
+		return; /* Not expected to come here */=0A=
+	}=0A=
+=0A=
+	rdmsr(MSR_IA32_EVT_CFG_BASE + msr_index, md->u.mon_config, h);=0A=
+}=0A=
+=0A=
+void mondata_config_read(struct rdt_domain *d, union mon_data_bits *md)=0A=
+{=0A=
+	smp_call_function_any(&d->cpu_mask, mon_event_config_read, md, 1);=0A=
+}=0A=
+=0A=
+int rdtgroup_mondata_config_show(struct seq_file *m, void *arg)=0A=
+{=0A=
+	struct kernfs_open_file *of =3D m->private;=0A=
+	struct rdt_hw_resource *hw_res;=0A=
+	u32 resid, evtid, domid;=0A=
+	struct rdtgroup *rdtgrp;=0A=
+	struct rdt_resource *r;=0A=
+	union mon_data_bits md;=0A=
+	struct rdt_domain *d;=0A=
+	int ret =3D 0;=0A=
+=0A=
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
+	if (!rdtgrp) {=0A=
+		ret =3D -ENOENT;=0A=
+		goto out;=0A=
+	}=0A=
+=0A=
+	md.priv =3D of->kn->priv;=0A=
+	resid =3D md.u.rid;=0A=
+	domid =3D md.u.domid;=0A=
+	evtid =3D md.u.evtid;=0A=
+=0A=
+	hw_res =3D &rdt_resources_all[resid];=0A=
+	r =3D &hw_res->r_resctrl;=0A=
+=0A=
+	d =3D rdt_find_domain(r, domid, NULL);=0A=
+	if (IS_ERR_OR_NULL(d)) {=0A=
+		ret =3D -ENOENT;=0A=
+		goto out;=0A=
+	}=0A=
+=0A=
+	mondata_config_read(d, &md);=0A=
+=0A=
+	seq_printf(m, "0x%x\n", md.u.mon_config);=0A=
+=0A=
+out:=0A=
+	rdtgroup_kn_unlock(of->kn);=0A=
+	return ret;=0A=
+}=0A=
+=0A=
 static const struct kernfs_ops kf_mondata_config_ops =3D {=0A=
 	.atomic_write_len       =3D PAGE_SIZE,=0A=
+	.seq_show               =3D rdtgroup_mondata_config_show,=0A=
 };=0A=
 =0A=
 static bool is_cpu_list(struct kernfs_open_file *of)=0A=
=0A=

