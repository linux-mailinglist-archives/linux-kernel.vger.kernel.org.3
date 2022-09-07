Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B14B5B0C01
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiIGSCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiIGSBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:01:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17173C00E4;
        Wed,  7 Sep 2022 11:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdRsRN38AeBLyRg7fFAcoVPwQjKY567tcHnKiITj2Y+nzqwK6Lnxr2UGAAM8x6neu0DN+nXXl/nel1VoBtl+dEGrveZcdA0n5k50BYR6y67mOpdI6pg9UI95pCrnJRK8KI5N6F86fU6Bt1+YPl06gllTx2QrflkqaXLfRA50QHcHGFRYz7xP08en2f6SLI38MDGTTsnYmmuSMMQ4OhGD9uskcSKTm+56AIorZ1EQz5Ez/4ZEU8aaJC7xfAhllBdvsnB4Z2Fx3mNPR2Rp5ymCbhDg3Vab/aAyszjLyRVpGwPGgxu5rzyucsA/bfMpUogZ+297YZeuyBaYsX+qd69Lyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkjkVEFkiny/G7rUI7zIkimBF7tByGQXpTTymY4k1Es=;
 b=mb+5nYShNLw9IOFplzlhDzYkh58c6k3DGVCe4w1yz0nl2puIj16N6fATcxHcJVOEQNGLFLOzo3DPs882lC8qSWDF26GBgOLfnKTb2GieOxBIg17qkO1feWjE//2ZzKhRtT140EHZFbxP+6Ve/PZ9hsYyLGBUHeZsyHZNSVxXscuNl35cwnWEj7Axpf4XG6WGiAJ+97+7XLYHGTMYGjOZLVHARC0aV8I/JaNVGiTsCXPVmYb1oBMrnnIlytpdz0lLJ9vVv9aNDbPROHzwrfcxVD7gLW3YeQUOe10Yy7YlW/OcXGIut7t2zyfWfx2jiyu5y6VLtiAqx/cw9g5gzgMdsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkjkVEFkiny/G7rUI7zIkimBF7tByGQXpTTymY4k1Es=;
 b=3e9sgDauKoeICXo2g+tzUXPJWLKu2Tpn50NXM9mUQqsWwz04tlqKPnw9gcagsYhk0fU98zi4kGJMgpzRqgcwPVAU35k3s//zphDNNYlPhREfGYjqYJoNqBbgLFH7YRe7QFuTbnv0+YSaOY+W5WFLdteqw2PLdjxrf4krE+uQhCo=
Received: from BN9PR03CA0532.namprd03.prod.outlook.com (2603:10b6:408:131::27)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 18:01:07 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::70) by BN9PR03CA0532.outlook.office365.com
 (2603:10b6:408:131::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
 Transport; Wed, 7 Sep 2022 18:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:01:07 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:00:55 -0500
Subject: [PATCH v4 08/13] x86/resctrl : Introduce data structure to support
 monitor configuration
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
Date:   Wed, 7 Sep 2022 13:00:55 -0500
Message-ID: <166257365519.1043018.5600209070890797172.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: f04d9356-1b11-4a99-f89d-08da90faf047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECR7UchZAxERG31ZpN06Pp6OVegQvH1c5J6IRLb57evmedyzjPaeprybsuprz1fSF/i7leRlZUfKk5MBXFx81tqHi6Q6IMuZO6QX4q1+s4M+UWrUU+MxQAdCV0st1jbpCtLdXx+jIr36BSIe/hpUOUJ6bpSTmOnwtG2s6d6YyiS8yacMCPljo6sWMV7pXrtm/KEDV+PNPf3/2mvfJSEmHsFAyhxuccfuSKNkYR+AihthfYrsbO2O5tj2YkKn/+iEi2aZPoWA+InBT2K6N2vwApO0SQ9ic0fqAnE8TKmWoIqbvTrqLda64gtDuiC7jdUwhGkrsWC2PVfu6SIunlReFtldC+Pj6YMcHL9YJfRLloQEi9o19KsDmlA5SB3hhyXNuSV50LB+/T6/6zeqTmeGMIijhh/hFXcTZkKBBRoK/1gqW1isdlxHY+ROJNbNjsgtXPPDSQO8kvKRv5/MTshHLcNDo0AMs4oHcNTj8nGZkXTMbtNxVxmasw9SqsQQErZ8mKRl9FWNS3W1TiUF+ljvT/KQHeYd4qahDvd95Ny0D/ZkUcr/qZMmeIBbVTZei3GGxjRjztLFoZqDQaEoY+z+cwjp8KetGOgwOZOhRXEC+0Yr2MVwoP4zG7HykV/FYfyBFV1MnSQLCyL2vZB5wPzBfc0NDq+tNSL4LxcUgQEmYgInhCDhgEvXRkE6hP5IGXdXkbi42pcAlC1ix6BiDS7RXZ8G9nrgexxdK5vojbI67NdY4+AYZ6+W7R7se8y+JAR3L0J2sTkp2KKzA1L1xtvIpXDIxsAK6+NNEIMezM9xKswomkVzOj3cUPvexXSsEJwkd5HqNYW1poF0k+ViA4l1GQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(40470700004)(41300700001)(9686003)(8936002)(2906002)(83380400001)(5660300002)(7416002)(54906003)(44832011)(26005)(86362001)(16526019)(47076005)(426003)(336012)(186003)(103116003)(478600001)(81166007)(40460700003)(40480700001)(356005)(316002)(33716001)(70206006)(16576012)(8676002)(110136005)(4326008)(82310400005)(70586007)(36860700001)(82740400003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:01:07.3193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f04d9356-1b11-4a99-f89d-08da90faf047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add couple of fields in mon_evt to support Bandwidth Monitoring Event=0A=
Configuratio (BMEC) and also update the "mon_features".=0A=
=0A=
The sysfs file "mon_features" will display the monitor configuration if=0A=
supported.=0A=
=0A=
Before the change.=0A=
	$cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
	llc_occupancy=0A=
	mbm_total_bytes=0A=
	mbm_local_bytes=0A=
=0A=
After the change if BMEC is supported.=0A=
	$cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
	llc_occupancy=0A=
	mbm_total_bytes=0A=
	mbm_total_config=0A=
	mbm_local_bytes=0A=
	mbm_local_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |    3 ++-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    6 +++++-=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |    9 ++++++++-=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 ++++-=0A=
 4 files changed, 19 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index 56c96607259c..513e6a00f58e 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -849,6 +849,7 @@ static __init bool get_rdt_alloc_resources(void)=0A=
 static __init bool get_rdt_mon_resources(void)=0A=
 {=0A=
 	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;=
=0A=
+	bool mon_configurable =3D rdt_cpu_has(X86_FEATURE_BMEC);=0A=
 =0A=
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))=0A=
 		rdt_mon_features |=3D (1 << QOS_L3_OCCUP_EVENT_ID);=0A=
@@ -860,7 +861,7 @@ static __init bool get_rdt_mon_resources(void)=0A=
 	if (!rdt_mon_features)=0A=
 		return false;=0A=
 =0A=
-	return !rdt_get_mon_l3_config(r);=0A=
+	return !rdt_get_mon_l3_config(r, mon_configurable);=0A=
 }=0A=
 =0A=
 static __init void __check_quirks_intel(void)=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index c049a274383c..45923eb4022f 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -72,11 +72,15 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);=0A=
  * struct mon_evt - Entry in the event list of a resource=0A=
  * @evtid:		event id=0A=
  * @name:		name of the event=0A=
