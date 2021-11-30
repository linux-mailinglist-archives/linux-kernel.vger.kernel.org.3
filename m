Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5534634AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhK3MnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:43:11 -0500
Received: from mail-dm3nam07on2063.outbound.protection.outlook.com ([40.107.95.63]:64808
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231908AbhK3MmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:42:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X36wNUvQhurOdqHq963sVBrZfqmxV+ToH3sEYeHBS63ZrWHQlC15t6JCv95SLH0z8Diw19WABYmMezIwtv8Cmd+VFOrqqyItDP6HvNdcBkeFjTFHJnSUgFNDGwPNd/vu4+6ctZbTv4WSBBN5zr3Ea3hmY7xiSL3lb5UcQFjj90gMzLLdUoCKrYCis7j5MNdR5Rvm+5+XqJkScVskPUMFG4ki4ZZAkYmiuCWUFBVkxbAT7hHJBp5p4OKX0AFVaSfkaVMy01/KBMF3xlXILYzoLNlFvR38YD9VIUSuTXv81EFOjj5A9CocD0BRac92lvswbjnVTs8cmhkEON3yYyaExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmPedJ1GrFM7DF3gYHOGRrsHUhkxTs4yXa2/Secm8Jw=;
 b=PnabpWhZzrEgkS+G47lLRx5a4DKy7MLgY3za+joQ5W1vZG4gQ0TqB3McjzLWP954IHc2uKCOYqpI+iZlCh7e1YBvchrs95BQvb176lu1jOOIH7QYvX0UxYv09NHWKQMfoLKihxvIMXpWYnZu1AUn+p/PuJ2vWk8++5zpJ76uR0jXeAYAKAieTVQbCgyAjX2JMIFTiywdc55jWqN+QgWmKouwJcuXfiHpr68RJ2t0jeAz6TmQJ2YW0ZMM+JK1i11XyGRalH8wnL64BAOER94tSj48AFf8BXf1sE4xW1ajE99zD8GSgXbxnj/0JweiljZtr1XlRVpVf6HBjwx88GM+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmPedJ1GrFM7DF3gYHOGRrsHUhkxTs4yXa2/Secm8Jw=;
 b=gRG6fOUeKEdM6yNvXfxu5aiiCLHTVdHJzv4k5acvhazK+pyuzxmaMmYps9hwvGQBL3AwviFdbNqCIco/LDIa76E3C1YtjI24d+YF+TkiUzldla2QDiq79UfqOGC59wzL3JfgW7qCnwvBPaOxD6rOhNiiuNKttg02HhMkeuYl9Zw=
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 30 Nov
 2021 12:38:44 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::36) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend
 Transport; Tue, 30 Nov 2021 12:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:38:43 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:38:36 -0600
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
Subject: [PATCH v5 22/22] Documentation: amd-pstate: add amd-pstate driver introduction
Date:   Tue, 30 Nov 2021 20:36:41 +0800
Message-ID: <20211130123641.1449041-23-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130123641.1449041-1-ray.huang@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d99d9be-38f7-4a62-e22a-08d9b3fe58a0
X-MS-TrafficTypeDiagnostic: BY5PR12MB4177:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4177A86C6590938D15E7B747EC679@BY5PR12MB4177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?roc1r5sfucSDYGAUpqgax+Ghfcxe/0JkQ66nMMs3gQmUnkuCSbj+IEmUyiV1?=
 =?us-ascii?Q?kd611++umqAsLjmmbXh/0502DL1Uy1jq3I4s0gAAsJLLOCPjQzFMJyWHg4t8?=
 =?us-ascii?Q?3Q+1qQPR9GMHvLyhEtJY3IKM00W11Njt2Fzj2sBJKG68Nw2do2S+33gmSuHF?=
 =?us-ascii?Q?3JY9tPbiPAHuah7nfrqF4hhZZT7ZawQmtuI1bK5H/I0MEFgnHNJhJcAZPsHP?=
 =?us-ascii?Q?NHq44z0oPhoyxcvzj3mY8AXIWc7zkJxR0GmLpxCw8on+A7OYH1AsclzzPdrI?=
 =?us-ascii?Q?hGJmRuRCHJORzaJJdxQ2uR/VCYJjW7P5nCv/ILKU2W4o4EdLRnDmjzavP18i?=
 =?us-ascii?Q?zfep/aDYQIE8kqs4PuD0q9xs3hWfwKQVQaHxoFwZ0Fv6Y4UhJTGQto6pJGCI?=
 =?us-ascii?Q?Z0cNtvsTBtwt7ZhCHG1d/zlA++jjPfnqTYNsrIyhN9X/1VIgvnluF9Zeh36o?=
 =?us-ascii?Q?dpU3Vjn4hxMNo6ZNDm2yqe5xf4qGldLxmstlhNEnXXCrw3eITiN+VIUigznS?=
 =?us-ascii?Q?lRa3Hcj12v7umvhZn8WbxuMRKWBbcwJmbX0kg6/6Cnsxl6RiXO3QzOmQMxDP?=
 =?us-ascii?Q?ExaezwRyH4ApZac3KUJsLDg1ctcsYpnmUOagtRxPqWB+DfSv9eNggPw187+m?=
 =?us-ascii?Q?B/2IzKqj+lyXK4g0pG+QPO/yPT9kz4b0p1sMAgE67VqOYcgaiPU4jMzIL5Lg?=
 =?us-ascii?Q?WxOerxJw9Rhvx/USxYQMyIKJ3/9zGdcRlw8K5UXT3gl2yEr2VORTDKyv9r8v?=
 =?us-ascii?Q?6xf9WYUQIAXMyMqaJH5yq+n6Wn4qmgbW0dhKfCPfQs5m9FAuvsSAmCaLKsed?=
 =?us-ascii?Q?jw7LBf4I0OHdRMF00VW3ZHIGTNChEM7nmVHts5UIxSz67jV6C6P9/IG0S/9T?=
 =?us-ascii?Q?EU78Bh6MFVywdEjrbZ8IhFZEtEgsAWfwVUgsprLDejHy1QHA5T2Sij0tEB2y?=
 =?us-ascii?Q?mptWKcuy30iKsPyWTkO51ln7kowHnHCR/femmmAA+FU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(83380400001)(8676002)(81166007)(82310400004)(110136005)(86362001)(70586007)(26005)(7416002)(186003)(4326008)(70206006)(54906003)(2906002)(16526019)(426003)(2616005)(8936002)(7696005)(1076003)(36860700001)(6666004)(36756003)(966005)(508600001)(316002)(356005)(30864003)(47076005)(336012)(5660300002)(40460700001)(21314003)(36900700001)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:38:43.8880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d99d9be-38f7-4a62-e22a-08d9b3fe58a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the amd-pstate driver design and implementation.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 Documentation/admin-guide/acpi/cppc_sysfs.rst |   2 +
 Documentation/admin-guide/pm/amd-pstate.rst   | 383 ++++++++++++++++++
 .../admin-guide/pm/working-state.rst          |   1 +
 3 files changed, 386 insertions(+)
 create mode 100644 Documentation/admin-guide/pm/amd-pstate.rst

