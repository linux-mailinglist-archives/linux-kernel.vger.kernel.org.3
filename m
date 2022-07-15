Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B37575F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiGOKG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiGOKFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB99F76970;
        Fri, 15 Jul 2022 03:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmkrpkE6334vOXUNvugux4jJzpooCBsJcEVrr3/MtCVn4WnnlFgoXWdZgDToSv6UQ+kaDJA6wCK2ajTtiZGP6PQUAQzbR3YmObhrJ/sLOiPLwgYZ++nPDr7a9s8xMOY0lVyHlj0FkfagHuHR71XJOWue7xTefWKLiYCDbfaYDPDC3ZUfya621NuM5Ov1A1WV76wF0Ez4FnMvSNE5x8fgHdl6Z/HE3cO0nZjfl4VcGD6JPgkC6SuFFhljpb3y1LW3Wo1frqYi5gVWpoinVeADqEyTSuA1HTwaztqZUVy4opHuYGuHiNN8i+/mIEpUns+jQ4BDuAR9vUyJb4ByYW5IOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEyFi4Da/GHpOR6B5nxXHPlGMMOY1maCq0fjJDPxWNU=;
 b=f1nxTR6iapLs2Y/WL1i9nfmfYC15d5ywF1dAOXivC11o72xqzHK2GtXI6ieJQZBeLN9NA9UOoiF0plY1xPFJvlV8fnDuYaTO1xtVXAh0+oB57lx4cWm/aAP3jashbTkxbj/Ne4QmapsAZZ8uPsHsVh7MI3TSLbSSj5TtNyYMRXI1x4hgibUlep2sZh7muAuURhJTuqEk+Tj7sx70q6/ad/po81s3hY18Wwq+DudGgKn5r1RW7qzaHMe0iYxX5ljx58GaFKd+W/PQWumlTjE4Mpa8/QX197sVWrb4ZW//SsW4Ut6Sj1PyMJVGM7AnMt54jwdxbiNp2Si3yR3/CHByNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEyFi4Da/GHpOR6B5nxXHPlGMMOY1maCq0fjJDPxWNU=;
 b=r9OZDWrnYH88dQgDE7vGVSpkBjFmzemstYRCcYEYym7jlqzod+EVvv+d4xvvKKQGYTOMCeXMi018FzP0mePpIbkXSfOTByR/ISqxOcpJYubhB9fXp2h9nlDHK4056OiyhMtZ1TGEUEa0b2yQMHvi54n+rxaSBJFv8oZNLlsTXGI=
Received: from BN0PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:143::14)
 by CH2PR12MB3766.namprd12.prod.outlook.com (2603:10b6:610:16::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 15 Jul
 2022 10:05:35 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::68) by BN0PR10CA0010.outlook.office365.com
 (2603:10b6:408:143::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Fri, 15 Jul 2022 10:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:05:35 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:05:31 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 13/13] cpufreq: CPPC: remove the acpi_disabled check
Date:   Fri, 15 Jul 2022 06:04:32 -0400
Message-ID: <da43e5feeb246c02ba4ce6ffb5fbd35fe7bd9f14.1657876961.git.Perry.Yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b3252ef-f5e9-45d9-464b-08da66498f91
X-MS-TrafficTypeDiagnostic: CH2PR12MB3766:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsqCj34CCGJG13b+winLmD6wi7CuKuDLzBSE37wUBWi3X9HRte4/rrc7IBXS/qSa3PZ1BwUziKiWkM+0caegqk8Kiv1nWqb+TX0eAVf/T7c/OQGgNk+D++U0PUllOOEmgsa68nSeKfgWTFXqvHbB5ynM4xhvvGc/XUv3HxQwDT/VBOA7tEhpYhxfOu9l/jWik9KAjNAp8zQl7FhZ8O8uhjygCNdIjYTftMS6Zk/EPAXP4RY1VkLE5NV3BypylHnJigT0/ALBfMhOK1VGrw83lhFFvZLOUEad7Q1ACcoVI5JL6+MY8DImGKDjh1G/dzAWwXN3Ue2VHnI/bp9ql5xM5yquWD0BK3LzQ3HWxp+zWEBEXDrMOlZ1Pk5YYL3N2xck0PS0NDaCeURYC35MT2DRfPCL627NODqzVm7pJot/MrSOByJyANbsGOSlQ/sBB29E9Xf2z7BeufcNotCu7kGWBXfyynPZjxcU0xjUFOD05KFXwXQtATdkNAlZdhfNyOdz5Oao29Hc7Kt8xq14dWTAJh5mbtYHc/HIKyebReA7TOKh3Q50LqoNAmgF87CGKVm1135r+ZVpbB/5rk4GvnOyHViLkUsi2wpPnJhovnlgEIOdKyXEqIu1bY24dMYtTJ2CclDAQfSmnKoTZ7mnTG7IUx8FIkToG7N17uY1OuHE7+RoTHMOfr+2DtAXPQlj4PRL5h4wmLj3UoH0SKMqFvt1BqyS93Au76wrfe6+reMiLKBOhi6CT4U6VZbHLAjb0m4Pd9n19E6/+YAYrDjc6I6Q6vjiaU6X7JYj2PGkNLUa+ipg7LZgXioji2L8hYbKsP4kC7GHoeMIMQ6zjtKPpkhJ2WqkqzNGZcscvIBrjzo1sb0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(40470700004)(46966006)(36840700001)(478600001)(41300700001)(16526019)(186003)(2616005)(336012)(81166007)(7696005)(47076005)(356005)(26005)(82740400003)(36860700001)(83380400001)(426003)(82310400005)(4744005)(2906002)(5660300002)(8936002)(36756003)(40480700001)(70586007)(86362001)(6636002)(54906003)(110136005)(40460700003)(4326008)(8676002)(70206006)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:05:35.3029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3252ef-f5e9-45d9-464b-08da66498f91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3766
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"acpi_cpc_valid" function already includes the acpi_disabled check and we can
remove the duplicated check here

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 24eaf0ec344d..9adb7612993e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -947,7 +947,7 @@ static int __init cppc_cpufreq_init(void)
 {
 	int ret;
 
-	if ((acpi_disabled) || !acpi_cpc_valid())
+	if (!acpi_cpc_valid())
 		return -ENODEV;
 
 	cppc_check_hisi_workaround();
-- 
2.32.0

