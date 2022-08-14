Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F52592592
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbiHNQtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243282AbiHNQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:48:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7A19F0D2;
        Sun, 14 Aug 2022 09:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFhscuqlJEt3aIUTDFPa6T3pxA10Nnn40IhNSLpNOqVuGrjyVcrTIH8/pTP2qtSB/hkZoLfwduacCkP24Kvdau2O0bj667PmPiOSELjtA/G0PgzZqa2AxW8UOm92ZE04CAHCqM6t+oVvWmBqBiEKH/vBVP27GXsM9BNF9KiRNqQlvH28tZObLYs1S78qVfScjQ8ObyTpKQA0SfYvpc+jj6nXMiwDfYajmd4AX9iE48VNpcxuC/Ul1gsLnZ//rIbuNBeM9PSG/LRZhgLSKAfNbs9IpqKuyc77zpfM9L19SCakL693hYH+NeRSBZKVR+o9gNVu2GAdWOxL58B2DvLeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqI6ibsnnowMxQI8rW9A5/Owk7pQgp7fZYXH3DTrxgw=;
 b=SoGzG9mDgqgfKry57G6UffqLIWztzDQrodABhRnpwcnKUsToRFewEvcKzJV6awlCQuD2qHpe5eZSQF5z+yCH4CgvVAI0TuNwChagpiFHfoe1HP9eWyunoasQpAxBSBF1wHT1jd0aY/NZXXHguOA/q8oMXumo8X4ZjFAXo3oretOqf1skXjmilmUv4p5KRCKnj5IFRpUc9PV5QXSc7IHugoHuCeUoA393RZnUdd1129IbbHR10sOPtEnyLanfre7zfB40aXRkwi1KORxHO1oFcQY5Ess7pyExOnHTbxT0BfhJk/eFlwk82rXbHlwLAPQJI1s/SFRY8vZHYd2yRbvBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqI6ibsnnowMxQI8rW9A5/Owk7pQgp7fZYXH3DTrxgw=;
 b=zwgFPQC/sxP9aztrl5+o1GVaMTpu/LuHF4FAw6hjdqTcQt3MjcswdnX2VxIcD0FOAwDHYVbNBl+uYrJ6zvczYwZBREPwjRp7KffDYDLXdfc8CCZbMzPgkxvgNOwoRIUkr/FqeHDYSvcUdWW+706WUqljmsAmKEjV3xmRBV5YG2w=
Received: from BN0PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:143::16)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sun, 14 Aug
 2022 16:38:02 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::b2) by BN0PR10CA0002.outlook.office365.com
 (2603:10b6:408:143::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Sun, 14 Aug 2022 16:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Sun, 14 Aug 2022 16:38:01 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 14 Aug
 2022 11:37:05 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v5 3/7] cpufreq: amd-pstate: fix white-space
Date:   Mon, 15 Aug 2022 00:35:44 +0800
Message-ID: <20220814163548.326686-4-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220814163548.326686-1-Perry.Yuan@amd.com>
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6782ebec-704f-4faf-d7d4-08da7e135aca
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwkljc0UBCunJvZC+6fgsWHPXldLzPDe0AKVaDCuoxktTbyXjL6lOUjkOgZVUHxgA+CYZjA7TwH06sFElqtHGL6pmvwc9eZf0+QuYy2H4jCwWNXRi95FhHlc6yAd4pJD8gqIYek/QdfOm6qIUgzgi1KDd1UraIHSNhY5ALP0BNRUsvQ0u3QdmuHn5uYPcGEdoyBJ9qUVLsoD1e6eNbbWMV5SXsMzHHtPqkhzJuDDRtHbKPvXS7d7ugWf+ZW9T1pxZq84HYo0Ssf8DJXYf6r+sD/lgT3iscsJu58s8+PDCh7USayP/8p4dupcAnw/sNQdIYnZQnOJgzdpzLflJ3ueBs9uVcTDT9NFeH0aIHb+tlsEwqFDzXUDUMmu1lwzFlH42M46P4sOOwQRxn0L3aavrC5/J2mhkQ1p4vVt///zUyxk3BQW8txeHJxQNpz1/3r2T96S4vbrR1wuf2ySsu98Zy/Ikd9lNuGJpYLubVoE9SvQ8J1qBFJgprVklcrV38GefkW2XMheT1uuldRtaTG+PCQTECLKr3pgHAV0VubmNST/EpFNXvpX+Y7+nkMOZQGGdoopnTmNnlnNjF1g14A/yeTLcha5jnZuL6Q34R3h3AY4uNSUkBNFIq6V0tS6vOr/Dw6/05Ct6X6EmytgCFEDL7fxpqYXUz5WOPYm0MS9SY/LwZvrBPnfONoLEJoi+mTcPnSfdzX+gRRpQMlQAxx/PIGwGSY0ZVul9y+p9uG/sP7jz9LLKvzrHsj3y0JA8G8jsCUxlk0t0NQyf1Zj2nKbYWp5c2zMRxuPNd0wKpvWVtgfJNAyRV1nIB3q5roGn9f2CmPkEHngbpcaDBY2eiKXhV9nH3UfI6DwNWNkT0lLtJM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(376002)(36840700001)(40470700004)(46966006)(26005)(426003)(186003)(16526019)(1076003)(2616005)(86362001)(82740400003)(40460700003)(356005)(336012)(83380400001)(81166007)(47076005)(4744005)(36860700001)(8936002)(5660300002)(82310400005)(2906002)(4326008)(70206006)(8676002)(70586007)(40480700001)(36756003)(316002)(6666004)(41300700001)(7696005)(478600001)(54906003)(110136005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 16:38:01.8442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6782ebec-704f-4faf-d7d4-08da7e135aca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the white space and correct mixed-up indentation

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b31bb5e6cefc..5cdef6638681 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -115,7 +115,7 @@ struct amd_cpudata {
 	struct amd_aperf_mperf cur;
 	struct amd_aperf_mperf prev;
 
-	u64 freq;
+	u64 	freq;
 	bool	boost_supported;
 };
 
@@ -651,7 +651,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
-	.attr           = amd_pstate_attr,
+	.attr		= amd_pstate_attr,
 };
 
 static int __init amd_pstate_init(void)
-- 
2.34.1

