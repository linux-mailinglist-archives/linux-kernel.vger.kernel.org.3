Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2945A8E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiIAGYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiIAGYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:24:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B119111AFAF;
        Wed, 31 Aug 2022 23:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4zau6MD8xmkZCgro9LHty6TXUbJBXO6GL4KTQx9Y9kz9V+Pp4TOJyBIPBP3/YDpUFKCyQiJMCeef45nDMruWD8NfVjcUhFDtFOKAjLh93sXlBNz9W6BCzyU09ncDCpMM8i1KGzIVBoB5av7VHwK6R6HIij8iTbhJ/U79P/qMLL5Di5agkw99nXPKHoBFPlZIZo8CSWX/1hfYjA8Qic/adesTByXe3LIYRmZxVlCQ9Q/Y4Yy74UtwpOjxfn7SUFCe0+VdAwULi/lD4r4mWLqJ+dwnHQmw6RXVPBSgbKlkq+Q4dQUYcqwfQGX5YWHveItIAaZY4ldvTAfdVdbIRhg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkuaAv4UXJ5EQ79iScbI5DysMLgCHeSTwXsE7xg2Nh0=;
 b=ioJaQE4KbTfdSuJVHoepDtXnxSF6O7vu+HhkCnLBCCfFibe2bmW6WvK9MMtaC0reCym6Vwvyh1qRIXiAjOXAqkM/+97lu2arEVJDXh40qYAhJ2Ua4SDHU3Tu2zmrpylhppwF6MlkOevsmDzn6RJggBT63yyRKjlCWcoZ2iVm3NP4EbNSpvpQj9WARJxof4GW4E3kLY/J8XEluGgm7xiAwLgex4/u8ygX7GyP0jvnM6GHkVfWBnOcWaW90PhWw/3a2jNST/hmJ0b4shp8oVKAfxcfV4cQyilSMZ3n8S9ugiJDNEPp0ePnnWDpH7MzCcjKVXqHVUAZv/CU+KE5zyIEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkuaAv4UXJ5EQ79iScbI5DysMLgCHeSTwXsE7xg2Nh0=;
 b=Kj2c1ruILA8RrMBb5YroJADGZhErR8S2zBgofgkAwxsFPTfhlQqdhJsKt9VRiPyVVdXFvT0/EjjTOvTzWXoL1xVEElqj3swsbtrTRt+aNFqaIaHmtJiS0KDDnrWq//R0vDuCnqq9G+Xb9LZYWM4kRh0SbxIBvx5ZE3kl+7mHYyA=
Received: from BN9P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::19)
 by BL0PR12MB4868.namprd12.prod.outlook.com (2603:10b6:208:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 06:24:14 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::f8) by BN9P220CA0014.outlook.office365.com
 (2603:10b6:408:13e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
 Transport; Thu, 1 Sep 2022 06:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 06:24:13 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 01:24:05 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v6] cpufreq: amd-pstate: cleanup the unused and duplicated headers declaration
Date:   Thu, 1 Sep 2022 14:23:39 +0800
Message-ID: <20220901062339.2357552-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e969928-cefd-4725-10f2-08da8be296f6
X-MS-TrafficTypeDiagnostic: BL0PR12MB4868:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhHokv8zdCzOQDeZqdLJgH3tAvF/1bWNFZqHwgBx3Nkx8DyBEAAdF75qtdXAmO4wRpmttHTKD215NmUqfdwcR8dfc2dx3AOEHHJVDjd9Oxij1N6eXR2cjkbkiH5pFTdQYXVthlS+DkdmoLSc69YGr3zb9EWjRc83fbrWx9cuHdStuOHmZVbIbSzy1GJRymoNc5iMPCd4Pgi30ff2z+iQXIjNi+YvrZYI8h06uZ+ikBnNLoETLcQGqwcxZIqWmq8AJEejE/IvTj+FzaDoP8EG7FaMIGSOW1nFftcVbFCu/p0Cvdq33g0zvqj7zhETxOGLIEcWCT26FVjDW1Yn8ZZUYMs3twnW703cTwOZy3aRAzkMM9vLuds0Gd+3US/PPfQ4Iz7zKMKARVzqCx56OrcBAd+VO5apZ6OmT4kA81WOEFJJUClNnYG5XGtbQP5NT3dLxC7YRgZ3WFFY8ahvLAg8EiQhOcSGLYxqDUQFhp6rIF65Tp6FpU9dKJlBn1eENsZv+gDbMk1uKmTy3Vzq2dUFsfYv91hN+dyce7LDuMX5MAYOrZoUnr6m23ac/biY1xziW8fb3f+1w9zU7qGWjsP0nreXbTmQbhKRaVH36bvOhrWB5aSKOdReJ5mxex/8rMNhQxmsotx6wdrwkMtE+rQHfl4KGbJxE9sIQHTnOCjj151jJ4w0HiGyUYVVzzTAFNSEPGRwRDPcmyCJ/P17w0DZiLWFcvw2ZTZKXwPLr+1uwXJWG/I5Fj8dQWvpTjxlQkigGDA03mfqeA3Hwc8F8khwwj4ik/TyvRPXiUXRVLeX+X4KOa/Ol8VBkB1/uwSDD7G/cjXfR8f2r0n5fY+d2u7kNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(46966006)(40470700004)(478600001)(36756003)(70586007)(4326008)(7696005)(82310400005)(70206006)(54906003)(316002)(41300700001)(8936002)(5660300002)(8676002)(6666004)(2906002)(110136005)(2616005)(336012)(1076003)(26005)(47076005)(16526019)(186003)(426003)(83380400001)(356005)(40480700001)(86362001)(40460700003)(36860700001)(82740400003)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 06:24:13.7299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e969928-cefd-4725-10f2-08da8be296f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4868
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

Reviewed-by: Huang Rui <ray.huang@amd.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9ac75c1cde9c..9cf7bc162e7c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -31,19 +31,15 @@
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
 #include <asm/processor.h>
-#include <asm/cpufeature.h>
-#include <asm/cpu_device_id.h>
 #include "amd-pstate-trace.h"
 
 #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
-- 
2.34.1

