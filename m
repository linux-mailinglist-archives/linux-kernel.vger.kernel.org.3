Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E533647A14B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbhLSQgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:36:05 -0500
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:43521
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233228AbhLSQgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:36:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xed6fKkc5suuXJ9OVPhc768J282i5/mIr1qyhNMR41N0OYi/4Mao5RlNYfOYUPlgUnSyAe9W8K+sKi3sP4zR3O9QR5Ys7vdKCnNzILISEWMrIrPRPa3L5onlVorQiH07VOY9dlqKIksmuXXbBx6Ae7ltNR3Bp1CFUOt+5MOCkEYFwtT7fFVjqdDelV7CVlyKlgR45S469p9jcL4PT705sMSt8AqI5sxP8x3zU2DPvD/Y7tlCkgBwq7V3b9GZcliPo9j0vXbTJkhlTm6PUeWjvE9c3vb+t6+4QfHP+P36yBO/nuvQLpf6GTzMcVyp4PD232lu4hinljbc0Hry6SCsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xq+AUCnwKDhSqKqPoh+AnkIxCB0HXZlOLY1COrvDHM=;
 b=Gccx88Dp5ieOpHAmfscjTW05X1OEXDn0xdYNk8Ez/anUvekDqfvlPtsnFOXrF2GIDrnwHJB9vwOso0ZONVz3hlndzEA5cNMspRM7VgsROtRIwFiIA2OvZdn9S9C+BjqML3XZjaBA4UPllCzfB7Rg9iokm6vt9yQgeioUBAu81YGVV6arPqvp0GauEjh4StsYEhpqBQOYPYJ2LYsaTrtgVO/dHIOc4CQ7LDz6/6nfqlh7FO3xU8wRWv5f8rG4xX9k0VrgaGTJtYc1PktoLH3BKr0LCdnDVQ6uefIo7izPpZH1wJgIKL68vXma/SWBXYVyQL35f5DKFek/pBYGp3JAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xq+AUCnwKDhSqKqPoh+AnkIxCB0HXZlOLY1COrvDHM=;
 b=fj1BAZKZ6p0do72TfAtVCHUXR7MFcEM+FeAJ3F2KTeXwPdLK83STu39YOoaoWfX+ZXVCacXLQ7HaUnz5j0wbGILCHmzlHcN3kuqXWfCVi95IjEc7m/Wvo1LwvY4mHKZLRH00lUv91gHCj6eEBiD+MCuBU51r1nulR1tWWCPf0fs=
