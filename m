Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471054FF2E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiDMJI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiDMJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:08:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41CB43482;
        Wed, 13 Apr 2022 02:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbshP1ne1P+iTTVNIoTvesStC7ZgA4qb6e0KW4tI7hB3G1rsAQH6bdsHrAOJOeHs4+DotsA54SnOo92f7+mR6zUCVRppFjVV5yfHZcn7dhI8VneBP5M5FHPCeOyBEtnp6xQCxGS7mZMeQ7GvM2lIA0id3Lz6CaHwYz3twTJ3MNTHKXCi716pEaHfNNzDA4feh0atFRqTIKdWlzQ7nsVHM9nM7WdQ4Dp+V1onGrh32tnEyNHsZrW4KD+uUduP+VfoQ7BfmW8Z7ti3ePLxJ6sFmyCVEtKY0f+LSWrWZnyLSPELLiZK06y5CBYBaVag63hlRhA95V4hzng9WAzPmOXMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOxZgj1Rryj5h8ieJHaxmuru+/F8V1Vt9g+DzmGJRWc=;
 b=Nfs0w3jJJdGbnjorc9W5pNiW/pIXyniLC3c8hBHPxpq9d/9Oz6J49X/HQosuduW0dCSq5tkZxYkn4b27fioc1vJZUVPf9grCpDU7AFf8PJnhNHz8Y4MXSicU8q5PYEVaUUduMQ/XYACud/XPEvlSC+klLDaAFTqjVKmnQTXpoERSK00TMg6cROVWe9pPAw2W/J7ntdtfTr/MwBynt23aMUewJsYZFKlPk+W2tAK++LOJH59YneaJNR2DppNjrzv5F1CnPjL2fytFYJZ2dXUe4EXTSwAswO0kBvLMayAb+whBDfJvsjfXZolJOJy2RgIRVTk4IWLqGY0ekR9/j+lyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOxZgj1Rryj5h8ieJHaxmuru+/F8V1Vt9g+DzmGJRWc=;
 b=A1rCGxgzX7YY3DIoSKFZ+HlolULZ9pzdVo3tAxMWuHZlAqwZ7slEYmmSMTfv2NSN6bjNijTicrAVEWG4RArbznxngNVyxl94OlGD2RxfkC5UWKNIEmBMPuTN/OS8OV0TmwRnckvDBi3mjbOHBO6309D5B2gI7PwxcwPTPPOikGU=
Received: from BN9PR03CA0416.namprd03.prod.outlook.com (2603:10b6:408:111::31)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 09:06:32 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::13) by BN9PR03CA0416.outlook.office365.com
 (2603:10b6:408:111::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Wed, 13 Apr 2022 09:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 09:06:32 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 04:06:22 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH v2 0/3] Add unit test module for AMD P-State driver
