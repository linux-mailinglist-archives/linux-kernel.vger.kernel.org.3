Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6086E539BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349424AbiFAD2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349328AbiFAD17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:27:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE019193E2;
        Tue, 31 May 2022 20:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIxsizeTR3pb4+TdsmHyPo3pSKxtz3z88QT4gDbzFcGbOcbCwoJFmdbsLBj2DFij+NIsQL/mC6z9g8hYLaEBNfWVGhJFb8Rm85iEvRNEb+yx5Na7V4HiCviQ6WIAwD2JZVFfgaKK8XxiRosL7dWNxugvVRfcdRTiluLM2pJFb9IwA7bX3/xEHwNtSSxevN68EBsjM+rTLRjOI7NjrNGNzBC++lgQ7/Zod60ZP/IzCfXKPPkyFn9S4FvqNN+PEgUeYZIfUHi/3Ry0CpAaZSLBekco16qVecRGdPCYxJTYJyN8FZ7DHRFT2pGqz+gtmiS0qXh7XCofey+DCXNpEJgpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkt/tynDsKaNxQoqRpnUZFfiCYS1vypKIPWHBe1XsPk=;
 b=bO0xW8jqKEv3SCa9YN+GIP53Ui4aN9/iWm59hSvE3/gq7VzbLxacOiCVIhpsl4M5tbmCCQc0bnGPhvWsQOkxwy3WFVCeqX+481+H8qgHE/t6nBmrLljg0VaGrlG19yfekeCrwkf3TD8VafVuV/d+x3GCRjw3V+8CjoxnT7MRBNZRps56HCkfwRpFQrrNkBI3qnmP0hgDE53RdTTkHwHlyspXYENZlQ6yjskKksKvMnuOEI63+zlBGDjQHnsebe5x7ZgaBCnqDB5mGmHFy00RpLGIEwXp4OswSR7RpY7Wd5H2YQvjlQ8en6BaLjd2fALEqaWxXJrOUOdQN5vbDKpuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkt/tynDsKaNxQoqRpnUZFfiCYS1vypKIPWHBe1XsPk=;
 b=Le8jorbaIKW1vvlDkuduDPSX9BjVnusCaEpHbI1f6Don/6zYl1kZPT+BD1DFL44R4RYdehG+BahhqEbMGkPTcZGG0kxy1t4UyJOiEYhbZodc2QFxHcYNWea2Qh6WgPjkunhvHiMb8HzYVoegwERb0bgO2FKgidExUB0tFlKimqA=
Received: from MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::34)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 03:27:56 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::21) by MW4P222CA0029.outlook.office365.com
 (2603:10b6:303:114::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 1 Jun 2022 03:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 03:27:55 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 22:27:42 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <kan.liang@linux.intel.com>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v5 3/8] perf headers: Pass "cpu" pmu name while printing caps
Date:   Wed, 1 Jun 2022 08:56:03 +0530
Message-ID: <20220601032608.1034-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601032608.1034-1-ravi.bangoria@amd.com>
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80f3d44c-0963-4938-f854-08da437eb7fd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4432:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4432A8F6F7DA260B4C7141D0E0DF9@SA0PR12MB4432.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/o/2V5XJFgGJ/JxVnhqDOrTbn1ng6RA+0YgglFMSVlEvmcBPLsXJ4ttfRooJb06VaDJmoDdYjtcgYQRwNE8B8p1Tyylt72NoKDr+88eUMicCEBTdC1SRUCO/W4rqV5bTogaGcvXh2Ljis+Dtirx39eIdbNfQFPqrCSr6t5bJ7RS8oKMYTM9zSmXU5shUA/rCymEHkfeT7s/YtyVXRr06qGzAZ3onNasaBT39bN8sUQ0RmCklb7/5NGbEMSZp0ZsgP5IswAkNWG6pEyG7gEWCn8lP2IJduvHzwk3rSitebc9dp5jnGEvnWvmd6nGDqn0YUlva5dEqOC9ql0F1qlQ1audIpFbqP2IdRa5Aejea1ikupYkK6+svz3ACZFKTCNF4RztVNYx0osuFgnz67wBnnYARoXnv8X1DwOTu4e9+NkSmCc1viQGqJYHbp4q1jGUjIOV4znaOnUN6Ai2VDRSv0v+XJ84LnPtYVARu0ZJDcxUO0QllK2/krK64D+OXp3j/m5RCYYiexj8yMbrmnJ2Dq/1WgUsCBDcQZg8vRtMYny7ou0WrZS4H56LO3zoJJ9y3di9AruDC+7eYeYdY6u9did9UJiq550+uyItB87wx6XQxYAvCiKooZrX7kE3nJYIjOK0s/Qi9J8tQLsLX9jBZdVHH61MxhvWxAQmV5jeomzSCSPGIgldwhFQEkjFszRXEZi+49k0m1I5FJRbxZOfjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(5660300002)(7416002)(82310400005)(36756003)(316002)(81166007)(2906002)(356005)(8936002)(44832011)(110136005)(54906003)(26005)(7696005)(508600001)(6666004)(4326008)(8676002)(70206006)(70586007)(2616005)(336012)(16526019)(83380400001)(426003)(1076003)(47076005)(40460700003)(186003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 03:27:55.5661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f3d44c-0963-4938-f854-08da437eb7fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid unnecessary conditional code to check if pmu name is NULL
or not by passing "cpu" pmu name to the printing function.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/header.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 53332da100e8..ee7ccd94e272 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2058,17 +2058,11 @@ static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char *cpu_pmu_caps,
 	char *str, buf[128];
 
 	if (!nr_caps) {
-		if (!pmu_name)
-			fprintf(fp, "# cpu pmu capabilities: not available\n");
-		else
-			fprintf(fp, "# %s pmu capabilities: not available\n", pmu_name);
+		fprintf(fp, "# %s pmu capabilities: not available\n", pmu_name);
 		return;
 	}
 
-	if (!pmu_name)
-		scnprintf(buf, sizeof(buf), "# cpu pmu capabilities: ");
-	else
-		scnprintf(buf, sizeof(buf), "# %s pmu capabilities: ", pmu_name);
+	scnprintf(buf, sizeof(buf), "# %s pmu capabilities: ", pmu_name);
 
 	delimiter = buf;
 
@@ -2085,7 +2079,7 @@ static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char *cpu_pmu_caps,
 static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
 {
 	print_per_cpu_pmu_caps(fp, ff->ph->env.nr_cpu_pmu_caps,
-			       ff->ph->env.cpu_pmu_caps, NULL);
+			       ff->ph->env.cpu_pmu_caps, (char *)"cpu");
 }
 
 static void print_hybrid_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
-- 
2.31.1