diff --git a/Documentation/admin-guide/acpi/cppc_sysfs.rst b/Documentation/=
admin-guide/acpi/cppc_sysfs.rst
index fccf22114e85..e53d76365aa7 100644
--- a/Documentation/admin-guide/acpi/cppc_sysfs.rst
+++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
@@ -4,6 +4,8 @@
 Collaborative Processor Performance Control (CPPC)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
=20
+.. _cppc_sysfs:
+
 CPPC
 =3D=3D=3D=3D
=20
diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/ad=
min-guide/pm/amd-pstate.rst
new file mode 100644
index 000000000000..6bafb9354ba0
--- /dev/null
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -0,0 +1,383 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+``amd-pstate`` CPU Performance Scaling Driver
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+:Copyright: |copy| 2021 Advanced Micro Devices, Inc.
+
+:Author: Huang Rui <ray.huang@amd.com>
+
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+``amd-pstate`` is the AMD CPU performance scaling driver that introduces a
+new CPU frequency control mechanism on modern AMD APU and CPU series in
+Linux kernel. The new mechanism is based on Collaborative Processor
+Performance Control (CPPC) which provides finer grain frequency management
+than legacy ACPI hardware P-States. Current AMD CPU/APU platforms are using
+the ACPI P-states driver to manage CPU frequency and clocks with switching
+only in 3 P-states. CPPC replaces the ACPI P-states controls, allows a
+flexible, low-latency interface for the Linux kernel to directly
+communicate the performance hints to hardware.
+
+``amd-pstate`` leverages the Linux kernel governors such as ``schedutil``,
+``ondemand``, etc. to manage the performance hints which are provided by
+CPPC hardware functionality that internally follows the hardware
+specification (for details refer to AMD64 Architecture Programmer's Manual
+Volume 2: System Programming [1]_). Currently ``amd-pstate`` supports basic
+frequency control function according to kernel governors on some of the
+Zen2 and Zen3 processors, and we will implement more AMD specific functions
+in future after we verify them on the hardware and SBIOS.
+
+
+AMD CPPC Overview
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Collaborative Processor Performance Control (CPPC) interface enumerates a
+continuous, abstract, and unit-less performance value in a scale that is
+not tied to a specific performance state / frequency. This is an ACPI
+standard [2]_ which software can specify application performance goals and
+hints as a relative target to the infrastructure limits. AMD processors
+provides the low latency register model (MSR) instead of AML code
+interpreter for performance adjustments. ``amd-pstate`` will initialize a
+``struct cpufreq_driver`` instance ``amd_pstate_driver`` with the callbacks
+to manage each performance update behavior. ::
+
+ Highest Perf ------>+-----------------------+                         +--=
---------------------+
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |          Max Perf  ---->|  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+ Nominal Perf ------>+-----------------------+                         +--=
---------------------+
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |      Desired Perf  ---->|  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+  Lowest non-        |                       |                         |  =
                     |
