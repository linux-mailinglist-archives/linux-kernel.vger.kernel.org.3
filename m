Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45599567FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiGFHhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGFHhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:37:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8676622B12;
        Wed,  6 Jul 2022 00:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvAATcNMZUYZriSBLwyb6Coj9TpvwRhEerqqpmGtNaA78wd1Dj81Sxjlhl6fTeATcJBMGKZg3A4/7FJq+A8G4BTxTDNiw0xOlPPu785RrfBMpT3nLCqChbC/HbJWgkjycFS21TgdGTNZGW7LbujWI5AKhbOVw6iCuOIXwn4aj1wpZQ4a2gC/40pOakuP4/rLS310bckLvQqhhx0KLcT6Qpq+17yoVS7GsEqt4oKlmP0bEpA3bY88aiZtLKYRZZ6CXml36+n4YUdv7vmPOQSGIpIw4UJZRao3ZFnEp3QcxoEe4etZT9k425HqhuhzBdoDPa5JrCzK+fY5+kS1bH88Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnzOgc+v4K81+QfDurQkzyMMrYRppHEzJvZ5jUdewjY=;
 b=aBhrq98FasADHfhiMLLdq3PeUKp3+QS2YWazSz/NYKuFD6oeJ/7Qsidu6rSNeltYzyISGluOlz9DfNMSupl+3GNzDu0qk7mGHWEIf29j/lsgnX6smKDZvBGcCkekqFAaYJ4HU5Gnwamlt2yUQsFNhJVT+POFyKgf69zTK1sC0shdcbI6zoAUIIWxYgZfCqA2O73iWeXEpyqqKJOUVlJgHjR0b5o4vtDYaBBh3x/Q9BNSFCIEP/Yyio/ooECkpSuRPdd+X8ZaPzgY6wModtZN5HiAPtUu3rjuUtoWbkpLCw4tvz9vU0RPdmWv9ZHR9yHjnykD20qxC0p8Sah7GA3CWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnzOgc+v4K81+QfDurQkzyMMrYRppHEzJvZ5jUdewjY=;
 b=h8IAwdpsjDRPmQv2dEjIvMAge/gxIZBZN7lnAqyZLeCnjj+dFVCUocnC006V2tUCEDbeEyxi/4NJ/JxB/KZ5Uz0KM4UjDVOWMs+UBepA/7AMg9wH1r3A4ohqgKHC5hh4BA4KqtxVR2ciD7+70mMppaywirNh73cQ7NUsdUaESGk=
Received: from MWHPR14CA0015.namprd14.prod.outlook.com (2603:10b6:300:ae::25)
 by DM6PR12MB2649.namprd12.prod.outlook.com (2603:10b6:5:49::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 07:36:55 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::bb) by MWHPR14CA0015.outlook.office365.com
 (2603:10b6:300:ae::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 6 Jul 2022 07:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 07:36:54 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 02:36:50 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V1 0/4] Add tbench/gitsource new test cases for amd-pstate-ut
