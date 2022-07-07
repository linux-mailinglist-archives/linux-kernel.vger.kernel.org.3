Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA156A8CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiGGQ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiGGQ7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:59:12 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80588B86B;
        Thu,  7 Jul 2022 09:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1dBsKqON4FQBDaKhXhSHp4yAGnE4IPjppy3C1OPP7cgzGjIdiOG0eURdjUCZzAVNjJB+q9waZvpWWJnWvqayTFG4Jvra4AO9D58WmbyR+melkjaRblOczsNjMz/hX+8ychZLZRvsawZT+mY5+V57a24HMMcLI1tTiUB381YZf0nf4HcavGSlJZ4XI/RkTpW/q2oeZsrtbVCt+O5odm6aCPGEKowpU9gs+Qe/EXL+3T553xLsWreV05nmp1my908H9PJSesnIkM8rhye8ipWsi89BPpCbsLusYZctjktnSc+V3iiyZICUfULyUB5ctaTQM0etX+NTiSiHuOcVqdT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN5+9MjVFTE9bOeD33YGoFoU/Kg+Vigkk4Cy9BhX4dg=;
 b=LUaaQkSAmSr0eBs8elr2RqUpR0PvwEvzlkZ6to9wnfg1LwC5ubosWEyn8PdH9ig9a+xVDNfzBsvC3MesOe7gl1o98N/58m+VH7z3dJzKY5MceccmmdBlQtDnT2Bq8ByCEwP8ge9uFWSTzQMiTZgREacswTAOpkerZzI+ctuNb+JVRPR0Q34dVu/Bh5djvBEe5I0FUh6r/Ws5J2f++HdsnYNvbuJx3SWDmcYhzSKhp1K2SZPpDr7d3EfIXgnPpprnw5bQsbD7n68BLPovYqicqQzpWv9qD1BKGg//xew6A7CyKpUT1dD4W65HveqjxUNu2vlGu4+dSlOMJ1WVWx04nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN5+9MjVFTE9bOeD33YGoFoU/Kg+Vigkk4Cy9BhX4dg=;
 b=16wwSLRyWfePWB3H0m5bvtVvnK36Z2IsIn4D5YOULQwW+4qy95buqmO9B8p/llFohKk205/evdv2Cuvz2OvEW9PHifSUhLlIXudbcyoJnnP0503wXH2XbZFp0oTvpYjKSRi6InGA427Je/Zz926C0ckLWfOu//G7YqcMTBLbidQ=
Received: from BN9PR03CA0099.namprd03.prod.outlook.com (2603:10b6:408:fd::14)
 by CY5PR12MB6107.namprd12.prod.outlook.com (2603:10b6:930:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 16:59:09 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::f2) by BN9PR03CA0099.outlook.office365.com
 (2603:10b6:408:fd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Thu, 7 Jul 2022 16:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 16:59:08 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 11:59:04 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 03/12] cpufreq: amd-pstate: cleanup the unused and duplicated headers declaration
Date:   Thu, 7 Jul 2022 12:58:49 -0400
Message-ID: <20220707165849.215254-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aea82e83-7c77-4965-eea9-08da603a025d
X-MS-TrafficTypeDiagnostic: CY5PR12MB6107:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8F9pqHsuoEoLkvM5aZoe3SaK3VOf15leVz5fdAcmatYEFDUWw0d1IcmNWdbmw6z49Aiqe8A+yu4HkEDAo0e1r8LDIRY/XNsEOVm+/7/iGmaN30LFfj0AeUKjLfU9ChSxGvfFVsBbaZaUimXmo7YicIMbZbGk66tx+rbZQ+gwx6r6R0qw8UUdtjnXyXnNhqslZ232DrpeULKD4B9lvz1bmR/XjzM3cIMfpfaUVbYHnWctks1cHt20dSFMsJFm7PAKBiYv1v6DlQBFyoZCQYanRI3jFB4+7Z+sPm9L3Qjrha0qWm4W9aJyk5NyOFKgf43mxlbK/HBu1GnR12EZhKuzPrxOtHVtuV3e3l9VwnMWUJJq2MWMUvjJRSTZAk7iHz7Lwqux1DAt2Pp6sBUKnBm6FLgyax3TVA5BLBfPsiTtIgtdcPkLeQF55CtEIvBjm8melSheuCmyazt0fXeJ5FRv2vTYancQ64MsshkBpLvFOWlhwguprvOYtdDl69F0ChBV6SSqutxj6ZFLpH+Bgq9ioe8v79JdZcAe4wp3srxvjZmcnFhKNYvU/r1j+UN+cr4L2DzMFY5hAhCIxgqJuiQDhxpYFlJD3bKpmGT72FGCAaVIfAHkPWpMBous1Bkbmeq8NtU12n3uicdFCWmNlCaWu4xqlcNBLCHnMDQWoVwH7yPP5ckpm3KK76DJmivjJ/z771wHkEI8KIkgINCKe12oWCq4GXu3LPuaFM/kjp2PtSudC0HiHT+romGI/S0z7LXyfSXzrwx8m/p4S6QzNAqPAh1H4grPsMottiHc5K3ilAxory7qMpDnakYAG1cKeYpJToRB/GqCbTGTUz4j82CBQXuNQTYn6lC0AZKX9huZkur0bOEjp/OS7xJ2eGkTo4y
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(40470700004)(46966006)(86362001)(110136005)(41300700001)(6666004)(26005)(2906002)(40460700003)(7696005)(478600001)(8936002)(5660300002)(82310400005)(4744005)(2616005)(1076003)(336012)(426003)(47076005)(16526019)(40480700001)(186003)(81166007)(82740400003)(34020700004)(83380400001)(356005)(36860700001)(70206006)(70586007)(36756003)(54906003)(8676002)(316002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 16:59:08.9801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea82e83-7c77-4965-eea9-08da603a025d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the headers declaration which are not used
actually and some duplicated declaration which is declarated in some
other headers already, it will help to simplify the header part.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 188e055e24a2..43e6df9f67f6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -31,19 +31,14 @@
 #include <linux/compiler.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/uaccess.h>
 #include <linux/static_call.h>
 
-#include <acpi/processor.h>
 #include <acpi/cppc_acpi.h>
 
 #include <asm/msr.h>
-#include <asm/processor.h>
-#include <asm/cpufeature.h>
-#include <asm/cpu_device_id.h>
 #include "amd-pstate-trace.h"
 
 #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
-- 
2.25.1

