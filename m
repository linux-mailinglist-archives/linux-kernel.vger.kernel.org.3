Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6CD571FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiGLPmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiGLPmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:42:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F11C445C;
        Tue, 12 Jul 2022 08:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k45ZkBwHqI0+4zA+iItgmcecYmcVVBv6hnzkpC78Jf8sJ3ULhjv7D3t3oiUvUk73cbMkKlRDXgPvGJiEuoRgGhpMdJwpgLGGSixI5qCNNyP62w8gscB3qaEL2sC7+u2RqknLUosQ74NnveZwEFwGOz+XVKyOw3u8x0bk0PuT2V6ZC3DrrlqDaks5ytQgmHArBkZCBQ2ldVvxhxKKzscODKOXJ/0n8ItLzZqIE7v9M80LQSckXo3PV9eIPuL/R0JWh0O5qJ1zNKvJO2lXmL9PsY29kPiHpCFiZIrBPjFqNojQ8YtM9ueO2heyapeFr8q1Y++MF4UagGdCt/rfUtx7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5yeDTWiBR+zs4cX2e30vumqoLvljIYYouopJxzrf0w=;
 b=XQhu+5JCa3lSc+/kD7xD02lV7rAxlH5VeNaFwDdxN+wFGbJXSYY1Z89cMV+HvZKA1vxnJ4Au4btMVfnD8QnjPggj21PfHRFkzNPgUqbJwgTOq9yzjHEsljmrRdedBW08efAkHEsSUPtcmk6USrFEdGYnk/jKG7Xmq6/KjDl0UW3e5XuudMjZcRhefgTa03IiqecV50Ozn+RmUy5glpgQZW+0ntpxAcUkPygZ3/XMyTPJMU/i/43gOaZH+oodSECz+AuPghCbzzWrPAMhxwbcV4LIX7osP2PL5jPRH7KkpFJzTv7/G97E8Lpp3pUcRQK4QE77MxttVA/YIsIi/hdxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5yeDTWiBR+zs4cX2e30vumqoLvljIYYouopJxzrf0w=;
 b=Ql7QjuPWaK3t2M6QWy4L4tinLUokNj7eYvoLeLQTuUCuW4vr33drrdeyXEsRUiToH1wOUITqyX/wXG93WnwzmNxOrtbZDg13LhEzll83u99sugcuRhkK4cJMoZSAFlUpOuPfAh2tfA+jDtVKqf0rMK322LBC19BckkX7Jl1eTEE=
Received: from BN9PR03CA0705.namprd03.prod.outlook.com (2603:10b6:408:ef::20)
 by BY5PR12MB3828.namprd12.prod.outlook.com (2603:10b6:a03:1a4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 15:42:16 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::aa) by BN9PR03CA0705.outlook.office365.com
 (2603:10b6:408:ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Tue, 12 Jul 2022 15:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:42:15 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:42:11 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 09/13] cpufreq: amd-pstate: update pstate frequency transition delay time
Date:   Tue, 12 Jul 2022 11:42:01 -0400
Message-ID: <eeb86584fabe92859b9b33c40442bada2e46df2a.1657638462.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657638462.git.Perry.Yuan@amd.com>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a27175cf-fadc-4006-150d-08da641d18d6
X-MS-TrafficTypeDiagnostic: BY5PR12MB3828:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MixfPANqsn9m+uMzfyfg4L/qhbrmpnQz1ASKIOMBd735f1j3JjaJA3SeBFfGsnng+NsRMoUb1BryMo+FageCI/WGwEyGa6UBj6p06F6ZHr3LzBHYxZTBVpXrMoFPvUbF6+fexCWkx7Ety7Ik94K9/363r/N/ZNOX5FV7SoIACHFGokGypoK2ROVAAEy4F84p7NC51OCEzbyif1RaTx7IaLiBz1CTsyrp+0ik92hKjR4/N6q8Z0JZ0LP8BWdEEtaoep5OI9DEENniC/wtQsMLvXFmqo4Q23StvQ0cjPbgpBhwqctVKdlOPLZByODPAEUPI/I7NjaIT9urSOsWXNkC/yk3PeO80yRlUwt7MOzJCs7xgV04I76jOANRafJ4G1YTpCgxKkJOXWYQNZn+2SyjVlHyqDRnIIAqhe92zdJfIrxWoI29H5KgiZ3MRuzcFTO8MHdpBmjr/vqEANL5RqpAil3PuCVLnYwirIA9CTpv+eRRbm3G+GxllOR1LnIq/JuzMZk6mFXd12JW1/tI/axHqLFepEkoivZXyLVTiSzPPrFqm5lkef6ruB3QkVy7YTZtux5DOag0tg3SJmzMHdvPLMV8eOZWbY0VM/yZigC59wXzfUVQSlErI6DOLvXLHHxi2yWXarH6sdfdGW7jKIMa/n2wgTpJSAtc9JvRgAzMSkt7xQ1j/euvWXWSi73tp4wuqOtaphdu4HN8cnFCWRDWuF0wxxGeYNDFZKjrR/28NWK6jwcWXpJ/KbsEnuaMxV50MQbZwvbo6478u0sUcvYhzDcgmpzMNSNOpITNvZ8g50WbAtqR/tyCammABgB6X2Zq33TWVSTPQ99ZPRTLKn3pHO80h1bFAiFWGBIwQ7Cdwc8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(110136005)(54906003)(4326008)(86362001)(41300700001)(4744005)(6666004)(36756003)(8936002)(8676002)(5660300002)(7696005)(26005)(6636002)(316002)(2906002)(82310400005)(82740400003)(186003)(47076005)(426003)(336012)(16526019)(478600001)(40460700003)(81166007)(2616005)(70586007)(40480700001)(83380400001)(36860700001)(70206006)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:42:15.8921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27175cf-fadc-4006-150d-08da641d18d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3828
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change the default transition latency to be 20ms that is more
reasonable transition delay for AMD processors in non-EPP driver mode.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 312ccef62f58..1e5ca4897b7e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -41,7 +41,7 @@
 #include <asm/msr.h>
 #include "amd-pstate-trace.h"
 
-#define AMD_PSTATE_TRANSITION_LATENCY	0x20000
+#define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	500
 
 /*
-- 
2.25.1

