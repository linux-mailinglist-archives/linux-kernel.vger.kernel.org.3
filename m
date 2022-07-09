Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7D56C9EB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGIOTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGIOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:18:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8331274F;
        Sat,  9 Jul 2022 07:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5K25IDG68w/J4z7CHjDWocW685p95YGpI3LZ3A+Eu25nQvParBP46/K26kTT4Lra0SEbz0AuME83Gu9amzN93HgfoSG5HJln15uC8isp8AVNqCuvWMMU8vhRU3IVPmYn+NbVUqFIENdmxcwfosb1dVLV5Na5Jr8DZXJvP7HeQw+KSFORPCPnXH9xXlNyeXmeeib2+6f5O6p7W/3OHL6mw4r9uiB6q3YR5Rq6t29ofnAkXHN1RRhMCB9DelqSWMMgodrWxF/2mG8NrQtfAQZafeNWqxOvhFAywkubjX0SHOkE1moSWkEG/xl2OG8iSY+0NhK+tyBmWz3WL4edzKp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76f2SBmh7P/rRxfMHYyBcgNGlGwGPtXKjcuhDvE1FVA=;
 b=OI/R839Q6FTkkbLFbJMe5KSxPjqkS0FzN7woKcUds9uqtk3mMdsIjNTsiWUUzpFCDlFT1GE2knBCt2iLoQ8a3QDuIkPL+e2bNR+a0yi5ee2BKPv6jWCBbmmp44FQhsUW58zY6g6QRYfTzz9cH1UuXE2gEJsUaYBXxSM13sLL+nMmleqnW0HjhoehdJhenO7lCff3xkNV4tuxDhg5ZhybVUkV4PL86a/T1KYVagG1nD0zUXGGb/MzO9PlUQqaFeRRpxEwBz3PSvd91J/tzWl9ddBNR2WnGZ5BPJUSwpNPbmdFObLFJrEDn/yNh/bl7qs5h28ClrJqSObsXt1BQ5+cNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76f2SBmh7P/rRxfMHYyBcgNGlGwGPtXKjcuhDvE1FVA=;
 b=HTbS+ulD453lxan+ZdNjouR+sjCGDC/9WGgMQTh/uJf2oo7jmq04T+uGZ1GWtIV81pZSalS3PrIAzNgrgDPicrKgh/eX+5WzwEK2R7LuzqBL01kYp7t8ZhoAhiyxJyGowemuqFF31W55uZ4Mp8WnLR3Gtm70gzXCsOaMAKqd0j8=
Received: from DM6PR17CA0022.namprd17.prod.outlook.com (2603:10b6:5:1b3::35)
 by BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 9 Jul
 2022 14:18:48 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::3) by DM6PR17CA0022.outlook.office365.com
 (2603:10b6:5:1b3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21 via Frontend
 Transport; Sat, 9 Jul 2022 14:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:18:47 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:18:43 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 05/14] cpufreq: amd-pstate: simplify cpudata pointer assignment
Date:   Sat, 9 Jul 2022 10:18:33 -0400
Message-ID: <20220709141833.835548-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f5cb23a-0221-4010-7e73-08da61b5f06b
X-MS-TrafficTypeDiagnostic: BYAPR12MB4791:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmyUerNJnQfHUM+/MrPwSt7VjfY6+y3zvnoETFapoX5r+jvhdqlRbz7RzNJZUVu+Y9aLiQhXzEDuJUhSqBcEpeu0BuFkUOGn/BWWgBtaszt9YgLeFGG80yKCD0roHREME2j3OHglbdq8syz03iq/zBrPRqqmO+FF4IQ3InJUIuXViJXjr5SckUCYE49rFKxfpWimOQbqqqiytD1oFu6DBN7sGRCmbbQGnIqg+GEmmTwXX9QnfCS7a7QR06dG/YuK8DP8PXW64+jME6wMb+MdxRjZ5y0A1BcdxKwTL94wSi91LbHO3ZN0A5hPo3sZenAnPXJu1PnO1xLIDEnYxNnG1RvDU4vc4KjTUQzfdeTB2YRn7cEKDTtrS4MHWWGLjZ4BAcXjMK7W0CHbKFNV/5I9NfNvMoZtRtziCrNYQDewNa3lS8D0coC/t4iRNSoE+8lH93YSeDbnN60ZKjMldm+mn7aU4p8aaTN0qh2pqA7lAA1Sz37fVSJSo5J8nUA0BcaAoqJGl/M0D735LTR+QjYttgCY9lLGct4TtwmgvrxYTcT6un4CfHNYGLVRHLU3vjuBVBkcCLvq1tCvF8Mlk6nbHMgbfSppwNXBN9Y4x7zLgf7w5aZ5Ney1v4Jo5qhs5M5LwBB2IF7tdoAFGvfjHgam6BlpYE9j19oLtn4e6oQPV+TGS0uExPOMeR7Jn56jcycvj5/vWtd3UzFriAX+IIss3YVTpbeG7vXMo8L7j24GP1+uKZXAhVEXH3HJyu0APdSDDJ3q4gLNuZ2Yw/w1yg71g3bNCwvQcunmcd4JaLb8WIHfOP62gyvMFvcVE8Wlsl5Y+4pj5VnvXQ08562QVRgqRarwu50PbRe1wtuHv7SWD2Kf9Msf22EUlYKByDewcW+H
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(40470700004)(46966006)(356005)(41300700001)(26005)(110136005)(54906003)(70586007)(70206006)(81166007)(36756003)(6666004)(86362001)(47076005)(478600001)(2616005)(426003)(316002)(1076003)(8676002)(16526019)(4326008)(7696005)(336012)(6636002)(186003)(8936002)(34020700004)(5660300002)(82310400005)(2906002)(40480700001)(40460700003)(82740400003)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:18:47.5960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5cb23a-0221-4010-7e73-08da61b5f06b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move the cpudata assignment to cpudata declaration which
will simplify the functions.

No functional change intended.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e4904da54541..fc0de9fd643b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -571,9 +571,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
@@ -615,9 +613,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
 	int max_freq;
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	max_freq = amd_get_max_freq(cpudata);
 	if (max_freq < 0)
@@ -630,9 +626,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 						     char *buf)
 {
 	int freq;
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	freq = amd_get_lowest_nonlinear_freq(cpudata);
 	if (freq < 0)
-- 
2.25.1

