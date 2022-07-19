Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4287E57A1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiGSOdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238326AbiGSOdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:33:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52B9B7CE;
        Tue, 19 Jul 2022 07:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwBg6ccoKw9V6Qd/lPWMB3MqTLTJcC5h6db/2NOIR9zUpidvGakL7j7h+0ap4V60Z3iW7EnpT6elf6rQF+pNl1oljpJlLXkdVxlLqCnWjxfAum3XtG7UKGx3V8803GJEPEqOFUns8EvbcAKfMJHUdZ/SRl2TQu6EnnrkVUeJZqicSfFkNWf3r77UilrygjpsI1QTaHwqufSNZVL4ufdUMEgyBenRyzmGtRQwGpfiXkJ4ZePft9EopqUjxEIW3f+9Ln+NZcqaevkDhC1sQrPHFZ/bfTDqnt43dfpiKyrsZ/9Cu57+bRn9ZaigBJe2B9/LjRJJxd2gUF1FpK0ughduyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4K9+rIbVDmMZntnKFxOTb7CqsQkvUoEzUcTSEzSCFI=;
 b=moaUt8JRQtQyi/sKAlZWy3R77mjqUY84j+/cxezhnPk/dDaA19BZ3sTbyD39srnAnI+i4TjesGEQpAwS/rRlG/oquR0tJdlUivPHkVbndqpGsuP/TNH/8DtvG2tDdm2ABBwoVNBiAXYiReTWhXLJBnHImKWYnS2J27GyAK8WuHpxrwbqBQRrPxHt/QbwQN0iNTez3hWdxVKsVfT+HM0UMaepNlDJ7JIFaXvb86mK0fsF9BehkYjQhR4BBj0pd+zTtGKtaNrY86uE6SH3b8OGzrqt2qSIXZVrRMbJYojR59UuDdD9Lyi+VG7xqMEPVbj9wwQAmXdDBG/raOkiu+vIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4K9+rIbVDmMZntnKFxOTb7CqsQkvUoEzUcTSEzSCFI=;
 b=RnECFjarpBZzcQp9GPy9TMBzCKTRZ5OqXxrPhG7uBKap09UvWc191qdj3LO6cUNB5R+IoZ+dDWxgkXZaZgB84ovb+poewFzZozwuffZk24DFH5ZihfnBjMYGzlK/jbGsg0bqg3MKPTgVrmq6dt5v5r9FhiNJaSzqq0Vy3ZS2H/Y=
Received: from BN9PR03CA0945.namprd03.prod.outlook.com (2603:10b6:408:108::20)
 by CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 14:22:17 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::3d) by BN9PR03CA0945.outlook.office365.com
 (2603:10b6:408:108::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21 via Frontend
 Transport; Tue, 19 Jul 2022 14:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 14:22:17 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 09:22:16 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Pavel Krc <reg.krn@pkrc.net>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] gpiolib: acpi: Add support to ignore programming an interrupt
