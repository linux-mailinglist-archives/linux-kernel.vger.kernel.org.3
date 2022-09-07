Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10FB5B0C03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIGSCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiIGSBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:01:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD889C00ED;
        Wed,  7 Sep 2022 11:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wz3WDb34Fn6xStqPGXNpw9QRSja3sPhbiT5Ttd9tDniUhBuOS6R02iR8hXaRClg5LXvzyM01MMx9hyB06lLsG9R2e+PDBd+M5Icr0pJnudGY/XEkUI0WhSWAbZNZHO+RKMBAsixzIgP+2jwwGOA/nWUFiR10Nn71NFhBmtMxjQ8Zf9dl1eSyrIgkAK2Sy9SU85KTw6w9bjbyo0m3BdCMvmNK/6X5/8IFFE2/qVs/X/aX+rypQDIG7a7Oa2by1IQeLk+nwSCnvyI4H2IO1xmzEsd29rM/JtGQuGVMdbtLl1XRmGAaT3nWK3d1F/2VYlFoCJNtML5Nxr1/AgdJhjSUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7E8w6G9IOdQ/csZtqgLfbosYqj9Ua/qTVaUvXaFDdk=;
 b=NWLw/mvsRSfvX8n2y15AAXt3qg3Vz/2E8tIlVqW7PzgJ/Ev8GP7JqrT3k0S4BG2kIpZW5wWmK1iT9HeILxhPI1nM7l2rE1BwGtH2ATI6lU40eaUkXh0hGMrn69iSid8DbpxPtnx1x8XajXd7TOTiZnDoxNL0pmn7rTallkSpqI0a+sJrfv1fDCQx5q5+D9d/4iG50c9olOvfbTOBUMSEGZ3KVGKawHA7YjtoX+mfRQ4aZWNgB4/YX0W/pjVEW+sQgd0FrKljRJc0Bv/7affJgETMmllwY3TEA2yUnTzE5TFiYQN1Yui6rT5czTp5hcrPrmvl76O5wnzxlJ4iyjv4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7E8w6G9IOdQ/csZtqgLfbosYqj9Ua/qTVaUvXaFDdk=;
 b=bqQ4U8FdU4bKbXSrie/38ok3W4A930k+806sQ5pehrureownHmovuSsX0719/BhoHlCko8Aj2jMGjxBPDncn2duHSTYjVGEM0W60jbccwvOfym/aL3Tjiy/BGJ5edW9Zr9SexjkwQ8Xc9dETvfCpPikUuux3I2bmmkpYntGuxCc=
