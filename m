Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CB456C9F1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiGIOTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiGIOTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:19:44 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082C011C1A;
        Sat,  9 Jul 2022 07:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVYQ/adO9fccw7YzMRpAFgctaA+q9yMcNWM506UWe3OOjXxY7+6G0Ep8oegIyMCOxZN6EhsuQpgT5VxN5K7KJpuOgNmeXlE/g2EsPSrg9fyuDxFIkxcp9AjxfFujEm3udU7ZB1b3+LTeOHQq5u6yeAELu07fp/ZSCT+JUK1Zep92MagR/veXwKhPPfL9/zB6eyRAsBEYiMvO72QIKq1LuwaeL+BeLQnR0Spe04pZj45D7OzeHd6qRKlMmrWz1heM2/oHUUiHAXPgVO8JQX5zqWTThawgmeba2NypU/9oxKEtASPT1JyQGrAZWWi42qp/wr2wnLEXB75PwxyGWzKQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g85sf/FDa67tvG0ofgjHGoccCDR0ib+49QUF8upED0c=;
 b=GMN/H8DTZl1WKSara7diyLOMqw8/82m+OYioF6U6SEd6KJwt2h+QXldSiqPAICRzZ4ckACcwNh8LS0obLP4L6vuxdaD3PFbRSFEgxUidtUjjhSF2FCJzgrRYg/cS6TCPjo8+5wxT+EY13zpF7FChwfXPZSr1bmoZpUqDXOEfl1Jt4hJm8xaxSCftgN0zNUvEJAEMZUci7iFkCcvhGVL+ivjas0GvyDsS9NPCaZ6eFFII//dCivfmWVAqr2Y0o/LHzt1mwJ7YfqZ9m7eiWg2sJnXaJetQ+YNByL6KoVgL+REs+YF1G/bqY4C2n4bBq5kYIToEubwZXhW1fdA0nZhG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g85sf/FDa67tvG0ofgjHGoccCDR0ib+49QUF8upED0c=;
 b=Jfh4EoaF6GAQA35GG7xlFb32mj96tLoxzHe6R6yPcn8vUNGrm2z4x6qi/8UtOrRKYaeeQtPkNt3le4qbds3AK7ffpb1AWkIS5Xw+Z0DusWpLpsX8ixxmH+JQqSu/SLDIk6PqckhPd+oXYcpBHzr5I52WWwZGUvf7P2y1wyxu4KU=
Received: from BN0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:141::31)
 by BN6PR12MB1843.namprd12.prod.outlook.com (2603:10b6:404:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 9 Jul
 2022 14:19:40 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::6f) by BN0PR07CA0017.outlook.office365.com
 (2603:10b6:408:141::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Sat, 9 Jul 2022 14:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:19:40 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:19:36 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 09/14] cpufreq: amd-pstate: update pstate frequency transition delay time
Date:   Sat, 9 Jul 2022 10:19:27 -0400
Message-ID: <20220709141927.836240-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bc2e4d8-532d-4257-ecc4-08da61b60fd1
X-MS-TrafficTypeDiagnostic: BN6PR12MB1843:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83QI13092b/1DOdEDjR7l9yvYMPNgXynaBWVnP14lZQ/SDlTWFj2lf/REIbcAA/dXCbJfuBzxGAmgiu0WO5OniJOA6V1i0l7vICK/PhqwNnqGthy1eVPo+Xi/xjwagJZtScTJpjCp/Zb8MPi21M3W3DYYZl/FsvpbBixy4jDMTVFmq19anSgfyN3En0VY3GEWxvmPLXklH7hgsOzsk1q6Isx8L/3aBXTMOsv3wMo/DryRqcJPWSMd/XqgCtQNA3IWrAVT7KDA83/6mTNKxua0JFD/IiRLvjbvgHc+fv8xZBJhwhSvM88X6ZEm9ZH2po35x/rkeGsI0w0peG5Wxtg5xurQl1hHnkuLw8bvNe5MA9C8XpmCKFr9xzA9yDGV6XPErTBXsh8jOrK3zvqotlENAP7AGSWDpw9OqakK8ecUI7dSYYWHIf2jPQQ3wC5pyb+8XVhG5c+JuVeZ4+DmJVK1Ms53Ef9apbW+KHuF9iy6SpyRUD0tV4jj21CYANYA2T/T/7axtEXMKvMfK+BgPx57Q0wiaoy4b9Puq5+wqmFKoBp5r4ZGhNtgDRnTvkd6mdenrBnrOjI9kcKdTzxbR2Nmfumr+E0PeVEgBEnlFK81urZ24OV3t/m0GSqTJAr9JlBTOXMcEnRw9t8uCOQ8CjpBt/kbz7YJNJvxzNhvnzjRKnO371mYtRS3mUU466HuuIeQKDu9+WxvwYpUfDBSZwGTd2gdF1v4j6xz70qOKkYBlLj++Z+D299mWg4JbQpewnZWAAbwgcPWreL+YBTCvVXiTzI5j73+eDDvdhiV53a8h2dvux+dI8KlRroEMeMgW85qJX1z8rYhVMEVCfnre3nZ1Eruw4lT/5PwzfGmX6cGuOgbEsaLZahoJg7rMl2csF7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(40460700003)(5660300002)(8936002)(70206006)(81166007)(86362001)(356005)(110136005)(54906003)(6636002)(47076005)(82740400003)(41300700001)(70586007)(316002)(4326008)(8676002)(4744005)(40480700001)(2616005)(36756003)(336012)(186003)(16526019)(6666004)(83380400001)(26005)(82310400005)(426003)(1076003)(2906002)(36860700001)(478600001)(7696005)(34020700004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:19:40.3079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc2e4d8-532d-4257-ecc4-08da61b60fd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1843
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change the default transition latency to be 20ms that is more
reasonable transition delay for AMD processors in non-EPP driver mode.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index da20e17a140e..21037935e869 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -41,7 +41,7 @@
 #include <asm/msr.h>
 #include "amd-pstate-trace.h"
 
-#define AMD_PSTATE_TRANSITION_LATENCY	0x20000
+#define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	500
 
 /*
-- 
2.25.1

