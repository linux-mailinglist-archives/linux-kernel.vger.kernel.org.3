Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C94556A8E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiGGRBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiGGRBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:01:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CFB5A2CB;
        Thu,  7 Jul 2022 10:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOd57qt7CvFAWZ91oMQUa22MPItpaGlBpYQqGOd14BVrphwX2kcIFVwN/zZRHqJt1klRGa07c1daYuT0LZienPqJy7+V3PVbGk40JCHy74ZjEHNJ0rXM7AOxxOCr8O0pQShAdGviagY+QVSIgh+Q/z/HFvlrZ03TzjfUDv1g90qj8w6wVu3ks3gLHrTjhSy3bjcX8nKwapsKGAEasF5/O/xk3SEoBPzaMgUZ8Cfm+hETO5MaktOlE0MJO1uDVJwhwheZG/FLaHeGxNirXPanbacEz8Ry/7VvnFwP+3KVcE78LFzAhqmlWPpOK4rXzJEsAk9bHitWmvYTWYgMXHP4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb8/Pi37J6YDGuT9JW3EZkxT3D+mGfgGyya5hpbNczU=;
 b=gTLwe3rjTqiJcIeJyag2D5igMiV9kFuNcJthqxK+xm4IeZA+4L5UfFaqZqfEXxh2d7dAWfRjChMCUbAkWlyIyBO49aBAbnOOVIz2/U+e/iQug75nhINRCI5DScW7dTgDkIo7UfBZbDYxXHCATOxaAJhnoSOKXIxOj5+V5BkLE4lvpLMH189pkmwVunTsfev74gXKFxa2FphDarDmtrrlQy27dCNZaZESHE9H87TXk7P9gbM2jtIz5CYQCp20AwVkw+2wYNjjmWTgrpKvJd/cucFjTUjpopOzLes/l2+bXIqa89u295Shh6zj/RD7btbTP2brY7hnXlcd9ex2Vxb0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb8/Pi37J6YDGuT9JW3EZkxT3D+mGfgGyya5hpbNczU=;
 b=ea+KhUBql6J05fChRVDTd//h//QHcbZNL5OiiOa+PAfraMCqfIwcY1at5y7bOcniJBqRbkGg1GvqnxTq9U0TD7+PniWFyJNQ3ZmpITceh2/iSVlhX3J02gE91qgZhgDFSDOARA8zx4MmaUeo/GhPLMfRVrbsqiwQX/VTOEG3kuQ=
Received: from BN9PR03CA0689.namprd03.prod.outlook.com (2603:10b6:408:10e::34)
 by MWHPR1201MB0174.namprd12.prod.outlook.com (2603:10b6:301:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Thu, 7 Jul
 2022 17:01:08 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::6c) by BN9PR03CA0689.outlook.office365.com
 (2603:10b6:408:10e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19 via Frontend
 Transport; Thu, 7 Jul 2022 17:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 17:01:07 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 12:00:59 -0500
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
Subject: [PATCH 09/12] cpufreq: amd-pstate: update pstate frequency transition delay time
Date:   Thu, 7 Jul 2022 13:00:49 -0400
Message-ID: <20220707170049.216556-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd5829de-4770-4ce5-15d6-08da603a490b
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0174:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5HrufuhswvHM0sDMzPZwvG4sTrjta7Dneg17hhVUNDSQ3u6opmsSv48n0P2nUaahsrI9oNZkwQ7anamP+D7HFC5/A6+hrTyGbauFCE979TYM6TTTSt080vVbrJlTbeOucELFLJYdrdzUBXAzcuF1eF4MEgravKZy5P4j94qSOSq+prC8MiZ8UzBOClW1I8DvuIydB+k+M10cg1h1eBo/XugMMXZvkvCT2TzsLuXZG+X11B1jS7wjbPwDgMlXCqOGM+/OSkuExgRxzgapN+usMRooPFrfthBKwuxd4RK799/BCkP0mS8TseT5wic6Ackc48PYuDp/vMAYoZJgZ/nhQdS93ToJOXa5KjC4vF665fVFYppC5oxBEEjCz221Q5nMKxLYte55zZdE5vSRbgy59lBzJl7xdzx7WH5xZ0a/M1t6EGphc6XCf+4iFPKAqLATBHptTdvX3RLHanj3ma7u86CgFcdYd/Zl/pcHGKhA3tjOTG0TLrKlLEJMFDL4mpSitOswuxq0qefAY/Lz3M0C+gEIx3n1dGkvVTXNVOnwPFqqiPtodSTloErVBMqptX0VNTjECXGltVG8FJ81SXCImpRwUMGu+6GBunFjU9tvCRnPFXADYR7DeA+/fCWzL33yVGp2IffDX2mMQh9aB19jVjPo9fFefv75GMPldkxVe5P/KMD7vAssJsXTBKTbj1na2/idlVzonxy8jGUJja9K8E2OzuaKCw1uPBDF9DxjiHJJ5UFKKYBrzCYbkKKWAF0DanRjaqRitQtk6RPB5DMJ6dEwW28rTjDBInWStTZTQUbvniiAlvEqGboG7fPe6L71NPoPGfR63ZG+RrWUlMUvx91HItHevpTkQHCbzmsQlV9KHadomtChR/tneBAVVOi
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(36840700001)(40470700004)(6666004)(2906002)(41300700001)(86362001)(8676002)(4326008)(7696005)(5660300002)(4744005)(478600001)(70206006)(40460700003)(70586007)(316002)(8936002)(82310400005)(186003)(16526019)(36860700001)(34020700004)(36756003)(2616005)(40480700001)(54906003)(1076003)(110136005)(336012)(83380400001)(426003)(356005)(47076005)(81166007)(26005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 17:01:07.5554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5829de-4770-4ce5-15d6-08da603a490b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0174
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
reasonable transition delay for AMD processors.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 173a45cf292a..b54b3b559993 100644
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

