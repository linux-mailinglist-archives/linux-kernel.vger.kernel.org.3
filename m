Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92AA511A95
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbiD0N5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiD0N5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:57:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099AF27CEA;
        Wed, 27 Apr 2022 06:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQDVX6rPtyrtjBWynkiU77/38JSDSORw6ZpRDeErkXQwCVxmnMIJ3tMReImynodBcC9udSD49VKVjHykIzdq7pQKwFLgxlUZe5oBemMYL3XggV7jKJRJWP82buTzXy/YV/s0feRf183wITYSMqS9cRlJW85uM6rhqvQQM+3mK84lKPNMDMdFcPyyxrQaceEY5o0k93V0TCI4S+cTlVdsSJC0mNyZosaNMiTDUHEHJPNaBZDs3zGkG7ju5GS0a/dxXJqT4gsDTAtebyph4fl10AljMBt71dORWMuZm67tU88V9afQ+tiBsVtlM5MFuD14WJQAHltAogKFOfNzglkXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAVgVGnNIzAzztIix2UcVfLquXwIGbPNolosqIoIuks=;
 b=X06CtIJqVbnhV2WRxc4M4IwOpPwNuDA12UoYe8XR1C0K6+2psMrd+A0AhAQnw0FW/GF/Zovj0oxvPcRtPchfqTo2VEhMzng+VwjGcIPe86H36xPuD/iYN7IcV+1XrkVNkXWhvaAQtgZw5TGL71U87f/aeKNOUCJrI+bR+O+qxMiEnowsmK4jY+1XUbRc7CHYyctMrTt+fr3rANV7ITpDO9c+FExKmRcRbm1PCPBp2MNQBiozcNSbnrkTmUZ/Ahp/ByyWTHiwnMNH6sMG6wGv3pPSSrN9Oamhgko/R04y5QJs2H0ElsiVfJnLbEuDXOdAcDxSliLuOtRQs5yFrZpLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAVgVGnNIzAzztIix2UcVfLquXwIGbPNolosqIoIuks=;
 b=Ldi88uXbO5tHSdU2xPxtrBauOd8M0ITQbKgiBUMpBUtKg6LmXtCYmkYCjF8Zya5Ja9MOGq6sZOIRYQfZzhVMIgastmROHZRkGYbjCjRKMnWgV4N9iEPTa8maQlsFWhSouhI1E5xlW/MnUAs2d39tD0pnuKrV5bLiB/cPj2i77U0=
Received: from BN8PR15CA0037.namprd15.prod.outlook.com (2603:10b6:408:80::14)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 13:54:23 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::d1) by BN8PR15CA0037.outlook.office365.com
 (2603:10b6:408:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Wed, 27 Apr 2022 13:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 13:54:21 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 08:54:17 -0500
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
Subject: [PATCH V4 0/3] Add unit test module for AMD P-State driver
Date:   Wed, 27 Apr 2022 21:53:12 +0800
Message-ID: <20220427135315.3447550-1-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d23b2b9-5a96-44bd-c2c2-08da28556e80
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5662:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB56624F101EDDDD211286030BF7FA9@SJ0PR12MB5662.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syKTcMatMKohIFN8+CLvG4GovXKnzaTiNa7rlXTxRSyud03XOi/JxXSXsYOEns5XOmMW9DRMqgxJH/Vy32IhICOt0hEHG1r6FnOaWJpDITm31xLfFQ8pBmTjD6zTkbtj3EAz8SKnVfO7zH07MhYSqROUvGZmYFPME6t0xAJJDLxv0ZbYps5OF09fZZJhZL+uKsMemRV11mBGu7MddZWiw2bpiBxBCf9NuNaOKPQ9EyC3m9OEvUxAVj6ssSXaRdY7jQZL2MOfAP5clllAcIPmKRl/M8n/1CDf2m9McDeayewT+cqj8AcGbzDJJBhV/+Eirqfp0L0Cz3hPsx5QDcucnwDvNiCrVcmlYblpcu+478Ym1lDgHkgReyKQMh5ScdV0a+dD+kH/ahNAYBsGoiTpZjjUW7v7iBT+PcrbrHAxW5O2j2tZCJjDOxMw4CcSh25hd+R7vQx8Ju/wi0aVazYNBU8yj+VSuWT6psanie/YG2cdwmUPNo+V12m9cldDR/tkpn9IcCmh4om9bRIrDHteEolq+Ydujr+fQEDk+yFhrpGoND9CmIvFlRHOqDZ4Iw8Xp3WJ7IQSgJb0y+G5bFeA5X+8u7dyilbffcoPjqh9fYxW8vzbqZjoANVvpH+SRubeBP2kSWpXg2Uu0HdZ8rLoYXVRfvYeNFQIoAz0iO8ZoZsP6dFxX5OU6NekJwklHkr3i+jiNJDJOJy/8jW34vti0yA80V2t/HYRTIACtCromvs548dbGiC3hWReJPO7RZUOMZXnmNAahUV+c2h4CH3Wizzy8bHRRcrKPkoYLAQEsQJRSv1ATtO6OF1EdgRC6t6HgrPTgzsj1/havuW/r7W/+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(63370400001)(83380400001)(4326008)(8936002)(5660300002)(16526019)(356005)(63350400001)(316002)(2616005)(86362001)(966005)(82310400005)(508600001)(81166007)(7696005)(26005)(36756003)(70586007)(6666004)(1076003)(70206006)(54906003)(8676002)(110136005)(186003)(36860700001)(426003)(336012)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 13:54:21.6984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d23b2b9-5a96-44bd-c2c2-08da28556e80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662
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

AMD P-State unit test(amd-pstate-ut) is a kernel module for testing
the functions of amd-pstate driver.
It could import as a module to launch some test tasks.
1) It can help all users to verify their processor support (SBIOS/
Firmware or Hardware).
2) Kernel can have a basic function test to avoid the kernel regression
during the update.
3) We can introduce more functional or performance tests to align the
together, it will benefit power and performance scale optimization.

