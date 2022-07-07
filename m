Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B3656A894
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiGGQu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiGGQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:50:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B762A42C;
        Thu,  7 Jul 2022 09:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEMAW2rXOmBviFpyzw/QcNqZJ4gkXXCSRUSxR/hRNEv+6xufm8rvDbLrR4YVLNCxh3q826ufuRSG2CIQCj2BaoeXXNE7MwXtr9JSOkLrLJDVqI1c4y8LKITFzwYRlLrwdO50ziIrNLArnA1ouFmzm/HpMUFMZbY87GWl/V6opUYKlF6h0+zhFIBR428wTQmWDlctpLPuQbXwDoMULho+69lPUX6PYJC/t1q33PwtlQmJRk0NS2MP/gYGvBuKjcyx6TW/mGFjLTenP2QYA8oLLVwsATCm2VBT7kV5sujXEoLQr2w1IfqpO/BMKV9XkyPTtCaC850KgEYDFl9d/Rg68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGgrjFhgAW9cB4WIvzoVfI2lbC+F4aSnWXizFzjh000=;
 b=Rvlr6NBa6kQf+FG+B9qImBzpz7cQurJ+4oXfGpOzF7iLb9YR9WoF6ADJoIiY81WUsAnG9qMfdVnQuWSvVNa9bNV87yjG/LSmbwC4NsF6wVDgRohJmJE5wLqoBxaROA98y4HVb1Q1lat5m41K9zySw3hfmNQwdW8lzoW5jcd38AiMuKhfGtYY/rNJH9TfQv9ii3elY7o6uq91ZtGCNNDRHmlX4X6xM9W/ZERIl7r7DujhHwdrLmKTIXrIcOmusopJ5AQHxtcXrcIZ7m75Q/Lx9bhJy/yguGynjear5MdTpgnLTiEVdc+RRbCytFItRK/s+ile2TaZtcncJ6Boq21T6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGgrjFhgAW9cB4WIvzoVfI2lbC+F4aSnWXizFzjh000=;
 b=Zvp5JsZ5uEgMqLl66NmrWO9JpzUeNJ2FYjdSQ/uZFeJAhacIxp76Ll8v2KdK+tk9hRrvm2tOwr4bpiv7EOjGK7SYeAMkwhGmyv3+wrHeQrFs5Ecz9gvpaTjPxmFf7ROo7shdM5r4CbrCVqDlBqsN02hVCx62sjXShlxqd1fE60M=
Received: from DM6PR21CA0006.namprd21.prod.outlook.com (2603:10b6:5:174::16)
 by CY4PR12MB1735.namprd12.prod.outlook.com (2603:10b6:903:122::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 16:50:20 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::30) by DM6PR21CA0006.outlook.office365.com
 (2603:10b6:5:174::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.5 via Frontend
 Transport; Thu, 7 Jul 2022 16:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 16:50:20 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 11:50:16 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 00/12] AMD Pstate Enhancement And Issue Fixs
Date:   Thu, 7 Jul 2022 12:49:44 -0400
Message-ID: <20220707164944.210616-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c64e86b-5550-4c81-af21-08da6038c766
X-MS-TrafficTypeDiagnostic: CY4PR12MB1735:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nap2iXX6XJyL+YTuY1Rzf9oLa/eq6tc3Gk4LxyT/HTnmhEj6ywyyvdIcx+57GQI9C/02e3IijxCwGFE4tmwg9oaaZFx9cncfj69ExtjnHRIY6ZrXsS/hZ0RYg0tcPTzp1IXP6PPCsItEP9yywPzYo1Y3zT+JEJ2ZSADFznI3vqyV10dN6oERnzUViGWw1hj6HqpQGa3dFjo+80Eq8b+FtD1cvl6hcWc8w47+jpyFNP9UZ6e7xvanenEax0Qt1kMvQQAePfJVzqIHYPgswPL3lXsPiytZruUuJT8Y2WjdioiqwmyFbcIDOoYhMlr1ZN9bNuHBvgj5/penSuKcduE5fuerkqe3t8gil2sHpkKXHWSXyAdBHA016u3bm3gf98U41j9tn9Ges3XObHQalHY411ufNkEA0dTF4H7raw44hGSh0d7S9WXGolgMRaQa/c8ERMHmEZv9LGCKWAsXF3rATCHyKv28r2TyBE6HEv3LyIEUxJ1tIzFYqqdZ028YM0HXFrBGNKzMP8jPWt7yjbU/NqrQ/kDZ1z5a28dY99M6MRT9wC4/hrGOHAErTL342MZtMp0CbSLTxy3DMmZdpcwk8um3wpg4SjtaGESEfCYKhcZyZQpcr0b15EQNq95rAARDJs+H1thKqcPLBgNwNIIeqF//SoU08AWD4JZzIzL1RJ2OPD61LGqIbXT2uHOaiv3C1IxauzjDjhId14s+cJrQu2DLWfHkc81HuXiFE8TN0MCSJpqQAeaU+BhCiBPC87SJ9O/QkezZ0INMmQIOM92167lJu7IhxeGKFdPNxFGFmMY2otggefivRZ1akWI2/yLNxcQ9YA+ktceyqsfY+LbtXxsKegao6wXBlW2FMtL7W2XFH6foB8qouXEQv3PHuftd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(40470700004)(46966006)(36840700001)(4326008)(8676002)(41300700001)(70586007)(6636002)(36860700001)(86362001)(40480700001)(6666004)(2906002)(7696005)(70206006)(356005)(82740400003)(8936002)(40460700003)(26005)(83380400001)(5660300002)(34020700004)(186003)(81166007)(478600001)(426003)(336012)(47076005)(82310400005)(1076003)(316002)(2616005)(110136005)(54906003)(16526019)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 16:50:20.5239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c64e86b-5550-4c81-af21-08da6038c766
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1735
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for precision boost hardware control
for AMD processors.

Meanwhile the patchset fixs lowest perf query and desired perf scope issues. 
Update transition delay and latency default value to meet SMU firmware requirement.
and do some code cleanups,
It also exports cpufreq cpu release and acquire for coming amd-pstate epp mode driver

The patch series are tested on the AMD mobile and EYPC server systems.

Perry Yuan (12):
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
  cpufreq: amd-pstate: add ACPI disabled check
  cpufreq: amd_pstate: update transition delay time to 1ms

 arch/x86/include/asm/msr-index.h |  3 ++
 drivers/acpi/cppc_acpi.c         |  3 ++
 drivers/cpufreq/amd-pstate.c     | 57 +++++++++++++++++++-------------
 drivers/cpufreq/cpufreq.c        |  2 ++
 4 files changed, 42 insertions(+), 23 deletions(-)

-- 
2.25.1

