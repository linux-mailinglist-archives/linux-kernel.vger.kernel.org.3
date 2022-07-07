Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD41356A8ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbiGGRBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiGGRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:01:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179352D1FD;
        Thu,  7 Jul 2022 10:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/Oe8WS+N2/4CL0KhYcdp8qICwj//lol/GNi/iOcfD0Pf54U6zDMcPm5qDpC0ugXChjvRj8IFLDKfLcg9x3nmGHsLWMzE53vHBZUEHfQljlGY3wJcKN5MYRqhV1oFnLz/09gIuhmJLOAh7FvTX597T0aP5FpPokNRskRF/zNr6ph59Hj8Msz02YkykxlBGT9F9MGRd8yi/zI7aVU9GNsuFtyo97z5sqp93I9Org7HTyCuYXVweLQya4ihB9WGm7vJcwO16Nobij+OuALyJgS6BQH6lwkhsq7R41GWv3htEYdA/6FM79ulc1wEKyt/U/0bu7QKtFkrFvU89gY1+5vNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOGwb6iQgiXC8uiymK3fzM35IAUzd3gvT64eOJo+5AM=;
 b=h/FXyjSkVYXfCgu//C2iWeNNp4/X5us32Ko5RfZLoExR0/vK5MtmJJGTo6aro7z2UeNlUX3ZDEjtpyZ4zJ9KDbfl5xF4PlzO65jtEtpKyCzI8rBGiWbUmz39LunBTW0gMd9mZdM2N5vUtJqxRfIJ2xWtBPru48uZsxqrd29eyDyQp7hBcNgn+05fVqcNdwNmPKfzSETCSU7wxprITyIbkTHK+cPQ0YT0tn49Krg6GcFrCOh5Y3X5qiGnsQ0l00h9WlOGludaoqe5y60DIAg10vNV3gXXeu+CNPIOE2awXLc74XIGCNt5H6GlwtfshZdsdXs01fSN/swb+jHqzr9lSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOGwb6iQgiXC8uiymK3fzM35IAUzd3gvT64eOJo+5AM=;
 b=VGn+uNYMYG+3SPFgvGhqx05aIhyCYIfYflkH4puXggY/0mY62j9nPXQXHLEmXxNyhINR0MiGGERZ8XGJAi3od9krMDY/g11CLvF1etLAY1vmfSxIDyFLAdazIghI5Pf+kwfVxsxm0ShqdRWlfaZOlfuTrt+0QQ+gGmA8SzXS9Pk=
Received: from BN9PR03CA0672.namprd03.prod.outlook.com (2603:10b6:408:10e::17)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 17:01:16 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::8f) by BN9PR03CA0672.outlook.office365.com
 (2603:10b6:408:10e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Thu, 7 Jul 2022 17:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 17:01:16 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 12:01:12 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 10/12] cpufreq: cpufreq: export cpufreq cpu release and acquire
Date:   Thu, 7 Jul 2022 13:01:03 -0400
Message-ID: <20220707170103.216736-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 894ef29c-ca37-4a39-ad7b-08da603a4e2c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5spTVkHjyYN4ZU9Y2nAQwlAKLYCtDQVR6dHCtZQFOJSiuEBoFesWbdfEROt13T+lYfFjnZrFnKjbKQyMhf+AZpZvvwE4bOE8OOMzkm1gXNaHPa+hyexBfsOZCmrIggcp+xE3NzetwcaawPYyFDfb1GBGl4DtawY3JOrCh+WaoYmZfpAblK1I15vpZPFPabbzQv8n3gMV0yfuyLjR3P6tUbCPJUC3qo9sHUutY6lUXY/xg7l/jIwX8qFeAFTp+KwZvs9MKlTXwbXAUor3AepVMxhLSBLtnwLOi9XK5N6szNA/cgLYxXUreN8uB2Z0gcmbij08e2HKINlIplIJXjRzmQ0uh+ao3AwyH5LdoFqHh07tYCWUVvngSQUM5O90bWgCJRAhbQ4VFzEY5KVsTOqNp+ZzPqP7PTTbbz2ov+5/YBigmFWIDQBwB09ef7ZF3IJpOfnvu4ss+poo9QQ9HF1nwNzjYKpddXyh738CA8u054SpL37Io6c+GNTNw+SMAgsK3ouzkeId9wv65eDusqje4BK77d7up/vq5Qjl2zmjEJB0zOtzo3fC5i/r2ZkWOt37r2Lzm6MNxSgmcifq+4YiovbDv7b2b7tirY/KSXYcePj8ddZ/DhCK1qk4SINUs9ZRs5Pg9oPLRw3HArCPL4vdrVJwH2FOV8dv8cw7c3a4cJK6f2G0gJciOwXvuB06x4l9p8o5xZk1C+zD2x0Z4OkfdFJT8BW2CBMrUS5D56oWI9JFimt0MIOxM0MZAjbLgaJidAjXL5Q4ADlgE25bjz/DyCJpobGwFtiR9blQlnnAbgyDcDbuAKc+Xq9GuU238K+TnEZxXSwLSqDWeDFoOpbZKmjPzY88Locdgx1+367dmYIoNMrRvichp+DPP7lgqOpu
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(40470700004)(46966006)(41300700001)(1076003)(40480700001)(54906003)(36860700001)(6666004)(34020700004)(2616005)(82310400005)(36756003)(316002)(2906002)(7696005)(4326008)(70206006)(110136005)(478600001)(86362001)(82740400003)(5660300002)(83380400001)(426003)(186003)(8676002)(70586007)(336012)(47076005)(16526019)(26005)(356005)(8936002)(4744005)(81166007)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 17:01:16.1485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 894ef29c-ca37-4a39-ad7b-08da603a4e2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq_cpu_release" and "cpufreq_cpu_acquire" are only used internally by
drivers/cpufreq/cpufreq.c currently.
Export them so that other drivers such as the AMD P-state driver can use them as well.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 73432360e6e9..4d3c83da29b7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -262,6 +262,7 @@ void cpufreq_cpu_release(struct cpufreq_policy *policy)
 
 	cpufreq_cpu_put(policy);
 }
+EXPORT_SYMBOL_GPL(cpufreq_cpu_release);
 
 /**
  * cpufreq_cpu_acquire - Find policy for a CPU, mark it as busy and lock it.
@@ -291,6 +292,7 @@ struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu)
 
 	return policy;
 }
+EXPORT_SYMBOL_GPL(cpufreq_cpu_acquire);
 
 /*********************************************************************
  *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
-- 
2.25.1

