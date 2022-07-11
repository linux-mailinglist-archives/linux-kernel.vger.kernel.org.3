Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D00570CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiGKVkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiGKVjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:39:42 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C5A83F0B;
        Mon, 11 Jul 2022 14:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRTpw0A4hml+b0vwrUWgmKIUbSJV/kGjqPGFyCoCX363Tcfx52zUT2+TG0UhpGjBvKsIZntaKM/xgk0TIwDIKXYV8FvPi78e+fu8Z4UlfcTnPA3OmYjjXXjGLXusJdzQ+7MKUP7fM3lXl4+OE9So6PFsOOuGhBRvX+JErq5B4GHuT/WT44aYa0o2pPzb0RWPgw2IX0NhQy28vVUMPMYaJ3KSH14CCxEtK2ERic9QiTvt6zSMft4OOlfBp/Z/k2XKNFbFhNnix2sH4sZu3l7hEgrkeetVkVw8Als/8VbzYyUanLuMDoEz7gPpXE5PtuSpATEchr2nhVqbZIM612ShFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3SDTR/kL4O1R4+mhUqund24vBhQUTOpem5bZn5n4P4=;
 b=CF1TFWsh2Cckq9VTwjeurmkFOhQKzh5QX+jXwsYFtoazekX+Sp60dDFkZzVi8HEKW45C3m53Q7mPGNwqFO2Z0bRcIEQIWJaeaqhxxhwzuJ4drsi4P+nq2mXUjnWo0sQmYYeUo4u71+4agPVlOnPcUvp8VKByxGdZzSmBoPUZNucmjKh+5vFJbXDJMpvOAvbHEm1Msd32IdlkhoCo2LC516eRzTRd3aKOm2607ewv9m33WgvSOKQqSsWbN/vEnFh0ZA5KWQe0Su8dBKWpG0q197Uzk/aWNBrouwvbzyfIt5sZmV29ZwY1hpCbVI+SmInUesDgrg/Rhz97V04j4O14aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3SDTR/kL4O1R4+mhUqund24vBhQUTOpem5bZn5n4P4=;
 b=BDMIQlR3wp15tyzpvNQqcHPykKOh/vicf1KuqxW5W8ddoGb6y1MKngVphXdYY+vfJQkmKBd0ljFOC8SRJBe6t0DS5bsXTZCXZA4kyUpCn/XeEAXkUj4RGsNIps3vKfp1P8nYYFz+ZmscW/AUm+4ZZ8ReHoj/feTnmpm2SwUaWy4=