Date:   Tue, 19 Jul 2022 09:21:41 -0500
Message-ID: <20220719142142.247-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc01b06f-6712-4ee8-a9fc-08da6992158e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvuWIDAe8VrQq+j3ldDWHcxSJbLTMiXISN0sgtO+BLBBc/BEZ3auaDXy0Cug1WxJGq9FATyPryw/ae+yFzLoA0+/R9isPcLfh3ZKB77bdJ3GiabEvuqFjC3p/t6Y+4/B5a+XkP9V8VCzMfaYlLAzh3d01cysGvytdslqdHb5tUxvak+7dHfc9LmaoqN/vl+X1Fo+1kgyZxWpnZbIBuXSYhv5Pcm0ETaOvrU5mG0/lZrvifPYaYx3DEgNZVGqTZ/XPdr7u6fY2Zrum/cpvuIiB2W5jhEk+Awz+QBr2vLVzsu0ufQxvXnsZWDaxCXynR9QLMtWOwQwARAYSvBXV0T4qfb250Fuen7sXAc0YEH8TYNvkJbDQ7ap3prjNZljzSovImeXpttFcA4xZLmya+1ojdhbJicwVGEbsnTthGkb2gBwnc0FvE3uFL6BlucFyrxjyH2l7MgcW40tAtXMi4ZbxLqr5hCpW21FTScYOgbt5ARQ0v6+dyjbBjBohEPgWDFXXW5zycBPxzg0SQEW7nTDVr6G8WaCeLrM1E3T4Q+ilz5MoavpF6xLtVVBbjnt1NX+WU7ZGMwEbR9URBYPnYGKzwud2SODzhQ6F4plLSC1P/T2GTglwy9pmz9Csqyz67w8sn/RyTVYKCgnSfgHHEtj0M7+Xufu5L9TUmxm2MqsqXNJ19AVNYew5SBF5BW1wsbtC+NiHHBGZARjCG3yNqzKOSi4Bmg/8abPK6QWu5Y91Uyy0OtXAF3okz8HfGeIrRXoaYcRTHmrACqSKrpfhQ/y8xLzJE8vnd8qCwCsw5+6B+hs4EV8t8jZ4h94HI9Z2fCW1NglLH2mat1SkAreQTFNTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(40470700004)(36840700001)(54906003)(110136005)(2616005)(86362001)(356005)(82740400003)(83380400001)(40460700003)(70586007)(4326008)(2906002)(8676002)(81166007)(70206006)(426003)(16526019)(1076003)(47076005)(336012)(186003)(44832011)(36756003)(7696005)(8936002)(5660300002)(41300700001)(36860700001)(40480700001)(6666004)(82310400005)(26005)(316002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 14:22:17.3534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc01b06f-6712-4ee8-a9fc-08da6992158e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiolib-acpi already had support for ignoring a pin for wakeup, but
if an OEM configures a floating pin as an interrupt source then
stopping it from being a wakeup won't do much good to stop the
interrupt storm.

Add support for a module parameter and quirk infrastructure to
ignore interrupts as well.

Tested-by: Pavel Krc <reg.krn@pkrc.net>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpio/gpiolib-acpi.c | 39 ++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index c2523ac26fac..375942d92d6f 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -32,9 +32,21 @@ MODULE_PARM_DESC(ignore_wake,
 		 "controller@pin combos on which to ignore the ACPI wake flag "
 		 "ignore_wake=controller@pin[,controller@pin[,...]]");
 
+static char *ignore_interrupt;
+module_param(ignore_interrupt, charp, 0444);
+MODULE_PARM_DESC(ignore_interrupt,
+		 "controller@pin combos on which to ignore interrupt "
+		 "ignore_interrupt=controller@pin[,controller@pin[,...]]");
+
 struct acpi_gpiolib_dmi_quirk {
 	bool no_edge_events_on_boot;
 	char *ignore_wake;
+	char *ignore_interrupt;
+};
+
+enum ignore_type {
+	IGNORE_WAKEUP,
+	IGNORE_INTERRUPT,
 };
 
 /**
@@ -317,14 +329,18 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 	return desc;
 }
 
-static bool acpi_gpio_in_ignore_list(const char *controller_in, unsigned int pin_in)
+static bool acpi_gpio_in_ignore_list(const char *controller_in, unsigned int pin_in,
+				     enum ignore_type type)
 {
-	const char *controller, *pin_str;
+	const char *controller = NULL, *pin_str;
 	unsigned int pin;
 	char *endp;
 	int len;
 
-	controller = ignore_wake;
+	if (type == IGNORE_WAKEUP)
+		controller = ignore_wake;
+	else if (type == IGNORE_INTERRUPT)
+		controller = ignore_interrupt;
 	while (controller) {
 		pin_str = strchr(controller, '@');
 		if (!pin_str)
@@ -348,7 +364,12 @@ static bool acpi_gpio_in_ignore_list(const char *controller_in, unsigned int pin
 
 	return false;
 err:
-	pr_err_once("Error: Invalid value for gpiolib_acpi.ignore_wake: %s\n", ignore_wake);
+	if (type == IGNORE_WAKEUP)
+		pr_err_once("Error: Invalid value for gpiolib_acpi.ignore_wake: %s\n",
+			    ignore_wake);
+	else if (type == IGNORE_INTERRUPT)
+		pr_err_once("Error: Invalid value for gpiolib_acpi.ignore_interrupt: %s\n",
+			    ignore_interrupt);
 	return false;
 }
 
@@ -360,7 +381,7 @@ static bool acpi_gpio_irq_is_wake(struct device *parent,
 	if (agpio->wake_capable != ACPI_WAKE_CAPABLE)
 		return false;
 
-	if (acpi_gpio_in_ignore_list(dev_name(parent), pin)) {
+	if (acpi_gpio_in_ignore_list(dev_name(parent), pin, IGNORE_WAKEUP)) {
 		dev_info(parent, "Ignoring wakeup on pin %u\n", pin);
 		return false;
 	}
@@ -427,6 +448,11 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 		goto fail_unlock_irq;
 	}
 
+	if (acpi_gpio_in_ignore_list(dev_name(chip->parent), pin, IGNORE_INTERRUPT)) {
+		dev_info(chip->parent, "Ignoring interrupt on pin %u\n", pin);
+		return AE_OK;
+	}
+
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
 	if (!event)
 		goto fail_unlock_irq;
@@ -1582,6 +1608,9 @@ static int __init acpi_gpio_setup_params(void)
 	if (ignore_wake == NULL && quirk && quirk->ignore_wake)
 		ignore_wake = quirk->ignore_wake;
 
+	if (ignore_interrupt == NULL && quirk && quirk->ignore_interrupt)
+		ignore_interrupt = quirk->ignore_interrupt;
+
 	return 0;
 }
 
-- 
2.34.1

