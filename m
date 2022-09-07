Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7244B5B0C07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiIGSCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiIGSBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:01:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3D1B531B;
        Wed,  7 Sep 2022 11:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEeYi52aQRteOCpQspqR9FZn37d6Um68XBay99e9n4z/SZeztm512ZJ7V9cOeI7MFA+gU5Di5AlOt+FNbKGvNWylne+Ehb42FMeWlCLAo23oevu0Mj13qKS4Es6BNXmvQoVfZ29pnctGmeMS+C3XiGwvm/gW2bU5LTnYyYY5UFZ3c3PGrVOxn6ySwCpUpatqRUPgaK+ayK7azUv3Iq1FaSdYJcD4FXSMEGWAyLXpY8sbrLU+GoPad+cGoKtxNH0BfqmZPAfaFmxQUJxeSBx3WYruWhr+gi1DF2ZxKj6/dbQPqRTXWhjis5RycvwGO9lShh30VggWfEyjloyc7gWg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51h14UboifHH/gPPlyu5dVDAZwkObI6EANpnvaQTpSQ=;
 b=oRICPkReQOTANiLj56JN76VpPYbd48JQnIInfojTqYSH9nBmxowyFctD3W3bFYqKdR9i3v4hrKA6oQJEYOIuHi0P4YsUJ8p307gbjxetO5vR1HGRpsC5M2pT/5pXY7bzKKm+FTCGtyTmp1YUfRmil7v7sZ7Taiq5FZoAnnPBOguPaz6VQmoVXjwnQeCVk0mZFnlt1jbpM5ER0tOtVdqaYwM9XyuOI3Ghi21CzzImJcGCSkCCuwou4Nj3pZhok6FwiDbFag3npxnej9AqYYD4+77KPT6diKTLD+iiU2jIRMGB4/X0kT3/18IncOXkaASDmIF5C710qq8kNToUYU3BmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51h14UboifHH/gPPlyu5dVDAZwkObI6EANpnvaQTpSQ=;
 b=ZTlqhyKB6re/9vxnFRC9bIWR3zJ4HS6ZD6fbKac0fm9rL/vs4Etyxig4QwNpMseUHuoTW9cdaIQ3LWrQb3itQwlGOVfWVQT2CNfkyuCktkoIhPmvnBL0Ig1Pi5IVqmXTwcaXX2Qp18a/2Kn84RQHibuFWoFzNLdaD7sRPD8V2ic=
