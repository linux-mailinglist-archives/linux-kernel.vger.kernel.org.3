Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E0A5930F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiHOOpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiHOOph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:45:37 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD3D25D5;
        Mon, 15 Aug 2022 07:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOS+SiOG4DfKDz6iszCoz04FAVkHNZ0HAPAIi/9xCIu7WYiznTNzOSUOCo+V/7yKN1j+Wx2FWkqE2ckiG4/7UwDgb2I7+hpqxo2nzEJJDR0Kzm8Ctstddb5ZUTG6+wsf9snAtVMQmIzwaUT6tqzv2GNOkL6Qk2AtA9P0eYT9Nj4Nllg9vY3I2TcWlbObR1LEyfpKbfbSVAH9yOMqFvJkY0B4X/v4eYOZOk9O6gl8Hn+ZUfVATFL6UdbzrmfHeGzJldF39N5vtFveO1E8fBkV/tRo9U5g3x5hhQDg14a6mOLXprvHb4MdexC0i2bNnEn/al2bNDsCwdI3iPfjvGfVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/14NfztUiuxu3WZXH4IDIW9ZmDE+yI6NXjl7+KgnkDg=;
 b=Tr4WLqEqKEgFCZv19VCR6pU3PsgHkyEwbneTmpWaHa2a3PZ0svOoh5tjK2kGPUz/FxDjdDy78Ay71+EC95N/GchRcJis56/J+0r8E/+tyUtUY/dTUo4SQFVGV9bVgmasVqIHQBA3TwEO2V5/zB8lpGOQF0F11TRu4zyXK+FSy8QMKLKg3WNaB2wlUeF+di6a8cIlvo4k9IyU1AqOoRD3LYM4IN1nQzLVGiAQHkGOGSA2NPLqlx4d31jtVZyVoAz7aOasGTy1JfyHfVmDtV7qmtGterTGLxOOTVGgHGmlOLvH6jXC1pJJ8PxwSvYIPmcI716uO4M5aXT4znoJwv55+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/14NfztUiuxu3WZXH4IDIW9ZmDE+yI6NXjl7+KgnkDg=;
 b=LpCKBg/gH47aHCRdUBc7Qys9gutJ8HTG+KSDaRYMLxtB21gI79j/BPztHp/GXjd+/iaC07VyMmUNVjxTgFGaI5VsLQgTgNGRUpdY82imK8pbtIXP4zboCp31MGNk6Hh0wo9jPeAadUumjrL8KRnx15qwm5aNQ7Lt5mcNxOVY0OHUdx1tIHdLPCNy0dn0tvys9auwUs/BzStTOwlBvMtLXJKQAn6oHZwADjuUahkmRVTcEzYeg4tBv/0hF5dX8owvMqjg3VLq/uI6oodUFMR7gbc59bVm3nUHl4jAz9abS3cjNJR6D7CQ6UC2chm6EBFt6gx73baGkZGDwrLxD5dtPw==
Received: from BN0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:e7::19)
 by BN9PR12MB5354.namprd12.prod.outlook.com (2603:10b6:408:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 14:45:35 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::aa) by BN0PR03CA0044.outlook.office365.com
 (2603:10b6:408:e7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Mon, 15 Aug 2022 14:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 14:45:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 15 Aug
 2022 14:45:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 15 Aug
 2022 07:45:33 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 15 Aug 2022 07:45:31 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <jckuo@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <jilin@nvidia.com>,
        <bhsieh@nvidia.com>, <linux-phy@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH 1/2] phy: tegra: xusb: add utmi pad power on/down ops
Date:   Mon, 15 Aug 2022 22:44:48 +0800
Message-ID: <20220815144449.9525-2-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220815144449.9525-1-jilin@nvidia.com>
References: <20220815144449.9525-1-jilin@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a4788e8-fd03-44c4-9410-08da7ecccff3
X-MS-TrafficTypeDiagnostic: BN9PR12MB5354:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2oiVS/V80VjXTxe8FpKumCM4qwReZGHPtTdwJu5MJ0XsUrBGRuP4OjAHpLK0q85eaViM4f5xYp+XckD8UALUe1EeDEViMfhvTf5ch0rnnRFom8MdbqlLA2fA9po3h9xHbVO5XdkdjXqiYljyXMYbARdhAErFZeXzh2uFJ0o8iM5IAPL/f//jtTsMY9XAeBB54DwhE2KGS020VSswqz+lASdHrwA0oR4O4TUXBusR2JIbPc2etCIZegvCN+Jx9yysD20YF/R5XfM5v0OodbxWSKqfQP/L3diJiaQAaRSvoH5mvB3hsO6pdPYyKIscV4s2yE5+7C+bzbvSEa2WaYTtdW/guy83UhFWytAPoFyNNKa6d44A4ESprp2WV5/IAUvG+TDMgXnAwmPzgIwjSId5zWMs7GfaY6PcPmwirMQFxwv5L3QWeGlVheRHAvRrBKfzA/w4wmUykMR0rFSNImD27L5e7rDBf+3POTatLJE60DZQfycF62TDQ+dY2t2FpXCSSoteADXFq/fqsUrq6BwNHZdewAy63VqjNr5lf7JVkyumAPWCJQla+hHyAvP0H0DzDX0M72wEF8KGgBMwZydfIqz2sCFrY+DasiDpUhuTyQ0FPms6CTjA/ECz4NKiXTTHMOmgG2E+3DaKGOU7MzlqfSFJ/kuqlBkpHPsH3xq3BKlvFbHgL6l6gRT8CTZYPSpBEsSlDz+5GTzmP30OssW1qdTK6GXCI+wic9HRXROAJeahIiTxEIhJh3kDC3/SqFrl0nPvh4oM4UB0IHj6H05OL3W0mOyK4RNgH3AeJj9skENIwR9rFIZmmbVbeTp5GAiuwyZCnndMWdkzSZZlQF3eqQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(40470700004)(186003)(8676002)(110136005)(70586007)(6636002)(40480700001)(316002)(70206006)(40460700003)(82310400005)(8936002)(5660300002)(82740400003)(2906002)(4326008)(54906003)(36860700001)(81166007)(356005)(86362001)(36756003)(478600001)(7696005)(6666004)(41300700001)(83380400001)(2616005)(26005)(1076003)(47076005)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 14:45:35.1746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4788e8-fd03-44c4-9410-08da7ecccff3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add utmi_pad_power_on/down ops for each SOC instead of exporting
tegra_phy_xusb_utmi_pad_power_on/down directly for Tegra186 chip.

