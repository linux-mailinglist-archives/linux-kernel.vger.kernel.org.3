Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08970575F13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiGOKG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiGOKF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:29 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE2582478;
        Fri, 15 Jul 2022 03:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kV0dCyG2YbpVJla2YvlsMFdDBph2gJ3or2DKS1ZtSX9CookuhFghdoqM5ycdSXULxJm2f8hVu/N9gpfLjgizdz4ABN5c9XH1+goKSvahd5sF4GXJO2erA41DrRwPWICaOlBArDGb1d/RZmuyhGaL+jSlmbkf+jus+wz1J9m7nPO1UQGvOR41a5ltxxXj6kLjRIsEqwItxrp7F/ka9ulnpHf2fDt565De8AfQtLRMRS3kj6grckM9/XYvyUk4SK9890+kokZ2RLx6PVqsZXROAOOaGGq/w0w33lC8CKtkgqg3vAizQ3k/AGYiGgYGACuwHxxZnzUFdPiU8L3CGVzTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCg4mNWv6SPudk0gzXx5yyZeZmHTwUTCNXKphpEyDKU=;
 b=mOlMOQ3vBOcRlAHPuP2F5eLY6OyEaJ3WJTZPMQyQO5HaFlOLdmx2/djS+akXBWnaD22dGFLZDrYJLt8zLbhtkQVDhtScwQL6u4Wwbp0Pn8aO2DRIH84goKbBPoDL3fynyYwHPpHqHxHimcLe96irbjxf8ORkoC/qTnZCekyoUrNbHlTNTxx/SY0ahgjVxTZvAVx8gHzb3731qRnznSSLR5R2W0DJ+csmduvB8HmPDYFUNB67Ap+7U+QpWZzqvhxugvFz3jIQsX/v6uGOapzcgrfllCvX7VA1Ap8mWC/jpVjHu3Bon0iWzqiz3LIM9vXXlj9G0hYWOqBIdsbfcoopDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCg4mNWv6SPudk0gzXx5yyZeZmHTwUTCNXKphpEyDKU=;
 b=JFsCeGVR0UCboH+JMI9sHRaUBXDEe6btHvfCjbHnahhKqNQ07WgfH2+hRvagsAk45odSSXOgFGnDBfz7JZfRTAYHzIstPuyWYKX3J0g4KYmUzrUB3tb91z42t2MHLdFQgmxOKyPk1UDCLUalHIUSdiZwEK5ieRY6YRIuSHEBfS0=
Received: from BN0PR04CA0177.namprd04.prod.outlook.com (2603:10b6:408:eb::32)
 by MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 10:05:20 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::ba) by BN0PR04CA0177.outlook.office365.com
 (2603:10b6:408:eb::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Fri, 15 Jul 2022 10:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:05:20 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:05:16 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 09/13] cpufreq: amd-pstate: update pstate frequency transition delay time
Date:   Fri, 15 Jul 2022 06:04:28 -0400
Message-ID: <507e6164192c0922d3101591edc6ba39f27556a1.1657876961.git.Perry.Yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c99f981-20d6-4570-6274-08da66498695
X-MS-TrafficTypeDiagnostic: MWHPR12MB1599:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95Vz2HQZcUs5SFDt2dfmE9qFF+d1uUTWHlIkErb2rEbDwG/MSjkYY4m2N9AsYJluLiPgvOf0lG7dWcXTFSYrr1sh1ixRAfXHT7o6a8Xl2AWkiGKhSD+xzRIOKEDC8wI66Ef+ZW/XNqyRXxteabglk0QNBEbys06FFydljoebErLcqoIDftp2BUGA7V8seB0lSxrigtEoeCcvo33amMcQ48eljfxWbYCeEzApKl0lZwSQ2do9Gs7m48OT0gzqzRr/u4D25+ouwxMjYbjj4RGt3GoJvVkgzkYilSa6+ygVTNk9uAuUeZc4UGsAdF4DrL6EZy+9ub/fzu7QWkjv1GRLGiMBiSDa/LEvdVboVUCJGE48y+uuumS5hnEyfQkwgJ1ctGcxZNFsEhG7IPTDTzNG1l+UUl8V3BdiPfGBVl4oyMzoAe+zc1tjpPWBNss2sq7hwUpny0FNcb3isob+lcBc0tepagA1/3RTsmcm/7a/xjg/RhnK7kYqI4NbE+Kw40EHyN66p7xANWNJRGw25FLJ6Sr6JchKnDdR4G/7fSfwpg7Tmt1fc0ke/uSa+YVH5c9N1KuiVftCRz4y7cVMfyqZkIUxRFMV6WzLIAktTaNrp8NG3IlAhKMjNtpbtZXWwkJBB3DjM3qbmniXwd3+KfuKhAWNDCcLXI1d7hm4a0xiG1BKKsq06rsQ+Vnq+evHHsjFKTASSoOqyUSwgZiRX+dKZps2z3fmH6zc5wpNS+4BMQ61YZePQnx0TkIOX8sInAWm7/fVzucbxzPkHRbLIJbyyUG7p6WbaapGU9avLHuTZ41Ihu5vJMY23PK0FuAs8Cc7uieIzCLleQ/H5YUpQfrVPNLJ1+kjtb8G+bwKoxM/NuU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(40470700004)(46966006)(36840700001)(54906003)(110136005)(4744005)(7696005)(41300700001)(36860700001)(356005)(82310400005)(82740400003)(6636002)(26005)(2906002)(316002)(81166007)(36756003)(8936002)(83380400001)(5660300002)(70586007)(4326008)(16526019)(40460700003)(186003)(8676002)(70206006)(2616005)(40480700001)(86362001)(6666004)(478600001)(426003)(47076005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:05:20.2304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c99f981-20d6-4570-6274-08da66498695
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1599
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change the default transition latency to be 20ms that is more
reasonable transition delay for AMD processors in non-EPP driver mode.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index acb62ec5ebab..c29d36f56ab4 100644
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
2.32.0

