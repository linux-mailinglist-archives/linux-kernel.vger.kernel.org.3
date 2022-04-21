Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7935099CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386049AbiDUHpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386013AbiDUHpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:45:13 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7AC1B7B2;
        Thu, 21 Apr 2022 00:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGVz947VV0eTNafHeEKWGWRl5mE1VqAiXoh0sRruUWXVzuffebCmKphZH8IqNuhvVE6eJF15hL8ziKSmNdMQI+/IA2xVkuDduzKoESZoWrms1qfWKPFDZZon3CFBvGaJUHyQYZGq8lzq+wMe9vhEJj6ui2ciUuKQwmMHFtMiSVJtRl4L1ut1zmgpxlluC3hPOFPbcpTEUCWGPC96KSYZtlkEZ4/Kjznv9qqNiJNEDbiS2s+ULZgtUJAuhUxMaFkISDWL5mwsklJP0KyZpvietISvg4zKSA6Bh5rgW0O/15Lf69tMVg4wBE0EHkii7/n2poxaRrOQhYcqDmRgaR6Ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKpkjbBcLxSzCls+II2vecD2lNXJJLEGCXzpfAk5x9Y=;
 b=YjfGcQRbHZdi6uRDdMibfpy1RuKwLVs25CoBXUKsIf+32wa0PjyFakjwJZ93FO8EaRFr6aFNyKsEse0cK8bryHcPlCVkB8tRP/loLSAXZwNnO8tGH7V58u/iduscXd/vnMgqZp2GWJRPaImThdf4ILl3dnTlpp1otRG2J+M8ZNhPPdA2Y6D8mepL6X5DxytAoHae/m65NtEHzJNK6auB7fs/CoRk0RiboNnm+pbri6uiia5cuFh7uKGupTvObewQTMKRV8Z4Y4AQ1Jwxr/iXpaijDlvHIo9V0R0UPVsbGqXP5zZOVxYDcvnqjeN1eYDyq/5Fl4A7tPdelxvnPric0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKpkjbBcLxSzCls+II2vecD2lNXJJLEGCXzpfAk5x9Y=;
 b=iKUl8a7x6DL5jjl0gKFW2VW5RlLgnZU+dOw7ir9UmhBCP8EiBtx7P4hOgt6QAWKPnWzC+B97CEaU6xd5Iiw6qaKdntK6z229p882dd+6t0nHoWK+mvAuMfgHDHje7poMTnNASGeud20+/k8LF2dw5bDOJMfuEJTy96pUCmWfhkc=
Received: from BN8PR03CA0015.namprd03.prod.outlook.com (2603:10b6:408:94::28)
 by DM6PR12MB3434.namprd12.prod.outlook.com (2603:10b6:5:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Thu, 21 Apr
 2022 07:42:22 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::eb) by BN8PR03CA0015.outlook.office365.com
 (2603:10b6:408:94::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Thu, 21 Apr 2022 07:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 07:42:21 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 02:42:17 -0500
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
Subject: [PATCH V3 2/3] selftests: cpufreq: Add wapper script for test AMD P-State
Date:   Thu, 21 Apr 2022 15:41:51 +0800
Message-ID: <20220421074152.599419-3-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421074152.599419-1-li.meng@amd.com>
References: <20220421074152.599419-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 623bdc17-d01c-4eef-9cce-08da236a786d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3434:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3434E299139602A4C3BF27DDF7F49@DM6PR12MB3434.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMuLCjgjbw5ZTeauJ7gC3JdBjrarKzmfE3QMReeUeWGW2ZKVj8+EtXY/pDNgmcCtgZNmee5VYMDQfstaLSt8kjaYd9ibEiQ/oy236CNfWJVaMHeppXFPPl5EGQNLemu5fsKLcrmnxk8iltvYmVa45P0Mbg2bvEO0CYKX+PnQ9bnOyqKatSMP3+USOvyoLvJLJBIJ++CVBTdn07ZbIsx4601XEywiLarPIdrSk8V0Mekux01Cq20V3UBbHsMil7EL59HFo9uM+ofqounqKPox/RAYasMkbkhbo8a7/DdblzDipoDf+S8/Vq+PDH1n+avNQlyPNyGKXBSxkHUyNwT9q7nqp4powvrJc3lvYL1I5XxFhpfHqIZvgvcfINGoKQHfo4o/be/uPIb2zEvlXIKtEMgjFlprbTYEQZwZWq2JSWfAWyqpQbqf+ul8DFTC4O300IIdWqXYlFiiRNM3JYNA9Kw7xLklzWi62ZQeE2VtZg/l9HxYSPtwftnKKZRg3jApMIl2j0X2gH20a6Ag4wV91sq2iMOqUq1gPTCJdX1eKlTbovA54dYReB8CBLLcSXL4gexVfhRy4HVRpF6rACNEqoetU7KCm/yjVHvd5cAYnilFQaaQ/lYU26rSKPx064zYBbUUfw1YEQ14tadzdOHEf/VDzyniK9mB6jC8ek4tolWZ0D4bIThCutABJz/aNKNXBowlwR5xRUv3OKgAPc6L1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(1076003)(110136005)(426003)(54906003)(356005)(70586007)(81166007)(70206006)(2616005)(47076005)(4326008)(8676002)(82310400005)(336012)(40460700003)(26005)(316002)(83380400001)(8936002)(7696005)(508600001)(86362001)(5660300002)(186003)(2906002)(36756003)(6666004)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 07:42:21.9676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623bdc17-d01c-4eef-9cce-08da236a786d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3434
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a wrapper shell script for the amd_pstate_testmod module.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 tools/testing/selftests/cpufreq/amd_pstate_testmod.sh | 4 ++++
 tools/testing/selftests/cpufreq/config                | 1 +
 tools/testing/selftests/cpufreq/main.sh               | 1 +
 3 files changed, 6 insertions(+)
 create mode 100755 tools/testing/selftests/cpufreq/amd_pstate_testmod.sh

diff --git a/tools/testing/selftests/cpufreq/amd_pstate_testmod.sh b/tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
new file mode 100755
index 000000000000..5398ad568885
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Tests the AMD P-State unit test infrastructure using amd_pstate_testmod kernel module.
+$(dirname $0)/../kselftest/module.sh "amd_pstate_testmod" amd_pstate_testmod
diff --git a/tools/testing/selftests/cpufreq/config b/tools/testing/selftests/cpufreq/config
index 75e900793e8a..374a8adbb34c 100644
--- a/tools/testing/selftests/cpufreq/config
+++ b/tools/testing/selftests/cpufreq/config
@@ -13,3 +13,4 @@ CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_LOCKDEP=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_AMD_PSTATE_TESTMOD=m
diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
index 60ce18ed0666..d3602fa11392 100755
--- a/tools/testing/selftests/cpufreq/main.sh
+++ b/tools/testing/selftests/cpufreq/main.sh
@@ -6,6 +6,7 @@ source cpufreq.sh
 source governor.sh
 source module.sh
 source special-tests.sh
+source amd_pstate_testmod.sh
 
 FUNC=basic	# do basic tests by default
 OUTFILE=cpufreq_selftest
-- 
2.25.1

