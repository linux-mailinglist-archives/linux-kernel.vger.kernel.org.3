Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CECE46347A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbhK3Mkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:40:31 -0500
Received: from mail-co1nam11on2085.outbound.protection.outlook.com ([40.107.220.85]:53312
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231927AbhK3Mk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:40:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGrSRwXM6Eqh0whi9XCuIqJpRJYwW23AWNHxkvcKi/FXd4Zfe3N3ZOkVBAExZ1ZZq2A977fT+S9MGqk4dgZzbs2pzT+TG4i9Tq5oHLCiD1BvGYOU4g3g7CDbhI15FN4v95oFCoRpC2Cb10LnDCJnX0lTqi7oE2N9Lz8GNXNx3Z9dzjGuY2JyjiCMQ20SRBhm/e7AkK2v3x/4YjEosAmKAjyqNBBn9bchLmsz/dygZvTNxRSNKbxjcGMgruUT8Yk4xBoMZiF8K4QhVNu/fjVt4lE1bRpVH43xzaezt0Jjp6qbm6JFOYL5y8WC3InZnodmJQQySdkkzUICqc5Toimytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIpbH+SLTm2fk1gHi+HZy7BwdvV0kncyBGazQnXUIfk=;
 b=Vlj5qlPcNLP4TGqThmkr0qGC7NMJbzFbLa1CZva1ggYOml9penuiXrWmFya+/GSKIFgjnXJTg5bD8tjZHaWWjgwGttCie2XOURhnibsngQhMH0uOorbAW8AE0zWbCnSC9r9loKTiF12sOYqB2TL29NE324K6d1j/e9V1dhxzn7+p2xumAqSKo0r4PXIHeTNvclpwhfBnw9IlUgH5F5InCGmfE/dJImT52g0I7Vf/ZYIDjUUmVThg76PVyNEx+HH8IdCgJqvhh4UGj3eW/cmZL9lJyD/u9bnm9Uav46ymF+Haqk6l7n/JUJdwb/zPHOP7su4u7QpcJrdZdEvFGC11sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIpbH+SLTm2fk1gHi+HZy7BwdvV0kncyBGazQnXUIfk=;
 b=yv6DgyQPo7uGQ5Vhi+8D4Cz6vZcIl4MifqeAppk55kPpreuIUTuuG5lrLbJOHEG6wIjygWBctJvgRVzET7eTWrZNNA3urbsBOXDI3Ky/IXeGE4aAIDnnzU87MOjduQzCdx54sX74gVQI7DP+cBcSxx9ysG1ksUD/WhAx7Id0tko=
Received: from BN6PR20CA0071.namprd20.prod.outlook.com (2603:10b6:404:151::33)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 12:37:03 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::26) by BN6PR20CA0071.outlook.office365.com
 (2603:10b6:404:151::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:06 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:36:58 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v5 00/22] cpufreq: introduce a new AMD CPU frequency control mechanism