+  linear perf ------>+-----------------------+                         +--=
---------------------+
+                     |                       |                         |  =
                     |
+                     |                       |       Lowest perf  ---->|  =
                     |
+                     |                       |                         |  =
                     |
+  Lowest perf ------>+-----------------------+                         +--=
---------------------+
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+                     |                       |                         |  =
                     |
+          0   ------>+-----------------------+                         +--=
---------------------+
+
+                                     AMD P-States Performance Scale
+
+
+.. _perf_cap:
+
+AMD CPPC Performance Capability
+--------------------------------
+
+Highest Performance (RO)
+.........................
+
+It is the absolute maximum performance an individual processor may reach,
+assuming ideal conditions. This performance level may not be sustainable
+for long durations and may only be achievable if other platform components
+are in a specific state; for example, it may require other processors be in
+an idle state. This would be equivalent to the highest frequencies
+supported by the processor.
+
+Nominal (Guaranteed) Performance (RO)
+......................................
+
+It is the maximum sustained performance level of the processor, assuming
+ideal operating conditions. In absence of an external constraint (power,
+thermal, etc.) this is the performance level the processor is expected to
+be able to maintain continuously. All cores/processors are expected to be
+able to sustain their nominal performance state simultaneously.
+
+Lowest non-linear Performance (RO)
+...................................
+
+It is the lowest performance level at which nonlinear power savings are
+achieved, for example, due to the combined effects of voltage and frequency
+scaling. Above this threshold, lower performance levels should be generally
+more energy efficient than higher performance levels. This register
+effectively conveys the most efficient performance level to ``amd-pstate``.
+
+Lowest Performance (RO)
+........................
+
+It is the absolute lowest performance level of the processor. Selecting a
+performance level lower than the lowest nonlinear performance level may
+cause an efficiency penalty but should reduce the instantaneous power
+consumption of the processor.
+
+AMD CPPC Performance Control
+------------------------------
+
+``amd-pstate`` passes performance goals through these registers. The
+register drives the behavior of the desired performance target.
+
+Minimum requested performance (RW)
+...................................
+
+``amd-pstate`` specifies the minimum allowed performance level.
+
+Maximum requested performance (RW)
+...................................
+
+``amd-pstate`` specifies a limit the maximum performance that is expected
+to be supplied by the hardware.
+
+Desired performance target (RW)
+...................................
+
+``amd-pstate`` specifies a desired target in the CPPC performance scale as
+a relative number. This can be expressed as percentage of nominal
+performance (infrastructure max). Below the nominal sustained performance
+level, desired performance expresses the average performance level of the
+processor subject to hardware. Above the nominal performance level,
+processor must provide at least nominal performance requested and go higher
+if current operating conditions allow.
+
+Energy Performance Preference (EPP) (RW)
+.........................................
+
+Provides a hint to the hardware if software wants to bias toward performan=
ce
+(0x0) or energy efficiency (0xff).
+
+
+Key Governors Support
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+``amd-pstate`` can be used with all the (generic) scaling governors listed
+by the ``scaling_available_governors`` policy attribute in ``sysfs``. Then,
+it is responsible for the configuration of policy objects corresponding to
+CPUs and provides the ``CPUFreq`` core (and the scaling governors attached
+to the policy objects) with accurate information on the maximum and minimum
+operating frequencies supported by the hardware. Users can check the
+``scaling_cur_freq`` information comes from the ``CPUFreq`` core.
+
+``amd-pstate`` mainly supports ``schedutil`` and ``ondemand`` for dynamic
+frequency control. It is to fine tune the processor configuration on
+``amd-pstate`` to the ``schedutil`` with CPU CFS scheduler. ``amd-pstate``
+registers adjust_perf callback to implement the CPPC similar performance
+update behavior. It is initialized by ``sugov_start`` and then populate the
+CPU's update_util_data pointer to assign ``sugov_update_single_perf`` as
+the utilization update callback function in CPU scheduler. CPU scheduler
+will call ``cpufreq_update_util`` and assign the target performance
+according to the ``struct sugov_cpu`` that utilization update belongs to.
+Then ``amd-pstate`` updates the desired performance according to the CPU
+scheduler assigned.
+
+
+Processor Support
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The ``amd-pstate`` initialization will fail if the _CPC in ACPI SBIOS is
+not existed at the detected processor, and it uses ``acpi_cpc_valid`` to
+check the _CPC existence. All Zen based processors support legacy ACPI
+hardware P-States function, so while the ``amd-pstate`` fails to be
+initialized, the kernel will fall back to initialize ``acpi-cpufreq``
+driver.
+
+There are two types of hardware implementations for ``amd-pstate``: one is
+`Full MSR Support <perf_cap_>`_ and another is `Shared Memory Support
+<perf_cap_>`_. It can use :c:macro:`X86_FEATURE_CPPC` feature flag (for
+details refer to Processor Programming Reference (PPR) for AMD Family
+19h Model 51h, Revision A1 Processors [3]_) to indicate the different
+types. ``amd-pstate`` is to register different ``static_call`` instances
+for different hardware implementations.
+
+Currently, some of Zen2 and Zen3 processors support ``amd-pstate``. In the
+future, it will be supported on more and more AMD processors.
+
+Full MSR Support
+-----------------
+
+Some new Zen3 processors such as Cezanne provide the MSR registers directly
+while the :c:macro:`X86_FEATURE_CPPC` CPU feature flag is set.
+``amd-pstate`` can handle the MSR register to implement the fast switch
+function in ``CPUFreq`` that can shrink latency of frequency control on the
+interrupt context. The functions with ``pstate_xxx`` prefix represent the
+operations of MSR registers.
+
+Shared Memory Support
+----------------------
+
+If :c:macro:`X86_FEATURE_CPPC` CPU feature flag is not set, that means the
+processor supports shared memory solution. In this case, ``amd-pstate``
+uses the ``cppc_acpi`` helper methods to implement the callback functions
+that defined on ``static_call``. The functions with ``cppc_xxx`` prefix
+represent the operations of acpi cppc helpers for shared memory solution.
+
+
+AMD P-States and ACPI hardware P-States always can be supported in one
+processor. But AMD P-States has the higher priority and if it is enabled
+with :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond
+to the request from AMD P-States.
+
+
+User Space Interface in ``sysfs``
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+``amd-pstate`` exposes several global attributes (files) in ``sysfs`` to
+control its functionality at the system level. They located in the
+``/sys/devices/system/cpu/cpufreq/policyX/`` directory and affect all CPUs=
. ::
+
+ root@hr-test1:/home/ray# ls /sys/devices/system/cpu/cpufreq/policy0/*amd*
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
+
+
+``amd_pstate_highest_perf / amd_pstate_max_freq``
+
+Maximum CPPC performance and CPU frequency that the driver is allowed to
+set in percent of the maximum supported CPPC performance level (the highest
+performance supported in `AMD CPPC Performance Capability <perf_cap_>`_).
+In some of ASICs, the highest CPPC performance is not the one in the _CPC
+table, so we need to expose it to sysfs. If boost is not active but
+supported, this maximum frequency will be larger than the one in
+``cpuinfo``.
+This attribute is read-only.
+
+``amd_pstate_lowest_nonlinear_freq``
+
+The lowest non-linear CPPC CPU frequency that the driver is allowed to set
+in percent of the maximum supported CPPC performance level (Please see the
+lowest non-linear performance in `AMD CPPC Performance Capability
+<perf_cap_>`_).
+This attribute is read-only.
+
+For other performance and frequency values, we can read them back from
+``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
+
+
+``amd-pstate`` vs ``acpi-cpufreq``
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+On majority of AMD platforms supported by ``acpi-cpufreq``, the ACPI tables
+provided by the platform firmware used for CPU performance scaling, but
+only provides 3 P-states on AMD processors.
+However, on modern AMD APU and CPU series, it provides the collaborative
+processor performance control according to ACPI protocol and customize this
+for AMD platforms. That is fine-grain and continuous frequency range
+instead of the legacy hardware P-states. ``amd-pstate`` is the kernel
+module which supports the new AMD P-States mechanism on most of future AMD
+platforms. The AMD P-States mechanism will be the more performance and ene=
rgy
+efficiency frequency management method on AMD processors.
+
+Kernel Module Options for ``amd-pstate``
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+``shared_mem``
+Use a module param (shared_mem) to enable related processors manually with
+**amd_pstate.shared_mem=3D1**.
+Due to the performance issue on the processors with `Shared Memory Support
+<perf_cap_>`_, so we disable it for the moment and will enable this by def=
ault
+once we address performance issue on this solution.
+
+The way to check whether current processor is `Full MSR Support <perf_cap_=
>`_
+or `Shared Memory Support <perf_cap_>`_ : ::
+
+  ray@hr-test1:~$ lscpu | grep cppc
+  Flags:                           fpu vme de pse tsc msr pae mce cx8 apic=
 sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mm=
