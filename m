Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EAF56A8FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiGGRB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbiGGRBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:01:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7BB5A2DD;
        Thu,  7 Jul 2022 10:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+b3DGIkTEEY8zk6FHWqO+MXbgE/VD/P1Se7ZMaCD2g1IdWh6mhn8+CRG+2C/cKzDbuTwC007geNSuHG0Jfj8tYewihzJoe1UJpwm0XHmKWl3SwLBhir5ldMsrf33A5gwv/SGF/ZPQRsHEEyxepl4YlEHgPNaWz96d0idb8BQ20J5tAbnersOW4/WudHrntajjHzaASBTcqmZ2jjDzDotgc+ac29Wq6a2il8qemZgFSnst8BPXeCRP2ONy8nGp5AZrEMYpiH3VM8Oz411VP07nZxZpXZbNShmjOvmfvdHx3RKHUFhfrDKVxzroYmJ+b1/lguZKItbd5wCx9UWee16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h37fqiQU02ngbcc8LOrE1usF6rNCcg/OMszPMryKmkA=;
 b=UmtLEW0yNb1kSD9k/oBReRvkGh660/rtZWE5B+IdhfsC2KvQzBu6jhlcHOm8otmXcI+k1u7t0tWRfeuutCIrTvrPb17kgvLauhwqU57mG/YuaAS+1u9hzSjCpwmRNItZthPGhH3d5XLZWi0HkCmBO+eo+suy56f1lMD2wp18UGkAFL2Kk0Jk100VwaGjhDT5LavWO3R1m3SVjUwAgBmydxUv7nTcZKTEkWY4808fHqKIEEW8P+ZXvU0JderFY/oitoxRv3x/A5g90UZXjJ9uR0Rt+rX/S7fmZ8e+GlWLn1fpWPjR+pDn418z85dFw2nX6CBYXkMBeojKdGq4hupJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h37fqiQU02ngbcc8LOrE1usF6rNCcg/OMszPMryKmkA=;
 b=1GgJK3/p73rf/qp7VHUAHpgFNAmZ2M/8sbaiKM42+cZzAQe4QOCkcCR7KVE6o4mqTu7CJwDJGvy2PwfBryQcu5XRh+MGtHKuuZhcUDi8Vrp2eyzf/+OJD9VQjT+MWChCaYgpPRcVh6r3TOh/5nUF0NsLXEE1xqqFNcqkTSmus+U=
Received: from MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::26)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Thu, 7 Jul
 2022 17:01:46 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::84) by MW4P223CA0021.outlook.office365.com
 (2603:10b6:303:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 7 Jul 2022 17:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 17:01:45 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 12:01:41 -0500
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
Subject: [PATCH 12/12] cpufreq: amd_pstate: update transition delay time to 1ms
Date:   Thu, 7 Jul 2022 13:01:29 -0400
Message-ID: <20220707170129.217086-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aff593b-f47a-44bf-5da9-08da603a5fdf
X-MS-TrafficTypeDiagnostic: MN0PR12MB5788:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlukKozwZIAP9npgxyO+542O+LFGOIglgdXoR5VLADi8XlCb+rd0xZaDITJHskm1isEq1BMTBzkp6JYJzqRkos+0fYexkNQeJHJ2kHKE8pETFXMlkeCjlu4rkh8LY170HLTpOXG1nFLyrdi++tqIjqdAaAZyineOMGqjWjeFXRilFJ+D4cn9aoWdpkk60V0eMGDCe76K6afoDi6UwXyT77utaBN5C+VC2crxE+CLMp1ExAr/O5EScbXDmhpZWvmifMl3UiArm3X8yq+i3OBUE+Lpxn7GzZUV9kpZ9nI7cfsZqANFFQVl0EPVYQstEFwltk6kOWp/qzPAOhHCwhRvQ1fANfKa7Srx13s/oFkNiKO8nEjYGKu6x1sanoYoP2tZHIVy+4nFnZAm44eBygpBWVYN2l+bini6EPXTeYnyZqD3Z6xepzKVXYLntMKinRCuBr7Nbxvg2qRpX6DpoQ57cRxP1hdYg7Qwy5nW21irDLmp3zXTCAvAu06R4XnMnhzfxuewSC5dBKsCqfy8qS0CdNSPbAMCK/m4xmjedtwTMcRUyKkj/2Py31yBMGSFZqnT/AifFrJQPqzqi5Wz2YsOW3kgPzekReGGuhCVp+Jlw2LlVys4eMZdfsWWSt/bFc4iznOJHZnIZX/OsDQBl6yK6r9reGc57bC28dxOWWOyimWoUBRaEAmd0R2QgzlsMGUwOvEbiYOfysqAXhCl3Ed9D3rPKg5MdqgcxE0dOpXr2Kw6/BGr82BmcOl8XY9PZTWRDG2b0Q08hw1H7Zo0Lagqy6aiJisB8YzfxcjozbYHXGe9k/cB87kZVwR648CMzInAba+DnS0+fReIhMtGHjC4E5lCQbID/N9VIGVlUG3O0s55GMIC4TbcpuZ0nxXBLMFU
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(82310400005)(316002)(36860700001)(54906003)(40460700003)(110136005)(426003)(186003)(47076005)(36756003)(26005)(83380400001)(16526019)(34020700004)(336012)(7696005)(70206006)(4744005)(5660300002)(15650500001)(2906002)(8676002)(86362001)(1076003)(478600001)(70586007)(81166007)(4326008)(6666004)(41300700001)(40480700001)(82740400003)(2616005)(356005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 17:01:45.7471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aff593b-f47a-44bf-5da9-08da603a5fdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
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
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6d81a9a94dde..f16ad0b108e4 100644
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

