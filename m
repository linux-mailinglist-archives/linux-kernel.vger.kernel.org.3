Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6959C0D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiHVNoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiHVNn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:43:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D377140BA;
        Mon, 22 Aug 2022 06:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GndL3YOCnot9ob+ZRxDhL8lv7zjm9VZrT9Cur1I9Uzx22EE29ecA0AgbUBr6DL4dRvTWz4NIDcr8HN9m3AIRSu0qGlv/trDN+26fatCmzR124M92uN95w5JHO8akcSlTyFvNAhVX4VYdT/4dxRW0IitTpXq4BkhkYgSOFRk424cWXV3adl8ZyO9bUSCsNVoy11BqtN17uyTltIPxQbKH0zrtOHLRmLDAQiK8ws2BesnFFEEmj667K/9dpqaFPMxHvOu8Gf1Fg0dB3n/KevlXOWf41M7sI7jsDoVQrQ7/XAM4ddyu/lb1Uz+IUCtS4KP+IFz3uywsUxrcYlayH78taw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vT6AYWCXCXZvUBYAFxGH/v338c4SAKmQxv3X6389jE=;
 b=mmThaZ2bc3eCt55n1hCZwTutM+cz4Tbadij1DMuyp9ejXAYYtuCVqHmWXixlLWSS78vaPcmbjfmoVNnjHtk3yOnlztROvZ1CEtld6+M/HqX9TP11OlZJwqZJxqgWEbg3ljkca08sCLhhtU8YS4ujIYV9qVL5aeh1L9V955LBgn/NgTzv5OaTAvPPNNGSVTmpAqMtP28k8VNevCh3Dn6wH1w88KBNGNs+hS6BXK9hUPjZdS/DFtE8f2RwTO4k4521lbdfSBsX7kQ2tgQvx25KLFJ1BlgZ15ns3M1CF5c3mkmfI+PIwem6iqagsHEhmqOo+RXTef7l/Xn9UjNuy69STg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vT6AYWCXCXZvUBYAFxGH/v338c4SAKmQxv3X6389jE=;
 b=sQzvG0FwFlfTTMuQ1+yLsCHB6rixhIdWY1rR45SLrP7eVJt8WCxyJUUfhUiiPj4C0bwh1bw5McozqOKsx45od8fl6EdfsQWGtnj6LbkSkk5fdcsZ/xWPnDYbFm19pcEbdTCXkNm5BENSii9zHzuW7BZA12/JBxlFADi2KZGyxIU=
