Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354EB5872A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiHAU51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiHAU4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:56:43 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC68041992;
        Mon,  1 Aug 2022 13:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtWW2r455YecChyFFSYHdZpNcL8zwQ3qkHEorychSuHwbwMY1lkXFXTY1/vaTRd43SgLrTIXz61ZJwJa497/CFQ04jgoxnGe/uFAnEVJ26VaQu6r+GCgGI4QlZmYIemvIGptQsO6oNVRi/yl5Ys5RLuu3YHA4BHX8gBpHXqdn/+lnvNAYY1S9eznFWUOdW3z9BfHWnKwULUYFgaE2v5EMUn5w1SRVvx+XoYqgEf38l7V4lUeINazMZgsLIPsb+uPUWO15itfDtV+iWkEBrBXCzpREGim39SdvThgT9P85bmQD89IC4CW+yKa+lrL/Ns2pD//SE+7oZHU7idvC5veOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3SDTR/kL4O1R4+mhUqund24vBhQUTOpem5bZn5n4P4=;
 b=gYNs/2AAmdBRMXpDnsQ38ZX/yN5svwdqikQsTyJplmVsZBxgkM5mmCQd9y/YTuAAUPMKUXrrStOS1PuBvacTnrWS7ZLuGZcFTtnVPykscN7lhEtPPiV1mqv41/wZxjQYrm/YxN8oMxPBIgreES+WvKmm0WAnk5d5xUWMVOKW9zi+My+Te92EuLMUv59LHduFa75xP8EyocXcoFGLV2cFaTjYBnjl/0lVtFCQHhD5G4n83x3GLdptEfz22pIM2ZiC/8I20kDxSmWoL8k/YU+rXaRwKs4+pl6PTWIeW6kf8/7UTp1UfXAI6VfzGa3JrxUTy4BpNdzewew/KHPf/M8fcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3SDTR/kL4O1R4+mhUqund24vBhQUTOpem5bZn5n4P4=;
 b=iO3XUvBW4DfPkLeJ1xQxJGzrivR1J2pe2bzXMRwOriaqk+6hHTnfZt6S1u474rq/lMl7XEAnk5aSGwY6H2iQmdOK3xPbXzLWCITVp1qOT7/3Ko2qr3fOP9s4EMnAfNYIczEYNIta+6k+QbVZPkCGsNAmuzzPc5/YBFoS2NyTbQg=
Received: from BN0PR04CA0189.namprd04.prod.outlook.com (2603:10b6:408:e9::14)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 20:56:39 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::ec) by BN0PR04CA0189.outlook.office365.com
 (2603:10b6:408:e9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23 via Frontend
 Transport; Mon, 1 Aug 2022 20:56:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 20:56:39 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 15:56:37 -0500
Subject: [PATCH v2 09/10] x86/resctrl: Add sysfs interface to write the event
 configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 1 Aug 2022 15:56:37 -0500
Message-ID: <165938739737.724959.9952911763036010551.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: 7ffeb334-7a19-4946-4376-08da740054b0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4498:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7kjce+xTpQ6jZ4b4ZCg2Ca0lg7MdyDvVJvdr2yDjmXNCcOSkalqUGT7c65ZVST8d7MluY7SzFnPmrm3dZegTkS3v50KhworCw6IPlmm1v1MhEcp9zUAHmuXGdMapOl35X/zqYthLMi4jnacfYKsNgapLI0MSPp0Ps6QtDEj67R69r1+j3tccrb72eOQMHC945+y0JKQvWfjMIs1Y+XsTQDl4pv4r18o2YH2fG9KatGwNyMPvughpK7Ni4ITNusJJ8VlhBWtJJplBn+COEUJxhDctElz/zoIdwYpV6SVVLm/nplog2PTiCVwM1iLueaoUBp1bzq2iyEm8Cg+81cdZugwnBPH3CmFwNU0CudDuCu5X/esdTubj0UFfWg6dsA9ThfcElOKCVsFgH3TqKJETWi0YptPWTpMj7M9TzmNzL5r5KI7BENLJTaPwbI+JAuSSI82cAsajSRYQsrnBj8JBW83TygQQbJH0SIML+ixnwt48YbHbJesnH48TkaUxgnsXASVcF+fEKeAaEJZEj+uV7ig6M4YfAwTP4DUI1LqB6FVkvzs+QF0JXMUGcqlKzBTDRINUphWJSKJvHF/rIHeHXPTcwNlsesshdLE0BqCCx/xTCD12tWVTqGxperYyMJgzPpPkRLbrnyZpZWKPg1Fr9391PFyY6cARAfkrtv/a93oFXraP5/4sybOiWh9ODXkTnF+tq4VmpcaNAvaGx3bp6l7QDIhK80TQ/rB01m8crpv+cgGuhUsR7Gvo5AG7Wiv+ROuLBrEw3kyLjPXakp7q5K/1broTAxup7oVOZQvg0XtFlMzH9GpOFvnyzE9hEt2QQxUTao4Oat8lM9bSeoRvw2Rd16/uyOEb9zgrfTJetI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(39860400002)(376002)(136003)(396003)(40470700004)(46966006)(36840700001)(4326008)(478600001)(70206006)(8676002)(70586007)(33716001)(36860700001)(40480700001)(83380400001)(86362001)(110136005)(8936002)(316002)(54906003)(16576012)(9686003)(44832011)(26005)(103116003)(5660300002)(186003)(336012)(47076005)(426003)(2906002)(7416002)(16526019)(41300700001)(356005)(82740400003)(81166007)(82310400005)(40460700003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 20:56:39.4443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffeb334-7a19-4946-4376-08da740054b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

