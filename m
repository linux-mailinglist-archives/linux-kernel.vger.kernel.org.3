Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648CC570CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiGKVjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiGKVjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:39:33 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D41582476;
        Mon, 11 Jul 2022 14:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8OxU6D4yyuMBZU508aOyoaSJc1TU1pUSSsDUtFi3+0hzvXk6EvrQvw7U1Uj3MYWTOKhzBrbqkbpL8gu42ZHKTFJX8juBhrTinfkeIoiBh4eUWfbE+5/FtBupCnSsFL3P/BFcA6HFtvRCjYspN+bgLNzK1FnTAeBN0S0tHzWH4qnzJinrYWaMDE/kzossHczN+0ydW6MbHpd1GWT+FIgSVBxgk3+U5usABeaPU8+/tM0WvYm6Ry0HcbmCkHckBl1uzU1BYzLbruTFhNnGDhB4bF/hXO/wmYaemuVybBBNlcFLvRUBzFBggNxXUQ2Plt7K9cRonyyTrUTCtOqjvwZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3fZJkFhRUUUFr/3d0O5Va6YqlFxUygGur86daiW3D0=;
 b=IcPJXosgnsmdtjyIcJpHPB8UNhkV0fNyGE5ZgcXbAHn8uGByS/bfQUqaE7PYgg4dwOMroJvg02d/Y2gQZ/PcVKGepl1bfwqiCqSCdQ8nOJaMPLOIj29wcaE3/Szh3s2ZubRi85jfdfl/675Kw4Qww+7B8zyAgEz9u1sTIaRI8F2SjVA8fp/7hx1ZkwF3sxSo83cDxbWqDjXKuW8iy0NTBBYdAqubg2E9iGfSe9LyTnoq+Xzucz/HBGIDkVgvsrgZsKIm8F07ZmE4RSM7LfeeGDtGEsj9ulzRtCkZuWVFHAKnd6O47esLHSfzJZckt1Xh+VWov3j1Ux7Qzo36FesfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3fZJkFhRUUUFr/3d0O5Va6YqlFxUygGur86daiW3D0=;
 b=3X4vFdd8QVfw5T0pLV7CAX0Lyq1O9JQ8PsnMseUs9rDob7GCB2iDnHAoi2HC0pGZKysZuYYAW9WEXhygnj8R1SXJOK+YX1n3Y3MiGiNABrJ2iY9+g6kRyklWzhclTgco42zgak/cj0FUCKwWKCj+o1hOGVEJvcWhMba9CPWIQUs=
