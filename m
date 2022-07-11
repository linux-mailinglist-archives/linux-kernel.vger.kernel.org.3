Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2120570CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiGKVjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiGKVje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:39:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6F7868A6;
        Mon, 11 Jul 2022 14:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0Nm9DvNXLPDjm7ImWGAIrkxHe0FZ5BcWWtGa4hFJdN5GZ04aKqrA65GoBskc7ralGbLM4vXbBgBx8P992uKsnhdACNoUIa3aYQK3sYPF2SiBgZKV7ldp1jo4t9C3wP2y5tWaqvmV/KEiVPp+uc810c1Jt7ZovWMqTB6mnKm1ikUMqw6zQQxgKM3PdE9ChRQ0O01fZLMHORzqjdGUa73W5lWPiOwCNXDhNC9RDeEsp8PIQzvuoenN+xBLxpolMrf1bolWzx0ariK4OnamdTq3YfQYmB7DcUtSen4XYGKWzufjpZlNTf8zVgYqfFSsbrUizrVgeT+D+fbUknJ5L6Dkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dspl4qODCwlrLJJG6Z4doqnJIGvQjbJ4A4d4uYHpUxQ=;
 b=gXARnMqML4wvx6sRciOU3zZmR1g/1l62boE+sCMgcxvRSQLLfbpcVJZvcBowliTJb1hinlmJtupsFhL9hJ8XYH+3vMe3kP5Evcb4nfxsidGNnfoouKVG3DNHADtfX/nwQIxUGwJg7DaCAUrheDI3Kix2FcQRnR4eqWxJ2FhqJedwKSdhmnsel0ht8nG+KZRGo0aOwzEAqY/oSL1FSclARwct+T72fuLWh3PIdFFzYA/gUGIhqD2OrpMqntYebVmlftA3OjFdYkB50xhJh8wNnWwHyk20r0t9sqqVsKbrNRFRI685IZnRGULagni23GGw/KDUvAU4CVfZ58WlJyJNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dspl4qODCwlrLJJG6Z4doqnJIGvQjbJ4A4d4uYHpUxQ=;
 b=WafYHQRtyCDxI8lvNMxpqVncz/hKmB0661JqJaFFcofqUnWWtkeJu/SQ10skjhWM7GAucnxASYBI5a2OEG6bIF956bkXL3IsVUcwM2mQoXH8zNVMdghM+A/R8brxVeztKZ3iTa3Mkcbt4nI8QBBFN/85Zyyl9JTxHohH7aQdErs=
Received: from BN9PR03CA0395.namprd03.prod.outlook.com (2603:10b6:408:111::10)
 by MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 21:39:30 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::95) by BN9PR03CA0395.outlook.office365.com
 (2603:10b6:408:111::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Mon, 11 Jul 2022 21:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 21:39:29 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 16:39:28 -0500
Subject: [PATCH 7/9] x86/resctrl: Add the sysfs interface to read the event
 configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 11 Jul 2022 16:39:28 -0500
Message-ID: <165757556812.416408.9921153753932958176.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: 2e3abce2-42b7-444b-0948-08da6385d61d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4517:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZi1CXQyKbkcST2bo2jxmQF72oTiWUtQz3Lh9qUi5GJe0ivTuYBu2FSNUWsXM3h1ZjmT1YSiJWv5mlTWrQjv2i0pzlzQMdRGFDpVWlgVBikVIqdWkgsz89IGv/KexyKBj8I4MbynEq8N5D0WPsaUuA94dyr4S87at0ydTuRPDN5CPcqv7eNRAWfrCgqgUdwfjlY753WtuZEQm/wnMiC4vXc0MONELA+N6jm+OMXMkmn1k3kwUyqAR9XzNIiMVbx49hja8tH3FAS0/LrCd4IsMW8mEya3QL2JkvOVBIpJqDO7JOLetgZGJdGnteJWrkdqcajRzm5ZnYO0HF1R4XPrliGDqpefzs0WrhCq40Eviu70XisuXMJtd64W9kV1r7QODqtWvs8QSVTH9F2+wPTckygGvVmc1g9Emy62kLkQYU+K3HpJ8I344BFtgvoicvJBh414A4f24TXlCrYD8HNl5+0AlrG1pniQiSXUC9RDct5MGOqu0aYBndnFtWlLRJSCDIVomyXeUsvy6VKDGqpdK0WERsb31ULYO+kxJ5Ote42hhBHGhF1MoGDVoeRK9BWaQ+a551QLL91b6NIvJ8V2DyE43RxCktzum1BSYGahD3H1McCVJHHHebZF+0l9PRYoi1ekzVFqE5LPyWjXYJLqZwfNBTIG4ThC89HCmc5JEUF/suVW5gBnQ8nbE2RePe1OpSiiiPqE2MHoUhg7lw1ilpFStmIXTvnYz8/Y3iyDT8hKXA1HcObqd1Z8lhrMKZEO9wTaBG8YiMWxzevtKEYBLlh4DImlmMNvflUyAqstgBAO3c2I75nHHt42ye674dxrCAMaJIuzXR+xTeHTs7aXYkuUjOVdsvIXAFw4qKAp4ZAP6iL5RULepta4t7EU77tS
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(376002)(136003)(39860400002)(396003)(40470700004)(46966006)(36840700001)(82310400005)(2906002)(478600001)(40480700001)(16526019)(41300700001)(186003)(54906003)(110136005)(8676002)(86362001)(316002)(33716001)(4326008)(26005)(16576012)(70586007)(103116003)(9686003)(70206006)(7416002)(81166007)(356005)(83380400001)(82740400003)(8936002)(5660300002)(44832011)(47076005)(336012)(66574015)(426003)(40460700003)(36860700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:39:29.9748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3abce2-42b7-444b-0948-08da6385d61d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index aaafee112fa6..9f494ba463b7 100644=0A=
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