Date:   Tue, 30 Nov 2021 20:36:19 +0800
Message-ID: <20211130123641.1449041-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86041cd6-e5db-4b8c-ea31-08d9b3fe1ead
X-MS-TrafficTypeDiagnostic: MN2PR12MB4440:
X-Microsoft-Antispam-PRVS: <MN2PR12MB444050156D1128905DA440CCEC679@MN2PR12MB4440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZ3VrqH/DPcV+MBJCb+6/SG1a5wLhgQRB7dTz2dtFGFJ/ltETJOtLklPTl7iLliL5y3YK+J1orDzByVXIJdYMSdTKVD7M1bC8jZoVMT4qLfU9ZjYVXJ8S6qxrNMabsS73V5kZEDnwW47pMPRXYqAWqBT4pnQOoDlmyCe8izosF2O1LiCDIM1uBRJyXI7YUWrjpog495zKqZkg9j5Klc7L/HcuSKMOXK5HG8XYl5R1QlZADADhPmZlLjv6r7KuV013Au1H+/cQMqThTD8zWbtQS0RSrnO2H26Vr49h9x2JZ1wHrVbYp794fqgkwsm/6Ldzf1+bASvlJ+I/AbGQoPHtohoeTiv+3m6A17pghVaQ6k5i3UGAL5GYAZWtajIPjLkrXgJ//b3IccqKcbdz59J06scN+vA1NAs+G5D0WfYCfjOFDfnrKUQ63SYVcEXC65Hho2pa7n0959PBPrm9Zj5+P2E7/lf75qzcCbvV2FrqgsHWN249TEY0G4wGsxs1L6CygqGsYISYU3CuFIvMjhEtNVMaNRCeX+163i31zvvXp2B5JorUwibKtoucD/C8Up/WdjSAyXUtjVjMDne9yNm7j7kU051PqK/IydGjPw4cxnN+/rwXLPlw7NWhwOkLi2qlyuXNICPivaCcpa67GIxkWZvbBBbG+W2O+H8AxQ8TSKXnJFYe1D2hVMQwyMvbQdsOey+54rqiskpPViwROUWWL0MGIuFQObop7YmRKjGuivhXeme8+PtajcdAz1qtEp+jalQguHGXM9pDIul2RQuxhf+Zg7IcZvVa9RzhLaVIAczV5Qo9EC+vBDb8rgfnx+nLNtHN5/S0pBg6OcwXY+Gqnmo/UATd3EeMPTcXxwbMyGgPWK6nFp1AjXhFYI9CXmqeBur94benwxaUD6PB0/Hzp4e/mhO+YJ71zML/sw968k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(83380400001)(316002)(45080400002)(110136005)(36860700001)(47076005)(81166007)(30864003)(356005)(86362001)(2906002)(1076003)(8676002)(508600001)(966005)(54906003)(36756003)(5660300002)(7696005)(2616005)(186003)(26005)(70206006)(8936002)(70586007)(16526019)(336012)(7416002)(4326008)(6666004)(426003)(82310400004)(40460700001)(45954011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:06.6027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86041cd6-e5db-4b8c-ea31-08d9b3fe1ead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We would like to introduce a new AMD CPU frequency control mechanism as the
"amd-pstate" driver for modern AMD Zen based CPU series in Linux Kernel.
The new mechanism is based on Collaborative processor performance control
(CPPC) which is finer grain frequency management than legacy ACPI hardware
P-States. Current AMD CPU platforms are using the ACPI P-states driver to
manage CPU frequency and clocks with switching only in 3 P-states. AMD
P-States is to replace the ACPI P-states controls, allows a flexible,
low-latency interface for the Linux kernel to directly communicate the
performance hints to hardware.

"amd-pstate" leverages the Linux kernel governors such as *schedutil*,
*ondemand*, etc. to manage the performance hints which are provided by CPPC
hardware functionality. The first version for amd-pstate is to support one
of the Zen3 processors, and we will support more in future after we verify
the hardware and SBIOS functionalities.

There are two types of hardware implementations for amd-pstate: one is full
MSR support and another is shared memory support. It can use
X86_FEATURE_CPPC feature flag to distinguish the different types. 

Using the new AMD P-States method + kernel governors (*schedutil*,
*ondemand*, ...) to manage the frequency update is the most appropriate
bridge between AMD Zen based hardware processor and Linux kernel, the
processor is able to adjust to the most efficiency frequency according to
the kernel scheduler loading.

Please check the detailed CPU feature and MSR register description in
Processor Programming Reference (PPR) for AMD Family 19h Model 51h,
Revision A1 Processors:

https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip

Performance Per Watt (PPW) Calculation:

We use the RAPL interface with "perf" tool to get the energy data of the
package power.

The data comparisons between amd-pstate and acpi-freq module are tested on
AMD Cezanne processor (mobile CPU):

1) TBench CPU benchmark:

+----------------------------------------------------------------------------------------------+
|                                                                                              |
|                               TBench4 (Performance Per Watt)                                 |
|                                                                             Higher is better |
+-------------------+------------------------+------------------------+------------------------+
|                   |  Performance Per Watt  |  Performance Per Watt  |  Performance Per Watt  |
|   Kernel Module   |       (Schedutil)      |       (Ondemand)       |       (Performance)    |
|                   |       Unit: MB / J     |       Unit: MB / J     |       Unit: MB / J     |
+-------------------+------------------------+------------------------+------------------------+
|                   |                        |                        |                        |
|    acpi-cpufreq   |         48.56          |        48.89           |        47.81           |
|                   |                        |                        |                        |
+-------------------+------------------------+------------------------+------------------------+
|                   |                        |                        |                        |
|     amd-pstate    |         48.38          |        47.38           |        48.77           |
|                   |                        |                        |                        |
+-------------------+------------------------+------------------------+------------------------+

