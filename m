Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D9C587298
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiHAU4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbiHAU4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:56:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860243FA3B;
        Mon,  1 Aug 2022 13:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdS30GQmbCllWF6qMff4WaT7yUgW2hoQCsNxWURX9iyuyhZY6qYnEfuGRJZ7/cReWREf7owXMq/bow41Nvro65jg4KFRdwZt6Z/sLDWJU/3ywKg34AWM9Pa697lkEIaJuwHlQb9vJYeDuXaMVr41VnLk6KG7XXYGDXaI6p0t1/ApWIxduAiLZ/+lnwigEn7ZHx2tPg/de22m1uMIBIHWj1kv+B2zwa8/pYH2oe6QTI71SmAj+rME/z4UeB3+V+PFQnCKwvLnsdJdtlP7dlfjamA6/kESH1LrAQtPUvjBNTe9GX8gFYHQBzl5gAHUEXOoR/I+rdloKUM1XmRtidJeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEIMSt5H1vUExObSsOpvPgK8YeTjuCc4Dx70hoQKJ6M=;
 b=j1PlF18O8SeAOp2oWt8fVLSNzImqAIALPAHOZluJ/6i0jd9MO5dZ2n7tg8gQZ5w8hK73NFKx1xfd1wUDwBQw9PQK2UEMczmd9yC2fACdCjftSOoS3V1Z4ZR2Lrqxpf2EQ1gPtCdqVv8gqkfVJ5Eo7pMkUXj/QgNXmZqCaJl1agkufXUcy6oJ188bg8KtVMUzEiDAkaK2MrDL3hi9gSy6BHQHo673AwpbzaJpxW+y0rrNlEThLx0EqW5FLUMmCZg08w7S+Tc6k5iyuf58fHZgrgQryVBmFVQou2uQEvpVcVdlBbRO83MEeY38++uOFeGTpr07VIN4LRCO1VJznmFhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEIMSt5H1vUExObSsOpvPgK8YeTjuCc4Dx70hoQKJ6M=;
 b=Gm324O4pU2lgU0VBgNJrNqvLENuNNtpzGoIK/h4GntrQo3hR79RIDoD8VZimFu6Xx40BtI6F2UhQZAd0OBI6D0kEE4l/fdCK5zTDHyrj8/UzJ3DXrSFDarn1Qmg1yWMcZnhv1EL48tLUdKIK975PXVztZUovOnzKzGMEVam+QAs=
Received: from BN0PR08CA0010.namprd08.prod.outlook.com (2603:10b6:408:142::11)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 20:56:01 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::4e) by BN0PR08CA0010.outlook.office365.com
 (2603:10b6:408:142::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Mon, 1 Aug 2022 20:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 20:56:01 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 15:55:59 -0500
Subject: [PATCH v2 03/10] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 1 Aug 2022 15:55:59 -0500
Message-ID: <165938735951.724959.5927072727388257548.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: ec0359c8-05a0-496e-a7bc-08da74003df4
X-MS-TrafficTypeDiagnostic: BL3PR12MB6425:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: celss2sTKFWpNSDDb18IiaWoNluu62dtjy+Ypm/9dfirrcF2z9l30fp2VnCSacQul8uiJF7VBy853GnbKH1/jz8i2pdDv3YOcdn96vfivbbwblN6/ThkK5bDwu26j54YSfPE4HVZQ+EKejBlSY27JjG63n7CuBhb3GcsWFOlh2Klw4KdsNJ7Lw8kzofGEMk/eWMp1Zi+MahUoBTiwRmPFSLloTCHrngf/C7f4Nb7dnxBH+PHakEXDcETak0Lw/ybJAWmPu0s8W/SuqO0rTlY0IGr0ESQUvtg/QJFiXIRxBdZ/wNwziZG7g4gJ6h5hmxQrY8w7qkdicqbvze4UmWBZNo8wtAYJE8+Y1XOISi/1fLEEhpV1I6ClW+Pv80CyBNNOpGYXj0dHaz7HAsNKAatN1F14bOPW2NxX9uTCVafmQHFSqtvz4ZRdMn44PFnjEw2N2p1NwO/3/l2xUVLNhNN7W6m7OvjhMT6M7/5Mkb22wFSUupmJi70qbF5QbLmZOEqJiuFHxBtaArgm43ZN/v0/O2/gd5gfmkEL47mfH8DcqzSY8OsKGHPdVCgpv0Qlg66TDfl9cOjjMeC4oyFHs+XwIuHefSyGB3pzcZfdUohyapXTpxdLyhX3tT2nouDvvM8UCLHo96m7RR97xBnjs0ll5Hr8Jd0kLS3GYw5ocMEE0fbwstNklovOB79QwYpKDiJA1N2l5mXhojBuJg7mqoKmqw/TGllc7KWliAiCP0NUrOPAizDdW1t/q5Mm3Qqf4ngmA8Z+5T9g5xjpuhi8e6lo27h042J9WafFs0FJqXmaX8y/Ed/jYZ2dygHedjKiFM+4fHLOLH1rXxZ5Kp1Wr4/3P4zixMAAb4Lc8zH+nA2qQ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(40470700004)(46966006)(16526019)(336012)(186003)(16576012)(54906003)(110136005)(5660300002)(2906002)(426003)(26005)(47076005)(41300700001)(9686003)(44832011)(7416002)(86362001)(40480700001)(103116003)(82740400003)(356005)(40460700003)(82310400005)(33716001)(81166007)(36860700001)(8936002)(316002)(478600001)(70586007)(4326008)(8676002)(70206006)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 20:56:01.3987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0359c8-05a0-496e-a7bc-08da74003df4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new resource type RDT_RESOURCE_SMBA to handle the QoS=0A=
enforcement policies on the external slow memory.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |   12 ++++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 2 files changed, 13 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index a5c51a14fbce..6c38427b71a2 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -100,6 +100,18 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.fflags			=3D RFTYPE_RES_MB,=0A=
 		},=0A=
 	},=0A=
+	[RDT_RESOURCE_SMBA] =3D=0A=
+	{=0A=
+		.r_resctrl =3D {=0A=
+			.rid			=3D RDT_RESOURCE_SMBA,=0A=
+			.name			=3D "SB",=0A=
+			.cache_level		=3D 3,=0A=
+			.domains		=3D domain_init(RDT_RESOURCE_SMBA),=0A=
+			.parse_ctrlval		=3D parse_bw,=0A=
+			.format_str		=3D "%d=3D%*u",=0A=
+			.fflags			=3D RFTYPE_RES_MB,=0A=
+		},=0A=
+	},=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 1d647188a43b..24a1dfeb6cb2 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -418,6 +418,7 @@ enum resctrl_res_level {=0A=
 	RDT_RESOURCE_L3,=0A=
 	RDT_RESOURCE_L2,=0A=
 	RDT_RESOURCE_MBA,=0A=
+	RDT_RESOURCE_SMBA,=0A=
 =0A=
 	/* Must be the last */=0A=
 	RDT_NUM_RESOURCES,=0A=
=0A=