Received: from BN9PR03CA0515.namprd03.prod.outlook.com (2603:10b6:408:131::10)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 7 Sep
 2022 18:01:11 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::ba) by BN9PR03CA0515.outlook.office365.com
 (2603:10b6:408:131::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 18:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:01:11 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:01:09 -0500
Subject: [PATCH v4 10/13] x86/resctrl: Add the sysfs interface to read the
 event configuration
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
Date:   Wed, 7 Sep 2022 13:01:09 -0500
Message-ID: <166257366902.1043018.16087054015308149859.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 19499cc3-e96c-4921-e4ab-08da90faf2c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6qXJTfegNTj2bmFNTrg0PgN8NMwf/ZguSrxsylpQxNLwKG/alqLUTdkn+E3x9WxZO1Os2DEqbAKpsHy5SzHyJsxM22Gg4e70lqI0j1sQ6cGtuYUqiLkz0X3foODAdz4jQarMk1wuF8RGCdlAsIei1aBJmTItIgCZKECFWAeSwkL8fN/kETlbQmaL5Mkbi/u7RqRhIjJuOIV9dGaJr7ldP1FcvzTseM6hwzT951dE523ZSmH/3jaj8H1Rrd+77v/iuGWLQROGVyMGSJbAaMppOkn4rhMZcwiXQt70VLcjpYGRBuwoy9Q9C/ixS1ACye0hHQzHaCgRaLMfVHqbVS6osBey10MIsjF1UqHAAjCwcOo45cHlLqZBmD8vzkGH3mRqm20blFMBmL6qbvm9Q/j4xT757SCOp0aV/WQmKpJvZef9E15FR3PqP2t/ZihVJ2aELtztlUMxkAuUsV6jD7cv7Wt7teNkmAXu/AXMaPT6kuh0HswUv9ioYu/mG938ZsXSC/9U9DHn/hZ+GxjjeEmVjqHH72i0Z22h+noVz/UkX8FplLbSJ4FnmTyDeXoxEU8VEtc46S2H4bb0ER2XfeIRQAMcir6jyQwuRDc8tAnCLiYGl/tl8ZhueqHmU1z42E4J0M7Ir3ysFlYfvNyd6ECzrJu/WUn8U8Q3uhRqQzJIJqlVJ9AtORzNfocVMoW5cJ1tD2chaLzZ4MTQhlaeEKaeFBDfDR0u8FR2D3dK0YPuANUdUmZ4a/6AkzJVLJeQVJKz/02sU5CZbRoKMb+NbVNWW7OWy7i4zncy1x21XEBSQ7Vfm7CoIOybNPIG8KtBwjgPeO72espWxhmWHvxDpukVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(40470700004)(36860700001)(7416002)(40460700003)(16526019)(5660300002)(26005)(8936002)(40480700001)(186003)(426003)(41300700001)(103116003)(47076005)(81166007)(44832011)(2906002)(86362001)(9686003)(336012)(33716001)(110136005)(478600001)(54906003)(4326008)(82310400005)(83380400001)(8676002)(316002)(82740400003)(16576012)(356005)(70206006)(70586007)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:01:11.4909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19499cc3-e96c-4921-e4ab-08da90faf2c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
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
Following are the types of events supported:=0A=
=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits   Description=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6      Dirty Victims from the QOS domain to all types of memory=0A=
5      Reads to slow memory in the non-local NUMA domain=0A=
4      Reads to slow memory in the local NUMA domain=0A=
3      Non-temporal writes to non-local NUMA domain=0A=
2      Non-temporal writes to local NUMA domain=0A=
1      Reads to memory in the non-local NUMA domain=0A=
0      Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
By default, the mbm_total_bytes configuration is set to 0x7F to count=0A=
all the event types and the mbm_local_bytes configuration is set to=0A=
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
 arch/x86/kernel/cpu/resctrl/internal.h |   24 ++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   77 ++++++++++++++++++++++++++++=
++++=0A=
 2 files changed, 101 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 45923eb4022f..96f439324d78 100644=0A=
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
@@ -50,6 +51,29 @@=0A=
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
+/* Reads to Local Memory the system identifies as "Slow Memory" */=0A=
+#define READS_TO_LOCAL_S_MEM		BIT(4)=0A=
+=0A=
+/* Reads to Remote Memory the system identifies as "Slow Memory" */=0A=
+#define READS_TO_REMOTE_S_MEM		BIT(5)=0A=
+=0A=
+/* Dirty Victims to All Types of Memory */=0A=
+#define  DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)=0A=
+=0A=
+/* Max event bits supported */=0A=
+#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)=0A=
 =0A=
 struct rdt_fs_context {=0A=
 	struct kernfs_fs_context	kfc;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index da11fdad204d..6f067c1ac7c1 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -254,8 +254,85 @@ static const struct kernfs_ops kf_mondata_ops =3D {=0A=
 	.seq_show		=3D rdtgroup_mondata_show,=0A=
 };=0A=
 =0A=
+struct mon_config_info {=0A=
+	u32 evtid;=0A=
+	u32 mon_config;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * This is called via IPI to read the CQM/MBM counters=0A=
+ * in a domain.=0A=
+ */=0A=
+void mon_event_config_read(void *info)=0A=
+{=0A=
+	struct mon_config_info *mon_info =3D info;=0A=
+	u32 h, msr_index;=0A=
+=0A=
+	switch (mon_info->evtid) {=0A=
+	case QOS_L3_MBM_TOTAL_EVENT_ID:=0A=
+		msr_index =3D 0;=0A=
+		break;=0A=
+	case QOS_L3_MBM_LOCAL_EVENT_ID:=0A=
+		msr_index =3D 1;=0A=
+		break;=0A=
+	default:=0A=
+		/* Not expected to come here */=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	rdmsr(MSR_IA32_EVT_CFG_BASE + msr_index, mon_info->mon_config, h);=0A=
+}=0A=
+=0A=
+void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon=
_info)=0A=
+{=0A=
+	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);=
=0A=
+}=0A=
+=0A=
+int rdtgroup_mondata_config_show(struct seq_file *m, void *arg)=0A=
+{=0A=
+	struct kernfs_open_file *of =3D m->private;=0A=
+	struct mon_config_info mon_info;=0A=
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
+	mon_info.evtid =3D evtid;=0A=
+	mondata_config_read(d, &mon_info);=0A=
+=0A=
+	seq_printf(m, "0x%x\n", mon_info.mon_config);=0A=
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

