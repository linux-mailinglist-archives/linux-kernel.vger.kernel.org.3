Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FFC50083B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbiDNI2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240537AbiDNI2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:28:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A66133E16;
        Thu, 14 Apr 2022 01:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELRy3OS8PbMz4xt87jJLE4XZ54ea0oqs6Er47o16BelL64pkFNO8tZsdO+Kqu9/fFnexLPnR9xk317ZB8uQhQRsEprlzGpQ4Yb7XdZpwswkDrjxi/UEvt85YlzcIcVbjFQpCSx4W11+Jf8YEFHkEnrPJHhax2kQzClHR8no/HiA79FBgjv6tGpoXsHwSnviPs/mj+47A7RQz5Wn3rICFxr28A/iTOVshmhPckxmq+WJkFltHYxDcWJElEm5rJFP8Umj1nhqqQe0TZ+nDnGdqd9lrKtyCVAr7KddV1Q2/ZGUcrN3N7L4sweAtB4Tm6sukj8HGvh8eW5k1SHzw5HtKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KCjsX397/2hHoO6eY+jnmgKy6d0iw5EanLra7DZqn8=;
 b=gHS+Iago7tbD4xtGXekaEmcaZHugTePGakUiM1gwoHS7WX1mJunO5h/ewynIKDKjaZsgwpSY9ql5kWoESzPJQpNhqhP/LBHgXT5s1GbyV9/E35J1XIFVcjWLM3zaGerqurp45rpZWUpvpE9Q0V7RYyXngAtPixVNex/HOc2n/9V2NVm2ErSpooFiT0trEb93qKbqJ2Qne2Zsh5b1xu+gMN5IPoVcic/zU5yTQe1GAszhvDk+74FNvgsC9XsC3GcFoCDuM80oBakQjysWKd3ItegnSwLk+zjGZRF0aThkZkHHHfK3pj1bP0dQ0JqiBTm4PBYlggZtBzeAuzF0/ZiSDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KCjsX397/2hHoO6eY+jnmgKy6d0iw5EanLra7DZqn8=;
 b=rGNN9ccIA2GND+Ch29BTFzyjmqDWs+AcKbOxzqK35QCJCTmQJkZ366lNCI/EAz4SwG+NeJDRTByxqD8VPvwdzSIy+bI3qk+BypZBzxrKOjT//lonpcMxnmdGat6DdJWeiEZlC1ZXmTRGdFnfcN9+ELqiYFf3WApMe6rNoElMNqktrEOrObt+NDmQyvJRkFkEdYB50JBZenePETjduuUc9tdCrdK7Nqm8tqGujPjxVkJoKZJcrY5PAzT6XNM9fC/px7JHEAY77Tv1scJWteniK8MsqXfkHXfV21qvQ4p6r2vlLIdK30SzAZvm6CTMg9RJqtDriHRuLI+qfatTF57xDA==
Received: from DS7PR03CA0142.namprd03.prod.outlook.com (2603:10b6:5:3b4::27)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 08:25:45 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::43) by DS7PR03CA0142.outlook.office365.com
 (2603:10b6:5:3b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.23 via Frontend
 Transport; Thu, 14 Apr 2022 08:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 08:25:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 14 Apr
 2022 08:25:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 01:25:44 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 14 Apr 2022 01:25:39 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <akhilrajeev@nvidia.com>,
        <rgumasta@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <mkumard@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kkartik@nvidia.com>
Subject: [PATCH 0/6] Add watchdog timer support for Tegra186/194/234 SoCs
Date:   Thu, 14 Apr 2022 13:55:32 +0530
Message-ID: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6557792-4802-4609-f99f-08da1df05f55
X-MS-TrafficTypeDiagnostic: MW3PR12MB4508:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4508D2B26C7CC6AE1F958BD9CDEF9@MW3PR12MB4508.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 245HcnL0wtuSY0npRDFQuWMhTxbvXkMEAuMe+8WaCpUr8x3gtf7xaEiAYBu4T7GNkybkBaqKeTwXboyB6RJbkOaNaxnjScwjqosLIbpg7cSGQ2nrhZyCygGkyLRSzg1ii1TYerLKjmdniTHr3e5bkuGRRG5/qlO++8IHZWkEpE8yAljk1v99rz1dP0JHN8NPGSIANUESl+U4H9QbdpxWhPJsL++2K+4XHc9gJTXbzrRIzxzetxYUhPVuRQfSnmW1gcWJmJfof4dGbb7J2TE41YulxYDyfKN6BFSfqAiSjbyazHgaRxnXdVC8zO6FIvT5OHE30KPqnzU0jOH1BP4v4d5x/+20Fc/JoAAnBcSY3nz5yFNDx6o4Dss/uPrXDThYLJFcQHRMzT1nL4AYZzZvXK3MdzdTNj1LoCIQ+jkTD/XppIN383hvsmgvauaTdDKv9IECdlUmsWBjj/GOEbxjtj8N+Zvk5jQvgseRRPVn8gMvJLW9q1Z2pHRuCaRI2GhxEnAEdvXdosDyGh1nk2LeGPQLd76ybznCimNEQtz+7OhqCa1VsmFS7WSgeD28M2K0Kmt3gFbOptCWyfXec3cKW2d/x4h/8RjCN9yEh3IhJIDVk9bOp7JrYrW/F+Lxv3iUHgUlgFhjuRT1bD+j3J/BGFgPYkK4tzv4ZhFGhEVyq6QL9gZKIPlR2S+JNjrY6Pbe/lYT44vfwrmmkE6zHJ6fKVBR/pzXalFrNB/Zca2Z7bs=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(6029001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(508600001)(8936002)(86362001)(186003)(110136005)(7049001)(356005)(921005)(70206006)(336012)(426003)(70586007)(81166007)(316002)(83380400001)(6666004)(40460700003)(7696005)(5660300002)(36756003)(82310400005)(26005)(2906002)(47076005)(36860700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 08:25:45.4235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6557792-4802-4609-f99f-08da1df05f55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 .../bindings/timer/nvidia,tegra186-timer.yaml | 116 ++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  16 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  22 +
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-tegra186.c          | 514 ++++++++++++++++++
 7 files changed, 678 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
 create mode 100644 drivers/clocksource/timer-tegra186.c

-- 
2.17.1