Received: from BN9PR03CA0105.namprd03.prod.outlook.com (2603:10b6:408:fd::20)
 by MN2PR12MB3150.namprd12.prod.outlook.com (2603:10b6:208:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Sun, 19 Dec
 2021 16:35:58 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::da) by BN9PR03CA0105.outlook.office365.com
 (2603:10b6:408:fd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Sun, 19 Dec 2021 16:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:35:58 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:35:53 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Subject: [PATCH v6 00/14] cpufreq: introduce a new AMD CPU frequency control mechanism
Date:   Mon, 20 Dec 2021 00:35:14 +0800
Message-ID: <20211219163528.1023186-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 666217fb-5bf2-45cb-5969-08d9c30da2d3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3150:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31509DFE2AB11AE1E336C22DEC7A9@MN2PR12MB3150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xea6gZNNkRbgdAXueBgvjglAJgz2h7zz+SuVsacoJ3/tItEgxDhHp773kP5dOJFPC39ub1WCi+pOo0NLNMp/+tzUXYjrKE5TV0qSQ1OGVtmmTsmQzjrqOcQPjdqEl0Kko3BlsCWog1ExwgqnucjEqjJeXsXrVnJ5lit01XB57ZJ2VeXV40sJwrIzcGdqudl34wrz0SufNnDRuHjpE4q3MmitxWiZgmTgswIJpxi0laYPSHHTozStReebps8vw3iweAo0JS2dupoZsbVZOfX2HKDXwB43eouX03Jmg370Y5lta5jFF1mploggtV5tUZaicqX3CU1YBzTAGMH5UhNoPy/izqIhC3S1SbtB2U0ipzibmT9aB/AtrNbVa8pTSlGttv4OMPa1kCkauwWl9DpGzNMeepAVTKtQBUdZoExCv44qUiEFXu8esotWMpgj35dX8vZRnzsouZ9Onsd2XD6omFuL/4a/Ic+f6JTyCWZWL1Ic2iRYulM1tlKRFe+EZx4KIt4ef6buwL2unTBjj1rdJOfU7oOLw01t0Gwtb8+1I95RBAI7/tCMiVZRFZ92dqojBtdMJKaMrlg6fQZDHfLBkwq4UHP5dyJChkVWGJwHZOcp+YJ3sTCFfAwSE+pFfstOUeI4NMO/jr1cjThNMLtnyczn+JnBCxu9j6pAaKrep3jZ6/0EYkHbZGA5DQ9Og88yz3CxZV9nocPu3Lf9j81KKj6e8gC8UjJ7Y23MBm7nt/gK/PFJLJSLWe+Ue1fyRlCL8F5IXAkiDLj4Achi6Vf0HrO5dhXQ6C3sBSdeqQnNQnNp8sug8EbHhd1s0ILwerPLSro2EwN9RkDvO+MCc7eTOYuqffns0PQjIoDriy8kSxygHOpLTuCa1jZGNL47BuPtOPePnDWKWWH9LvzYW7Sc054lHZ6sd1+J4puQAs7jcM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(966005)(5660300002)(36756003)(30864003)(86362001)(54906003)(110136005)(45080400002)(426003)(70586007)(40460700001)(7416002)(6666004)(336012)(83380400001)(8676002)(7696005)(36860700001)(26005)(47076005)(186003)(2906002)(70206006)(82310400004)(356005)(8936002)(316002)(16526019)(2616005)(81166007)(4326008)(45954011)(508600001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:35:58.2918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666217fb-5bf2-45cb-5969-08d9c30da2d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We would like to introduce a new AMD CPU frequency control mechanism as the
AMD P-State driver for modern AMD Zen based CPU series in Linux Kernel.
The new mechanism is based on Collaborative processor performance control
(CPPC) which is finer grain frequency management than legacy ACPI hardware
P-States. Current AMD CPU platforms are using the ACPI P-states driver to
manage CPU frequency and clocks with switching only in 3 P-states. AMD
P-State is to replace the ACPI P-states controls, allows a flexible,
low-latency interface for the Linux kernel to directly communicate the
performance hints to hardware.

AMD P-State leverages the Linux kernel governors such as *schedutil*,
*ondemand*, etc. to manage the performance hints which are provided by CPPC
hardware functionality. The first version for AMD P-State is to support one
of the Zen3 processors, and we will support more in future after we verify
the hardware and SBIOS functionalities.

There are two types of hardware implementations for AMD P-State: one is full
MSR support and another is shared memory support. It can use
X86_FEATURE_CPPC feature flag to distinguish the different types. 

Using the new AMD P-State method + kernel governors (*schedutil*,
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

The data comparisons between AMD P-State and ACPI CPUFreq module are tested on
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
|    ACPI CPUFreq   |         48.56          |        48.89           |        47.81           |
|                   |                        |                        |                        |
+-------------------+------------------------+------------------------+------------------------+
|                   |                        |                        |                        |
|    AMD P-State    |         48.38          |        47.38           |        48.77           |
|                   |                        |                        |                        |
+-------------------+------------------------+------------------------+------------------------+

Note: The previous data was based on TBench2, as align with Suse, we use
TBench4 to re-test it. The PPW is very closed to ACPI CPUFreq.

2) Gitsource CPU benchmark:

+----------------------------------------------------------------------------------------------+
|                                                                                              |
|                               Gitsource (Performance Per Watt)                               |
|                                                                             Higher is better |
+-------------------+------------------------+------------------------+------------------------+
|                   |  Performance Per Watt  |  Performance Per Watt  |  Performance Per Watt  |
|   Kernel Module   |       (Schedutil)      |       (Ondemand)       |       (Performance)    |
|                   |    Unit: 1/(s*watt)    |    Unit: 1/(s*watt)    |    Unit: 1/(s*watt)    |
+-------------------+------------------------+------------------------+------------------------+
|                   |                        |                        |                        |
|    ACPI CPUFreq   |     0.000174579        |     0.000222647        |     0.000174455        |
|                   |                        |                        |                        |
+-------------------+------------------------+------------------------+------------------------+
|                   |                        |                        |                        |
|    AMD P-State    |     0.000217094        |     0.000291109        |     0.000175385        |
|                   |                        |                        |                        |
+-------------------+------------------------+------------------------+------------------------+

3) Speedometer CPU benchmark:

+----------------------------------------------------------------------------------------------+
|                                                                                              |
|                               Speedometer 2.0 (Performance Per Watt)                         |
|                                                                             Higher is better |
+-------------------+------------------------+------------------------+------------------------+
|                   |  Performance Per Watt  |  Performance Per Watt  |  Performance Per Watt  |
|   Kernel Module   |       (Schedutil)      |       (Ondemand)       |       (Performance)    |
|                   |    Unit: goal/watt     |    Unit: goal/watt     |    Unit: goal/watt     |
+-------------------+------------------------+------------------------+------------------------+
|                   |                        |                        |                        |
|    ACPI CPUFreq   |     17.95373047        |     19.67731256        |     17.97789671        |
|                   |                        |                        |                        |
+-------------------+------------------------+------------------------+------------------------+
|                   |                        |                        |                        |
|    AMD P-State    |     17.90493980        |     21.45128302        |     17.39773457        |
|                   |                        |                        |                        |
+-------------------+------------------------+------------------------+------------------------+

Steam Game Demo on Ryzen 5900X (12 core 24 threads):

The picture to compare AMD P-State and ACPI CPUFreq:
https://drive.google.com/file/d/1PvSduykJn9U5MMOhzFWycnbmGmznalM3/view?usp=sharing

Two videos:
https://drive.google.com/file/d/1nQQEteL-v_zQxnOJpyW8JqvRW2FFDN2Z/view?usp=sharing
https://drive.google.com/file/d/1heuPgFG71SQHvGb6wfedrQciBfE2rhnu/view?usp=sharing

Actually, the AMD P-State driver doesn't change the physical maximum
frequency capacity in the processor. But it's able to provide the finer
grain performance control range instead of legacy 3 P-States. It has a
better performance and power efficiency than before. We will continue
optimize AMD P-State function on kernel governors to support different types
of processors such as mobile latop, performance desktop, and etc.

See patch series in below git repo:
V1: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v1
V2: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v2
V3: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v3
V4: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v4
V5: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v5
V6: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v6

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
- - Move AMD P-State sysfs definitions and functions into AMD helper file.
- - Move the boost init function into AMD helper file and explain the
  details in the commit log.
- - Remove the amd_pstate_get_data in the lib/cpufreq.c to keep the lib as
  common operations.
- - Move print_speed function into misc helper file.
- - Add amd_pstate_show_perf_and_freq() function in AMD helper for
  cpufreq-info print.

Changes from V2 -> V3:
- cpufreq:
- - Add a patch from Steven to add systemio register in cppc lib. (Thanks
  to verify the driver in his platform)
- - Update online cpu mask to present cpu.
- - Enhance cppc_set_enable to cover all valid use cases.
- - Add more description in the Kconfig definition.
- - Clean up some redundance functions and data members.
- - Revise AMD P-State trace event prints.
- - Move the AMD P-State traces into power trace system and set the driver
  as build-in instead of module.
- - Clean up the duplicated sysfs with core cpufreq driver.
- - Revise the AMD P-State RST documentation.
- cpupower:
- - Revise the cpupower_amd_pstate_enabled() function to use
  cpufreq_get_driver helper instead of read sysfs.
- - Clean up the AMD P-State max/min frequency APIs, because they are
  actually the same with cpufreq info sysfs.

Changes from V3 -> V4:
- cpufreq:
- - Rebase the whole series to Rafael's pm branch (5.15)
- - Fix the typo in the commit message and comment.
- - Clean up function implementation.
- - Clean up freq&perf sysfs APIs.
- - Fall back to move AMD P-State traces out of power trace system, because
  it's flexible to debug and fine tune processors with the shared memory
  solution.
- - Add a kernel param to disable shared memory on AMD P-State, it can be
  enabled manually.
- cpupower:
- - Introduce ACPI CPPC library support.
- - Clean up the duplicated AMD specific perf/frequency.

We received two issues that reported on the processors with shared memory
solution from the community. 

First one:
https://lore.kernel.org/linux-pm/a0e932477e9b826c0781dda1d0d2953e57f904cc.camel@suse.cz/ 

Thanks Giovanni's support and suggestions, we corrected the calculation
method and duplicated the performance issue in a 64 cores / 128 threads
threadripper which is similiar with EPYC 7713. Check with firmware guy, the
sample rate is about 1 ms that the hardware responds the frequency change.
We are working to simulate the ACPI pstates with cppc api and checking
where is the gap with ACPI CPUFreq. Will share you the status later.

Second one:
https://lore.kernel.org/linux-pm/f9323c6fddd4a55d8ca4191a9539ebd056221045.camel@gmail.com/

Thanks Matt to help us reproduce this issue in our side with Ryzen 5900X.
Below is the video to compare with AMD P-State and ACPI CPUFreq on "Control"
steam games. The FPS can be increased as well. It is probably something
wrong in the SBIOS.
https://lore.kernel.org/linux-pm/DM4PR12MB5136084E5DC1809FBB578075F1959@DM4PR12MB5136.namprd12.prod.outlook.com/

Due to some issues on shared memory solution, so we fallback to build as a
module and add a parameter "shared_mem" to disable AMD P-State on processors
with shared memory solution for the moment till we complete tunning on this
function.

Changes from V4 -> V5:
- cpufreq:
- - Fix subject typo.
- - Fix Clang-13 build warning.
- - Update RST documentation for the latest update.
- cpupower:
- - Fix the table check condition at cpufreq_get_sysfs_value_from_table.

Changes from V5 -> V6:
- cpufreq:
- - Fix online cpu to present cpu.
- - Fix comment code style and use macro instead of raw value.
- - Move static call implementation into the patch of shared memory
  support.
- - Move freq_qos requests into patch of boost support.
- - Add brief driver and core data structure descriptions at the start.
- - Add maintainer entry.

Only send the cpufreq driver patches because there is no update on cpupower
tool in V6.

Thanks,
Ray


Huang Rui (11):
  x86/cpufeatures: add AMD Collaborative Processor Performance Control
    feature flag
  x86/msr: add AMD CPPC MSR definitions
  cpufreq: amd-pstate: introduce a new AMD P-State driver to support
    future processors
  cpufreq: amd-pstate: add fast switch function for AMD P-State
  cpufreq: amd-pstate: introduce the support for the processors with
    shared memory solution
  cpufreq: amd-pstate: add trace for AMD P-State module
  cpufreq: amd-pstate: add boost mode support for AMD P-State
  cpufreq: amd-pstate: add AMD P-State frequencies attributes
  cpufreq: amd-pstate: add AMD P-State performance attributes
  Documentation: AMD P-State: add AMD P-State driver introduction
  MAINTAINERS: add AMD P-State driver maintainer entry

Jinzhou Su (1):
  ACPI: CPPC: add cppc enable register function

Mario Limonciello (1):
  ACPI: CPPC: Check present CPUs for determining _CPC is valid

Steven Noonan (1):
  ACPI: CPPC: implement support for SystemIO registers

 Documentation/admin-guide/acpi/cppc_sysfs.rst |   2 +
 Documentation/admin-guide/pm/amd-pstate.rst   | 383 +++++++++++
 .../admin-guide/pm/working-state.rst          |   1 +
 MAINTAINERS                                   |   7 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |  17 +
 drivers/acpi/cppc_acpi.c                      |  99 ++-
 drivers/cpufreq/Kconfig.x86                   |  17 +
 drivers/cpufreq/Makefile                      |   5 +
 drivers/cpufreq/amd-pstate-trace.c            |   2 +
 drivers/cpufreq/amd-pstate-trace.h            |  77 +++
 drivers/cpufreq/amd-pstate.c                  | 643 ++++++++++++++++++
 include/acpi/cppc_acpi.h                      |   5 +
 13 files changed, 1255 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/pm/amd-pstate.rst
 create mode 100644 drivers/cpufreq/amd-pstate-trace.c
 create mode 100644 drivers/cpufreq/amd-pstate-trace.h
 create mode 100644 drivers/cpufreq/amd-pstate.c

-- 
2.25.1

