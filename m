Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F6519DD8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348672AbiEDLXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbiEDLXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:23:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485142A244;
        Wed,  4 May 2022 04:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuEFBgETK7A/GtntsE53daJOpitWK4Ee1gko8yxT+fgmm/6AbBCT0rgG8fTaQ7qrEAGekhFLkq9Eql8lZ5QilolBrltL79LGiQSzzGTHKyOHvrQ69h+7vq8jxJjqPb2iyPRFKdv1GIso4qyRAP8csOnLLZlPxqjDBST9p61garC/JHmGieww+4s4D67K1bAEI7X5WHbDUFgKErZXBGnkv9u/4+uxFlrs2/HkRp8HxnClUUxWdn5PCbLuGl6qs79L/uVrkUmQaaXqVGeI0k2D2MebP787qUqaWbrPSSHa4+hf29VCJU038qLCJy7rHDN41qpxVH/brGX/qYbtUMaXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cX2xAFxbOanocCvyPtIatyA/9Br6/sM9XNzTwPhJr1Y=;
 b=KlucmTAj52nUBGm1p9cAZb7HWOtffdLPNjZKPabA127btZ7Z8oFU3Ip4d0KjHI8vZuGpj3rBnXCjg8I54v7dB8BlcL1SiK0xUbh9N/2h6qPEy+UUj9a7lDvjPqSryRprZk7dKaks6n3VGKnqk5BHvShAMVdUrD2c8Jp/LMChdmJC1ML+G9sNsXlQwTlORvpw0r/ZWu9P5n8Jm8c/zDL9AnZe7a4DHydCG7tqmoEq4wEnxMoEJHdgEiznoxTL/iRA768qRA2/K+IOkBeueZJvFhC8GGSwaOXzE+NcGsxI+eanU/j+jARTVHTocnvV99L3hZI0MC+oiDYU7TXQ38/vYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX2xAFxbOanocCvyPtIatyA/9Br6/sM9XNzTwPhJr1Y=;
 b=b1r20Uf1TruUVXjpLTlURyot+v8L4yboQ/4TGSwpLsYG8ZiXZCDb6OR9tYwwlHSNym9UiayOQAfKXg75DzZzeVmPymuv2IlTaJHFi64/zNegp85HAF8lY9Z4B4XfUmp4LEV44gNogEb0XXMzxJoqUgga2o/IcAxkvjuMCtJ0num5p7bXruPaUSRq2NrDtTqrKdv1/b6wBVQTvC8X3Z7+IWJOgovYiZjRIDGFOrzush+mITje20ZGp9m2/teZ/A3e/NggkVsaoXf2nK9NlFUm84iad7WpF3p8YestX54kZwOcyO8JeAMqFKRhsNYU1os2zq0hJdgEYb0O2dNPymkJYQ==
Received: from MW4PR04CA0294.namprd04.prod.outlook.com (2603:10b6:303:89::29)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Wed, 4 May
 2022 11:19:43 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::b7) by MW4PR04CA0294.outlook.office365.com
 (2603:10b6:303:89::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 4 May 2022 11:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 11:19:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 4 May
 2022 11:19:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 4 May 2022
 04:19:40 -0700
Received: from moonraker.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 4 May 2022 04:19:39 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] gpio: max77620: Make the irqchip immutable
Date:   Wed, 4 May 2022 12:19:36 +0100
Message-ID: <20220504111936.8412-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfcbff98-c781-47d7-799a-08da2dbffc64
X-MS-TrafficTypeDiagnostic: DM4PR12MB6397:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB639714EC9A09FD7790B80C30D9C39@DM4PR12MB6397.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0x0kWcJsk7LiDi823Gi5oyM5RXuHR5y6up4n6rroOUBfveaNfh2jQ1XwiPJHqceQ8VbWz/dknZWRCTlF16F7ZUiZA9+xpOd2f2QnHAr3dZ2HGnvu/nR0UwGypne8lioFLyaLIw8T71XAqtt5ZQsZctRJhk7qRXi1vc1+fWKhFbluvgMsE3EwKVXpI5j5PmGJAF/w4jZJsIbwK9ttr938MZ5jPrWo4n9KFXHAn1+aapcgUvQOSgwUQSKCPZ6Eb37ltNicwdK6wtkIRJo/UyDRw7NtYWtO/p16Oou2hPxdHEvLTJmrgK4TcdENVHZXNEqK2bd6+j/dA86iE1N983zechP4zgo4tIUQu2+7vBkgAqowX/ROsUJxAEHIsE1zAHifSkwfW2A0jsU5IWYBSEeUB8pLyhiHuh425PL9o4AQAojvdmjG8C5ScLQvn3fG+0cOHWcoUQ3OybPw8o3hAlnZZ+hXbCDODKS6YbVDxnGgHvUXqaQug/DHm/txHRP1L9S2TydWlqH7cQFpkpci5+WTt8DJZPRczlKnF1gUniQfswyaeG0bzJamehPc1+atYSe6JIMaR9PIuuDSqBVFhRKDlbWBKapCNO93G2WRfkTMFd0VXSupQMTiZ6b0eyNF2Uduy+F9JehAWQ3cRpqVsRK6Qj0tFznNnBRpNLChcnFK48otkOOl3PwdWn8LU1PW2NsrYn5vprv++rvQTinSRWkj2w==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(70206006)(5660300002)(7696005)(8676002)(356005)(8936002)(70586007)(54906003)(316002)(508600001)(6666004)(110136005)(81166007)(86362001)(36860700001)(107886003)(2616005)(83380400001)(82310400005)(186003)(426003)(40460700003)(47076005)(36756003)(336012)(1076003)(26005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 11:19:42.1543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcbff98-c781-47d7-799a-08da2dbffc64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
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
This warning is observed with v5.18-rc5 and so it would be great if
we can fix for v5.18. This is triggering a kernel warning test failure
on one of our platforms.

 drivers/gpio/gpio-max77620.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index ebf9dea6546b..aa92658780d6 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -119,14 +119,23 @@ static void max77620_gpio_bus_sync_unlock(struct irq_data *data)
 	mutex_unlock(&gpio->buslock);
 }
 
-static struct irq_chip max77620_gpio_irqchip = {
+static void max77620_gpio_irq_print_chip(struct irq_data *data, struct seq_file *p)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+
+	seq_printf(p, dev_name(gc->parent));
+}
+
+static const struct irq_chip max77620_gpio_irqchip = {
 	.name		= "max77620-gpio",
 	.irq_mask	= max77620_gpio_irq_mask,
 	.irq_unmask	= max77620_gpio_irq_unmask,
 	.irq_set_type	= max77620_gpio_set_irq_type,
 	.irq_bus_lock	= max77620_gpio_bus_lock,
 	.irq_bus_sync_unlock = max77620_gpio_bus_sync_unlock,
-	.flags		= IRQCHIP_MASK_ON_SUSPEND,
+	.irq_print_chip	= max77620_gpio_irq_print_chip,
+	.flags		= IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static int max77620_gpio_dir_input(struct gpio_chip *gc, unsigned int offset)
@@ -318,7 +327,7 @@ static int max77620_gpio_probe(struct platform_device *pdev)
 	mgpio->gpio_chip.base = -1;
 
 	girq = &mgpio->gpio_chip.irq;
-	girq->chip = &max77620_gpio_irqchip;
+	gpio_irq_chip_set_chip(girq, &max77620_gpio_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
-- 
2.25.1

