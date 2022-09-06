Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745F45ADD8F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiIFCtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiIFCtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:49:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C56BD48;
        Mon,  5 Sep 2022 19:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHg3aRVYR6y9Bhji8SeIucscqOlRAtzu+XXt0qbxwqIp3atC7Ol+TFcxvVMNcLllwhWAJ9LiTaHxq4gafD52f9agNSnF7OoqOCmbNKRFoZTU0xISQ/sFh137dAlOZl7GJZZBVUjUq6gQUejB8OdFupZPFoAjRoBOqdZ/Oly1FJuYqJHv86h5MLQO4BcpIAuStG6+voW1MnqOfqP2vLABlWPVbejdYI5r10ppgW0JQLiCCnZoOBelO7OZyNGvT27HAOq7UQRPAiprzdJlXAlf2t40G3vrIjKt0i/kP74g46pnYxK9fUH/T6ZwyzIG+agIHMInJSv9D7782AWHzxL/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CrBC10jwm86GbkWjGEJA2So7o/1u90HqmQoHfUurPg=;
 b=PV8polWYtGGyEdTpc26NDAtMVOZ4ekag1C9O78DULIxZL9kFq0p0Wc9mus0b29c7FbD+Z8RPDwNGreERdMxzl/v5gp3UdTGd06qtd1IYY9N8Nm5jP5D9Wn3ASLMYy0SqmrF9MtMMpsnnCtmT5KXgWGINIOwFwhjpwz1UTBuIoPy9z3P84bu7b2FBCGU5NArZ0ADggDYauXaiSyWEM3fovxtLcl2IIAmkcrU02KnB1t3bYWZ2C/QQlHQphDjdHkuC7rJK7TIYaQzrrpF3kGbFpUygpDrOcenA4lvZbtTATrQFQ0R4DKZAgtpUVU8Te/yP5Iva1iHcP/CmrJU3zTVOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CrBC10jwm86GbkWjGEJA2So7o/1u90HqmQoHfUurPg=;
 b=OWxg4ev/hJTYrqEq7gcy6TG4ppzo4+cIhZD9MS2Xv3F0M/2T8btEJ4WVnQmVBvzCax29GusndCrAG6fthfELnBgcoB9KJH9wE0tD1nky5WfQmLB/kYffMCZ0qS8RBIqmJD1ALaBgX1GiewDr9cScNFa1gH2y4vCbOarwkiO2rCM=
Received: from MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 02:49:11 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::55) by MW4P222CA0007.outlook.office365.com
 (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18 via Frontend
 Transport; Tue, 6 Sep 2022 02:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 02:49:10 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 5 Sep
 2022 21:49:05 -0500
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
        Meng Li <li.meng@amd.com>, kernel test robot <lkp@intel.com>
Subject: [Patch] cpufreq: amd-pstate: modify type in argument 2 for filp_open
Date:   Tue, 6 Sep 2022 10:48:26 +0800
Message-ID: <20220906024826.1560949-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44f48535-55fb-45db-3537-08da8fb25fef
X-MS-TrafficTypeDiagnostic: BN9PR12MB5337:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcIRKyK8EnmLb6wyys8Whz9kOyy1XHN0XBJOOK5m/8UzNELS7CyB69fwiCMWtnDJI8hYCzT3wsgzjGvSBIXtfnaDc0xF0zCzeKTts3zrVVhGixGkC9Y+IOsRURMiev+OwR6eh5Yf7I5APJF64Ylb2NH2Og1IQt4tqRve/vNuWkx79/mPsDoNVQodFDJdvdHI6Vn2a2gKjqnvnj0ubY4PJ1c4KaYCb8tLjinvnMDyymEPgUr3+/IKDbNrbtaZpJpuy/AdFjWsqEovV5ASz/j5yrsWDycigzDehs7vjq4fuciWMvXJmfGYUFGf9x8qLEJnuFysJLmfpn52yfjp0SknVp4ROiCI1Q4nLLp/zIAoUTykJlR55pOWMBBPsX6OXWbrUDCc5ObYMvIjE0B0oTbMX1vhhvvTYLbkNd/6878HVZA/1bkCT4vGOIy7vDAduK0jbh+xCNakc3/p9b41bYYwR1UB2eMWF0tlfkbAual9W5cCAYhMRslArooQFwQnT4ha1KGPZBWojV7YnyDnhLzSUgcRZa/UHAujgPvuLhw1jSyIJnX3rHwrGuCkC28va/+geh+JSfQibMq7zZ19cR8uNg+MYP/BtEmR1To9K2Axxozz5g6/6hZlGp7PhMuPGLE4FqvvUMozaYLHS1MVcni7PpbCs9tqHgPfeO/tR/Wwg5hwM30x9XZjCE/dEnivvm/kM0TXMhSDN1tsgkiT6erg3cQLQzE6Lv4H4HIO8M7hLxhudecrFU1Af1cXwU6CySTLCerI/U4qcMkQnwOX4c4jNHf66ikJfn/VOdEP1xskntwElOnTJ5tCpdsBtuoEBOEC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(40470700004)(46966006)(36840700001)(26005)(2906002)(70206006)(8936002)(186003)(4326008)(6666004)(1076003)(86362001)(8676002)(41300700001)(478600001)(336012)(426003)(7696005)(70586007)(2616005)(47076005)(40460700003)(83380400001)(16526019)(36756003)(81166007)(356005)(82310400005)(40480700001)(316002)(5660300002)(36860700001)(82740400003)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 02:49:10.0934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f48535-55fb-45db-3537-08da8fb25fef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify restricted FMODE_PREAD to experted int O_RDONLY to
fix the sparse warnings below:
sparse warnings: (new ones prefixed by >>)
>> drivers/cpufreq/amd-pstate-ut.c:74:40: sparse: sparse: incorrect type
>> in argument 2 (different base types) @@     expected int @@     got
>> restricted fmode_t [usertype] @@
   drivers/cpufreq/amd-pstate-ut.c:74:40: sparse:     expected int
   drivers/cpufreq/amd-pstate-ut.c:74:40: sparse:     got restricted
fmode_t [usertype]

Signed-off-by: Meng Li <li.meng@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 3947b7138184..e4a5b4d90f83 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -71,7 +71,7 @@ static bool get_shared_mem(void)
 	ssize_t ret;
 
 	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
-		filp = filp_open(path, FMODE_PREAD, 0);
+		filp = filp_open(path, O_RDONLY, 0);
 		if (IS_ERR(filp))
 			pr_err("%s unable to open %s file!\n", __func__, path);
 		else {
-- 
2.34.1

