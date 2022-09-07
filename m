Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCA65B0C0A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiIGSCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiIGSCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:02:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9CBAD97;
        Wed,  7 Sep 2022 11:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPYCw7kPmtFnjpEgHOkoUNHBuC+7kBzIcfME1y4j1imyPXXGQf0bCerSaCXjrQJ03OMCNFuydoMjKLOWBqobVrcOGYgjwYjL79HLdCBKmo3lEGJ69KCkkWj7XA7++9LTa0zJ2WWenTcso8LkRlXhtjbIwVD9cfK+pM6g0h7aHgNtOyyIhEp5VQkOo/sG3BdgbDgo3cK3okrZ3RvZBsBQii4g2aDVOzf6B/sHLmzftFDrd35TY9ilXAPT2AKGD6y2aMgDmG0IN7EOSOfAk9QatEj83p3ma/M8DB1at4JWgjb6N4OfdSOXbbJEGObyDnZmY4Z731WuMIkluamUFGORDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcJHzyqPzpmvzo5kjhjK8df8At8wBbzU3lSUJ+qaDfc=;
 b=dulybLL7Tje4CU/tC+qptPPZsZw5ybK8slYCIEyidYPBUQ9DM9jsmjt9hlW0qjwbUzaL8Pnnp2Ovt4QeectU0FjoHohAz5xw2/+p3GOnJ+Y50+AfTG7GFvMjD+mMYO1okqB8OVJvrWVwbhVw0CsZ1eQfxOpWtfjyxL1FtpfBCZc0oSVTA129AhumdE/TXlSoS479iZq3kNw77hy3JRzCOCR6COd8xnifHGwEOKC7PJEmAD2PYJNh/QBzfKbZuT7m3RaHRwedGlBAXIxgiyqc8ud41/IDZhrjDtK01bJ1BCWIfWciBvMsnT64LANSLqf/lONGLzmXUaWtXfl2+16bpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcJHzyqPzpmvzo5kjhjK8df8At8wBbzU3lSUJ+qaDfc=;
 b=fG/j+hpYloFAOEn8b5aE1spgTR5EGQVY0/Q9r5JscjshzOE5NRcHYGb0aFfUFZ6FBtn6DL/ovAmj9629GBnz+QclHnOjjj/EcrELRY11x/R38OxIp37cB3mGwMmRkurClEhoa2IFcjzjSZ8FQdyfUY6Nrt0AW1wVa+pRrZFMhcQ=