Received: from MW4PR03CA0005.namprd03.prod.outlook.com (2603:10b6:303:8f::10)
 by MWHPR12MB1791.namprd12.prod.outlook.com (2603:10b6:300:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 13:43:49 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::56) by MW4PR03CA0005.outlook.office365.com
 (2603:10b6:303:8f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Mon, 22 Aug 2022 13:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 13:43:49 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:43:47 -0500
Subject: [PATCH v3 06/10] x86/resctrl: Introduce mon_configurable to detect
 Bandwidth Monitoring Event Configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bagasdotme@gmail.com>
Date:   Mon, 22 Aug 2022 08:43:47 -0500
Message-ID: <166117582698.6695.3458866624522799072.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: 09fcd433-9293-4df8-1b3d-08da84445806
X-MS-TrafficTypeDiagnostic: MWHPR12MB1791:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jWaNe5ZuJxM51DQBSTUxft4Uetq5Kdcnt1rno3kyCWnutT8au/aY/XTl7eIXJLH1w3VoufoYGdNNXmObN53mnukcIVBzc/uUDSBM56RjOevicf098cPE9KjQ6RdRTLpAq2SyrjTiHLDwugzemZOQaYAzMYnVvGIlY7oTriyQe1IDKk/i4dqHwHQfWwTBJ2VPLlfz9WiWSiTPf3PWc/2BbWYOXAcmMbt/VD+qpC5tcWi210vM55S8qrH6Fl785rhVAPz1QHAUj9j0YYGRyTO1ttnAluTjryHIi9KaTlGCv2AntARaKTSW9exOgg3yr+712XWA8UuigClfHpmyhziSmqMMQcbTSMUV0VhfHLqKj+yNktVb44kL7ZzwJN2RZYCDvzzzmurWU10dloF9+BLWpJ0AAhnMeWT5BxrJSQGDPmWpvVwcczfi0i03oXOu4o+6ExM0Fy0lNAcsG32YNmzol7JQiGi6dMWsoxPgEwCQZxfmyjV1NVUVABGIERy5gQPBchC/hQdedJMiHBcc8K3nvxyOzcm6lBtxOOZJ+8+P4+5kLOWc1i5569i/bzBafcMMT596TTBveh3R+pyl0Os/JmAT8tiqoypEpNkf9z1JXDZeC7e5KynO6JgaaUqMMRRj3R6d1O8cwG7K2UNNidER/SZu3syz93G2q/FTPKH21vL3B5mmfd1xqv8EVbn8108D6FV7/vLshMzwXU8A/ex/qOtOLc3HWmix7F1gM4g8Opkt1n+A0Qnbku6eR0wWfcFF89hPewyc+SPhqXlTgxdH46yWhw6EiXfZafWwox11PMUr78wXY82LMTKp/gchMSO8vCuONqzxZ35uve+WZTwHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(39860400002)(136003)(346002)(376002)(40470700004)(46966006)(36840700001)(47076005)(426003)(82310400005)(2906002)(44832011)(8936002)(4326008)(8676002)(70206006)(70586007)(5660300002)(7416002)(9686003)(41300700001)(26005)(103116003)(33716001)(186003)(336012)(16526019)(478600001)(40480700001)(81166007)(356005)(40460700003)(36860700001)(86362001)(316002)(16576012)(110136005)(54906003)(82740400003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:43:49.2971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fcd433-9293-4df8-1b3d-08da84445806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer AMD processors support the new feature Bandwidth Monitoring Event=0A=
Configuration (BMEC). The events mbm_total_bytes and mbm_local_bytes=0A=
are configurable when this feature is present.=0A=
=0A=
Set mon_configurable if the feature is available.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |   14 ++++++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   17 +++++++++++++++++=0A=
 include/linux/resctrl.h                |    1 +=0A=
 3 files changed, 32 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index eaf25a234ff5..b9de417dac1c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -682,6 +682,16 @@ static void l3_mon_evt_init(struct rdt_resource *r)=0A=
 		list_add_tail(&mbm_local_event.list, &r->evt_list);=0A=
 }=0A=
 =0A=
+=0A=
+void __rdt_get_mon_l3_config_amd(struct rdt_resource *r)=0A=
+{=0A=
+	/*=0A=
+	 * Check if CPU supports the Bandwidth Monitoring Event Configuration=0A=
+	 */=0A=
+	if (boot_cpu_has(X86_FEATURE_BMEC))=0A=
+		r->mon_configurable =3D true;=0A=
+}=0A=
+=0A=
 int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
 {=0A=
 	unsigned int mbm_offset =3D boot_cpu_data.x86_cache_mbm_width_offset;=0A=
@@ -714,6 +724,10 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)=0A=
+		__rdt_get_mon_l3_config_amd(r);=0A=
+=0A=
+=0A=
 	l3_mon_evt_init(r);=0A=
 =0A=
 	r->mon_capable =3D true;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index fc5286067201..855483b297a8 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -995,6 +995,16 @@ static int rdt_num_rmids_show(struct kernfs_open_file =
*of,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static int rdt_mon_configurable_show(struct kernfs_open_file *of,=0A=
+				     struct seq_file *seq, void *v)=0A=
+{=0A=
+	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
+=0A=
+	seq_printf(seq, "%d\n", r->mon_configurable);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static int rdt_mon_features_show(struct kernfs_open_file *of,=0A=
 				 struct seq_file *seq, void *v)=0A=
 {=0A=
@@ -1447,6 +1457,13 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D rdt_num_rmids_show,=0A=
 		.fflags		=3D RF_MON_INFO,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "mon_configurable",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdt_mon_configurable_show,=0A=
+		.fflags		=3D RF_MON_INFO,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "cbm_mask",=0A=
 		.mode		=3D 0444,=0A=
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h=0A=
index 21deb5212bbd..4ee2b606ac14 100644=0A=
--- a/include/linux/resctrl.h=0A=
+++ b/include/linux/resctrl.h=0A=
@@ -154,6 +154,7 @@ struct rdt_resource {=0A=
 	bool			mon_enabled;=0A=
 	bool			alloc_capable;=0A=
 	bool			mon_capable;=0A=
+	bool			mon_configurable;=0A=
 	int			num_rmid;=0A=
 	int			cache_level;=0A=
 	struct resctrl_cache	cache;=0A=
=0A=