Received: from BN9PR03CA0532.namprd03.prod.outlook.com (2603:10b6:408:131::27)
 by BL0PR12MB4881.namprd12.prod.outlook.com (2603:10b6:208:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 18:01:10 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::85) by BN9PR03CA0532.outlook.office365.com
 (2603:10b6:408:131::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
 Transport; Wed, 7 Sep 2022 18:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:01:10 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:01:02 -0500
Subject: [PATCH v4 09/13] x86/resctrl: Add sysfs interface files to read/write
 event configuration
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
Date:   Wed, 7 Sep 2022 13:01:02 -0500
Message-ID: <166257366204.1043018.4834615270384002210.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|BL0PR12MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: 954dced1-085e-4b9c-8de2-08da90faf20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQy9B81GevH+wRycYRWHzRVEH8jBmMWrtHFQZL4L5e2d1jQprj8MA9I3UZfTsiaiwntLPxBLSgzNE37L4ZTS20nhmFF4f1RFfqE/+7DyTPgbaO4wyB2ZRq7r1GRI9jt+Xm6fRm7k/FaX5GVe4hNtpaqJPuqkVyoncyS0nDNNL4CZZK6sgG3Kmmpv5EksCSL37cQObKv+Defe1B9WJp1Jh+ODMoEQT6J0+L352d1K6YPDBboX06Mhfea0n4FjHA7Nt/VUCMR3IKfnmM0j4sBHC4wwKmQSDOGBrkDN4avSnMoKDNADWxJnJpyRtGUKCFA53OdckDatE74NXuE1RUBMA9ruE9NvbRNoDnciIIybsPzPGBPQEdQimYS/0Nar95ScvlqYSLPzRPLA0IGp/un9zIBGGnnkvpHQunzsCp61oClx+EeOffd2mKZ3uoFW05FAERBKrPHAvXQoOydsH1dErTQjVG0/6tc08JjHWp+fAMEgeyJPVicx5yZCdzDzVn2snoELCHymZkOoTrGMbCrDeE3GpTeL4Dniq+XAXevSNg54U3Ni9tJ8uNU9G6+3enESkAFIHaJ+JsVbDvrklAEXlrhqMrtCuCRtY/KfXe/aIuLF4IUKgWQblqpfWYsJSJ4h5+OD2tj4BFF3CuziDfoTiuVxAlnx2Fkh3qUUt1DefmV0pr1dNlSpGPC56GDGAzkgZ6Ls4FjM+VPZdA2TMeo9w16ePDdNJECpY2eAzA4Wi8JIyOJD/kdT7V7EOqyhSUgMDG4f6r/R9h/sbt1mAbIZSu+syoP8YrQXD4nhElTV24jDabvHIVcmfdOj638mhI7WJWED/qOSUPPV94DBZR8gwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(40470700004)(83380400001)(316002)(110136005)(9686003)(478600001)(26005)(40460700003)(16576012)(54906003)(33716001)(103116003)(40480700001)(8936002)(2906002)(82310400005)(7416002)(86362001)(5660300002)(356005)(4326008)(82740400003)(70586007)(70206006)(36860700001)(8676002)(47076005)(44832011)(426003)(81166007)(336012)(186003)(41300700001)(16526019)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:01:10.2723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 954dced1-085e-4b9c-8de2-08da90faf20a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4881
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   40 ++++++++++++++++++++++++----=
----=0A=
 1 file changed, 30 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index f55a693fa958..da11fdad204d 100644=0A=
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
@@ -2478,24 +2482,40 @@ static struct file_system_type rdt_fs_type =3D {=0A=
 	.kill_sb		=3D rdt_kill_sb,=0A=
 };=0A=
 =0A=
-static int mon_addfile(struct kernfs_node *parent_kn, const char *name,=0A=
+static int mon_addfile(struct kernfs_node *parent_kn, struct mon_evt *mevt=
,=0A=
 		       void *priv)=0A=
 {=0A=
-	struct kernfs_node *kn;=0A=
+	struct kernfs_node *kn_evt, *kn_evt_config;=0A=
 	int ret =3D 0;=0A=
 =0A=
-	kn =3D __kernfs_create_file(parent_kn, name, 0444,=0A=
-				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,=0A=
-				  &kf_mondata_ops, priv, NULL, NULL);=0A=
-	if (IS_ERR(kn))=0A=
-		return PTR_ERR(kn);=0A=
+	kn_evt =3D __kernfs_create_file(parent_kn, mevt->name, 0444,=0A=
+			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,=0A=
+			&kf_mondata_ops, priv, NULL, NULL);=0A=
+	if (IS_ERR(kn_evt))=0A=
+		return PTR_ERR(kn_evt);=0A=
 =0A=
-	ret =3D rdtgroup_kn_set_ugid(kn);=0A=
+	ret =3D rdtgroup_kn_set_ugid(kn_evt);=0A=
 	if (ret) {=0A=
-		kernfs_remove(kn);=0A=
+		kernfs_remove(kn_evt);=0A=
 		return ret;=0A=
 	}=0A=
 =0A=
+	if (mevt->configurable) {=0A=
+		kn_evt_config =3D __kernfs_create_file(parent_kn,=0A=
+				mevt->config_name, 0644,=0A=
+				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,=0A=
+				&kf_mondata_config_ops, priv, NULL, NULL);=0A=
+		if (IS_ERR(kn_evt_config))=0A=
+			return PTR_ERR(kn_evt_config);=0A=
+=0A=
+		ret =3D rdtgroup_kn_set_ugid(kn_evt_config);=0A=
+		if (ret) {=0A=
+			kernfs_remove(kn_evt_config);=0A=
+			kernfs_remove(kn_evt);=0A=
+			return ret;=0A=
+		}=0A=
+	}=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -2550,7 +2570,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *p=
arent_kn,=0A=
 	priv.u.domid =3D d->id;=0A=
 	list_for_each_entry(mevt, &r->evt_list, list) {=0A=
 		priv.u.evtid =3D mevt->evtid;=0A=
-		ret =3D mon_addfile(kn, mevt->name, priv.priv);=0A=
+		ret =3D mon_addfile(kn, mevt, priv.priv);=0A=
 		if (ret)=0A=
 			goto out_destroy;=0A=
 =0A=
=0A=

