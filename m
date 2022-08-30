Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B5B5A590D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiH3B42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiH3B40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:56:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D2A7AC31;
        Mon, 29 Aug 2022 18:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMUECIa3yF1V55w1MH/QMjzKDTiINgxwfZ0wenJ6dz1Q2IjZEvm1ioUXDj9e83shhVkuvilvK2p4PrQOzzQ2VVE0Gc/7melZNURx44hNhZp06xlbNUHfsu52008f71oihF/B9wMuDJwtcRr3CndPK/gzhpWdLk4Yo4/sFH8zdVLNXBxh6vefqEUihoinZGeceWB1h/n36lO0pesZCZYFOI1QeV4OzI3+PnqrTFEihCHRtWK8OBTfAYsVd/ps+Ih2HoITFt2rC0PTiR3W3PU6t+2jaEVjB8XH4rSdbmK55/y0LiVcUsxmybpTcsqz79B5dOe0kjV6CMqw5/51NCH59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxJ1llotJeDEk3OWuUNdKPrRuww5QZM6IQAJ7sE/bW4=;
 b=e9eQ7Iu//R0/Nkpl3iCJfMjSet8UgraiLalKWJYMu6GC2jAJeQuMWAcd97vwik2xYu/xGoDGZP5OK5JHjncSdZQMscvkcpqZtRl46W5gLkcFwDUGJOf9BJSQy2xdlTZM0w9JjpFiYKXwohIGE7KCFz9oXbmnrVlxcv/B/5aa+javrXgxXpaGZO5xKclVh8228usxtE6qiKJuRcfHNtdYks4HhPBRKatiim0ABZhsF8Fwbo4NCNLRGrK6AARxYB3vOQNU74JRuG1soYvmgofQQzphdLvJ4Z4ZBqP9z5FfmyjJny/uOTn1nVrMgLeU9LOjU2e5Oo5y3DvBb06NK+iIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxJ1llotJeDEk3OWuUNdKPrRuww5QZM6IQAJ7sE/bW4=;
 b=AoRYSx4q9YMRUSXCGGtQ6bp1IGzHOxDAwlwLEMUaFQk+Uw8BtFyJqs9wWRCa5kKIHBZZpuPTzYf0Iz+4ad9J+5ST92r5FDavjC/iRuO3XjXro3kEvwLMDzF0toHp6btd5P3G5Rs53ebCMSdOXLc8Qp+UV2aogswH/j5ohH9BXgw=
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by MWHPR12MB1696.namprd12.prod.outlook.com (2603:10b6:301:8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 01:56:21 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::20) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Tue, 30 Aug 2022 01:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Tue, 30 Aug 2022 01:56:21 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 20:56:17 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3] cpufreq: amd_pstate: Fix initial highest_perf value
Date:   Tue, 30 Aug 2022 09:56:00 +0800
Message-ID: <20220830015600.373537-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eae1465d-8969-4c36-36f5-08da8a2ad688
X-MS-TrafficTypeDiagnostic: MWHPR12MB1696:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gG33z2XIuRg/XhFTpqvDszyf6kf+rIIU4oaykjAflRNJQqpev61wMdIIBiYkX4ZJfmUdIxcLkjdTlO2JEnu3wbEzSYv1wmG8hP7wnF9/DmTBOkk1qZnE+2Xgz76jcelqAy9KaycxkMeguxPTTod19YtH3HyLLepeo00kMZGR1vKVWzdeCTcy+l1Y3NZrzRuX3FG1dGqzjBcJvPQvHR/j2sVbCFael7lBqkRqPzWi6KGs8bwJEqWWO7FK8rHc0ph+aSWMp4e3ffp5KFoPuULE9rvuNM40jD0OS4fQnXY0HpDh3a5fZeDW6u/bkOC6C87Q4ElP8infEr+3Iym2HF+mmPIPTZ/ibzm/pGlu4f4s2f+QF44P/oVySyMNVLcxmROttYBJNhMDJ1GeqhYSdg/46+p6i/0u4Ej1HAO/ZSL6FZQieGdIel50/h/2Ex8YhH9vBjcemW4rHbPdoPusTF7XFaFTeCkK3WxITcU2v2CKSjkTsKJ1JCC6iCs6iMtvZIMPCcGIaiNi2P/k15NMdIp7qDU6h19l4OcnJ+NyJjlVpU3OWcFV9YB+vnFF2AxWPDAPtPSu8AcJsHPHRt42PjxT9vtTZrfbGnRcKwUk4byb7glZYVkHTlqNUE/jfdTxYh+oxedDIsXQgZi3XQMuD7cml598q1wp5d1/eAqlNZZKxaYIZ5ABXTQ2n+C3Y0GugGV2Qap82ASuwSuIjQzw7wu90I+cGJrqs1f/JZoDxkxQd6lKufuGLSphxvTkasJyekwvlNLtuW9ahCkXIM5xKbAbrsPYC+c1RkWIXs4wgjJAIZF4/UzinQJulWA1uDD3UUWCdpFFBIRasSqdcnOVXqhdsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(40470700004)(36840700001)(16526019)(36860700001)(8936002)(5660300002)(40480700001)(26005)(336012)(186003)(2616005)(86362001)(1076003)(426003)(47076005)(7696005)(6666004)(41300700001)(40460700003)(83380400001)(316002)(54906003)(70206006)(2906002)(36756003)(82310400005)(70586007)(110136005)(81166007)(356005)(478600001)(82740400003)(4326008)(8676002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 01:56:21.6826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae1465d-8969-4c36-36f5-08da8a2ad688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1696
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid some new AMD processors use wrong highest perf when amd pstate
driver loaded, this fix will query the highest perf from MSR register
MSR_AMD_CPPC_CAP1 and cppc_acpi interface firstly, then compare with the
highest perf value got by calling amd_get_highest_perf() function.

The lower value will be the correct highest perf we need to use.
Otherwise the CPU max MHz will be incorrect if the
amd_get_highest_perf() did not cover the new process family and model ID.

Like this lscpu info, the max frequency is incorrect.

Vendor ID:               AuthenticAMD
    Socket(s):           1
    Stepping:            2
    CPU max MHz:         5410.0000
    CPU min MHz:         400.0000
    BogoMIPS:            5600.54

Fixes: 3743d55b289c2 (x86, sched: Fix the AMD CPPC maximum performance value on certain AMD Ryzen generations)
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9f4375f7ab46..30fbd30c0949 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -354,6 +354,7 @@ static inline int amd_pstate_enable(bool enable)
 static int pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
+	u32 highest_perf;
 
 	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
 				     &cap1);
@@ -365,7 +366,11 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	 *
 	 * CPPC entry doesn't indicate the highest performance in some ASICs.
 	 */
-	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
+	highest_perf = amd_get_highest_perf();
+	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
+		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
+
+	WRITE_ONCE(cpudata->highest_perf, highest_perf);
 
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
@@ -377,12 +382,17 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 static int cppc_init_perf(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
+	u32 highest_perf;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
 
-	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
+	highest_perf = amd_get_highest_perf();
+	if (highest_perf > cppc_perf.highest_perf)
+		highest_perf = cppc_perf.highest_perf;
+
+	WRITE_ONCE(cpudata->highest_perf, highest_perf);
 
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
-- 
2.34.1

