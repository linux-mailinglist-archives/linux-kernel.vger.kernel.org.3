Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E124C927F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiCASC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiCASCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:02:23 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1596C3FD8F;
        Tue,  1 Mar 2022 10:01:42 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4K7Q6r4FqXz9sTd;
        Tue,  1 Mar 2022 19:01:40 +0100 (CET)
From:   Marcello Sylvester Bauer <sylv@sylv.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1646157698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0gXkkSMWRwsd/tK/1tooWVlC8FpM5vy2KBjzcgp2LuE=;
        b=iAe/jQEv/SOKEvJJxcCaOC9cqlf7zBIUnz89K/4vNVb+P5N3wkxIDYNcOq/UhMzcWLhnQ8
        TSIE8eqxkO/6hINImIbSLxACJ4/Gnj7nDroOJms5/iRanIbiF8L5G50wnWublWX8cX9YrH
        +0rWWGb2r5W8pdezQyUP8fdOeb7tGNsd+aSpZI/QQWLbG6lOjdfWV+v0n47vwK9HXw5lNr
        qKHdQgnyFvE6CHyoXdg/NRvVKpywZxT1yqYU4x9wc8HBsoyx+NG4Qit4eo09tE2mXLwrd4
        c6XbXuMP+wV2OLd9COXQ4jILyYpioVIcBYL2TWxTndhVQttY6NjL6VCb6uhl9A==
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v3 3/3] hwmon (xdpe12284): Add regulator support
Date:   Tue,  1 Mar 2022 19:01:13 +0100
Message-Id: <f747eeeec852fc964151afe0aa387bbe4d7291c5.1646157237.git.sylv@sylv.io>
In-Reply-To: <cover.1646157237.git.sylv@sylv.io>
References: <cover.1646157237.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add simple on/off regulator support for xdpe12284 and
other pmbus parts supported by the xdpe12284 driver.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 drivers/hwmon/pmbus/Kconfig     |  6 ++++++
 drivers/hwmon/pmbus/xdpe12284.c | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 6552467c588d..a2ea1d5a8765 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -417,6 +417,12 @@ config SENSORS_XDPE122
 	  This driver can also be built as a module. If so, the module will
 	  be called xdpe12284.
 
+config SENSORS_XDPE122_REGULATOR
+	bool "Regulator support for XDPE122 and compatibles"
+	depends on SENSORS_XDPE122 && REGULATOR
+	help
+	  Uses the xdpe12284 or compatible as regulator.
+
 config SENSORS_ZL6100
 	tristate "Intersil ZL6100 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/xdpe12284.c b/drivers/hwmon/pmbus/xdpe12284.c
index 3413aba9d5be..495c62005aed 100644
--- a/drivers/hwmon/pmbus/xdpe12284.c
+++ b/drivers/hwmon/pmbus/xdpe12284.c
@@ -10,6 +10,8 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/regulator/driver.h>
+
 #include "pmbus.h"
 
 #define XDPE122_PROT_VR12_5MV		0x01 /* VR12.0 mode, 5-mV DAC */
@@ -107,6 +109,11 @@ static int xdpe122_identify(struct i2c_client *client,
 	return 0;
 }
 
+static const struct regulator_desc xdpe122_reg_desc[] = {
+	PMBUS_REGULATOR("vout", 0),
+	PMBUS_REGULATOR("vout", 1),
+};
+
 static struct pmbus_driver_info xdpe122_info = {
 	.pages = XDPE122_PAGE_NUM,
 	.format[PSC_VOLTAGE_IN] = linear,
@@ -122,6 +129,10 @@ static struct pmbus_driver_info xdpe122_info = {
 		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
 		PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
+#if IS_ENABLED(CONFIG_SENSORS_XDPE122_REGULATOR)
+	.num_regulators = 2,
+	.reg_desc = xdpe122_reg_desc,
+#endif
 };
 
 static int xdpe122_probe(struct i2c_client *client)
-- 
2.35.1

