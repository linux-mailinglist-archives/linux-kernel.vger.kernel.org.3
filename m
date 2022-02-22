Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E794BFCAC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiBVPfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBVPfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:35:19 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D13A160FF5;
        Tue, 22 Feb 2022 07:34:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSLy+w09mCQ+E7RzSHhMGP0oKXvrXHYar9l8mfvNtRGZOREogZPig7vx3ZshQjlcUBOmFyTGiW8WixN9PyzXn1LUhO0ayzF+gO8crvZzZuSHHJZMEwXTie4gLf3/GZsbRxeA4s4qFtQnTWWf3hGvbvBTogZTuY6ziZ9cvlX3efQBV0q4VF36Q/2Q9WGHXKYYDTh84Tc0CeSFWQq5cjWnX5THT/0jlaGRsa+pgp74bA3shOxNHhtWyHH/yOqqYIbyn5Of3EJbgh/nMaNE2bRvXeRlL693M6qPJNpoCxbS+gq7iCl/jxYWq22WbiY27xDKufnG8aroVPeuGgfM0HrqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUZdMapVYkX7Qk0sCdyZISgDR9YYxNv+trkWgOhL4z8=;
 b=I4Rp6W9rVvE4naCcbVG4dt+HeS0p4pCFw0BNnIptV16sr2S8J4BWsL2cdzEA2oxc+LHnWWYpcyYutxerFTSyJDxoMFZJzGRc3xp4lO1fY3Z1pNGaJjTFbActxqjgLAsri0cUFql5sgS10YCqzTt8mldbloI0db1p3HcT7eylVV5EWfOLBLY70tA2dRNQOnAN7yQnITXhmyUl1JH7Q8nQ0EXQfmSpLGpk/XaIo6I93Imtqx133RDAh9cq1WPUzTFERh9Aesrblp9By4/PTM64W7gzH8HQwc6VFbyyzGkw4OZoha8UkV+0mw026O1kqThQnxEEJ79FLNHAoaWJiv6K0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUZdMapVYkX7Qk0sCdyZISgDR9YYxNv+trkWgOhL4z8=;
 b=b9foJrxTfIlz8Utyt03FPerVvKNDN5HYvViBPor9NG/sTg99rY1GI22zpCo359iGDUB3gnFFnZBAkKcQrekvCPoMGpDOhzyOxPdLi0kdVVaCLQ5BWjScbNijnQxypppSVBFiX/twCF1MSigp2vT3q+Grf5NMAZr7G82M6XLF9fE=
Received: from DM5PR13CA0072.namprd13.prod.outlook.com (2603:10b6:3:117::34)
 by DM5PR1201MB2475.namprd12.prod.outlook.com (2603:10b6:3:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 15:34:50 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::9) by DM5PR13CA0072.outlook.office365.com
 (2603:10b6:3:117::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.9 via Frontend
 Transport; Tue, 22 Feb 2022 15:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:34:50 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 09:34:45 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Giovanni Gherdovich" <ggherdovich@suse.cz>,
        <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v7 00/10] cpupower: Add AMD P-State Support
Date:   Tue, 22 Feb 2022 23:34:16 +0800
Message-ID: <20220222153426.2216974-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d2cd198-e194-4009-d3d7-08d9f618dd93
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2475:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB247552BDD024618098CE7B87EC3B9@DM5PR1201MB2475.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aj2FG3ha4WJC9+1yjYEXpwhPv/LFo9OcyiVYZGUcsf4jCr5xb38jhWgTOP/h/+iUnoZWnvZGiacfuuFDm0MpnJ82gNaKDzLJQc9lNdPvgcnNhyUyyRGjD0lSjtncHhQszmgi/aFcK8Vwu0fmDP67T9IxOPGMXge1mG6g42bo08/H3g+2Eo5risgLn6CyIZ1Mvu4U9o8CuYhinC7J4g1d7AiP7V0DodeI83pfqHQSj+7M3mtx+T4nw2Q//IwWjJCj/tVQWVIBQOAp/6nHrTM71+Pf+2+ah9wD77qmV7jAMqlFQH9sMBERiT/lA37kZjyLnvHbCffkIT26sCbQECS5kWeGPwSherZ9F5zKt7jur3WIZ0Exx+0Rnzk4WK9/jBwSX1nyfRQAWuGb2psEaCRzNVwgxWqCV7ODOVT8a3YOTl9e1Es3H8t65LaIDvN72Qt2xtKS1jUZTJ+ZIdlwoWTC+dmRVMUdGyhAcGDI3Shkca5VbYBN6WLHg1XAkpmEGnBb8eofkDzGaRjIjspGmLRNdUCZqJpNugEod03V6xH6hjVqdATOk9sp2hKUZ7CRJz2wcVwdct91X2ey0jRyPF4zgcHHUiZ5r7jIU9Sx3PXJ25xTcdkPN6zpnLFQQL1sY9DI146ACfxBlksZpHWGGVATdzdD4ewI9q5PruIOoeZAJMn1rAdp1y2blKx5s6P8MSyMFQSNP939DfCGfXm4WfviwkMBNJy9AR4Iq/X3bZYZsJgdE2Qamh0jKmV62H3Pw32rhGh1BELe7VtF0siKTUdjQiTSuf641qmnOVf8S5aXh1MqZO5w2b8I5RBkoKmrhbTQ5nb6RXBWkT0o8X04+sAxKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(110136005)(54906003)(426003)(2906002)(7416002)(7696005)(40460700003)(5660300002)(6666004)(336012)(8936002)(47076005)(36860700001)(36756003)(70206006)(82310400004)(966005)(2616005)(8676002)(4326008)(70586007)(1076003)(356005)(508600001)(86362001)(186003)(16526019)(26005)(316002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:34:50.5642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2cd198-e194-4009-d3d7-08d9f618dd93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2475
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

