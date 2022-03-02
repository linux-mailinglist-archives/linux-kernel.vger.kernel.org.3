Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0381E4CA145
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbiCBJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240654AbiCBJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:50:35 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C51BA74B;
        Wed,  2 Mar 2022 01:49:52 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4K7q8v0p8tz9sqx;
        Wed,  2 Mar 2022 10:49:51 +0100 (CET)
From:   Marcello Sylvester Bauer <sylv@sylv.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1646214589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r3j4TfpwYZdoo5iNxbvs/pvrxDs+7O8OisHS1HfKjXU=;
        b=HqcoqYvEdv/j2uDr7iypGcFvmD2e8aES2OGx6psjL29809Yydvt8EL2h/f1TsAwpWEX47k
        OEBTgiYGKV2bIJXgN7WgUvswlLH44KwWNPZwZeG80whDmiWVWu7POuYM6nKU/bYGycbVGW
        ml6TBJbu6y/hOGnKPMSlG47/b4voHCs8BnB2CQsj2YXThHmrgPc0OrJg//hJg5NIRG9qfs
        Lz4S12j7vxSuQyo7fE/FhxTMJaRpCb4m/AUiq3WydgxoDlqe/AI31a3o9oRq7gM6+Mm67m
        CgBqUhfh7RtmitWGmGTcS79nD6qqEhNZp5qAuFU0AXUb3Vo0tYNkSgpO1I4f/Q==
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v4 3/3] hwmon (xdpe12284): Add regulator support
Date:   Wed,  2 Mar 2022 10:49:21 +0100
Message-Id: <f69b8e7fa32cd2bad9516d8fa590abb87c7e4869.1646214248.git.sylv@sylv.io>
In-Reply-To: <cover.1646214248.git.sylv@sylv.io>
References: <cover.1646214248.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index b979c88d2e87..18fffc5d749b 100644
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
@@ -122,6 +124,11 @@ static int xdpe122_identify(struct i2c_client *client,
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
@@ -138,6 +145,10 @@ static struct pmbus_driver_info xdpe122_info = {
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
 		PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
 	.identify = xdpe122_identify,
+#if IS_ENABLED(CONFIG_SENSORS_XDPE122_REGULATOR)
+	.num_regulators = 2,
+	.reg_desc = xdpe122_reg_desc,
+#endif
 };
 
 static int xdpe122_probe(struct i2c_client *client)
-- 
2.35.1