xext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpui=
d extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 s=
se4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm =
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt =
tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp=
_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2=
 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsa=
vec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero=
 irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc=
_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_=
vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflo=
w_recov succor smca fsrm
+
+If CPU Flags have cppc, then this processor supports `Full MSR Support
+<perf_cap_>`_. Otherwise it supports `Shared Memory Support <perf_cap_>`_.
+
+
+``cpupower`` tool support for ``amd-pstate``
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+``amd-pstate`` is supported on ``cpupower`` tool that can be used to dump =
the frequency
+information. And it is in progress to support more and more operations for=
 new
+``amd-pstate`` module with this tool. ::
+
+ root@hr-test1:/home/ray# cpupower frequency-info
+ analyzing CPU 0:
+   driver: amd-pstate
+   CPUs which run at the same hardware frequency: 0
+   CPUs which need to have their frequency coordinated by software: 0
+   maximum transition latency: 131 us
+   hardware limits: 400 MHz - 4.68 GHz
+   available cpufreq governors: ondemand conservative powersave userspace =
performance schedutil
+   current policy: frequency should be within 400 MHz and 4.68 GHz.
+                   The governor "schedutil" may decide which speed to use
+                   within this range.
+   current CPU frequency: Unable to call hardware
+   current CPU frequency: 4.02 GHz (asserted by call to kernel)
+   boost state support:
+     Supported: yes
+     Active: yes
+     AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.68 GHz.
+     AMD PSTATE Nominal Performance: 117. Nominal Frequency: 3.30 GHz.
+     AMD PSTATE Lowest Non-linear Performance: 39. Lowest Non-linear Frequ=
ency: 1.10 GHz.
+     AMD PSTATE Lowest Performance: 15. Lowest Frequency: 400 MHz.
+
+
+Diagnostics and Tuning
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Trace Events
+--------------
+
+There are two static trace events that can be used for ``amd-pstate``
+diagnostics.  One of them is the cpu_frequency trace event generally used
+by ``CPUFreq``, and the other one is the ``amd_pstate_perf`` trace event
+specific to ``amd-pstate``.  The following sequence of shell commands can
+be used to enable them and see their output (if the kernel is generally
+configured to support event tracing). ::
+
+ root@hr-test1:/home/ray# cd /sys/kernel/tracing/
+ root@hr-test1:/sys/kernel/tracing# echo 1 > events/amd_cpu/enable
+ root@hr-test1:/sys/kernel/tracing# cat trace
+ # tracer: nop
+ #
+ # entries-in-buffer/entries-written: 47827/42233061   #P:2
+ #
+ #                                _-----=3D> irqs-off
+ #                               / _----=3D> need-resched
+ #                              | / _---=3D> hardirq/softirq
+ #                              || / _--=3D> preempt-depth
+ #                              ||| /     delay
+ #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
+ #              | |         |   ||||      |         |
+          <idle>-0       [015] dN...  4995.979886: amd_pstate_perf: amd_mi=
n_perf=3D85 amd_des_perf=3D85 amd_max_perf=3D166 cpu_id=3D15 changed=3Dfals=
e fast_switch=3Dtrue
+          <idle>-0       [007] d.h..  4995.979893: amd_pstate_perf: amd_mi=
n_perf=3D85 amd_des_perf=3D85 amd_max_perf=3D166 cpu_id=3D7 changed=3Dfalse=
 fast_switch=3Dtrue
