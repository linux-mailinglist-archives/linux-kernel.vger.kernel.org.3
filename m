Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B99F5B111B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiIHA2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHA2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:28:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310FCD0221;
        Wed,  7 Sep 2022 17:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM58vSgHe7QF68qWN1mfpeQtk2ylAtWjkQcrAMTMxHTn31HZScxnRUJTLGkQwLLxFN83S1jJry6PM4O3qXdFWU1IuWh5X8gNwGK38JUK0XPaPCZrcHhf2eXx22TEJ6XreLraVQ/9tQgSDRHiv1kOV+cwiM/gqoC0UzT5D8Z5Ci3qiz6H5wajxcc/YwO+w3M+uxqPuCWLg+yjXRanIUnbT0VmyEP4EvFg4YrxqCrSjqEeUTP5zCdskhnz6B4YvyNKleHNPKm84JV8aOAbNeOy+kmCIUvucaZFGv2yFZOXD/rNgUsSmY/Hl0mOAyqwde5hm8DWOjaOuRV6qx+3aln6tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdLQYg8RDb396A262haJ2vGV8GQosuRznx2f8SQyqqU=;
 b=A8EZH/nmNpuxJNvoqxNDNyyJLOyourIOPZIgIQHFg5FGgaqlEvozODyyG3A1gsRFk5wIAxVDgYXOsrC49XAs6STQUyv2zqaleySdJW6atIePBzO1NX7LYKUAVZtfaBaESimN7LOSA9Hj2q0kC5bIwMXIoe7t80Hy/q9xB+0iRgM0H0c9zI/QIsn2xdRj2psoPYWhD1uTYisoxRSKSdNO2TpUb+PfRgdI6DmHSUpRzduWCl3zGcOz68IMmiNplzBIM2VlHWaXxqCf8XRNV9+h0a2XDW5wwwwYe8HMLoVfcmxzq6uwowQYr7i/6+jZa6ROWDM0iQP+ELhSLVgZl5sL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdLQYg8RDb396A262haJ2vGV8GQosuRznx2f8SQyqqU=;
 b=vhFyT4qZVPzfEr6FHg/+jexJE0MnDjIpxs/M1UvDj30EfIQKRCzdcCK3m/2FBs5imHUj5/wRh+ASw/4uL+F4vdejphZ8jWHCvfmahdA6AlWkkt0UkcZeIGeagVml75Bl9jcY+QXJ3MFQyKB2oB+TJNxFKoC7NFOmk5JJmSFvNx4=
Received: from BN8PR12CA0019.namprd12.prod.outlook.com (2603:10b6:408:60::32)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 00:28:44 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::2d) by BN8PR12CA0019.outlook.office365.com
 (2603:10b6:408:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Thu, 8 Sep 2022 00:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 00:28:43 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 19:28:39 -0500
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
Subject: [RESEND PATCH 0/1] Add explanation for X86_AMD_PSTATE_UT
Date:   Thu, 8 Sep 2022 08:28:20 +0800
Message-ID: <20220908002821.1648880-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8a70ed-09c0-4535-4d8a-08da91311643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XK9JwZSxg7Ym9QuJV47y6p2rJSVemtgaw83reoLpp1QdSDu/RzZ+/ewMgWYZWuzsH/f48R0QAjdeyPQ03U6BIGmN36fvIg+upffDNSWdGAK7VBnLGcoBFvfCK8INwEYgn+na/T/bGWkUkbgwbHfw7oOhIqMrXJt0ENp+rBdcrwaO6xYPv1kRGE7MARRGvAWJ/IuCf8R2Bjcwwb1b7wbT+rYd+6QX/QVj8fEReseHl2rirnn5Jq7DzKnxzjd2ovPOjR8Ur7Xpb8/X8IzR+TYDPmVOrinsXLIrKFqGd56VDcwOwmArjgvCPb9AgnYFhE6WILxNqpZqpHaYdsXoESmh2WU6xpGDZLVITAQ4+weZArtotC9HDp6Em26okHAabTkp8xMcoI7LKVjszZbJMN9Heo16AaB0YsS27dm1eBP3c28vY6pOSXHQAOE5F9fiyGvsJWAbX1n0c7I46HFR3oeqX8BWyNPtJTZMF5Mn0fFdFbzuLd/M+Q0yjhy0MEMGNwomI1Gksc07siFnaAFtcPcYzAzj53WkPWp8jZXhwSAYsn+ghwVEPFaoI3MSaSxuYd/Dz5n+9wDdXGt6yYTab1fPBX8wLdtXlHjuTjiBiyVZ33WCPRkminNFHGEHoD+/z0Ek1vnaRFU1ICPQWbz+IFdhFB/0LtWtBWsga41l58gkhjqW854sWPxfpVnCBVRi0zIBL0A4awF4DvG6Kuu6EVdGcRsvNfekFVXr3gHdxBWFktejqR719TNxEaAeUu4a/FOusFt/pt+RfB2Zq84Nwv/ChzfwyDTAFl5zPOEqCUQfwu+uwKW7y1hiczUfHEN7OSN0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(40470700004)(36840700001)(46966006)(26005)(16526019)(336012)(2616005)(1076003)(426003)(6666004)(5660300002)(8936002)(186003)(40480700001)(86362001)(7696005)(41300700001)(36756003)(47076005)(40460700003)(82740400003)(478600001)(356005)(82310400005)(70586007)(4744005)(54906003)(83380400001)(110136005)(36860700001)(2906002)(81166007)(70206006)(4326008)(8676002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 00:28:43.8656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8a70ed-09c0-4535-4d8a-08da91311643
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
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

According to Shuah's review comments, add a new patches for expain
X86_AMD_PSTATE_UT.

amd-pstate-ut can also be built-in without X86_AMD_PSTATE enabled.
Currently, only tests for amd-pstate are supported. If X86_AMD_PSTATE
is set disabled, it can tell the users test can only run on amd-pstate
driver, please set X86_AMD_PSTATE enabled.
In the future, comparison tests will be added. It can set amd-pstate
disabled and set acpi-cpufreq enabled to run test cases, then compare
the test results.

Meng Li (1):
  cpufreq: amd-pstate: Add explanation for X86_AMD_PSTATE_UT

 drivers/cpufreq/Kconfig.x86                         | 8 ++++++++
 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh | 1 +
 2 files changed, 9 insertions(+)

-- 
2.34.1

