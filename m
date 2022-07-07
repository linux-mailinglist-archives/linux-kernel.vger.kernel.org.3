Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9719D56A8F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiGGRAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbiGGRA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:00:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0E95A479;
        Thu,  7 Jul 2022 10:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN3ppaexZWIkfH5SDasXnNfjejOAIu/Ds/MAC7LBkFQr+SYNkpvxM2zbp/Jw//SRbvzi33x0w+b7mgh4z0TjICGfxklf2QiEU5hHIJ+8zoQlIvySMa5S3Y4YpPdSWuYq/lPKjNXLIVBBDUEb5DmiaP5P06IpcOnaMDPuDBje2XX0KGPTsF+jqZlBHwzi+TnrwsM3ynymGjDbkCMXFOKVYrjZ8MYMZn0RvN1keca7c6ei5amAFTbvutYHoX62xOESXS0bH09XDsaD3ea3atWP5w7UrtNPWH7eHYv6DoH/Xz7SMKG5smZjiRQSaHqpn/ySPPza75T64wx80zFsM4iB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IF95Ie9bB81+bMsjtP8dBQ0hXdlo4sdYb4W3ShgO7w=;
 b=RWAhiVyKN/fJLlHV9AKobRdILQZmIXggdZZAJ9EhFSNX2lBGgtFydsPe50puqWdFvrQ7symFrVnqBLAcwJgAL8ao06nwDpZx7N71wkIE2cFYScx9qRLU6tbBsW5uLIkUvuienLvU3dWR+AaruRcSvOhvM49nWk8frmrXdpotIWnRBvmQfdetK8lyikOuHbrVWdzYbHnK9RJ7M6oD76XMCzp/So+m6nk75AM0TpJgxwoT4dHZ/uoRTFUaXVVhuImrlKbYyfFH1MbDmPDFefEsSi658SnTXQOX/RPoUhgYFb8haFQB/cAIRLg6uGpqXi26p8ca0ZCEFjBXbPsfj2xQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IF95Ie9bB81+bMsjtP8dBQ0hXdlo4sdYb4W3ShgO7w=;
 b=0P9cVPiHASkviAL1shLlATiaz8SKUEScrqSVP0XzjPzBkHXKkVtf3GYBiJxfp0jIbiXknHkYyr/YmYuPpH19ehH8yAA4ITSvLgVlpdZoV10cUyjs2uWFisT3b42XOMVkEMaIMZlHZNixaeBl+HXnHzYbHgsGrNiOxDSUkndcWEw=
Received: from BN8PR15CA0012.namprd15.prod.outlook.com (2603:10b6:408:c0::25)
 by DM5PR1201MB0266.namprd12.prod.outlook.com (2603:10b6:4:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 17:00:22 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::f6) by BN8PR15CA0012.outlook.office365.com
 (2603:10b6:408:c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Thu, 7 Jul 2022 17:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 17:00:22 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 12:00:17 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Su Jinzhou <jinzhou.su@amd.com>
Subject: [PATCH 06/12] cpufreq: amd_pstate: fix wrong lowest perf fetch
Date:   Thu, 7 Jul 2022 13:00:04 -0400
Message-ID: <20220707170004.216002-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64d010f6-c74e-4a3a-c2d7-08da603a2e23
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0266:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaXWP7R1TJeTk429vJc+fDtor6bxjKpYgLaJnuBDENHf914W4j6d8PGfQ4EAy83APTS5i+Yf5RjpJ5rTWFUHkv0sLkRFGQnQhztB3ghoVFJQHdEFiH6hSoBbObhGG/viEB6jGKQ8UutxOEjCaOpTFZq0pSrsUOmpz56n4a1U47k2PugqIQXtbXeg7CKG2sd3NlWfeJWLsUPGLZc8sU4jFl53GVzsRKRouEr+QjL9HZ+PefR38eoiH4apJPlEZRBgWQxtLo9wQF1qlN3n+7gBZwgM2KFfb8fEvastlYf81+4Mfz4UJ6nxH3R3HM8Y4Xuu/VossQASb06Oq+bERZxkEW4811J9Xz7eGJjUr+Wsrastx6AZEAD9tgh+GknxtamfGUnfdqok8AcYobex4Mc9lr3sEaG1RU4bhXOdbYZtNQ5MlUwzlW+qh/EdJPRLrsj91M+tQT76w0LZr+jRPlmcyljvOf1BQvWPO+k+/vXmoxwgWTzbZwoViZ9HeN/civ+2lCT8EslfNjlwRr53yhvHeYCLh4IaeKqetu1FrA3ywoasSmXbjWne3+e3MxNeg9cBhh8q0dvPS6q1R2qkwWcgmksjUy9KYJxMJUpMRQSbT82djBmaFYBhGqVHOjLefXgCzXIwQl/c9dPRei+N2sdSZANdFrkFGcFaqbNtbUcXmDt207DK9p78qFeaCxNI9pr4edCveCzoAa19QLgRVnEEHFH6JvWRp+SVL2dcOMuVSw9oDEXhT+h7CRQQidl3qV+eSqhRMIzZbUt1as3gG1lCAFTHOzMr+LrhAWZjdzI0X6JuZa9sXawYt+ANet/LejaehJPFybTkjfA908zvSabUzlLfUUfnHj88AlFvOj0bFB/DRiZytcH3i1ov0kOL/PHX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(36840700001)(40470700004)(36756003)(7696005)(26005)(2616005)(2906002)(40460700003)(34020700004)(47076005)(336012)(1076003)(478600001)(40480700001)(83380400001)(82740400003)(186003)(16526019)(8676002)(81166007)(86362001)(70206006)(36860700001)(82310400005)(8936002)(426003)(5660300002)(54906003)(316002)(41300700001)(70586007)(4326008)(110136005)(4744005)(6666004)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 17:00:22.4186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d010f6-c74e-4a3a-c2d7-08da603a2e23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the wrong lowest perf value reading which is used for new
des_perf calculation by governor requested, the incorrect min_perf will
get incorrect des_perf to be set , that will cause the system frequency
changing unexpectedly.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Su Jinzhou <jinzhou.su@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fc0de9fd643b..7c51f4125263 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -308,7 +308,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 		return -ENODEV;
 
 	cap_perf = READ_ONCE(cpudata->highest_perf);
-	min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
 	max_perf = cap_perf;
 
 	freqs.old = policy->cur;
-- 
2.25.1