Note: The previous data was based on TBench2, as align with Suse, we use
TBench4 to re-test it. The PPW is very closed to acpi-cpufreq. And we are
still re-runing other tests.

Steam Game Demo on Ryzen 5900X (12 core 24 threads):

The picture to compare acpi-cpufreq vs amd-pstate:
https://drive.google.com/file/d/1PvSduykJn9U5MMOhzFWycnbmGmznalM3/view?usp=sharing

Two videos:
https://drive.google.com/file/d/1nQQEteL-v_zQxnOJpyW8JqvRW2FFDN2Z/view?usp=sharing
https://drive.google.com/file/d/1heuPgFG71SQHvGb6wfedrQciBfE2rhnu/view?usp=sharing

Actually, the amd-pstate driver doesn't change the physical maximum
frequency capacity in the processor. But it's able to provide the finer
grain performance control range instead of legacy 3 P-States. It has a
better performance and power efficiency than before. We will continue
optimize amd-pstate function on kernel governors to support different types
of processors such as mobile latop, performance desktop, and etc.

See patch series in below git repo:
V1: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v1
V2: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v2
V3: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v3
V4: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v4
V5: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v5

For details introduction, please see the patch 22.

Changes from V1 -> V2:
- cpufreq:
- - Add detailed description in the commit log.
- - Clean up the "extension" postfix in the x86 feature flag.
- - Revise cppc_set_enable helper.
- - Add a fix to check online cpus in cppc_acpi.
- - Use static calls to avoid retpolines.
- - Revise the comment style.
- - Remove amd_pstate_boost_supported() function.
- - Revise the return value in sysfs attribute functions.
- cpupower:
- - Refine the commit log for cpupower patches.
- - Expose a function to get the sysfs value from specific table.
- - Move amd-pstate sysfs definitions and functions into amd helper file.
- - Move the boost init function into amd helper file and explain the
  details in the commit log.
- - Remove the amd_pstate_get_data in the lib/cpufreq.c to keep the lib as
  common operations.
- - Move print_speed function into misc helper file.
- - Add amd_pstate_show_perf_and_freq() function in amd helper for
  cpufreq-info print.

Changes from V2 -> V3:
- cpufreq:
- - Add a patch from Steven to add systemio register in cppc lib. (Thanks
  to verify the driver in his platform)
- - Update online cpu mask to present cpu.
- - Enhance cppc_set_enable to cover all valid use cases.
- - Add more description in the Kconfig definition.
- - Clean up some redundance functions and data members.
- - Revise amd-pstate trace event prints.
- - Move the amd-pstate traces into power trace system and set the driver
  as build-in instead of module.
- - Clean up the duplicated sysfs with core cpufreq driver.
- - Revise the amd-pstate RST documentation.
- cpupower:
- - Revise the cpupower_amd_pstate_enabled() function to use
  cpufreq_get_driver helper instead of read sysfs.
- - Clean up the amd-pstate max/min frequency APIs, because they are
  actually the same with cpufreq info sysfs.

Changes from V3 -> V4:
- cpufreq:
- - Rebase the whole series to Rafael's pm branch (5.15)
- - Fix the typo in the commit message and comment.
- - Clean up function implementation.
- - Clean up freq&perf sysfs APIs.
- - Fall back to move amd-pstate traces out of power trace system, because
  it's flexible to debug and fine tune processors with the shared memory
  solution.
- - Add a kernel param to disable shared memory on amd-pstate, it can be
  enabled manually.
- cpupower:
- - Introduce acpi cppc library support.
- - Clean up the duplicated amd specific perf/frequency.

We received two issues that reported on the processors with shared memory
solution from the community. 

First one:
https://lore.kernel.org/linux-pm/a0e932477e9b826c0781dda1d0d2953e57f904cc.camel@suse.cz/ 

Thanks Giovanni's support and suggestions, we corrected the calculation
method and duplicated the performance issue in a 64 cores / 128 threads
threadripper which is similiar with EPYC 7713. Check with firmware guy, the
sample rate is about 1 ms that the hardware responds the frequency change.
We are working to simulate the acpi pstates with cppc api and checking
where is the gap with acpi-cpufreq. Will share you the status later.

