Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12497501998
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244770AbiDNRGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244930AbiDNRFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:05:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB89BC3;
        Thu, 14 Apr 2022 09:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6BKK7rLq4mh7u1SCMoeIEQjyyniXHDZitC3suaL1IeHw9zqbBzN7bkpcWxuQL5KEHW0j/C4fkbDOFAaZ59bLWvJVa6lNy7mzny+WlwKwFjeyXvTNuhhBhkmWrLl3q2hHfu84Y5B6XZv8guLX81Y6IpRYYM/FD5jPH8pyoQ8diQw18r3hxTr/ivfRJz8hW5itJWah8LX4kEsv3JejQZfxr3DjEF1bZ404nPlkca8UGduDCv7X87EOu8MUe0cq3l8fDiQVYLNUp7gy/vkQSYUmxVGYHbL3Ibo92U/RDXJzyZHf96LOPu9t0O3rjc52tdO/vUr6IW5iqartUlO36UuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qmzr55cp2EbMngwaZIRCp1nStztnv1zdLphWXlYuvzI=;
 b=M2fY+94enRrIEndrIMwkiQ7N+drgsIqH4OnjhFjBcXGjfpyVIfVEGwRHC6CsYeFbtUiS15G5Y8vkMFloFZkkEIkNhR8/4MqTXwzFn5rZT15OJFYSuVj1Ef/oQ3r3S2LNFgj5PuxIZBXkmOB+prQR/F3T5h1rXsdrILxweaRAjcn2HOz3/kngEtVFMlD36ZQe8RUAPIjjaSgrYu0V53krXMwVECTR/3mjib+xaX2sh9zhoLFXWfl8sHeBpSw6bDhKnyNCLvV63V12lCRNWV2U4s/xwn/H71m/e5XU/ufIrFdulR0L2RNiMBygmcWiDNYi6nAmi6HXzM0/3EhDdm6ojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qmzr55cp2EbMngwaZIRCp1nStztnv1zdLphWXlYuvzI=;
 b=seYSED5YodXkmoJXI1O+eBTXqXliHICKNpmmy+l+w5IiZt/waTCf2TgVjSQX5MYMP1F14V2BsNXq6KnR19mXXO+ND0F86L2bP0apIUendcMhlDqoqgMZqxxwOFIh6UwqRfSyPleiA/9xvbVQ0QqxoMq8euj93Yg5fO/FT/e3I1c=
Received: from BN6PR2001CA0023.namprd20.prod.outlook.com
 (2603:10b6:404:b4::33) by BN6PR12MB1938.namprd12.prod.outlook.com
 (2603:10b6:404:fe::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 16:48:15 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::ed) by BN6PR2001CA0023.outlook.office365.com
 (2603:10b6:404:b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 16:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 16:48:15 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 11:48:10 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rui Huang <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 6/6] cpufreq: amd-pstate: Default to replace acpi-cpufreq
Date:   Thu, 14 Apr 2022 11:48:01 -0500
Message-ID: <20220414164801.1051-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414164801.1051-1-mario.limonciello@amd.com>
References: <20220414164801.1051-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4d56c98-443a-4523-15cc-08da1e36920d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1938:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB19384EDCC01AD08B0F267A15E2EF9@BN6PR12MB1938.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXOZXpnwRI0LBEi2kXcjCzDUCbkXmJrdnEdYVVHJXad2LJhjlqCZieNbCUpOvjToZ41Zn7efqqLrXRkaD6cxAKTSbPtXSiYqd+xaN+n6umiM86ICLO1DzybxsfKg7jMJgInhojo/iODyx0H1mu4mHzEpsrKXTs6SulUhIbOVoYUiREGfZZkscv5z7aIlRHBuFoZ2OaO8mL0JY/1e542KONLcyiRhbFONi9pv2C0jIVe+CuUp5N802UICDSFN6qomukulepoE6lRP0v7LKfb5P7DCrqVoyvP2nhYDDjP66FtEnVHxqMhyAFMYfhmlClCNF22vKBWzVIASHXDMKSKxoD/NDj7c94by+sEVwxIlDf/9kj4VtlVpQ8GAgcTnJdjQfKrQE++ED1H9njDH9cONbQbAptNaRxgqp/kYgxw4RguLO4TF6o6YL8hvNK7zqSyOqiR5AhxcTwcjHa10ewOwbsfq7/UE+2pCGfheigfqHmADBjFN/d7ZeJaghRloG0oL4rXRxyz0HGnWUUnajZKB6LkxVxR8H28egDQwNN5MjOCs5SAdh94VcK/75Qj5QzSCCDkX6IqKUbPQR+UwIwLrpMFcFVrckMHX2GnryXcEkKzMbmBZtmbqHZe+TEiWggwtXQAyCSZIRLGz9i2EMCt6h3a2sfOoJf6mUUbML3tdO7eeqyjlnnTab1K//C1oqpM/9c3I86nNj/4kNabJ4TfhSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(83380400001)(82310400005)(47076005)(2616005)(186003)(16526019)(1076003)(426003)(336012)(110136005)(54906003)(5660300002)(316002)(8936002)(81166007)(86362001)(356005)(2906002)(4326008)(36756003)(6666004)(7696005)(40460700003)(26005)(508600001)(70586007)(70206006)(8676002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:48:15.3119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d56c98-443a-4523-15cc-08da1e36920d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1938
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a side effect of using the symbol `acpi_cpufreq_exit` attempting
to `modprobe amd-pstate` loads the acpi-cpufreq driver if it's compiled
as a module.

This means that module load order can't work anymore from those changes.
To make this a more obvious default behavior set the "replace" module
parameter for amd-pstate to true.

Expected outcome is that no matter what configuration for module or
compiled in, amd-pstate will take precedence.

If a user prefers to use acpi_cpufreq, they can set `amd_pstate.replace=0`
and then the following outcomes will happen when attempting to load
amd-pstate:
* acpi_cpufreq module  & amd_pstate module  -> acpi_cpufreq
* acpi_cpufreq builtin & amd_pstate module  -> acpi_cpufreq
* acpi_cpufreq builtin & amd_pstate builtin -> amd_pstate
* acpi_cpufreq module  & amd_pstate builtin -> amd_pstate

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * New patch, added since worse experience from patch 4.

 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3330504b7070..538c9c4cea6d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -64,7 +64,7 @@ MODULE_PARM_DESC(shared_mem,
 		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
 
 #if defined(CONFIG_X86_ACPI_CPUFREQ) || defined(CONFIG_X86_ACPI_CPUFREQ_MODULE)
-static bool replace = false;
+static bool replace = true;
 module_param(replace, bool, 0444);
 MODULE_PARM_DESC(replace,
 		  "replace acpi-cpufreq driver upon init if necessary");
-- 
2.34.1