Signed-off-by: BH Hsieh <bhsieh@nvidia.com>
Signed-off-by: Jim Lin <jilin@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra186.c | 19 ++++++++++++-------
 drivers/phy/tegra/xusb.c          | 22 +++++++++++++++++++++-
 drivers/phy/tegra/xusb.h          |  4 +++-
 include/linux/phy/tegra/xusb.h    |  2 ++
 4 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index ae3915ed9fef..5abdf81aa143 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2016-2020, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2016-2022, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <linux/delay.h>
@@ -638,7 +638,7 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
 	mutex_unlock(&padctl->lock);
 }
 
-static void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
+static void tegra186_utmi_pad_power_on(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
@@ -656,6 +656,8 @@ static void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
 		return;
 	}
 
+	dev_dbg(dev, "power on UTMI pad %u\n", index);
+
 	tegra186_utmi_bias_pad_power_on(padctl);
 
 	udelay(2);
@@ -669,7 +671,7 @@ static void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
 }
 
-static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
+static void tegra186_utmi_pad_power_down(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
@@ -679,6 +681,8 @@ static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
 	if (!phy)
 		return;
 
+	dev_dbg(padctl->dev, "power down UTMI pad %u\n", index);
+
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
 	value |= USB2_OTG_PD;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
@@ -849,15 +853,14 @@ static int tegra186_utmi_phy_power_on(struct phy *phy)
 	value |= RPD_CTRL(priv->calib.rpd_ctrl);
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
 
-	/* TODO: pad power saving */
-	tegra_phy_xusb_utmi_pad_power_on(phy);
+	tegra186_utmi_pad_power_on(phy);
+
 	return 0;
 }
 
 static int tegra186_utmi_phy_power_off(struct phy *phy)
 {
-	/* TODO: pad power saving */
-	tegra_phy_xusb_utmi_pad_power_down(phy);
+	tegra186_utmi_pad_power_down(phy);
 
 	return 0;
 }
@@ -1486,6 +1489,8 @@ static const struct tegra_xusb_padctl_ops tegra186_xusb_padctl_ops = {
 	.suspend_noirq = tegra186_xusb_padctl_suspend_noirq,
 	.resume_noirq = tegra186_xusb_padctl_resume_noirq,
 	.vbus_override = tegra186_xusb_padctl_vbus_override,
+	.utmi_pad_power_on = tegra186_utmi_pad_power_on,
+	.utmi_pad_power_down = tegra186_utmi_pad_power_down,
 };
 
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 963de5913e50..49873718d54a 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2014-2020, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2014-2022, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <linux/delay.h>
@@ -1458,6 +1458,26 @@ int tegra_phy_xusb_utmi_port_reset(struct phy *phy)
 }
 EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_port_reset);
 
+void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+
+	if (padctl->soc->ops->utmi_pad_power_on)
+		padctl->soc->ops->utmi_pad_power_on(phy);
+}
+EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_pad_power_on);
+
+void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+
+	if (padctl->soc->ops->utmi_pad_power_down)
+		padctl->soc->ops->utmi_pad_power_down(phy);
+}
+EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_pad_power_down);
+
 int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
 				    unsigned int port)
 {
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 034f7a2c28d6..8cfbbdbd6e0c 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2014-2020, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2014-2022, NVIDIA CORPORATION.  All rights reserved.
  * Copyright (c) 2015, Google Inc.
  */
 
@@ -412,6 +412,8 @@ struct tegra_xusb_padctl_ops {
 				    unsigned int index, bool enable);
 	int (*vbus_override)(struct tegra_xusb_padctl *padctl, bool set);
 	int (*utmi_port_reset)(struct phy *phy);
+	void (*utmi_pad_power_on)(struct phy *phy);
+	void (*utmi_pad_power_down)(struct phy *phy);
 };
 
 struct tegra_xusb_padctl_soc {
diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.h
index 3a35e74cdc61..beced277f40a 100644
--- a/include/linux/phy/tegra/xusb.h
+++ b/include/linux/phy/tegra/xusb.h
@@ -21,6 +21,8 @@ int tegra_xusb_padctl_usb3_set_lfps_detect(struct tegra_xusb_padctl *padctl,
 					   unsigned int port, bool enable);
 int tegra_xusb_padctl_set_vbus_override(struct tegra_xusb_padctl *padctl,
 					bool val);
+void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy);
+void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy);
 int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
 int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
 					 unsigned int port);
-- 
2.17.1