Received: from BN8PR12CA0032.namprd12.prod.outlook.com (2603:10b6:408:60::45)
 by BYAPR12MB3480.namprd12.prod.outlook.com (2603:10b6:a03:aa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Mon, 11 Jul
 2022 21:39:24 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::b9) by BN8PR12CA0032.outlook.office365.com
 (2603:10b6:408:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.24 via Frontend
 Transport; Mon, 11 Jul 2022 21:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 21:39:23 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 16:39:22 -0500
Subject: [PATCH 6/9] x86/resctrl: Add sysfs interface files to read/write
 event configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 11 Jul 2022 16:39:21 -0500
Message-ID: <165757556181.416408.7184075871766868847.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: da7c2618-ff0f-4662-56cb-08da6385d24d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3480:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7M2IVmL0yMMFXC1o83WGMVOeowNWE8HWujs3t7vzJL1KpEz4mwtSpoc5Jj0xa2ZYr11RX/46qnAhSlZumwnwHeeQHlzn+zSUkHoLU/MKs7HtzYFJ9DjhF0tKW2omgFKkRMRuxZAz0zZV37ekOOvkkgWcXFIj0LG+KVz3iAoNonKMV7XIIieUL+JhD00ScqWIM0zXybHZzGf8M4Tz/GT936ufpUixuTylbB0o3hI3xtT8UFqRh/YdezqxW118x4CEpMKu/SY/hDZMTTnZTFXPsm0MrLTA71jEOTc5p5piaFBCSMxWaF8U9g1ytPuD0WO8+SoRt/2OGSqCJalJp6LtIQ1+9hKc6mcC6bfAAuMms4QkGEeto7fi8ABgtrW9buC2rkiimBFE6ZZ+CmWzwxMCDeB/sdBR+4+pqpe1OzbEcSs871i7Rhm4hVdDL8BqtjfSMvQ3P4s+ulj41T1kNw7cGa6UQqSK9oU2Lqa1MxOiABevve58KthOgHcnKAUggIj7iZjHs1cq/fksQEzjm2RQncQBSbMx3uB8ha82agzlnm6FZB6KUQUGgTPF2sOF9WRzNEvpBvt09B1GffSz4Xz1amRKMxOhG3XZrz1SsEfnEmF6a6eTEkE1ccSsXo5HTXeRq5wtHNo8SRST+ff4fEcBEgFdk/9kfzV7i4CjGRnMLeGNTwHL8p6WLncfMFGwgOPsPmRYUo7L4GuSf9obXu0tospWt5aWmrz6jBet0XSV80unEJIHuAeOura3ciVLLNKW4eJ4Pv1AapmGGB3N07xaiX+3DVDW/le9tnO0oxsqCzQhuqUycenf30/bH4zG1X21hDdDrRhptYkHbmXtr/dynlsLbcnL/tFPjmNXEIc/ZM4qfA0fbMpLx0ck5Kxyofb
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(40470700004)(16576012)(40460700003)(81166007)(26005)(54906003)(336012)(4326008)(8676002)(44832011)(2906002)(33716001)(70206006)(82310400005)(41300700001)(70586007)(316002)(82740400003)(356005)(426003)(110136005)(9686003)(5660300002)(186003)(8936002)(103116003)(47076005)(16526019)(40480700001)(86362001)(36860700001)(7416002)(478600001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:39:23.5805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da7c2618-ff0f-4662-56cb-08da6385d24d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3480
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new sysfs files to read/write the event configuration if=0A=
the feature Bandwidth Monitoring Event Configuration (BMEC) is=0A=
supported. The file mbm_local_config is for the configuration=0A=
of the event mbm_local_bytes and the file mbm_total_config is=0A=
for the configuration of mbm_total_bytes.=0A=
=0A=
$ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local*=0A=
/sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes=0A=
/sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config=0A=
=0A=
$ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total*=0A=
/sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes=0A=
/sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    3 +++=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |    2 ++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   32 ++++++++++++++++++++++++++++=
++++=0A=
 3 files changed, 37 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index c049a274383c..aaafee112fa6 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -72,11 +72,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);=0A=
  * struct mon_evt - Entry in the event list of a resource=0A=
  * @evtid:		event id=0A=
  * @name:		name of the event=0A=
+ * @config:		current configuration=0A=
  * @list:		entry in &rdt_resource->evt_list=0A=
  */=0A=
 struct mon_evt {=0A=
 	u32			evtid;=0A=
 	char			*name;=0A=
+	char			*config;=0A=
 	struct list_head	list;=0A=
 };=0A=
 =0A=
@@ -95,6 +97,7 @@ union mon_data_bits {=0A=
 		unsigned int rid	: 10;=0A=
 		unsigned int evtid	: 8;=0A=
 		unsigned int domid	: 14;=0A=
+		unsigned int mon_config : 32;=0A=
 	} u;=0A=
 };=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index b9de417dac1c..88421316c816 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -656,11 +656,13 @@ static struct mon_evt llc_occupancy_event =3D {=0A=
 static struct mon_evt mbm_total_event =3D {=0A=
 	.name		=3D "mbm_total_bytes",=0A=
 	.evtid		=3D QOS_L3_MBM_TOTAL_EVENT_ID,=0A=
+	.config		=3D "mbm_total_config",=0A=
 };=0A=
 =0A=
 static struct mon_evt mbm_local_event =3D {=0A=
 	.name		=3D "mbm_local_bytes",=0A=
 	.evtid		=3D QOS_L3_MBM_LOCAL_EVENT_ID,=0A=
+	.config		=3D "mbm_local_config",=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 855483b297a8..30d2182d4fda 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -254,6 +254,10 @@ static const struct kernfs_ops kf_mondata_ops =3D {=0A=
 	.seq_show		=3D rdtgroup_mondata_show,=0A=
 };=0A=
 =0A=
+static const struct kernfs_ops kf_mondata_config_ops =3D {=0A=
+	.atomic_write_len       =3D PAGE_SIZE,=0A=
+};=0A=
+=0A=
 static bool is_cpu_list(struct kernfs_open_file *of)=0A=
 {=0A=
 	struct rftype *rft =3D of->kn->priv;=0A=
@@ -2534,6 +2538,25 @@ void rmdir_mondata_subdir_allrdtgrp(struct rdt_resou=
rce *r, unsigned int dom_id)=0A=
 	}=0A=
 }=0A=
 =0A=
+static int mon_config_addfile(struct kernfs_node *parent_kn, const char *n=
ame,=0A=
+			      void *priv)=0A=
+{=0A=
+	struct kernfs_node *kn;=0A=
+	int ret =3D 0;=0A=
+=0A=
+	kn =3D __kernfs_create_file(parent_kn, name, 0644,=0A=
+			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,=0A=
+			&kf_mondata_config_ops, priv, NULL, NULL);=0A=
+	if (IS_ERR(kn))=0A=
+		return PTR_ERR(kn);=0A=
+=0A=
+	ret =3D rdtgroup_kn_set_ugid(kn);=0A=
+	if (ret)=0A=
+		kernfs_remove(kn);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
 static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,=0A=
 				struct rdt_domain *d,=0A=
 				struct rdt_resource *r, struct rdtgroup *prgrp)=0A=
@@ -2568,6 +2591,15 @@ static int mkdir_mondata_subdir(struct kernfs_node *=
parent_kn,=0A=
 		if (ret)=0A=
 			goto out_destroy;=0A=
 =0A=
+		/* Create the sysfs event configuration files */=0A=
+		if (r->mon_configurable &&=0A=
+		    (mevt->evtid =3D=3D QOS_L3_MBM_TOTAL_EVENT_ID ||=0A=
+		     mevt->evtid =3D=3D QOS_L3_MBM_LOCAL_EVENT_ID)) {=0A=
+			ret =3D mon_config_addfile(kn, mevt->config, priv.priv);=0A=
+			if (ret)=0A=
+				goto out_destroy;=0A=
+		}=0A=
+=0A=
 		if (is_mbm_event(mevt->evtid))=0A=
 			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);=0A=
 	}=0A=
=0A=

