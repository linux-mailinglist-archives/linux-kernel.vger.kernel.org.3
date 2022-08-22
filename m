Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC2F59C0DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiHVNod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiHVNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:44:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71385255A9;
        Mon, 22 Aug 2022 06:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E18heCj3FMq310Zpv02EO41E1Y9qHXYpBFmY+FTRv5ssRbDQ1E373IXiI6tCzIErECXUnw2lUfjjElsSZy6K3SBdFiQ35zSSy4gVyQMgCfJxnq349VUcEUWiHS8TBJH6AIVlgHs88xq6d0m5L+ZaYmig/D4uwepdGI+ZN1k36yh2PJ1b4EUEt85pHuoG1hbBk+17w+aQLTeyZXR2wNqi5S09eAOfhZW0EizarKUk6YRTSgyQPHX61/21ZSMh8I2vgWKu8yDa5/Lm+zmiKEwQ3bFcm2tfnKQzHLzzVyXme16DiShIR1287Yn0sXrVlAW39JwpQ91gS2pe4ELCuVZ2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpVBMI7/5h15P6oceqQHHcg9twNEA+TXrXxIThkc5oE=;
 b=jRnVxPDxPuclD6KbYY1bKHZrthuPjCjNCZX7bmR7HsMd+4uFEIboEycSJw9pyw5vYagVHjgMMqDiCE7ZwLHkIpvciIFIdKoJsebNjsgv66AKWjcILD6XO7iqoPYZTfSmE5o6hZ99uPPkYKG8U4IblfcKfBDuYd0pgiX8oogh2q+EFzBJotqFLku+oJP4N23skcyJgmG/WomD+ofi0gnnHzCnMt5xihY4+9AecYl7c4eoftQQbxPbTl9RehW+wPDx8pTDtbCzdYT5b+NdLfPCsN4YDiyzJ39ko/GLSuhl1krN6Kz+cQ3Z7YZbNwbgN3TfPotioRK1kBkGn56Uei8O4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpVBMI7/5h15P6oceqQHHcg9twNEA+TXrXxIThkc5oE=;
 b=xSdmAeJDrAYtiq/qoXEHVUCS8yvPqo40hnDoaHWvAaemjS9t242BymZjscsqsU/r2MRu6OgcPrKN4dxg8UOxR0K+yyJHKD2gxNy/br0IsxmrSm8YjqCZKSsDKz9KmZvwhoekke4Q5VZ95rYu6qbGJJYUsod0nY0ojDsJ+fb56RQ=
Received: from MW4PR03CA0036.namprd03.prod.outlook.com (2603:10b6:303:8e::11)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 13:44:21 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::a0) by MW4PR03CA0036.outlook.office365.com
 (2603:10b6:303:8e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Mon, 22 Aug 2022 13:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 13:44:21 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:43:53 -0500
Subject: [PATCH v3 07/10] x86/resctrl: Add sysfs interface files to read/write
 event configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bagasdotme@gmail.com>
Date:   Mon, 22 Aug 2022 08:43:53 -0500
Message-ID: <166117583337.6695.3477964609702763678.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: dc54aa5f-ab24-46d0-d739-08da84446ade
X-MS-TrafficTypeDiagnostic: MW4PR12MB6950:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxlktMQPbaELDqw4FIjLuIjkSLoNE2YQfM+bOqczmPYf05MkX/kbz3ArkzZmQ+Vfpbj/Sj9nVql0k6dnf3U48EwYLB8v43QAN+QR1QDOxUMeUANTXbQyHhcKnCPhZZYKZxkLmNfyIAxcEfFUVhL91P+CiWZ287/JtQqYw2x3J7roBARssQaBfpDVXNVdjXXC/uTmD2ZracM3kNIsXI/0ELmoJ15bwX+CwzeX67r4tW+mTsE/5wyQdYhU3u2AQnxdI1qchr3FDHXf8xmvtP3e+Du4O9Wts/5oTCm1X6O+cA3NL+0WLFOJnMjQyNHq34xFyJMZhg6FJiMGgxxttFrbtQ8KR/p8ll6VV2uU0mBv7Fx7paEZLGxbxUIeKURn4t0nR3AmbhY/1H8GRp+Ygkq+063+0mRhvZzG6T02U71nM9dMTvkV3cH1XPGc9CgJFJwPMAd808+qE49mxYWOJRqS3yc57Qthac4aZZd0kNRM/OiClOlC7ZpKQh5epsq5cAYAx6YxlHuABtkK4qOsL2+qtfvpPl5kf6ope7ay5bOn0GTUO51OeJM9E/dujiR50AqOHtfsVe+tqK2I3BuGee8nsYpZ4BfP1atFKvy3jTNEt/pnQvF4lLYGTJ4/cV8xqYKfpMlwHiP36h2c5LaxC1S/9lVRsGKAm90JCL2JBVHaK7dnwD6y7f8IgtR3YxBnpvqml9O8repKprGk5//ZA7BtuvAYfk1L9wgs0koqa1/TE58tC4TWFpo9qix1QwRr/og1mkfB7xcUFl+V1ghgu4vmgvkXOlXRvojhlrcPSsONC/30us+a2Zcj2V55V225aAkg6vMr5n2AgL6NuI9IH8aVFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(396003)(39860400002)(136003)(376002)(40470700004)(46966006)(36840700001)(26005)(2906002)(9686003)(40460700003)(4326008)(82310400005)(8676002)(70586007)(70206006)(426003)(336012)(186003)(103116003)(16526019)(41300700001)(47076005)(44832011)(33716001)(8936002)(36860700001)(86362001)(5660300002)(7416002)(316002)(16576012)(40480700001)(82740400003)(478600001)(356005)(110136005)(81166007)(54906003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:44:21.0259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc54aa5f-ab24-46d0-d739-08da84446ade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
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
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    3 +++=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |    2 ++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   32 ++++++++++++++++++++++++++++=
++++=0A=
 3 files changed, 37 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index c049a274383c..fc725f5e9024 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -72,11 +72,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);=0A=
  * struct mon_evt - Entry in the event list of a resource=0A=
  * @evtid:		event id=0A=
  * @name:		name of the event=0A=
+ * @config:	current configuration=0A=
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
index b9de417dac1c..3f900241dbab 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -656,11 +656,13 @@ static struct mon_evt llc_occupancy_event =3D {=0A=
 static struct mon_evt mbm_total_event =3D {=0A=
 	.name		=3D "mbm_total_bytes",=0A=
 	.evtid		=3D QOS_L3_MBM_TOTAL_EVENT_ID,=0A=
+	.config 	=3D "mbm_total_config",=0A=
 };=0A=
 =0A=
 static struct mon_evt mbm_local_event =3D {=0A=
 	.name		=3D "mbm_local_bytes",=0A=
 	.evtid		=3D QOS_L3_MBM_LOCAL_EVENT_ID,=0A=
+	.config 	=3D "mbm_local_config",=0A=
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

