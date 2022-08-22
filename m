Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DF859C0CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiHVNnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiHVNm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:42:56 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B99175B1;
        Mon, 22 Aug 2022 06:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyWkqlG/PpVTk9gOL3UYd4J7k2cmeB++1IM23/yNd+InyjQzKZs5Zbkrn86Xtuq0hzzjzS5G4z0gYTwUqGpNdx8NGLmVt2jmy6LJTwNKwXMCkZq1mgc9BKmYpu4J56ajKDxHXivvikg8JChFjfmtMrgS9F5a3wZKHmSfd10PDMTOFueTB6MYWe15LLBuLxHb31ouE/KTNAIpfQ6xYEU/mQXMEvfQtnRgkO58FvCVloRwvpexfzyZ7QWz5xQzZ3JZXLwjOaismljcF33JYrZu/q3VsMuM6MF8lURVu8jE0CsnfWlw9ILBBpj+FsUfcCEKsS5Yc5IhS/FCi8tlm8aR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmiF2OsM7T+iO2blDq8waLaftEty0iyH2AbzEDW3lSE=;
 b=GMernFCL6EKsTez1D6abhnMXnYjlEcIGz/Xw3dVqAVCFixwajZGgjRIUw+ziyTVSzbEenU8Jf4aBK3q3MJ1wUz8+PkmJci6AtKvBHg4TzSo5ptLJ05LtVgp+IExj2+wwYNosrRDq2UtZxnO2uyeDsMA5zZDqLSDAcBgRrzJUfNORjVIg7fryYfBh6j6e2utCAY+PD3HqiCq9epctHVEfm1iPxbZADQJ5JVJalKNSJn2kDXhvlvD+ba7sxRxzY3HqStMdbPTLtQsN0h6QXBTQ0GThK/0+eCFgKN/JUXzRF0CsksdOIT4f9bGYtIQ5prsQRaOQ334qvZYzWfvl+hABCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmiF2OsM7T+iO2blDq8waLaftEty0iyH2AbzEDW3lSE=;
 b=AMt5XbMl053gvXE3BzgR8bImmeKB9uNqPI69VvRwzix0HGbaEij8yOvv+cY50W1YSVJvodX8nnbLAJQVghFA6Rl+3/5w+MLLj807TAIbjCHFzrFrJN0dAit7WaxB+4RKcObm5gtSgozdNVMzlpBIrlzD6Cxs3Qbrqh2Nqw+TJD4=
