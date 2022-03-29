Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1334EA758
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiC2Fsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiC2FsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:48:15 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2061.outbound.protection.outlook.com [40.107.101.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C49A24B097;
        Mon, 28 Mar 2022 22:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtIhRGnRbnEic8g4lrFQC3nG8fJ09ZgBIFrGjA7Tas6+DLOV6/RklDAS/u8xw1Aq0TpRKZ1oSqQ5f2v/zsFYJxQAWnWfe/gZSyBss4Z78H1ZgYpo86xl+6dSSATF+BDt3RY5AypmS1UNty0cN//BB9/xwacub/Rn2+zPWVpGLlmvvzYdCYA46OVy4sg/jJQN9+8DVjbhK74UlbOk50vVqMqfIDShCyHFMl9C8xX4gKQlc3WirK8bkZCoTMy/gKS/6Lg3/Xq6qCfHNBBmleDx1YMCa03u7GaGgiXFo9v6t2JVq903mBYforhYjU7Gbt9/jU7q5cSCEKjRP71JSosyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRI6kL7yNT8HooIeIU0PExPKsGgL5P6JEYbDonuuSuc=;
 b=c2q8I4h/tWA9OOFbFSM9/8L0MxrF03NjcJjzVlZ8IxW4nkx++Lrw1rKPAzq+Cf6vgBAxrXBkx7SkwWkjvHKWJZ67Gtw7ezcl8TvZQgKnOd3EOj8NtRwm7Ig/Gz6vXpzGU0lExB38awjDPqvblT9VvVxHBAQ5pdQj839Hb6fKgmaDnyfqiIo6kDBLQj6Lp4npGHxKIU3zsBJ15Tdk5z8EMY2k64lYbm1mdkYWwkzCCO4X3SuGPWgixAa56vUqSZ91mkVi7WOQz9Ix/+J7FrTkH/8Fky6LoZwgsAXr6hBwUq4xQ07b6joO56vUdsIXjiNPoQChoWer0tY8iJX/mWV9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRI6kL7yNT8HooIeIU0PExPKsGgL5P6JEYbDonuuSuc=;
 b=LhgRj/zvcdN24Xo2XYTAJ2xWU4swy7a2IGjfMiCA+gakKEAoiBZiJMp0ksmFN57Z9hAem1XkuSmBOItGQRgLFYUWh1dTf+SqPPldAiQJyyXdtuq1/w+lUbvywmhbADjE09xHYXV7l/ZeFSgWOLM64DsSgYEEY8q/sGg7Ig2Dp2P8fMWCe26eVlv8PVxN+dQPWVRiLyPp7XnC5VO/L4peIVLUSkqMb5tbgA3Q0ZIdaklgl2UfpjKZx1fBGyOhrtsfq77+7iUktSDyo7ytR/YNiFIkJHS//WMH3hGebse4OD33Q8QadyTDGK+6MDk+y7mRQWYbLyQCWkBtlkt1v8CKcQ==
Received: from DS7PR03CA0129.namprd03.prod.outlook.com (2603:10b6:5:3b4::14)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 05:46:11 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::c6) by DS7PR03CA0129.outlook.office365.com
 (2603:10b6:5:3b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Tue, 29 Mar 2022 05:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 05:46:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 29 Mar
 2022 05:45:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 22:45:32 -0700
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 22:45:31 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v5 06/11] gpiolib: Add HTE support
Date:   Mon, 28 Mar 2022 22:45:16 -0700
Message-ID: <20220329054521.14420-7-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220329054521.14420-1-dipenp@nvidia.com>
References: <20220329054521.14420-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43fc6546-e46c-4e19-4d23-08da11476e60
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4090D3EC1158EEFF622B5CD3AE1E9@DM6PR12MB4090.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jc2hoUA413WdIYxqoZXy5ncrIY7H9o19bNsv3d8ZIzp18OcI21MybeVR9bfbl5iKwJQiP/bbhcRzjTvVAU+IS5w72R8OIE2S9kFOPzSEhagilABnVGBLa9pNJTIQDcvxeTEhIKIXskw2+rLd4K/kO3D7RJF96QI4H4qTMxTJJmwqo6OBwJlE2pc7pxfUKgqp1GXQ11hxTDpxCCQEGJRpzHjB1WxWxSWZkquzo5j49f4kERnFmvlaZo2FNDUMbxGzc43yBl2Nl7YwuLIWwuMYS/eIsM61dtECMZIBmyxXrEzv/gnPoj2v7OMpD+x57DZ32M3tvJiq1wG/7M96tXMmIDVmOEWsfOC4P2E8d0rsnkzNNrhRBwQVEOgMlN+PcMiCTCLQViKYGRY08ExRiLERPh0wkwXuzOEixJ67J1AKDRDts0HhvROou2H9ydYsMXvxu9gIhCY0BJ2K6A9ByG6HEmec9+DyUANfGHiZssLqAngrnAGudkugV2qC58AdDAm9I2et2skDW9zQghLMsA5QbRJog6pCZKafWRWFL+h/E1ftxKgN2WkWgpSXXPrMmybXqPS3gGpqvI0qP/gHGPo3e4mcehJ7z9P1CTGKY3KoItDlYaQ/blONjIGmMTCc6RvBAhQAUYfg2jt34ulSUvQBQQt8YmZLK15JFy91nr943agVyrmC0vMHwdLzCsMiVmNAUqXulqoVW/6hqT8rzhqq1fqIsQWh3QBmUNnrjqUbcI01uBI0gEi1PkERjaD03WJEf7lSsimBapP57qz+S6ZODw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(36756003)(7416002)(70206006)(508600001)(356005)(81166007)(7696005)(921005)(47076005)(8936002)(316002)(186003)(83380400001)(107886003)(40460700003)(110136005)(86362001)(1076003)(8676002)(70586007)(4326008)(5660300002)(26005)(82310400004)(2616005)(336012)(36860700001)(6666004)(426003)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:46:11.7095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fc6546-e46c-4e19-4d23-08da11476e60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 56d090258d62..d355026892e0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2422,6 +2422,64 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 }
 EXPORT_SYMBOL_GPL(gpiod_direction_output);
 