Received: from BN0PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:e8::13)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 18:01:27 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::52) by BN0PR04CA0038.outlook.office365.com
 (2603:10b6:408:e8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:01:26 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:01:16 -0500
Subject: [PATCH v4 11/13] x86/resctrl: Add sysfs interface to write the event
 configuration
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
Date:   Wed, 7 Sep 2022 13:01:16 -0500
Message-ID: <166257367603.1043018.15774268739007323339.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 039ec870-ccf1-49e7-ff3c-08da90fafbeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/8WuGNaSydR39F1j33stGzsyLkgodPiRBjorQW2BcbJgVWg9qOp84rDwCCvIgT27u635pI/yVQZwsYNvonxlG53qkquXbjs2kdFj939IQxzieXXTtSzXcgvSkE0iAYbGYdDD+1LCZMfp94K34Z2/dbB2p39DBtrJTmw/ygX3Gx/9VLnGM50sJoTUK/wxSqUAVK1OoEMKnVlVLY0gfVWQCXXTrw3QqPDoTmwJ9pNRayH+czAHPs9bFXnXlo92BHeDWJqhtbkY/JMDxBz6RS+zGSumCdDktXK/LYZ+VPPNZfgKRxCVf0Ao/qeI5jFdoLXMGCYkrLVNNyGXK3B9zqQoxoAVszzydhI0oZu0/JiPicWGAwsYNMNuZnSSxvwht+BeZSlyQx63w4Vfp2YpaGfKA/9VyiXJKnjGoRlWtfieWoAk2ZkDQiLU6QY/d7pweaxSKHOWdqZlPm4398YayeFkfJQyBLoZ7m8ngXk7MwoK5MRR8Vn9BneSMtaPVnJJWD7+m1seL35l7cS+wjnwqixvXnT5evTMcYEeSNeVLEBS/aG8AWxDyu2P1FOdcAFSGxmWN45u0LmW7/7GfmNt4raviPnwLl/iCFpjSfHa4THySAuPzdOwhj4+XeO17wuTSw1ieEtL1kk+jYweGSmsYjT4BAdMvCGkWG08yh9CeQKvrHgnDtC5HdtUqE3d6pn+Yxg86XNYJKuyat//DVHIuLgZmnAIsgQP5NzXtatCIHiK8aXNcYtKeI2yFibSzIqTv8uo2mYw6R1L91y+JNheRquqh4VuYqDXjIRnBWFTJE9qawwoYe6wEXqvl6zHNvQfUIFMS0lqBjISYA0uubqSkf4iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(396003)(39860400002)(136003)(376002)(40470700004)(46966006)(36840700001)(54906003)(16526019)(47076005)(186003)(82310400005)(336012)(356005)(426003)(110136005)(36860700001)(82740400003)(40480700001)(83380400001)(316002)(16576012)(8936002)(33716001)(26005)(2906002)(40460700003)(41300700001)(9686003)(4326008)(8676002)(5660300002)(103116003)(81166007)(44832011)(478600001)(7416002)(70206006)(70586007)(86362001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:01:26.8492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 039ec870-ccf1-49e7-ff3c-08da90fafbeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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
Following are the types of events supported:=0A=
=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits    Description=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6       Dirty Victims from the QOS domain to all types of memory=0A=
5       Reads to slow memory in the non-local NUMA domain=0A=
4       Reads to slow memory in the local NUMA domain=0A=
3       Non-temporal writes to non-local NUMA domain=0A=
2       Non-temporal writes to local NUMA domain=0A=
1       Reads to memory in the non-local NUMA domain=0A=
0       Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
By default, the mbm_total_bytes configuration is set to 0x7F to count=0A=
all the event types and the mbm_local_bytes configuration is set to=0A=
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  112 ++++++++++++++++++++++++++++=
++++=0A=
 1 file changed, 112 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 6f067c1ac7c1..59b484eb1267 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -330,9 +330,121 @@ int rdtgroup_mondata_config_show(struct seq_file *m, =
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
+	struct mon_config_info *mon_info =3D info;=0A=
+	u32 msr_index;=0A=
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
+	wrmsr(MSR_IA32_EVT_CFG_BASE + msr_index, mon_info->mon_config, 0);=0A=
+}=0A=
+=0A=
+ssize_t  rdtgroup_mondata_config_write(struct kernfs_open_file *of,=0A=
+				       char *buf, size_t nbytes, loff_t off)=0A=
+{=0A=
+	struct mon_config_info mon_info;=0A=
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
+	if (mon_config > MAX_EVT_CONFIG_BITS) {=0A=
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
+	/*=0A=
+	 * Read the current config value first. If both are same=0A=
+	 * then we dont need to write again=0A=
+	 */=0A=
+	mon_info.evtid =3D md.u.evtid;=0A=
+	mondata_config_read(d, &mon_info);=0A=
+	if (mon_info.mon_config =3D=3D mon_config)=0A=
+		goto e_cpumask;=0A=
+=0A=
+	mon_info.mon_config =3D mon_config;=0A=
+=0A=
+	/* Pick all the CPUs in the domain instance */=0A=
+	for_each_cpu(cpu, &d->cpu_mask)=0A=
+		cpumask_set_cpu(cpu, cpu_mask);=0A=
+=0A=
+	/* Update MSR_IA32_EVT_CFG_BASE MSR on all the CPUs in cpu_mask */=0A=
+	on_each_cpu_mask(cpu_mask, mon_event_config_write, &mon_info, 1);=0A=
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

