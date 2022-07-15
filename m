Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14FA575EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiGOKD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiGOKD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:03:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8721263F;
        Fri, 15 Jul 2022 03:03:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUacmSs34JJrgxHw3T6kRWqwjzQwm4P5ASxXfKD2S2pPtRe3PlikpNqg29QFzq//1x6k/TJeKk6a96Wc+MEbxVygW8jp4Ez4hDP9SRdf5dvS91pySS6RVydkXs7es0+BMUaVZ/aeBvumbzTK3lPIice2wYscXzVUGgmRP+cz6QMdzdv6fU7ETAWmElrxjjCL8GFWAOFmZOMvD8IIoZglHvzy6D3c2OuR/U3jpGqawJAm0py2reG5H16AMcmEQ48GoWJ3Wi0zpk/kECoCuE9rGgGCokVOwCq6LGmfI6JjL7c3QjYVpMW83B0ZsodqBGY6TQqN9TNpXyh+/AFyXBAkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5yqMLCbxkwRD43dwPlrc9b9J7vrLk7g0Zo4I/xkx9c=;
 b=byqtVILnaupRkpLh7zGzpUYqmpRI1o0GBp8rrzRZuf4ZDpuXn0Z383w7+nRmUPl030x0MjDBBqKchBVWoCdSRLyPt3W+I9Lp4YT1i1sD0ANKTHUx8AwAqdDsem6n6bGMdVN0MbrOaDmNMJdhu56mnzUmv+WDTEs2ivvUqpWugNEEEGEMlpnIfVuRje4q5RuiBMGX6crqjblDJuTH8gPNiRQixijI5Js+LT5Ci7xXEmw5mo6Zj5GYOCv5qHK+erDxZ9y/X9zWYYVHFGtS5W9C8kzBTeGMLT4E1CfE82n5cQMVDkrXyhOHRQHFRDLnk6dAeXPz+4qT2avDqE1cRHs+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5yqMLCbxkwRD43dwPlrc9b9J7vrLk7g0Zo4I/xkx9c=;
 b=COA17au4svT0tBJTDVXO6bDk2XooF0RQxSggvnbqUf4p+2bLF4hqChjDjNvV6Z3BV8OZtAB0nxgPa5/mMQzfo1sqvfnEMPgnnQZ77tgt2BphU7A/1lB5wbwR9x0KULDgLaxd5OqJvoesgYCtJhsGwcPhG50vXg0YTEKa/fd3bHA=
Received: from DS7PR03CA0080.namprd03.prod.outlook.com (2603:10b6:5:3bb::25)
 by BY5PR12MB4018.namprd12.prod.outlook.com (2603:10b6:a03:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 10:03:54 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::1c) by DS7PR03CA0080.outlook.office365.com
 (2603:10b6:5:3bb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Fri, 15 Jul 2022 10:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:03:53 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:03:49 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 00/13] AMD Pstate Enhancement And Issue Fixs
