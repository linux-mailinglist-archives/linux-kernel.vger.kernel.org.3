Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227B653D593
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350564AbiFDErU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243476AbiFDErE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:47:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B05F96;
        Fri,  3 Jun 2022 21:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2GmZnRC/wdkAQK3Qq7oT+PXKuTJ4oeeKukpEszeztIOfIiLFywR9atTYF0Ma6ZkQ7Ej6q0J5hTOQ2Ez46GNgD1qRUmPYBYmaaq0SCnbCYOKcOamiQWAHU4m/YTniKWaiI6HXjQEnVCiUYV7CesLCCXizKtnMkAPENHFbrMLFVHBJjwrxisqyWZI6RoYuhCZ+7EdFBsF9Vw5ISQj5veXFpBs6WgHbmfdQmt9DgKXSEZmNuHNkSECkR8xCBNjNjxmi4MIhc8uSNHWubv4Z6rYEoyKrbRDrCMoCsRWsWd6nkWUCSZzq2erxHGH8Mp/30jvhNT6xoQFEohN8KvM5mt75w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amvyUMxva0+w/ZyK1icK4hFjU3FTlT0cdfQKQyrwyGk=;
 b=XxqxbAaA1CrlPUutyal9CjW6r963qw3nnqo+gH0Vm7hBc3Ux/46I+Wqf27v7iQHW9CaTByfDvip2PjNaAUZu/HLayjoGY1JoRWzDOEEkmtvYM9H2WG9hCBg052I8CSV2kw6fL+ElLAl4eeQSHJjuj5OXjW5b8P/3iLFe5iFPtoyNwEN1epdBeJwl1vai6LVSs0jAB712aUGuc/BQbj1ehwu7GtmPEG17KccV+fRgKg5qrUHSXaVnKmUhF6OEuxsGaMr5clGoCnewCLTNI2DYbdV5bQ1933OkQhG+MTmoJqEZfkNeUzuNttG2daQTQZSKH7zZLTSZnNhKrXakQ7cRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amvyUMxva0+w/ZyK1icK4hFjU3FTlT0cdfQKQyrwyGk=;
 b=Vk1W+0yMrbKnQuu6GSssZDSB5McNeosNs/QTigl5PwauVbZzDE0N8Blehl/hRoFWOBLUC8XpjUzbAdbPeyRxsXgfLvZIaFwW+z+wIuEqpd6yBKyHZ3RMLctT1P6R9Lf/Q36tSQBy5s/X89lBsrSLYXLsytkkBwAJKtvm6oeqxEo=
Received: from BN1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:408:e2::8)
 by DM4PR12MB5309.namprd12.prod.outlook.com (2603:10b6:5:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Sat, 4 Jun
 2022 04:47:00 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::8f) by BN1PR13CA0003.outlook.office365.com
 (2603:10b6:408:e2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.7 via Frontend
 Transport; Sat, 4 Jun 2022 04:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Sat, 4 Jun 2022 04:47:00 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 23:46:47 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <kan.liang@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <james.clark@arm.com>, <leo.yan@linaro.org>, <ak@linux.intel.com>,
        <eranian@google.com>, <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v6 3/8] perf headers: Pass "cpu" pmu name while printing caps
Date:   Sat, 4 Jun 2022 10:15:14 +0530
Message-ID: <20220604044519.594-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604044519.594-1-ravi.bangoria@amd.com>
References: <20220604044519.594-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fff4ced-d6a8-44cf-9b34-08da45e54334
X-MS-TrafficTypeDiagnostic: DM4PR12MB5309:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB530960EA8CA47701FD4D9735E0A09@DM4PR12MB5309.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzvekSdF4ZiQKrlXYs0p4Cv5FKJ9dqYzJwhC18aZlzF6oforHMimNfFF9kc4L8/nQPB5IpFsQ462bCKH4QJ0ASnCWdQK54tGrrFYdq3SdcMKOaBXPn530XQjguoMtY1NW52B/9kqDAD6YYJXi/E2IqTsPh1uW3aaP8lkHk5qTUHtCrtxwwMbGMDpr4MQ58TIeT5J1o0j7wChuIxUa5pAiFDQzFsORwwLwmG1B7t9lXj3wdCuK57JhUFLGTLDj9UVEGzT4IpCaOxthJUVqtnq8+PsdMjxxyjMYLsRt81KFOLPlR8ZIMYiIfuIj6xup9ZbLa3Bs3/Sqg0qmpUotKWr0qnJVRounKVhlWxfvDtU8zx3dM5poxZL9xk/myKmlgoC6FhT4BuMxHwvzZNaBF+9tNmy2cmosEOy+B3MmexNsOq2nzUlUG1eFUHXuh1R+4kshg8edu2ab6/RIW789uRMLI/Qw0agSsypo/2tcmWdsra6CfqP4sqQy8rbIQUJNM7MnvbpcUQUkYHi00Dj8g8UEXB9KHCryYah1bseW/C1J7Xjf04tsG+V0Fn/rSDUfKuwkrYh4qX7hO27zbDRDLa2La9tPyUgu71HbZhQPquK8xLPHuLs5krFHWXYDYhd7FFaf6o5PZzJFTFrLt6OLAGNzyFpDZXLTTgc6nHIz7IannEhJL2Htdk2q2fFnvQWp8e8GHZQUMqxTispa2JAlBdAcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(336012)(186003)(16526019)(426003)(44832011)(4326008)(40460700003)(1076003)(8676002)(8936002)(7416002)(6666004)(83380400001)(508600001)(81166007)(7696005)(5660300002)(316002)(47076005)(356005)(36756003)(36860700001)(6916009)(26005)(54906003)(2616005)(70206006)(70586007)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2022 04:47:00.2913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fff4ced-d6a8-44cf-9b34-08da45e54334
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5309
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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