Second one:
https://lore.kernel.org/linux-pm/f9323c6fddd4a55d8ca4191a9539ebd056221045.camel@gmail.com/

Thanks Matt to help us reproduce this issue in our side with Ryzen 5900X.
Below is the video to compare with amd-pstate and acpi-cpufreq on "Control"
steam games. The FPS can be increased as well. It is probably something
wrong in the SBIOS.
https://lore.kernel.org/linux-pm/DM4PR12MB5136084E5DC1809FBB578075F1959@DM4PR12MB5136.namprd12.prod.outlook.com/

Due to some issues on shared memory solution, so we fallback to build as a
module and add a parameter "shared_mem" to disable amd-pstate on processors
with shared memory solution for the moment till we complete tunning on this
function.

Changes from V4 -> V5:
- cpufreq:
- - Fix subject typo.
- - Fix Clang-13 build warning.
- - Update RST documentation for the latest update.
- cpupower:
- - Fix the table check condition at cpufreq_get_sysfs_value_from_table.

Thanks,
Ray


Huang Rui (19):
  x86/cpufeatures: add AMD Collaborative Processor Performance Control
    feature flag
  x86/msr: add AMD CPPC MSR definitions
  cpufreq: amd: introduce a new amd pstate driver to support future
    processors
  cpufreq: amd: add fast switch function for amd-pstate
  cpufreq: amd: introduce the support for the processors with shared
    memory solution
  cpufreq: amd: add trace for amd-pstate module
  cpufreq: amd: add boost mode support for amd-pstate
  cpufreq: amd: add amd-pstate frequencies attributes
  cpufreq: amd: add amd-pstate performance attributes
  cpupower: add AMD P-state capability flag
  cpupower: add the function to check amd-pstate enabled
  cpupower: initial AMD P-state capability
  cpupower: add the function to get the sysfs value from specific table
  cpupower: introduce acpi cppc library
  cpupower: add amd-pstate sysfs definition and access helper
  cpupower: enable boost state support for amd-pstate module
  cpupower: move print_speed function into misc helper
  cpupower: print amd-pstate information on cpupower
  Documentation: amd-pstate: add amd-pstate driver introduction

Jinzhou Su (1):
  ACPI: CPPC: add cppc enable register function

Mario Limonciello (1):
  ACPI: CPPC: Check present CPUs for determining _CPC is valid

Steven Noonan (1):
  ACPI: CPPC: implement support for SystemIO registers

 Documentation/admin-guide/acpi/cppc_sysfs.rst |   2 +
 Documentation/admin-guide/pm/amd-pstate.rst   | 383 +++++++++++
 .../admin-guide/pm/working-state.rst          |   1 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |  17 +
 drivers/acpi/cppc_acpi.c                      |  93 ++-
 drivers/cpufreq/Kconfig.x86                   |  17 +
 drivers/cpufreq/Makefile                      |   5 +
 drivers/cpufreq/amd-pstate-trace.c            |   2 +
 drivers/cpufreq/amd-pstate-trace.h            |  77 +++
 drivers/cpufreq/amd-pstate.c                  | 609 ++++++++++++++++++
 include/acpi/cppc_acpi.h                      |   5 +
 tools/power/cpupower/Makefile                 |   6 +-
 tools/power/cpupower/lib/acpi_cppc.c          |  59 ++
 tools/power/cpupower/lib/acpi_cppc.h          |  21 +
 tools/power/cpupower/lib/cpufreq.c            |  21 +-
 tools/power/cpupower/lib/cpufreq.h            |  12 +
 tools/power/cpupower/utils/cpufreq-info.c     |  68 +-
 tools/power/cpupower/utils/helpers/amd.c      |  76 +++
 tools/power/cpupower/utils/helpers/cpuid.c    |  13 +
 tools/power/cpupower/utils/helpers/helpers.h  |  22 +
 tools/power/cpupower/utils/helpers/misc.c     |  62 ++
 22 files changed, 1508 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/admin-guide/pm/amd-pstate.rst
 create mode 100644 drivers/cpufreq/amd-pstate-trace.c
 create mode 100644 drivers/cpufreq/amd-pstate-trace.h
 create mode 100644 drivers/cpufreq/amd-pstate.c
 create mode 100644 tools/power/cpupower/lib/acpi_cppc.c
 create mode 100644 tools/power/cpupower/lib/acpi_cppc.h

-- 
2.25.1

