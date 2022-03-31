Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1974A4EDB11
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbiCaOFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbiCaOFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:05:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844B3546B7;
        Thu, 31 Mar 2022 07:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwQ89lp0ZWx79BvtpACPjmd45kCt5VPRfRhK4GZZNu65HB/DZPpCpo5If6zqP5Dak3a5m6I+rgQ6/OFJdMNIk/Ge5ILtFkFw/J1oJDeroUNbPFD3mlO6W2Z7Om1qAD4VqR4Ui+WQuokbFxJFtCR+8msJXHAnq0eikEWsInDfiF+j41Qt29yLx4f/1YuN0rSAkSvwmIorwo9R5uhCg9q9OsYLGYzRVHxoKSSzoSLlNAd5zB/JdA6Ey+tHc8cwubWH7OT0bHjr1Rb5VRqXkKueOE8BZqXVWJVgSKBP+rvmumFAVe6x0ax4AdGy5oEXd2Bhg8l2ZUzwiRN5rXAKggzg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/t+xt7t/i1M2lVzDbvIsI51byrzUTSi0dAF1r8/fjI=;
 b=b30QOfVC/IKtrlm/0mIJoNCMbuktmk/ovu+/ZKkEWbo7EH47sZsRlNqNXB+SZwFJlojyjfgSko+lfwkVsgZqbPm5gtVGjTmu0QWBZQa6Lb34uyLq7m1zKMs8rb+tvTL9jD303PGmMYwgnJntcBQBPkzDny4oNtsFixS6veMV7IRWIXg9S+8WlQY4xQYEz0kL8w8wRNTggMyPyOrlCwoLQLzzm8KC7GzSqsWkge2magJO9H6kBQwBjOFiz7aGyrKB9yd3UImqi8TfN0guzYdCFTxbAVCNa3UyOrHu2MdJXSs5Qm9yliKf5K9cfkdGf4IcPXvRqYW7OS2UDvHL9RC27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/t+xt7t/i1M2lVzDbvIsI51byrzUTSi0dAF1r8/fjI=;
 b=gA6+1Sdxx9vyunXnYR5ED+raeE5DWAQ3ixEJqYaD8Rocc+D5eSCkbpteGZVtaflzMG3fWniOWrDjAYYIuZcnGdA74nu1BrqjJiATSc+iJGkUrNqu2kv+3i/TTWE8n8zpmpJCZciniLJ9vrPA4wLBUaJY520ugyBfu836un/b+QsTcBDPCoP1R94utf3562NV8c4SgMHdFVVhAykZDLool6P+ATsOI1uOjKeJ9xzbstOB0FzPqLKzWcrgsm/gIF4+gQoIxF/e4iuHqxfscr3LkvWAM1hXWyGoyhqSf4gHlgtGj8C+yI3Q6keZ21QW0N9NacQmHpIpuOoCHeOxM15omQ==