We upstream out AMD P-state driver into Linux kernel and use this unit
test module to verify the required conditions and basic functions of
amd-pstate before integration test.

We use test module in the kselftest frameworks to implement it.
We create amd-pstate-ut module and tie it into kselftest.

For example: The test case aput_acpi_cpc is used to check whether the
_CPC object is exist in SBIOS.
The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
existed at the detected processor, so it is a necessary condition.

At present, it only implements the basic framework and some simple test
cases.

TODO : 1) we will add more test cases to improve the depth and coverage of
the test.

Please check the documentation amd-pstate.rst for details of the test steps.

See patch series in below git repo:
V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
V2: https://lore.kernel.org/lkml/20220413090510.4039589-1-li.meng@amd.com/
V3: https://lore.kernel.org/lkml/20220421074152.599419-1-li.meng@amd.com/ 

Changes from V1 -> V2:
- cpufreq: amd-pstate:
- - add a trailing of amd-pstate.h to MAINTAINER AMD PSTATE DRIVER.
- selftests: cpufreq:
- - add a wrapper shell script for the amd_pstate_testmod module.
- selftests: cpufreq:
- - remove amd_pstate_testmod kernel module to
  .../cpufreq/amd_pstate_testmod.
- Documentation: amd-pstate:
- - amd_pstate_testmod rst document is not provided at present.

Changes from V2 -> V3:
- cpufreq: amd-pstate:
- - adjust the order of add amd-pstate.h in MAINTAINERS.
- selftests: cpufreq:
- - remove the call of amd_pstate_testmod.sh from cpufreq Makefile to
  main.sh.
- selftests: cpufreq:
- - add explain the goal or intention of the AMD P-State Unit Test
  module.
- - modify comments.
- - use the checkpatch.pl to check my patches.
- - add conditions judgment before formal test.
- - delete some unnecessary test cases.
- - modify test cases about perf and performance etc.

Changes from V3 -> V4:
- selftests: amd-pstate:
- - remove script and test module to tools/testing/selftests/amd-pstate/
- - uniformly named amd-pstate-ut.
- - check current architectures and cpufreq driver in amd-pstate-ut.sh
- - delete codes about conditions in amd-pstate-ut.c 
- Documentation: amd-pstate:
- - add introduce document about amd-pstate unit test.

Thanks,
Jasmine

Meng Li (3):
  cpufreq: amd-pstate: Expose struct amd_cpudata
  selftests: amd-pstate: Add test module for amd-pstate driver
  Documentation: amd-pstate: Add unit test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   |  87 ++++++
 MAINTAINERS                                   |   1 +
 drivers/cpufreq/amd-pstate.c                  |  60 +---
 include/linux/amd-pstate.h                    |  77 +++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/amd-pstate/Makefile   |   9 +
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  27 ++
 .../amd-pstate/amd-pstate-ut/Makefile         |  20 ++
 .../amd-pstate/amd-pstate-ut/amd-pstate-ut.c  | 275 ++++++++++++++++++
 tools/testing/selftests/amd-pstate/config     |   1 +
 10 files changed, 499 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/amd-pstate.h
 create mode 100644 tools/testing/selftests/amd-pstate/Makefile
 create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100644 tools/testing/selftests/amd-pstate/amd-pstate-ut/Makefile
 create mode 100644 tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.c
 create mode 100644 tools/testing/selftests/amd-pstate/config

-- 
2.25.1

