Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C6151A276
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351458AbiEDOsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351448AbiEDOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:47:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081BCDF88;
        Wed,  4 May 2022 07:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0yK2L5S8x0Um4KMd+/gAS9wbqo2oJ8JujZI1fIJT8m7ObqCzhLG26fRWaKL2glpZTuyq9PaVCEGbJ7gUoaxw3t80EDO61jGQkWxmDV80RPF5GZmm8M885ouCjAqvuWzr6tDvQAgXKcBL+YZjUITP+Eq9cQ8ztTrSaAv9ax610LBOfs835UDFNlgrw37SPEuPHIubpLi5tsgiMiw5nKhNkAeoS7kIejbyIl2sZ42U5jvUqvr6ST+Z8OavlKzQmF5gEfYUyGNLi80eYuPiwI6SF58jOoVN0bWeYDWzhbR26s3thASiUZoGFN3Ji+9UhYQwcs575i6s2qipBqKpqigPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC4jUhvnp1dHe3uZdo/nuw9lQ4EliNXa+4E+C+IIBcA=;
 b=Stx+twrLUGVmF/BH+GyO/gGESIHxVAI6PHokYBoz2lzS1DDGAB8zOvXM4vdln5WooV2hmT3j9vhgczL7elyuVyZF00Q4JG2001Pc3vm5DmnWqngFnUaRHZnnDHOv/HrfQaI41hCRN3e/uHg6JaZ0JrTwBYfnBjLV6hKqYQEtoyuiYMK44LBNxk8tn+INKM0jionCg9okJqU+mgyaB3as09NBkOGTXc/waygnPQx9I2TLl7zeohz5yTGsJHNo7NNjCu4xAgYaHQbSmFUwoHhc75Wm3VL00l51Y/tMRmEnJt90ncvBilBTGxjbm6YiwD9oM78S4gmHewwH0FjbtuMERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC4jUhvnp1dHe3uZdo/nuw9lQ4EliNXa+4E+C+IIBcA=;
 b=IjLEbe8cf6TgZdxfPiAQCHuOv8FXrQX7F02eSXtEiQvtY7KZ6MohVw9TZ88Y9w+Kmh7YRAZJIPtMwErgj5ZmP1cJhaquYatgxWH2DmPG6n9bjd/ZCwcv9C+Te9d52v+gO3GbwiNSXMWSl1MrvvUz4pZMB6YswW6ud/5/sF24ttiI/iQo8kNb5VvDWLGIHVdoWgrN7/C2dNSywKvwif2T0/gq1cKii+mBK+Xy+hJU6nUOo83mdPgCen3QLdA9z/kv5/OMsD3+gn2EciEF73qFoSliiRrabxfnpE85uIkpTiTy7w/RBwZScPiy4E2p7Gx0Gqk436MWeL+ewCK2DxHgSA==
