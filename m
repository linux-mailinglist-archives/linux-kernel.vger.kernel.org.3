Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64EB471C07
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhLLSHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:07:13 -0500
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:44932
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230468AbhLLSHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:07:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/WwZnfOpaFB7x85U6NYWy6DAEM6LngNP4nFshdTsKAYqTNgUTRvLc2v+jVLST3yBEptx62YnjTivSqMKG0FTXxXksZBxKH27dxJI9QcMkcF4aDQuLqBmIhyjVEivF7Z0Xg1A1gcfRJ0yZ7hdVzUKC74ZW6oC9tzRATWGEHfT4UYKXzurkbxuyxISuY9qwk5IKyJuBD/u/6RZOnTu+ebZY2xfhhBBIdPpeOJbm7thO9mKS4NjOSmTZbgbepliTqEAUU46HH2AV1fxv9IpGhd3rygKUSk+n2lP4qF2ZBPxR5/N+K+kaG7QChe1ozkkfbQjFdkT1xsvItkZOYktOVbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTe6TzBlRFjzhVmSGHkJRdBFO+AVh8RlV9S8TFNLxRk=;
 b=SEAtBQZdmzMZnIEKH6VdKdjKzY5WXDAKRnsMc//GlpxBDqIgc2z4nyrdxKs0gkkUz621E4dyAgpPRZ++StGUB3+ca/48i2dUqZ3Aazq9rYizSkSY78hE7R+sfxCnNn67877fXX8xeGbeMnvNraM6PJKiTitLpbwciM6d3h80PpcQloxKQMaT7pEWeFFDs/+k/lHBaRTkI8GcVrLono9I9NDz2+/KSrZePbG3YZvW+y5xzL2/FlAzWwQK7aiexgPPHk88KjYotunyS3lURZwisz/pJh74O0lwZdecXLcmqO7Lha+BwQxtwQLgUOgcQt76Jyglnb2RoYQZIYWh+AMbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTe6TzBlRFjzhVmSGHkJRdBFO+AVh8RlV9S8TFNLxRk=;
 b=pbUFyhQg+xPAoz+DP2akwMP6LM7ayL3iMSwqmM+V5xELXjhX5pT7S0RY1tZ2ksuHxWdheTgvAgs1hA4ZKYVtruZaU1wpXj2NoTFw4153MtYLrvYGzzG1Qcxd+nSs18N4lIupMiMO09MbtnbVovvXEA3FtMk/nlLhFDTOmSIx1nU=
Received: from DM5PR22CA0021.namprd22.prod.outlook.com (2603:10b6:3:101::31)
 by SN1PR12MB2431.namprd12.prod.outlook.com (2603:10b6:802:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Sun, 12 Dec
 2021 18:07:08 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::20) by DM5PR22CA0021.outlook.office365.com
 (2603:10b6:3:101::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Sun, 12 Dec 2021 18:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Sun, 12 Dec 2021 18:07:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 12:07:07 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 12:07:07 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 12 Dec 2021 12:07:04 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/5] clk: x86: Fix clk_gate_flags for RV_CLK_GATE
Date:   Sun, 12 Dec 2021 23:35:27 +0530
Message-ID: <20211212180527.1641362-6-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com>
References: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fd33008-fce7-4566-2fa9-08d9bd9a3658
X-MS-TrafficTypeDiagnostic: SN1PR12MB2431:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB24319451DD82CAB59829F25F82739@SN1PR12MB2431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihIxXNs+DqlPjYp1b7rgPZieswJsLZQ1Gz0tZwyGTX7wFvRjGc2/0VVdOh/jLDGnQIMzpaYl2PjxE9VAQ3Y5GeSyUU9o5re0SPz0D5vw1QbigODVoWeJNgqhKi+FmGeLDVoYOysLcM+RFlJqE14Amy+NlXONdg1KZL5IndLxte5BgadZfXp+Q2G6CKDQvPbLFWmZ5ksgRUockF1/hvZ/TIsQyuda5TdZ/CgY4j9s3YWW41bpIUSDtiWPzNYKVo6kbi3NAgt6snB/d6VAyXGKMpnxpo6h0vDHEXQjxZTiGiG3Jl1+L9AR5pHVI9rnyaCRlica/zEBDMh2L+Kpwo1c7CkmOyR5wv76SLdvH4bXqYCIsKZWs695r0uAPcGuSt+kTgNCGkT6D5ZjIh+boZ3AVujcByPJzy8t0GFLMZMUDmO6pQbWdwXmtOyB+1+ZAcwecEz4Qnk697PbcVJYfZStDqLEB99tqmpjmVHgRJhf6qn26br3Eif64KYmftCyd5HkaovY7bqt+1Y/AeWIvA/cuxnQ5NM0VaX2X7qay1wFy7uGQ2OBmNsrLEExsPxCKcFwEspUtaQJB0p2y+a8Ervv+JcDye0Nni1H7rRxXugOG3I9sZYvY39q0/m9h85YHRdBGG3G4KyYU7EsRx02MM3Osogp8tHbuX636etdAI7HICBSEWhwH3RuzZWsnPPC1jjJxYDF3N9wRilvQSYfv26ghYTc18gf3ZDlT31q09SHe5a+CJL2YgTFNhkgmE6JPOwhxSVL3pzEGOZZ5tK/+NGzK0dDTYP3712idPG4RlGSuXM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(81166007)(2906002)(82310400004)(316002)(356005)(86362001)(8936002)(110136005)(8676002)(1076003)(426003)(47076005)(36756003)(54906003)(36860700001)(40460700001)(6666004)(83380400001)(4744005)(70206006)(186003)(70586007)(5660300002)(336012)(7696005)(508600001)(4326008)(2616005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 18:07:08.3216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd33008-fce7-4566-2fa9-08d9bd9a3658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2431
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In newer SoC we have to clear bit for disabling 48MHz oscillator
clock gate. Remove CLK_GATE_SET_TO_DISABLE flag for proper enable
and disable of 48MHz clock.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
---
 drivers/clk/x86/clk-fch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index d41d519b9c2b..fdc060e75839 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -82,7 +82,7 @@ static int fch_clk_probe(struct platform_device *pdev)
 
 		hws[CLK_GATE_FIXED] = clk_hw_register_gate(NULL, "oscout1",
 			"clk48MHz", 0, fch_data->base + MISCCLKCNTL1,
-			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
+			OSCCLKENB, 0, NULL);
 
 		devm_clk_hw_register_clkdev(&pdev->dev, hws[CLK_GATE_FIXED],
 					    fch_data->name, NULL);
-- 
2.25.1

