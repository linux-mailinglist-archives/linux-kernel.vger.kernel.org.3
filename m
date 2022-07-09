Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33DE56C9F0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiGIOTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiGIOTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:19:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DD311461;
        Sat,  9 Jul 2022 07:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3nVk/CezOXIq/LyG1kWFt99394KI0cNVhIw9ilv8IX+/s2D8jH5f87b/4GImliS8576hXs2hkPzAINYsbLOqJOQISVNd7SbvS02sKNRmsUv5JYs5BTUYTuvuEC5IQCg157AH6WLEsCgGvqJ2BmYspLJ8L2w0uHBHIO/n+ZVU/acp+saIQRcoFHpJSj8ToGW6U9rjwSF+8agfsTShVIWDZTJD/ZCPelp7sg2pPXYMkzfUkaHxMmyD3LVzZ1rlLXsSu2tu/WRlgMASulgWm2e43c28zNylskhawZPEKFTjJE2vUOamnVOKcnsPDxNb/PNSm9xlCpqNx6Cppr+BLVOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWK8DtliHR9UBQ1cKClpmd1bDs5vvxvS+N0wtoP2JUY=;
 b=cmRlWn8yFpVO7tqoKUFIlTsEDedSzUd12+gFhF1Ee6N+A+EyydXbxiYrECBRlQsqMWrPe75lEbDF9S4v7AuDMuW9jjxzTyCwc7+D7a5vxzqobJ7qwzkp91TnldicgUxsCpd0DqMTttOU29e/4hWRqwb8+KOobhr1EueWVVCOq3jzPbVK4d6ab1EjJN33hzrHJQoEBzqdjepafA+bdwA2XEg7tNc1gG8xJo9zayBTjphxHt7Q7hGC/YiCXCFta7lJDrJ+5RE6LUjx4Xaae9AqTVrrrWEu7mSyUYdUcM1VUQYKiBL8nJrBNyBLB5Du2Rc2u5T7aURCp0+JG+lc8Phv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWK8DtliHR9UBQ1cKClpmd1bDs5vvxvS+N0wtoP2JUY=;
 b=zQKDofBDAYlfDdNgEn8kGwDD9brsUIIkrYDBcPhx5v/v2mBF7bWgPkmezcBGA63NbAoOOtS4mYbpSpVdPOagFC6qu2JTed+XkHf+FkvldEJ4R2BKyq89e077Hpu3h0JiOeRaCb1TsZLvBHfOFj5PRxJTwAMPihFe+Y8qejWZBrI=
Received: from DM6PR11CA0056.namprd11.prod.outlook.com (2603:10b6:5:14c::33)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sat, 9 Jul
 2022 14:19:14 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::b2) by DM6PR11CA0056.outlook.office365.com
 (2603:10b6:5:14c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Sat, 9 Jul 2022 14:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:19:14 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:19:10 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 07/14] cpufreq: amd_pstate: map desired perf into pstate scope for powersave governor
Date:   Sat, 9 Jul 2022 10:19:01 -0400
Message-ID: <20220709141901.835903-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 438235ca-0842-4b47-70f7-08da61b60097
X-MS-TrafficTypeDiagnostic: DM4PR12MB6325:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZTlph2myDdMeqYOUvgyXrg/kV/PHM5jUIz5IfEgi22B07Chhcbg9AnOSl2FgYqw4yPz3tdphB3whDHs+Z5DzYQoE3QO981np9hBS2/iUlKEeg15SJYebfs5SMagOJMYXtGvokwXWQR3EaxCXFm1v1DavF8XoJUaIqJ7IyOq7ZfTdulJlWs2xD+vIBCcmaAjuPSlTFMUeNuQdaEsMeT7aqb+GOyqKf2Z+c9D4dHU96tZSi9KylCVgc4hAeqhf+J1gYHKigPlY0FCArkYqU3hdSU14749owD6zRwdDiWOOSZoJX3uDMAynubjBJVvhKsmP6BGfCQ1FQaFA4JGIGlULTTQDLPGQb1YcGUofkLDVyK39BiqkjLtecqn8BQRLhl7aF04d3ocMB49GrHJHzSOHDAD41QjMxwHLt5xHUAQVVSHDf7/mAgeYvvxh0prI72m3OnpkIphyiTi/BC2piYvpRpkIu0mVAepBp8jyFNhafSYOtc9zPsDXyS8OfP6bjnee7uewswhT3E9fq5cbL8QV7NrA8xfV2bmTXo0lMk+IlFtk36daZKYcNWygPlwY8ivj2nmlj4yiUaczW4gwDnESpWKAFTLjI25DA/5at2xtXHWc38DDpYa0Co6NdIoQsPMqrqMUhNpI360IPqTF+vLqafBLSkwekKQtKi8py/6EUhT34ZetezXdnHo0Zt7cBswagmuv+TwzASx3qo4C6kUqg3CZGqgwVC5YAOUNVBFUXndWmwubZdE169i6xI/10WeRc2j5eSzFtKopM4Q6OOKR/e2iLoMeqGOCA6PTurdtopSIe40SA1/iArTNJ5RE+CxKesE5gUFxqKSSxhTuXOMFoCrI29B2hLXhM4E1dZh769c/LqM61E2qXgHJdhWjI98
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(40470700004)(36840700001)(110136005)(54906003)(86362001)(70586007)(316002)(6636002)(82310400005)(70206006)(8676002)(4326008)(26005)(16526019)(186003)(1076003)(426003)(336012)(47076005)(478600001)(82740400003)(356005)(40480700001)(81166007)(7696005)(40460700003)(41300700001)(6666004)(83380400001)(8936002)(5660300002)(36860700001)(34020700004)(4744005)(2906002)(36756003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:19:14.7276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 438235ca-0842-4b47-70f7-08da61b60097
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch will fix the invalid desired perf value for powersave
governor. This issue is found when testing on one AMD EPYC system, the
actual des_perf is smaller than the min_perf value, that is invalid
value. because the min_perf is the lowest_perf system can support in
idle state.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7c51f4125263..8a2b6ad9b8c0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -265,6 +265,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
 
+	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 	value &= ~AMD_CPPC_MIN_PERF(~0L);
 	value |= AMD_CPPC_MIN_PERF(min_perf);
 
-- 
2.25.1