Received: from BN9PR03CA0356.namprd03.prod.outlook.com (2603:10b6:408:f6::31)
 by DM6PR12MB3866.namprd12.prod.outlook.com (2603:10b6:5:1c6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 21:39:37 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::fd) by BN9PR03CA0356.outlook.office365.com
 (2603:10b6:408:f6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Mon, 11 Jul 2022 21:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 21:39:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 16:39:35 -0500
Subject: [PATCH 8/9] x86/resctrl: Add sysfs interface to write the event
 configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 11 Jul 2022 16:39:34 -0500
Message-ID: <165757557476.416408.6689961473424844894.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: caed0c50-cee8-41f6-8557-08da6385da34
X-MS-TrafficTypeDiagnostic: DM6PR12MB3866:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3VbuoDjxf10lmZ8HclP76pe5SZp2nublnMLbpnnPj8bUs0LliK+2ElJ4KNXOwP2e3CD0t5n79gw1gGpC1c1hG2yUf0QfeTUzbcBlkAyR60apLDPG//8SWx7asqiyXP4oeChGIu/wA26I3VCWdpesVva17JFyp4akFzs1VKS6DckiHyaG093BxrYzc+27P0j0GjPzlC7ZDW2SVuK0NGfzkQ7/lkQCt/GOfTocYJGqVl/R5OTPbhZN9u+/EAnI0U3ZyOL0GBXyAbr6EGDNMa+J0iXxiB/H6rqTmOjMYwig+YFSBnxNGqd+CaLRlb9gLl+GmAETry4dWStaAWuq/0OS5kIvYjuSwyD5HjBFOeAFaM4C+MFTGQZBouF6swTeOm7dxW2Zf1gm5pdz76FDTpQMQbMlmSPBeJPuMxUIGtOM2jP9M/3noGg1mAh+CJ3xYwhJgxgDBcem8rUORRxB+dusY3vVFPTBdEXxbbPSvZHiAZaDCQ66whbTiJSt6+9NrhUZFecyNARD4RZEs1ff6NP7WZW1Kvb8sgxA8V9HnncarrwPSizRY1pFUkfMPDaLZ1cetYxBjPSFeQG7rseu4wGzMwUB/tUjaeJV7v5p/d/c/xS6v0atd5jrUGU9Rs+baMOpMKfy1wCLz64fi0GCgMMk6WBzvli/voR5HpE1LaXuQMMDrT8gH0CL3yTyIqvnLLg6roUmPIT4StV4A0PPN7Z2s6u1Lf8B+F1Ta15/JeW02tfWmlOpro3zCXSsDYR5dcMnR+HVlLhgYtJaOytRvJl/TwXdoaVA5YJrWE6BLBzkqkRJWgY22tSYPVzuFTLhRQnmU5r+LIVPKC4YxhGW3JXmrMYWP3LKaCuSAdDc15t7HiEx/J6Y+Vqp6LnQM3HjqQwQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(40470700004)(46966006)(83380400001)(316002)(16576012)(70206006)(26005)(81166007)(70586007)(33716001)(47076005)(110136005)(54906003)(8676002)(40480700001)(4326008)(336012)(9686003)(186003)(5660300002)(16526019)(82310400005)(86362001)(426003)(82740400003)(2906002)(103116003)(478600001)(44832011)(40460700003)(7416002)(356005)(36860700001)(41300700001)(8936002)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:39:36.8240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caed0c50-cee8-41f6-8557-08da6385da34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3866
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the sysfs interface to write the event configuration for the=0A=
MBM configurable events. The event configuration can be changed by=0A=
writing to the sysfs file for that specific event.=0A=
=0A=
Following are the types of events supported.=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
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
For example:=0A=
To change the mbm_total_bytes to count all the reads, run the command.=0A=
$echo  0x33 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config=0A=
=0A=
To change the mbm_local_bytes to count all the slow memory reads, run=0A=
the command.=0A=
$echo  0x30 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  109 ++++++++++++++++++++++++++++=
++++=0A=
 1 file changed, 109 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index e1847d49fa15..83c8780726ff 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -323,9 +323,118 @@ int rdtgroup_mondata_config_show(struct seq_file *m, =
void *arg)=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * This is called via IPI to read the CQM/MBM counters=0A=
+ * in a domain.=0A=
+ */=0A=
+void mon_event_config_write(void *info)=0A=
+{=0A=
+	union mon_data_bits *md =3D info;=0A=
+	u32 evtid =3D md->u.evtid;=0A=
+	u32 msr_index;=0A=
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
+	wrmsr(MSR_IA32_EVT_CFG_BASE + msr_index, md->u.mon_config, 0);=0A=
+}=0A=
+=0A=
+ssize_t  rdtgroup_mondata_config_write(struct kernfs_open_file *of,=0A=
+				       char *buf, size_t nbytes, loff_t off)=0A=
+{=0A=
+	struct rdt_hw_resource *hw_res;=0A=
+	struct rdtgroup *rdtgrp;=0A=
+	struct rdt_resource *r;=0A=
+	unsigned int mon_config;=0A=
+	cpumask_var_t cpu_mask;=0A=
+	union mon_data_bits md;=0A=
+	struct rdt_domain *d;=0A=
+	u32 resid, domid;=0A=
+	int ret =3D 0, cpu;=0A=
+=0A=
+	ret =3D kstrtouint(buf, 0, &mon_config);=0A=
+	if (ret)=0A=
+		return ret;=0A=
+=0A=
+	rdt_last_cmd_clear();=0A=
+=0A=
+	/* mon_config cannot be more than the supported set of events */=0A=
+	if (mon_config > GENMASK(6, 0)) {=0A=
+		rdt_last_cmd_puts("Invalid event configuration\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	cpus_read_lock();=0A=
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
+	if (!rdtgrp) {=0A=
+		return -ENOENT;=0A=
+		goto e_unlock;=0A=
+	}=0A=
+=0A=
+	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {=0A=
+		ret =3D -ENOMEM;=0A=
+		goto e_unlock;=0A=
+	}=0A=
+=0A=
+=0A=
+	md.priv =3D of->kn->priv;=0A=
+	resid =3D md.u.rid;=0A=
+	domid =3D md.u.domid;=0A=
+=0A=
+	hw_res =3D &rdt_resources_all[resid];=0A=
+	r =3D &hw_res->r_resctrl;=0A=
+	d =3D rdt_find_domain(r, domid, NULL);=0A=
+	if (IS_ERR_OR_NULL(d)) {=0A=
+		ret =3D -ENOENT;=0A=
+		goto e_cpumask;=0A=
+	}=0A=
+=0A=
+	md.u.mon_config =3D mon_config & 0xFF;=0A=
+=0A=
+	/* Pick all the CPUs in the domain instance */=0A=
+	for_each_cpu(cpu, &d->cpu_mask)=0A=
+		cpumask_set_cpu(cpu, cpu_mask);=0A=
+=0A=
+	cpu =3D get_cpu();=0A=
+	/* Update MSR_IA32_EVT_CFG_BASE MSR on this cpu if it's in cpu_mask */=0A=
+	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
+		mon_event_config_write(&md);=0A=
+=0A=
+	/* Update MSR_IA32_EVT_CFG_BASE MSR on all other cpus in cpu_mask */=0A=
+	smp_call_function_many(cpu_mask, mon_event_config_write, &md, 1);=0A=
+	put_cpu();=0A=
+=0A=
+	/*=0A=
+	 * When an Event Configuration is changed, the bandwidth counters=0A=
+	 * for all RMIDs and Events will be cleared, and the U-bit for every=0A=
+	 * RMID will be set on the next read to any BwEvent for every RMID.=0A=
+	 * Clear the mbm_local and mbm_total counts for all the RMIDs.=0A=
+	 */=0A=
+	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);=0A=
+	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);=0A=
+=0A=
+e_cpumask:=0A=
+	free_cpumask_var(cpu_mask);=0A=
+=0A=
+e_unlock:=0A=
+	rdtgroup_kn_unlock(of->kn);=0A=
+	cpus_read_unlock();=0A=
+=0A=
+	return ret ?: nbytes;=0A=
+}=0A=
+=0A=
 static const struct kernfs_ops kf_mondata_config_ops =3D {=0A=
 	.atomic_write_len       =3D PAGE_SIZE,=0A=
 	.seq_show               =3D rdtgroup_mondata_config_show,=0A=
+	.write                  =3D rdtgroup_mondata_config_write,=0A=
 };=0A=
 =0A=
 static bool is_cpu_list(struct kernfs_open_file *of)=0A=
=0A=

