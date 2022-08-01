Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA0A5872A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiHAU5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiHAU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:56:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CED814D2F;
        Mon,  1 Aug 2022 13:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld3N+SkqcS+sbB5OcXWt6V5FLnpw6PZIop65eTgYJ6AW5/jVnih4tAr/QXd+z6cxJeJLSLxv0ZpkkI9pQJVfIjqClbn/xGMNW9uQxmTbzNGZeztsZHiIR7L01dONRoh0MK3PANGBtwso0g9vlotE5ZmoChzZmKv7HU7Y/hapBfg4RbvgFeesPP1W5z/iP739t0FbSFxAe9IzeVi18YrYLchXv7Cu+0ueNOEXC9XxmZvjCpay6V12IqnLWav+G8D6RRXOYi47OXRoHSsMuslGJ/RtHWpBObhM7xLwrbp3GOu92HY2iL8r4Ptf+7HXaKLrdUH77ZGZ3KqePm8XQcxvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2hVQFstr8tM+N5wK2rA7VHzevAR441TvRF+4BIXnqQ=;
 b=ZInNMBNdmOa3Lfq1EINiL8QJ5vIYhlbJbOkbbfvaO1AaJtqQzbkW8JYZFuX5ezE83J2ZktyCaSJm977pSMe7S70yacRaQ5eU0SCRKA346gCkupelPxVsNvzlzJcJaf+Bghlvqgef/20JqYz+q9yrButRYNKvxs4SjZ9admGwA2V74j9rMtZwrwxozS1uXdc59vPjN5p3y/vk2U2tF5KOEZpLN0TlmJfTQGwKzHinW0DXkk3UbAIa36gjirYptCv4fGA+FAoVItSmkSMCj/8bzF6OR4qBBH768B7uT3PIOg0yO7zqkGYdM1vjanH4vp6KjU50Zt1JOBvLiyAyKmZp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2hVQFstr8tM+N5wK2rA7VHzevAR441TvRF+4BIXnqQ=;
 b=MdbNRTVcAFdjTwMwhTWcUQyGjOYIS/sgpd/wRJ1IElLSRuQOQ+mTGoqNttYJS/PotO17CGO4w35knjRKuX/8Jlqp3M6N667mZZU2bM2928yfbi0Ie2vkeZJYoFPMIu+OhC89w2GFSTq3M08xdpKdPOcFUUA85ep02uLoum5E40Y=
Received: from BN0PR04CA0206.namprd04.prod.outlook.com (2603:10b6:408:e9::31)
 by CY4PR12MB1605.namprd12.prod.outlook.com (2603:10b6:910:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 20:56:34 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::13) by BN0PR04CA0206.outlook.office365.com
 (2603:10b6:408:e9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14 via Frontend
 Transport; Mon, 1 Aug 2022 20:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 20:56:33 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 15:56:25 -0500
Subject: [PATCH v2 07/10] x86/resctrl: Add sysfs interface files to read/write
 event configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 1 Aug 2022 15:56:24 -0500
Message-ID: <165938738481.724959.179823924599228076.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: cfa46bcb-5946-4ede-666c-08da74005158
X-MS-TrafficTypeDiagnostic: CY4PR12MB1605:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMgBMCRoIjDIt6RGWzfURCFIrRxdu1r/ZHXrjizzaqmjg8mEJ2GTJYu37+a30ycXePX5zKZOaXCbbAgj7HMddHYm0E5H7xX9i5JmMaRylS9R9vIXyjBkISQ+sKOCNpPDJeHgzHqSv1UVm23oJWQVpkFcg4j8zaUnyidaOhzoHbdLHJtuxr52b963Drk0nwc4jWnfthEAhbcSne2510oRlDfDGJ3MTFQGmoyK7zXNIFdK2UQw7xq70GdAuPu4k7d/dmtHcuWHRkqtEkDte9F5M8Pyz9WTOgrunhR+xRWXs5zN0tn5ajGxb5p8Vi0LM1fghmB0onHaW6MBwbEigdb8IcFiolmNhBAA9OV5gJEnYwVwcVA+ahFP5TeKNBo0K3dTodbuAFsBIqT+SgD3+h9hoZpFj6CIUvhfwz8G5x6qGFD6AwW05TzPvndUa0EFz3DTx7qOritKs5iOEsrQRgUZDETmQtTuM5+qpKAc/PNuALKSnK/U+pE1N+xwbXr7yzoF5Xe/VeFNULtHiB2U2fg7qlLlsF3ncUmCvJbQ5zrQEIfWhesTCgXA+E78Yt8OKpeOHO3aRSQb7wKqKrQQKqGjB5+V6b9MKKnSM4Y6FSjDgnE0ePgxLe3Nwg7nWaBzbktlG7rCx/odiAvF40xDTLwyQb/AbIpBzh+MQ9E9OCz8JKNYIG+/foU33OSFvJdX9vZGps6ZmsmOhPIz3s8vXl6YtGOoTi1E6wTHwHIlm3ZsfENVBoT3PIrAAt6wvjseUGdY9booqrF/IqNmuwer2CVU9S7xd4vyU5nWfzgqeanR0yxAFHrFYScya4sxU31qkhTmxNVbLGwDHyGRsjZa/AxlXY4XvTiO3JKjtw0qXp2S7MY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(376002)(39860400002)(346002)(136003)(46966006)(36840700001)(40470700004)(33716001)(478600001)(36860700001)(103116003)(40480700001)(110136005)(16576012)(8936002)(54906003)(4326008)(47076005)(40460700003)(70586007)(8676002)(70206006)(86362001)(426003)(82310400005)(81166007)(316002)(7416002)(82740400003)(356005)(336012)(2906002)(41300700001)(186003)(44832011)(16526019)(26005)(9686003)(5660300002)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 20:56:33.8822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa46bcb-5946-4ede-666c-08da74005158
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1605
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

