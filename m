Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D50654C0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 06:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbiFOEi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 00:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbiFOEix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 00:38:53 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2053.outbound.protection.outlook.com [40.107.212.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4528D237FE;
        Tue, 14 Jun 2022 21:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jr9ZshT+CPcEcWKrWoH5w7BUyk0bjwH3Xy355cyUoHCjgFuD4WPsmt0nmmg0cffdxPrrFCt1uMIaNGxzf/BJhy8yT9L9USovrU+cXaMUwijrPi5zc9S2dntnX4nub10hhKukOJq0ZMBTAy9oVtvkYRfWDspFe8T1pimRq5MJVdaLB5G9Itv731GUESiQXWPXlV/OpJr1c+RXvjTAJ3EdYBghf8+HgJTz7lwJyGzDHU8AiZ6MFHBJaQad9QZZsLyzOfC3QJ8uPvVPfhTPVolhvNPHPcqeJVuL1SDRwak2hOspjCvwfrZP1/lz8/CLNdhmDnW7geTnVeXnH60z+U23ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJ+pFBnj61WNRid+wnwOsWKCQKRt5DOUCWJ7ht+9shM=;
 b=iCQ4zs85L6yUE+aoK6eO3C0fYaEQa3W5hvXYCdJjHQXP4zjQIyxHCiFi2MwrhLEeZMglh200nuL3QDyxbDWfCPlvl8wBh173wDiDDaJApwv8hUsXfM1Wsotmasid1WgTPFAUwph6HHp/agwcLPd3/Z+DgxKLOKfGlqWAUMsPOS/smD0tXKx/s+MzaJJrHjG2DmCZU36InKMZbG9Q2v2k+T+aAi4BzI3RrRUr64Jr4FejkXRyUQNfIXx04FFGhs4ZvHF4MJkOE8OisgYwSnGqhQNe2moH71WtxwRBjxSFyzwKgABAr9M6oWG+FgnlsZRJOruPt02KIRMHYMDwZQAhPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ+pFBnj61WNRid+wnwOsWKCQKRt5DOUCWJ7ht+9shM=;
 b=h7YrMj489+TPaSve636za73GBzHc1Ht9T42/8apy0n09wV3cytH3wESWFJD78jMOv9WmTiXR1A5kXz/Tqvj7fGSpYPQNQTPi7QuTGjbSTDj2qO9tirZUVXOnxfMZjPe0eCwvHx91NjdZ7OgfFw42CnzX4cHuGJqthk151ZcG3R4yjs+/7gzYzqhap9VeMeegLDuFBOFXuHkVjY3WJiwn7n4QY0vFJm+Z1p/tI4wA6kW8emduyEXWH+XJDn9xTEGZSfQke0Cz/mLTKzBEsavicpEx9Y8b55iqhGL3ktXkOKAZDpJfNZLmsYNmEcLByVrzc1t+5nq8VWpcuoC2Oh8J6g==
Received: from BN0PR02CA0028.namprd02.prod.outlook.com (2603:10b6:408:e4::33)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Wed, 15 Jun
 2022 04:38:51 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::6b) by BN0PR02CA0028.outlook.office365.com
 (2603:10b6:408:e4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Wed, 15 Jun 2022 04:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Wed, 15 Jun 2022 04:38:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 15 Jun
 2022 04:38:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 14 Jun
 2022 21:38:49 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Tue, 14 Jun
 2022 21:38:46 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <dan.carpenter@oracle.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] ASoC: tegra: Fix MBDRC bypass mode check
Date:   Wed, 15 Jun 2022 10:08:34 +0530
Message-ID: <1655267914-24702-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ef31e85-bf95-4d23-2be9-08da4e88f201
X-MS-TrafficTypeDiagnostic: DM4PR12MB6157:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6157D5130FADA6C4FC6AFB91A7AD9@DM4PR12MB6157.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNYPuhcSG3TIRYAHzhNNdrWagOhFVf1stQssGH7s/FgIjUvACf7nW0KpggwU/wOfqv3Ihm0MHv2FkZAHnQu0u2KcDV1AkFRq6XiWPr6apluePNzC6gnORKu2IegC8QTWgCN13mUi2lGIq9U0Xis6ho/ZkrJE6ZB08+BTjV4sqWjcmUKnQvyhJcvyEu8Oy3o337AvN8OUsRRb4hKYlAFFncTYsxSTGxZoKUiByaLsyzu5PjLKoi36Qs1Zi0eEJYXIS3JpWjJEE74faHZk6i2yBfWFwLDvdSzXvgJM5f9tLweDrM8CnCYSg3bC9LYhvUkcNKsMVRUKSpccitbJTcGZ4Fwjw5ALksH1NAQzDrw+PWtn1asoeyYDPGk6cWbGq+8AJbuYMqosVMlc2q7Pivf3QItFQgrfEUyvqPv1ElK9RxsFR1fA4SOgea1a9hqHKB2ZHH5slT2jQECYdC8qPmyLmZ4XyHZICxDKpTtRXJGu7Y08GimKEB1j/HlOEUIX2gal3bhLO1iDMUR+AXMNMA19w2RXMflqJhEwcUjWrmXCaLa4650O3XQwNsQrVdYFi5LudcBCjk0wEdNWNItNMvbkTiVa6/KvCyK0SbzchLGW71qyIdu5YQmIZcofQImp0XognjHtmF+UMa1rc5zTYPFFTzWTxJYg9fonV08Xy+GSD7ytAMOMi3OYVtnjZiSUxmQ0eD2mgNXGl7/OxjXnUBLtCg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(4326008)(508600001)(86362001)(6666004)(356005)(8676002)(110136005)(316002)(83380400001)(54906003)(70586007)(70206006)(36860700001)(426003)(47076005)(336012)(186003)(2616005)(107886003)(8936002)(36756003)(82310400005)(5660300002)(2906002)(26005)(7696005)(81166007)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 04:38:50.7153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef31e85-bf95-4d23-2be9-08da4e88f201
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MBDRC supports different modes of operation. There is no configuration
required for bypass mode. The hw_params() call does not filter bypass
mode correctly and it leads to following Smatch static checker warning:

  sound/soc/tegra/tegra210_mbdrc.c:778 tegra210_mbdrc_hw_params()
  warn: bitwise AND condition is false here

Fix this condition by using proper mode mask and just return for bypass
mode.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 7358a803c778 ("ASoC: tegra: Add Tegra210 based OPE driver")
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra210_mbdrc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra210_mbdrc.c b/sound/soc/tegra/tegra210_mbdrc.c
index 7d9da33..d786daa 100644
--- a/sound/soc/tegra/tegra210_mbdrc.c
+++ b/sound/soc/tegra/tegra210_mbdrc.c
@@ -775,7 +775,9 @@ int tegra210_mbdrc_hw_params(struct snd_soc_component *cmpnt)
 
 	regmap_read(ope->mbdrc_regmap, TEGRA210_MBDRC_CFG, &val);
 
-	if (val & TEGRA210_MBDRC_CFG_MBDRC_MODE_BYPASS)
+	val &= TEGRA210_MBDRC_CFG_MBDRC_MODE_MASK;
+
+	if (val == TEGRA210_MBDRC_CFG_MBDRC_MODE_BYPASS)
 		return 0;
 
 	for (i = 0; i < MBDRC_NUM_BAND; i++) {
-- 
2.7.4

