Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF754A7AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349498AbiFNDzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiFNDzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:55:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AB93A726;
        Mon, 13 Jun 2022 20:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuAiKrUnvbmm92kj1+LxvywUY8FNcHClNlWE2Zi0eWLQ9KLoFQFvksijvdd1Od5DkdJiS1Nvcrw9YdmezmEpA06XULV2EtrWUYC9P1+Mqx3M7M4n8D/+r/kqUnOzu+MbufzeFLi1nnolj8MNvGfOEb5AbHzJZERjPPtLpNQLOOyx8gGnPbxUFHdCVVnwjvlMfDOMgNqZ1OPg7/jKQumwuY+/wvRs4IvU0eVa6lG6DAd+eBay2JMGs1ACIPiw+6h2RHsyS4U03ZmNfn231haCG7jC4WQiinCuI2lKRe4fqjlDHrsn/xDsVvXJlTsiraL6aWkpQq7ETVqDgBxwSl4Qyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFsjPLY4Nl/VFLYmW2280pzWnb16HckmQFyBH4BtRsA=;
 b=UbeEbk/P2bTG+d1XYaCS6JkAK5tpu4tkQCiNAFYREsXKopdpa3VPaUTNqDzcgRaR1tHGAbu7QmVRzqStHeMF84lrmLJJbpGvcMZ202nKOdprLCIwxeHqi7WOuaPTy2JX3vOvNmQNw2C6f0uvraYbfPhntPZR4R2KZ8oWHcDhCdhiDv2D+Qf/Se56m1ntC8xpZreJq1VrsF9mlfc5iluNYLLHGtOs2TxDzwTkyG+qytxUeU+Ktiq8gaTCFNmDANEMiQ7cBTca4fhc31T0CMnuD0ooRvjfTPcasFQPas7MQk4YI5a4UoA/AopAyaU9DfsZtO9KYHI212um8+X1VSdzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFsjPLY4Nl/VFLYmW2280pzWnb16HckmQFyBH4BtRsA=;
 b=PtJBbsVbTrtnptuFsiLC85m2RTUYtKE6EkbBbsAYaRSAeAOml6UMx4Ry9yfllW3wLCRg3ObkIfaGlW93YCq+ks4OCe5B4UnUKPjsdAiWdN8geb9gZxcmdeS4sQiKx0qE23VC6/lNNQsdceVPhq0ieQo8IW4IRUhUxqoAf+XO/Bg=
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by CY4PR1201MB2517.namprd12.prod.outlook.com (2603:10b6:903:da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Tue, 14 Jun
 2022 03:55:07 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::f5) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16 via Frontend
 Transport; Tue, 14 Jun 2022 03:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Tue, 14 Jun 2022 03:55:07 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 22:54:28 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jane Malalane <jane.malalane@citrix.com>,
        "Kim Phillips" <kim.phillips@amd.com>,
        Tony Luck <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>
CC:     <Ray.Huang@amd.com>, <Jinzhou.Su@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH] cpufreq: amd_pstate: fix the highest perf query for new AMD processors
Date:   Mon, 13 Jun 2022 23:52:28 -0400
Message-ID: <20220614035229.170852-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15331d75-0b86-473f-b1cb-08da4db9abce
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2517:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25174E3C15B9E21A54235A2A9CAA9@CY4PR1201MB2517.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9IWbzFMw2bc3tKchxwLPXRFsnvlOLJ03O0sxao0CCKDPK5sM+AA9weYcDtuU3GutiL3sotswKza6I3U/gaaP8aObl5nqufAIn+H/E8/IcZyZWSoAhX4aDaO592kkWyTWXJOoaYJHxItUd36xxiL+agqu3TSg2knCA+JXv6Q6pdgTU3jRH495fNNGygz1zMHIv9aRM5bPO2ySQyA195Nv4FZ4VQXyRVevd56qLyROBk9xD9fU7wsnad3YA34ZtXF7UkGklRySyTfl9cmmBjTlEzLMoqYw6TldiB7+7kZ4FqTaEMwn2AsmevbIPdgh4JCe6nNDhRkCVttQj30lF9BI2tuAmyfCrs9lt6f1cbfmllx5EXpWvBjfYMxbDCVif1/VKU9h9StrpQ4IWzv6aTku2/ySkcGoNLJbURDP5ix2xNsc9ESN7t1+P67KxbYLxEXcc8rcz61dT3Gyh7kCXUzBUHcv7Ea1y6z6oNeqhOm5qgng3yTsh/l5kqjiKpT+sh28YvJJ2whek63nHq2GBeWxXTCs9tUKIdIIKvzo3BZDp4rxMP/qq0BQ3J3b8oGZoPmJM0OsVCY/TXQIUIc4/0p0H2jkHudn4F6moIYeKDJTCcopb9w1+O8uOhB+BnaGeuObOBwLCyqMC+LSmjjTPJfbXBEdo5K+2crjjI5To/YHEKu9qVM+2IDc+icl7kOdC7b28ut5QEbfAG4/jSuotNttyeCIzCP3ECMZnIOAvgDfNg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(86362001)(36756003)(8676002)(4326008)(82310400005)(5660300002)(8936002)(356005)(7416002)(110136005)(70206006)(81166007)(4744005)(508600001)(70586007)(316002)(2906002)(40460700003)(36860700001)(186003)(47076005)(54906003)(2616005)(7696005)(1076003)(83380400001)(336012)(16526019)(426003)(26005)(921005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 03:55:07.2459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15331d75-0b86-473f-b1cb-08da4db9abce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get the corrent highest perf for some new AMD processors,
the amd_get_highest_perf() call will check the CPU model and
return correct highest perf value.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 0c0b09796ced..ff2075f26ef4 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1152,7 +1152,8 @@ u32 amd_get_highest_perf(void)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
-			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
+			       (c->x86_model >= 0x70 && c->x86_model < 0x80) ||
+			       (c->x86_model >= 0xa0 && c->x86_model < 0xb0)))
 		return 166;
 
 	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
-- 
2.25.1

