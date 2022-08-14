Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E095659259B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbiHNQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243315AbiHNQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:51:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23FC1D0CA;
        Sun, 14 Aug 2022 09:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZQXzAZ/sj6D7eeCfO71NFN3RRhJEnUfQymGn+KmZb4GPRUocjtaKVKdX9omVqRQQVDPPcQd8gbFG9FtkKoAdK5y6B2pBT8XmAqZDcJ1TU0L9ozQW95jLkd6vrxvYML1QcylDLs7kIpwkLWIfC4iARWCinqhd3ksYYG7kMkMsWO1/H47Uq76S4NhtYnhbnHKAJrvrZ8gec/AhUIqvsJlys7Ew6DRgVnnf2/oFebG7r+hNVCL+9U3h5fFNbYu+AlOEHhMCFeF1kSg08wVIpq4fF3+dBfnXNK2rdT6B/lLjN7TP5R4cWliCIzwRvTgOhPQtySvTzFq1ce5zYsYSeKF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksJ89ZFCpodpAJmrKMzze3A5go4HN0tv+M2GH4g2o3o=;
 b=j+kCSWsGqptrp4Nadt88tARvKkSgw1jUPnE5Z6kq+KHUNWw9RqrgGWDosRKp/HXUqpu0mahndLL2Ptlje5WuqxHayRQIMzifHcWhQM0A0qE3TN6RJnNjCR//enkPCC/OqDHZlus57aq04wgqtfsDMr1PdZq7Jm4/gtFny2zHmaUW7pzlc5ETa+yFvs5OkKVqAw88zRFzDmDAWnz3jMkqg7Q+pRkZu9noy6O9KDgUeC/4xuWuiWVsYyN91HtEi4tljsMN94HasYSMO1QyTbaQuYxulaLL6cAZzQSW3NP/5cKV+WxX5L4h4cqeyBa3xGJ3k11yoCX+ZEssDwkXR+0vyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksJ89ZFCpodpAJmrKMzze3A5go4HN0tv+M2GH4g2o3o=;
 b=xP4PLkG2jQNOJJ0WIvTEuwU6glEAMxLScJveDo6F80CsNd9xViQXgA2wpf+D8TAZxLTAcPYWK8v+k7FGNo5zYR93UzFgG/qMzS3nwk42SDOEOZHAvUXdvW+0T09DDp4RIekyp5lXqr3Ph/Ffj/i3MaPWGmKWnvLPp9Z5NT1Z1YE=
Received: from BN9PR03CA0329.namprd03.prod.outlook.com (2603:10b6:408:112::34)
 by BN6PR1201MB0067.namprd12.prod.outlook.com (2603:10b6:405:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sun, 14 Aug
 2022 16:39:20 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::bd) by BN9PR03CA0329.outlook.office365.com
 (2603:10b6:408:112::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.19 via Frontend
 Transport; Sun, 14 Aug 2022 16:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sun, 14 Aug 2022 16:39:20 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 14 Aug
 2022 11:38:47 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v5 6/7] cpufreq: amd-pstate: update pstate frequency transition delay time
Date:   Mon, 15 Aug 2022 00:35:47 +0800
Message-ID: <20220814163548.326686-7-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220814163548.326686-1-Perry.Yuan@amd.com>
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47ab9ae4-40c4-41fb-7ec5-08da7e1389d5
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0067:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISRHcjr6h8MrMB4ViefYBW1YeriBKbVUHOEVYearZ0LhvNfvfq++KebH+Jyaw4zgbDAy/Yw2x7dgJuiT3l/pZAHTZGDpZsF4bPmBda6+CbbhtcUL1z7EpbBrngM9/9L0oFvPnlHjx77mSCHHuqu3DZWMltwANg76H7bE3NdxmSs8nHVuwWxKNTixQjeZXbY2JbsGBBPs4cLjwBzN+lQ3s8w+7u1IXo5hvC72+I9JFm2mf/i+zw2TOOog+DeZFmpQtVkbOfLHAiGhW23d9P4eyxczcfCorENbOSy76Y6QTGNkAUhSmQpG6qK2tKGZzfqdKqmS8rxkRHwHIujUf9KqusAU1blLyYrW7HfYkIkOGPjhEzH37z3O+qnXiXgNycza151BeX5HJX9g3DkgGYSTXQRdEf4sOFij4puJ9BS/fK+LqZybfYngu26MiEBFT3SU+La45Bm0VbxYHNEnhL7WpAtCVUF2s/pGdbu6fbrBdWVeiM25OIgGs3RMlG3qztUd9AF+5gDAxQlX8jKe9yLVyAQ2brT8yXPyqBsPjysKFZruVz3X1UmhKnm0YYdSm2/qtPuVuN38703PyncmB+rq1eCApfa5N9S4cqJwJWJUDoFynuLbTDbqVUwCMcXlfraKxGW6lA+inA8Bnl+kGNpfeGSwhzCE6I2pJNnmDyXdhoi1KkxMnPPc3YbWd2ccClQ0/GO7qLT31jarh2TadYaVAM6GDds+Y5EzhLMXk0rqKGJgSQDybde6j6Ky3804PHqs3cBuNS6pAh/zFD3cwWH03tSQRSYA2UIUE2bGDtiE7CNB7UY3ecCj0Wl/LgHK9/ncq68+/87xon7K99sKX713cKrVNK92IlCXUaXCXLfgaXw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(40470700004)(36840700001)(81166007)(82310400005)(356005)(26005)(5660300002)(40460700003)(7696005)(478600001)(8936002)(86362001)(15650500001)(83380400001)(41300700001)(40480700001)(8676002)(2906002)(4326008)(316002)(82740400003)(36860700001)(110136005)(16526019)(426003)(54906003)(1076003)(2616005)(47076005)(186003)(36756003)(336012)(70586007)(70206006)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 16:39:20.7513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ab9ae4-40c4-41fb-7ec5-08da7e1389d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the default transition latency to be 20ms that is more
reasonable transition delay for AMD processors in non-EPP driver mode.

Update transition delay time to 1ms, in the AMD CPU autonomous mode and
non-autonomous mode, CPPC firmware will decide frequency at 1ms timescale
based on the workload utilization.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e40177d14310..9cb051d61422 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -41,8 +41,8 @@
 #include <asm/msr.h>
 #include "amd-pstate-trace.h"
 
-#define AMD_PSTATE_TRANSITION_LATENCY	0x20000
-#define AMD_PSTATE_TRANSITION_DELAY	500
+#define AMD_PSTATE_TRANSITION_LATENCY	20000
+#define AMD_PSTATE_TRANSITION_DELAY	1000
 
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
-- 
2.34.1

