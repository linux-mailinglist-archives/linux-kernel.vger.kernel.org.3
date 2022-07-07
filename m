Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDB856A8F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiGGRBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiGGRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:01:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE0E2D1FD;
        Thu,  7 Jul 2022 10:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL5UG8RpLDRFXwIyn7RzyDpk/Rrz9X3XgLveEq8awmcFPq43yiMtxdYfgrUMbT8ROXNg0SQ/VAn44lvwa1F/tEDEHOyC41MOEz27KTR38aqVuNyxGf2TSCxQpyXnAqxqUl1aDkG5CCSoBAepZ3+xlomxt7hKG/GtejsNH9uaF64/ZMlho/mjwIp9RbseuabZujlzT2o0/zCdBkMzgLyfv4Mga4IL7szB98vQJYpYJD4TwhmVTLyH/u8K3C9C5H/K/B9WQ65qxO+rRiz1WnVrQss7yb9ycttQbNCSJwSgHNkiuqm+VkvM2XSZ7f531YfPcZ5IkJZPEjebVzdzSGooUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76W9lTSjv7/o2nz175WwEVMNGMz09Jm35bBwjGY82Fk=;
 b=VlmMYDETFec2WqJQKa07dj/eHthkQm90vqWUL5zkqg26Rz1msHpYIRB9i8rHo8noBK83g+xCywm+CQzop30VKnnRR70BsMROFpXbX79aB8JonqxuP06OlHOKlrkstUrGj3LM7Fspvfiw+wpGZoIxWLh0NP/yi8x/QrTDRSQVl41g+HSSu60l29irTPAHt8TYstpTat26VRkSgF8wrgmrDFO0TLFxsvxyWnTX+zxKB0mDZGBN9UWwALs6ZW3418Kd27BNHs7+XUN5+YazUi3jYzhrX9Z7EX+Pt3wUENXTviO49zaN8CS0/vNaKI4kfxpgeACb6kZ3rQufXmQ206fIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76W9lTSjv7/o2nz175WwEVMNGMz09Jm35bBwjGY82Fk=;
 b=usrrGrwo55H+n6BGNCOZ6W+SO8/VfoF3VVhFOictIjTx69y57S5VftAfmGOgqa8m1d+QdrhwRIk/jegNtmG1nV42J7zEKamEa5sELrAl0dUndHDzY8mXhZUTpmE3zYMny/e5qUde3m7STWl4Lu4gqM8uVleevz1bCNUoFX1/N4k=
Received: from MWHPR07CA0008.namprd07.prod.outlook.com (2603:10b6:300:116::18)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Thu, 7 Jul
 2022 17:01:29 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::9d) by MWHPR07CA0008.outlook.office365.com
 (2603:10b6:300:116::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Thu, 7 Jul 2022 17:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 17:01:29 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 12:01:25 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 11/12] cpufreq: amd-pstate: add ACPI disabled check
Date:   Thu, 7 Jul 2022 13:01:16 -0400
Message-ID: <20220707170116.216912-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2048675-e557-4a4d-9a8a-08da603a5644
X-MS-TrafficTypeDiagnostic: DS7PR12MB6045:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wy0uK61ddqlEnm8B0RHTPCRQ5CrtM4jVqlowdAxVeipc6v/xmPz1Fnw/d9kb4pTN3T60ks2ujLCtDiQAq3vmTP38bQ2C1XDaqpsSKVwu7ZJkuWwrmIwEnQHddkz8xBTBO6iRqN14B8KsuL948MKYvKvEKyKkBkom77f+cFb1WL9zZcvlrveyPJUmQb+S1E6DGWXTk9XrAj+ZFnz9KVIyD9+ffsXfurm1s4yEoHRFNAa6UuhrRE5pws5VYVSBbtuXNOlZGk8JOUDLqhsUsUcyn5VemLY+VodUYpE2/W33Ltc1Myq81dbO2ysTPlDn1STW8hvu08I941o0pToijbdVc3dIKZhsyoFEHQ0veRD93ZG3T4/RPdd69onNPMLU27tEqbLtPncyTBBhLZupfe1Q0/mdRHfGMAw+Id5niIHapEQCzqUAm82sgPJ4YtNsdufy73IfQyhiSXi/tMMLA9lgaUvp8/bAqnKuZEaqg/G1Cxd+9NxBNPzXI/r+X0Ml1kB3ug3Pr261UO+npKJu41rITuBcaF1086AiIe7WnXgaIN0Q0sOCsmuTgvVBbc7+jP10Mp/l5OYiIDVQGKTBEkS6bK0axsFcE9YVagWeWlV2uOdD2RIfbJrhlo/qkkeA7PLL0hfvsit8A5kWu3QfOvH5cqymHq1c/GRnzD/uGl6ebSRVdx4027F03pdI5yk7MpUMQlFh35d+szI/qIDRG0p0eK7819YYceTUtlHZdwAcMj3wmqI2/OrZ//OhCggOy0rxy979D2bBarezGvnODWXZi4gphI9RmvHFzXvFRoNV/SK1TB6BLPSGl2uwCj55foSax9CNfDh1shAR6OlPqhAeEyQPglan+EdvrVK5J49GkTfJh8Tm8Hjb9aYgcQev7dFw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(40470700004)(36840700001)(46966006)(2616005)(186003)(83380400001)(110136005)(40480700001)(16526019)(426003)(54906003)(1076003)(47076005)(316002)(8676002)(82310400005)(336012)(70206006)(36756003)(70586007)(4326008)(478600001)(7696005)(86362001)(40460700003)(81166007)(82740400003)(8936002)(5660300002)(34020700004)(26005)(356005)(36860700001)(2906002)(41300700001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 17:01:29.6334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2048675-e557-4a4d-9a8a-08da603a5644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add acpi function check in case ACPI is not enabled, that will cause
pstate driver failed to call cppc acpi to change perf or update epp
value for shared memory solution processors.

When CPPC is invalid, warning log will be needed to be printed to tell
user what is wrong.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c     | 3 +++
 drivers/cpufreq/amd-pstate.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 6ff1901d7d43..17d67e3ededf 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -424,6 +424,9 @@ bool acpi_cpc_valid(void)
 	struct cpc_desc *cpc_ptr;
 	int cpu;
 
+	if (acpi_disabled)
+		return false;
+
 	for_each_present_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		if (!cpc_ptr)
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b54b3b559993..6d81a9a94dde 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -684,7 +684,7 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 
 	if (!acpi_cpc_valid()) {
-		pr_debug("the _CPC object is not present in SBIOS\n");
+		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
 		return -ENODEV;
 	}
 
-- 
2.25.1

