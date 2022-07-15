Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34617575F11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiGOKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiGOKF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203E31DFA;
        Fri, 15 Jul 2022 03:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d75yc7YIlje7lw/RaH62nCFZVJlmfBHuhf0wc5AkmiYLfrvZzgpZJqsExXg7uCUia5u0WVj+c4gz+0+/N1WtoPIPEqkBNRX4EYnm/ROziTy+oAy72aLntP9ksdu7wKEmQrRHeJHJYhVws2hm3ssHxZg2EzU9V5AXHJl06jRL6bd/8OlPZf3Ph+lmMkdJjUaQXnIHOdC6Z82kjkYvLKsvgNxshJ2uB8aEdGBRj1i/MaV9ctWTcxNnJAIgm/LpThCHwmn6201z5DKR3Hr8YBzJ+AfOs5SKX09rOb0FtAXhn6QBHKAcY5y/8QNindWQO/E9Ugny/dcHY5rPHKf0N8QNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCpjWS95V7cNh099uTMhHdGGmu7BXkk3H8grHTVglIw=;
 b=lU5bp8+eZVY246ksyhBTJ7mpSY++UtGzrQk98ymPfERodPszj5hp4dzQ7I2KmeEXYqVUi2O9KZipNz5KIkMEzZZ5Y6uZuOsJ+xEXF5YtO5z9WKFd4ELcd+Xot4SpT6Wti2tWplUgCqchNbrgSuZTnraTYn5NMzlbx355eap8JwaId0FVp2/IjZz0TdCq7sDmY8xKairLK21oIrpC6kXQ/5v8R06jWcbgp+SFh6rcKx1vlKE/QqnsPcgmme4owVI84JkWeqf5vaJdKQdam+UUK9loprNIN/7neYSmOUJRIzGSTnnIpApLcHAYHT1HOxZnFuZr2/OlJCYO1CitJw2hPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCpjWS95V7cNh099uTMhHdGGmu7BXkk3H8grHTVglIw=;
 b=HN2Dq6dGLr7mL7kqCJGt+aL7hZ+yDnQ2nGYAPu4xBQFr4Gv73JQ8kdlempbz6xUBhV9ia1hTSqj7oz8t/M8LstM1/QHDxiWmk5GJjVIaK9MYG9psU8Anv5L6W0PFOW5wj7moY2XjEsjuUvYqmVmRgt7mzr8rrFxCwXfGP4XEwdg=
Received: from BN0PR04CA0152.namprd04.prod.outlook.com (2603:10b6:408:eb::7)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 10:05:24 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::19) by BN0PR04CA0152.outlook.office365.com
 (2603:10b6:408:eb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Fri, 15 Jul 2022 10:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:05:24 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:05:19 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 10/13] cpufreq: amd-pstate: add ACPI disabled check in acpi_cpc_valid()
Date:   Fri, 15 Jul 2022 06:04:29 -0400
Message-ID: <d79822156b59228de38163132335bad1065f718e.1657876961.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1657876961.git.Perry.Yuan@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edc285d5-146a-4879-9f17-08da664988e4
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kixG5VTtKQV8/SZiGdm9uvtKQp9Yca85INxCdb3J3iFK+dwyPR4U4LhxyhyxWLs3FqG1cmFTIq72zEAgvfSZenr2dWacX8YEDnHftkvylqrVU5jznyTgPdgf/3jqlcAO9xDPv04gSA+JVel6BH+SNKurYMEeLy1N92jLFED8z5HObrROMyMFRRu55uPXTwmh2kSOd1JqeBst0bJW5sFYSBf8s1mgCkTcM6MqB1rwqSjiDNXFg5fpVjPsEF+YYgoYX1dpIIywGLN5hysQvuvNBdZg8dbbU9PCqdgkbm3PQ97wLJyh2oRP4tzjW22nXHCS2U1bxQKZa8JEBK20iWb+v+1xz3+19MkjpraNDMpgPdonNfPtyNtWjcjU+zv4QCJ8Vn4bTkVeAyL4Nk2CbKrGZxscUIJC0kDVtfVjB879dtCdDMZH5CHvPSlz1sEHSaHJkCSuoEsIsZtjzCtfsTAToEcX49pS5nb5T0fVbhsI8A8lS5K2VN2JkQO1djtkbO8pb0jnpwdxYJ/potqzeOrPSuBDnalhAHxZuh8no/+RVsS5rkHwu5diPRMWAhRZ+ED8eAkQFepYwYReqDLSQasjCxJkDMwFP5gg7m/bXN4L2fpq+ILeM7pJU+XufBBJzjKJSy7Jk+4DC3ry7ecYd5XwCfIa4Ekdgewda3SUAlqQKM/f6wIlhrJxnzBGnNzztsTYV/vJq1cF04VD1OuTxS4fEQZ/h2WO2PNl0R+XlCI1plRCuf6ggRhJr1UCbOFJsgm8rRTVDbLrSw+Uksj38UVzyLpD05SSniwbxDakRDBqH76yioPQHPxXdhGFJo6RKscLaOe4RKdQ0BhWZZp3cjqm/HSzFR5ar9YuKmzn6yPc0ZY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(40470700004)(46966006)(336012)(478600001)(81166007)(82740400003)(36756003)(356005)(41300700001)(7696005)(70586007)(186003)(47076005)(26005)(6666004)(316002)(426003)(6636002)(110136005)(70206006)(2616005)(54906003)(82310400005)(40460700003)(16526019)(5660300002)(8936002)(4326008)(40480700001)(2906002)(83380400001)(8676002)(86362001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:05:24.1051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc285d5-146a-4879-9f17-08da664988e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add acpi function check in case ACPI is not enabled, that will cause
pstate driver failed to call cppc acpi to change perf or update epp
value for shared memory solution processors.

When CPPC or ACPI is invalid, warning log will be needed to tell
user that AMD pstate driver failed to load and what is wrong.

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
index c29d36f56ab4..4f8600a36194 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -685,7 +685,7 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 
 	if (!acpi_cpc_valid()) {
-		pr_debug("the _CPC object is not present in SBIOS\n");
+		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
 		return -ENODEV;
 	}
 
-- 
2.32.0

