Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1826456C9F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGIOUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiGIOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:19:56 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7093511C39;
        Sat,  9 Jul 2022 07:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1lWwrUoU5AKk7zX0BvZc89CRsFK7nyn3jGv+YvLgySaFjlDBywkpK1HYCvFRxpbxMmnzsXrIyhr2BtJ8a/NmcmG9BTldJR8D+lC/9wQDEkdr+MGLUUb0TsJeg9T2UTtq4YA6Yga0289ezVgVFDEYFP4Gkk4uMUlj5njdmLFiTtbsnY828ocROMiSLjr3Vnb1s5Kt31TH72qVlDTDVSz53XDOwkCIujyrhfYHSKCKEHKvjKi7tic43Yc9VUolv+R1Nc2F4jUwYg23psw1STMas4lyZ/SCD/8wCe9k7y2U1wzlcLm72Q9bU77dshO8XPTr79haWoin8SJGilDV620sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG324AAWuhIoRQ8IkoyGEW7b8eSQwCgehffpgyPmtO8=;
 b=jKknU7fJ00a5YWkvkNphwC1zzzdMkKSpH4u2jwzNuSDvzIGtxF3NxNtMBsFfe8CDkOELgHG6lRoqtxme1uU4AbZSky8N0djSS4CnWWYE49SeU/TRRYWHEaLI843PnJNWSJa77LbvNorRJyKc4DW3ABja4p5n+phsl5/Q2gVGowcaPDD0UMfOVBJdVEm4stHNOjMmmKTNLVsUcREi9C6EUpdD1DdkcK4Z8JBJo3Th+PS6FnKduHaUGquJ9Jv/NukDyUGApo/8zZuXiq9LJPgh93nIXzj33TvGfhz5Zf/9cujE2tsFIeyv3U9kItKEmGTgq7dw1tujObDpEwjsUxJxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG324AAWuhIoRQ8IkoyGEW7b8eSQwCgehffpgyPmtO8=;
 b=PBU1xDl7/rkOJ+fWVEuA8uKQ9r5gMAcpqFYSMZFFWzO4J0ee0aMgOMTo9MVxWQFLMdQTK7ILKdP6DcrV1hhfLs0tj6krxrRksiRMrk58Vzq2xXSRlkJHJv8Zr3PTIl9pwCy1X8Idh1mK9vFu896G+0EH+C/iwHtoGW0tTLUSazg=
Received: from BN0PR04CA0099.namprd04.prod.outlook.com (2603:10b6:408:ec::14)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sat, 9 Jul
 2022 14:19:53 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::48) by BN0PR04CA0099.outlook.office365.com
 (2603:10b6:408:ec::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Sat, 9 Jul 2022 14:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:19:53 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:19:49 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 10/14] cpufreq: cpufreq: export cpufreq cpu release and acquire
Date:   Sat, 9 Jul 2022 10:19:40 -0400
Message-ID: <20220709141940.836412-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37940160-bddf-4c91-1257-08da61b6176a
X-MS-TrafficTypeDiagnostic: MW5PR12MB5681:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3sxHa7heOmo/xDlXPZh0lii5yn371vXL72aMtWCJfAXoIg+8FKewLuXsBZ/KgGoJ+OpsR5ndGLOCGovG05n3Fv8lk6BJKbk2Nxyc33clQjmBgHtg9EXwPalkjAnl8OLlKDlvgavbvJ3iWeraTrXrAC2c+xo3n/VB84lVjv8eQiSMdmyNhkx8iQ4KmhttC41CIMn+DhQE8xIXeEIAw95sYQnQkcfDROqsFU+e1tJdRIXE4eqcMH7IhmYiWgplliGgzEoGkazuofFnqRoRcNccv7VA7WF45FnfM/da/3/OUvQ/eJpmDFgOXPH8GVnpVz/Zru/HyEXXuXyv3wC1tn3lasuK+hbrXe2NWS2QfVH7vKUjNTbV5SGRTuZirr/COKL6zomHHyqKyUXNzr39bgQ975NyjOpyiQw6wBSGvZ9v3n4GtOQ3ku4M7QanA54c+pP0u+TYpOTb7u0qu2dYgye8gXOLqngycLmVZOFyyeFXa7TNae91S66qiD2SiGS1Z5BArTe4v+w+h4cumy9ZGQBFYidUfDkpvk25Z+nk01+bzzFVqCcmsGFaOkRlsccu5lSO6y7KeQ9Ehr817ybwaBERBjOyPvStccjl8j07uyFLkf0VV2k3GRtMNSniMpGk37E2vFkDxfyzJWmm5UByskIUHfjbAF5J+o22bQvH0LGsUcmbi583RFi3RKBf1YpGcaf6AwcrKS8GEYhL+VS7Vzt+VAqPhrf1pgpF2Lz+8frS/EhnoGjM7tdUPBBEnBnJtwG6eK8BfSL4BQ2ZzYvstUckoCFcVBANh7sh5sSltzkjPm0EN8ztGNbV0FLXm58ukXGq1Jkqo49p07zKKqfAeksJmTNPdwWd6kI3NZQv43JAdDxTvvnNGtM3C+rgODSO0AdV
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(40470700004)(36840700001)(81166007)(86362001)(82740400003)(356005)(36860700001)(34020700004)(4326008)(8676002)(82310400005)(40460700003)(70206006)(70586007)(2906002)(4744005)(5660300002)(2616005)(1076003)(26005)(8936002)(40480700001)(16526019)(186003)(426003)(336012)(47076005)(83380400001)(7696005)(54906003)(6636002)(110136005)(316002)(478600001)(41300700001)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:19:53.0178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37940160-bddf-4c91-1257-08da61b6176a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"cpufreq_cpu_release" and "cpufreq_cpu_acquire" are only used internally by
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

