Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFA45B13CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIHFDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIHFDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:03:33 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4F26CD2B;
        Wed,  7 Sep 2022 22:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyRDb9AsSPhtjYuA+rbinQcICJQCfz+PD1JFF86ow5pgGcPDT0RuNk3yJOPl15ua7D8hSQjKG7HeciqYlU0s+6a98OiBchNrxh9s61UgicKOLlzrq1/3YpGf/Cm+cJIgh60OjY8/4hAYpdznCVUPpUuLmHy5K3PlfCe4+2W8D13kfqfr3dY1cJszlRenmYWOMT+iwtpQ31erUAoKTBt4AeUizP+eZ4xybdoDxEWmXaaqYtjBoBTl2HtI8N1hMawagqfNS/JGbxnMDvLfIBxdLqRwmyqLrlLGVwA2PGEp2nqYCqRC5ZoJcaf3IHazuk9JtF2aPnKtrm15vo3tjDddrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viYW+sidf0LlHog2XV8uT7Puf6uJEO7JkkaOuXCuRwk=;
 b=hqPqKdlWO9BnmIgcvP4WCi/SWZpVZU/y/xxbDVFqwYYhIv6mdpIKvyDSwYnre9jXaEfANUI1QPgUXWCcl+3TIZ5TXM3juxgIU8OV83qeLD4eF3qlbKbpZ4wt9N7JVkMOIjXQBmfDrS510F0Td/5xf0h02SXEKPxDxMvIunmbrVEDuAn2o+73EILB72N2PQXPi2YCx8DN8zSyEyyvsJvcRZHLKoLS61PWFtvZCXUf6hZyFHe+4IDtoDG76cIgHueyboG+f1U5EJiMzCSiZZxMZS0/nnOLK9m23jvMDrDPhQOFY8kHql3dqF2aIJuU2mODRrBGmHkGm0fJHAHAlaMhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viYW+sidf0LlHog2XV8uT7Puf6uJEO7JkkaOuXCuRwk=;
 b=xcTviN5yjLktanr9ioA2SAyoQTOvHY2k/QKEHlNEIpV0K9SZ9cJctsFeA8lLFYmwWQ2LccF6TnYayfdtN0j4IziP40oVs7v/y4q43FLdtRsmzqnX5SBeLgnHAnSXGtLdZ6Kz9GKDiv6QRDTzytPyEG+JFkmqVfgRwsv/XGJoJd4=
