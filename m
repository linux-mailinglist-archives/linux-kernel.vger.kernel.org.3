Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B40A56C9D1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiGIOK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGIOKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:10:24 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B4013F23;
        Sat,  9 Jul 2022 07:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPnq1ahb+TfviT7vzF97El2uq5ACqnvDhnyKlrJnOpqYVZKHmMIzMqX7wgW01NK4PFwZGJ1s0qujVmAvt3tkwCAn+2+tfHKDNl9irTm0aV1jddg743T7YtxbBovgJEx49Y34bAF0nBMeffSct6pONijO87GKqwEIm1lEw2Dy/4QYv5o2TkyOhCbbdxXZCZU7kGLM7vPaSoYU29TPnE9hbTEMxuBLzx4ClibUz8Y8WgUBx/a5IbnZL070/jtW7LP42yi3hSn6tIsgHJM+l58ZKGiRYlqGMtxgtT+ICSQ/B1kw+ib859cEJvPavmWT7DTwlu0LIeqTn8fXNS4KpftzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcYhTcRIqYsFfZBKTEYI68asQtvruIN06VdsK79VyKU=;
 b=RlQYsMiQ3nMQLkfPxw4LhH3IIRfNFGUF2yC8+8+2RRS/Iau8BOpkwi31p10hk3qwWgsgrH790kVEawGJi20AbBTCxQ0ovr9RXWaWF94UA9kxfVz4rIF2inwp6eCbbpyXabMCx1wy1r49f0sTLB3FlHDEthFb3/G/BW2C1RqLyIM4BFIRVEcbndYaBSfAa6iIJ0KTx5a3ZKZ927hVfl8p3sNCwj82LJQGtIFdH8PbNxL01Rrf+D1Li7JFt8SxibKcGW6WvWp1C+hXvrOH1VOEuSNQKNGMUPwMikd7PZyjESWheKaBRy3jxSaC4Grs0RV1oU2+ssgq+SXFqDT/P/kPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcYhTcRIqYsFfZBKTEYI68asQtvruIN06VdsK79VyKU=;
 b=a6XeKBNIADTHjBtJLUnHY7E1avbiyx5zV119T22hM7h8DSjNR992ul7iwIQ7KYsV/M2ehjmT1JqWoc3ISF/4M5Re+OP17ocgToDhJHcK2An3GvjiLvIVW6U/rms8jpr4kRv8cX61hCoE9Z1vqIQ80OI9XwPQPn+tnY44kL8PkdY=
Received: from BN8PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:d4::28)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sat, 9 Jul
 2022 14:10:20 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::61) by BN8PR04CA0054.outlook.office365.com
 (2603:10b6:408:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Sat, 9 Jul 2022 14:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:10:19 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:10:15 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 00/14] AMD Pstate Enhancement And Issue Fixs
Date:   Sat, 9 Jul 2022 10:08:35 -0400
Message-ID: <20220709140835.830084-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72952b6b-225e-44d1-b02b-08da61b4c1c6
X-MS-TrafficTypeDiagnostic: MW5PR12MB5681:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qcg6kmW4rj8Q8B8hmy6P1CUk6TJYI5ju8on6YkA3wSq9hEd6W0ZGk44XBPlJ+FGq4vkVTKr5JKrWv+B7QMI1i3jdiOlvOnIEZnRV45cabEBdcSfU4mNk74KVdcT9q82GmVLRfm4gIvuzwwiA1i35rQUlYWNqBHSqnuTGZVh395CxvjikBs0decV//Yi58lXd8fwOdl0lOEgO/y3a6vDgofanRSenHF51um6iXeXbUZinl5L5cr8mskm82Jd5zHuATVblTZlflNNpfw6lI7Cq3Vv7uYEiBTqy8OYmUqblFVSsdghkVEIU4XrIiYEM1L92KofsW5p9LOYHqHtE/Iswy7w8N9QckRhmi14TvDNhpR1ux+1kMdKpO2zX29rAjmqn8fkMxD8cYhlgRXdkCMYjhv5cTjzMyTM0k36b9UAIs45e2btlu6zjlH3PcHlCd43uxa7/CY4jQN92h7O4aHI3madl+97ZVLTD1mUbNseQjDKPqFdZAv27OTUnz8klLBdp49CzmV4+T1s7+WZ09jFmA3guMIvY9afUfRT03kYc/4hBIemXahoo4H/VnVSfP0fIxYtshxa3HZrDuHOpM31+ansqgwWqO4rBgo7+kaIvNnwb1ONv2s7br3OrB9449n7QvswIC4FBBNzwjSOw17+LQTrIYDrlilyvoOc99OEuYsH00AZbeseaSMzYrf8lUsWP9W8u6k6yhl9uY67r70vmdDdTpWwnfRpwli5+4UD9gXTANIkh5luFstGcu5BMEybfIsgsc+HgXftijNLN2tav3Ag4q49nddbtaIYmoSPGjjnhKxsaWOCQGwMmcU5uykLC6gI+9ECMAda/WfMux2nplG0NIHhf5DfT2uwVcoPJPmDdsa4Mh6elhHFG1UcwHG3nznNO9NKAcO4a4pGaQhLM7ElgC2C/YPqgKFo5DAq86Pc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(40470700004)(36840700001)(81166007)(86362001)(82740400003)(356005)(36860700001)(34020700004)(4326008)(8676002)(82310400005)(40460700003)(70206006)(70586007)(2906002)(5660300002)(2616005)(1076003)(26005)(8936002)(40480700001)(16526019)(186003)(426003)(336012)(47076005)(83380400001)(7696005)(54906003)(6636002)(110136005)(316002)(478600001)(41300700001)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:10:19.8596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72952b6b-225e-44d1-b02b-08da61b4c1c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchsets adds support for precision boost hardware control
for AMD processors.

Meanwhile the patchset fixs lowest perf query and desired perf scope issues.
Update transition delay and latency default value to meet SMU firmware requirement.
and do some code cleanups,
It also exports cpufreq cpu release and acquire for coming amd-pstate epp mode driver

The patch series are tested on the AMD mobile and EYPC server systems

v1->v2:
- add two new patches to remove the acpi_disabled check
- fix some typos in the commit info
- move the clamp_t() into amd_pstate_update() function
- rebased to 5.19-rc5

[1]:https://patchwork.kernel.org/project/linux-pm/list/?series=657510

Perry Yuan (14):
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
  cpufreq: cpufreq: export cpufreq cpu release and acquire
  cpufreq: amd-pstate: add ACPI disabled check in acpi_cpc_valid()
  cpufreq: amd_pstate: update transition delay time to 1ms
  arch_topology: remove the acpi_disabled check
  cpufreq: CPPC: remove the acpi_disabled check

 arch/x86/include/asm/msr-index.h |  3 ++
 drivers/acpi/cppc_acpi.c         |  3 ++
 drivers/base/arch_topology.c     |  2 +-
 drivers/cpufreq/amd-pstate.c     | 57 +++++++++++++++++++-------------
 drivers/cpufreq/cppc_cpufreq.c   |  2 +-
 drivers/cpufreq/cpufreq.c        |  2 ++
 6 files changed, 44 insertions(+), 25 deletions(-)

-- 
2.25.1

