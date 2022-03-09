Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A0E4D266C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiCIBZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiCIBZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:25:31 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2041.outbound.protection.outlook.com [40.107.101.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BF3443FF;
        Tue,  8 Mar 2022 17:24:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfJZbhj76iU3dmPJ9blDa+Z5FSaBlt4jUGUk0OTwUeTmcO3O/Bx3Sp7MZh4T4+HlmbVeBuQCpX1bF5qsVOCK3F/X6U7GG+7DidS3yFry1vkkCctFuVOKFQUZ/pQvC+z3jeilyQTc9CYB1lHcOL5DnpCUL352bQyggtAzPraPF3WAj0Pz7o0Ehr+dXfORCGdbsqdYYFeI/r24TidhIC4bdflJfXwURSUK9aKP+ufT48H4IuiLrCYN7cwGQDOiGsrymzwS1bE1pJT46hrYgLeF24gKS6YCUe6MLJqhsgVNo/46W/eyaSlTIY6GXCh9w7YGDZpt8RV+x+1kSWEWxGY7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7JioxBXyuI/+3upZxDYw+188bO0Sc5e68yaCfdZvrE=;
 b=Nok4bd9MOhfuiZ9A8CwkqpbpaBf43v/JlSMeAUXHvv9Cx93pU/yMMMFfrTDkZulrk9JjSUPGTZzKZ7rfOyQhu1Eznaw/0Lk3EGg8nrSDVgwZobjTX0u70bjgxxOJAEnkTjWuz08I2iyF5WoVQ7KKf3l/+j2J6Hl0SvDL0xpPvDWkzMYadsQw0KetTo73b8jPP260nVXUohOlowcadGYwkaPqZa+NLyAWegl4YuR826+0Lj3gihLjut2EeD5/gzM6Biy5gI8fagGL+KBDevGbm08iL19FKp+cD0OOImQHtur8iwNXwOi/dyT/6wiJfmRu4zRVRTPZF/S+26q1YtHPJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7JioxBXyuI/+3upZxDYw+188bO0Sc5e68yaCfdZvrE=;
 b=nIjTdzyLb6xvaxVSNwV1ujnVaNCsdKli5/h36g7BDcXgsZttCnCMVaAC02SSO6kMIVS70baGuege08IQNXeD5uYlqCjJ4IRSeKB9yoZyOs38Nq9Z++Z6W93H8wDtS3oSEF19u76lxbUxQ6v6LwO+ykqnxrt5ha//WmSo7T664Dc=
Received: from MW4PR04CA0366.namprd04.prod.outlook.com (2603:10b6:303:81::11)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 01:24:21 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::c3) by MW4PR04CA0366.outlook.office365.com
 (2603:10b6:303:81::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 01:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 01:24:20 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 19:24:16 -0600
From:   Jinzhou Su <Jinzhou.Su@amd.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <dsmythies@telus.net>
CC:     <ray.huang@amd.com>, <viresh.kumar@linaro.org>,
        <todd.e.brandt@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <deepak.sharma@amd.com>, <alexander.deucher@amd.com>,
        <xiaojian.du@amd.com>, <perry.yuan@amd.com>, <li.meng@amd.com>,
        <jinzhou.su@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>
Subject: [PATCH v3 0/4] Add tracer tool for AMD P-State driver
Date:   Wed, 9 Mar 2022 09:23:47 +0800
Message-ID: <20220309012351.616826-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb8cd80e-77b6-470f-3056-08da016b89b1
X-MS-TrafficTypeDiagnostic: PH0PR12MB5403:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5403A9B0A74F6B503AE94955900A9@PH0PR12MB5403.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T67PAnENIap2I9SazTKXKwKdW2/udA/eK/u6Mg/BMeENq4M4+QFLrRVDtQpUSNIHjoIlr5Iq9ejADK9IMvZ6pJvTRhVS+zJnG1B5/3H/X7cw4f4O5D10tShizWuZorWPhbfCRZAN+2Y9TPlPEYXVMqOAgln16NkiW/Rqdi3ufcGRJZUZ6kBzBh0GCqFsjXtS0cZ6zEKUJ03p8ZGDCZbcFv9eD/0WntRpqN4kQo6uUEvHiQLaJpy7Rd1DCdwuxgaPP3MwU7ETjNy0g+ClboozLkVAJcgJ3FCWM7kkrP4xq4Lg882hRgEU+1MIT+BuQnGub0tSpVaerIGTVfG84meNKIGubCraVge94KcdhOFJNWevVReJTqFUCqYZ/SWIs5EmPEUbf0/1w5FTW24uq66LFBtqkbBNSZRMXMSr/GeemfjXHMWY2Sgj4DEeY/R0rzOg+EqSk3ym9TT/8PEHZkCuhiwt9ecOCzk8128YSIrzXKcvnwX6s6lS67cwahJmvVRbTuNDgoBi4bMS2X6N6kWMWBoBH+HDRFUOxrDVc2MReb20GtahLxLp6ra2zZI4eQiVaooyz8d99DyyLbaOA2Y/g7OrQXBaxU2c/flCOY0mOQ/+8cLKp8kRO1zR8b0kCAuupLs3qeEdQaiYXUM88JI9578b9YJ3AD8Ik6QLb2wQ0YAuIcMOVIDA1Z7tmdV1dHTfdSEzvDw+mt9K5sOGiKnlVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(110136005)(508600001)(7696005)(54906003)(36860700001)(40460700003)(26005)(316002)(426003)(336012)(86362001)(83380400001)(186003)(4326008)(36756003)(16526019)(8676002)(82310400004)(81166007)(5660300002)(8936002)(356005)(70206006)(70586007)(2906002)(1076003)(6666004)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 01:24:20.7690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8cd80e-77b6-470f-3056-08da016b89b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
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

intel_pstate_tracer is a useful tool to analyze the performance of
intel_pstate driver. We upstream out AMD P-state driver into Linux
kernel recently and like to use similar tool to tune the performance
of the driver.

I modified intel_pstate_tracer.py then it could import as a module to
analyze AMD P-State trace event. Other trace event also can benifit from
this change once they need this tool.

intel_pstate_tracer could be used as the same way as before and the
original functionality isn't broken.

Changes from V2->V3

-fix typo in amd-pstate RST

Changes from V1->V2

-Add tracer documentation in amd-pstate RST

-fix typo in amd_pstate_trace.py

-add "Co-developed-by" in patch 1/4

Thanks,
Joe

Jinzhou Su (4):
  cpufreq: amd-pstate: Add more tracepoint for AMD P-State module
  tools/power/x86/intel_pstate_tracer: make tracer as a module
  tools/power/x86/amd_pstate_tracer: Add tracer tool for AMD P-state
  Documentation: amd-pstate: add tracer tool introduction

 Documentation/admin-guide/pm/amd-pstate.rst   |  26 ++
 MAINTAINERS                                   |   1 +
 drivers/cpufreq/amd-pstate-trace.h            |  22 +-
 drivers/cpufreq/amd-pstate.c                  |  59 ++-
 .../x86/amd_pstate_tracer/amd_pstate_trace.py | 354 ++++++++++++++++++
 .../intel_pstate_tracer.py                    | 260 +++++++------
 6 files changed, 588 insertions(+), 134 deletions(-)
 create mode 100755 tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py

-- 
2.27.0

