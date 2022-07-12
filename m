Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B617571FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiGLPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiGLPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:42:59 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2082.outbound.protection.outlook.com [40.107.212.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0491C3AD9;
        Tue, 12 Jul 2022 08:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZOpFImKTGPMlftvYhGeouRbTfh7hjgrCO3wixDRL/RSqBmvQEFciv4xwEu2DaKqpLjcmOR+UkbozH1yKUwithmHYcRLp5ehI3mGsqvOxyQxWfJq15n35mdmPdAUcqShL3wQV0xoz32/Ri8GHcacyqUpip8RA0fdr+rwDhHEi0RofZ8o/jMqGsd4o3MLiSG9YX1a6kjBWdfyq4oUIKWdWTpEJxV0udYv6oN4iQJ2Wdo4Gr5B9KwgP6ziHreMiIW9rU1tt1rMH8RS9BVWb/uQxfpG7QbNZwd0+afHqvaSvKC6INpzNeA6LuX/WZ2l6GQrWjojcXQvkhaednuHrcubIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQzY6ZjO4+NLotDe0Sqa2ADxdZIi5WF1I+zUsc2a/Bk=;
 b=LYoVhn8pA54RqjZZ8KJQSoloRO8wNaq6Zq6qPyx18VDkRxYWW9ykOUitJN9DqfABmZCf/PotrHefLRJ5cRsuudadIhfXa3Uyr+zHUdpsxC2DbFqHnIyXMxI95TlQT68ULaiFGhub2GScYfa507DEImsiZa+nHDOEx6V9sXbB+ziUFwsD9MLwmjWle/E7qJBw8vR2arVzrTe6y5SdNzslAQs1E0DxApJ4KZmuwWMoqPwlb+nYHFO621h9MAsBtw0KH3OuX30QtFKNf+t4PawOeAOG5TK6AQmy85hEuy70MiSSvP3E2CxJRfSnCY6bM0W4XjyBYxdwlYCH1TCyMWZHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQzY6ZjO4+NLotDe0Sqa2ADxdZIi5WF1I+zUsc2a/Bk=;
 b=Cb7/OvEnPiJixiFJQ5Z/Kf2FeShEtqrR4HS9EYpfhVQY0APShOv4fCJyqqzFsYFRoWS+enelCFbtYq4KHCjPuCcsVaV3yQ8gX7+N09X5YpauFrrbKa+5H3mdAEofxexZyrZg2LgBBDJED8aBCBUgU7/wI1mHuqzImlq1qV3GWB4=
Received: from BN9PR03CA0690.namprd03.prod.outlook.com (2603:10b6:408:10e::35)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 15:42:56 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::c4) by BN9PR03CA0690.outlook.office365.com
 (2603:10b6:408:10e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Tue, 12 Jul 2022 15:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:42:55 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:42:51 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 11/13] cpufreq: amd_pstate: update transition delay time to 1ms
Date:   Tue, 12 Jul 2022 11:42:42 -0400
Message-ID: <b138d38ecd1aeef1121971071380ac538c07a747.1657638462.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657638462.git.Perry.Yuan@amd.com>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 058b4a92-0143-4945-e773-08da641d3094
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFjL2xzPP3piniY8C9B0fPuXKEQLjgDvISiacVzwAFcLivI3El9ptBFxAimF6Tqs3aTv2DtfgqMbCOJykj9YjfdN/LXczT5ItfOvciV7S063Zc0rVSxz5BMESq3xu0f3WzvJemCVa3aBQDRpVZpzsLBKDPHrd38a3jCTuHM7QE+iRNLZ4p7qjpWEHYxsQcQtvkGaZGtPb18gg9bkNB1rBFtB/W530itEwVfp9Kne2375aQoUFcGCbWNu1NwZay+Et1QahhZsBKf67CGoQ5tnyDeC3lqKQPfjC74PllNbOeiHmUCyDVJrgS3dd8M5ajFQe1lfYJAQYIJUrt9mf6igob+jNUylKL8BjjYB5NmQG62NYSr7aIwG/BRSWaCwfrrjePhXwLdVCL6YKomeoCOMXoIQZTSsk3sYWDv3Mt9dv9XmJZEUdw2vZDtNvcIXj5PU///UolVx1VqVf+6dPTA6sEsHzVFFRSkRloWcTFogqvfNGvccQq75cyyVUcH3VFnCM8XSg4mD2Rr3O4xmhH7mdj0nkGV8R1HDhZOs5KBTfj4VhgZqEA5PJmM5Rsx6bPybG3z6aWqe1hI4GLYLhlvFzRZuC8aExeNeWkX24ak0M28Ylp7Re0UXy6DFawUk0SrC7Q2HYt/9a8JLa/dB9oAgjrG209Vf3HRrQ/Odq3CJoJAgcmDLf5Uq4L3U2QDLnB1Yj8hd3roozIv8+jThy0e9NZG69TCTq+ya8IqFGhZdI2hQlnjzjz2c3bs8en2UF1YiCO9YKNiwnzwJBuJJqabHf+iHD2IhFG43yQ1xfYxPsG/3VfBlHxlRcJmFz1crcxRobxPfI0e0ljJA4vJOy3f5XxB9h58B7yb8fWf1bykY2lk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(40470700004)(36840700001)(46966006)(82310400005)(36756003)(316002)(478600001)(2616005)(15650500001)(40460700003)(16526019)(26005)(186003)(6636002)(110136005)(54906003)(356005)(70586007)(4744005)(83380400001)(36860700001)(6666004)(47076005)(81166007)(4326008)(41300700001)(2906002)(426003)(8936002)(40480700001)(86362001)(5660300002)(7696005)(336012)(82740400003)(8676002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:42:55.7459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 058b4a92-0143-4945-e773-08da641d3094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
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
index a9918728948a..83570acecc78 100644
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