Date:   Fri, 15 Jul 2022 06:03:25 -0400
Message-ID: <cover.1657876961.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b449f3db-cd79-478d-69dc-08da664952fc
X-MS-TrafficTypeDiagnostic: BY5PR12MB4018:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zp+mUq2QqXZCVQ8vPkBc137Q3XM4p3reln/bFoUjdN6uUcqS8hcCJHXF/ASfFlKo1GoulCnzJmXsSsOl7b5xOCuJjFKQIx4AVPB6WZ4FWbCNU64h2shXqFT7KeQ1WKClGLoB6bA0fDwecWacHCXWhIwR1rkFjK+AE5DxPhCvPfFvrqDxICMdEwEBcQq4YPeojLv5KpVLMjvDWXTVtCWnbdFeUT36uNseyvEOtFwIYg25amYzp1qS0gaYUHmOucJTTcqeAyxm+/OzVXWMRhqDVwLn2F6EH6LyjPV6r18TB0+zyAPIKuEi43OZ76LvpKZiTHgTZf3dV+QHXsRQqSism+xPoacyXNmMA/11MsWS4ptU1XTOnGY7VHmaLai/+TiaDTyVcK5OOqrrwaMshfcq/LWVT0A7gW7heZOV3gGP7msna8TI/667rVZYPcdNvdYga7J8zvTQIU0Qo/CSSL7cd7MxocIppZN28xITwB0GskMpsvTbzPNA2L4+ffWGlpzBuRIWKUQdPqZcYhO8dI/B0vxpzFy7sA2bsbt4OclyH9lXp+t4zf030hhK/hirLNJAmg2s/tj2wkP0IpRsA6ayw5xlVuYrwVJHyUIc79QjP8belEBV+ZdIpB7fCVKSjYlPTWtcFp90Wc3nEXUfCYV25oXpDtRhtxJFsSpxhJpXKY7QGhz3sVqI9jkWr7Ix/CBJJxjMvWjdLjJW/y+awmAMt48fhm5wG7uAYTYjhTEbs/LPZiq8evP9IQPFG9bNSEFuzceE2AFkC4mJq2tNO9lJRCXwZcUzFoQvAu0ZcB+Lu1p3TlqIbXTfBDxBYmYb4ui4irYFvLJxkwC/lfJeKWi8vVSbeJm+MYejpfGdMIeWWfwPN1vZdA7XoxbH0k8I64hujt1SP/w6BzHuaIgiUqXuq4cwpj8Zikyadv21sIY9PUs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(40470700004)(16526019)(86362001)(186003)(7696005)(356005)(70586007)(6666004)(2906002)(336012)(8676002)(478600001)(4326008)(2616005)(426003)(70206006)(26005)(54906003)(110136005)(41300700001)(966005)(47076005)(316002)(82310400005)(40460700003)(81166007)(36860700001)(36756003)(40480700001)(5660300002)(83380400001)(8936002)(82740400003)(6636002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:03:53.6328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b449f3db-cd79-478d-69dc-08da664952fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchsets adds support for precision boost hardware control
for AMD processors.

Meanwhile the patchset fixs lowest perf query and desired perf scope issues.
Update transition delay and latency default value to meet SMU firmware requirement.
and do some code cleanups,
It also exports cpufreq cpu release and acquire for coming amd-pstate epp mode driver

The patch series are tested on the AMD mobile and EYPC server systems

v3->v4:
- check cached bit for core performance boost from hardware configuration
  register
- pick up the Acked-by flags from Viresh and Sudeep

v2->v3:
- drop cpufreq cpu release and acquire export patch
- remove the clamp_t in the amd_pstate_adjust_perf()

v1->v2:
- add two new patches to remove the acpi_disabled check
- fix some typos in the commit info
- move the clamp_t() into amd_pstate_update() function
- rebased to 5.19-rc5

[v3] https://lore.kernel.org/all/20220713052944.xpk4fi7nuj6rmekd@vireshk-i7/t/
[v2]:https://lore.kernel.org/lkml/20220709140835.830084-1-Perry.Yuan@amd.com/
[v1]:https://patchwork.kernel.org/project/linux-pm/list/?series=657510

Perry Yuan (13):
  x86/msr: Add the MSR definition for AMD CPPC hardware control.
  cpufreq: amd-pstate: enable AMD Precision Boost mode switch
  cpufreq: amd-pstate: cleanup the unused and duplicated headers
    declaration
  cpufreq: amd-pstate: prefetch cppc_req_cached value in
    amd_pstate_cpu_init()
  cpufreq: amd-pstate: simplify cpudata pointer assignment
  cpufreq: amd_pstate: fix wrong lowest perf fetch
  cpufreq: amd_pstate: map desired perf into pstate scope for powersave
    governor
  cpufreq: amd-pstate: fix white-space
  cpufreq: amd-pstate: update pstate frequency transition delay time
  cpufreq: amd-pstate: add ACPI disabled check in acpi_cpc_valid()
  cpufreq: amd_pstate: update transition delay time to 1ms
  arch_topology: remove the acpi_disabled check
  cpufreq: CPPC: remove the acpi_disabled check

 arch/x86/include/asm/msr-index.h |  3 ++
 drivers/acpi/cppc_acpi.c         |  3 ++
 drivers/base/arch_topology.c     |  2 +-
 drivers/cpufreq/amd-pstate.c     | 62 +++++++++++++++++++-------------
 drivers/cpufreq/cppc_cpufreq.c   |  2 +-
 5 files changed, 45 insertions(+), 27 deletions(-)

-- 
2.32.0

