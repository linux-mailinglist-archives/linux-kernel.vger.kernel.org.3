Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398BC59C0E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbiHVNqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbiHVNpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:45:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D317B2A955;
        Mon, 22 Aug 2022 06:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZqpGkhpYDSLAabDTD+P3qio89ToZgenOAalSeYenweWtF+IGXrGzrunEDK3GoxCqlqt39ONL4gH25VN8BtSYqL3Pf90JhaqtZrMVG2TvTjGJsMJn5VleBCBysUCh+oYI01EXRHnnQrB7rrJoeBy97J2QEEPXPUSbVNmZuglVHJ5mZLDoCanmt1j/aksVN0Ynuwh2uVkENxXs76ptwufWT+mLmSEsGNo4CxLeIpipRhd0B9pdLfjz2ZZHG1X2xzTKM0SJQOrW9trYHwoIVOd2qB6Iz1i2JOu0ivJvrGslQA5UyO6bw+FJDRSWIrcefFuW/yDx13u8bZ/miQ89ROAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqKH1YBAzRMx5YEC96DOtTQPhLcdAiGdNoZmJ5VT2rw=;
 b=M7eyjbq3LmSEIODjz0qZrz0eWxFoQj2/IbxL2A7IBb8talWAvtQ4W9TgLom4Yl3C/LAAQ8ndD3VRWR26VUzitQf04HtkjzvaNATb1P7Je1atDldom9pghJRg3Ki996mayKeWYGuFUZDjFFcn+SSmtFAdZCtmmpec3hqukL1RWKivQ3xDhDzsVcxp86pZ+1Rctl/xjnOaeBfc7ZcTS+ippeFa7+tIWj5OLsATlEfwn9NUOx9qCXueyemPzyi9BlpM/OxQGUm+doDzIT2vJl2n0kX8aRjOoh+lgJvLAaDOAnoxRrs0SST7rXSRK3YKlT4lMK1t2yS3xjH7LkfC8bWrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqKH1YBAzRMx5YEC96DOtTQPhLcdAiGdNoZmJ5VT2rw=;
 b=KGB4tmlEifWsniHAUma/PrOi8VCAwLpdOMbpcoJ8MCMWW3bI6GQF2+7KDDYMTCOjP5k3vwlcVEoHPawjC2zOUYLHfOdZw9WXvunafOs7Bfyq6bLzB3CpegeajXehTIzh9lHGvHOHEFPXlqke5y1/oAawIh31rWBWHWxDrnF/K4Y=
Received: from MW4PR03CA0334.namprd03.prod.outlook.com (2603:10b6:303:dc::9)
 by DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 13:45:07 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::93) by MW4PR03CA0334.outlook.office365.com
 (2603:10b6:303:dc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19 via Frontend
 Transport; Mon, 22 Aug 2022 13:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 13:45:06 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:45:00 -0500
Subject: [PATCH v3 09/10] x86/resctrl: Add sysfs interface to write the event
 configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bagasdotme@gmail.com>
Date:   Mon, 22 Aug 2022 08:44:29 -0500
Message-ID: <166117586910.6695.3670808098195387542.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: d9e7bade-7cdc-454d-d0a3-08da844485fc
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8qZ3fHS8dIFfwKDlUmpNmLOcMhuGaEXTS8/exE/YA7lGIX5mHOZZEeZjGA3gIgp0mAg2ffcl1+K9zLYktML38yKx7OpHafl0Hs/M6+a+Yw1yGTE+52Qam5f/7EoO6OX6IqIyL5we1kkBmPXbOaab7Mlhxc8dfiRj+HH2x6m6rnEk+XC971Qw4g6RLeX2e4frqvMJ2QZDIbqBdNt53r7Z1W4XM0AAq+bxzF1RNdRtmvIChAE0Re6xIGcPNEOrbNiDYLeyg7JKiKrJwXH2xUEXDiWeaZaSGjsdz33fn12Dp+Nlbic7qwYvBLLFWm3ZG4J0m2eiEFk4K599LuyZy2PbRsTcPz8ZYoOkXw+CFW/gOoiKetk/W61G3GrRykXTTOSgBhR6M2oWzYiPnIRURHbu158AqfEfoh/CWhl0Uwnnz6KP+IPae5aVlVh/6M4wiSa4ICmHAmlCNvwKHipSGDjo/oKN85N04frSvdHFCMwP+Cea3g/8kCMSKGQIKtG+tiNURZ0F8fgdQiuIAEOZulqiUX5+Eu5usWd4Mmx6vvDXSbxx2zK8RKzx4ks1A0+gvrq3TbLMoNOSsQDvHw/iXuX43f5FjwV7HBen4pBCO2TLdCzGYxCVlkapEA4qrBZtlHYV7rcUPxoIJ+WOGbQEUn00Ug0KpsDJhoXNqxMVDUQqaNVe/QrJySRZZ8QDiiv1+M5TQnmU0n6ExiziOxdIAXwcjAsq6ophD44KWYokQ0aPvz+vDKcXi+paqOiFv3fKAyLuhkFS5Qo1lrIzLXWFBb/yIHsJmxl9j0eSiHLF2zrSsUz+AwVcxmbujSnVqI+I7K4hfjn0uYYZDVgMmn8BBYbqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(36840700001)(40470700004)(40480700001)(478600001)(83380400001)(16576012)(316002)(26005)(9686003)(82310400005)(336012)(16526019)(54906003)(110136005)(47076005)(426003)(103116003)(36860700001)(186003)(82740400003)(70586007)(8676002)(4326008)(70206006)(7416002)(2906002)(33716001)(41300700001)(6666004)(44832011)(40460700003)(86362001)(356005)(5660300002)(8936002)(81166007)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:45:06.5208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e7bade-7cdc-454d-d0a3-08da844485fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5248
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
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
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

