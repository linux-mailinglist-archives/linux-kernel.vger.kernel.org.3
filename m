Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79039564F8A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiGDIPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiGDIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:15:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CB1BF4D;
        Mon,  4 Jul 2022 01:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT5fVYCt2lFMKZGddpsDyISACYsHrMVF1webe6/NBeoTTdA5tvpLS2IU35RmzwJkHz7Xg0tqXhzo8ezHMT1xNZLGWURgGVOcHJhiNKZJ5bfH5n5b76RCv/WvPIzLFQXAelJtstzCM8n8G41Pg1gcH8I/FxH/fkRGBNh+C3FSsKoW/ziJaZCzymqUbMZU0+iVGU8/5pV+MgRjAtc6ot20+YxI9IIBpKRASKPNe233ApQ8zmp89MwSo0yKMEQ0gEm8EHI2eFujslNUgQAdh1pnl4T+eO88sKC6X4s+FMQvTzyXzxaC4IIucR2Dou/ppdt02zl2OLBV40hp+F8wkYrNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npopQAJP7ok2klS0KMbrSAbtluBKFRnqahZ2Y6aZHfs=;
 b=boauH3QfRz6M8zmjJXcwLDAjql5UoyHBuwTAcjpI67HirTmn/2a1KFsczfwKOg1dL/p3SQCzy3cgFNcs8fz9OYsEDa68o3WL7+no16dYt31q1+SYJRpsOW+iV/OGJKX9gsWIeFSpQw7rHvFOGIvfsMAFogip5rHh3byWymkmtL4A2nm8kjZL5u+RjR9K4zWIjmpiU59+r7zuQe7hVm4SpnNWoCOB/nuPUESFjxjc/SxON2NOBVtTBPkVdSqpSWOTy5WjwuzflgJI1/8nSJbeqhh0Pu7CpS3110dSOf/FPioDgc8DhPuSDzERLs8uQdK6ReFbT4tnc0LAaaXK7js3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npopQAJP7ok2klS0KMbrSAbtluBKFRnqahZ2Y6aZHfs=;
 b=mnMGt/NtlwriTb02rQOf+Br4BLR4i4fiRAas6KdRjBE1eI8E7yjsDmbDrrAXklEYUXlt1c5zb8wCaGs32NhIdPLNEvMcMV3VHsWkhup6XcabwAxODC9RO55qvWxOfU9QRLy904OibKLEyYWGBGRGmFMN5GAmgk8ds/PQdL44EO1gxIFh9tztr+CIqdWEz7rh/Rg67Fv3yZ6P8nsVbr2eWiUg/t9FBZkCfXwULV0L+gIWew/L09hdo4AhUZ5bJBN5lk0igm/RQgmlha2OdB/a84aLgdIZHdnLAjb9IGQecs+62BLnyfqtWUyL7Y4t0x80zp6caPhSJCWlflHLCPcAMA==
Received: from MW4PR03CA0170.namprd03.prod.outlook.com (2603:10b6:303:8d::25)
 by MN2PR12MB3135.namprd12.prod.outlook.com (2603:10b6:208:c4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 08:14:07 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::a2) by MW4PR03CA0170.outlook.office365.com
 (2603:10b6:303:8d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Mon, 4 Jul 2022 08:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 08:14:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 4 Jul
 2022 08:14:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 4 Jul 2022
 01:14:02 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 4 Jul 2022 01:13:58 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <mperttunen@nvidia.com>,
        <rgumasta@nvidia.com>, <amhetre@nvidia.com>,
        <akhilrajeev@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 3/6] clocksource/drivers/timer-tegra186: Add support for Tegra234 SoC
Date:   Mon, 4 Jul 2022 13:43:39 +0530
Message-ID: <1656922422-25823-4-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
References: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e9a4014-c3ac-4df8-554a-08da5d952a1e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3135:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKZgq1znK/Did2tXZP9VRrXZHs0uncXtp8cITbEnPeWfXKeLnE8Wr6nL8r8PA1Fe0DpF7Q2+x2AXZj6m0M6wxhg1PoKdfPTSXSIjX1i8uSaDSQv+59j6d8Fsi2oNQB5ace70o0wL3yBnej5ZQEEVFSaUZ0iSO2wc0gdYlYGqStC32AApnInEIC3R+LbXfw1IH470cTJDHZIobH94bDAMeoNyMmaHqrn7cfaRJtZlQSkesLsMNGPDQgueS61yGYrOEp4o8xJKkQTcfSbhlVX7ntmatJSxzy1EF2OIaKg6SLdHDVx4rb8q7jXPDCDyXGQA2zPRCIa7/ydQWteKMMSMzlgitG+U2SgYc+n0PFSTRG4gXLIEkalEPd8aOlaRFZOsoz52e2F2g6SxyJuMK7Zfg/GLb27pt5YuvWEOHqa1d13Ssx3xDBrfQ7RsWwwXnK/7plro5W4cTzVS6vss5+OHKxfNjUNouXsAN94wKjNGp14XTDxaxKG0SYDNvbTyZlm7y1CNEf8pDS8t6qS52ppxWfHDd7M38T/hALkTlZbS6PQBuhGX14wBgl5nC4nDDWa0X8mM5fVz3Jr/Xf6/ChH7buukYzEQPQ960KKEjf4hEyrihZe9n2tmTD1jvyy0lB8BeKH9LCeVAVYB0L7QVn6zZfjn9U4f4juzF59Tn2Xy1yissPhxUyRm74yzLkb3g6intWIWPG8lzvWLpXZZ/28VfbQqa0XvNpABvsamFNKe7tctjLTRGkJHTVgoRvWbuzwZd/WSF5rIAZCrtvnrWs0/LW3fu+dUo3+IY0kf5vgwlGnhohJEu5QWv5cXZZi4Cy8WRc4fBVT1gAVRRq09uhhRqD0huuV3lB1RlI7kKQlit9ckWYvsoEt/dKzmdhAGPxrB
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(2616005)(186003)(40480700001)(82310400005)(6666004)(47076005)(426003)(336012)(8676002)(110136005)(70206006)(70586007)(316002)(83380400001)(36756003)(81166007)(7696005)(5660300002)(8936002)(40460700003)(4744005)(86362001)(478600001)(82740400003)(356005)(36860700001)(921005)(26005)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 08:14:06.3394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9a4014-c3ac-4df8-554a-08da5d952a1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3135
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

