Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0CF5995BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346757AbiHSHAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346933AbiHSHAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:00:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B861ABD2A9;
        Fri, 19 Aug 2022 00:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUByJoV/fd7wrpGdkRlGo77XsrZwCQPw0P5U8OjdJoFu121HEikTSc7dvyHgY78TOYw2+ns5I4s23Y2KMtyw4BlOd61o2q50yGBd0kVD5bUiK0jfmG5vTum6GMqiefJFxo29OJ0cc9Q+mW5bT4uG0JFy5k6r+uq/LQQIwE2ZBMhcc7GtIEO2/2gIg/42XeLKbkZ4CWrUTtwn++h6ICazxIoKTwH5YIxZCtChXTYZMmzbnSmKt3RdhcxQMRkjyBDvYMIjWw8IPBmUZI5tvjPZuSy05ZtLO0lM/bL6Hot6Rcr1Xc6porKZIc4xyYzgH1G43ASR3CIUM1Vxfi5QX5SBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOSRmtYp9EHzQ7qyTrbRl+w0m8lh4snJR2d9TnB1KDg=;
 b=PUovgICm/0cGAZhZ/eFoj8D2b/LWGgo4DbT/zyBsUE451uUzDyEYaCotkoLCdbaQK+lSHI0zsWc32vcvZcV++SKyOQ9rZzDP/w4scHDj9Qa/4a05FPauSg1naXnl+Kh4UlXheaes1TjOHTtWZQBBXU9f+DiEFH4nDWanBhBHdU6tlrDs9zP7+tvuedOZcQtTpMjbNWyOH+6FrZrwwFnJr94BAKEYvxa9B2c/riGt5wOJC7tZ/RZecc4+jD9SysiA9g3GJywyuqQZCF9ZV08lw8QwQrdpiP1oa26VMP1En2kj+ptyjHB94Tlhr9llV/S22+5qwKIEZIGLjtHZ+yiyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOSRmtYp9EHzQ7qyTrbRl+w0m8lh4snJR2d9TnB1KDg=;
 b=fTTglObntL7T2T//QqhEurZjQjOz0mp8aiN9V2/GUzIvWHhJBvLJq7XChUVZS75rgUbcipe4d6o7eLTJbAX4eSbOOmZ6p4KdCzRuJ51iZcF+sPPhlCoSxMYLuhOKFB3XZbYrizhDVfL3wMFq1Ld+b+UKahZ/+ZlRYbIov2DlAHA=
Received: from DB6PR07CA0166.eurprd07.prod.outlook.com (2603:10a6:6:43::20) by
 AM4PR1001MB1300.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 07:00:30 +0000
Received: from DBAEUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:43:cafe::83) by DB6PR07CA0166.outlook.office365.com
 (2603:10a6:6:43::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.9 via Frontend
 Transport; Fri, 19 Aug 2022 07:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.203) by
 DBAEUR03FT017.mail.protection.outlook.com (100.127.142.243) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Fri, 19 Aug 2022 07:00:29 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Fri, 19 Aug
 2022 09:00:25 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 19 Aug 2022 09:00:25 +0200
Received: from localhost.localdomain (10.167.0.81) by FE-HUB2000.de.bosch.com
 (10.4.103.109) with Microsoft SMTP Server id 15.1.2375.31; Fri, 19 Aug 2022
 09:00:21 +0200
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <bcousson@baylibre.com>, <tony@atomide.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>,
        <mkorpershoek@baylibre.com>, <davidgow@google.com>,
        <m.felsch@pengutronix.de>, <swboyd@chromium.org>,
        <fengping.yu@mediatek.com>, <y.oudjana@protonmail.com>,
        <rdunlap@infradead.org>, <colin.king@intel.com>,
        <Gireesh.Hiremath@in.bosch.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>
