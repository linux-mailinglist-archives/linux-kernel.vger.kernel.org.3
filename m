Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E112158729E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiHAU5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiHAU4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:56:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2629A13FB6;
        Mon,  1 Aug 2022 13:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+pQ9Wd7CKalHUgggSMmOOZCrPY23kG0UJT84c2ja5tEe/rvfR0qoZloRQd/pm2TbsVOVsetpkrge4i+NmlEb3B/F4HsB9OVr+vr4kKKdW6nMdl2diTokmg/B1bmC+WOkmDhE6iJNmW0afnTvfDR9E6AcP+WNvriTpYJe2UTIhKeiUm8306Hs2G0uiUJksQxv71thJU1ojyvUsiTcueWVGhKJlfWzh5JZ/KjDxInr4eTmb8ymt+Odl4EDR/w6M/H4PcZq49pBdtRTbUCYVeB+qvpwa1mdk2RplIrnL/BJkH8Ibksizw33+b18iJj1+h/+pd9/4kh0VHrtntbYpICLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFfgMuYkADALOBUFl88SwOIHqs3XC6t28Gu6oy2MR1s=;
 b=AvoqensuF9ZqM3phQvBJz4Poo0whLEnttd0lEwLIROWB7ofNmmZrXFfynvUziorSyDZz5SJOLRg281a3Z7PFhWLxWP8EYe4eUj+IhTgVOAu+BdHxSgFsEQxaCGTgHpQcZiYVNs+DHSdMInLhU7xmYaZCcOWA2+i1CcPuRK92sGYg+trJS8+U5/hLgBmxnTHGQH+qrG4+P5nd699ik1QnMzZ+21qm5HJ7T6nf21VhhJ9VhDvDIZfKa/r7btRyOvj2Y5zJ/yN3rBxVP6A0PWgwYUgKR0ztgfFd11ss0s3RxCLV7uwgPCIqtQBqJH/haFOOswzGGVplCl2C0H1qFNJ+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFfgMuYkADALOBUFl88SwOIHqs3XC6t28Gu6oy2MR1s=;
 b=qpyCT+gmMiznlDmRRRTNUffkmN5AXJugKJPy7oAtUh76+Woo3bvmgsmYYo5jlvJJmG41ISeewohj8DgExNCYktCQbDAk2eDrhzrtuvUfP6AsDOFDd9nY2q64yqRZr2NEtX+847FVyIC8BXdgfcv6evcuBvsMVQOamHtD2ftSn2g=
Received: from BN9PR03CA0348.namprd03.prod.outlook.com (2603:10b6:408:f6::23)
 by DM6PR12MB3276.namprd12.prod.outlook.com (2603:10b6:5:15e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 20:56:20 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::1a) by BN9PR03CA0348.outlook.office365.com
 (2603:10b6:408:f6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23 via Frontend
 Transport; Mon, 1 Aug 2022 20:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 20:56:20 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 15:56:18 -0500
Subject: [PATCH v2 06/10] x86/resctrl: Introduce mon_configurable to detect
 Bandwidth Monitoring Event Configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 1 Aug 2022 15:56:18 -0500
Message-ID: <165938737828.724959.2910385805798358887.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: 7ba4fae2-9519-4304-7718-08da74004939
X-MS-TrafficTypeDiagnostic: DM6PR12MB3276:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wl49TFUelUEpgwtJdnBt1CDD0GBj7RxphwwT7o9I465PUC+Cs10fkXUI19dUb22qDxPusLuRIPw8dSGTdJvYkezzrIYNpv7OmtNDky6Fy52Fp+KNkVN49haCoCWmTBTvvsQ2Ozs1EcS0tSW6Dz5sTVHJTUolC96nqWnNy4li+/6P2H4BbkqI53Fq62hOs4IcX4dowsYcIg7iM81Yvsp3dAaWU17NQ4Ar8z7EmymUO9shPjCGILYBd/66kS9gjwNHEbbXxWHHqO7AQVyv9gGZOQ24JfqH9rD5l+DkYfoLV8wXo8z79kj+kjkCrXisS5avdsoeA5C8MQw73Y211Mh1d7T7Zk0QUpBpQbXajaU0F9ziT9Upx3G1leXMQPN+TCE38GqGt0CL3DWoE1MfOynzC1BgPLSVrjxQOxfFHVD1gHVQ0lQFrTZJycmWqUfWYj5ajX31Oo13UtEu2ZvbNG9+aGmIYyP3CzQ4KaWsdmaTroSduqe3ik4SvLtm3s39Y2Y3979R4DHyKC20Jwgy0fqClHqEeFwKMtih+FlgvlichnmGl1whNFG3k+TYje2J7ksjhWx+tMzeAW9pyA3Xuzzu6S88hdH2db47EYHdENxXpgalolzyxWVLGJlOEymEu4/GCeN+kPa3lBVx8z+9Oq9d8NZlIT1LHVVujoVRjks5LZjjB2Vv5K6s/dUABrmRjAQY1HLvKyS1a8G/Asaovd97vFEBLWr1g+3j9U9NDw8MVVDFZwgWxdsV26Nig+MyIc8r+fu+BRN1Iryjm+j5iRofkD3E+pOARj7fqcPXsL4L476l91epcOUFAZurrvtqgcdjgeXAhkRQpKa0XTzpqSvUlOUWxuRjTnM2A/faacPOl5E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(40470700004)(4326008)(8676002)(110136005)(316002)(8936002)(54906003)(478600001)(16576012)(33716001)(82310400005)(70586007)(36860700001)(7416002)(70206006)(44832011)(5660300002)(186003)(16526019)(41300700001)(9686003)(26005)(426003)(47076005)(336012)(103116003)(2906002)(40480700001)(81166007)(86362001)(356005)(82740400003)(40460700003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 20:56:20.3046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba4fae2-9519-4304-7718-08da74004939
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