+ * @configurable:	true if the event is configurable=0A=
+ * @config_name:	sysfs file name of the event if configurable=0A=
  * @list:		entry in &rdt_resource->evt_list=0A=
  */=0A=
 struct mon_evt {=0A=
 	u32			evtid;=0A=
 	char			*name;=0A=
+	bool 			configurable;=0A=
+	char			*config_name;=0A=
 	struct list_head	list;=0A=
 };=0A=
 =0A=
@@ -529,7 +533,7 @@ int closids_supported(void);=0A=
 void closid_free(int closid);=0A=
 int alloc_rmid(void);=0A=
 void free_rmid(u32 rmid);=0A=
-int rdt_get_mon_l3_config(struct rdt_resource *r);=0A=
+int rdt_get_mon_l3_config(struct rdt_resource *r, bool configurable);=0A=
 void mon_event_count(void *info);=0A=
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);=0A=
 void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index eaf25a234ff5..dc97aa7a3b3d 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -656,11 +656,13 @@ static struct mon_evt llc_occupancy_event =3D {=0A=
 static struct mon_evt mbm_total_event =3D {=0A=
 	.name		=3D "mbm_total_bytes",=0A=
 	.evtid		=3D QOS_L3_MBM_TOTAL_EVENT_ID,=0A=
+	.config_name	=3D "mbm_total_config",=0A=
 };=0A=
 =0A=
 static struct mon_evt mbm_local_event =3D {=0A=
 	.name		=3D "mbm_local_bytes",=0A=
 	.evtid		=3D QOS_L3_MBM_LOCAL_EVENT_ID,=0A=
+	.config_name	=3D "mbm_local_config",=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -682,7 +684,7 @@ static void l3_mon_evt_init(struct rdt_resource *r)=0A=
 		list_add_tail(&mbm_local_event.list, &r->evt_list);=0A=
 }=0A=
 =0A=
-int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
+int rdt_get_mon_l3_config(struct rdt_resource *r, bool configurable)=0A=
 {=0A=
 	unsigned int mbm_offset =3D boot_cpu_data.x86_cache_mbm_width_offset;=0A=
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
@@ -714,6 +716,11 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
+	if (configurable) {=0A=
+		mbm_total_event.configurable =3D true;=0A=
+		mbm_local_event.configurable =3D true;=0A=
+	}=0A=
+=0A=
 	l3_mon_evt_init(r);=0A=
 =0A=
 	r->mon_capable =3D true;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index fc5286067201..f55a693fa958 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1001,8 +1001,11 @@ static int rdt_mon_features_show(struct kernfs_open_=
file *of,=0A=
 	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
 	struct mon_evt *mevt;=0A=
 =0A=
-	list_for_each_entry(mevt, &r->evt_list, list)=0A=
+	list_for_each_entry(mevt, &r->evt_list, list) {=0A=
 		seq_printf(seq, "%s\n", mevt->name);=0A=
+		if (mevt->configurable)=0A=
+			seq_printf(seq, "%s\n", mevt->config_name);=0A=
+	}=0A=
 =0A=
 	return 0;=0A=
 }=0A=
=0A=

