Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014EB54AC91
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355983AbiFNIyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356365AbiFNIxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:53:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B16018B24;
        Tue, 14 Jun 2022 01:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSpNnwjaMcvu2Jpnv5zFOt1fYE9dY8ab5rrdH6j+/akRQIoKz0ysmxgAY9WmGNOEjyIVQWKGQQTXOe9Q4ZAnRnI2cY3T8CfxEkPRvlM2UlGCxtwxXYKKEkCBLa3EFomm4L1DIdL3AnNuKUgrD9XbXWcJhaRpgl4hCOmyfxT0VPXz5x4eX/xvg9Y10LM3Yvs4XCP9yyRWnff5NuF/gZqNvyJlmnmoJBvqQIymzPUEqISCZOrR9XA3S1aA0j+tC0CnzawgopftTs8fRe1SOujdVXm4fTFQpb3aBiL48F4yvJPhkP+fN8zDnH93z9juwBg8cu3ECNITiYP6GmIjiPDqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFsjPLY4Nl/VFLYmW2280pzWnb16HckmQFyBH4BtRsA=;
 b=bBNWyKeK4YIWb+47W5UjySIh+kZhoXnojD0S2ygeZbX9A5EKqbuGdPtpMJLWWgfk7o3xwTVv8TT0aqs+634wFPoYpAaVhvEBKzE4mJSI8yZmgoMmUNjO950kDY9wMEhjOnYuHZvcI964yeo59GcJ47KkkwpEJw8uE+hBZfjBLZbG/LAdQVNCR8wuMdvZUFuPKvf18BMlom5KYrS0Z0GfcD7ze+JOnfSDTjrP57AYgcxJaMsWAHbp6tQH7yOcBj33kc7fiWp/X0mKKOEcXzjBTZ8sMk0RElp8mlRHSMh87XBOy6fy/B1P9dTfYTsn6ucuwIZ7Ygu4wDhDwLWE/cDv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFsjPLY4Nl/VFLYmW2280pzWnb16HckmQFyBH4BtRsA=;
 b=NxQ2MR7p2bZefwXdRd6n5J/93S9FmTQIViN6cbYrCQ6lskEx1zTr0hRvamW3ihdea99XAvP8DgL/dAH+xRsFB8IIB8HkHvJxtTp3u2/0F7fsRgvRpZI6UiicGIJP72Agw39ARhehuzAtAs988zUl87cMHHPGXQotTTFyZpXuDKo=
Received: from MWHPR10CA0006.namprd10.prod.outlook.com (2603:10b6:301::16) by
 BYAPR12MB3381.namprd12.prod.outlook.com (2603:10b6:a03:df::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Tue, 14 Jun 2022 08:53:43 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::7b) by MWHPR10CA0006.outlook.office365.com
 (2603:10b6:301::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Tue, 14 Jun 2022 08:53:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Tue, 14 Jun 2022 08:53:43 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 14 Jun
 2022 03:53:38 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <Ray.Huang@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <Perry.Yuan@amd.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Jane Malalane <jane.malalane@citrix.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
CC:     <Jinzhou.Su@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2] x86/cpu/amd: fix the highest perf query for new AMD processors
Date:   Tue, 14 Jun 2022 04:52:54 -0400
Message-ID: <20220614085255.256600-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e3889c-7d3c-4e84-2d94-08da4de362bb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3381:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3381BAABBBC62F080628F3219CAA9@BYAPR12MB3381.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaGhHkhFTNXrWhmI1TZD03FYGZkqWGgtIVe84Ks8//L4fm+Bf7OAJNl0mzvuCw0RlvjPPwEViXxuBfk6a1PlxAEsLUiO2tLaFzPjz5DMq8IH4VRKdndIUOZZlJ4lXOkWo12097d1a1TS/OPMmns5neYKKSAqA/+wby7t1bKbPHmrDcQ9bnkyHj8eA3o5pc7FJsJr8URI3yEXgyNsVcP0F+FokupOgVnhfYFG43ULHFN7gMDi/URH2hFlHKswzDDtzpHXrF37LpImEhFlC4evx+iFy9YPfObbAEgD5zYmF3azVYd96zG3QDom2Tc4O80CPIwnxniIPofWvksCPUl3BkNDgGusT1U5/ai+DVFMbhmrMiZeZibSQzeZuiRnG8scnpteBAMquIlATHS1gdF1YjUGMY8J9bKSKTWFFIiG7JqDHw2enz0ixU+8At9OSgT/2zD0wzTkoMC71VYsavXItoJjeAy2mPFaFcpbm7aAdVA+pGLmS/UqmlKK3VqQvniMb45jBxn7Q3BbOui1nTjnDEB+6qCJaAXvXh5tgXjbQAG4w3obr3TXUZ7MJ/V7Qinbvj5Qxz/AA5VE57aVI9KHQRJ0cUEowqtuMBQj1EOqeST1fNwrzRjDiKpl6lr6N1pTA08DqQWweyu/cvXMrC8gWNCWNtgqjp/X0uFEP/nD/yc02jkLC1bheBWeIbt/q42ErQpdflL94tfi4a6vfrFv3cGFqBlbbDyOjW+02e2w2bc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(82310400005)(26005)(8936002)(86362001)(2906002)(316002)(40460700003)(921005)(356005)(508600001)(4744005)(7416002)(81166007)(5660300002)(70586007)(70206006)(16526019)(1076003)(47076005)(426003)(336012)(4326008)(186003)(8676002)(110136005)(54906003)(83380400001)(6666004)(36756003)(2616005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 08:53:43.3820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e3889c-7d3c-4e84-2d94-08da4de362bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3381
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

