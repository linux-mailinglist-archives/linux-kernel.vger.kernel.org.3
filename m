Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2678589779
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiHDFro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbiHDFrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:47:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FE5606A1;
        Wed,  3 Aug 2022 22:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX5mClMI+bR1izV1zm5lq+CysMmK3zA0CciGvEck6SrrbcJo/tsaJ9PHcTnPtSY0A1UZsZooxraw78Zn21nbfkAgXPRVtILkEr/jt2/CLTfbmwUV0IK49aH7OLi3k/p+WyomBjp+ntzvSDIF9FpnFsV2QbD6QK4zQtd0byUoBuPdZE+jL9cGByOWK7DW96AYa6kiH8kn90M4gDjnj4cqM825L2F2tNtotV5SMHE8QkJBJt+dCRheptWCHfEW/PVjs5eVjoxMaDLS4e50icSUtH1+cnKWS/dA3L51YGQpj3YqfC05mP6H4WDyq/JLKvu8kkTDTwmi3y2D0LzC4/s8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deokd5XzMEHlnuOZQW21t//HUwofZo1wcheqUx+YY+I=;
 b=VMK61LgtYWO706G/FJhcc9gibn6w2tOR2VYEroqmdCWXU7VEH1FJSMB6RoV90A6nadlnhjKkKQEXAxOiGi4l3H1C9BO+UJpAZuuAbBNfi/o2GkK+MuKSt3FQvn+aXD1Z/VNOEr4RWQrVFIUeye2lqw3OO85RffeQTufIZ+qouiFILxZ8CSA7zND2ROL9hi2pmcnnH9R1N95k4/55yrWOHHd5HdMicC50R5xUTNkRYyB0aDiI4OSy0Eo+4xl/HxqUNmBF1T65O+ZAj5HZu9CxtqOt5i9t/ycNGNdEigmD8XBxayyOst0Jcd0WSgbDrkEtLp2SN8VxhsPYSAIZXYDDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deokd5XzMEHlnuOZQW21t//HUwofZo1wcheqUx+YY+I=;
 b=enutVI+EGR5jVcGxmWg92TQ1usow1ol5wl1x1ACcv8cf6f5rq+Lo4r77mMV8zVkdP0NHdkDCOI/V4gQQFpVLE3X3s0xpHk1LHakRAQBpl+RxqeDwQhhWyhA+5tssyoQtRS0FAzmhDdecgWWvuYbJmEX/Tkh9DxgAZHl5J0dXvXM=
Received: from DS7PR03CA0281.namprd03.prod.outlook.com (2603:10b6:5:3ad::16)
 by DM6PR12MB4809.namprd12.prod.outlook.com (2603:10b6:5:1f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Thu, 4 Aug
 2022 05:47:08 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::8e) by DS7PR03CA0281.outlook.office365.com
 (2603:10b6:5:3ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Thu, 4 Aug 2022 05:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 05:47:07 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 4 Aug
 2022 00:47:00 -0500
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
Subject: [PATCH V2 0/4] Add tbench/gitsource new test cases for amd-pstate-ut
Date:   Thu, 4 Aug 2022 13:44:10 +0800
Message-ID: <20220804054414.1510764-1-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 304135ed-2c05-47b2-e8f7-08da75dcc4b4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4809:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXxlI/85PAOVlwm9S1ee8PivfIEEwcjE8+DU9L0zF2EcDLZFTGG6hloi3Zzh0ojb+oAjFyW4xVJ70kKLaMD7/6FkSBkjLieTX88LIFbqDoSb8E9TCryBUz0Z6+FiOMcz6/foUMBG0qWCEX+7ks6XG3KCGxHMV5gUz/nlQLdbuZSvTygR9tVRNwZuVvWXaVd5A+hDoPVLAHK7aRM4QO/+hOiPf1DsY+wMEVwKLb7x5BUBDbc5cKb9ecwTE8QkAEgGoJx7tEGXZzNnVSD6c6AflkrOE88dEcXGX8FyGTX9X4hUiPq1DL4R7W0+1+uFPGFXPkX3L1Nkeo7RQVJZHm4PplX8XZgtRVrpaR+rMiwa69jbVLB7A/vrfOs2DXxKAaQl3XW2dBiApt2ypLzIBu0xRgnibxCJbNLswTtWA/ENbnt00NXvpdDCzFrEO1Xj6cUU4pDp+q5DcqvsyMrL/Opc9+u7nlq8lBJM/Z1M50Ojp6Fss6S5X2XH2i1MKAryhKrwfH7JNjDX0wCZNmfB0zXXskmr0O8rD+LDKbYlkvvhFujze13uOCRthJ9Tgc4msi3VkfhZSJItltgGynuXMTnqGCVdR0luhdgmqzXR7JlMRfAdujjfOs3d53c/L0Vi0H6SRfTYgjFUZix9R/yigd+cDGxieTF/CNx0yYKWMtou8LzvEWNJ2gmYDh+rxxgHZECbnzO7Zzx4ZxlnOt0PqffYwY2wkcb85PIowx/sJS9o5R6uJzxR+/E7OHB8/TDqP64p/yDI4VTIDR3EOlYgAlDNy1hvW+XP12tEETTe2Sy2BZww5HpECe6jXC/fIKA58/V5bLU26ZWCWmdaAvasOxfy7nxwPda7hM0hHBlmjeWafy1ID+TLvqBp8BKWNNGpm1SlgZm7sGHK5G8njSp+S8nBDU8qDjl0/hjnkR2FYlAFJZA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(40470700004)(36756003)(8676002)(4326008)(83380400001)(8936002)(5660300002)(70586007)(36860700001)(86362001)(2906002)(40460700003)(186003)(2616005)(336012)(426003)(70206006)(81166007)(316002)(47076005)(40480700001)(110136005)(54906003)(1076003)(16526019)(966005)(82740400003)(82310400005)(478600001)(41300700001)(356005)(26005)(6666004)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 05:47:07.8854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 304135ed-2c05-47b2-e8f7-08da75dcc4b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
3) Run tbench benchmark comparative test on acpi-cpufreq kernel driver.
4) Get desire performance, frequency, load by perf.
5) Get power consumption and throughput by amd_pstate_trace.py.
6) Analyse test results and save it in file selftest.tbench.csv. 
7) Plot png images about performance, energy and performance per watt
for each test.

