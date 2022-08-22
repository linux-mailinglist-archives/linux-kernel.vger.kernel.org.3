Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3059C0DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiHVNol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiHVNo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:44:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF2522BEA;
        Mon, 22 Aug 2022 06:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLtjwnSorT8GaGYrWweXlRD1ZaGZlCwrk3AOB4aEp5hrBZotpQUWPN0KJ4TuksAqPdpvW226UvvJacbxl8XfaZgra5Wa66gQZYJ50tJWnuZ2dyIOUTpAX+HUfpZ8wGVpXAYCR4zzXm96bY+RbzJd+miHQc6i2UoM6cppK+eZwNnJMVuOAU3rLk9/NpMPXvkln0ByJWMRQ+afH3plMfPlDKhtQA5SNceAuRV7PBMaKTkh3BLSqVQr6Ou39EAZ/mSkdkkJmYqviAJ44vH87jBnI4gJoMR3BJ/9ZPrH6bQPgGxErhnzvDImraIBVWPQtFs91kfvvXiHOzuE4NWICNwoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wtxi6rxr7VXwh2Yxe+u96QZm4MhKtXGMDz+IQeMsmQ=;
 b=PbPwtkmJzQ9U/AH1kftEu6OuTrtbMGFFCmI+0itgGaHmBDHl7v4lPxJ+66FNBR/E+y0+OOD/b6ZLDzLHV9AW1PH20sYkI8ceUSUo0WPUXAH5c2qG2oPcQFKIIs4Z1R7nuBBjZELI5xVXwvYXqj3vwRNDVdxe5X4RsfGBX97LB+N61wDeeJ2hS/cLSMVOnPnb5mCmGbxle5DnWBlGvNIrx7EfORkeZPDzz+rDv/a96oNGYIGhjaqpzHUi/6XRzr7uYiCdrZLx1C2T6nVQUX8ymg+8pYfwUvDKVM1C2RQkRj7APS/GgwMvEvNviRe16flMg9DoBD6ppXo1PbGyl+lEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wtxi6rxr7VXwh2Yxe+u96QZm4MhKtXGMDz+IQeMsmQ=;
 b=OGZN7TaAHucDCyilYaK3Eirvmjjlh/rpnaJSo3Wk59uWkqppEUvWUVuopKl/T5m15sTYffWxrqXx9XScm9YNgQ/PfITZdyaz0aEztg2XsOX/5xZIgAyNrWchusn3umG0G+ybwz1oMUTFvUTFTGQg99X513JCbaDpxdmduhThcWQ=
Received: from MW4PR03CA0039.namprd03.prod.outlook.com (2603:10b6:303:8e::14)
 by MN2PR12MB3870.namprd12.prod.outlook.com (2603:10b6:208:166::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 13:44:25 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::de) by MW4PR03CA0039.outlook.office365.com
 (2603:10b6:303:8e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Mon, 22 Aug 2022 13:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 13:44:24 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:44:23 -0500
Subject: [PATCH v3 08/10] x86/resctrl: Add the sysfs interface to read the
 event configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bagasdotme@gmail.com>
Date:   Mon, 22 Aug 2022 08:44:22 -0500
Message-ID: <166117586269.6695.16560984025494646306.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: 3378ef3e-d8ab-442f-6a65-08da84446d3c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3870:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52GvwyFfEvXyz3rOaiiqiY6KHbFLwuQf32ADQf76f19y+B3CLxKFM7GOuI8tSwtK8OjGuIOsO6b2ndrbMwG1gojuY4pEw4OnBvwqfluDs/zka70/B2FeIzVRU2m7XjdDNfr9HdMLLRX2v6OK8dFRm38zLaJBr2Zs0AyYAQRIb07j6nhgGhEm/4GsNoanqK4iVTWGI2LIN9Gqahq9e637/mYNYdzaPlSF+CxRHVZLjbaOVmjuWlxcoHpcSeH0BNhwHn2o3gAHTGWeDBNB5FCJnVqKWb8+SKyCj+mU0uIo29d/DnNqhGWU24FKoF/Sw8jR1OkYIasAf3zbplaL+3621wsmhUnCipbsN+yS7KG3zm2MAitFR2PT+/tg99FwsGW5ew2QvSgyhsQSNO8aom/eppoJgJYCljJ1F7bgL5WvzU1qmlswXeq21uPW6nqSUb6eu177yHxCGwzM3Cdw1cbVSEIsTbvGqp9Lo9woEwqB8f33IlqaquBZDF6tipa2Qh8aIBtPZIsOJyJMrRl5HaGYLIM+4hZZ0cp7MBpgwghFao7qgc2m5myMFyV2kUcCPob3IhPAk4/UIr1Ke7tY82O2lJsv8hcgx+UwGUV3JtFmhNVBgfQ7JIq0zbMoLwA3IIoJjJD5HQbmV0ionLb1pI6hGRp1W/A5weeXX0jq1MUqFBRDj2aquguoaEFFgMHL7Y//d4xngUAgERKM2IvF+AVCNQ4qLCwsVpt27pkqZSbSEJgU5A005k+EZkaScjfnIyWi/AGNTdGxtygipaxvEhvUDYNHxZEkXlPeVGROY/IcH76JlVJbdnUIZ2YRYJvKte3t95UIrjSltTeg2jryeKYfqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(346002)(396003)(136003)(376002)(40470700004)(46966006)(36840700001)(5660300002)(40480700001)(478600001)(83380400001)(16576012)(316002)(82310400005)(26005)(9686003)(54906003)(336012)(16526019)(110136005)(103116003)(36860700001)(66574015)(186003)(82740400003)(81166007)(47076005)(426003)(8676002)(4326008)(70586007)(70206006)(7416002)(2906002)(41300700001)(33716001)(44832011)(40460700003)(356005)(86362001)(8936002)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:44:24.9790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3378ef3e-d8ab-442f-6a65-08da84446d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3870
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
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
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