Date:   Wed, 13 Apr 2022 17:05:07 +0800
Message-ID: <20220413090510.4039589-1-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65cc074b-f586-4113-a411-08da1d2ce75d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4224:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB42246F490C782411F3EA763DF7EC9@MN2PR12MB4224.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0ULeXJhde603sWLy30WNwU1h2SLwRiUicZiGwdVMEQX+fQZ1h3W9f6/e/y3qkkGdVKqV6hi7VCPAmAA7TBsvIRPSrgJwB/YmvheG1PmolnyrvaODCTFbLIlYQSTaLstqMARLdsHj/JOBeu+PI7P2BsqG66V0OR3Op/hykeC8a9EXJiA/kty/mzoP/8xyvlRKWsVQ1bPRpJjDTpPVM4JtqlHQXJ/kQ0fZdT3YlnxXw4JJDJOJXCv/PSbivFWmw8GQBybnF+bl1ILkxkKjYtMWrK9nqjokxaFpBPy9RGPOAmfNjn61TJD/fxz/+KZzGIZNRP7V3UczJ6jTFjjptVTo6n52/mpsppHTqTs6fRw7dPzpGJWim9fSQXaaqlIXWnswNzhtFa2MC4PGCzpBmIOgQA8W7hemhMg2mtq/5v9AjlBESh7GJwwxzi8j3QEzkhGu0OZqTHwiJbfN1/s1KZ0DKP8CuYKEY8UtG7UlurnY9kskbozpmJXKT2+/fcowV1YvS81nEEiUF/8kR52FexbJH7EW47kBY5+aEFEAMempe0uG7jEXjtum6n01XyVmIqOJ3EboiQY2B1mpjlIDPvuTEhyQn2OoVrtaoCFIVOg1Kaam1Z7HqWaNG9Pnr4P+B20xIK6cyI8EmNWuJ4xL9w4gHNWSTbAgvUl4b1vRy8TNwtz9orAk2e10wvGVsvcrxKSKrFKoG+caijhI9VWkYYpLlOr+RWPV420Q493FANEFAS1P4IK9NCYcpmBqtP3vEuMRQKOEWts+muxEsHm3hRQkCnGxg33CrCdPxKN5DDs314=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(70586007)(70206006)(86362001)(8936002)(186003)(83380400001)(8676002)(336012)(356005)(4326008)(40460700003)(81166007)(966005)(47076005)(82310400005)(16526019)(2906002)(36756003)(426003)(26005)(1076003)(508600001)(316002)(7696005)(6666004)(54906003)(36860700001)(110136005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 09:06:32.3161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cc074b-f586-4113-a411-08da1d2ce75d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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

AMD P-State unit test(amd_pstate_testmod) is a kernel module for testing
the functions of amd-pstate driver.
It could import as a module to launch some test tasks.

We upstream out AMD P-state driver into Linux kernel and use this unit
test module to verify the required conditions and basic functions of
amd-pstate before integration test.

We use test module in the kselftest frameworks to implement it.
We create amd_pstate_testmod module and tie it into kselftest.

For exmaple: The test case aput_acpi_cpc is used to check whether the
_CPC object is exist in SBIOS.
The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is
not existed at the detected processor, so it is a necessary condition.

At present, its test cases are very simple, and the corresponding test
cases will continue to be added later to improve the test coverage.

See patch series in below git repo:
V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/

Changes from V1 -> V2:
- cpufreq: amd-pstate:
- - add a trailing of amd-pstate.h to MAINTAINER AMD PSTATE DRIVER
- selftests: cpufreq
- - add a wrapper shell script for the amd_pstate_testmod module
- selftests: cpufreq:
- - remove amd_pstate_testmod kernel module to .../cpufreq/amd_pstate_testmod
- Documentation: amd-pstate:
- - amd_pstate_testmod rst document is not provided at present.

Thanks,
Jasmine

Meng Li (3):
  cpufreq: amd-pstate: Expose struct amd_cpudata
  selftests: cpufreq: Add wapper script for test AMD P-State
  selftests: cpufreq: Add amd_pstate_testmod kernel module for testing

 MAINTAINERS                                   |   1 +
 drivers/cpufreq/amd-pstate.c                  |  60 +---
 include/linux/amd-pstate.h                    |  74 +++++
 tools/testing/selftests/cpufreq/Makefile      |   2 +-
 .../selftests/cpufreq/amd_pstate_testmod.sh   |   4 +
 .../cpufreq/amd_pstate_testmod/Makefile       |  20 ++
 .../amd_pstate_testmod/amd_pstate_testmod.c   | 302 ++++++++++++++++++
 tools/testing/selftests/cpufreq/config        |   1 +
 8 files changed, 404 insertions(+), 60 deletions(-)
 create mode 100644 include/linux/amd-pstate.h
 create mode 100755 tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
 create mode 100644 tools/testing/selftests/cpufreq/amd_pstate_testmod/Makefile
 create mode 100644 tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c

-- 
2.25.1