+/**
+ * gpiod_enable_hw_timestamp_ns - Enable hardware timestamp in nanoseconds.
+ *
+ * @desc: GPIO to enable.
+ * @flags: Flags related to GPIO edge.
+ *
+ * Return 0 in case of success, else negative error code.
+ */
+int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
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
+EXPORT_SYMBOL_GPL(gpiod_enable_hw_timestamp_ns);
+
+/**
+ * gpiod_disable_hw_timestamp_ns - Disable hardware timestamp.
+ *
+ * @desc: GPIO to disable.
+ * @flags: Flags related to GPIO edge, same value as used during enable call.
+ *
+ * Return 0 in case of success, else negative error code.
+ */
+int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
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
+EXPORT_SYMBOL_GPL(gpiod_disable_hw_timestamp_ns);
+
 /**
  * gpiod_set_config - sets @config for a GPIO
  * @desc: descriptor of the GPIO for which to set the configuration
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 06f3faa9fbef..29a7d39062b3 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -158,6 +158,7 @@ struct gpio_desc {
 #define FLAG_EDGE_RISING     16	/* GPIO CDEV detects rising edge events */
 #define FLAG_EDGE_FALLING    17	/* GPIO CDEV detects falling edge events */
 #define FLAG_EVENT_CLOCK_REALTIME	18 /* GPIO CDEV reports REALTIME timestamps in events */
+#define FLAG_EVENT_CLOCK_HTE		19 /* GPIO CDEV reports hardware timestamps in events */
 
 	/* Connection label */
 	const char		*label;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index c3aa8b330e1c..7eaec081ae6c 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -109,6 +109,8 @@ int gpiod_get_direction(struct gpio_desc *desc);
 int gpiod_direction_input(struct gpio_desc *desc);
 int gpiod_direction_output(struct gpio_desc *desc, int value);
 int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
+int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
+int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
 
 /* Value get/set from non-sleeping context */
 int gpiod_get_value(const struct gpio_desc *desc);
@@ -350,8 +352,18 @@ static inline int gpiod_direction_output_raw(struct gpio_desc *desc, int value)
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

