Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA68D5B0BF8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiIGSAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiIGSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:00:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF49AFD9;
        Wed,  7 Sep 2022 11:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn2vrCUdGv9Nhdt1APtx/c4rCR4c90D5Xj9VYonFXxJVqt7QVJisI2dDkq11UP7FOQiNDHSrcQoAOfer//k6eGOJbaUWdU7tR2V0pL5XTflrh+6A7xRZUrqkQw3OeGt+bguacLmN41qdgs9AA3pwN6oXzun4DRxim3tv0atekoMYyGGFjHkHoS6NLc+VIaNccdmLxAZ6ICeUymAfaX55RCVNnTiPqIZwP3C9poD6jjw5mr5nqwboO2fmEw7wxiz/6BJiv641Lv3bxaELUzzmGnEf0F0eIHfHoftjt8D8Qk/t9C58v640Ho3tumBUx1sF8PruBEwpjDU1oXR+iG8Sww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3kkdkWFEMHDbL17w2uty2+22sFbZwrftwxmBoADp/s=;
 b=FlwCrs2PvdZcBDLuHHgF60AO8eyBQGev6KjtQqKx7sLUa+bDUFmffjiLH6i/XHC+cLAQQpc+30uOoTrlQ7Lx5TZsmyfEK5jgG2gEdT1WqaD+ZqWiMmEVkVA65+HnKeB1vX3YczjmbzSNkmj678uV3GejrR9EZYOziqY6Vd83I2NFwm+MQ8XN9MzenYJQeSSNJEwQ5JTpOobg5fioWkH0phSjd/Z5QpW0kxIjca3MSM6oq79yU1zrkXcx2FdOoXRSurCMy+bigENISZl/Y4upRJT5wrVMladVS22w/Td31wU53CAm0xwUwyuEokjwsFSiwlJ7jYKbrCWJapU/srBOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3kkdkWFEMHDbL17w2uty2+22sFbZwrftwxmBoADp/s=;
 b=427QUlG4FuCljI5RzTh4/aZKAc4Wp82pU5+hcE7Ys20n3umnHGRWGmefVMxtwE3FOi/sLgiICC8zbXW0FtN1cnScBCUw/D5uubvgw9u19VfGNsR9b6EC+ca76ynsFTgc9uk/s/5TWhJr2WkH1cGEJycpPtjskY45oiXIYaigNvg=
Received: from BN0PR02CA0053.namprd02.prod.outlook.com (2603:10b6:408:e5::28)
 by CH2PR12MB4938.namprd12.prod.outlook.com (2603:10b6:610:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Wed, 7 Sep
 2022 18:00:29 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::91) by BN0PR02CA0053.outlook.office365.com
 (2603:10b6:408:e5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 18:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:00:29 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:00:28 -0500
Subject: [PATCH v4 04/13] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
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
Date:   Wed, 7 Sep 2022 13:00:27 -0500
Message-ID: <166257362752.1043018.4708265660824485482.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|CH2PR12MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e16b257-11a1-44c1-4f58-08da90fad9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWV7ILPF0Z7oTJFUsj34sbmOEsCk6rRj2lvLA8XRsaKf/Kp3d6huxZkJpOSlu2ONNQkF++lslK9zOoYEcbQ5uhlYa45W+3C2o5MJJ9DUP0mh17exkBm8gd8UJ4RF55uSP0y0Wsf19dwh9bVBtY9CNgSs3rVjX1mdjF+dETCoJQKef+fhXwub+N7DW8KV0Uvm0XY4mX5nN4zDyiFxnFB2erf/H78gtMFaLcaBjTkrh3V+uNho4EXL58A0RtYrUQWWvvJxVBQu4lZpw3qdDI8nZcfpQw/skv9/lc3Nag25swq5RsRuiwcpGgul0PxaqlmbjpWWLJsitmkItDvn0++fEGpBs0VHYog6ECawCkqAkFnJl535TE9IWU4dMIzPqtA2uK0ptJY4zr2QE4z+QuJM/UiINHJ+XaF9e3AHMJXwV5ehKglAiJmE9zJZ3gzXvcQbeYE74y1OutnHA+1j6gPJ3U11LjZUUwfBdtsdJHDB9ViWcw4ZbrqOFelJ+klpSy+NjsJOA0RJp7x4uIydYTkilYQYjc0n9AFfrshmBLcIIqArJ58N9vxupnM0Z2FwJZDnoIF4iZ5HcTJZlD+372pMYQwXY+jIx0VItVW7Zao/GQX7a1l1h2ylef4rNTxsnmu6wrEMnDG8PvDQfXFDCFPScWVV3IEKG5gAaaCaoR8kA9w8L2Q9yXA8k8FDfaCeWJXMTRNPozhdFWTlyAMEU4Pm8a2v5jH2u8EYq0OOh9gs8iewUqiXXK+Qx9FAv1hG4EhOeIJqvv9Q4HxK9PpCRH283iELzAcf9Va0ahV/jc/WW6UG18hOIEq8RjVoyBuNVbEYyIXseiB4q7nCPxsKEFb7Yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(396003)(346002)(39860400002)(376002)(40470700004)(36840700001)(46966006)(316002)(36860700001)(5660300002)(103116003)(16576012)(110136005)(4326008)(54906003)(7416002)(8676002)(44832011)(70206006)(8936002)(70586007)(2906002)(426003)(82310400005)(26005)(41300700001)(478600001)(9686003)(40480700001)(16526019)(82740400003)(86362001)(186003)(336012)(356005)(81166007)(40460700003)(47076005)(33716001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:00:29.6121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e16b257-11a1-44c1-4f58-08da90fad9ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4938
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index c2657754672e..a7e9aabff8c8 100644=0A=
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
+			.name			=3D "SMBA",=0A=
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

