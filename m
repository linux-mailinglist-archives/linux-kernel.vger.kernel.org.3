Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A916459258D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242980AbiHNQrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243688AbiHNQqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:46:19 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C178E0F5;
        Sun, 14 Aug 2022 09:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HX+jA6zRKGQS3eiFDVSNfFxdlc4dkmGZJ/uXejKFGZThmebIzPSow0orGJSh/SO7k0TAG5RPVB+A40fCvh+06H+zgioOjD9e+7ipc0wEB4bSqzE9PPlCBMPbAbD5Tnr3EmLFgTtfXIH6XHtGHj7Tv6A0sHQSeUg6svWe+UT9UjMk0d9wuG7dCgxNhpIT9Vc4jp1z/L5A2dHA25AQE0blajLSkhRur4ik5L+cxRvy7ddwD7edvhpQptL6HayNq6hp+7GlX+2v2GusuaUh951vdUfXoCG5M9M6b35c3n5YiARt92AHbqbNbo+bxGFYtg4NzNdMsJLnsFfn01PgY6jccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nbY+vX6gnAKN0BkZW7Y2wTYqCdJGIJliiY6wjIh6Sk=;
 b=DGiV8Wti9XmOMNQidfxiE11C7PB9+WJGFAfClBRn1HpgKkz6PzKB95cGENH/G7VssFq2OuVYOTAEGUanNBCaLZVXXaqeEN4LcT7Rb/f1ZLkGSRl6KMBi5puoW6lPeZCsoaPQOYOgBZ/a7RXdfIMamxUfrigbO7vlagn1l6aq2X4jfHDw3J8RAmb//xLzvyUsktdoltDJb+IqgXoe1pYn/VuY231LdSSSn7856iYZdimKzbVNkOpPmpHSyRNoD76kUgtX+7vhcrkIeOfMkc7j4jv0I2rK4TxVJE1H0OBPDy8HTqyzBF2PRDirpeXmTXX+lmP/2Cd0FWjMgE+CMLT+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nbY+vX6gnAKN0BkZW7Y2wTYqCdJGIJliiY6wjIh6Sk=;
 b=CBQYS/FS17WIopZkxywudN7mtFPr66vCT96tJ0Ii0qu1YLlpWcy7R19aLj/RaYGJAIbU2z8FIHPf9nQjGmIul7SsQE5cqU1zxYjopGRWBZpIQsmkfm+Gome5Pcss4unVOkb1C0v6MoLn4jxbsAv/LAD/SqJ8vtj7A+8XD69Fjdo=
Received: from MW4PR03CA0356.namprd03.prod.outlook.com (2603:10b6:303:dc::31)
 by DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sun, 14 Aug
 2022 16:36:33 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::69) by MW4PR03CA0356.outlook.office365.com
 (2603:10b6:303:dc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Sun, 14 Aug 2022 16:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sun, 14 Aug 2022 16:36:32 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 14 Aug
 2022 11:36:05 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v5 0/7] AMD Pstate Enhancement And Issue Fixs
Date:   Mon, 15 Aug 2022 00:35:41 +0800
Message-ID: <20220814163548.326686-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20620bdf-65d3-46ac-65db-08da7e1325e5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3721:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hSI39y16zZazki3cmSIwD29x5SDPlcljWdi0OrJqOZC+CmyyUDlNA7xDUV7cMWYf5IxJnD+JIpToasTuqM3YwQxhV83lVfMMTnYMEG1oO51lPF5A51VN8dMCwpci7foa5/k4TJ+ukuZYlGUYKqbILRYIBlAHdWM9kPRlEafiNiMnInm4qoCbGlTwMet9xAMF5vLeZOmVRNWQyR93KL10fh/4zPVDu8YGkLMRfz1vrvNEOf5aaXAGSw1ubm8agOrdBONFEWn/cLi1RvlR0SDsIefLLgFzoUwnhUqWgnNlhEKz9iv2Gkb9CUKvLKYA7khWH4uL1vSGaagGy8IREMADjM8roppGTP2IjRfNgrbK1qtluznUl5iwusWxJ1pqDGwh4rs/SncpAqJ7TwCKTv4h6X7z3QTQ5Bc+iHb5mGYCRyzrNDdO1ZP5DKy4lwed8t5mwtli3ef+DwPJKi4JIeJEnVtDQohopYdDOKJAKC0HJhEOUQRzb00d5svjkyZazLQaK8NG0JeZ8iacbvvzZvCPxbWbESz7DbUqfjxRDM2e0ZCTFEMEVU6r+ZR9uJQY8hVpul06cFbVRSnvtRcbt4aPRyR/aMB1S338YOR8EL6JNAq1DreqWFBqYJ95lWtaU5pkIy31EDOIG4THWAqaMguhMA1TLdb3XhZGLryXYXshQ8gtaKAUrZzJdezZxbI36FShF963HjUfDvxxbvDuejWeK8Icpk96Pl1NqIEaAzKikaNy2dtxTyGJW3xUdCp4w6RwVMOQ+Td0dOelXN0ADbvxMS96fkGAOZOK+sCq/pedTfvajbV7wQNZ+3b5FIAnlEGzy+rTWj9dUui+VVi0JjDLkieF6bpL8Qa0H/tc99vYfY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(36840700001)(40470700004)(46966006)(40460700003)(426003)(336012)(478600001)(1076003)(5660300002)(47076005)(186003)(16526019)(36756003)(2616005)(83380400001)(110136005)(40480700001)(54906003)(8936002)(86362001)(36860700001)(41300700001)(356005)(8676002)(316002)(81166007)(82310400005)(4326008)(7696005)(70586007)(82740400003)(70206006)(2906002)(26005)(6666004)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 16:36:32.9740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20620bdf-65d3-46ac-65db-08da7e1325e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3721
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

v4->v5:
- drop the amd precision boost mode control patch
- combine acpi_cpc_valid() changes into single patch
- pick up Reviewed-by flags by Huang Ray

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

Perry Yuan (7):
  cpufreq: amd-pstate: cleanup the unused and duplicated headers
    declaration
  cpufreq: amd-pstate: simplify cpudata pointer assignment
  cpufreq: amd-pstate: fix white-space
  cpufreq: amd_pstate: fix wrong lowest perf fetch
  cpufreq: amd_pstate: map desired perf into pstate scope for powersave
    governor
  cpufreq: amd-pstate: update pstate frequency transition delay time
  cpufreq: amd-pstate: add ACPI disabled check in acpi_cpc_valid()

 drivers/acpi/cppc_acpi.c       |  3 +++
 drivers/base/arch_topology.c   |  2 +-
 drivers/cpufreq/amd-pstate.c   | 32 ++++++++++----------------------
 drivers/cpufreq/cppc_cpufreq.c |  2 +-
 4 files changed, 15 insertions(+), 24 deletions(-)

-- 
2.34.1

