Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3C64CCD9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbiCDGKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbiCDGKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:10:34 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450C547AFE;
        Thu,  3 Mar 2022 22:09:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3aRqQW3dwj7w1kLOks0dNf1HIOtrBY8t+tec/Mc00yn26NlTPEPjCVwDADPJVg6cbHrxp5jtM+ef1UPmfljzW+07HKsTiCiQHU2jD2wIfyASow9Xi+AwdoG+wkl+Ho8/WEVN3wsYgypfb+brN6wDR03D4asUdXRj2TGSgqBipmzXZ5zAtA4mgBKKz7XHhPgYn9D0+xLIH2F0Sx7xoIkk87pMq/hz2Z3s/WQXxUI9Zaf9vYC7pf8dzfY4vuutJGBCSEIWzqH7JuG5yjK+pKL2POnAVf/1k40JG9/hUFDSuqcMqWFRS3IOehArm5vVRv5nSPj4tHY1MZAi0NYXamXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQSb8aXFwzJmaujcSCOmzQP9FuKfdMzEyXLIAc7XpV0=;
 b=be1SbxMfUYwGRLs7Y8nrzMz70t1ja3LGKKRtojR3SB49gZUlJLoIsGSdNhDfJ1M+OOTcUcZwZs0wTZJOt0tEXqjT4HoFlRBQHZhwks4wdIKWx86k1ZoT7dWf/ZxyHwxxXZaSQD7evws8Bv0ctJt6cNQ+KgRlunackMykd5D5plXUlOIvXBPRTVpMjnVz6+9TtyaT6LzrfFpIO6g0FstZVzwoH5ywz26nKIHZ8TEzENP96TKaOvnPJ3DnYQKzZfqwtH08mmPmNBaSxb/x3xyn3IVpn9YLqB8fqP5JRtzuEvMAxyct+0lrQ0vqCnVY6AmY7MoBsjWV0+6EOha+Z0ebkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQSb8aXFwzJmaujcSCOmzQP9FuKfdMzEyXLIAc7XpV0=;
 b=BQAdBX/2CX1BT3h2pGfhgJRfYyMkAzdl9qSzrtj/9KyO3p4zWN/g+duLDU3gGiBCteQfCE2utDU9FkAqFbUbaeyQv0T5vi5WxtBQtgaFOp+yHhYVGY2QQVfqlJFgkg0fakXrYStkGRLzDo+bVvxOIKnq92iClfXydRy3MKz1GC8=
Received: from BN9PR03CA0937.namprd03.prod.outlook.com (2603:10b6:408:108::12)
 by DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 06:09:43 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::31) by BN9PR03CA0937.outlook.office365.com
 (2603:10b6:408:108::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Fri, 4 Mar 2022 06:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Fri, 4 Mar 2022 06:09:42 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Mar 2022 00:09:36 -0600
From:   Jinzhou Su <Jinzhou.Su@amd.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <dsmythies@telus.net>
CC:     <ray.huang@amd.com>, <viresh.kumar@linaro.org>,
        <todd.e.brandt@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <deepak.sharma@amd.com>, <alexander.deucher@amd.com>,
        <xiaojian.du@amd.com>, <perry.yuan@amd.com>, <li.meng@amd.com>,
        <jinzhou.su@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>
Subject: [PATCH V2 4/4] Documentation: amd-pstate: add tracer tool introduction
Date:   Fri, 4 Mar 2022 14:07:24 +0800
Message-ID: <20220304060724.314582-5-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220304060724.314582-1-Jinzhou.Su@amd.com>
References: <20220304060724.314582-1-Jinzhou.Su@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fb6b7e3-b999-48dd-139f-08d9fda592c5
X-MS-TrafficTypeDiagnostic: DM4PR12MB5326:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB532692CC6FE823E8D32E15E890059@DM4PR12MB5326.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GxDl/LJ/yFzWT1+TY7cwUht9DF90jLkNuLemqy8kVoRVAa8oz81bNatTvTI5YKmUookYDuqctTJ1OACfMY38Z8WdDh8a50/4d2QSy2nt9DYmzTGP14ZPAsCOwAOJ4vHoiy2lgbLHxdj206td8L3TSne9M/N1eyk0kpiZslZp6Btv2ShI0ggr9I3KMi+oJQgc7YH+qqyMNO4nzMvW73AyDPYiZmBpvNDc/1Wk3/IM2FBiN1OUKcfzsrtqYLlgPerm5pwr8YUCw6lkFWHGqvsC1I6r+v1S1tnjZqnx5BqTBaOcTpZcLRvvp9OVb4Qw3bOQ8Dx0QhFJV8g9qGxlrymtcW+HYzk1x+442ZNF2cYjkn/5Tl0kv6ydIK/IcKefj1f4CmDHNsRTGQU5UUBEVpdqp+Gxh3W35kPzG2jCrmYllCB9g5xAspD7U2phALVmpdIx2lA3Z6I7h8JDwthRrguefDWddmMSTrdccnC/69fcR3TLGYysXQSNO0iZKKePitUsansHTZE2PnqiCUmG6N65sqc4BRwLhm8c2h0uxikkod0vAygRaKXap08GYyNTjOxr1Hvut/leUJdKKOf+nhFeM/VO4ddZxusIcHZl/v+WroVV6n1jyAV0pccrFC093r7YSDZNAzYeFwVrZC25rOnSFdIRJB9nXl/CEy4Gtfu+i6cdwIDjz7LMIaLvtjoJX2ky59SjgbBM8AExHXgZN7rxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(82310400004)(8676002)(4326008)(2616005)(70206006)(508600001)(70586007)(86362001)(110136005)(6666004)(54906003)(36860700001)(47076005)(40460700003)(26005)(81166007)(186003)(1076003)(16526019)(426003)(356005)(336012)(83380400001)(7696005)(2906002)(8936002)(5660300002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:09:42.2674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb6b7e3-b999-48dd-139f-08d9fda592c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add amd pstate tracer tool introduction

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 26 +++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 2f066df4ee9c..17dd7396e8fc 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -369,6 +369,32 @@ governor (for the policies it is attached to), or by the ``CPUFreq`` core (for t
 policies with other scaling governors).
 
 
+Tracer Tool
+-------------
+
+``amd_pstate_tracer.py`` can record and parse amd-pstate trace log, then
+generate performance plots. This utility can be used to debug and tune the
+performance of the amd-pstate driver. The tracer tool needs to import intel
+pstate tracer.
+
+Tracer tool located in linux/tools/power/x86/amd_pstate_tracer. It can be
+used in two ways. If trace file is available, then directly parse the file
+with command ::
+
+ ./amd_pstate_trace.py [-c cpus] -t <trace_file> -n <test_name>
+
+Or generate trace file with root privilege, then parse and plot with command ::
+
+ sudo ./amd_pstate_trace.py [-c cpus] -n <test_name> -i <interval> [-m kbytes]
+
+The test result can be found in ``results/test_name``. Following is the example
+about part of the output. ::
+
+ common_cpu  common_secs  common_usecs  min_perf  des_perf  max_perf  freq    mperf   apef    tsc       load   duration_ms  sample_num  elapsed_time  common_comm
+ CPU_005     712          116384        39        49        166       0.7565  9645075 2214891 38431470  25.1   11.646       469         2.496         kworker/5:0-40
+ CPU_006     712          116408        39        49        166       0.6769  8950227 1839034 37192089  24.06  11.272       470         2.496         kworker/6:0-1264
+
+
 Reference
 ===========
 
-- 
2.27.0

