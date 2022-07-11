Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0197C570CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiGKVjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiGKVjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:39:07 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6902820F4;
        Mon, 11 Jul 2022 14:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhOamA4bkz60SaE2MUlkPaHiWSHpeF8wnvWDY/n/1ZxuKvnBB1RnNnNCO6K8q4Bv8IloL56u182VtVkV9+612K7QrTkyVT0ZUHAhzo/CJ3QRlc9DgDrmnGJj2LlTLYjMoEgXiN9V9lOu+Za12JlV9iWJDAtp7bNwvgilT8+ngQEYlHVpt+VnPb1tcn+Xbb8uE2XQfVe8P+OixHl2kZehzvtZsBjzMyYNTH0g22SxQTd5Y9CCzXtSkrmHmgvZ+8At98UuRy7A4gyVPAc2nQs6n3JDr7cTlGXWAB/WNfxT6dUTbUDWBam5kJ2ah8m3D86NKV+wzt01M+joMMlEgA2Agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXd55s1pYNCPlCnqRTRwXoSGItYfuw7Gl37f8vDKr1M=;
 b=JsiyXuRJ8jX5itZX731OkF+2L6P5QNKwPUjaQc/Ub9fBE7lh3wtJahqPc4B7nsI1DuUYgvH2Lh2ZG7WvI2oosOzuLENORmYzAty7p3n0qcXDpTVeDrxUkpI4WdPUejGF7XoXLOV9ZAuz+hqyu9FX+yxxG2p7ztckJmgK4rO/LI62AvJEtvMJ9h0Z1Vgs/UkQBDeW0PmJrgv4AwIRy9Pse/g0tqFo4Y/2O9bbw4AsUctclBToTFTRiy9vksos2GMMtPfE7UH05IC/J37zbcX6y+4MIZOWM2FH4Ac2wHyn8/exrzv2ONlym+jpZnDkDeTXE4VgNGEBqeyZttu8ItE0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXd55s1pYNCPlCnqRTRwXoSGItYfuw7Gl37f8vDKr1M=;
 b=I9MrxQ7KH6ga06zOjthbn1mtR6XTgLQ4M9Dyp4o1yudlrk4gGQf6Y4FVfT6wpPr/yJ53uQa/8CuxoRyWZ2hUs2b3YyM2RtteQH46uwYa1BnBF6m+GXvEc9A6BNlnIRsrkaf0eMnEqESRA/57jDu3+U+X6CZJ3vgRlVISqf+eyQ4=
Received: from BN0PR04CA0138.namprd04.prod.outlook.com (2603:10b6:408:ed::23)
 by CY4PR1201MB0232.namprd12.prod.outlook.com (2603:10b6:910:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Mon, 11 Jul
 2022 21:38:58 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::f) by BN0PR04CA0138.outlook.office365.com
 (2603:10b6:408:ed::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Mon, 11 Jul 2022 21:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 21:38:58 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 16:38:56 -0500
Subject: [PATCH 2/9] x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 11 Jul 2022 16:38:55 -0500
Message-ID: <165757553569.416408.8259197582419583314.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: 6110092a-a2a1-4134-c0c4-08da6385c35a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0232:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnBPr8NFrPbmDpVLH/7fp4bBK5RF/jtP46lM3az4B3JxqboFBCuorFRTxeWGNjVe4nS472M1raVxTzoF7S+eLK/t4mmfx2e6upW8keIehsMFebEDg+jTitLmLI2T0+sOXvCDXJvY7QAilnahGaNiI7DFadETx+9s3mKIBHfLLD07rNUDYvD4tzHy+ZGuRk2BZwD3I4Yev5MKeLOwDz6uvBsFS2SgYWJGNGUxqj7NfEC3sxgHzxnSptUNeW3zHnW2xTxB5ZloZmouApIgQTIJ90aem00T63h2TuoL7gtLI5iVkp7pHqqbOjKbHSGLzDQcZCyN4mutAPt+uuZCjC34dyac0cTpzxfHnCtQTni95hUioRJqhLBnsa7W41frJkS9Ric83GbzIsFWzL75SKYzWQrQWY8iPJq6xcBNNpeA9wcJ2DnyOVX7ntv55907DgavWWzSCSlCIx+8ZFJNt/DyGe5yVGjnrZ2NmhHbSjfKjTqr4AfSKm1Wn5/Gz1VF2Fht+vQD6pihxEEBoOjRy2b2xxohMgeBlx6+7YupJ9+oTtAVtGVvxvHHDMmWADFdY77KmM+IPTkVtt2aa+2loRCTlrVQVTNK7XL6cyCuvadXx7CUWjAXu6EVFqLjd6EPWBMWqoYRpoVMNdsjdwI9j55FdGGaV/QXWlWhRenp0+gi4wqqDZqRru90Ebbli4ZRGJk4itJyA48UKW4YKEriFntBtcDdjSc3C86rvdv5UvT8/BGi5lRfDRsBpYsttvVyMiH1fp2uIg+fwgafj3+TIotoDYe5iUKLxWizSK5hLDJ8nPXfrmrRNgLwtX1zb1bgi8hSegaSP0O+EOvAwVZE5VaNmw++nzHiWhhBokonul6kSGhDc2ByM9sz0IEQw5Ot1jBq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(346002)(39860400002)(376002)(396003)(36840700001)(46966006)(40470700004)(86362001)(103116003)(8936002)(26005)(316002)(7416002)(44832011)(82310400005)(41300700001)(478600001)(2906002)(40460700003)(16526019)(336012)(81166007)(426003)(40480700001)(47076005)(33716001)(82740400003)(8676002)(356005)(70206006)(16576012)(186003)(70586007)(36860700001)(54906003)(110136005)(5660300002)(4326008)(9686003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:38:58.4870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6110092a-a2a1-4134-c0c4-08da6385c35a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0232
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
index bb1c3f5f60c8..004d809ea675 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -106,6 +106,18 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
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

