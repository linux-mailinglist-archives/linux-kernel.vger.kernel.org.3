Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31054E8DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbiC1GIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbiC1GIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:08:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4272E517C9;
        Sun, 27 Mar 2022 23:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dqs9YzwrCGfXaA4CDYGVue2PakipBxxRqSaaZSL9tG373SXtEEP1iZfZMc/lS4kuejBdZOHjNxp2LJbTgprGLpj1igcMeKBtLrG+4DraDJuf8OhJxABQ4D11b9ZYM41s7lLmKaOqvivg3U/wRB3KMZr2w6dDwkw9Jw+md7FPiC1W5oC5x6Y+UJnVzYRktizgPSamcI1awqqLOSoZAXNZmoKvAJqGpTta+h+RqPpDGCvNMVrgeXfuF3uGVG7jXEdVEldrJ2r3HpQ+vp1c0kfI9IT0tP/yUuub771KjrAp397VCydkPFnhzmjOs9fzbVJN4N4ScHpKJboIhPRDZXeI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC6L2XdDaQF847syeS0jq7DiNVTyw430JpljyPB2jTQ=;
 b=QcDvSzl0wNXbGLxWKYspaBXyzXIhT/UVEHQ4KMQWIZ5mgBVHGb4lCGAnRARXBXCiHseA6brGA1kJdkLDSZ+MBSd4O4Bxr9G1v/CkNZLRFqCabQZkVSgB+/Krvu5kwEr9O88aG5/nXvQ/u5juTZmRLJ71z8OMvng6CHg9zOkmUFm+XeP8WFMeY95N0mMpjnOwBsdYc45KWmwOck7Z6Vp8le/87RVn7jsy0YfIv5Rzt1QrxBEVA1ihL7UXwoYb4mIwSX3iGS9A5HlX0LeG5L5Tc0tKQ5KpCe5C1RmOyAGMYk7v3PjRq2rIqW8WyqtLTqhOboGG0ubg+fsHccXawT5sFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC6L2XdDaQF847syeS0jq7DiNVTyw430JpljyPB2jTQ=;
 b=pZeJR7Obns663ODtx3cYSdNHywmJx4p9HWD2JDCLW9kluUiAl09LSqHe3dLcnvY5s4a/rpID5NmWRD7NjHP3F6ks135ZfCniess//3zPGxI308GPTM2s21uT3DGpCpYhOjA5xctijr9UzKde1UAwGoBBCY8CW2qfT9k+qTJLJ9h0v6HtLL3UmznYH8h8XuaViQhtxK6fEama1cipE6kWcFLUQBy5FN467SvcXZNlq1Vqn9psyIalnfvp030MFDXHhaGl/Jm5mDkWd7v4W5QQ6m+TPj2SDWpfB6f2bsWsaiQU3C1u5+lbEtvIX+bRcdBUSHAS0qKqrAfgLjZ6Ht+lZA==
Received: from DS7PR05CA0028.namprd05.prod.outlook.com (2603:10b6:5:3b9::33)
 by BL0PR12MB4946.namprd12.prod.outlook.com (2603:10b6:208:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 06:06:53 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::e9) by DS7PR05CA0028.outlook.office365.com
 (2603:10b6:5:3b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Mon, 28 Mar 2022 06:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:06:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 06:06:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 27 Mar
 2022 23:06:50 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 27 Mar
 2022 23:06:46 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 4/6] arm64: defconfig: Build Tegra ASRC module
Date:   Mon, 28 Mar 2022 11:35:24 +0530
Message-ID: <1648447526-14523-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648447526-14523-1-git-send-email-spujar@nvidia.com>
References: <1648447526-14523-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7605bbd1-ea39-4c63-ea6a-08da1081272c
X-MS-TrafficTypeDiagnostic: BL0PR12MB4946:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4946A7320ABA9B705D4A0C89A71D9@BL0PR12MB4946.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REwWt27YlKDkPxsL0gapzbXxa5AsLbBiThB5XfOHDxtobh/wgJooL1zkD97Q9xlXoKMvY99p2UqqVavDVBdjG6VWNOgPzJbinSoQd6a3nLAoBg11zR272x0VysUcBETlhn78o7w6GRlNCjqs7w7FD0IzGsGAJOu83ouHX03g9oAqv78J41ebS+SccKOLZLWgq76N0mRmS6BMHimlUrWwTwi9VDywq91l4+M/z+Z2TpS6j7R07jONubK5oj0Daz0ye4CQry7JdNrAyChX35jx6H8rBaBQQdw05w/RkWptbBUwONYR4v/0O7GyeNMexufGXXgvWrE+VKMMSlfsU0vp3DGJDxb94Cgc6vkmsrMR8Xu112khcpIGzZjMfMttSkqpRTLo9EnLO2xdS9A1U73eDUtQDysLj8/aKzBvtvq+nV2XvqAttLldSQufZ48q9X/gTFXANW3oLMT4mUTX/D6zT+jqHTmS79rMXVqHVYorJjNtfgdzfQm1eFWVKSLHGwrikLXztt7CJFO2hhcqvm1FW1Gmd9G7EVH4Sf086+rJQAfg4lIE4sJ+l2IK6czsCMwVcWZT53y1zjCv6aMG366QdtFaHeozEPBAXvdJLln1uxRkqDnlAlJYEjebShxSJ3/IlGjoQKOjsvHToT06Frr29onOniM0v8vlvF+/Z8w5Zc/tGGr26WkJp8RjrcT3GJhfmGQffxBj2pPIsTdJmdX1AQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(81166007)(107886003)(4326008)(70586007)(8676002)(6666004)(426003)(316002)(2906002)(36756003)(7416002)(47076005)(110136005)(54906003)(4744005)(70206006)(5660300002)(82310400004)(2616005)(508600001)(26005)(8936002)(186003)(336012)(40460700003)(86362001)(7696005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:06:51.9177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7605bbd1-ea39-4c63-ea6a-08da1081272c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4946
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asynchronous Sample Rate Converter (ASRC) module is a client of AHUB on
Tegra186 and later SoCs. To use this module enable the driver build.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 813e644..7a8d9ad 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -798,6 +798,7 @@ CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA210_AHUB=m
 CONFIG_SND_SOC_TEGRA210_DMIC=m
 CONFIG_SND_SOC_TEGRA210_I2S=m
+CONFIG_SND_SOC_TEGRA186_ASRC=m
 CONFIG_SND_SOC_TEGRA186_DSPK=m
 CONFIG_SND_SOC_TEGRA210_ADMAIF=m
 CONFIG_SND_SOC_TEGRA210_MVC=m
-- 
2.7.4

