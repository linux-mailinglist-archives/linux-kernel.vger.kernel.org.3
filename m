Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA811571FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiGLPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiGLPoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:44:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C009BE6BB;
        Tue, 12 Jul 2022 08:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/6cr0k7K8gHoGMcR/z0OISqewEzUv7XpkhDXuTNoDkCxD1bLQTFOhDsOvRBCCGIrZggczGXIReMcwb/BSo8xZkoYi5o+wMzQqbxW2FPv0lW3j3wkhJm1FmtVBKKLkOZ4LhuHXkDJf6RWcv6JH2ArxgJ2PpxypoTUI49ZMIAlYbSwuCq3vPGUAvOyv2re+MYGt+fo1ZyP4le/4Bb1qH0ZtgASTRa1dW1z/lgAd496P8Kkqc39Za9SGPWilwSO6eS6vUa1Sw8pQ6EUpMgBUtULbFa0wA5O/YF1dnmem726tkOx++V22bGleAvmyKRMFXh3R3FTsldwZG27wu5no3ntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GyzmVDCJcEPYjeURfC5aBvySzwWEqQNpnsQPQDsfQs=;
 b=V/X6naGc+j7oIrUShnQrufDDCZLzv//qjgHdZVSeej2asi8x360ui+PsvxUo1I296AnFx+LOeKjYv/Z9OB7N6B+Eq2KOvePkQ5XHaOpd/O9r9a3yFAlubv0yoFDBCT3eW0K35IaexU+xDHIXzOCzdoSKKh7oyDdpzs2/Xn/VmbF3ChZSnXaz276Mkh0vtYu/+r+A+887TXNJFMUerhM4Ns/hVcNiprX3id446aT7sSuRd/zHLJ1efJrysxHG4+L3xwsHg3t+lUK/3UnLOeH3VyCYPevjdoxIJ9NyEAzIwRI+cXGGfkCmU5Y7FtTK0+px1R9fd9+HAl/+vy/g2+PB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GyzmVDCJcEPYjeURfC5aBvySzwWEqQNpnsQPQDsfQs=;
 b=48tiMz5P5im2u2XK8wtTrg46nnyJEstaYm3NA+jYADhUOrM3o+kMg/EoIW38UXDoaWASuSCdnxmXbgnvbIx+/Q53foOZxv6q3TioEE/I5aXAT/sLYf10diGp8NcSke6dFvnQmzlVuPkku+221NdeU2OnyBPHSmyv3gAhea3y9I0=
Received: from MW4PR04CA0300.namprd04.prod.outlook.com (2603:10b6:303:89::35)
 by CY4PR1201MB0103.namprd12.prod.outlook.com (2603:10b6:910:17::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 15:43:56 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::e3) by MW4PR04CA0300.outlook.office365.com
 (2603:10b6:303:89::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Tue, 12 Jul 2022 15:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:43:54 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:43:35 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 12/13] arch_topology: remove the acpi_disabled check
Date:   Tue, 12 Jul 2022 11:43:05 -0400
Message-ID: <c31b9c213e7c3b344b299abdbef87b7d1bc29d57.1657638462.git.Perry.Yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 17254e93-853a-48da-87f8-08da641d538d
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0103:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCZ9KbarCZk3T1qWbDgfhUtGS3oRb3eEjqKeGVkvSIOdvnvdZ1dNGVZmZldrD+lAKy0mMA39WkCClN5uu+R3OM/ppwcLdm26HwPMbyDEWlOjLy8byuu//crKhN3pLdJRsreNtd8BMvUkMmcL0TsNLYsy38Dr6vfvLUVdQWsnyMZmHqr8hRp/xS2bHoeUNCThqUOJ3Ep2xuU0EV7c/yYDEOR10MTR9Gu+8qwH5F5QJNm1Uq2wdTT94ncic0asxT/7C0ofzp1Id2XBq6lHB4WAKLdWmZDXN3fkbZArgDA2XekEbfnjR2E6wLOF69CZwpBTtnJPU/6h35BREFLLUGpriSuRfddAUd1v0YIFPo2Ut459zrrmwPeTc+FCGTD6IoUH81s7EZnfcfAZVuHI6S9ybzwmUUAUd7e7WVyUhcGp6amOdZ5hPfWcK1ry+6OlMeCADqiYKLHgA9HyTKl0cTo5nJ0f01VfPgXpiZLYeaXVrhnF13XEhVgT3Lvi/5OMKsw5DK7P5/1IRZwZvV6n3R+gq7CkCpO/762X3Z2Le897i8vKmZHtWP313smB+4FaZPARA1WQIMppQJoub7GgiyKhzoLw6OxmwZWHiu75g5eH1W8TlVPAtd8PNLfTwaXUVPqh0tQ281V2TOpp30F2nNQWx5u1CdyPiMhIaCn8MeFWiLwJH8x0+iQTsqOp6VIQLj5Ptljm9UmhG6aEx/H+Yzf477NacHFPILsl98HiAvlkvPaJHopyj+Z+yixVihgBwHQk8lO/I1yO6u4wuyzURrBSym9iqxOkWy8qfAoGrFxjqqXxIUofcxG0n+ypRqptFqXCNE0bF5xFG3VjotgHsAGdQR8NI5SEibptOpJZrYE5W6U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(36756003)(2906002)(83380400001)(478600001)(47076005)(336012)(40460700003)(426003)(86362001)(316002)(2616005)(356005)(82740400003)(41300700001)(7696005)(82310400005)(81166007)(6666004)(8676002)(8936002)(70206006)(36860700001)(26005)(70586007)(54906003)(40480700001)(4744005)(16526019)(6636002)(5660300002)(186003)(110136005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:43:54.1991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17254e93-853a-48da-87f8-08da641d538d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"acpi_cpc_valid" function already includes the acpi_disabled check and we can
remove the duplicated check here

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 579c851a2bd7..73a8cb31529d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -352,7 +352,7 @@ void topology_init_cpu_capacity_cppc(void)
 	struct cppc_perf_caps perf_caps;
 	int cpu;
 
-	if (likely(acpi_disabled || !acpi_cpc_valid()))
+	if (likely(!acpi_cpc_valid()))
 		return;
 
 	raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
-- 
2.25.1

