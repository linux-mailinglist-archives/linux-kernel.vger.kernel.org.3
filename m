Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD5C4E4D23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbiCWHRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbiCWHRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:17:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC356E8CC;
        Wed, 23 Mar 2022 00:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY183ZnwsuDSX5AoukjHeahvVmGSWijFJs39Z3kMBiDF8wjfFfi5tT9hCbLxqwdoO+nZqCRLOQr0Er40+/sMRSEwOZVRQR9fe8H8Hz9UyobC6Pn85LrHwbQTPBgjU72vt1VMprWRHc4zuiXaz8aF1bMV33I573jFNMasAsq4unYoamS4ZJiEiRkqR9BSp620WGh9ridU5ip7gdNDEZYcJ6eYkktvQjDVXSfZqEdjyrHLB7obUKjPPiBXfuwvalTXS/6ivyMkojeHATbJpU1plbD5wcmCvhkaXShgM9vvlFxsPS1iea3eE96JEWc9hujNIM0GP3mefXZhV+uNpPIzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pflCF1dJ/WrvbFgbX656iqhyo0Zjg9uiNHjlbQWQ70=;
 b=haDpclOISm+cQkYZYdkmwjW6wVwcNv/HhBk0qe2V28bc0/x2VjTZp5wrVRe7zRh9cbNLc1sVTGqNPjbn7is1HKUmiYBNzpU2Sw/ECf+FvWKEyrbufWIvq3qCyRGerDSbSieE5A4nWk/T+g560vyciGVelLjbmgEJMqY49dyHeDYFlgeavutCztJcC5iCFaAV3u6JM66wqNZrD13eTc64daxGGxBijUl8hMS1dnIhnnxV0pcExJvd8EnbuamZMVYBTJ4lnAqxGrkESJxqL74VRGP/cimRlmnem+EsnxElMhqVmyzNxczpLTKm0JGRoPpOgCz+lxqZOrf9LKcheRAD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pflCF1dJ/WrvbFgbX656iqhyo0Zjg9uiNHjlbQWQ70=;
 b=QUso4/rMGtViek5YXbZkfcxC9CslZZG1+TSV8tg/8HTK88GaeY9JfAmw+OWdJL9pxNrJrhgqCmhjOqD+ygL7So7naNAVLDZaSc56AbCK/cRJPzBk2/esZJp7n8P0pSYf2vTvFeDfieyH1Hog1LEUhJgXnxKhq2dItSVv33VTahM=
Received: from DM5PR20CA0041.namprd20.prod.outlook.com (2603:10b6:3:13d::27)
 by DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Wed, 23 Mar
 2022 07:15:41 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::e7) by DM5PR20CA0041.outlook.office365.com
 (2603:10b6:3:13d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Wed, 23 Mar 2022 07:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 07:15:40 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 02:15:36 -0500
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
Subject: [PATCH 0/3] Add unit test module for AMD P-State driver
Date:   Wed, 23 Mar 2022 15:14:59 +0800
Message-ID: <20220323071502.2674156-1-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abb10339-d318-4074-1200-08da0c9ceff9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3897:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38971DB93ACF69398AD8974AF7189@DM6PR12MB3897.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0crCpXmUd4W8EXDzBu3+VFFTLlCD4rQD5HFzdE4XL1SC6hE6+y8+Z9wwQcKAAUsbtoEz/6UdTcXO/3s7mkhL6M5z10roOuZi3mB5iSb7akwF9IghUQo7EbWXg5au8fru10dTgRfxvpdH8BfilUfEaEqvCquSRKghOlJ5GgnPcwUrGlj8t1TnhYQYPeADzNufuyaJgryMOVTbcifOnZ30VioIz5oF96NggB1sHufoKuh6G7KiF223xVlH42g9He7BTFy6AmxImdCD3ZllVrm779Iez0FpUmUVbSCDXQaNge5lYHeW6q0kh/ypO/whzunyPxXWQLp1jcRlitHZI68VLqGSOl2tebZZ6iBIKOdSZHYbGRfPZQ4SAKr0dXBHjZY9NNl51S1soviSn2qheYqxPsHjPF+HPunxn8vebC5Ni1+EdVUAYVwtkAA9GR8Be529JjDrkjt7ZQkEgPbPyz5QoC7sgYpYAdJKz2XuKzs7Oty/6VA3DQ1MN5Ti4NCBa4pnUygrPsuJ20AehrXFe489kXKQu4x1AUtk7xAG/+zXgiJTIa9iflB9KIb/LU8V2Pw8zo5eFlQh83T2eYKIRu6QqqU4WYaJM6ahoEwZJVGY0iY/eBSpqVJkUw1QN6X8ZB4hiM6+ODZ12UTcYaAJ5x78CvpOeccFrc7nr3+A1dehcegjMrPi52wxiwUH9ogG37XMfxILh7ZMu82VBNyFSWA9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(8936002)(7696005)(82310400004)(86362001)(81166007)(6666004)(356005)(2906002)(8676002)(4326008)(70206006)(47076005)(70586007)(426003)(336012)(110136005)(1076003)(83380400001)(36756003)(40460700003)(2616005)(36860700001)(54906003)(316002)(26005)(16526019)(186003)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 07:15:40.5918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abb10339-d318-4074-1200-08da0c9ceff9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3897
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

AMD P-State unit test(amd-pstate-ut) is a kernel module for testing the
functions of amd-pstate.
It could import as a module to launch some test tasks.

We upstream out AMD P-state driver into Linux kernel and use this unit
test module to verify the required conditions and basic functions of
amd-pstate before integration test.

When you test all the test cases, you will get the following test results.
The status "P" is pass, "F" is fail.
jasmine@jasmine:/sys/module/amd_pstate_ut/parameters$ cat
unit_test
Index    Test cases              Status
0        stop                    [ ]
1        all                     [P]
2        x86_vendor              [P]
3        acpi_cpc_valid          [P]
4        modprobed_driver        [P]
5        capability_check        [P]
6        enable                  [P]
7        init_perf               [P]
8        support_boost           [P]
9        clear_status            [ ]
------------------------------------------
begin_index = 1 end_index= 8

For exmaple: The test case acpi_cpc_valid is used to check whether the
_CPC object is exist in SBIOS.
The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is
not existed at the detected processor, so it is a necessary condition.

At present, its test cases are very simple, and the corresponding test
cases will continue to be added later to improve the test coverage.

Thanks,
Jasmine

Meng Li (3):
  cpufreq: amd-pstate: Expose struct amd_cpudata
  cpupower: Introduce a new unit test module for AMD P-State driver
  Documentation: amd-pstate: Add unit test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   | 221 +++++++
 drivers/cpufreq/amd-pstate.c                  |  60 +-
 include/linux/amd-pstate.h                    |  74 +++
 tools/power/cpupower/debug/kernel/Makefile    |  10 +-
 .../cpupower/debug/kernel/amd-pstate-ut.c     | 618 ++++++++++++++++++
 5 files changed, 923 insertions(+), 60 deletions(-)
 create mode 100644 include/linux/amd-pstate.h
 create mode 100644 tools/power/cpupower/debug/kernel/amd-pstate-ut.c

-- 
2.25.1