Subject: [PATCH v3 1/3] driver: input: matric-keypad: switch to gpiod
Date:   Fri, 19 Aug 2022 06:59:44 +0000
Message-ID: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.0.81]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 472e6795-97b8-4d48-4ab5-08da81b080c4
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1300:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dAsjepNA/e2md6p52shODFQlZ/YiJ05BqBqLAUPPl+o8WFTPq7Mp3P8sMizstncDsCpm2UufqB5Qx8QcZQwl0OdeCHqW8aoQgkwxAJwAODYvB+pJB8KCyZumSU5Kl0Vivh0XTbyfrp9D2xFl5TFbpqLkIIJurW8eRazDxs3lr7q2qKD0GG1ucLqn+Hw5bMJI4DK6qq/7SHShjln94mF7fpH0vnXTIVWYvF7HdsjLSIuRBpgp9fyowFuKoZ+x7MHTX1WXlGTSPBlyKTB7tmzX3SsHkYWLmItfKOfWbVSQoKxM9KZE/bwXOa1OhY6svyxI5JXslkV7vXf/LYFwXf4voKkaEeUu5tFu0xa2cx4gsu164Bv2W97HddpNirPA/ZficwlcJVW6Guj5/BA5l1EQAAExEQ9e14g/iKeqX7NOBazv1hiDyoJi7FxfwmO0d+H4yd10mQ0gHm2XcginVzuCE1iRj9MsvvZbURxajeZiHhbjgo30SqRzT2g4BKGJUB1wTU5s60ygz/Bu8iQizUsfYGv2VgH68gA1l93QuMKkbBFOMOvOYlnXO+tGo5AFo2Q6YL0yDInXTJHZUG/9N9xGtGhbSYLgquXbFH3O0dlLCOeIUzxUy/5yqJCYFICccI6AyV+NZ7Z2u+1JHsARaZrWJNRzaSOLwoPWoRK/q9XRMBrwmOVdjQNjf9XL69OfMNDE9t2H64XRH5+Jj/a7Zh42UN++lYCcaeIGQxxPhyWvcKEd4MtBbGTsAXWWObwnqHdpQgdh+aBZPVrj7rOZf4q2Ig2q0jjbxHug2tOoR83W2wUpV1DsNZqiSqFLcvs9w0J5
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(36840700001)(46966006)(40470700004)(70206006)(70586007)(4326008)(8676002)(478600001)(2906002)(5660300002)(316002)(107886003)(6666004)(336012)(186003)(26005)(1076003)(110136005)(2876002)(54906003)(16526019)(47076005)(2616005)(83380400001)(82740400003)(40460700003)(86362001)(7049001)(40480700001)(82310400005)(81166007)(7416002)(8936002)(356005)(41300700001)(36860700001)(82960400001)(921005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 07:00:29.9827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472e6795-97b8-4d48-4ab5-08da81b080c4
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1300
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

Switch from gpio API to gpiod API

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

Gbp-Pq: Topic apertis/guardian
Gbp-Pq: Name driver-input-matric-keypad-switch-gpio-to-gpiod.patch
---
 drivers/input/keyboard/matrix_keypad.c | 84 ++++++++++----------------
 include/linux/input/matrix_keypad.h    |  4 +-
 2 files changed, 33 insertions(+), 55 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 30924b57058f..b99574edad9c 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -15,11 +15,10 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 
 struct matrix_keypad {
@@ -49,11 +48,11 @@ static void __activate_col(const struct matrix_keypad_platform_data *pdata,
 	bool level_on = !pdata->active_low;
 
 	if (on) {
-		gpio_direction_output(pdata->col_gpios[col], level_on);
+		gpiod_direction_output(pdata->col_gpios[col], level_on);
 	} else {
-		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
+		gpiod_set_value_cansleep(pdata->col_gpios[col], !level_on);
 		if (!pdata->drive_inactive_cols)
-			gpio_direction_input(pdata->col_gpios[col]);
+			gpiod_direction_input(pdata->col_gpios[col]);
 	}
 }
 
@@ -78,7 +77,7 @@ static void activate_all_cols(const struct matrix_keypad_platform_data *pdata,
 static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
 			 int row)
 {
-	return gpio_get_value_cansleep(pdata->row_gpios[row]) ?
+	return gpiod_get_value_cansleep(pdata->row_gpios[row]) ?
 			!pdata->active_low : pdata->active_low;
 }
 
@@ -91,7 +90,7 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
 		enable_irq(pdata->clustered_irq);
 	else {
 		for (i = 0; i < pdata->num_row_gpios; i++)
-			enable_irq(gpio_to_irq(pdata->row_gpios[i]));
+			enable_irq(gpiod_to_irq(pdata->row_gpios[i]));
 	}
 }
 
@@ -104,7 +103,7 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
 		disable_irq_nosync(pdata->clustered_irq);
 	else {
 		for (i = 0; i < pdata->num_row_gpios; i++)
-			disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
+			disable_irq_nosync(gpiod_to_irq(pdata->row_gpios[i]));
 	}
 }
 
