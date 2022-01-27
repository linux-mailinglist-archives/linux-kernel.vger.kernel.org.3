Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A762A49DB74
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiA0H1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:27:50 -0500
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:55297
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229920AbiA0H1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:27:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4sPROnBRToLUfzUjKPrUQ7rA4aD6NwsyTE0DPT4tu39LlFxyCXXyDLOZbCGFtfWPfDlMmc0dES8nhSUw7pD/MK20FS/jOy9ThkiXBo3VnplgVFKNU8NxEnRbiKJ6GiD6iOE250qZ8pO4ZDABfbIK0f+b6W4n1AhBDJvv1gsS/EZQ59ZWI1BGtArO+lsBTH8qL3uSsGHfxH9nduh96viPVB1Ag1aAk0FdllDMA0oHexfvFNgLmgBGkJ7/r+OX2zNWZNSB0EL0pq8GQBGtbEN5Oezyj4ugEPZBlGBK2+138/NjTN1Mo86k4vLZVV9YnCHEAccXyBxshGm04fJ4wTCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIS0gk398QLvoZe1oZJni1yCbHQZobkdj/t7ltEPBSk=;
 b=QQ6v8Xk9E7IFhsj8QgAmQ23Pxhw87G2L10VQhLb40YYOEjb7tef52oD/0YnbXFO+0cPAawIuYp/u8qlzFPheStfjCAFEZgE8CH4dHuILG+oqcWxm7TPBdtSa3YwN2jDmeZ+gjJC0G34FE4OwchmTzmRvrZqsKBhiKLHMCzyxz6zhMD6adh+Z3KtjbcQMwibJ0uAD+vIV0QpQ4Q28t1aaQDlDtstC6nL96r1gaC0LuNfbLBwPJAxJEgJzYRhhPjztHkr+QhivyFkzLPwY1sOdV2c77RxAZYP7+5OMM6YwMHj9Vc8KzzV7vuhhGEQ5pjDhqd0kgbg4qyiV26pG08C6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIS0gk398QLvoZe1oZJni1yCbHQZobkdj/t7ltEPBSk=;
 b=E1ukKSfSnUc6aJ1o/QGfNGK8+ziqswSFPgtZNDbLJW3H9uZyASuobdOu88bXmEZs300aFBWVbBqpnePJdCYjQZNYqmplrWDb/YkoUI628rVpJGIItPuYDUXZbyhowQ78RGQvTNEkV2C7Ap2Nea32bbzcn1MNVBc5djcZtC3YelIDiK2Ih38z3FWc5xCviLmmhFYghHU1g1oQ1kb+eHckJ/5+29eUQw85NbB59XOCPjWg6/c7IGx6xG0r4VgT42M/A9VAPiSdZg5FM8QBvZr38TqZCkRxte/cARQMlA7Nj9mAa622wqFmDghILWT/EBhPAdF0alzE2KT23GIkz9qLVw==
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by BN8PR12MB3459.namprd12.prod.outlook.com (2603:10b6:408:65::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 07:27:47 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::2a) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 07:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 07:27:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Thu, 27 Jan 2022 07:27:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Wed, 26 Jan 2022 23:27:45 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 26 Jan 2022 23:27:42 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 0/5] Tegra234 APE support
Date:   Thu, 27 Jan 2022 12:57:30 +0530
Message-ID: <1643268455-15567-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50c76368-e206-41d9-b1c9-08d9e1668408
X-MS-TrafficTypeDiagnostic: BN8PR12MB3459:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34599FADC8790E95891EAE9EA7219@BN8PR12MB3459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pe/lbjsTQ3lR1ygjTpOKYnf4xaj4X2a0qU5ifgFND1x9u0y6hrK1A7+ujkl5IcDYoby2NLii3cnoC7HeDr6TQ6R6Q2xEMHr0H2eUDCxBu2mxPfJA/IAh62CHJ3X3j5mPq75fnJDi8pM9T+IVHb97K/MxozQY7dfmbeg0Ahwn6GWmad1mcus6GKRAWmSODSXoqt6wxdY+Ppu38v8UUK3PC8C8lXZzZBI6LZc0plm0a4D7yNBpKdu6Msi5R197oKCmBufzN1w9nVf3xmALqk2W5VTK/Y43UrkeuOYd84aiNpRn48tifQ7HeZhbJs0ulTnJClMA2sYSY1WVMf4xKcx3huCis1zX4ICQjO73hGfN/eYPnD+6SmkRprQv5ATzvXVqWaCVUOpiuvjGv6UXiGq6pwzh/u86mF93H6We1FfkuhxYRkgwPCXbcaG7bG1cPmhOQNTCZSlLPKEBz0Y8IarmCYG66euv2wMpiJpXRpY/4O06c85KyC894Wdx7k/Fug0JHcbuvtQZy4kS6V3fi+qC7l0RQiuBvDoosKkAAz9klMbsqqwQks96tu06DzuBmibI9KF092KoFVNx4N3LTzBN4JGWlmD4zMor75GAZJPmSXBSMyyYbhA8L+RYRVYrA5q+0g3Ix8/A77HwN6XXJTHLkYk6NROw6GQ1mF85OiJbGKCyWfhQTQNcllQl8K/8m0R/iARzwvsaMyKkqFXTknOeqA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(4326008)(8936002)(8676002)(70586007)(356005)(54906003)(110136005)(86362001)(316002)(70206006)(6666004)(7696005)(40460700003)(82310400004)(83380400001)(5660300002)(36860700001)(36756003)(2906002)(426003)(47076005)(336012)(508600001)(107886003)(7416002)(186003)(26005)(2616005)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 07:27:46.7086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c76368-e206-41d9-b1c9-08d9e1668408
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3459
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds APE support on Tegra234 and enables sound card on
Jetson AGX Orin platform.


