Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CD5571F64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiGLPdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiGLPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:33:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78078A4385;
        Tue, 12 Jul 2022 08:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n79bHzvvGKNeKoh9rKZJlS8QNJUrP/6Ii4KU468ZM6/A6552S9QgSHNJWG8E7Ou3ouCXIwil2mbHlXYv3OQCsi3wEwIxTOvhCpDspXE7A6MlEcnVexf2hbyZM/Hi140S6rUFQHjtI2ug4TGDHZ4TMDK0jl8IbyzulUNC2r8lPytwIcg/uoj9TM/jsQu1NXEp5cz7bvmzuxLaSfYLA81fvifpMzlmidabiVglpTLMsSKO8nuxB3VqLHfpSKybreCsk8sx402GbIEbBcJuwKGmbafUguGDhoqrl8SJ7h9MQHaMgSOSwo0k1+J7L2jHx9yjXF4bBGz/UP/Wdr5gBt0BNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18mdBzAhmg88el4qEDC2tx+a0cN3ViQmrzah/kEdqWk=;
 b=Day8eEZ4F2g3nHji1xyFul63U/aUZDlnhi2YnrXDPhdJJ0yXeO50uBoGh0BhfeR1oc++473mr2pxKih6YEYfduiNMsJd6P6Cf55omgpop7EsyCKgP4reQwmh8Tsxrh30WpcS3yBm8Sq8o1RH/Mf2kbouD44f8WtGDwBMONgSBD9qmIQd5WRwlqAQYtSld6AxuRRRXD827SaG5FCwUG3EUrdMDWGWe3chHULQA1gfc8Ema2OXwQdmW+nveQsogVsjCRR6iOeo01/tDkDJjkQNNWoirN9Q3fUtM6B0uAJmwe/Q4GlZ3GMqqPrJsWsNYNXKW6SukKru9kFdcC1UyGwFsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18mdBzAhmg88el4qEDC2tx+a0cN3ViQmrzah/kEdqWk=;
 b=wquYsylwshVWPs2t/x0GkHiNATy84Wjr5+7yQrMAoTBBRABznWTpcM4DWN1eZ6bv+TknLv/VOfjW67r/O/NniXZwNWpv6GaqL/cRU+AEUdwylr1f/9Uig0fh/Yc0fQKGNd+WRAXIqma5xoGOpgZcMJc+LXp+8KLtzU7cUQ6qwaE=
Received: from DM6PR07CA0039.namprd07.prod.outlook.com (2603:10b6:5:74::16) by
 DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Tue, 12 Jul 2022 15:33:13 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::2e) by DM6PR07CA0039.outlook.office365.com
 (2603:10b6:5:74::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Tue, 12 Jul 2022 15:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:33:13 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:33:09 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 00/13] AMD Pstate Enhancement And Issue Fixs
Date:   Tue, 12 Jul 2022 11:32:46 -0400
Message-ID: <cover.1657638462.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ea3f23e-ccee-4e44-c44d-08da641bd552
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0d/T5vhpLDV2i5NH3t4Xazo2pSFbb4cC5gPJ8QYVZzuF2Tn6hIbufcCxF53akPi5fFqFts1hc1qHdst8AT8wRMJDqUYFI5sAl4ah1rBGal7kRPYcDZB2FRZQ65UCQk8dHqA1GZ4ds1DHPhPLPIiC9XGkBGLrTF4bxgyQN95KAax64xUWGQaFg7Ai3IxuDP5qKvReWmnWizMbcTeBWMr17ClKJM7O4eTK/NlqWOqU38CGCbvzeCthXUYhKmSCx36mWij79LPQv7qphUSzADTcVsqJH1/Phwebo63fhqM28qA22lVbMaRhKWsTvk2lbTToMSHCiWE/w3i0Dz5uscQWHaRdV8zEkdiZ8CU9CdVz6aXFGQ849avLLfedFo/gAgN5wJxDOF1VRpVzFMti/aX/xRzo+cCl2Cs4XQ8kyla36Pf88qFSOf4Bg+TQRDL3pfekaqKC81oAmMuihORV0QSF9CJ08V+JwlTenqFWmlinhOjqFbGmOUBp0izUkdmAtJflUhWPUDd1zo5YExcLA+x3lE5ZH1B36TQAnuGwzVVqCR5Zq6X1v98Woja0JU9Vp7vDFYLmX8YiSrfHEk4ry2W2LcCFW418N9M4oMnbAq6IjMOpGFBpSAU7k9ChdEsVmYO0Mys5qb4R/nHeu5lXzeg3gYWzgZIbiTBuqbZrvTQRIujX6huc0u7OWsGbm4O236yxty4XjwoZsB2Ix9M/oxdt9dfYq9qhd2cqZ5N9iU0Uq7vuRztbWUf/SRsfLDEHSE8uNdxwm5gw+Bp5WzkC/sARR1JJqhOkg7Tkj1c11Eq1RSMlz1mQoZcZbFq6sZxGTYQxpc/DsVBcbudQr3zQeuletgMqExdV9zTdamy+Py27LLggjB0PqXg00sKh85EcaziZWd9oeAPWXvkmIqg920xG5auLj0r10J6WWS0SwPrMyh8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(40470700004)(46966006)(36840700001)(4326008)(110136005)(70586007)(426003)(47076005)(356005)(82740400003)(8676002)(82310400005)(81166007)(70206006)(336012)(36756003)(6636002)(316002)(54906003)(2616005)(6666004)(40460700003)(478600001)(5660300002)(8936002)(86362001)(26005)(2906002)(36860700001)(41300700001)(16526019)(186003)(83380400001)(40480700001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:33:13.1118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea3f23e-ccee-4e44-c44d-08da641bd552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

v2->v3:
- drop cpufreq cpu release and acquire export patch
- remove the clamp_t in the amd_pstate_adjust_perf()

v1->v2:
- add two new patches to remove the acpi_disabled check
- fix some typos in the commit info
- move the clamp_t() into amd_pstate_update() function
- rebased to 5.19-rc5

[1]:https://patchwork.kernel.org/project/linux-pm/list/?series=657510
[2]:https://lore.kernel.org/lkml/20220709140835.830084-1-Perry.Yuan@amd.com/

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
 drivers/cpufreq/amd-pstate.c     | 59 ++++++++++++++++++--------------
 drivers/cpufreq/cppc_cpufreq.c   |  2 +-
 5 files changed, 42 insertions(+), 27 deletions(-)

-- 
2.25.1

