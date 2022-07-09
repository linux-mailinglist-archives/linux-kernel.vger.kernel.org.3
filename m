Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88C56C9FA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiGIOUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiGIOUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:20:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CCB4BD3B;
        Sat,  9 Jul 2022 07:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFLnOYQVai4EdEmtJHwM5biCf70AzYFdZQQFSVh4FuBX6rez5cQqlNQUaC6cOMSkgwyHSqvJOdgDk7Ip2vYneTlcGVldiipHoTZILUCBGOOSvZRCVI7qHl5xXjw7M2MXRYgS3f7M6g3gFhtTi0hr/uW+eSf9jzEk5f8pO1pH4Y4I3oSLHQa3cU/RbKahPQxXRi5I5WR3HLxMMfz+k7iH8KUIhZOZgANEMFjIE1+TxjYGSKyRVF2+hL4DbTp1cs4Y8Z8dVOC+44U8rxLubm+Ac2QoA6KBU2xQomWusvucI+BwyxNOjm6VKq0879wJiIJVkK/KtxBUP1TijEyN8rg4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCHSvHPRC6KFdt3ifzaVDrVQ6o5jWOzI99fmre0O6J0=;
 b=O6Zur6WlIocZxTBnyJR96nn/RzCHDqVNFHaCWbbnI+Wy+p8B3QkL1EbetRbUmNO2hvGk28p6aJ96DP5+hMeV4HNIFsvM3qnZAykGoqnWZh2dazQkXY9UJjF34jZf0/IS+qTXfMaQX8Np+jtn1gmLYAYNwp6JpjC5Q8ACG6n7sxTXZ32YkalvXsmeUD+WS3Si5EcAefuPBRidC5o2ZaqGsMrQ8nULZ1zoSj4Eef9MUsebuxPbnCInOCR6u/aO896U4ZC7B4bC78hSTEpHYosIl8h3Qg7CrRPU6lv+Nq7rb2euchDo94Fn8WhmoF5J2c/bNchkkA+CSwC75f+sm7pvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCHSvHPRC6KFdt3ifzaVDrVQ6o5jWOzI99fmre0O6J0=;
 b=2zra7z1yCGgtO7bGBQoymbslwM8VaY1DqOEfA5WnpekptasudY4nNnbtL/7mliJ3J5JB6AZ3EIR9bhLdX75kbb8IHsFGcuMyjUeweK/boZhJPxsuOSO7eY1ndC1Jp6QMofb6hh3ml/IzZnfv2hiodHNtAag+iE3cPbR/LXl5pNI=
Received: from BN0PR04CA0186.namprd04.prod.outlook.com (2603:10b6:408:e9::11)
 by SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sat, 9 Jul
 2022 14:20:19 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::96) by BN0PR04CA0186.outlook.office365.com
 (2603:10b6:408:e9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Sat, 9 Jul 2022 14:20:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:20:19 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:20:15 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 12/14] cpufreq: amd_pstate: update transition delay time to 1ms
Date:   Sat, 9 Jul 2022 10:20:06 -0400
Message-ID: <20220709142006.836754-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da8fb208-f139-4f19-46d9-08da61b62700
X-MS-TrafficTypeDiagnostic: SA1PR12MB5615:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfLCS8WzaEW9Af/Q6072OcXQjhukv8utI6Ei4iLglGokZTjzsiAIHGArpp70VMGP/t2b0VNol195HvymK3ilLLB1Zbbc9FG/n38OZc9Xt97e31/vrw3O1JSe+tG+TpTDNmHVJNiFwSi2olHtk5nwu1jmiXu1NYaEvf/jn9YS4s+OmZZMBmmS6SVa3W5d6LqzpIijZ5bgQK8FrEvHFBmvAa4zF7Fk792bIm6C/R2suAvSXl4+nQCh2FiZyWg41yZgLxoDrRDqrphrd/nZKV//TYZn7B+E5Rr8e98k+a+ClUNXapJqmWHvdJy5id71VD5Z5Iz06cfq0o1rRyqz/CGm9Naze11bUwV+NcgNB1KwtXa3c814lM/RTCX0Pnhqmy8m4mCJjjtVgTmMCU7N5X7MYLg2M+tdVP1986ycAMWsXdS1vo4pPFy5wtcEPrc5P6x4to0Xz9Kx+GHJDM5RAtQ7gF3jH8So61czO9bx0HjM0kr5EPRuv8DZ99LYtIdwj2hy5xXv1y9ycTvaTNTCXAnrYJmDQp2ubAXAIiAtYoo85KLor1ga8ebvWGmcLcSwf/PvpCuYd/TTUqRTPgdw2P8wi6pvWVINlYt7qrj/UEczDxWHjQW+K0ekwAUyp2I5djO2xsauXBnlvJwHG0ZwwcU7pb6ahK9O0hDGuwW7xofIJq17LupGG9I61mtZGE1g3G1651qF8wfGOoxLoLTuyJqmdyfhA97bNvwhnjpwhH5g7Fw7pnyKAJMQZhiz+t477Sd9etxAX/QaQb+l2InVDbtEZzQUD+OER+1JY+a/L7uYbpCbOzeZyJ32gbLjI9WNWYiVfeUdB4s2AOvDGO5MOe5eFJ8BAqWS7uEr3jv1+jMIDWeu/0ETi9A6dsdq12Cc9P2c
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(40470700004)(36840700001)(36756003)(86362001)(81166007)(36860700001)(7696005)(34020700004)(16526019)(83380400001)(2616005)(26005)(356005)(82740400003)(426003)(186003)(47076005)(336012)(1076003)(8936002)(41300700001)(316002)(54906003)(110136005)(8676002)(70206006)(478600001)(4326008)(6666004)(70586007)(2906002)(15650500001)(4744005)(6636002)(40480700001)(40460700003)(82310400005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:20:19.1993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da8fb208-f139-4f19-46d9-08da61b62700
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update transition delay time to 1ms, in the AMD CPU autonomous mode and
non-autonomous mode, CPPC firmware will decide frequency at 1ms timescale
based on the workload utilization.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Su Jinzhou <Jinzhou.Su@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4c600cd7cb5b..8ba4b98b7108 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -42,7 +42,7 @@
 #include "amd-pstate-trace.h"
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
-#define AMD_PSTATE_TRANSITION_DELAY	500
+#define AMD_PSTATE_TRANSITION_DELAY	1000
 
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
-- 
2.25.1

