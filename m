Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA558867B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiHCEZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiHCEZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:25:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2055.outbound.protection.outlook.com [40.107.96.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D907A56B89;
        Tue,  2 Aug 2022 21:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTSrg6GjFV+FqeXs2mnuNo7iyU0IK9eF//lHXwjOGhsiE2TwwA34i+zMyg+GCG3xctkYY2AYReB6JgEjZVWtUZ/I18CZJGXdE5bDw3XIXlkxItX0YV2e87G65pln7SakUW2w+YoRK6/TGQraxg8jrjxD5W5EJ415YxnPKNogNm1FjbivKQRk+YKqKEEJ8M28IXQ1MvE1oF4avXvu4NMRU1aYQ5NQMeM83znWz3ESD2sB13FlUh5nZTqw+5o+JeEGYUWESu6HyvLRVkDtXZW2lR6Nyzpi4aSuyiEMh2BKwrgtbPSfzV17PVCmj2HWYxA52LNz8kZE5OhXPDAyO0pJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbgNuDJ1Nh+Nso2OFUAHPVfNDB8oXbcyeEOid1fq2bQ=;
 b=DZ7okwifEezIFrXn6sXaTcfSWUoYxwRj45frop1e3ejawOqRa9ckV86oubv+rh18Z7Sb+bmsw12hkK/A0iNZyLe0IS1YZYghhXqCfRoEkEv2LQPbkc0fZZSHNul9vbRyuM200t0KqDPW4OIq5tnierydPTafg04H8wgK+wNwlKGz7sMK+HUGG3K/gNzozdY1d4m+Jtg7O6ZLujbNFn8miN7zGoM17EENq/85cYv8avL2XUujd9Xkrb2Rd8dGmTQwg6I/HDLqCA0zOE1bUFJ5EzW9tV/8IEe8YGGWLpbGNEsTz4g8tf85yzSYx60RLkSueUgOOcli+X/nLC+zWAMKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbgNuDJ1Nh+Nso2OFUAHPVfNDB8oXbcyeEOid1fq2bQ=;
 b=IY8DaShfaCPLuThw9VMwOxesuobnNi0JYSFOodfpiUBZDw1lDBDLgIQqkgPgcEiZyExkNFn1y1cQACn6wRIYmnDO0dc+4Iicar5NGIuyw3TDKDCfbDAbv0MdN0cYhqr7H8tNXZvSKCFRfAhfUbZWlFtRrTK/+6mCYUO8n9bw+Gw=
Received: from MW4PR04CA0084.namprd04.prod.outlook.com (2603:10b6:303:6b::29)
 by BN8PR12MB3603.namprd12.prod.outlook.com (2603:10b6:408:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 04:25:38 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::88) by MW4PR04CA0084.outlook.office365.com
 (2603:10b6:303:6b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Wed, 3 Aug 2022 04:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 04:25:37 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 2 Aug
 2022 23:25:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        <linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] gpiolib: acpi: Add support to ignore programming an interrupt
Date:   Tue, 2 Aug 2022 23:24:59 -0500
Message-ID: <20220803042501.515-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9cac76a-dfd7-40f5-d66e-08da7508378e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3603:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/wY/G3ZADbpgTe0b98cF+jKDnevHs/LL++4XDl5JHDKctt8pX1rVXOGTUZUd+2tmGdkIemE1v0E4cEITG9pPl7Ehg6erDLzfRVGxF5yiVKDcefPIJ0YTWmKrX0SRt18vACkt0eleNNEmooDgiUngqsEuBP55H2eQaIuEcx0qA1PUTxyua4nQov6JGpBeBmg6Eck7jUxvXPHq/nOA6zfHaFlbQiBZIOlka7UMBH+8XtPWjsQARRS5PzjJrJAg5NUbKbKMEY7r5dRV2MkpwuPgQ+bP4BUs86iqyCtWc2pXddD7jAf25cPAl1fEhvrRGO1KpMJc+jjEwdxz00tf9wHKp0XkPaKFDnLrajkAq1eQWGZ69ZJa7EylyC6ynrr4JV5zGfty/AzxjLdsoEEJIQ3QQ4JK3msHvpOHMnVTu0B4e4XiHQDFAu/OPTSeuchYybzOJTMfLxut2ackJ4Gcz8gYB2sipXMZtRNlkwf4WYxmFPb2+GrR28iGQ7TZYTXUCCHS66CBPWTNRBtZfUUc9uuqDXIIiEfgm84hJqq3naenM0kGHQ0fv1ZjQ8poeKtoSdIL1/0o7emmkugP94UAB5l4KjRC7yKoQYt9yngRZvVbOLmq2p8gCe2T9N6x1Wkvmkaxe6lqlprm1QHebds0emauvdE6IkOlDycaSe4QrBU5sPYjLBslAR9W42o9/ukqVpHPO1OYjngJoZuxpVyLCHs8yhA3UGiQ3b76HJcQBiKXFqWbZycXA9T9msPsVDVdMzQHjnAyyGQEpnjKVSnPitRoohnU6A99RuqGAy+2CooLyBZzaGA2E91qZhyy5DDaU5GmLjcJbRAR0otnDyOkiLEZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966006)(36840700001)(40470700004)(6666004)(70586007)(70206006)(316002)(82740400003)(54906003)(4326008)(8676002)(5660300002)(1076003)(426003)(44832011)(336012)(47076005)(356005)(41300700001)(81166007)(8936002)(2906002)(83380400001)(86362001)(40480700001)(186003)(36756003)(478600001)(16526019)(40460700003)(26005)(110136005)(36860700001)(7696005)(2616005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 04:25:37.6767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cac76a-dfd7-40f5-d66e-08da7508378e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3603
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Drop enum
 * Drop Tested-by tag

 drivers/gpio/gpiolib-acpi.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index c2523ac26fac..f993f6f728ad 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -32,9 +32,16 @@ MODULE_PARM_DESC(ignore_wake,
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
 };
 
 /**
@@ -317,14 +324,15 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 	return desc;
 }
 
-static bool acpi_gpio_in_ignore_list(const char *controller_in, unsigned int pin_in)
+static bool acpi_gpio_in_ignore_list(const char *ignore_list, const char *controller_in,
+				     unsigned int pin_in)
 {
 	const char *controller, *pin_str;
 	unsigned int pin;
 	char *endp;
 	int len;
 
-	controller = ignore_wake;
+	controller = ignore_list;
 	while (controller) {
 		pin_str = strchr(controller, '@');
 		if (!pin_str)
@@ -348,7 +356,7 @@ static bool acpi_gpio_in_ignore_list(const char *controller_in, unsigned int pin
 
 	return false;
 err:
-	pr_err_once("Error: Invalid value for gpiolib_acpi.ignore_wake: %s\n", ignore_wake);
+	pr_err_once("Error: Invalid value for gpiolib_acpi.ignore_...: %s\n", ignore_list);
 	return false;
 }
 
@@ -360,7 +368,7 @@ static bool acpi_gpio_irq_is_wake(struct device *parent,
 	if (agpio->wake_capable != ACPI_WAKE_CAPABLE)
 		return false;
 
-	if (acpi_gpio_in_ignore_list(dev_name(parent), pin)) {
+	if (acpi_gpio_in_ignore_list(ignore_wake, dev_name(parent), pin)) {
 		dev_info(parent, "Ignoring wakeup on pin %u\n", pin);
 		return false;
 	}
@@ -427,6 +435,11 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 		goto fail_unlock_irq;
 	}
 
+	if (acpi_gpio_in_ignore_list(ignore_interrupt, dev_name(chip->parent), pin)) {
+		dev_info(chip->parent, "Ignoring interrupt on pin %u\n", pin);
+		return AE_OK;
+	}
+
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
 	if (!event)
 		goto fail_unlock_irq;
@@ -1582,6 +1595,9 @@ static int __init acpi_gpio_setup_params(void)
 	if (ignore_wake == NULL && quirk && quirk->ignore_wake)
 		ignore_wake = quirk->ignore_wake;
 
+	if (ignore_interrupt == NULL && quirk && quirk->ignore_interrupt)
+		ignore_interrupt = quirk->ignore_interrupt;
+
 	return 0;
 }
 
-- 
2.34.1