Changelog
=========
 v1->v2
 ------
   * Rebased patches on latest linux-next

Mohan Kumar (1):
  ASoC: tegra: Update AHUB driver for Tegra234

Sameer Pujar (4):
  dt-bindings: Add Tegra234 APE support
  dt-bindings: Document Tegra234 APE support
  arm64: tegra: Add audio devices on Tegra234
  arm64: tegra: APE sound card for Jetson AGX Orin

 .../bindings/bus/nvidia,tegra210-aconnect.yaml     |    1 +
 .../bindings/dma/nvidia,tegra210-adma.yaml         |    4 +-
 .../bindings/interrupt-controller/arm,gic.yaml     |    1 +
 .../bindings/sound/nvidia,tegra186-dspk.yaml       |    4 +-
 .../bindings/sound/nvidia,tegra210-admaif.yaml     |    4 +-
 .../bindings/sound/nvidia,tegra210-adx.yaml        |    1 +
 .../bindings/sound/nvidia,tegra210-ahub.yaml       |    1 +
 .../bindings/sound/nvidia,tegra210-amx.yaml        |    3 +
 .../bindings/sound/nvidia,tegra210-dmic.yaml       |    1 +
 .../bindings/sound/nvidia,tegra210-i2s.yaml        |    1 +
 .../bindings/sound/nvidia,tegra210-mixer.yaml      |    1 +
 .../bindings/sound/nvidia,tegra210-mvc.yaml        |    1 +
 .../bindings/sound/nvidia,tegra210-sfc.yaml        |    1 +
 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  | 1783 ++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |  432 +++++
 include/dt-bindings/clock/tegra234-clock.h         |   74 +-
 include/dt-bindings/memory/tegra234-mc.h           |    7 +
 include/dt-bindings/power/tegra234-powergate.h     |    9 +
 sound/soc/tegra/tegra210_ahub.c                    |  146 +-
 sound/soc/tegra/tegra210_ahub.h                    |    4 +-
 20 files changed, 2473 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra234-powergate.h

-- 
2.7.4

