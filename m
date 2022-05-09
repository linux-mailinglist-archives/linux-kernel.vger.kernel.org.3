Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133C451FF96
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiEIOV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiEIOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:21:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8AA2044C8;
        Mon,  9 May 2022 07:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTh1uTPssXf91BaT0PzDMWxSXiFBcKiq5tvHLMEH9uRQrw/sfftcq5+f0DsrW0J/zDyI68+V9zvBfSzJbX8Gdqtf65XcYHfChB3TgZbkjASDRwTmUK7eKnQ6DRHWaUW6CBa2QZUoDpFvUfNFMSYu0Hf73YvjgPwz31PSOSlGwfWqGise+yO3JC4Q/VbRnQXbPvhLWBlO6RHugMp4WQyKL0D3982GLAsDAQeSPL7wcR4Zwd71BrqZrETtRVCsKAYD8nP6EAglg+ecTQZNlyrLBOmXNeyNbREPI0p4d2tsb517G8eZV/42yJsnZT0F5psS7saXJJFbenXlksRzP9RWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChsgT1BknTbDT6cYZIEKT43oemuREX/tCoABYafNBEQ=;
 b=UuOu//Pi/5OT36dRS6Dm4jPvWQk5lyi9H/2jxqxS91gSvCCIGDgbmknkRX2aZ7aApULM2ISNGeP2qmiftB06GThpkPN8sjiv7S9JN4g475TC79qxerdwC5T7sUbOmUISrUNDmRvCoD93uphUTs+tTzE7nfGs5ZPSAICViq/8/FuqQ1qPlJ07if4RN489yWc1qedJVnE62Mh9FmwBzvdKMZX40z5+/gQcWkfaWQ2tc+06lY9tp5QEGeW64LNGrzLNnLXVHM7FOOXdXob9p6o2O4a8pQyqgpvyH8XJxa/2uhjBN2k2Efe+lV47xvuhNd3E0A3IbGekhP6tS3fh7ByyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChsgT1BknTbDT6cYZIEKT43oemuREX/tCoABYafNBEQ=;
 b=glxjijBhlOnYuHFYSU+3ml1VWPux+h1ThDDxgvyC1y8BQg38f+nESY69UNh7lAPv+E0t/P04nXO4JDlh8XgbEHnS4IUF43vX7P91eGXd4tDDFXh+dCwRgg8i8chvO3Qxr7+gRgnjI7U6y9ZREdXs2dHtS8CKj1ymR2SuAw7wBIs=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by CH0PR12MB5187.namprd12.prod.outlook.com (2603:10b6:610:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 14:17:25 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::5c) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Mon, 9 May 2022 14:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:17:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:17:23 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, Sudeep Holla <sudeep.holla@arm.com>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        "open list:ACPI PCC(Platform Communication Channel) MAILBO..." 
        <linux-acpi@vger.kernel.org>,
        "open list:MAILBOX API" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mailbox: pcc: Fix an invalid-load caught by the address sanitizer
Date:   Mon, 9 May 2022 09:17:16 -0500
Message-ID: <20220509141716.1270-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ffe8db1-420a-47ca-72fd-08da31c6a3e9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5187:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5187984CB5E4491871BE0586E2C69@CH0PR12MB5187.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+qvcgiCEjscx2ss+Avgx10vHWQ625aohXYP66HkSQPTrHbrLl95Ma0wMlhyx51H4NHuCYPAwghHhCOaM+BrHnGm1F8DQIXWjT7SaxxKNs3If3NEW9J7W9krysX7giedS/y+pN0pnDugh1WmmDObVMiCfewJOH0WwDv5z1kW/T3KC0Do7U/hdxGPxriv4K3r5JF3eOHSLQJMr0z45gTuKkJ2AR+qk9N+GY1X1NHksL0Y6wJKiQgGKh3Y+MwgJ4QlLgu9bLNFYV6U/l/u/W76Tmxs75lsLNr4QMBxlYebs+8YFUUTTPf0pG6ZpU7GxceCuv+Hm3tMQsveWqzLiGaWEugn/KPBAkKXyHFtXHdPKNxaRQ+MA7eXBTYlRbZWbnedmeT0Td2NTSPhzBijlEL3JFUy4xJolGutkxlCITUnOnEsGlfdMFbbm3DZ1Eox7dd4Ea4fnCV8VS+6uqeahZmSi8Ey2PHiPTjSDKihXdTb7WLWMBYjoypL2kyJ044nndqDGkck9gwmk4jIM6hnD18wVHcy4skUuZkuYl7CfKhqDYrJCLCEjS/7SONpqa4CI+H5tdTn78vr+nNkbFzOr7TKtXjnAn3J0EY9Y9A47M7LrmVuhFSvmRZoKdd6MWodmYXhyFrcOJZt/ihr6R//hdI7YpJKo2/LxD3c2wdWRi9PE4/DEhTVckRbR60YAIIlKKNrehQok2wgisbQk3BZ8SzgVIhPLeYTHpuKiJYPp346H6mYdnL3B6pgwqzusYQd7gxnGdTJNGvRiwde5bWG63lRfUBB9Quye5sHydE2lxy6u+8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(2616005)(8676002)(1076003)(47076005)(426003)(336012)(508600001)(70206006)(186003)(83380400001)(966005)(86362001)(26005)(6666004)(316002)(82310400005)(7696005)(110136005)(36860700001)(356005)(40460700003)(16526019)(8936002)(81166007)(44832011)(2906002)(36756003)(15650500001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:17:24.7742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffe8db1-420a-47ca-72fd-08da31c6a3e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`pcc_mailbox_probe` doesn't initialize all memory that has been allocated
before the first time that one of it's members `txdone_irq` may be
accessed.

This leads to a an invalid load any time that this member is accessed:
[    2.429769] UBSAN: invalid-load in drivers/mailbox/pcc.c:684:22
[    2.430324] UBSAN: invalid-load in drivers/mailbox/mailbox.c:486:12
[    4.276782] UBSAN: invalid-load in drivers/acpi/cppc_acpi.c:314:45

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215587
Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/mailbox/pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ed18936b8ce6..ebfa33a40fce 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -654,7 +654,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	pcc_mbox_ctrl = devm_kmalloc(dev, sizeof(*pcc_mbox_ctrl), GFP_KERNEL);
+	pcc_mbox_ctrl = devm_kzalloc(dev, sizeof(*pcc_mbox_ctrl), GFP_KERNEL);
 	if (!pcc_mbox_ctrl) {
 		rc = -ENOMEM;
 		goto err;
-- 
2.25.1