@@ -230,7 +229,7 @@ static void matrix_keypad_stop(struct input_dev *dev)
 static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
-	unsigned int gpio;
+	struct gpio_desc *gpio;
 	int i;
 
 	if (pdata->clustered_irq > 0) {
@@ -242,7 +241,7 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 			if (!test_bit(i, keypad->disabled_gpios)) {
 				gpio = pdata->row_gpios[i];
 
-				if (enable_irq_wake(gpio_to_irq(gpio)) == 0)
+				if (enable_irq_wake(gpiod_to_irq(gpio)) == 0)
 					__set_bit(i, keypad->disabled_gpios);
 			}
 		}
@@ -252,7 +251,7 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
-	unsigned int gpio;
+	struct gpio_desc *gpio;
 	int i;
 
 	if (pdata->clustered_irq > 0) {
@@ -264,7 +263,7 @@ static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
 		for (i = 0; i < pdata->num_row_gpios; i++) {
 			if (test_and_clear_bit(i, keypad->disabled_gpios)) {
 				gpio = pdata->row_gpios[i];
-				disable_irq_wake(gpio_to_irq(gpio));
+				disable_irq_wake(gpiod_to_irq(gpio));
 			}
 		}
 	}
@@ -308,27 +307,11 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 	/* initialized strobe lines as outputs, activated */
 	for (i = 0; i < pdata->num_col_gpios; i++) {
-		err = gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
-		if (err) {
-			dev_err(&pdev->dev,
-				"failed to request GPIO%d for COL%d\n",
-				pdata->col_gpios[i], i);
-			goto err_free_cols;
-		}
-
-		gpio_direction_output(pdata->col_gpios[i], !pdata->active_low);
+		gpiod_direction_output(pdata->col_gpios[i], !pdata->active_low);
 	}
 
 	for (i = 0; i < pdata->num_row_gpios; i++) {
-		err = gpio_request(pdata->row_gpios[i], "matrix_kbd_row");
-		if (err) {
-			dev_err(&pdev->dev,
-				"failed to request GPIO%d for ROW%d\n",
-				pdata->row_gpios[i], i);
-			goto err_free_rows;
-		}
-
-		gpio_direction_input(pdata->row_gpios[i]);
+		gpiod_direction_input(pdata->row_gpios[i]);
 	}
 
 	if (pdata->clustered_irq > 0) {
@@ -344,7 +327,7 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 	} else {
 		for (i = 0; i < pdata->num_row_gpios; i++) {
 			err = request_any_context_irq(
-					gpio_to_irq(pdata->row_gpios[i]),
+					gpiod_to_irq(pdata->row_gpios[i]),
 					matrix_keypad_interrupt,
 					IRQF_TRIGGER_RISING |
 					IRQF_TRIGGER_FALLING,
@@ -352,7 +335,7 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 			if (err < 0) {
 				dev_err(&pdev->dev,
 					"Unable to acquire interrupt for GPIO line %i\n",
-					pdata->row_gpios[i]);
+					i);
 				goto err_free_irqs;
 			}
 		}
@@ -364,15 +347,12 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 err_free_irqs:
 	while (--i >= 0)
-		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
+		free_irq(gpiod_to_irq(pdata->row_gpios[i]), keypad);
 	i = pdata->num_row_gpios;
 err_free_rows:
 	while (--i >= 0)
-		gpio_free(pdata->row_gpios[i]);
+		gpiod_put(pdata->row_gpios[i]);
 	i = pdata->num_col_gpios;
-err_free_cols:
-	while (--i >= 0)
-		gpio_free(pdata->col_gpios[i]);
 
 	return err;
 }