Received: from BN9P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::24)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 05:03:30 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::61) by BN9P222CA0019.outlook.office365.com
 (2603:10b6:408:10c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Thu, 8 Sep 2022 05:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 05:03:29 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 00:03:24 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/uncore: Fix memory leak for events array
Date:   Thu, 8 Sep 2022 10:33:15 +0530
Message-ID: <4fa9e5ac6d6e41fa889101e7af7e6ba372cfea52.1662613255.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: b8911a4a-0d90-4cb1-591a-08da915778a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gklJP2RsQirGnlB0Fs/r/rUwBlj0bU7Zu1G3hteiP3brBVNECEVoE4umqd6xrf3tEeKqVszZSXqW06uywKIR9T55bq3NZErtedVtl6vrqa6nHE+E2BjDHs8PItQkh9TirlaWIIQz6sUH9RegKrNXaU66FcuyN83bqZhCii5FfW/AYY0x3CBSXAt6tpQ4GqEqLV/dtUs+NSGpinJpcOKWV5EGGPTXkFEuOjGHY9sackKm5JBlYzfx1oUedrcdpoxODH9rOK0Gtb2M9v8hEo5t/DfSDmOUjq0Eer1hWx0oCjclaKvytGMz3E9IhDuQ4BN7u0pbHaomxzEtSifDZkuMtz+mqiLcCB8X7JeIxx5Tb5wCPkkyFBWmTxF8G8LlXMJDgq0uFGbQX8Sf9J0NK1AP73zmjT/d1MXwUkd9b2XILXObJaUkZ1ZKRvsnopPmuCtj9ZSOGMN1Msm3mKc4u8owH2ZPXCJ9OcjLWHB4ENntfqLtnXQVnw3gd1I5zCYHodyltxcWhQtwNGaWs0YrO5JyDw1iFVIHMNHH1MXZIy+x5i7q++Ax8U3ajfKLPVV98Bj+Bz9U50d3BPR+wBfulHTCebTiZtHug3CC8OfuExghVdmFVkHdLq1Ul9bYDQZXWqKXQ8VT4nhDEGsBI9vAZyIx5hFTuyEAH2kpBCNoiXdC/6efVCOK0CVjNhCiL2eou+ecYRmZLxazpXIYQUCGhIJnINyUkAIcFhoC2+yYpGqbFlaWFqvETy+x4xBTXnEwxR5I4oEFJKg3caD/C2GYgpz4KiljWL91ZckMmXJh5CnvYD80fJ6SssVCwmehW2SD0KI3De/r2A4sSQ1bngMVzsfv5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(40470700004)(36840700001)(81166007)(82740400003)(40460700003)(316002)(356005)(70206006)(70586007)(4326008)(54906003)(8676002)(7416002)(82310400005)(110136005)(44832011)(8936002)(336012)(5660300002)(40480700001)(16526019)(2616005)(36756003)(2906002)(186003)(36860700001)(47076005)(426003)(83380400001)(478600001)(26005)(41300700001)(6666004)(86362001)(36900700001)(505234007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 05:03:29.8202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8911a4a-0d90-4cb1-591a-08da915778a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU comes online, the per-CPU NB and LLC uncore contexts are
freed but not the events array within the context structure. This
causes a memory leak as identified by the kmemleak detector.

  [...]
  unreferenced object 0xffff8c5944b8e320 (size 32):
    comm "swapper/0", pid 1, jiffies 4294670387 (age 151.072s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace:
      [<000000000759fb79>] amd_uncore_cpu_up_prepare+0xaf/0x230
      [<00000000ddc9e126>] cpuhp_invoke_callback+0x2cf/0x470
      [<0000000093e727d4>] cpuhp_issue_call+0x14d/0x170
      [<0000000045464d54>] __cpuhp_setup_state_cpuslocked+0x11e/0x330
      [<0000000069f67cbd>] __cpuhp_setup_state+0x6b/0x110
      [<0000000015365e0f>] amd_uncore_init+0x260/0x321
      [<00000000089152d2>] do_one_initcall+0x3f/0x1f0
      [<000000002d0bd18d>] kernel_init_freeable+0x1ca/0x212
      [<0000000030be8dde>] kernel_init+0x11/0x120
      [<0000000059709e59>] ret_from_fork+0x22/0x30
  unreferenced object 0xffff8c5944b8dd40 (size 64):
    comm "swapper/0", pid 1, jiffies 4294670387 (age 151.072s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace:
      [<00000000306efe8b>] amd_uncore_cpu_up_prepare+0x183/0x230
      [<00000000ddc9e126>] cpuhp_invoke_callback+0x2cf/0x470
      [<0000000093e727d4>] cpuhp_issue_call+0x14d/0x170
      [<0000000045464d54>] __cpuhp_setup_state_cpuslocked+0x11e/0x330
      [<0000000069f67cbd>] __cpuhp_setup_state+0x6b/0x110
      [<0000000015365e0f>] amd_uncore_init+0x260/0x321
      [<00000000089152d2>] do_one_initcall+0x3f/0x1f0
      [<000000002d0bd18d>] kernel_init_freeable+0x1ca/0x212
      [<0000000030be8dde>] kernel_init+0x11/0x120
      [<0000000059709e59>] ret_from_fork+0x22/0x30
  [...]

Fix the problem by freeing the events array before freeing the uncore
context.

Fixes: 39621c5808f5 ("perf/x86/amd/uncore: Use dynamic events array")
Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index d568afc705d2..83f15fe411b3 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -553,6 +553,7 @@ static void uncore_clean_online(void)
 
 	hlist_for_each_entry_safe(uncore, n, &uncore_unused_list, node) {
 		hlist_del(&uncore->node);
+		kfree(uncore->events);
 		kfree(uncore);
 	}
 }
-- 
2.34.1