Date:   Wed, 6 Jul 2022 15:36:18 +0800
Message-ID: <20220706073622.672135-1-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07859ea0-ec28-4d30-86e3-08da5f224cfb
X-MS-TrafficTypeDiagnostic: DM6PR12MB2649:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcbBU+8dBCteylt5103zuDHA/0R6vDdFCBMcSlqs12ll+IJsOt0tXmenbDdQR10uRotKPi0MOGFenYa1zdYRURm+VtHQCklBfILEWZd9jGRfOSEhnVpETbFMeaG0b9LJ9lOIPa3beufpeNX8A9rsYf5K9UIMqfgpr7jdlhw4p88uGOGasb3vwwEu2qeN//53+M3s3GefLC4htpEYpifUyY3TvTNSv/f/rE71L7zl2haOpE0ro7cOTXxlL+l1+drp1/UZEqDgBgUqPWpcFPY8vDPTAmn5KM/g10I7+YJy9FbXnebnMjIaYPd6KIHVjxcN/tzECaSZoHf+SOVXnr+HvMbJbXt9f3flmtb6tLxyGNAK+E8uKca6mq9GzHmIcsOYEHM5KSCkxuzBBdZIWaWVBfw2S0FzGxigFm1r4X1rJwVFM+rqh4SfhQ/lWHT5E8GsTrtFRcjVxThLRYVDTQhbEyWGpFy6Y4YG6p6Ns6NpVoQZ7peJ0a5qWlB4t3cMT0lLEalZz3d0/jrXkemyzef2uRnOLyUFmxKPT6lpV3PlvwtyGrUmu58dXPsC+IMFMATc+ytZhbEpCQWpWV8Pef2+Z8CIZdFkYKOdAisLBLrafnxUEaMI2/p5y+kA/03OHCNra9VRase+kRJrjUtP5O6RquBO9WnJJ+EJkVB3Vu7dJmudF8d630fyebjlAPsndDuU5iaZJA+DvNFzsysUq/LWjO6frvfSEQe7L/tfnBsW7BnkGFgEMqtFPVVCIXrHDFnO7qERmTyCOFf+QFh/M4qm+Bc9hjOxIRL2NCaJcUWNENKeYjofZGttVyA+8DE0k2qniYg4/Uc5sx4mh9qBeEaB3haYzVBoRXtLaOsGYQhAAo/4yQi6CUNhpdGWdkwKtvigG6/XV+Umwy8Qql1ws/WXIglOqdMVFKbnp6LNP0rMrK8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(40470700004)(36840700001)(82310400005)(34020700004)(186003)(1076003)(16526019)(426003)(40460700003)(47076005)(81166007)(40480700001)(356005)(82740400003)(6666004)(83380400001)(36860700001)(41300700001)(110136005)(336012)(70206006)(26005)(54906003)(316002)(966005)(2906002)(7696005)(478600001)(8936002)(2616005)(86362001)(4326008)(5660300002)(70586007)(8676002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 07:36:54.9550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07859ea0-ec28-4d30-86e3-08da5f224cfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

The new patches are modified on the basis of the previous patch
https://lore.kernel.org/lkml/20220526034725.1708916-1-li.meng@amd.com/.

First, we modify amd-pstate-ut.sh to basic.sh as a basic test, mainly for
AMD P-State kernel drivers. The purpose of this modification is to facilitate
the subsequent addition of gitsource, tbench and other tests.
You can test specific functions by specifying test cases.
Default test all cases, include basic, tbench and gitsource etc.

Secondly, add tbench.sh trigger the tbench testing and monitor the cpu
information.
1) Download and install tbench codes.
2) Run tbench benchmark on specific governors, ondemand or schedutil.
3) Get desire performance, frequency, load by perf.
4) Get power consumption and throughput by amd_pstate_trace.py.
5) Analyse test results and save it in file selftest.tbench.csv. 

Third, add gitsource.sh trigger the gitsource testing and monitor the cpu
information.
1) Download and tar gitsource codes.
2) Run gitsource benchmark on specific governors, ondemand or schedutil.
3) Get desire performance, frequency, load by perf.
4) Get power consumption and throughput by amd_pstate_trace.py.
5) Get run time by /usr/bin/time.
6) Analyse test results and save it in file selftest.gitsource.csv. 

Finally, modify rst document to introduce test steps and results etc.

Thanks, 
Jasmine 

Meng Li (4):
  selftests: amd-pstate: Modify amd-pstate-ut.sh to basic.sh.
  selftests: amd-pstate: Trigger tbench benchmark and test cpus
  selftests: amd-pstate: Trigger gitsource benchmark and test cpus
  Documentation: amd-pstate: Add tbench and gitsource test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   | 124 ++++++-
 tools/testing/selftests/amd-pstate/Makefile   |  11 +-
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  55 ----
 tools/testing/selftests/amd-pstate/basic.sh   |  38 +++
 .../testing/selftests/amd-pstate/gitsource.sh | 176 ++++++++++
 tools/testing/selftests/amd-pstate/main.sh    | 308 ++++++++++++++++++
 tools/testing/selftests/amd-pstate/run.sh     |  15 +
 tools/testing/selftests/amd-pstate/tbench.sh  | 187 +++++++++++
 8 files changed, 840 insertions(+), 74 deletions(-)
 delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
 create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh
 create mode 100755 tools/testing/selftests/amd-pstate/main.sh
 create mode 100755 tools/testing/selftests/amd-pstate/run.sh
 create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh

-- 
2.25.1

