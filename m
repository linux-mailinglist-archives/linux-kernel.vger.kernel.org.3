Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584A4575F14
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbiGOKGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiGOKFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2382FA1;
        Fri, 15 Jul 2022 03:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Klvv8E09ggdKzUIJDSArKitNAmgn27qp2+nxmSsbFGiFMYMnB3hyU8xsRdmw5F9ibe8BZRQvdkp39A7xFW/hy2uvMwzArFaIg35UjoWksB029hAyaDOLtrzjBzmU1jo+ZRHJfxUz5xodS1KQ+SrTFG35Sfdyr3i7vIDngbZWQqgX2HwHHE7WskTyGm6jOrGydCXRG7DKo5OAsT0wnb/gR2qmqHViEDik0qXhW4FECUhXPLd38dm5l8yah2dZOWwCTA21pOs4NLvTg5m71WJkmoMOk3zX6Xc6ccGAqduU8sfknUEIEKdSyM8eZ3Uoj2Zy+/qKYsBEyOk6PX5gBTh0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyEfC/pQFjsoMpJM51dDEFp+MNBMAA6Dy+dVawzhXM4=;
 b=SSud0UGZK1MZfwz0/o+8ieQDuwb0UggLDCITBdIu5fQbjm4vjH4JR29LBEhRTqa3+xk1ijqC+fRXS/JY4vPNdHIBbJmG8SiEcr1bc/76DP8UCSBR373EH5YakCLfTQo7N/MisSFuMgEKJeGyAvlaX/hMDln4NbkyBBLjUHF7bjOl+0HL2/6X8+iz84PcUD9xuZwC8ylN3DmYXMKr1vC1+ovjR/uOoe+dXqqYQhS3VZswGiZWyc4Fr5jxYLwrpwt7H7E8Rbh6JGjgseH4sPOHa6SKBuH1g9E/gLgQiRmOFflruc0bUvtRcvK5NhJk95YLbnyz+ulgBabM/ZEN10jtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyEfC/pQFjsoMpJM51dDEFp+MNBMAA6Dy+dVawzhXM4=;
 b=4yTaH/J40ij+p+HA2aD2sw/N1GWlApyk7JihaDBWdGMIYvLXVwSiPEB/9yoWvmh6L889yzWH8oh+F7ZzBPa5ksxYa4k7W32pw1WVx5eNt9aebeatpSlT+qGQXNDCv8h4OmZff7qfZuBiXH/doE39sdc659ztI344VMTzuHknPXA=
Received: from BN0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:408:e7::28)
 by DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 10:05:27 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::ae) by BN0PR03CA0053.outlook.office365.com
 (2603:10b6:408:e7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Fri, 15 Jul 2022 10:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:05:27 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:05:23 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 11/13] cpufreq: amd_pstate: update transition delay time to 1ms
Date:   Fri, 15 Jul 2022 06:04:30 -0400
Message-ID: <c1b46c68d521ff2c8ed49a6e8f5ad75ce51fb772.1657876961.git.Perry.Yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 093b131b-543a-4fd2-e094-08da66498b04
X-MS-TrafficTypeDiagnostic: DM8PR12MB5446:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umle0qvW+COktyUIWFy3Bk0aS2Yc/Qv1WMLK41dPIEe1spXYbvoS0RFkwmjG3urx4BO3546b/A6EfKpEJPxq+7fXHHjIQgo4k4JQ7H0Y2uqZeeGAy/PG0X8NgB56Om3iFdCZex8v0EQDOxLqpJ7IwbOKYfsdEt7M4JJ5PYR4v3Zxgthopgoxz9TjkhD+/yL5yLP2+naugo9gplblngvYiDh6ug+T62PVOeHnqkx+6EDLmjaxc4qOnSHcT8SwA/0Fr+3CgBtfAqYemcERuCsQnBLl7PooX40EuMCfVGX6FYjK+MSbdZLCxYIv3JGRcv/2IH4ns3eWHKTpvIu6Z2mcVwER+PVBc26BX6NRLT2CMBeO4rUtxOhzdrxfPunmOzYsEjl36PfqHbv7I/ygkC7sE42+W9O6OW4GtaVa/KE8hqT6SggHgI2cd23Iw7re93hQ4QlLM6kjP00QqxtqjRIkHWvTXT+Z+1Mb6OSi5AoHIWcpmY/A7iOhaHW7PyoLRnUHemxrtIYPaNzK1yVcNmaCaCQiuE0pAjifTEOPT4EMgl6YhxnIEeR+mbFywtyXijE0GRScvmwyRdMat0C1sM2wGxvZqXnIuQnk5R0eHF09iHnkW0XwSlFxhld0o8Lh/3nrrE5i3ZKuklXcTmQSWFWdNnDE1D4Tue4TiD1VvqvAlVUxrxqY454O+1XzTZNkvYUxYyRjVN8F8wSCH9Ytrl63SBM9u4e3kVM0aTmjAHaaYtcvVwqNg7RUsCh1v53q5kJ3BN7XU5HbOswvtsMU4+JkB0+ZwdNrQgphxO5IFVBf6h7R3CsMpHje1rwXJDpGY2qVcakXv5Ap6WUKnXbgqnArUA+WvlJg4idqHzAe0N2cR4c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966006)(36840700001)(40470700004)(70206006)(36756003)(5660300002)(2906002)(16526019)(426003)(186003)(47076005)(83380400001)(8936002)(15650500001)(4744005)(336012)(36860700001)(4326008)(70586007)(8676002)(110136005)(41300700001)(478600001)(7696005)(86362001)(82310400005)(6636002)(26005)(316002)(2616005)(54906003)(82740400003)(356005)(40460700003)(81166007)(6666004)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:05:27.6563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 093b131b-543a-4fd2-e094-08da66498b04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update transition delay time to 1ms, in the AMD CPU autonomous mode and
non-autonomous mode, CPPC firmware will decide frequency at 1ms timescale
based on the workload utilization.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Su Jinzhou <Jinzhou.Su@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4f8600a36194..d3bc441b3923 100644
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
2.32.0

