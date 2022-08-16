Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E6595820
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiHPK0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiHPKZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:25:45 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A574119853;
        Tue, 16 Aug 2022 01:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OefniQ8ogXYc+3g17+UZ4XKmpJl7W+kItUpyuvph5LDx8GXyEgK1aj0aafoBd9lYnc+s9BzqTOBsD34PI7UDk9P3rEb04RUNl+lD1mPOi2By5yXJ7KVItLlhZ3mACPfeEF/hWCxgv34tu2dzqDTMv4JfelOfvs0S4vyYJl9bGaCPNH8ktY8uYFyJcqqT8GXlSh7snKiskd6WrSuzH/iqYDZyk4uJlRxUW9OxMhfJFP5yv9BcyqQwZgRI6l+uhM/jSs54MRyVO+0qx/9QnCblnjvoexYFcql9cCLxbUuv3QZdEkWJ/GGX1qGsD2zm/zH8xtqUuFg4UCtY6nYSvvmX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxGHuh/DMTItO7XZn0UiWcvHfQdVQmVOiacOK6UDZw4=;
 b=asqvnxtBGgQO03+U1RZkGDr6aZWSL9yMAgjkT2XzUEW0DI8l48aBhsyUA2a9pWc7pXh32ZSqPaSx5bDrB6Ue3FWbX4/474XS9BDMCNnRyAJ1s/BRQN6J2Bw3ftGAkxCVc1Po01gQIpOGlYE89OZX0WSFgWC1/1RhlxxRAigJo1TNMQY7DcvhdAdB9Tm55JIEydaoytGBlkpqqPJkGppHdiEqlHbRQRk6EahmsBVBNrZV2MZ28LO4CA7UA6Dv17qKz5pJ1U+ZOgtcyi9UQjesuARWDVx3ikqZfMoqQ1ROEJBnMm6vyZdty+HJuNBmv/Wz2TE38noFoyshTGyhCWOZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxGHuh/DMTItO7XZn0UiWcvHfQdVQmVOiacOK6UDZw4=;
 b=laEwcZHiTONQqltc+8lrk+OjSf9arEqM8EOb9DUun48qowkku4pY2IfrNCCNFnpEZZD636jQ3CKrEwPKfP6wLpYS4UGiJEw8uNsWWwO0Z0E8JKJTqTPA1EeXCWRLKTj+RyOL5JK48vkiXRSQEE+25ESomSDni6cTsS+YKtVSii2MIakdga9lrfHpbtvVwIaNqFwuny8ccJHLg+aNaNFJXmFJVncyYnSQcplMqKPvGMIDAlmrf7anDOFA18BfPWed1yxQiE7CVq34WBGr1HR3jhSN1rZBQROi0gWu+w3XyN0CNCRf8t8gwToYNPCeMnG0oaHPV0LgBsnzZembcV3b+Q==
Received: from MW3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:303:2b::31)
 by BYAPR12MB3528.namprd12.prod.outlook.com (2603:10b6:a03:138::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 16 Aug
 2022 08:24:03 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::f) by MW3PR05CA0026.outlook.office365.com
 (2603:10b6:303:2b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Tue, 16 Aug 2022 08:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.7 via Frontend Transport; Tue, 16 Aug 2022 08:24:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 16 Aug
 2022 08:24:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 16 Aug
 2022 01:24:01 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 16 Aug 2022 01:23:59 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <jckuo@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <vkoul@kernel.org>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <jilin@nvidia.com>,
        <bhsieh@nvidia.com>, <linux-phy@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v2 1/2] phy: tegra: xusb: add utmi pad power on/down ops
Date:   Tue, 16 Aug 2022 16:23:52 +0800
Message-ID: <20220816082353.13390-2-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816082353.13390-1-jilin@nvidia.com>
References: <20220816082353.13390-1-jilin@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f74c9d9-587d-45a6-2e5e-08da7f60add2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3528:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WaTPDdz3SFCy41aJriWpdLMkhTOGws45KaFuhMBsmgE0x6eWP5KL7xv2cfm+MN0jSgaj5a9/2bNibSraEfBcKXBkMTFP34AhWnEKTd+wxFZIEUw764NtKnYx72spcrmiTxzltAg9OLzl68vGclykJEzzOphKPrrlCeFoLJr5QSzB3w+DWp85GepGTPE4ZdMz2p5MWw5zKMlUkpksE0glC3cKKjHbusz8bWo/P+8uAiJ1e/ESJ7OdrXc2qIMG4sojwoa7yV0fawXY+SckTfY4M33Bc+h7gV3ePEZE4C2WAVQYiVh07rz/gdZWHx6SQG3meMd+pHNukYYWWSn4sxQG9wsdi2P7Hjo255PizybKlo/BvDW1dzDtNu0jhbPgwFW/79aRKePNUw9YJUt9d1oqCQtLyoq8tBNRv8DzrU+Ng2u05x0kSVX9NevPY16yPg2/GOpYMHmW1XevlGUUsF3OEIKqwnBjLbxM0702DqE1nfs7jYCM5oFMRcBqY8Zz1KPbYm5f7YqnuVTzQsvnYC3D1341vl1LESMWka1i+7++/2t3LXbIMFYSkxDrEj+/WgFRLsiTSeC6wHSSVct0BkFko2c6ciUgPecG/IsgVhrre8rZd3KTO0mjCEREufAclgcSV4UVnV/0r+aLutM395qriTjjg2d1qZ9gSh65QJKcKPtelIYoAOPpnnRP5WHu+Fmub434ZhgtTRdpsgykZhmbG3+8UGkQoEwqkGn9I29BU0yFmOkRbxDgostUAD4htJUOBxwsZNOqupz9Nmau/mtUWmZUsnKNLgzoZyQCCH/8D00DsDUFiQwsgfqE+c89zIeWU47wg0dJ2qtxMnDwxiNxfg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(186003)(81166007)(336012)(1076003)(426003)(356005)(2616005)(82740400003)(47076005)(5660300002)(36860700001)(8936002)(70586007)(4326008)(70206006)(8676002)(40480700001)(82310400005)(478600001)(83380400001)(7696005)(40460700003)(6666004)(26005)(2906002)(41300700001)(6636002)(86362001)(54906003)(316002)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 08:24:03.4917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f74c9d9-587d-45a6-2e5e-08da7f60add2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3528
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
v2: update copyright year 

 drivers/phy/tegra/xusb-tegra186.c | 19 ++++++++++++-------
 drivers/phy/tegra/xusb.c          | 22 +++++++++++++++++++++-
 drivers/phy/tegra/xusb.h          |  4 +++-
 include/linux/phy/tegra/xusb.h    |  4 +++-
 4 files changed, 39 insertions(+), 10 deletions(-)

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
index 3a35e74cdc61..70998e6dd6fd 100644
--- a/include/linux/phy/tegra/xusb.h
+++ b/include/linux/phy/tegra/xusb.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2016-2020, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2016-2022, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #ifndef PHY_TEGRA_XUSB_H
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

