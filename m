Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9937856A8FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiGGRBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbiGGRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:00:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D530F5A440;
        Thu,  7 Jul 2022 10:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwFDsyXqtWAXOfxyJimDL17fxUuRIQB/T04C6G0fdNCDS4F7NTDouavVDTxrJoD2SLPadrZ9XAO3mVwbWxw6Biwxg88fDFtuWT2VESQ5m/RNr3OhtRIBTmn4FBvHEzy/b/G78cQZwUNIhdQQAUtCobm76DhaekzjYfTpw9C04RCfqOydFy/yuLzJGZ+GhcPf2bfPHDVp8xlzQm3t5B+qZa5KY7qYxVPOCYS4F0K87EjaohqEke1oB0/rC0YsXdmZ/7jaUjZFNGTMHeZg7D1n9s7pNamC0JS658BtZmKUFSrtkmrnR5q0L/qtxf19YUUzOq8LIC13xZSM92nO1Pktqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6TzfMK3OcoMv5+cmDJ2RkwEixU0K61j6qyFoKP/mpY=;
 b=WYJ+hrISTPHWbrzAOyNEsquifw5h3beAIUvRZoEexONfr28DTYpPDAXmR6xIBwlKP/ClPaqx5NFRSE5wMYDD5Nu43b/5Q0nTJy1VZTWNBbbsKZC+NNH/ibc/bJqsi+N41ptoJISS/iJxwzN4Ax3PW0wE93/0GZaZ/g+F2tg7ikiZnh12MNQmbQ3GVU75/qwZcUaqpCTmvyOdq0GnEIPoM4ghNUlsJqqa9JI8GZS6J0SUld1oz9vf7hK9fXLjRDBtp0qyv9Go/GQwh8BQvcCIYUT8NBQWwTeuBKVZofE9XKpZn5uqAXsEd1O7RSMq7EpwyakAvaf89w1T9M8+7QTlYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6TzfMK3OcoMv5+cmDJ2RkwEixU0K61j6qyFoKP/mpY=;
 b=s8WStfJhHh1AJ/wZjrDfIAN4lhoxFvff4bhv/fNJZo1NisewUlkbyY1DL+qN4mc7DHMYtIrh0TTk6vK9uMlw8R+gOzg9kT+eb3qno6Mia7q/uZXz+nNZuqnoF11c22PBYrhhZ+wMh63MqpPUo4/dGxWRG62JbZVazvrKHtnMJbM=
Received: from BN6PR18CA0010.namprd18.prod.outlook.com (2603:10b6:404:121::20)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 17:00:51 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::ca) by BN6PR18CA0010.outlook.office365.com
 (2603:10b6:404:121::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Thu, 7 Jul 2022 17:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 17:00:50 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 12:00:45 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 08/12] cpufreq: amd-pstate: fix white-space
Date:   Thu, 7 Jul 2022 13:00:36 -0400
Message-ID: <20220707170036.216382-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76a3df22-2071-4af4-d020-08da603a3ef2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4860:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhKN/9AIyU+l/NTWKDEcqmfEYlzSPtxb2ZFkheYLKxpk1z1IBChczSjH6LbQeaIUnt+LdEPrFX0qsaujwPZ+LpRtEXn7EVgQHe6PSCg2DciOO2zPw2dcVk3JMy4aQq+sQulCaaRM5a6ihSWyNRm5R+lLrBKi+2cVIVJnppMdTFULwWhvLPkwWtOur2J/s09Jxs+p/gBsG71jbURfMIdHdB3WmCmkA76iSyOzBsT4810BAgEbWmJv7w4CbV7RXqbmt51cwZ+HspwasXoAz8lDse0ehjxDSE/A06iFFxFK7FnxD0x5JqI95bQRh9wsNs7UUZg7dDvEinpNSSZfxu4txFLSUo/QntSjCKJqWcYjRG7Dye38ytt6P9LdQkf/bzE+3EzlEDlcgFt2BH2UNEG9CkwAkw9kprbeLDfGNtAyEX6Us3xtFVBUpagb6JhUoPf5G94HKeTIVrJVJUJRk+8X5aVsv/O2eE5+h174/fSK7yMOU6hGbmQLa3LShuLm/lOvnSFpJAZri+8/bdo2shrmyW8X5V8HEk4v4R4i/xGjP83P0L5Oa1bFOsUL27P5OI+CV/+t7Jb3k/wIM+ocKvU0F7KvxnPLdm4u5sbJkc145fRko4ugFrvEfveTpsTT5F3MEtQo6+ZXic+2wOJtwf0I/FMf0CjsVEe/RX7dYF++3pd+CK3Aj97qwAip3bV8kch3nsrF+8b/N0qLqa+99XVA1F4i/RQW39C2vV7bPmY9JH2Ps0ayfNtxqjKitT72xwSDiLrB0W49dba7x9aEAwcT00Df1FVmItqnKjU+N9QZXT514S3lriuUaElcrDAMIrSs7J65xpC8X4pfuYNGnqhimQ0C0+rCEw7GHoEZyRSX3qOS6pTTUyVjDHxx8wWCKbqP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(40470700004)(46966006)(36840700001)(4326008)(40460700003)(186003)(82310400005)(426003)(110136005)(6666004)(41300700001)(54906003)(336012)(7696005)(26005)(316002)(36756003)(81166007)(83380400001)(16526019)(47076005)(8676002)(2906002)(82740400003)(1076003)(8936002)(4744005)(5660300002)(40480700001)(70586007)(356005)(86362001)(36860700001)(34020700004)(478600001)(70206006)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 17:00:50.6191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a3df22-2071-4af4-d020-08da603a3ef2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the white space and correct mixed-up indentation

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 154eed849f38..173a45cf292a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -115,7 +115,7 @@ struct amd_cpudata {
 	struct amd_aperf_mperf cur;
 	struct amd_aperf_mperf prev;
 
-	u64 freq;
+	u64 	freq;
 	bool	boost_supported;
 	u64 	cppc_hw_conf_cached;
 };
@@ -673,7 +673,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
-	.attr           = amd_pstate_attr,
+	.attr		= amd_pstate_attr,
 };
 
 static int __init amd_pstate_init(void)
-- 
2.25.1