Received: from MWH0EPF00056D0A.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:a) by PH0PR12MB5482.namprd12.prod.outlook.com
 (2603:10b6:510:ea::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 13:42:53 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by MWH0EPF00056D0A.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.2 via Frontend
 Transport; Mon, 22 Aug 2022 13:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 13:42:52 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:42:50 -0500
Subject: [PATCH v3 01/10] x86/resctrl: Fix min_cbm_bits for AMD
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bagasdotme@gmail.com>
Date:   Mon, 22 Aug 2022 08:42:50 -0500
Message-ID: <166117577023.6695.4825793379162387650.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: cd7788ac-8426-4fe2-ef45-08da84443616
X-MS-TrafficTypeDiagnostic: PH0PR12MB5482:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXLXGDdLDpM3ixkzrY0152aRYT7m3f1k1Vti4yhVQ7HzuJH9Lb3ffRgMvailF1PlmFjF181y8NHHLEe5Q24uivtYc85m+3PqE6r1EgWaEw13BvJN6P2Qi5C6FbukTfM0JS0G1fqDJ2jI1+ic7QLUrWgO7x6GvdJm+bzzP8V4yfA8ErfTKeyMOK/wN/oB9ECEHSVc+jxfbWaE/38G2SEUotKbpq28kdpBeCqJkkojt7uKr/dnlr+YUkEVrJRXnEZT/SzHcYtvlowFowTWgd+cc6oJ083pc5UC8wD+kytQOCNC/t3nb/FpdoHTPUdLj3dj2hLyDQQ8R6yclmh25xUDDplBv7v6Ql7nPVVdh0PEkwIqt1Wcq13ozNCFmkkA09ow+6V8XqpZwCjCgsOdePF+5pe0apkhlv8LY0qClvvlsmAd0aH+M92bN/8SS0OxBh7QdhoqFlwdI8ZsqBYalPfSU/C16WgWduQKdT/zxzNpeLopVr2o/c8tOP8lklBLPNsz6c7pD6KOsJ5365ELwblf2uISHeQTpM+pS7GkbySngBIykRPgyaFoRFRtDdogtQYbDm7ypRkGcdnJce0qkhGefhcoWfPsCkLQmII2siHqeFDe0XVBk1ISHbo+irj53EkcvTAkt/t84RjuyP967HBDxeZ49Re9RLWFLwaGYY5B///wjum4fQb/jLZM5rV2dCGtS6fZtkW1vWpaeZmX1PyZLMpZQMpz69vV6RKlkkvJVdJxeXkudQH0OT8GksJccSN8dmtrDNLKrNQUaNeJB9MTAdN1x6oYOA0kq2XiWiHJ3k9l1IEaSYsLHROTvq0DQX9iHK7pzWCLo6rOriF6QG+VvpoaqQTWIGbUdZKqQZKTrns=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(396003)(39860400002)(136003)(346002)(46966006)(40470700004)(36840700001)(33716001)(36860700001)(40480700001)(86362001)(356005)(40460700003)(103116003)(82740400003)(81166007)(82310400005)(8936002)(5660300002)(41300700001)(7416002)(44832011)(54906003)(9686003)(16576012)(316002)(70586007)(70206006)(4326008)(8676002)(110136005)(966005)(186003)(83380400001)(336012)(16526019)(478600001)(426003)(47076005)(26005)(2906002)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:42:52.4586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7788ac-8426-4fe2-ef45-08da84443616
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD systems support zero CBM (capacity bit mask) for L3 allocation.=0A=
That is reflected in rdt_init_res_defs_amd() by:=0A=
=0A=
	r->cache.arch_has_empty_bitmaps =3D true;=0A=
=0A=
However given the unified code in cbm_validate(), checking for:=0A=
	val =3D=3D 0 && !arch_has_empty_bitmaps=0A=
=0A=
is not enough because of another check in cbm_validate():=0A=
=0A=
	if ((zero_bit - first_bit) < r->cache.min_cbm_bits)=0A=
=0A=
The default value of r->cache.min_cbm_bits =3D 1.=0A=
=0A=
Leading to:=0A=
=0A=
	$ cd /sys/fs/resctrl=0A=
	$ mkdir foo=0A=
	$ cd foo=0A=
	$ echo L3:0=3D0 > schemata=0A=
          -bash: echo: write error: Invalid argument=0A=
	$ cat /sys/fs/resctrl/info/last_cmd_status=0A=
	  Need at least 1 bits in the mask=0A=
=0A=
Fix the issue by initializing the min_cbm_bits to 0 for AMD. Also remove=0A=
the default setting of min_cbm_bits and initialize it separately.=0A=
=0A=
After the fix=0A=
	$ cd /sys/fs/resctrl=0A=
	$ mkdir foo=0A=
	$ cd foo=0A=
	$ echo L3:0=3D0 > schemata=0A=
	$ cat /sys/fs/resctrl/info/last_cmd_status=0A=
	  ok=0A=
=0A=
Link: https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.=
com/=0A=
Fixes: 316e7f901f5a ("x86/resctrl: Add struct rdt_cache::arch_has_{sparse, =
empty}_bitmaps")=0A=
Signed-off-by: Stephane Eranian <eranian@google.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c |    8 ++------=0A=
 1 file changed, 2 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index bb1c3f5f60c8..a5c51a14fbce 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -66,9 +66,6 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.rid			=3D RDT_RESOURCE_L3,=0A=
 			.name			=3D "L3",=0A=
 			.cache_level		=3D 3,=0A=
-			.cache =3D {=0A=
-				.min_cbm_bits	=3D 1,=0A=
-			},=0A=
 			.domains		=3D domain_init(RDT_RESOURCE_L3),=0A=
 			.parse_ctrlval		=3D parse_cbm,=0A=
 			.format_str		=3D "%d=3D%0*x",=0A=
@@ -83,9 +80,6 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.rid			=3D RDT_RESOURCE_L2,=0A=
 			.name			=3D "L2",=0A=
 			.cache_level		=3D 2,=0A=
-			.cache =3D {=0A=
-				.min_cbm_bits	=3D 1,=0A=
-			},=0A=
 			.domains		=3D domain_init(RDT_RESOURCE_L2),=0A=
 			.parse_ctrlval		=3D parse_cbm,=0A=
 			.format_str		=3D "%d=3D%0*x",=0A=
@@ -877,6 +871,7 @@ static __init void rdt_init_res_defs_intel(void)=0A=
 			r->cache.arch_has_sparse_bitmaps =3D false;=0A=
 			r->cache.arch_has_empty_bitmaps =3D false;=0A=
 			r->cache.arch_has_per_cpu_cfg =3D false;=0A=
+			r->cache.min_cbm_bits =3D 1;=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
 			hw_res->msr_base =3D MSR_IA32_MBA_THRTL_BASE;=0A=
 			hw_res->msr_update =3D mba_wrmsr_intel;=0A=
@@ -897,6 +892,7 @@ static __init void rdt_init_res_defs_amd(void)=0A=
 			r->cache.arch_has_sparse_bitmaps =3D true;=0A=
 			r->cache.arch_has_empty_bitmaps =3D true;=0A=
 			r->cache.arch_has_per_cpu_cfg =3D true;=0A=
+			r->cache.min_cbm_bits =3D 0;=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
 			hw_res->msr_base =3D MSR_IA32_MBA_BW_BASE;=0A=
 			hw_res->msr_update =3D mba_wrmsr_amd;=0A=
=0A=

