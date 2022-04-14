Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218F350084C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbiDNI2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240859AbiDNI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:28:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F144A3C0;
        Thu, 14 Apr 2022 01:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzkkQeYDWbMSWzBxAtvTGR/kSdM/26qAPYY++vvYQ0x4maIn3nbtHFCdiQC77DcrMjVa0yj412ZTWcLS8U3ZhB3bQ4zvGzYE4SYoNdBcCZIcw6LdltRI7XDeVky6Pxpn54d9s2noEKkryFSJbJ8KAR/lI3XSgt00QCoA5W6vrh3dTepHr2T7g14+ltFj3aRRVmwQiIqumRl8e60wkW3dGH892V/cgTmoere2eeTuJCIiO2xyRgqaDNGvBvPubbZgBBPg1S1+bfzb988G8+qm3XGtVcJ6jR59KIXnoYUE5KNCLaI2CF9RrT328Kv1WLzW1BSlE8x3EzsBsTekvb7DAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npopQAJP7ok2klS0KMbrSAbtluBKFRnqahZ2Y6aZHfs=;
 b=O3wOFW+e7TAKDyWXyUa491k6o7zEha+BsCX5yKubT1ao/cY6+g2NJ3SZmvy84xLYd6s7u2Y39MUUlxquP7lRjfCWloxgPfHG59E0XRWh88KW21J7hvMvfywIK0y6/0CGiEGn6Jx9QMYEWTN0pIPpJZs92jeqUXtzIchwbGutmksK7wCP0Z7IF6CthRf1LXYmOpl+e+QDeXuXrnfF2rdUnMDL9HZNnbRioBbpv/SK0/IxPfJ6n2uyFZKkWKhLgQ1oruHmyRNKbNYpPO04jfGtesBXO60VXwN6hoEyRlPJ/3cd/q+NjTNuTFz/vXukHq5isKiqQDFxNCQ0Is3mMwFeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npopQAJP7ok2klS0KMbrSAbtluBKFRnqahZ2Y6aZHfs=;
 b=FDaQPS4ksuUBD7MilasHL1DwXjTD2DGLGM9kL0ZFU81NJkNDQZ1SRBIWCQT+6qdqFYIi+2p/sN7eNI0xXQtW4bC+JeZZu4PsXIXhAeonSIfa6givRK9tNDEataeKRdrakY/9gwBvPPrFHgY0YtQW204HQhhpAQE8X2RZGfNLpR9IzFr9ZMBIh+K+jJwp1XivB8/t8vpgU9E5qoCjpmPvpTFbv98gRArwCMl0dZorONNQ9MXT4i0772GudkEMuHtqMCQczFdotHlXyYxy7K56TARsbktdh5mRjk0u2qFqpGl2Y3HYgBnLF5rnh3gpLuv9dz4GGyQ94Yd7GuxEZjgAEA==
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 08:26:00 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::7d) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Thu, 14 Apr 2022 08:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 08:26:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 14 Apr
 2022 08:25:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 01:25:58 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 14 Apr 2022 01:25:54 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <akhilrajeev@nvidia.com>,
        <rgumasta@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <mkumard@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kkartik@nvidia.com>
Subject: [PATCH 3/6] clocksource/drivers/timer-tegra186: Add support for Tegra234 SoC
Date:   Thu, 14 Apr 2022 13:55:35 +0530
Message-ID: <1649924738-17990-4-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
References: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7790612a-87b4-4025-d868-08da1df06841
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0234:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB023422010BDC75E8C5F78ECFCDEF9@DM5PR1201MB0234.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gojVAIOsJ3XSdOfo4WMQpaI+BaeEggxwEE3D7CDXagYZTLDQvpn863uJ9Sjh+5nq/Waujb73PlQ0hI38FECXlrh2BFLNHSOQudRYJ6HX7duUbV59SEqMzPC+V5F7r5ZJaQGkIdLxsSnpQkqcFpbihpzpnd6B/ut5c6dH2zQGfNeFqviXkIw8auxttt5amqx36hDjIWpUtrXNcvDJ8bxX7ZSsaUKuSCHSPDsJ70Vh7rm6oXmB+N7oZMsFiKcMLmSZryqa6GaTUt69lSN+FIbAxbwQtvt8zmjXIGAESOz/yHkTg4ioLs8e6mbanOqdVznj2ZpzTwCjI78GdOxg8aOKhiEEsD+L+w0493SWCbRTJaOnMmP0QsrantQzmK2VleKOwCDWtpADgp3bRb6oIGHf2fwCTIiTFMGoBQaiTUgp18m9nUgZXZSA0SIT3RWRarCO8QvMbYJDUnT669RVp40nzyeJk6ryrhFBBTCgRK2RdhhjAUV4f8mMfIIhOl56taOIjuN2ZeSCJKEBD6LlhB7y4R0FnqtWYo7pebfRfT2dAx2n1sX/YgJD1ROE8WdbrZn1oBWu13aUlyqCE+pSqu7NSupEa7iLLpFmyI2ierT4v6kZ6oLQNHIPHRFgw6FWd6cVILpQrdsu9WtLq4ckx1PkSvwXRRU1/pHg1tbTYfilmhK10iJ5RTLUOVCGHY+9jfFU8l4J5vM3wrUMUZl5KT+tj8g9l0KahSnReeqsmxy6Ii8=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(2906002)(316002)(47076005)(110136005)(921005)(4744005)(70586007)(70206006)(82310400005)(8936002)(508600001)(2616005)(40460700003)(7049001)(36756003)(5660300002)(36860700001)(86362001)(7696005)(81166007)(83380400001)(336012)(6666004)(426003)(186003)(26005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 08:26:00.3598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7790612a-87b4-4025-d868-08da1df06841
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0234
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer IP block present on Tegra234 SoC supports watchdog timer
functionality that can be used to recover from system hangs. The
watchdog timer uses a timer in the background for countdown.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/clocksource/timer-tegra186.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 4515517c87a5..ea742889ee06 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -486,8 +486,14 @@ static const struct tegra186_timer_soc tegra186_timer = {
 	.num_wdts = 3,
 };
 
+static const struct tegra186_timer_soc tegra234_timer = {
+	.num_timers = 16,
+	.num_wdts = 3,
+};
+
 static const struct of_device_id tegra186_timer_of_match[] = {
 	{ .compatible = "nvidia,tegra186-timer", .data = &tegra186_timer },
+	{ .compatible = "nvidia,tegra234-timer", .data = &tegra234_timer },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra186_timer_of_match);
-- 
2.17.1

