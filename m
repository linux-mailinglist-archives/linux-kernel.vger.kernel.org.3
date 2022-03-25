Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA06C4E6DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358373AbiCYFnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354788AbiCYFnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:43:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F964C55B8;
        Thu, 24 Mar 2022 22:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OewItdXDxv5G/o1H4B44idny6TCTzzsqdC0e1DmUfGYxQ2aKPbHgvQP3tyVhMtvZr8T/9cIhwgS1VWURIz5F0Rb3LYXDqKQWRrMA9fQBMA2DgkGT0yHCu6JZFh0xWY7kVyxIJeyOuoWApwamy5L3PGXv3ncfC8xKF6m2VcYvREPUEEplg/xCZ5SSDyQp3Xq+jU5g1nlU8gdd0LJ8GVPA52sT6ijSTssMh1zPx99mQUq3ljsRrtRV1/17MLInBu1Eed7i65XZeVu5EXOP41YR4K79hlztu3lpLk5mXyQ57RyUb7cK75cn81XVIBc0uRmsBhmYJzvKwIZ4NxnKxGRf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fonkNK680iAi+GbGOhyZSme2CTU0cqXpqINleBRPXGg=;
 b=F+LFT8ueiVjRFZwAge3iwLjjE55AIec+AAfPUOlqjF1EvDvE9C+1QUieV8oS6s0Vijwhtj/ek3QUrklPplAXbthBhhJexbIW9ytI9fKQjoY5pLFL3c9qCgfA8zk8nTevilh4LNssMrMqASpVYmfpJSu2HSobTV8xu1rOPwepB4H1puM2MTjQPihekAt1UXVCY11eU7jnU+Y2nFWQDoy9AcMrsN1kfCY/HvPB98LbD5nQ6f2mueBb1T6yxwAxNtTa5YYAA5aFswqqy8I+o1bIfz4ZpeQxK8H/x4D08ZmZ+JP2+haWbxpm/i4GwXFcZ7SUNqOxB5ljMeBHU9/2srsgNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fonkNK680iAi+GbGOhyZSme2CTU0cqXpqINleBRPXGg=;
 b=YFF0BnY95KA6DIbYrFW5OOlaXZVoa0/Wne7sHbwjbvCXrBuZs+3IZueKCKgxr2jYSrjdwK3b75s3xtFwLRk8H5/RG627qFp7PIcjvdZNhgGJnWjCLG6SrXLDd+fsAsaArgUxp0wFppaTYJwWJuluWf+5QJpIiQSaPpiDFfBrn5M=
Received: from MW4PR04CA0101.namprd04.prod.outlook.com (2603:10b6:303:83::16)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 05:42:03 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::77) by MW4PR04CA0101.outlook.office365.com
 (2603:10b6:303:83::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 05:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 05:42:02 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 00:41:59 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/3] cpufreq: amd-pstate: Allow replacing existing cpufreq drivers when loaded
Date:   Fri, 25 Mar 2022 00:42:27 -0500
Message-ID: <20220325054228.5247-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325054228.5247-1-mario.limonciello@amd.com>
References: <20220325054228.5247-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e2dafe4-5dd9-4dec-5de2-08da0e223026
X-MS-TrafficTypeDiagnostic: CO6PR12MB5475:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54759B9F10847754C3662968E21A9@CO6PR12MB5475.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dMeXSpOWTDWjwlPZXrpgA/wyz30qWHp5MCMsl5uW3NWDQ3rKlhne7Qql2JAvAqX1uwipwrK7fna5XaGtLSmslUqKrMJbhfhy4ps3tkUID2KBbYpOgFMxXSZ2vt7QWE3xydst9p6efFpbck8tYordMCDzM4LWNoGUOCpA8oDuF/rWDrdfK02TbrJdtOybNxCVs+OBeyYrXdHnj4AkLPd8YSzZhX6cB+GC4VvupVDldDhPVwasD74n8tYcxEOrFjalF20MyjIzIntKVlJ6qIRbXTqaosZ0zfxDiRGSstjwzaI9JsjdQrfuLz+vjFnr/5cSjz9hKixEeObTQtg1xq7NCQUY/54Q+LTTjQSPis8sJheCOK/h7Xo+V1yigi/Yw52SQOjiAfNQ5taAsRo27wA5b6YyNHUs3DqO4udyZS/XQAx0RNvshD5GO/4Rt3uNYiCRcJDHZv0ztAI6W3nNeGEz+pA/IEVEdPu1pZkMAqHKqffD5BYqwA9AL/9lDXyRcJbo/AL/iko2PiR6xOhjZostDabtoAfvb1IAQv7TfFG3O2Xf4cs0fbxB85Yk2InsL5DsYLxY+cWa9/tgQDh4XaKn6ml7bKC6ClwsrdJbTYnHikijnp2I8hW5Bho/dlnUpSbbnG/+fEr17ncxS5u7Qg9d/5L/mj/7u/BcSBdM3LstdY3+d9qzlv9sXVVGT/KvocJLawjzzF1sozOlsQ0zhdTng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(40460700003)(70586007)(8936002)(2906002)(47076005)(356005)(2616005)(426003)(7696005)(36756003)(5660300002)(83380400001)(186003)(44832011)(26005)(16526019)(1076003)(4326008)(70206006)(508600001)(336012)(316002)(8676002)(36860700001)(86362001)(6666004)(82310400004)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 05:42:02.2563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2dafe4-5dd9-4dec-5de2-08da0e223026
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`amd-pstate` can be compiled as a module.  This however can be a
deficiency because `acpi-cpufreq` will be loaded earlier when compiled
into the kernel meaning `amd-pstate` doesn't get a chance.
`acpi-cpufreq` is also unable to be unloaded in this circumstance.

To better improve the usability of `amd-pstate` when compiled as a module,
add an optional module parameter that will force it to replace other
cpufreq drivers at startup.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9ce75ed11f8e..31a04e818195 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -63,6 +63,11 @@ module_param(shared_mem, bool, 0444);
 MODULE_PARM_DESC(shared_mem,
 		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
 
+static bool replace = false;
+module_param(replace, bool, 0444);
+MODULE_PARM_DESC(replace,
+		  "replace other cpufreq drivers upon init if necessary");
+
 static struct cpufreq_driver amd_pstate_driver;
 
 /**
@@ -598,9 +603,11 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 	}
 
-	/* don't keep reloading if cpufreq_driver exists */
-	if (cpufreq_get_current_driver())
-		return -EEXIST;
+	if (cpufreq_get_current_driver()) {
+		ret = replace ? cpufreq_unregister_driver(NULL) : -EEXIST;
+		if (ret)
+			return ret;
+	}
 
 	/* capability check */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
-- 
2.34.1

