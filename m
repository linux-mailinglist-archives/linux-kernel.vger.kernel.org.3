Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22834B9C04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbiBQJ21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:28:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiBQJ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:28:18 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE161B4463;
        Thu, 17 Feb 2022 01:28:04 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4JzqHj33TPz9sV8;
        Thu, 17 Feb 2022 10:28:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645090079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfcNRSGnkJBjMPrtUucPQRJFz/s/Ce0jeEEdQxko2do=;
        b=W/4Z9LsWwZSggFpzAJTcohaVSsG8VgG9f7OHWmXrACGInXlKyR8hVQ+EKFZ9gaKi3xaJDe
        pvVCHB+fc4OpBOYn2H6dGzAp4mg0x7UodrX2lyFMvrWTH7CZkzdDTOwA+nWRig2Am26saG
        FgWFEWPB6P/+nfEKBly9nMJfFxrRq0WNGg7MC1VexKHNxnge7rCIUhP1sSPyHZz8rxfAv8
        rSkPrqKeTPdTTc2XfxGQVPGXFM6kacsnkDkw2KMOykXgMvON50R5QYHq+B9X/KnQqkujXL
        AvifHbZata4OkqLY6f5MHchxXT82mgHi6qNFxwfxRQz8YGhAzjdGUdr4k6al6w==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v1 3/3] hwmon (xdpe12284): Add regulator support
Date:   Thu, 17 Feb 2022 10:27:30 +0100
Message-Id: <6c8a38efa0b61e3ba8de023f56f59043b99e5947.1645088804.git.sylv@sylv.io>
In-Reply-To: <cover.1645088804.git.sylv@sylv.io>
References: <cover.1645088804.git.sylv@sylv.io>
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
index c96f7b7338bd..e0e9b67bf3eb 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -394,6 +394,12 @@ config SENSORS_XDPE122
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
index ec947c697670..c58776ef0311 100644
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
@@ -120,6 +122,11 @@ static int xdpe122_identify(struct i2c_client *client,
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
 		PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
 	.identify = xdpe122_identify,
 	.read_word_data = xdpe122_read_word_data,
+#if IS_ENABLED(CONFIG_SENSORS_XDPE122_REGULATOR)
+	.num_regulators = 2,
+	.reg_desc = xdpe122_reg_desc,
+#endif
 };
 
 static int xdpe122_probe(struct i2c_client *client)
-- 
2.34.1

