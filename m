Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BF852C159
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiERRiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241063AbiERRie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:38:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396E4216050;
        Wed, 18 May 2022 10:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etOaqyVUs18CQdbn+XhUEsUP8ABCcHCWFQnLtR2NqqQ0ahF0kGKXB1NMONL1Q/c3ZDbxYA3NGX2QmNpKCK9J1w7SSS0wYCGq7fHjlWPybqs6vqM41o6V64CPmnPBA4F4UNqiMxXbgUXbwFuZPyDjVQlrqpMqmEIm2/NDJSgcNtW6Y0grRDqbOmHYpfTHAvkkbJLElxhpQLc3MBoFhVaahOSTPb5ybU6sKBSmdWVjbuocT7gIobAWdZzuoQ3rW4P9kaVUhmPF9739ZcTTihNQkFRhrwbIBx8YyWAq8Y0XBxvnYyRjAOPbYyX4buTDMjLqnPf1sOe1+p7O0fNPNPIKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+NIWq9tKqXYJ0fqFj9l0fRjJdF2NAU5j6BYrE5kCxw=;
 b=UzxH3jRqYJHdiorKDfNgqBB4rvjIub37Vp2Wq5FXNhSZnfftKJTMVulsXIYAqCyWWOJuiMQw/JeukC72rokfK0wv/N13IhEbJUpvnwWOpVNaYa1S/7BT79IiPGyuivqh0bS7AUt6KasTMYHN7Id9VwXLapl6lp7vZzXwVxW3wobVMYZeDyFcuuEq6DiIpRPgaqnAUu/V7CxnytqXW8pXeOsoVZpxgxNx2pBn8bXRjpdVzCci2A3yZAulkSWSQbNbfzZrfxKUvdIfSENm87CVRKt6h2Jplgi4n2Xs61j4e/tz9XUYBduaPs6SKSz0IwNIWmSbHBrCQS8GAu2PziJXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+NIWq9tKqXYJ0fqFj9l0fRjJdF2NAU5j6BYrE5kCxw=;
 b=nkP0A4MGs2m+rI1iazsdgYZHqNgjpfzkYkv/bORfkU+XChngoCdoQ1Brv6amAKzmh2KRZKFa9UARJs9myrKyC4v1E9IXI3QMvjtlZBL2NIjlTpxtFHpA9TzM177M5pxIFnzHFqSY5/YatD+b4/6e1+J0TZaO3ywC/COKYJmvTTSt2swHe++83d4toSOtnobZYWKgxbkqbUOQz4O2Cu2Bs5nb65XxU+xMszMtwyCmTIkX0WOGx5gFKWxJsWeYIdE3pBCEggltO7+pO7BXofFVZk2E1Q+IX4Oc2CIWI33PTJk35O0T6cQGXRzidkGcQOaqYMqNK1Csiudf9kmd8Jb8fw==
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 17:38:30 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::a9) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Wed, 18 May 2022 17:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 17:38:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 18 May
 2022 17:38:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 10:38:28 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 18 May
 2022 10:38:24 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <thierry.reding@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 4/6] arm64: defconfig: Build Tegra OPE module
Date:   Wed, 18 May 2022 23:06:10 +0530
Message-ID: <1652895372-29885-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
References: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f63867c-aca9-4a12-40cb-08da38f5390f
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2900603C88B806937E2A5F45A7D19@BN8PR12MB2900.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pw8QRII2IAdRm0SSrGeLCk6RwBvOdmXqEOeXeDhyJ+Jl5vus7uHrfnA7cOGoy3PXCDyG24QYdHWoljQAOgBNmhk+hWDKb06b0nMONMO0reCkwr57k7l1dsAptV2jZz+iElm8PiISRH+d0ufCTMECrOdJNFluzdFqKADSY8U+l8mXJCSBRV8rLjPjS7ts4COkYwi01rpJtfE5k9e3895kVWb5MiwWnjm8hAhhIJAv/VR+UFWJEKx4Mr1lETMuzhXu2I1pkKIhQFuSAzqCyrrvoS62P/+RN0ATXOgbDojlpdu5byvuUL16Zxt30+zWLo1bx2Q+/1o/CjIwQJUFXmoS/4eqkwXuMl2jAyKnuu0X++rulQB2U4Gfu0kJAeXntyTs8oSvkLVGAV3pxnD0BIAUbeFOCIY8JQcJAJvRs3pYWvsvowyO9JOfcMVhjr3vRUrbXYduD3R9fhAbuc64bsS9bsmA20Dg4spmj/1mlbjbcnteiS2SRWfQT6MvxvAyi4XVL6TgtisCbzjI9F9HZrkRyjC4JegYO5XV3aSHn/ia4dChaLG+eapXPvs+ttNDUUDgEaOazNjfbhu/gFMrQmzjJSM/vT3Qw1ICnt6qfOACzZyktbUNiI4tUKIz9FrQNe2QEhibpTcxMJFv1u06K5h0tg+or3N4+pOoxbZ74ipZ1/R2Td0lIMIl53JaSbSgZNu1CfQCWUoNIMVsSOZhQfFIJA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(36756003)(4326008)(70206006)(86362001)(356005)(8676002)(7416002)(36860700001)(5660300002)(508600001)(110136005)(54906003)(316002)(82310400005)(8936002)(81166007)(6666004)(26005)(107886003)(186003)(2906002)(4744005)(336012)(426003)(47076005)(2616005)(40460700003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 17:38:30.0696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f63867c-aca9-4a12-40cb-08da38f5390f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2900
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output Processing Engine (OPE) module is a client of AHUB on Tegra210
and later generations of Tegra SoCs. Enable the driver build to use
this in audio path.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cc9afaa..eb61a4f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -826,6 +826,7 @@ CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA210_AHUB=m
 CONFIG_SND_SOC_TEGRA210_DMIC=m
 CONFIG_SND_SOC_TEGRA210_I2S=m
+CONFIG_SND_SOC_TEGRA210_OPE=m
 CONFIG_SND_SOC_TEGRA186_ASRC=m
 CONFIG_SND_SOC_TEGRA186_DSPK=m
 CONFIG_SND_SOC_TEGRA210_ADMAIF=m
-- 
2.7.4

