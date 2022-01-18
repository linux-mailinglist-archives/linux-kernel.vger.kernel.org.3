Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA584912BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243976AbiARAS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:18:59 -0500
Received: from mail-sn1anam02on2057.outbound.protection.outlook.com ([40.107.96.57]:11230
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243861AbiARASr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:18:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiMpdJwhZ1AEnEC3pCQJ4KrjO4Fk/9+UbGNq3sOiVnGmb1n6QKGeQcsa79Jdfy/1JH/xZcptklppO9ec36MT33No3BysTrQvpPqxLH7W+jrr/McdGpNRyFGMtzva71m0qm8zWLL6ihxSxQt3K4fIhdIAWPPr819MDt3GZOBRuzayzjb6IBEUXN6GX7Q1MEmUokcpzifa4bb607jaPx6jhl1S6FI0tvlLuQb3NT0Qw2Me92Q+RDKXhsnTL9mcBA2DGssbPrdWy4HygZbrazBubpgV4ZuTb7DzfCrBJjd4/akG3HlluPGfH6Ri6bli53T212IXVTt+szkrJTPloHnXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9KPrzulc/Y/asdJt5ooIuV4AiO22q0nS5X+Yzi9Huo=;
 b=KoUAuBf8Hfy+oiASpEydijCfXCO8dmqrKVLu8WY5pT2Jj0XRQ1fdnPRqzZVMR2IjWFcg5qIY1ijsWGpqxF36KhDPHe3U7C92klqVeLlR5J90BisTo8rWmfcVqT6CvcqbBwYnN/oatuBivCxZIUaJsEN+5dO0YvIo+HZIuhjl+qEqIm6C73u8vsqTsNp5RNOPmXA+d5WqENlx2hy/T8jEEa/5RjUx/Z5kFlIpnHTcj7E3/861WVdWML6fS9yKeJeXGcQpYC4VjvilYKUIR9Yoi6AQZCNRCx//ImgaaHa2w92E3E4n0+p+wkFEXvwpHKdEmtv3Fsd+wlhKgSJt3CktNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9KPrzulc/Y/asdJt5ooIuV4AiO22q0nS5X+Yzi9Huo=;
 b=VGD8T5ovKLykEGfiY0KTiEpRSOuWTWuCukq17/Zs9Gv/9syBhjTSvIcJ0zTiIRyjX+Ue1ob4nRf+Sk6Ga+ZzVAfVguhFpL/10lzrfrrvDHWvKjyiedZsL8X+is4MDAbtRkxO0msuCjkszm/dSQZV4Evn2whsrGFWirhMGjui1vvk97tOvjlSqdUMtdOf43uU0vaoStBwCje4aGPsmCYmFrJ539A6QTtnd5dfxbX6TwhocXr527KPtdPaeKevq8lDwvZcALC4566ozGa5xkljXXG/yeLh89AC/l4cyHHFGt+1gfNWLk5M/YluwI/bbKLIM3dKr5T5Ai0gv+bW553BSA==
Received: from MW3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:303:2b::12)
 by CY4PR1201MB0134.namprd12.prod.outlook.com (2603:10b6:910:1b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 00:18:44 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::41) by MW3PR05CA0007.outlook.office365.com
 (2603:10b6:303:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.4 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 00:18:44 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:43 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:43 +0000
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:43 +0000
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [RFC v4 06/11] gpiolib: Add HTE support
Date:   Mon, 17 Jan 2022 16:22:09 -0800
Message-ID: <20220118002214.18271-7-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118002214.18271-1-dipenp@nvidia.com>
References: <20220118002214.18271-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c137f75-568b-4748-28d9-08d9da1816a1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0134:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB013464EA7B06BA78B91A9746AE589@CY4PR1201MB0134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5jux2q+IjUsgZe0LTq6e6Uma/3jLUbIKcbf4ZpG4wUgtxXNbd0WcbVRSQMIKJlfaPOJGLo2SpgFzw+XEVD7zwg+hoeA6RXLQrMTXHWQctq4kIsPKHRkjFGtBH55fNM/i6lzXsMLbiIjWA6vkWyeVC2HTehZm2lKlZecQdYnikK40r+TR1Ou3qV9RGry+e/umd5f8mRTTKErX7CEZYHvxhTu82XEYKjbGL4G75qJBmPtDKy2xHdeTYtJbu9OOtXVUVAsle+uz4X9Ko121pnZSUz1ChKqGQccuAxmU/jeAAXlYmYmaPJ1PncbubbiPiM3jy9Y0upKyN+y1lvjl7TFCJK5wtgV6M1oqNahD4gmOfF3awA9D4D5Z5UJFuux65+/V35HRPsxP8CKm4ENF6TS7+jsiL7VSNHF0BZ4s5sXCB1+dKYHMdjp0y/caTfTo614g3puGL6f4ZYCd1EP7NGynJiHbJMvoR0SWmmoAi1HteaMP8J5rSnKSsrjYwBZbzrHqd1L1EKR/V8lKhaAFyd9G76JhAx9mLkMAEnkojqxcalPqGlU/gqXoVGzKMHB+KoRKVwrofvoi/gT9tSHDXnkpVvYhlBw3Geqp1Dy9XSyQ95sdkkU96er/aMlyaWYXYXFdedByOGlCxBcRNcvtaWnENt6+JlEB9c3Wj9Mv7SDnuR8YopnY/G8hCPL7l+ehHVGLHH8HNtxZpiJAgSxuLcQkiQ1GQufVCUNqCESMe0zBVVAcLOPIZKiQ47kZI86SmF8YklprVybO1UYnp69VHIzrEUMAMusoC7dopxpYSWjh9Jt+3/7I0aPC4qWeqTBBKqBBHv4QeQvK95IqP6G2duEjLn+0kDc+pzI4g+Zc1LLUik=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(508600001)(8676002)(8936002)(36756003)(36860700001)(83380400001)(921005)(70586007)(4326008)(5660300002)(316002)(6666004)(70206006)(110136005)(40460700001)(356005)(81166007)(107886003)(2906002)(7416002)(86362001)(186003)(26005)(426003)(47076005)(82310400004)(1076003)(7696005)(2616005)(336012)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 00:18:44.2116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c137f75-568b-4748-28d9-08d9da1816a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some GPIO chip can provide hardware timestamp support on its GPIO lines
, in order to support that, additional API needs to be added which
can talk to both GPIO chip and HTE (hardware timestamping engine)
providers if there is any dependencies. This patch introduces optional
hooks to enable and disable hardware timestamping related features
in the GPIO controller chip.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes in v2:
- removed get timestamp and is timestamp enabled APIs

Changes in v4:
- Removed gpiod_req_hw_timestamp_ns and gpiod_rel_hw_timestamp_ns APIs.
- Added callbacks for the GPIO driver to enable hardware timestamping
functionality if supported which takes gpio desc and flags as arguments.
- Added APIs are called from GPIO provider rather than gpiolib-cdev framework.

 drivers/gpio/gpiolib.c        | 58 +++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.h        |  1 +
 include/linux/gpio/consumer.h | 16 ++++++++--
 include/linux/gpio/driver.h   | 10 ++++++
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3859911b61e9..e9ffee5f4bc9 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2424,6 +2424,64 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 }
 EXPORT_SYMBOL_GPL(gpiod_direction_output);
 
