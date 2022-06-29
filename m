Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F46560912
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiF2S3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiF2S3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:29:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9E61ADB4;
        Wed, 29 Jun 2022 11:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/2buJttsVOlPrF/rpMV3SAX281BMyukZhsI6cyDmRetoSRGX1pL0v24mVKeqOQXLK74gs59YZzrCR1acLZr8q+2jdNC3yxtgOK7WOKatDRZq4duqWeuM+dYsyQ0hCpH2M82aR29FosLOY9Euto3mK4qY6e5r2cxcb3K5tKnCeur2kt7vzil54L36V4ZMzIX5wpcz+LiZ/wscOOX7xknHjbIGVsczZvu40/a0lSy90UYkAJ8i2wBW9ygVAfSnHg4+Zb64vq5JeSPVnE5FjnGHUcd+VsHPjASJyd5Kd/WjX8giP3UyHWBd1yQBNFZ7W1/AvLTX/J2Ez+gisg1jaLR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggyyc4yhOgQgUcBhkfQJbmV3oeYifEtc4KxroU06MDE=;
 b=GY6ZWxVJAKfuptz/eWtO1fKicKzK7qMoU6slJslSY5L8MhiZy67RecuKmSG3nFqjSXWZSoVsY+a5JiiAX7epNAk9Y3aj/0xHtxSxNLWGDa+Fbc66tpr7/o7rKZlILxRZX+m5RVrS2iASzrlGkj9JJ2nRVy0ektBwa9SC8soRDYutjCvfkWe63l44egdfcldSCLHSGMiG+gWd2Ff4+RCps8CWDK0ee9wCS/gHJURK8okFtVCFp7AxP3cmOq2zxKYx4HPwDsEsFbyQUT2hCc/1/yqiFwrVlhxIeQMeb81XprqTguIF6SRz2ChTS4lcCNpmWsHgwQRDvAUzgrQac/zsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggyyc4yhOgQgUcBhkfQJbmV3oeYifEtc4KxroU06MDE=;
 b=OFgghD6TEKfJZ7ryLt2nM/0jlXiSEwar2u4WgVwSSFjAWlHNF9MmegLTd3YCBEMsvDr8FfvmxuWp90L9epBS8a0EluGJiJWyAhK694DgnXbtitcoTWhsMe+ymFhpBG6o3fywt/EMm6SunSjMc3RJ/2knUZsxqfdnaXb3rITB9N5HeAYXfmzWQIGdDDXARELYiju9jPk2b9AHEJK7j8WHttOHE1iCN/zECvsfHGB8dbEgsf36eea2+Lte0VCZbyGR9QJvwBYg+9qTl0yWjyjWSXQkenWJadSAXPYmlDnJ19Q5g3s8MGKnxa9fUYYLABUE3a0iOGRsiUv3DCFYDE/TEQ==
Received: from MW4PR02CA0016.namprd02.prod.outlook.com (2603:10b6:303:16d::22)
 by MN2PR12MB3535.namprd12.prod.outlook.com (2603:10b6:208:105::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 29 Jun
 2022 18:29:15 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::4e) by MW4PR02CA0016.outlook.office365.com
 (2603:10b6:303:16d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Wed, 29 Jun 2022 18:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (203.18.50.12) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 18:29:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 18:29:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 29 Jun
 2022 11:29:09 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 29 Jun 2022 11:29:05 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <akhilrajeev@nvidia.com>,
        <rgumasta@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <mkumard@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kkartik@nvidia.com>
Subject: [PATCH v2 0/6] Add watchdog timer support for Tegra186/194/234 SoCs
Date:   Wed, 29 Jun 2022 23:58:58 +0530
Message-ID: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58df533a-4ec1-4099-ffd7-08da59fd44c9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3535:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5rNR62zbuLqLnF8677+XjcItPV/EFnzHTdWWD0PIJbkIMj+CgYL6YFzrKuQ8P7l8fAvd0JCr70WKVXThxymybFlkZvpnhBXtwpRSDpFRzCuhPkIjt9d04ytXjJqzCjRtHQxW3aMMFbwP9mzS6Uz4CV2ro0qBCDPp99fe5jie0m/FfPJAFHJs4y6bgxAnraS8b+EYQMZVhTomUGAKNnUr1rRux8VAtUygQTemw+SAV1i+eURSMZo+GOzG72gSP2qvTLrvG9o0HvXEvDIeuL4O8yrb7IgfZX0MIGAo5zfyafsffAqn27JTi+6ApePrDDcTrvByF4OwzKamXBQSfMsfNBFRx+Sx+TcI+fQoSNs1MDsNbbHHm2ggLWfm0BdFW6HnfjUzYezPGAGxwzDVJeqoiyJZipF1Fib0iLKpeyKn6yPAHiNiGXJkQz5VKIEx3PLOJ7k/JmYqIQfuj6/ZDGK5q8h3qAdgB+4oDEOFf067WvdHf+88X0jSqT6QVpdyOWj2ZaK1+7qrxv/QQ9Z7X6l0XwF9ED0YUNxhL1/5F3t0TZrZbL6uTylzz6pg5atKAJ+T08nP1vLfF3RtJjcOc/DZ5eprnE51TxCJ6dNXcpVtuvzkh/ry8iPOyTtfaNeil9Rl9QejXPvLYP5tBNAbH6Pma5P//lgyw944Iyzwthd65D5YxDXPO36LN5AKqSQJdPL6tVZW8PP9b/JbJGomITSsul+njvwY1fJrv16bQf/YPXNnI/c56Ms0ib5gd/yo3AP2ZXCt4zBe+eW2sKNBCp038S1bjkyZ3Iqh7+yihzBenX49zl18vFnrCGRs6U8tfa5
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(13230016)(6029001)(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(41300700001)(356005)(921005)(82310400005)(6666004)(8676002)(2616005)(26005)(2906002)(7636003)(7696005)(83380400001)(82740400003)(5660300002)(8936002)(7049001)(40480700001)(186003)(36860700001)(478600001)(86362001)(70586007)(47076005)(110136005)(336012)(70206006)(40460700003)(316002)(36756003)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 18:29:13.8596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58df533a-4ec1-4099-ffd7-08da59fd44c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3535
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The native timers IP block found on Tegra SoCs implements a watchdog
timer that can be used to recover from system hangs. This series of
patches adds support for watchdog timers available on Tegra186,
Tegra194 and Tegra234 SOC's.

To keep the history intact, I added Tegra234 driver change as separate.
The original patchset is an old one authored by Thierry.

Kartik (4):
  dt-bindings: timer: Add Tegra186 & Tegra234 Timer
  clocksource/drivers/timer-tegra186: Add support for Tegra234 SoC
  arm64: tegra: Enable native timers on Tegra186
  arm64: tegra: Enable native timers on Tegra234

Thierry Reding (2):
  clocksource: Add Tegra186 timers support
  arm64: tegra: Enable native timers on Tegra194

 .../bindings/timer/nvidia,tegra186-timer.yaml | 111 ++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  16 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  22 +
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-tegra186.c          | 514 ++++++++++++++++++
 7 files changed, 673 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
 create mode 100644 drivers/clocksource/timer-tegra186.c

-- 
2.17.1