@@ -386,14 +366,14 @@ static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
 		free_irq(pdata->clustered_irq, keypad);
 	} else {
 		for (i = 0; i < pdata->num_row_gpios; i++)
-			free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
+			free_irq(gpiod_to_irq(pdata->row_gpios[i]), keypad);
 	}
 
 	for (i = 0; i < pdata->num_row_gpios; i++)
-		gpio_free(pdata->row_gpios[i]);
+		gpiod_put(pdata->row_gpios[i]);
 
 	for (i = 0; i < pdata->num_col_gpios; i++)
-		gpio_free(pdata->col_gpios[i]);
+		gpiod_put(pdata->col_gpios[i]);
 }
 
 #ifdef CONFIG_OF
@@ -402,7 +382,8 @@ matrix_keypad_parse_dt(struct device *dev)
 {
 	struct matrix_keypad_platform_data *pdata;
 	struct device_node *np = dev->of_node;
-	unsigned int *gpios;
+	struct gpio_desc **gpios;
+	struct gpio_desc *desc;
 	int ret, i, nrow, ncol;
 
 	if (!np) {
@@ -416,8 +397,8 @@ matrix_keypad_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	pdata->num_row_gpios = nrow = of_gpio_named_count(np, "row-gpios");
-	pdata->num_col_gpios = ncol = of_gpio_named_count(np, "col-gpios");
+	pdata->num_row_gpios = nrow = gpiod_count(dev, "row");
+	pdata->num_col_gpios = ncol = gpiod_count(dev, "col");
 	if (nrow <= 0 || ncol <= 0) {
 		dev_err(dev, "number of keypad rows/columns not specified\n");
 		return ERR_PTR(-EINVAL);
@@ -429,9 +410,6 @@ matrix_keypad_parse_dt(struct device *dev)
 	pdata->wakeup = of_property_read_bool(np, "wakeup-source") ||
 			of_property_read_bool(np, "linux,wakeup"); /* legacy */
 
-	if (of_get_property(np, "gpio-activelow", NULL))
-		pdata->active_low = true;
-
 	pdata->drive_inactive_cols =
 		of_property_read_bool(np, "drive-inactive-cols");
 
@@ -441,7 +419,7 @@ matrix_keypad_parse_dt(struct device *dev)
 
 	gpios = devm_kcalloc(dev,
 			     pdata->num_row_gpios + pdata->num_col_gpios,
-			     sizeof(unsigned int),
+			     sizeof(*gpios),
 			     GFP_KERNEL);
 	if (!gpios) {
 		dev_err(dev, "could not allocate memory for gpios\n");
@@ -449,17 +427,17 @@ matrix_keypad_parse_dt(struct device *dev)
 	}
 
 	for (i = 0; i < nrow; i++) {
-		ret = of_get_named_gpio(np, "row-gpios", i);
-		if (ret < 0)
+		desc = devm_gpiod_get_index(dev, "row", i, GPIOD_IN);
+		if (IS_ERR(desc))
 			return ERR_PTR(ret);
-		gpios[i] = ret;
+		gpios[i] = desc;
 	}
 
 	for (i = 0; i < ncol; i++) {
-		ret = of_get_named_gpio(np, "col-gpios", i);
-		if (ret < 0)
+		desc = devm_gpiod_get_index(dev, "col", i, GPIOD_IN);
+		if (IS_ERR(desc))
 			return ERR_PTR(ret);
-		gpios[nrow + i] = ret;
+		gpios[nrow + i] = desc;
 	}
 
 	pdata->row_gpios = gpios;
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 9476768c3b90..8ad7d4626e62 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -59,8 +59,8 @@ struct matrix_keymap_data {
 struct matrix_keypad_platform_data {
 	const struct matrix_keymap_data *keymap_data;
 
-	const unsigned int *row_gpios;
-	const unsigned int *col_gpios;
+	struct gpio_desc **row_gpios;
+	struct gpio_desc **col_gpios;
 
 	unsigned int	num_row_gpios;
 	unsigned int	num_col_gpios;
-- 
2.20.1