+/**
+ * gpiod_enable_hw_timestamp - Enable hardware timestamp.
+ *
+ * @desc: GPIO to enable.
+ * @flags: Flags related to GPIO edge.
+ *
+ * Return 0 in case of success, else negative error code.
+ */
+int gpiod_enable_hw_timestamp(struct gpio_desc *desc, unsigned long flags)
+{
+	int ret = 0;
+	struct gpio_chip *gc;
+
+	VALIDATE_DESC(desc);
+
+	gc = desc->gdev->chip;
+	if (!gc->en_hw_timestamp) {
+		gpiod_warn(desc, "%s: hw ts not supported\n", __func__);
+		return -ENOTSUPP;
+	}
+
+	ret = gc->en_hw_timestamp(gc, gpio_chip_hwgpio(desc), flags);
+	if (ret)
+		gpiod_warn(desc, "%s: hw ts request failed\n", __func__);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gpiod_enable_hw_timestamp);
+
+/**
+ * gpiod_disable_hw_timestamp - Disable hardware timestamp.
+ *
+ * @desc: GPIO to disable.
+ * @flags: Flags related to GPIO edge, same value as used during enable call.
+ *
+ * Return 0 in case of success, else negative error code.
+ */
+int gpiod_disable_hw_timestamp(struct gpio_desc *desc, unsigned long flags)
+{
+	int ret = 0;
+	struct gpio_chip *gc;
+
+	VALIDATE_DESC(desc);
+
+	gc = desc->gdev->chip;
+	if (!gc->dis_hw_timestamp) {
+		gpiod_warn(desc, "%s: hw ts not supported\n", __func__);
+		return -ENOTSUPP;
+	}
+
+	ret = gc->dis_hw_timestamp(gc, gpio_chip_hwgpio(desc), flags);
+	if (ret)
+		gpiod_warn(desc, "%s: hw ts release failed\n", __func__);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gpiod_disable_hw_timestamp);
+
 /**
  * gpiod_set_config - sets @config for a GPIO
  * @desc: descriptor of the GPIO for which to set the configuration
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 30bc3f80f83e..33acc5754630 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -117,6 +117,7 @@ struct gpio_desc {
 #define FLAG_EDGE_RISING     16	/* GPIO CDEV detects rising edge events */
 #define FLAG_EDGE_FALLING    17	/* GPIO CDEV detects falling edge events */
 #define FLAG_EVENT_CLOCK_REALTIME	18 /* GPIO CDEV reports REALTIME timestamps in events */
