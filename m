Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202205ACC28
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiIEHVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbiIEHUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:20:47 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968CB43E59;
        Mon,  5 Sep 2022 00:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERR//eFZqokMgYUx5Tc0RWJB0JMmcra6bGkOE+bJNJjITrgGWL/g70SvGF/+TUX2aHuLq8uLy7jyUJH8+yE1s9iHEMEfJZgW+zW1NmahybGAZhe3C0XI4sksBT/N8zHZiWZFdeoV1iUyft27svIa3wCIGNNWxoKrYvfi4rxtO7vqKY7DQ0zXXVPfSwjIskUtOFhKq+nraBwWEMo+zI/cFgCiJMDvvz7Zp35HzX5usbB/WW4kG1eh5oTXtcsbq/icDs+PCEp+FnQVPaIMjHN7CltMSjkMwP0I28fn6WD38yDECQAhZFYC/crXgf5og/S1db0BkLIKIx2o1lW43bu+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp/nsDcWRE2P9+mxJq4BQ95Pddf5DcPEps6+WfE8c7E=;
 b=BZBTVghYrxWIj0nfjvQoGqVVT3oLCsDaOzv5JzZtwHyrM/HMRDrtx5CFwcuvOXyk6nkL2NXa06QzF5aOaH5b7f5V+q8Si60Wcky3OFivbLL9Fq0/MEAw78sh30Osdt8mC+kDe5d09BWRLhu7ymgR3IkouhDYlVt46+oonqj7zs8XOoE8qGZWRygyoeMUGVqRr7Wt3IXRQWFtzdqvq6gDYPrR593yYT8aNOAyox5PyxgQTJWW7vs7/J2V4TIAEW8UGlA2a9ZwrxQxgDqJ53zw7x7gNSDZjRXQ6MF3B5jGXU5/hqxSqRCz/j7OMiCHea4n3hmgreY2sfEBu+iTMoWh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp/nsDcWRE2P9+mxJq4BQ95Pddf5DcPEps6+WfE8c7E=;
 b=hyMSUoyltg4MLjM9bzu0cI94Xq4naOaQ4M6L1Lod12ZdWl2C721pQdZHywZSJxe/RRRKDZahp2RSXX9KGCCFfWwUe0jbyKshha2JfemHuhPtC7rjkbrd/bvLXuT26e+cFy6dWaSFAbZikSxJAFZbYEY+6Rmfa/Fn1JyIT3N6Hpg=
Received: from MW2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:907:1::15)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Mon, 5 Sep
 2022 07:15:50 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::3e) by MW2PR16CA0038.outlook.office365.com
 (2603:10b6:907:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18 via Frontend
 Transport; Mon, 5 Sep 2022 07:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 07:15:49 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 5 Sep
 2022 02:15:18 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [Suggested-by:Shuah Khan Patch V2 0/1] Add explanation for
Date:   Mon, 5 Sep 2022 15:14:17 +0800
Message-ID: <20220905071418.1518338-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aff151ce-f117-485e-28b7-08da8f0e75f4
X-MS-TrafficTypeDiagnostic: SA1PR12MB6677:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yH/p1cle975/tFYBdLhIBNL4WPGsrXRvOzKzoWjRdJBfMxRMvAcp7/iumNbHkyxPRwl1E4frXLfAg0zPfJtLtxJOFukPlS01FKkK226fXeNoXI9w+vIe4KyhZEJvM1xBPtONtSh1NzZS8CWluqj8Vd28VUx2/lMT2QVzORB54IMjxmsHKv8sstJEF0xL/tJrKECQPmy/aSKuOB1z7Y4mzJ1uwoRW2OvQUsOrABOC7gYiUYaYH8zHO/fi0Ehq9lL5U72TtUnmwb4vlEYvIOU3U9z0Jhjdjy8M/rLfqpXRxZWafaU2biDMzuT4stehR+KjC45uu5I55Fmce11GnX/h/nxJX1qMCHjKAwiZxZhTn2XUz38+RVMZyG2hHWmlgesHO08Ry9Y7h2l7lLCilqSFJyK60+KlfqO4ExFh4JmFbgN+/6QeZVSJrHide42mkx7+bdqwtLaeswLN3e8VyZejkgrKFs5Y36EPOmGPBiXrujjOLZ7GQoI6PUubA1HPpp/UyZmRtr/ehzJB0B+aUpWJa/XyU4qZsthoB0X08Chndg757OXE0yDb0jW5CwqHQHsV7GwbBf+Yz0I824/uT8B3W59KjfG+6uyesANqS5zJytn7cjPiIScoY7YlNd1LDisJYAJSvCH+Advo+sllbD5gi+Oxv2vBdNH3DlA3DTIjcVOiWjwkAiGScaS2AhyOgyS8eWw+lVQrqrPwr6kBS3s6PEbIRDPRv2hDNN9qAFNB3yDbOzMbPNoi8MHRaP8/lWfsU/pt1h2jzEOb5/nuw9jYToaVI6Gq6QD3DW3aHlmaA4ggApEfFiryGcE66Fxyd4l7Rq6q4ckX8rMba0SYIZS4nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(40470700004)(46966006)(336012)(426003)(2616005)(1076003)(82740400003)(70586007)(40480700001)(186003)(83380400001)(70206006)(36756003)(8676002)(110136005)(54906003)(316002)(47076005)(36860700001)(26005)(40460700003)(82310400005)(4326008)(5660300002)(2906002)(7696005)(86362001)(478600001)(16526019)(81166007)(41300700001)(8936002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 07:15:49.5565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff151ce-f117-485e-28b7-08da8f0e75f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

According to Shuah's review comments, add a new patches for expain
X86_AMD_PSTATE_UT.

amd-pstate-ut can also be built-in without X86_AMD_PSTATE enabled.
Currently, only tests for amd-pstate are supported. If X86_AMD_PSTATE
is set disabled, it can tell the users test can only run on amd-pstate
driver, please set X86_AMD_PSTATE enabled.
In the future, comparison tests will be added. It can set amd-pstate
disabled and set acpi-cpufreq enabled to run test cases, then compare
the test results.

See patch series in below git repo:
V1:https://lore.kernel.org/lkml/20220901143313.1491951-1-li.meng@amd.com/

Changes from V1->V2:
- cpufreq: amd-pstate:
- - Modify explanation for X86_AMD_PSTATE_UT.
- selftests: amd-pstate:
- - Add prompt information when X86_AMD_PSTATE is set disabled.

Thanks,
Jasmine

Meng Li (1):
  cpufreq: amd-pstate: Add explanation for X86_AMD_PSTATE_UT

 drivers/cpufreq/Kconfig.x86                         | 12 +++++++-----
 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh |  1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.34.1