Third, add gitsource.sh trigger the gitsource testing and monitor the cpu
information.
1) Download and tar gitsource codes.
2) Run gitsource benchmark on specific governors, ondemand or schedutil.
3) Run tbench benchmark comparative test on acpi-cpufreq kernel driver.
4) Get desire performance, frequency, load by perf.
5) Get power consumption and throughput by amd_pstate_trace.py.
6) Get run time by /usr/bin/time.
7) Analyse test results and save it in file selftest.gitsource.csv. 
8) Plot png images about time, energy and performance per watt
for each test.

Finally, modify rst document to introduce test steps and results etc.

See patch series in below git repo:
V1:https://lore.kernel.org/lkml/20220706073622.672135-1-li.meng@amd.com/

Changes from V1->V2:
- selftests: amd-pstate:
- - delete main.sh and merge funtions into run.sh
- selftests: amd-pstate:
- - modify ppw to performance per watt for tbench.
- - add comments for performance per watt for tbench.
- - add comparative test on acpi-cpufreq for tbench.
- - calculate drop between amd-pstate and acpi-cpufreq etc.
- - plot images about perfrmance,energy and ppw for tbench.
- selftests: amd-pstate:
- - modify ppw to performance per watt for gitsource.
- - add comments for performance per watt for gitsource.
- - add comparative test on acpi-cpufreq for gitsource.
- - calculate drop between amd-pstate and acpi-cpufreq etc.
- - plot images about perfrmance,energy and ppw for gitsource.
- Documentation: amd-pstate:
- - modify rst doc, introduce comparative test etc.

Thanks, 
Jasmine 

Meng Li (4):
  selftests: amd-pstate: Modify amd-pstate-ut.sh to basic.sh.
  selftests: amd-pstate: Trigger tbench benchmark and test cpus
  selftests: amd-pstate: Trigger gitsource benchmark and test cpus
  Documentation: amd-pstate: Add tbench and gitsource test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   | 192 +++++++++-
 tools/testing/selftests/amd-pstate/Makefile   |  11 +-
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  55 ---
 tools/testing/selftests/amd-pstate/basic.sh   |  38 ++
 .../testing/selftests/amd-pstate/gitsource.sh | 345 +++++++++++++++++
 tools/testing/selftests/amd-pstate/run.sh     | 358 ++++++++++++++++++
 tools/testing/selftests/amd-pstate/tbench.sh  | 358 ++++++++++++++++++
 7 files changed, 1282 insertions(+), 75 deletions(-)
 delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
 create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh
 create mode 100755 tools/testing/selftests/amd-pstate/run.sh
 create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh

-- 
2.25.1

