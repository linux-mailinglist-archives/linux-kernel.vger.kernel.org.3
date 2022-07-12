Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD2D571FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiGLPmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGLPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:41:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8843EC3ADD;
        Tue, 12 Jul 2022 08:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbnKmBNHxeoCg5kYijrPnugHlaJ0jbfC+eMXMem4RCFNKSUIYE2EK1bdoozkRMQ5iLt83dsW7n0y+Vk/kgkD+uQJVVIEyqbftP5AsmEviRViKyDTA8hsZrwb+ekD8abtWxq+IfDeaxWUmoT+QlpA9zSmC4iwmS21UZcbvWduPYGQ5US+CLkMOSVETjxq87R7qgfnES8k8ZTAdXGI9F48kP8XBfFrnRuKCxBpA45i5vVUfpI/4fHiE0fDLhPkDGh/2NWbyeFDcFhZV0Hb2CcTgcOdKuvuNWL3hp6UoAuZbVMryZWK09jvHIfhx1YF2Y1PpCPbdCXNVLrNsgkVsfm9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uC7epzQxMMNQDjREPI+QOqlajXUTKgUxuqMAWVUNs4=;
 b=J9/asTxErkT6S5B2p9bAF8z/M00di0UXiWyfNXHo9xiQgY/sco0svLfpup66ZgDr+Th7AYikUY+DVXs/SdryXBJTw190jwVPQjTA5Ptx4ECvrRk18A1Vz9gcKmfRbAzv9GBDOI/Va6xGRyZehr15OYyyxKrTYqQneB67oMGlUbCdzVgsyKHnZtq9WdGFYACjlMkYqEJADYCcc+zF07AH8qzGuHMJr8YvmV2aTmM8NCm+KLKVUej+xJS8BnQq5sZcYXzOwryUQKB75iBHjbhD1jXbp+/QQOuU1Mb/ZhcfFzFZV5G4aNRgRb2qL7mNkuKikH2NKUqDugbTdg2EONzDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uC7epzQxMMNQDjREPI+QOqlajXUTKgUxuqMAWVUNs4=;
 b=YjaeFj5jPTb3BL3s142sJb5tciScSfxzUpOfFGjnLkHXKtwzpJ28JsjXcwV9hGIWdJesVvzetKpcZMXrxwPl76d4Y/ctAQ6wCYWqBKZPF9BobYZBQuUdHcjsoFUFgFr7TzHIAwkJ5a3eVUKAt/+PG9qq0Kyjv2T6VCdHc3hP0hk=
Received: from BN9PR03CA0398.namprd03.prod.outlook.com (2603:10b6:408:111::13)
 by BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 15:41:55 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::6f) by BN9PR03CA0398.outlook.office365.com
 (2603:10b6:408:111::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Tue, 12 Jul 2022 15:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:41:55 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:41:50 -0500
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
Subject: [PATCH v3 08/13] cpufreq: amd-pstate: fix white-space
Date:   Tue, 12 Jul 2022 11:41:41 -0400
Message-ID: <79c21c72c13a25aea0fe9b6eb3d3072c757f1017.1657638462.git.Perry.Yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e8128ec6-5526-402d-1a9a-08da641d0c91
X-MS-TrafficTypeDiagnostic: BL3PR12MB6404:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89CaceooQ4BXoS2UDhkElWnVS3zI2AvQehmaw2iUpWVA4Ioj55paOCCxXVv41ehD3SxSsbFgJIwOGQtgrvbMPXZq5wi8ey75Why7PIhi5ntaM6vCG1sTELpEG7gLhqLWehsqFLlhy8DlFYpGVfTCS+hTFgARyRgm58RK9hOgJDcTTxOvAsV8M+HUdfZeJo52G9okSvJz81de2jFwAn32IOn/Vh9cNrltFOz7t1b81IrcTZmSRTE3hBfeLI2X5ZXZusIXjNSCPH7RfbvJ2OisDy/Jo22v3qmuyMxz79yURRC2XswXQgN9AGKKtC5S2tCjXMJv4QPFIIHNUeSt/kAX0qInq8CL2TBL0JkqcNyriAsc1ejv1wqGRTfz8+f1CR+BmeofUJRFGuWn3A9ypv+CFf8/Tol4cl7ZNZNOIB1FWXBG4Rntz1iwUir73HGIYd+YUjrBfACIYgsX+0VDuqXmNxgS4tTirOVe6bTl0dGNCr76Kvd6LgLbodE+SPSLOIhBZFoBU4Gchijuj7TYE8XTb6htIvNEUT+nYvPoL4n9IGEic4oE5iUJiRiRPUPIXJE/qLgDFJiPmkw/OQnAo8LCP+NsdttceGmNZecXD5GeBc5VI/1DqyKNqubjpX5zTsT5uCPg853XeNoIHY4/7A+qHboB4fwf2DAXJ8gd0bUlVWVtnwH0SVeTWFIqa9/bCbKlLV8Tb3RTo0oA8N1Ig1EPWV6Q/nHpX0DDiibC60fEfDYZIihLhBf/KfY6KYPWzGMIvSw7xk/TNGyscb9bbNemZgD997cluHum4UxyN2q2i6q3Tq1r0cZ5yhJiYfnDVy+PfOvP418JKz7sz6EOlEBYc2X8NEBOSsBmW82x9Bocvug=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(40470700004)(46966006)(36840700001)(2906002)(5660300002)(36756003)(8936002)(86362001)(6636002)(70586007)(316002)(70206006)(4744005)(40460700003)(110136005)(40480700001)(54906003)(82310400005)(41300700001)(8676002)(2616005)(26005)(47076005)(336012)(7696005)(186003)(426003)(16526019)(6666004)(4326008)(356005)(82740400003)(36860700001)(81166007)(478600001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:41:55.2918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8128ec6-5526-402d-1a9a-08da641d0c91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
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

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f359b1b20140..312ccef62f58 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -115,7 +115,7 @@ struct amd_cpudata {
 	struct amd_aperf_mperf cur;
 	struct amd_aperf_mperf prev;
 
-	u64 freq;
+	u64 	freq;
 	bool	boost_supported;
 	u64 	cppc_hw_conf_cached;
 };
@@ -671,7 +671,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
-	.attr           = amd_pstate_attr,
+	.attr		= amd_pstate_attr,
 };
 
 static int __init amd_pstate_init(void)
-- 
2.25.1