+#define FLAG_EVENT_CLOCK_HTE		19 /* GPIO CDEV reports hardware timestamps in events */
 
 	/* Connection label */
 	const char		*label;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 3ad67b4a72be..e85e590e3ce8 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -112,6 +112,8 @@ int gpiod_get_direction(struct gpio_desc *desc);
 int gpiod_direction_input(struct gpio_desc *desc);
 int gpiod_direction_output(struct gpio_desc *desc, int value);
 int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
+int gpiod_enable_hw_timestamp(struct gpio_desc *desc, unsigned long flags);
+int gpiod_disable_hw_timestamp(struct gpio_desc *desc, unsigned long flags);
 
 /* Value get/set from non-sleeping context */
 int gpiod_get_value(const struct gpio_desc *desc);
@@ -353,8 +355,18 @@ static inline int gpiod_direction_output_raw(struct gpio_desc *desc, int value)
 	WARN_ON(desc);
 	return -ENOSYS;
 }
-
-
+static inline int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc,
+					       unsigned long flags)
+{
+	WARN_ON(desc);
+	return -ENOSYS;
+}
+static inline int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc,
+						unsigned long flags)
+{
+	WARN_ON(desc);
+	return -ENOSYS;
+}
 static inline int gpiod_get_value(const struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b0728c8ad90c..f28d1e9b61f0 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -320,6 +320,10 @@ struct gpio_irq_chip {
  * @add_pin_ranges: optional routine to initialize pin ranges, to be used when
  *	requires special mapping of the pins that provides GPIO functionality.
  *	It is called after adding GPIO chip and before adding IRQ chip.
+ * @en_hw_timestamp: Dependent on GPIO chip, an optional routine to
+ *	enable hardware timestamp.
+ * @dis_hw_timestamp: Dependent on GPIO chip, an optional routine to
+ *	disable hardware timestamp.
  * @base: identifies the first GPIO number handled by this chip;
  *	or, if negative during registration, requests dynamic ID allocation.
  *	DEPRECATION: providing anything non-negative and nailing the base
@@ -416,6 +420,12 @@ struct gpio_chip {
 
 	int			(*add_pin_ranges)(struct gpio_chip *gc);
 
+	int			(*en_hw_timestamp)(struct gpio_chip *gc,
+						   u32 offset,
+						   unsigned long flags);
+	int			(*dis_hw_timestamp)(struct gpio_chip *gc,
+						    u32 offset,
+						    unsigned long flags);
 	int			base;
 	u16			ngpio;
 	u16			offset;
-- 
2.17.1

