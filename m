Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3C59C0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbiHVNnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiHVNnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:43:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD09E7F;
        Mon, 22 Aug 2022 06:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho3xEjzqR0EaU1o0vZpnDS2FutU1xcNz2HP4SyyrxxSqTKUDenXQKhszgdopkbzeMI1uLYa1WCenz4n0DIc12BNaTNl1TLyVw3EjfBtU6IaKfzMv2y4Mm9X6CobaNOnx50r/TIkgVTdPxdNO/jDHFca27WkuK9tiF4UHHO5U10KVPknDdfBJ/IWchF5zGLoHeEgPY4r/3Hg+yKNhwz9v9PTjI5pQs6jdEWyymtSOCjf+OgAyUFuuhgEeU2QgtLPNwpfmf5tiyWZQEWV1z0z0/QKvw0BBKx2Ev0LT42nrS7Y6E/F2JgT4yZktEmVsoDa9SI2LXuhCuspX8SzLBfTlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qO6FPFfWgyFyFIsUK8bT7DKE8WMtYxloo3sWyT/rfM4=;
 b=AM4KWjoQRfFrRSp+7rneAp9lI6PfFbGshvYT8vsGR7mdhHCwCTKhgoeYWcneK7xboCzwaB922h71GaWyLk2AVbSkKO9H2c2tLiFN13/zhUtn0x5x79fGzxrd9l8B7yaioW1uJBK13xU6M4hHDv5JBoeUmQtMWfro+rInoX1YnlQl0HCFm5ePsY0gqoPoFQ96Bl42Ugj+g59fpwl/NzoPm93RS5IPmS+kVrMa4/TZCNgWbVXGxnwHalOmfLA1F/TTxsfy+BuX5StkyTvDBq7cMZnf/lznP1Wy3P4pJfOCNL8iSrijskufggIe1DbbF5rSo1vDGUAxbjWF78QdOcdMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qO6FPFfWgyFyFIsUK8bT7DKE8WMtYxloo3sWyT/rfM4=;
 b=RxkJC09SIpfPIzTHNc6GuMpVCmieIehQS3Cg+sGlhKwQb84ImCdcYCVRGmq0CyKvNyy50RQ98jDuCZhD/yE0NRxexsg0tOJYDNs8LtzInY6i4h206OWnCac6bXWJ9w6Pf2kyajlixiD5hDfesNDVqoe+6bAZHQwo/CWsxXDQ0yA=
Received: from MW3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:303:2b::11)
 by CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 13:43:34 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::9b) by MW3PR05CA0006.outlook.office365.com
 (2603:10b6:303:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.13 via Frontend
 Transport; Mon, 22 Aug 2022 13:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 13:43:05 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:43:03 -0500
Subject: [PATCH v3 03/10] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bagasdotme@gmail.com>
Date:   Mon, 22 Aug 2022 08:43:02 -0500
Message-ID: <166117578296.6695.6947071073613460712.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: add31c9e-cbbc-4ed5-bbd6-08da84444f31
X-MS-TrafficTypeDiagnostic: CO6PR12MB5459:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+UwfuEZZCmNLdc88XkO3tm71ULFoHnolgPzggwYoMQDAEEu4H7kVcXB9VCGv551P8cB3fDnHM+NIy+YYHNsNu82jgNHzglv1zQlMHAd8EHEoY/lU8w1IIVaE0JXMgAQ9j6VX431lxjeYYaWtbYGCnEDEQ654E9PM9l5E0VFr45eOy3VCpJEQrrM0/OM6gKZ8hKvhXWrytN590TyjttOMTGEwC/LlkOfxREq3ow02uujM5D5bwp7FMD91yEImy42I1t8xUwYb42rSxbBlv1Te15oY/X/gLZvgU9HeRcGkeeDj+n4L/afnMCV0O6VQNFJgyK3U0jWRwsdp7mtMyMy0zmtcPwqWjhNviC0FY1GARr0fnIUbldy2jbegxlWfupPUjhh1t6lDl7JLJLyHi+rGYiUBbGUr2CSYwsecH35VXdj/kStYua2gLYuX9YK+jrPm7aHJXmcB4m8duLAi1y8cg8duHa/pM4uv6EfDVeI41esI+F0JyW/nYrHC+EHMlCjNTxiTgCPZ9vhZRjr+CtVl4hT6KW7s1nUbdOm9h8cQN/5/UmyaiYfY9rH5wVsf6GWAWdkzXW5vPFcaPK/hij7+k2L69vJr+3XEFZxKTzh9zgab28hkPpqfJ50TSLGXwpZXQdVOQRVfDXfzq71qFzl5A8QyXXp67NPDZfWcAsiRVcJJn2khnhrfiNb0EtQDoOxB/hHHpJ/0YxRZJOBlDSY6qtFjWonta6ccke7nqKvl1mWjZrZxGHg7+V3RrvbaDfumKDowgE1jzosPSiuXnssAo4KQFwwBn1p5SNhnKLqTqq4TZFeSqb6XsgfjW1rMNGHpuFNkrKMa7ZCRvQYuSZpTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(40470700004)(46966006)(16576012)(316002)(8676002)(70586007)(70206006)(26005)(4326008)(7416002)(5660300002)(9686003)(103116003)(40460700003)(47076005)(8936002)(426003)(110136005)(54906003)(44832011)(86362001)(186003)(41300700001)(16526019)(336012)(36860700001)(478600001)(356005)(2906002)(40480700001)(81166007)(82740400003)(33716001)(82310400005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:43:05.3285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: add31c9e-cbbc-4ed5-bbd6-08da84444f31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
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
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
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