Received: from MW4PR04CA0355.namprd04.prod.outlook.com (2603:10b6:303:8a::30)
 by DM5PR12MB1914.namprd12.prod.outlook.com (2603:10b6:3:109::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 4 May
 2022 14:44:20 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::40) by MW4PR04CA0355.outlook.office365.com
 (2603:10b6:303:8a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 4 May 2022 14:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 14:44:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 4 May 2022 14:44:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 07:44:18 -0700
Received: from moonraker.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 4 May 2022 07:44:16 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2] gpio: max77620: Make the irqchip immutable
Date:   Wed, 4 May 2022 15:44:06 +0100
Message-ID: <20220504144406.36744-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b8f180a-dc97-4261-7402-08da2ddc923e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1914:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1914D3C7ECFFC149FFB1FCE4D9C39@DM5PR12MB1914.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 806uWJVb/y18wvq4ESkvrlKisf/QjMz41tRNevdU3YfNGwbCH+nvkt+hBAPAFiclg84qr14aBF0cR5Zvs+aiTq9pzI0tFn2sshMxNE8QA7oOXwa5wXfSAriEMoJviq3qOpRtJvCAPKiBUWyowtQ8eeyAgI/5MOJvAtr+vSv/vKlgqzH4SOxY6gbLzlaYIqu/KED9Mxi4HURxVs1LQnJaZS/Zt8euSWeqrQGxBE9eui80cRQNnAZw+nUxHOPelmv1hR8+LpR0Hj9LZRHsdRs8q1eteuR7u1yGiHEe86L+NX1D4l75RNEs92b2H72Gu2gMsok04MclwokgNRnq/uhHXn7H2ocGA5D/uqAmDI4McbyLVstX4Al1Xp+Fcs3SVRKch/0QA4WZE6DDBSok4us7QzA2gN9w4CDBb33cF5Nj9ia2eyYWgR5Q0LHWo1MSKTMp9vstK5n5Xdym9EXo0BGnUCVkV8Y6Y6oPSr7cht6/z8h4RJ4RLZ09dSeWPAN1vs6rENZMDEpCUUpW3oPGfaDv2esU/ywEFkqflv5vjMU1mnRoSj7bAFjxzjr9evOPGMlAauY2SyvPY5dfo00JG1T9wNwTks8CVB6nv4ySU1cOKWhFQPNYdoTcBNMUnIJZAEs8+tgR9Z1HGa6w93ePug4pH78Pv7+5HwQ8hP2JdRZE/M4sclXuQuKI0U7ME55QOcLR9mklhG3kq23eCFQKMmsJzw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(316002)(110136005)(54906003)(356005)(508600001)(81166007)(426003)(107886003)(8676002)(4326008)(82310400005)(5660300002)(83380400001)(70586007)(70206006)(36860700001)(36756003)(2906002)(7696005)(6666004)(47076005)(1076003)(2616005)(336012)(186003)(26005)(86362001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 14:44:19.4093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8f180a-dc97-4261-7402-08da2ddc923e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1914
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
immutable") added a warning to indicate if the gpiolib is altering the
internals of irqchips. Following this change the following warning is
now observed for the max77620 gpio driver ...

 WARNING KERN gpio gpiochip0: (max77620-gpio): not an immutable chip,
 	please consider fixing it!

Fix the above warning by making the max77620 gpio driver immutable.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Changes since V1:
- Dropped irq_print_chip callback
- Fixed up the irq_mask/unmask callbacks

 drivers/gpio/gpio-max77620.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index ebf9dea6546b..c18b60e39a94 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -54,6 +54,7 @@ static void max77620_gpio_irq_mask(struct irq_data *data)
 	struct max77620_gpio *gpio = gpiochip_get_data(chip);
 
 	gpio->irq_enabled[data->hwirq] = false;
+	gpiochip_disable_irq(chip, data->hwirq);
 }
 
 static void max77620_gpio_irq_unmask(struct irq_data *data)
@@ -61,6 +62,7 @@ static void max77620_gpio_irq_unmask(struct irq_data *data)
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct max77620_gpio *gpio = gpiochip_get_data(chip);
 
+	gpiochip_enable_irq(chip, data->hwirq);
 	gpio->irq_enabled[data->hwirq] = true;
 }
 
@@ -119,14 +121,15 @@ static void max77620_gpio_bus_sync_unlock(struct irq_data *data)
 	mutex_unlock(&gpio->buslock);
 }
 
-static struct irq_chip max77620_gpio_irqchip = {
+static const struct irq_chip max77620_gpio_irqchip = {
 	.name		= "max77620-gpio",
 	.irq_mask	= max77620_gpio_irq_mask,
 	.irq_unmask	= max77620_gpio_irq_unmask,
 	.irq_set_type	= max77620_gpio_set_irq_type,
 	.irq_bus_lock	= max77620_gpio_bus_lock,
 	.irq_bus_sync_unlock = max77620_gpio_bus_sync_unlock,
-	.flags		= IRQCHIP_MASK_ON_SUSPEND,
+	.flags		= IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static int max77620_gpio_dir_input(struct gpio_chip *gc, unsigned int offset)
@@ -318,7 +321,7 @@ static int max77620_gpio_probe(struct platform_device *pdev)
 	mgpio->gpio_chip.base = -1;
 
 	girq = &mgpio->gpio_chip.irq;
-	girq->chip = &max77620_gpio_irqchip;
+	gpio_irq_chip_set_chip(girq, &max77620_gpio_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
-- 
2.25.1

