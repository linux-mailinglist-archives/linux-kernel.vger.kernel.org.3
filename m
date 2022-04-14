Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0A50198F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242929AbiDNRGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244615AbiDNRFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:05:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9375F49CAA;
        Thu, 14 Apr 2022 09:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJG4ki+jhfEOqoMYzd8CkEyGPl2+ErAGuK7AaTQz8umzjRo1oDWMNGvM7soJb91hD3zF1drS2nwMuAeZJzANf3xRIhpWmHv/vqiAN5Sy/eqKjxfgmQz4UjFhzPUOAo4Aw4GeB+UCF57cc+lcGj/j/gQeuUIAD9lsRLWdLU8wLYCnueWdQJwSrZ/Y8ME7BTxItipslXGtyis45QVD4cScxqo469brE4P7qJImVp39dW6ywm9gqLCv5SxrCGcF0bpj7FHj6cuY7iV59PfM2paf2izXz8teACKcuZ8P183BiE0IuENKgi+Pu02dT/IC2dNENvZsI+yR8XcaPMzsM3sjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkgpigE1LvaXonsaJ8J779zuU+/p6eVI11s0hWA+n8Y=;
 b=nMJM1namw2FUWb2vJApbSir9inWyVTGPbwj9ATaE46m7UISvpuusvYMwKwP3Dd8VQL3J/UqAkVAoXZbInMsXf1mRcWQxip5+7z7uegFg7B/XuTypJMBzwylRmGPY7d/NqdkQkf4hHIyCDdSsSKLqRlhHWKZdxeCEDhQIkFeiXhkalBXhpnDPDeVl0hVLYC6e/IaxAgWOqZAtkKa3PxoeMgl5cu1YBaecFPZX955QZjRAd27EYxuX3rf1uBugTycuQCEUTN8qxnQKFV2yijDOX0zj1LlBZ7BljwQD2yMy71lFBXI8jgxMvfVZ7O9zQAjG7IjnFRBes8wk2KSTVvi4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkgpigE1LvaXonsaJ8J779zuU+/p6eVI11s0hWA+n8Y=;
 b=znvlv7uXUdiBQ8JU9f3PA3YYZFBnMmuNuWh9ASrdqS+Q3QP5BemJQyR2b7Do9M+8kMPKAu8RRMsiLuvELVbz18Xc5XFa8woN3a8KgCWU9ewVmw46Vr+e9OMdXU9xi8z0mA5W+tTZglHdP409oqLnPVrR8DzVXRyT2w6UwN0HfKM=
Received: from BN9PR03CA0780.namprd03.prod.outlook.com (2603:10b6:408:13a::35)
 by DM5PR12MB1371.namprd12.prod.outlook.com (2603:10b6:3:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 16:48:14 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::51) by BN9PR03CA0780.outlook.office365.com
 (2603:10b6:408:13a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Thu, 14 Apr 2022 16:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 16:48:14 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 11:48:08 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rui Huang <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 2/6] cpufreq: amd-pstate: Only show shared memory solution message once
Date:   Thu, 14 Apr 2022 11:47:57 -0500
Message-ID: <20220414164801.1051-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414164801.1051-1-mario.limonciello@amd.com>
References: <20220414164801.1051-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 070996c3-2ff2-4aa5-4e17-08da1e36916a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1371:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB13711A597880F25B80301E4BE2EF9@DM5PR12MB1371.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAjzNGM7Q2uM0QZ9j4/t0W5cewILjusodtk2pKhE1mQ4JBedQnAfsNZl9o49f1NjRZkSprz6sa8AtGQng6urVHAF0nYub9zlBKQ/WlpwDWonX6QV/Dk2HPBWUIszCy1c84x5SIMllMfm8YGvwUFZTxD+/1Z6f/jgNpDGT7n4kQg4VIJqGe7EDrpi/NPKd8Jawp2gP967XRccWiFfcq8BPdcRViIjtXGaxFeTAXvkVxfGYBVmF+TK9OwzTr3WAecJMGSp31i4jQ8lcoz2ikYZ/hJPGd74Ja+hsE0TDHmo/peAtiJPlo6URIoYkbXYX9dsY7TGsFwp8GZwZKHdQ4N7BColgpEQPDWih2LsUG7TlSMZURmTKC7hgQQeFm8aFdPZcIBTtT3q5E/vcBiCcilGOtIFsEU0ZFYw1voEcf4WVykOXGhgZuEzAgcMaVLKb8PScjiJ6hqRAWhLhkLnrAbzmBr1k2fLux3N60q0b6POO9CgLrzRYLLkwQ5F2CA8pridaaMXFCsMraHbZEj9ZZ2YS5j5mZhDA6KxmRg0V6ecX63VspED8m4vuCCnmqM+It7iCRGtKvXBvqR9ygrwDtzfgvM6isq5SU6vBBDwbF9Qb1G75PsslEgdoKMssdOX7q7meI9UDTvfwCqY/y52pyncU3DmCPYvKGezpN5wHd+wJFqkR95ppr90hx15MjBuDBos9/kxFCJTOZ3lZlqflVypPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(8676002)(47076005)(54906003)(426003)(4326008)(6666004)(86362001)(508600001)(36756003)(1076003)(16526019)(5660300002)(44832011)(336012)(40460700003)(110136005)(316002)(8936002)(186003)(26005)(81166007)(7696005)(2906002)(83380400001)(82310400005)(356005)(70206006)(70586007)(36860700001)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:48:14.2451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070996c3-2ff2-4aa5-4e17-08da1e36916a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A message is emitted to let users know they can enable shared memory,
but it shows on all CPUs.

As this parameter is system-wide not CPU specific, it doesn't make
sense to show 8+ times.  Modify it to print only once.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * New patch

 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7be38bc6a673..ecd1fd5e5b5a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -666,7 +666,7 @@ static int __init amd_pstate_init(void)
 		static_call_update(amd_pstate_init_perf, cppc_init_perf);
 		static_call_update(amd_pstate_update_perf, cppc_update_perf);
 	} else {
-		pr_info("This processor supports shared memory solution, you can enable it with amd_pstate.shared_mem=1\n");
+		pr_info_once("A processor on this system supports the shared memory solution, you can enable it with amd_pstate.shared_mem=1\n");
 		return -ENODEV;
 	}
 
-- 
2.34.1

