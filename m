Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F8D564F87
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiGDIP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiGDIPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:15:00 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02CFBCB8;
        Mon,  4 Jul 2022 01:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUbBFJZEbgzIK52WgbKngvXdeG3DQY5ZKsCJMy21RjzYuayqrGe7KeJLqvO06tZVAJusje8fQWcxTmTicYxJ77bzUdmvKftzqlL12RZwd3iK21bSkmqgaKq7jzHTioXLMDsIUhF2TKnTrx3VPwHhpljAMnVqXGhfINbuB43Qx7+eMEINSsUEqYjQF7XMw2FbO/41ZlL/aPUytdlh6AVWVJRRTUHFppTwq+zob88nOwSpdH+R1iDwITcuDhbFafHtb9q4T/zv3ZTGQAQAQcwgCCa3cCKEqUc4VRBYmUESeTF2AMRKfecxpRt+k4Zu780wyAX0/a4rb2jgJFu3sl9J/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6ZHYP8pJ2TEfRF8D67iZ+QJB5QnATuY7iv6i4lztdQ=;
 b=C/Lhj96iyFb2eB2ucvGcpisHzo2w2xsVBO1PKdx0vbVmEKqz/BYH44iLJI9ZSN30PIZkAu2VA9Nuijlb6AiPxvNRYgsl1iaS+Lmwk6DbJ3CvOFAkQJZlW9x2143yuXuwi0ZWT9VhCaOuq10hdwGZ2BR3/vZphvtSSO6RYRgmeY3ncS2n3ZR30wfBFi5gTzJR8nstCeHulBa8D6Ich+wi+brsviNqEnst0OwidGhleJ0J1ryRUU0tfw1XJR92K6qOEDingbeWael9UHXsu2QzDf3OPEWtDG9GZ69soWgmUvbTP0/q9xZGQDOlQH4Sd29MRO8UcfCEk+hpnkg9XT9g0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6ZHYP8pJ2TEfRF8D67iZ+QJB5QnATuY7iv6i4lztdQ=;
 b=WcF5phdeR1Ik8WzZXc25vnE+bxtT3U6dZ98L2GcpBrHo4KqtXRt8gNWu2qrBDX+ujZlfStYpvqb8QdCxXEuAE3Sxar8oMfh5tJN+V6RRExxcoAGKTo+1coJzfRiYxX91E9sqfozxEv580I+kex8+WcZruTdIFrZBIPR/DAwvZ3qjoNWeVI9J70/TSKLfjSpkvWfpVDfewqfSrusBuz6Wm1Suz+VTp1h9avcxKY44uWVJiKViqtaT/SHAjIuSHlxiG9zrWcRa57dNY5QHvKCAYV7lCTdw60nQP88J7eGTJxGOwSg3puh7o7KRc9gNsycTqnPaucU8uMc0/JMx9OPBrA==
Received: from MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::30)
 by BL0PR12MB4723.namprd12.prod.outlook.com (2603:10b6:208:8a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Mon, 4 Jul
 2022 08:13:50 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::fb) by MW4P221CA0025.outlook.office365.com
 (2603:10b6:303:8b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Mon, 4 Jul 2022 08:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 08:13:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 4 Jul
 2022 08:13:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 4 Jul 2022
 01:13:48 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 4 Jul 2022 01:13:43 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <mperttunen@nvidia.com>,
        <rgumasta@nvidia.com>, <amhetre@nvidia.com>,
        <akhilrajeev@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 0/6] Add watchdog timer support for Tegra186/194/234 SoCs
Date:   Mon, 4 Jul 2022 13:43:36 +0530
Message-ID: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 649f167c-8fc6-40a7-d20a-08da5d952006
X-MS-TrafficTypeDiagnostic: BL0PR12MB4723:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIXAHbSdna6RBxWnzJxcUFwLITjkyfKke9OLegMaLNvq6V+EOmOV37NPlLa73V7WQdT0XSz82bxDBpTmBjem7TQGO5SemqD3LItufLXRFkYGW0dftSFovV+Z6Xtj7XMwn/QAWryqEbMMckMbGtvQJWLltfYft1Ku1nsXZBO7YLDFYcFxjMJgx3x9DaXLwrr8EkyupZ5/dogBLpnnl7GzSyO2PUlNkrpaamYXr9A8MX1kjHft0jNpI6wnyGojWbwJGU5SBfSFh5f4fva7x6aVX5hcXU/EzZJVxsOjGO21tWh7RZJa0OBm+lIO7vaQL1Q2oQAT7mR49Ti7RJwTV90sUqNeam7p7CaqEQVZssc0t2h8WtZp2gsTv9JY4y84sEYCORsO7QvSqg39iPLfmqdMAngEaiUc7MZa2lXAhDijjO6nrTfp0KvQhDeTX4WjgRdLJRGhkDznD1cxD74qA7ukXuwZUlfIfhXhqOCC1UvSTmjCHLTknSPYK/YLk6w3QpA/EHfyfsp5KdNfzwesfKbqFl6w6HPzfjeDm3Hyj5QIsXaEVV+1DRXkmzhORiQJU5R1DhL+C31Jsnw3jcZbR9yDJNDaklNh0XUdZI651v7LH0zdjT0s4MiSnOfNajVyFnZEj6oUmA8ifqROKm7vYmjBQ/aTeY01NhSu9hhxBMAO8Uj65wAY5lhhGZfkpjA97BacRA37Uv/Uxzyf4niZ21oHlKM3GDK2N3imEYC7bL4kHBPZZo1c2wtHaf/zhHJVk8mL4fM0xApwn/HZV7CTcIUc8ZEEDLQNh6IpWX+80VYo6duTzFcQEdfWby3CVvEH/DxlOxZYskU+BxoBttk88EhGcQIJa8aDDwxVRIG36h2wJx+0cmr+oz91Dmvy7qH8xzo+
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(6029001)(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966006)(36840700001)(40470700004)(47076005)(426003)(83380400001)(336012)(82740400003)(82310400005)(40480700001)(81166007)(356005)(921005)(36860700001)(186003)(70206006)(8676002)(70586007)(316002)(2906002)(5660300002)(8936002)(7696005)(26005)(110136005)(2616005)(41300700001)(6666004)(40460700003)(478600001)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 08:13:49.4081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649f167c-8fc6-40a7-d20a-08da5d952006
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4723
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

 .../bindings/timer/nvidia,tegra186-timer.yaml | 109 ++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  16 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  22 +
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-tegra186.c          | 514 ++++++++++++++++++
 7 files changed, 671 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
 create mode 100644 drivers/clocksource/timer-tegra186.c

-- 
2.17.1

