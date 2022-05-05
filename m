Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBBC51BD7C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356077AbiEEKxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiEEKxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:53:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA4A15FD7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkGUNNs1v6a3pfrLVn9VojH5lIWtgII0zdjt0y0YS80cqCR/tCtkshM2gi7TPHG4+YwOysIrXNmAnBBO7k+UEHNPPWj8zCP1KoOoHK6xOc80ntTcWrp/rpG1aUJb5VyiiMpyj9EbXlVou+imHuJ4MEbXcc+ZkR4yLMK06GYZemeOWIS+BjRUN/hcIv7AqsuaoEgG1JV30NvpVvWLBt66v35eAuTmsyCYjHQg1S4eAr63TpddwOzIHU+Ie2nfGlADfIuuwp17kZdQrorljMXquQhg3bGdNw2yMK3jFQlzDEZeQkOKx8Pzx5hI47RhcGdZpYLGW3lwTMI11rym4T+Vrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qng1Uy62fv0a9tbuZ4sC1ezovZF/l8WZBl7qmCl0dMU=;
 b=G7huiRRNIWLQkTdj/USF+8b7WjDU48EKQlbvvobJLyLFCXPf5mZDTEv/y18Kym2061fiUYlUp5ILLyaswIBG5OHVuweS9u4tKWr4lfa6dYCQlD/d23hM8cNtHNAzJpeH8BUdHl6CUjb9Saf7rH8DCEHh6tpvc8HwVaow+2GGOKFw0eG699QZb8QObcJhe0Po3WXNouKHq40rUfP4IeGWhft5fF92feGQXg55pZSM3FHDAEimJiKQBJs9driIrjMfwtLgk/b6mbBzZSYsuMNWjhgPFvUFWhvMzotQtZk+cjNrQyZYXq/VbXR4sOVWYNHYofulZw5HtFYHEmbFbaIJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qng1Uy62fv0a9tbuZ4sC1ezovZF/l8WZBl7qmCl0dMU=;
 b=hdxcp6e3ioeWAbsD+cJ5n6MrkdZnRGX/HT1qIUWp0VHc0ZXz+Pu1jLgUzjlhIolIbF9rSZPJgtuCYluklUY+XSi4Dv39bYRftrsJw0/ESCY7EY7JSje5De3ymE/dM3H2lE8vJZNm9BZJquMEeX4wbTKv11/ZYSG2UHiU76RK3W4=
Received: from BN9PR03CA0152.namprd03.prod.outlook.com (2603:10b6:408:f4::7)
 by BY5PR12MB3649.namprd12.prod.outlook.com (2603:10b6:a03:1ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 10:49:41 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::c5) by BN9PR03CA0152.outlook.office365.com
 (2603:10b6:408:f4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 10:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 10:49:40 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 05:49:33 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <Lewis.Carroll@amd.com>, <Mario.Limonciello@amd.com>,
        <gautham.shenoy@amd.com>, <Ananth.Narayan@amd.com>,
        <bharata@amd.com>, <len.brown@intel.com>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <peterz@infradead.org>, <chang.seok.bae@intel.com>,
        <keescook@chromium.org>, <metze@samba.org>,
        <zhengqi.arch@bytedance.com>, <mark.rutland@arm.com>,
        <puwen@hygon.cn>, <rafael.j.wysocki@intel.com>,
        <andrew.cooper3@citrix.com>, <jing2.liu@intel.com>,
        <jmattson@google.com>, <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v2 1/3] x86: Use HALT in default_idle when idle=nomwait cmdline arg is passed
Date:   Thu, 5 May 2022 16:18:54 +0530
Message-ID: <20220505104856.452311-2-wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220505104856.452311-1-wyes.karny@amd.com>
References: <20220505104856.452311-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28ec6091-e5f5-4562-ddb4-08da2e84f4fa
X-MS-TrafficTypeDiagnostic: BY5PR12MB3649:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB36494E02807CF402A4F6ED5B84C29@BY5PR12MB3649.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4QmRWwIi9YkoE9GGnjvgb99uPg6mDUrHGeVCuZHYGGagO83fQ20dC30wzVYg2nmy/Yt5HTwjTkkhKSMU9hfRYdDjAPhEqdv/bGsnbd6giLEFlfBaq6IS/MCYc2qhONGNWhyzcjaR02kBrbk8fuPLGNGgaHJ/P57D7DUQR6DTlnqUKaDolF8njPilLZMJvW9FNWU5TeNxFx/vJYAVUhjK5W8R3BnsHiOXv3Jfye4F4Bjae/mvJQo/kPI2T0H3LXbJpGa5m/CuEu6ataP5VXZJNqGQDs5DMH5e7Eavv38zLTXhz/yghAtEOJYnziNm+eNgl3rVuv3sCnZ70xz3Jwkny2il9WU6Ye353YrgSVDgQszyWE/7CpBKAozV4q4I4LOhh3MhOrJCPn1zcJHKQpFZHWX6qXOqI9m9HNgKsxNk2UlsPVHM/gkT4Fdt917kzy2FznRUJ3kDd77PQeLRhDJxDep17XJG/Z1xGfPSvUxi8Mm2fvbcfQ7SoXTjXtly7drMD8ys0QlIpuGJw+2CZ8GHv2am9/VBZh9HnQg0Rld8YhrZS3rhKVGgi+mMtzYPrfEuPhvI8S+DXjNHcQQ6dt+MI06KX8+z/gyZR0q87hq+f1HuWk3EA4zJCKFcqjjX4JrbwaA3BYGxA9NH87cLWHxYt338A2QlPeAL8AzyL1A0J6+lIC4pfXjV0+oIuIHRrZ1vAj4Wuu7B3guaFG1T9jcMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(86362001)(2906002)(508600001)(4326008)(8676002)(70586007)(5660300002)(70206006)(316002)(6916009)(54906003)(7416002)(44832011)(81166007)(82310400005)(356005)(26005)(2616005)(1076003)(426003)(47076005)(40460700003)(336012)(16526019)(186003)(36756003)(6666004)(36860700001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 10:49:40.6363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ec6091-e5f5-4562-ddb4-08da2e84f4fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel is booted with idle=nomwait avoid selecting MWAIT
as the  default idle state.

If the user boots the kernel with idle=nomwait, it is a clear
indication that they do not prefer the use of mwait as the default
idle state.  However, the current code does not take this into
consideration while selecting the default idle state on x86.

This patch fixes it by checking for the idle=nomwait boot option in
prefer_mwait_c1_over_halt().

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
Maintainers,
 Should this be marked to stable ?

 arch/x86/kernel/process.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b370767f5b19..49b915d1b7b4 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -824,6 +824,10 @@ static void amd_e400_idle(void)
  */
 static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 {
+	/* User has disallowed the use of MWAIT. Fallback to HALT */
+	if (boot_option_idle_override == IDLE_NOMWAIT)
+		return 0;
+
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-- 
2.27.0

