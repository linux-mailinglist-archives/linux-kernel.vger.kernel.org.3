Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314F54DBA6D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357043AbiCPV6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiCPV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:58:36 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9053DE94;
        Wed, 16 Mar 2022 14:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TctkMs3iQU091V//03DjC9PV4b6wjXl3knpzQM5i16GX+AFTvvef14iRMVw9uNwAx2JErDTS26CisG7P3WFmqlmyjOGj0J5n9s21tbGq3JK48LtXG8mXHHIvQF4Rc39/Fr6q/TGHgm1Jbv6wb1WmfZqZAH+5JugHE0lUG1jqp89y9f756vBcl92Jyri886u5JCntsECISN0rayzpxVH6ZxvmX1w3gT6fKjC1XoJ7Y8LECrg6WE3lXo8RGPfOsifqBfcoWj/k74HPIKDUss/hcFRBLz3CSd6o6YiCncn6EwO/q8t60elrZwkgzCWnRpiJMZZNyKji1F8XiHuVO9NgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml5tMxBHG+g8Prcq+35jmqDJZefpolxnYAt78FIKCFk=;
 b=imL6t/aQ8OTz+m6AMeBmf2eVjhIdmfVEOx+xnjcsw7lANsYL4UegRUOGAwjMBefKQ+oJkENyeJrBr32uU2agyIzIg88/oL5Fsiyd0p5o4eXZ4JF0qtd7T//98spcwP37tot6K5zaFJe7i2IkkQwX9t433e1RvEyLIf+8ZoeqmAxn+x1n5gnegvck4wBr3o2hlfw2NyiY8LjcdExVf+8V2myGp76xHcCHKCJU2zESrQ6O39v0t474dncoekGnJ2BtMAh3hm0kicM/b+fuuBtJ4o4WQsU8LeV3vn3QnLoJeW6PvIlSZULKTN8PYkiY8D/lPyV5WjzhROtdwZEnK6jL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml5tMxBHG+g8Prcq+35jmqDJZefpolxnYAt78FIKCFk=;
 b=Q3RHus2Ffad04PD9SQ2dRjC72XEO6LeScZ3o/ZDZm5eJKdgpXrY7KNOtYBz1H0YO7oNO0aKpfTJL3HleerQN3HqJx1u1d44CepiXr+8lrGWsxvHQ3rAyVM+j6t1VSJCpkzDQrIRFDtq/Ep05FeUcq2RDlyP0IOrksTKJDkGBdsE=
Received: from DM6PR18CA0007.namprd18.prod.outlook.com (2603:10b6:5:15b::20)
 by CY4PR12MB1206.namprd12.prod.outlook.com (2603:10b6:903:3b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 21:57:19 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::d2) by DM6PR18CA0007.outlook.office365.com
 (2603:10b6:5:15b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Wed, 16 Mar 2022 21:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 21:57:18 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 16 Mar
 2022 16:57:15 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <Ray.Huang@amd.com>
Subject: [PATCH] cpufreq: powernow-k8: Re-order the init checks
Date:   Wed, 16 Mar 2022 16:55:48 -0500
Message-ID: <20220316215548.6013-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f09d0f6-5788-44ce-aa5e-08da0797f073
X-MS-TrafficTypeDiagnostic: CY4PR12MB1206:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1206869AE98070E772029C7EE2119@CY4PR12MB1206.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJlDkoDV5oCAU20yX+YRoX0tXt1zIQ1s5hT1RwUwL3etg/UkIovZ/7Jg63aJbPLxAyRTHGmQhdqhAP+CBI9trdYAIE/juDhEq8D3h7JgfHclJOebpw9SDmVzZ79gsI4+IpZHpa+lgjIxHmHFWi3g+X67YFua426M73RqFaPUlOVZWSUscMRDYgUfftXo4+RNBMNfOP/R6GvPMjt6K6JJB0GW6+nx4+Lmbl5zn2pO817bcGypUcmtxpYpv07aMZ/AqePpbiBqRKF5YfAIw6rYKJOufeOlAgPUheCwGBwWcR62UT1ywI1jG0JIiMl/teCsMvm8h2TXbn4tR5NVmIsd8zYFylMQgq3qxz6OG01tG9YCxyYKEsqDd1WMCVZYMIn7Z7liQvTK8LNJ02v7p3viEqFdpZAESqxP3zhfCgHVaEgi91q19vu4SPig2fsfUNv/ccunJOcdsoqInWkslegtJtaQcmrLqb7mXru6zKEKPWW8OLK9Bx7BY8Dy2ZuXQ7y4M85fWCkbqtpOPuV9QSn1ApKWOTQDON+ccSYi32uoIqTZLxCLfBzktkCXXq1XecrnuvBkscU95RAutvZhQcrZpsEBKDBZnBOU1cJhgc8LELqYNJv4HBSqIC7h0FQe2WXVYaKRHnOczMqQnD6uTOxOk2TajWtznkereTpoHqIZsj9NTSVLSl6ZrurTh9/CyVjYQELB2JnAFpBhg7mCqIqW0AicseKgxinvpc5kkL+7VdPVGEcqOxPMesoY+UtUiSaF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(5660300002)(336012)(426003)(2906002)(8936002)(508600001)(70206006)(36756003)(7696005)(47076005)(2616005)(8676002)(36860700001)(316002)(26005)(186003)(83380400001)(40460700003)(86362001)(44832011)(6666004)(356005)(4326008)(16526019)(81166007)(82310400004)(1076003)(110136005)(169823001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 21:57:18.0821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f09d0f6-5788-44ce-aa5e-08da0797f073
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1206
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The powernow-k8 driver will do checks at startup that the current
active driver is acpi-cpufreq and show a warning when they're not
expected.

Because of this the following warning comes up on systems that
support amd-pstate and compiled in both drivers:
`WTF driver: amd-pstate`

The systems that support powernow-k8 will not support amd-pstate,
so re-order the checks to validate the CPU model number first to
avoid this warning being displayed on modern SOCs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/powernow-k8.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 12ab4014af71..d289036beff2 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1172,14 +1172,14 @@ static int powernowk8_init(void)
 	unsigned int i, supported_cpus = 0;
 	int ret;
 
+	if (!x86_match_cpu(powernow_k8_ids))
+		return -ENODEV;
+
 	if (boot_cpu_has(X86_FEATURE_HW_PSTATE)) {
 		__request_acpi_cpufreq();
 		return -ENODEV;
 	}
 
-	if (!x86_match_cpu(powernow_k8_ids))
-		return -ENODEV;
-
 	cpus_read_lock();
 	for_each_online_cpu(i) {
 		smp_call_function_single(i, check_supported_cpu, &ret, 1);
-- 
2.34.1