+             cat-2161    [000] d....  4995.980841: amd_pstate_perf: amd_mi=
n_perf=3D85 amd_des_perf=3D85 amd_max_perf=3D166 cpu_id=3D0 changed=3Dfalse=
 fast_switch=3Dtrue
+            sshd-2125    [004] d.s..  4995.980968: amd_pstate_perf: amd_mi=
n_perf=3D85 amd_des_perf=3D85 amd_max_perf=3D166 cpu_id=3D4 changed=3Dfalse=
 fast_switch=3Dtrue
+          <idle>-0       [007] d.s..  4995.980968: amd_pstate_perf: amd_mi=
n_perf=3D85 amd_des_perf=3D85 amd_max_perf=3D166 cpu_id=3D7 changed=3Dfalse=
 fast_switch=3Dtrue
+          <idle>-0       [003] d.s..  4995.980971: amd_pstate_perf: amd_mi=
n_perf=3D85 amd_des_perf=3D85 amd_max_perf=3D166 cpu_id=3D3 changed=3Dfalse=
 fast_switch=3Dtrue
+          <idle>-0       [011] d.s..  4995.980996: amd_pstate_perf: amd_mi=
n_perf=3D85 amd_des_perf=3D85 amd_max_perf=3D166 cpu_id=3D11 changed=3Dfals=
e fast_switch=3Dtrue
+
+The cpu_frequency trace event will be triggered either by the ``schedutil`=
` scaling
+governor (for the policies it is attached to), or by the ``CPUFreq`` core =
(for the
+policies with other scaling governors).
+
+
+Reference
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
+       https://www.amd.com/system/files/TechDocs/24593.pdf
+
+.. [2] Advanced Configuration and Power Interface Specification,
+       https://uefi.org/sites/default/files/resources/ACPI_Spec_6_4_Jan22.=
pdf
+
+.. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 51h,=
 Revision A1 Processors
+       https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
+
diff --git a/Documentation/admin-guide/pm/working-state.rst b/Documentation=
/admin-guide/pm/working-state.rst
index f40994c422dc..5d2757e2de65 100644
--- a/Documentation/admin-guide/pm/working-state.rst
+++ b/Documentation/admin-guide/pm/working-state.rst
@@ -11,6 +11,7 @@ Working-State Power Management
    intel_idle
    cpufreq
    intel_pstate
+   amd-pstate
    cpufreq_drivers
    intel_epb
    intel-speed-select
--=20
2.25.1

