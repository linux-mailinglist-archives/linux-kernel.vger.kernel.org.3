Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCF44B81CB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiBPHhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:37:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiBPHhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:37:32 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D27A1728A8;
        Tue, 15 Feb 2022 23:37:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2Gauxt8ej0Pk0fk24o84BmjhML985j0dhUWDYW2rsKy/V48WHcBCt55Fw9vRUz9VaN/oUYsBxnozDGwxbj7RVjSCM3Gif7RqieUIugXIBwidSL0W5Q7W4WkHSl2Z5B04TiavhAfLBqIqppcgp2ZdWXdiVzA9pyOKHn+56EyiskkoPbUhSr24Uun5F4aLzYI9yLFH29GaIX19nF68HhaDBuBamuj0FTAIVlnvmELehaLUVuTmuinGTW/ivNZa8oxygl4udDHRLXJm6WDrY0XkYG/FxhBF1Bg2a5JLtar62DtnO3uyiQqdGHC4VaZxuBKBvZpH4fExkNQJRv2Oe5liA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djRypXxTLk6ZjhGKCuPiHPY0DgZR1990aUJn35Xwvbk=;
 b=B1vyLW5oNYzFsvcBFZBsZN+wmH8e+7u3eF7dkowwG4LFSr8gExz9mxrLkOfV8uTKOPFIi1gtPaP37Oq8WnohEpat/o/CGfy77ExyppGMhK5pSan9YrmEpJAz+SUUUIG0lXtPhyQW7a7G6EzyqO7K5lyUgpA4gAQRh+BrZPkDtf8fyzOPGHvNkdQcYQtWyyGTLHAWTWTho+l+prBoNzy4lwj60dyClrUlSz8YnUPy4PWJPezZcHFGe8MtCLZY5L47x2oEK1D+ogia89mLB/MXj4/WPS3Gj7kl4YB/i6ax2R+3uBGwGdE2VAfThCVzYHe52iAQmrsTS5IRP59VcKf/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djRypXxTLk6ZjhGKCuPiHPY0DgZR1990aUJn35Xwvbk=;
 b=ocv6G4VnYgeC9kSiDuSSd9noSmAKnfnVGCbZ1Wn+JJlRKXCYkjAjeWXVvpSYdC8oqYm9RkUjsbNj8MDNvZUFLnvCKiYoh2zf7lo+MMB5pClxF8ABOKSD6m4nclSmRenAlw8LpeTf7UH2dCygO25s2FVQghT7kHQl5sNZhNDZcr4=
Received: from BN8PR12CA0030.namprd12.prod.outlook.com (2603:10b6:408:60::43)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 07:36:30 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::22) by BN8PR12CA0030.outlook.office365.com
 (2603:10b6:408:60::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 07:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:36:30 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:36:25 -0600
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
Subject: [PATCH RESEND v6 0/9] cpupower: Add AMD P-State Support
Date:   Wed, 16 Feb 2022 15:35:49 +0800
Message-ID: <20220216073558.751071-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 611f41ac-a3a6-4df3-e354-08d9f11f0c60
X-MS-TrafficTypeDiagnostic: MN0PR12MB5930:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5930E2981E3A217557A82635EC359@MN0PR12MB5930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHdbOaK96CuP/dpGJqmVTNMJnukmEzg6AvwJEy9KP+FJgmveXN6z+iiTLNtqxg3ByNFGPElRzOeGS0nYeCf1nV6cDd42rtC7ULC5QPZmyMko66au2C5nEbBglaDLOR64tKyHH31oRQQgx6akH8gySEq1EYMVJkqf5Kc3N8Zq9cGEimplyOwgXENs8OvlPV+aH85/DVNsFR8khbUW0+8CShzut0dT9oIVHQNq6kvkcCX8NCKH53lDjM1bmHyPTeBa0CFhaSkhB9lvCA7i6mdLgGoJ/HYKHDTt/sk6V+Q/A9BHR0BT5PZf28KBt3jCz5d+evwUVhQgCgSVHudz3tvkXlgR8cDdKbw6d9QHND2rzmbAYRcF8FL/4QuzNhos14tMLoatWEXiWhOGiN/PAzesu1nyUAOKv0WxjkThpiIeaKWvsNtcPDjB2cyGl4ifsCoT2oSxGoDOZC5WHq1QGis7Jy7D1UcP8C7ktpfsfWjBNdx0B5bDRY/wyDu3XedYEenIni3OqSOo+Nn1lEtHgMkNHbQr5IXlZLk/PTAxp6Khs3ZoIN9aL23BU+GG8QERteVmhPIRRPOwuw5zDTmjPO8JGGHwCTBmnU9z5PZtXAlTE88oT8ARZ4ZWFs7V80tVpXsswjGDCEyaBEKA/TcWBgB7mZeE4hFQ4g8NYk879j68e0E39qdTdpwHeW1s7QJRKablDP/1GdU54kYYQbVzZssOGMqmCUNOkKsP98xDqefC+pIn4cUr2nkAVbo5Dic8cyXfG5verMWLw7B9vaeYLoqe3eugSBBizrADMyD64fuhl0TPTopv8ImLk65W+au58Z6pkJP1oLYUnjDrYtnOBPMTuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(4326008)(5660300002)(8676002)(7696005)(7416002)(8936002)(186003)(36756003)(426003)(1076003)(36860700001)(16526019)(26005)(356005)(86362001)(2616005)(81166007)(6666004)(110136005)(83380400001)(316002)(47076005)(966005)(2906002)(82310400004)(40460700003)(70206006)(70586007)(508600001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:36:30.2811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 611f41ac-a3a6-4df3-e354-08d9f11f0c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
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

Thanks,
Ray

Huang Rui (9):
  cpupower: Add AMD P-State capability flag
  cpupower: Add the function to check AMD P-State enabled
  cpupower: Initial AMD P-State capability
  cpupower: Add the function to get the sysfs value from specific table
  cpupower: Introduce ACPI CPPC library
  cpupower: Add AMD P-State sysfs definition and access helper
  cpupower: Enable boost state support for AMD P-State module
  cpupower: Move print_speed function into misc helper
  cpupower: Print AMD P-State information on cpupower

 tools/power/cpupower/Makefile                |  6 +-
 tools/power/cpupower/lib/acpi_cppc.c         | 59 +++++++++++++++
 tools/power/cpupower/lib/acpi_cppc.h         | 21 ++++++
 tools/power/cpupower/lib/cpufreq.c           | 21 ++++--
 tools/power/cpupower/lib/cpufreq.h           | 12 +++
 tools/power/cpupower/utils/cpufreq-info.c    | 68 +++++------------
 tools/power/cpupower/utils/helpers/amd.c     | 77 ++++++++++++++++++++
 tools/power/cpupower/utils/helpers/cpuid.c   | 13 ++++
 tools/power/cpupower/utils/helpers/helpers.h | 22 ++++++
 tools/power/cpupower/utils/helpers/misc.c    | 62 ++++++++++++++++
 10 files changed, 301 insertions(+), 60 deletions(-)
 create mode 100644 tools/power/cpupower/lib/acpi_cppc.c
 create mode 100644 tools/power/cpupower/lib/acpi_cppc.h

-- 
2.25.1

