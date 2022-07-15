Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67B0575F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiGOKGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiGOKFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3197E823B5;
        Fri, 15 Jul 2022 03:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8qXIHC1gycvLjC4HVygBGjrhv9eca/AVq5bmanbDg8rUwjX3Mj1o0hCRfMEp9Bv6cQN1pab0W4sQOuQA0K2HnRgA2UmbRxWPBfiKSSBWUr0ze9aCwPR90KZD3ghdCwD3RPg8KfQ9EfHi8+WO1CvbAYia0m0C2yYNb4EtAlXsVcBfwtnPbF0NeyCi2qmK4joPl5M9o7Z6XiU3UrI+VplOu6u83y7sVQQfRKBSQAzqLRPMRfwX22bAZzQUihJijlRtR2QaEaxiVNTrD+KZBK1aCzkLKd/z6rN9/P7+r0lfFPoN29erSH2tS0K05utr4KIzQLR2qxaX6ePxO+ZX1zYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5m6E2DtFSDmFiXas1eyp5utcmdhxLyGDwQDmwN36tU=;
 b=OMT7iZ63D1bNtGtoO0caBW9vOX0Su9mbrmThhDgmze5qHqXyFpMOSR5cWh3Z64IS69IGZe8/fzU7mW49pgOoGl1fyb5+pP384y/9u+04Z8/Oki+QEO0RtteulPKFgpek+jjEeDaBBS7y9vfxovAE8Eu/8BHG2KIJNL6G/cH6Mddi0jDZ5GnU61GA/YhrXv2DOpDBibleIRthzAU/WgTBIBhKnBYDYwPvvHQXEuQ8ATe7Au25rMB/B1upvObD9e3TZFqYx/UuwkdCtSMrvdTKDSnIIZcRIdZEuX8H7aBaDoP0lxUFoGZO1s4MjSq51OVkiEzN7kGpyVDia9d9amFfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5m6E2DtFSDmFiXas1eyp5utcmdhxLyGDwQDmwN36tU=;
 b=CyUGtouJVJVf0RyiP5Y6qt86pFdAGUsH34SrTraANdaPBaNX4PCQYvPOZAGlTmYfQ6WAkpQIa44VWwXU2LgelzbJkyC3u2GVaDfZ7i/1XrPPIFNco/t1fcDeritQYe4qiMWSetPds9IkhqxWcDHcLgf46r94TfX5knhjpul8MvA=
Received: from BN0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:408:e5::23)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Fri, 15 Jul
 2022 10:05:14 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::2) by BN0PR02CA0048.outlook.office365.com
 (2603:10b6:408:e5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 15 Jul 2022 10:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:05:14 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:05:09 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 07/13] cpufreq: amd_pstate: map desired perf into pstate scope for powersave governor
Date:   Fri, 15 Jul 2022 06:04:26 -0400
Message-ID: <e6fd9622e2316cb32a39f8ceb8102336cf79a37b.1657876961.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1657876961.git.Perry.Yuan@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d379522-21fa-4f54-9524-08da664982e5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5059:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBwrBkzcX3NRqll+zFzn1GtO+YHBg6wTwJjht7OfAFCwGG2rZdkALUzntqtc34zw7qqrp2PixW9a/o0y+kssVd4x2bTPCsSeL+3bjU+by5f0xMlR4GJXBaJ6Q1RzAVnplkRE3pzCaXTUS3IY6RONzbuRnZs5TKuvRScOrOwWYorv/lrr/2Pi3klluQfkBmK71K8A5iC8yQD4pU4iobvX9E5aAtlKijOH1BhtmYk36gF6kJJAAzJeit0ORhL12oUqqtFetFTSXJcp3tzK1JdadJn65ykw4nJG/TXk7l1b4Uz9rwBtU81o5qtwordMcyDi7mVV2WjAjwZRzaCVTezLPi/tzIhQjNS7InQRTlTaTVKjetqONeIZMlPT9gpl6zoii1kX9290olWfsV0ar6gbQ/LXVNz6VleEbhRv0z4xxBALJgMf5EdqOOqk1x50hl+r5tYN6onMqHG9iCFDU6oivuASrDLrvBdJiO7VYnI+yZIWd4iZclc7ZTc2wkR/4gc/Uequnc93on5+1iBUe73jg4tUpj/IupbjUNV5jySDRk0F/3HhOIZGjkp1eEpeSxJ6+79/33PyvcsX1t5zIZzk6qC7/HBL/1e7TH1C4LGMHMrkDLuNqf/TaqSWU/ZS+bbnvx/15Lo40dxgpUC+z4pAVMXiwUb6rxtu8jkFSFqRi4HyhmcIs6IGsCV0v2R0h67/xAxzAWSFV1uxHorMp5pUVFDUqkwN7L9/fR/ORoQosrDKOyV7ntwnIlYmOKk4vOFyaa9L+xRTeAb4rvbHNQffeM6sCGhnmZxlX695Kb1rOESqQ1I3tfFJCgcHDRaRr9t8fMZgKDJk/hocTnDsS4UWPmUMTr5CeKLnkiKlRJ8xdhk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(40470700004)(46966006)(8676002)(86362001)(70586007)(81166007)(8936002)(6666004)(40460700003)(2616005)(41300700001)(336012)(40480700001)(110136005)(2906002)(36860700001)(316002)(6636002)(356005)(16526019)(70206006)(426003)(186003)(47076005)(36756003)(83380400001)(7696005)(82740400003)(54906003)(478600001)(5660300002)(82310400005)(4326008)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:05:14.0451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d379522-21fa-4f54-9524-08da664982e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch will fix the invalid desired perf value for powersave
governor. This issue is found when testing on one AMD EPYC system, the
actual des_perf is smaller than the min_perf value, that is invalid
value. because the min_perf is the lowest_perf system can support in
idle state.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4b764870035e..ebc7c6d389be 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -268,6 +268,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
 
+	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 	value &= ~AMD_CPPC_MIN_PERF(~0L);
 	value |= AMD_CPPC_MIN_PERF(min_perf);
 
@@ -356,8 +357,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
-	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
-
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
 }
 
-- 
2.32.0

