Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D971356C9F3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiGIOTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGIOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:19:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92BE2AF2;
        Sat,  9 Jul 2022 07:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZA1QKsJK2EhryGV6jY4cD1p2PT7iBty3+bVnlEjYGZvTlXlMAU5/4sqTAUlrpeZ32mvMBaKVi5jZXT2d0OHk8LYkYthpspD/vQoXovtS7IOu8m91xqGH2qq58zQ2ROi/MQ9a8tuXoWg4yj9gxE1FDSlOSvzlUtpYU91EjsQyQQ7rLYpoVGe68I3hUzrtmowSuZWMcFWAbbxMIbqt2XyoMbGTVHOgUt1uwHl5OC0NFS9/Seu07nm43a4Ci1LfZY8cKZens41QsknSiL6n55QsASRz865KP9kMYaGbeZH+cHbV3j9G/QMVPbJHtmJE506WHyzZmLhRuVUriP7+eZhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9vuV1oULmeUYLC1kWRx/y2f7jNWisV4B4cSHuN095U=;
 b=D5Fmi9/dByG/ocMKvTU1dyNkjOY/+hfMhc81wTUcb2eXdP24hIIu5KgeOwMbTZl+kiLwfdJ8SEwMuHj5agOnYsml+cUMl5L+V80nNIoRw5WxhGew/CoAHA6c4QtfcM+SEyNaoKCkSXZ5c2FBPpJLnAwQCZMjcdddke+11saYCNgRtefnsPOLMZ4zqyhdyJiNjQAZYfBuMAOmoaSkmTkxmlDfi//Uu4RInVxFFr8X6VpfCAPVlCAjaUf0Bhw+bo6WQtiGjY68HxTaRAx+cILYv9hmGUVqMq7elrN7rgarGZGFfUCPNkfspxw/hocrNDU1Y6HqMuLpPy8nwnEvloHGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9vuV1oULmeUYLC1kWRx/y2f7jNWisV4B4cSHuN095U=;
 b=b2WoTqpJK9Q/axiL2xRmP96dvy+EZdG4IaZ+bnYbFa9Jv7nOXusKI+Q1a+jL9Ox6orAgTKTOiVIKScxKcR6Kzg7FUkCgwnVp6T3XeTp5HHzzjXevi6Xaknu6LVirAwhVwLIAJIL1CEiU0Vu8h6YPiSRS+U1afLSnNvVdWGXGJKs=
Received: from DM6PR17CA0013.namprd17.prod.outlook.com (2603:10b6:5:1b3::26)
 by BYAPR12MB2904.namprd12.prod.outlook.com (2603:10b6:a03:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Sat, 9 Jul
 2022 14:19:28 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::ea) by DM6PR17CA0013.outlook.office365.com
 (2603:10b6:5:1b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.24 via Frontend
 Transport; Sat, 9 Jul 2022 14:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:19:27 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:19:23 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 08/14] cpufreq: amd-pstate: fix white-space
Date:   Sat, 9 Jul 2022 10:19:14 -0400
Message-ID: <20220709141914.836074-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6c060c5-b1b9-46a7-171d-08da61b6084c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2904:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBBFU09kcotqnZRJ2tzQKHV7wFwWPOmJ2o32OuCVkawiX1lbdfmwsc8oJi+1/rCn/4/Reog5WTwXQqEVcLIKP7w1Aru5YeD95Jh0nr5xh+pKj491vymghIaQ6HFIf4i/+PcQHnrbIsz0095ackIQOx8pWfmVk6MMIeDF6QYDZD+9n2clod3Hf70iI4JU23+ZHb2GCKb9dv7W4292gsCnV9/6w/LC7EpHmuzx79Gz8fEluLNCcoBv2g+knKMsyjiJz4Paky+lr7myyw8ubOxcGqWmDKW4Ns/0c/w9OCSgcSc9Hqb46llb4FQhIVM00sZQNdTjLnQ9amqPa8wHBu5IcaBP+2U2klK0BJQ6pOXu0j156j5bhvzppiy/tj6e69z6ZOcKOFk9wV75GH/+fID09kdLP1DVx3pghwNY9nwYxG6AlR3oA8vXPU9rOvUEX/Qm1OyRw2HsUg8TrUMvs9AO0yz9O3MClBcm7KTUk+t8Dl6fXAdUsXapLom97yqzqvWANUuAtvur7VYDObs1icaAUUWcPsOSHqR2JGMOTVmPWnh+f7U8IL7OBAbCxPQZ7J5AI0DcMkLJIjXKLs7HmWAYQqkv6F+FKjqv9q8crxSndFciySKCq/GltESmGI1rCouGJ06jRijc+qSq3pHbQ86aCYer25ucU4m9Ef5oKTmwyt8p2Me6qXjqV7cJjlXv3N+hIx+dln9qxVvlF4fIRDpuYMbDfnV6/4o/s4QHz1xZ4XBTroy8AytO5nw5O+MoyZxWPX1/95n8CqLXZLseqwxN3KzKhXIr7ZCR6bsYX50+X9bJsJZaHKGxA85y/A3KXI39fpVJZPlypgI0nNiZtnpjR6LtZqJs2bK/e+kHaO/1qqdmooc4CEIL98HlH8hBiUJo
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(40470700004)(36840700001)(26005)(1076003)(316002)(81166007)(54906003)(478600001)(8936002)(2616005)(6636002)(110136005)(40480700001)(356005)(82740400003)(82310400005)(36860700001)(70586007)(70206006)(86362001)(336012)(83380400001)(8676002)(41300700001)(36756003)(186003)(2906002)(426003)(4744005)(34020700004)(16526019)(5660300002)(4326008)(40460700003)(6666004)(47076005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:19:27.6555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c060c5-b1b9-46a7-171d-08da61b6084c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2904
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
index 8a2b6ad9b8c0..da20e17a140e 100644
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