Received: from BN9PR03CA0326.namprd03.prod.outlook.com (2603:10b6:408:112::31)
 by BY5PR12MB4818.namprd12.prod.outlook.com (2603:10b6:a03:1b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 14:03:47 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::7b) by BN9PR03CA0326.outlook.office365.com
 (2603:10b6:408:112::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23 via Frontend
 Transport; Thu, 31 Mar 2022 14:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 14:03:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 31 Mar
 2022 14:03:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 31 Mar
 2022 07:03:44 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Thu, 31 Mar
 2022 07:03:40 -0700
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
Subject: [PATCH v2 0/6] ASRC support on Tegra186 and later
Date:   Thu, 31 Mar 2022 19:33:26 +0530
Message-ID: <1648735412-32220-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 877b1ab8-77aa-4623-3895-08da131f45fa
X-MS-TrafficTypeDiagnostic: BY5PR12MB4818:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4818D12A32E38089ED89FA72A7E19@BY5PR12MB4818.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5PP1tBG6y6+Iem6noWEey2PMWx8yGSAz4UarIJxoAZJjbbYIvVnjBe1QEU++ztDi3amXEewwjGqo1bN1S83Ynq8Qh7EFeolQGG0OyQlfb/oMTWpgXpmgKzVbBKaFavSiz8+Ez3T6cJp7mpyBP5hoxUtaqhcb3/0lKKUsTSOsXEKFUgPMooHJrcy/A8F6cHVOHk4Ra62za5KAkVMtSfUUknPa1+JHwL4OATPLjLJsIdnuA+MORbFcv3nbnx6VQziJl96dfOvRbj4pZ6Bdl6N2zPuRHvZ9/V5jrXVRY/EKrPQeDBV/e7whiUE0+i/QCDSDPNRI6EgtYyOTJUhkeIGAJip0Uahk8sXNABI+mwDdPd+cLaYWJcp6tFFlQb4YNOhQ4u2S+1uOqlkKVfBIoD0oBn9AhNuOBblFTviTKp8bOKOROR8r7sPEdAPjKnhYT/zsrGJfnmdImex2ppmQLRr5ujMUsgaahulFBHqU1jgX2TruhM3q0WcOPhCi1z9QxQcf1V9acgr0W9iHqprB0PhE4cemFGReQ8gt0Il+9jRdWyxNjVGai3rRil5CrGIMd9bqDcI3c9/jfsMd72UWnnRXMu7u3aOHTCYaNF5wNo2SUJlM1j4qUU6M/qFJlzg0I6Jd2T1m6Z8e1NG08tUrEWsyhM1vOrhTTnG9r29ZGxEKdCoqdhLzjodjZtmATXxU+rT8lNQ05iTbFu6GFL32rc1kw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(26005)(107886003)(110136005)(40460700003)(2616005)(47076005)(356005)(426003)(186003)(336012)(316002)(86362001)(81166007)(36756003)(70586007)(8676002)(83380400001)(7416002)(82310400004)(508600001)(5660300002)(70206006)(7696005)(8936002)(36860700001)(2906002)(6666004)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 14:03:46.3411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 877b1ab8-77aa-4623-3895-08da131f45fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4818
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Asynchronous Sample Rate Converter (ASRC)
module on Tegra186 and later generations of SoCs. ASRC is a client of
AHUB. The driver and DT support is added to make it work with Tegra
audio graph card. The module can be plugged into audio path using ALSA
mixer controls.

ASRC supports two modes of operation, where it gets the ratio info
from SW and ratio detector module. Presently the support is added for
SW mode.


Changelog:
==========

  v1 -> v2:
  ---------
    * Updatated RPM resume call in ASRC driver. Specific register
      sequence programming is done before regcache sync.

    * Fixed return values of mixer control put() callbacks in
      ASRC driver.

    * No changes in other patches.

Sameer Pujar (6):
  ASoC: tegra: Add binding doc for ASRC module
  ASoC: tegra: Add Tegra186 based ASRC driver
  ASoC: tegra: AHUB routes for ASRC module
  arm64: defconfig: Build Tegra ASRC module
  arm64: tegra: Add ASRC device on Tegra186 and later
  arm64: tegra: Enable ASRC on various platforms

 .../bindings/sound/nvidia,tegra186-asrc.yaml       |   81 ++
 .../bindings/sound/nvidia,tegra210-ahub.yaml       |    4 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |  223 +++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |    7 +
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |  223 +++++
 .../arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi |  223 +++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |    8 +
 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  |  223 +++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |    8 +
 arch/arm64/configs/defconfig                       |    1 +
 sound/soc/tegra/Kconfig                            |   12 +
 sound/soc/tegra/Makefile                           |    2 +
 sound/soc/tegra/tegra186_asrc.c                    | 1046 ++++++++++++++++++++
 sound/soc/tegra/tegra186_asrc.h                    |  112 +++
 sound/soc/tegra/tegra210_ahub.c                    |   82 +-
 15 files changed, 2254 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra186-asrc.yaml
 create mode 100644 sound/soc/tegra/tegra186_asrc.c
 create mode 100644 sound/soc/tegra/tegra186_asrc.h

-- 
2.7.4

