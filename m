Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED14C0FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbiBWKEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbiBWKEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:04:45 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2040.outbound.protection.outlook.com [40.107.102.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D774A8A32C;
        Wed, 23 Feb 2022 02:04:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJhgVkuCDL4GLTvPaNzNCSutSfwJzfD//B+f3f13DjNvSvEXBjVgz5RhlescTDZ89+4p43xzVAoA52h6oXD9+YTw02dG3V2Tn8azeP/1mmWT5nAGXiwfgOJSBRzU4UcvuID9ot6egILIKBzPU7HZq5VipY3cdCsJqNU405iuim0Lr1lXPwcOD/s3oyNO9kHh3XofsiPPzQ0UPJM6YjwyWIkozkxghft7SS1XbQa/C6cvMWSnaEFcSmZhFZnUpjNEWI8Y64Z2S7b8OcZSlbbJrIme9ILJ6WfCdnHaOIbknHI4HuJ1f6wOR6rWhX2Oalws5SykWtAPCXzQ7qY16lZ9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSlrttMsmPx2BZPFqN5nmNJ77iz7ZuYFXsatxv+ccf0=;
 b=JUMiz1UkSLPNUr+yts3Bi6UBySLQgXFzHN2i6HYMoXEqYHtyx8ZSfJf3MNJF6xCs9wNHmzOXraizgiRiZKxhiZa902iU7GMgBts/al7Dvdq1UtszJwDwBCXlAeYKYlqmuYsuO1+wbQzwqX7mzPQfl0hyomEclg9ipuQarUWOlnIBN7NuII/4OoSUYZyOeungG7jOg9pD/C994PNU44QwEgA2rc3jCtRB5Kdcf0ls9AXsLEmPeE7fb4cj8i0oR/JPBL7627X0nm54h8j9+kSTAEcQHpDMu0dlOWojrgLlDxhCwEzQh142RdPCLeQq7KBvKPnER4xm6ffEzCfhKNVz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSlrttMsmPx2BZPFqN5nmNJ77iz7ZuYFXsatxv+ccf0=;
 b=YLt53y1bvgX9nzkY8/genO19t7yVrqVAl8qucUIlPcrqo3whC1Z+LzKCEs3nEnlT49A84t7eO+Jiz9p9eUBOc+u1cV19Oc3d/3IWbZY3G2QcHvWTiW/SQl9UgQJY7TXfqmcSQhfB8RPJhmtDGq4veoA8Y7LGxH4oGYO9+qvgahs=
Received: from DM5PR18CA0079.namprd18.prod.outlook.com (2603:10b6:3:3::17) by
 BN6PR12MB1266.namprd12.prod.outlook.com (2603:10b6:404:14::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.21; Wed, 23 Feb 2022 10:04:09 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::d3) by DM5PR18CA0079.outlook.office365.com
 (2603:10b6:3:3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Wed, 23 Feb 2022 10:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 10:04:09 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 23 Feb 2022 04:04:05 -0600
From:   Jinzhou Su <Jinzhou.Su@amd.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <dsmythies@telus.net>
CC:     <ray.huang@amd.com>, <viresh.kumar@linaro.org>,
        <todd.e.brandt@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <deepak.sharma@amd.com>, <alexander.deucher@amd.com>,
        <xiaojian.du@amd.com>, <perry.yuan@amd.com>, <li.meng@amd.com>,
        <jinzhou.su@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>
Subject: [PATCH 0/3] Add tracer tool for AMD P-State driver
Date:   Wed, 23 Feb 2022 18:03:47 +0800
Message-ID: <20220223100350.3523826-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdcc9f33-ce29-45b1-904b-08d9f6b3d5ad
X-MS-TrafficTypeDiagnostic: BN6PR12MB1266:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1266A69854098A93E4CD7AB5903C9@BN6PR12MB1266.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alR45z2+lPeDWZT2kiVYSXZqua67mx0i1JQt5HbxXqBNvqwoDCzZ7nyLV98Jal437mD60Nh+82jKi5PHI5iNzPLxawRBtrE89VfI71Pm+tEzBxTm9DmW0sycN5VLbK+0L7CeSTvOC8yPFwLd8CpTE8JJFqqJ7nI/IuNY69iEEwLwagDpnPEWHtLb0PwPD9c4CEopnFVVOIeFH6OpdgZMOw2HZOmIqzIV/vbi359sLsftWpwoJDLgzXYYHd8uaObrSAunDYQ9CEeA52LQM4xZvCILp+3dQhsX+I36HSYLYBwKXXRfxJyV/Rr4oRVyi1bUfYaExRXTron06ftwsNZ+4pMBJ9c32BokPBgvUvTJoepFm+BKtxxnEtnwPS+ZI4+N0pY5CVwfcHEFgSUlmKuC/PKg3Dz5GsHB+zJ1qyAYHo/eSAAYC/528ItW5SkH5Pp1oiUrPKygJF+++KDfy5XByxu2JLCqjtInVz5ayZ8gva6qEZRDwlD04E79d+Yug0sHbiuH2B4YApgjGCZZkL7jx5XM+npDfesjfZsa24Gg0adBQaAft0FcX+zt/7qe55RFCoYZHMRJVfuVjI9SnqPR6eL2cdqYrincTDgcU5IxYJU++fgW227d61DyyTzSNDdTIzmVCf7bJ2s9ntfR3iURTjk7An1iLanPVz5DHPimraR0uUYSc1P3h3p7ZhxDPSdBcG6M4FyQ5p2nFrF+wI7mmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(5660300002)(2906002)(110136005)(356005)(8936002)(6666004)(54906003)(82310400004)(316002)(81166007)(36860700001)(26005)(16526019)(186003)(426003)(336012)(508600001)(86362001)(2616005)(70586007)(70206006)(1076003)(40460700003)(8676002)(4326008)(7696005)(83380400001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:04:09.2105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcc9f33-ce29-45b1-904b-08d9f6b3d5ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

intel_pstate_tracer is a useful tool to analyze the performance of
intel_pstate driver. We upstream out AMD P-state driver into Linux
kernel recently and like to use similiar tool to tune the performance
of the driver.

I modified intel_pstate_tracer.py then it could import as a module to
analyze AMD P-State trace event. Other trace event also can benifit from
this change once they need this tool.

intel_pstate_tracer could be used as the same way as before and the original 
functionality isn't broken.

Thanks,
Joe

Jinzhou Su (3):
  cpufreq: amd-pstate: Add more tracepoint for AMD P-State module
  tools/power/x86/intel_pstate_tracer: make tracer as a module
  tools/power/x86/amd_pstate_tracer: Add tracer tool for AMD P-state

 MAINTAINERS                                   |   1 +
 drivers/cpufreq/amd-pstate-trace.h            |  22 +-
 drivers/cpufreq/amd-pstate.c                  |  59 ++-
 .../x86/amd_pstate_tracer/amd_pstate_trace.py | 354 ++++++++++++++++++
 .../intel_pstate_tracer.py                    | 260 +++++++------
 5 files changed, 562 insertions(+), 134 deletions(-)
 create mode 100755 tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py

-- 
2.27.0