Since AMD P-State kernel is merged into 5.17-rc1, I would like to continue
revising the AMD P-State support for the CPUPower tool. These series are
rebased on latest bleeding-edge, any comments are warm for me.

See patch series of CPUPower in below git repo:
V1: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v1
V2: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v2
V3: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v3
V4: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v4
V5: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v5
V6: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=cpupower-amd-pstate
V7: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=cpupower-amd-pstate-v7

Changes from V1 -> V2:
- Refine the commit log for cpupower patches.
- Expose a function to get the sysfs value from specific table.
- Move AMD P-State sysfs definitions and functions into AMD helper file.
- Move the boost init function into AMD helper file and explain the
details in the commit log.
- Remove the amd_pstate_get_data in the lib/cpufreq.c to keep the lib as
common operations.
- Move print_speed function into misc helper file.
- Add amd_pstate_show_perf_and_freq() function in AMD helper for
  cpufreq-info print.

Changes from V2 -> V3:
- Revise the cpupower_amd_pstate_enabled() function to use
cpufreq_get_driver helper instead of read sysfs.
- Clean up the AMD P-State max/min frequency APIs, because they are
actually the same with cpufreq info sysfs.

Changes from V3 -> V4:
- Introduce ACPI CPPC library support.
- Clean up the duplicated AMD specific perf/frequency.

Changes from V4 -> V5:
- Fix the table check condition at cpufreq_get_sysfs_value_from_table.

Changes from V5 -> V6:
- Revise the minor commit and subject descriptions.

Changes from V6 -> V7:
- Fix the checkpatch warnings and errors.
- Revise the patch 9 to move the AMD P-State information prints out of
  boost function.
- Add a new option to print the performance and frequency capabilities of
  CPPC, and add related description in manpage documentation.

> cpupower info
>
> System does not support Intel's performance bias setting
> analyzing CPU 0:

Regards to the print of "cpupower info" above, it's becasuse only
"perf-bias" option is implemented in cmd_info only for Intel processors. So
in another processors, even using the acpi-cpufreq driver, we still get the
same print. I am thinking, can we add a simple print to say this command
doesn't support AMD platform so far? Or any other idea?

Thanks,
Ray

Huang Rui (10):
  cpupower: Add AMD P-State capability flag
  cpupower: Add the function to check AMD P-State enabled
  cpupower: Initial AMD P-State capability
  cpupower: Add the function to get the sysfs value from specific table
  cpupower: Introduce ACPI CPPC library
  cpupower: Add AMD P-State sysfs definition and access helper
  cpupower: Enable boost state support for AMD P-State module
  cpupower: Move print_speed function into misc helper
  cpupower: Add function to print AMD P-State performance capabilities
  cpupower: Add "perf" option to print AMD P-State information

 tools/power/cpupower/Makefile                 |  6 +-
 tools/power/cpupower/lib/acpi_cppc.c          | 59 +++++++++++++
 tools/power/cpupower/lib/acpi_cppc.h          | 21 +++++
 tools/power/cpupower/lib/cpufreq.c            | 23 +++--
 tools/power/cpupower/lib/cpufreq.h            | 12 +++
 .../cpupower/man/cpupower-frequency-info.1    |  3 +
 tools/power/cpupower/utils/cpufreq-info.c     | 87 ++++++++-----------
 tools/power/cpupower/utils/helpers/amd.c      | 77 ++++++++++++++++
 tools/power/cpupower/utils/helpers/cpuid.c    | 13 +++
 tools/power/cpupower/utils/helpers/helpers.h  | 22 +++++
 tools/power/cpupower/utils/helpers/misc.c     | 60 +++++++++++++
 11 files changed, 321 insertions(+), 62 deletions(-)
 create mode 100644 tools/power/cpupower/lib/acpi_cppc.c
 create mode 100644 tools/power/cpupower/lib/acpi_cppc.h

-- 
2.25.1

