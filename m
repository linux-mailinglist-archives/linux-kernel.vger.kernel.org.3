Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB574BDD22
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353234AbiBUKXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:23:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353333AbiBUKW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:22:58 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBD26005F;
        Mon, 21 Feb 2022 01:42:44 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4K2HQq30pqz9sdL;
        Mon, 21 Feb 2022 10:42:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645436561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5zDT7vSi9fcWRgO6D47twmIF4dJbZysIxXfi1k5jmWs=;
        b=mp72uL4RsZOKzUUcOAeA7YA3tRppi+UCeEzQGpK0zJFI75cupAxBshKHQdudW0ZIxIkP4O
        MUBZZLxecc3apfXag2K6F0vMi52S/ZDcQ+DTws29VfQNkJolj/PZt8ciqyrTcYwvHyGpxr
        0hwAfw83zJBAPrJI7RpzFfkQX5CARSihZn6Fvey0WU31KaBlHQ96GlM5T7bO1543W25V+x
        efqaLcw1urn0bRslc2zojUwEJoDS40MmE78PqvGkX/0gn3hJG6N7juYRo5jeWtfBaLhGl+
        Lpx1h0W5JmNmTn/lgMotONO4IdGa8tjRbfjD+buCDexOiwHQQy0wQ1rSV4IZSw==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v4 4/4] pmbus (pli1209bc): Add regulator support
Date:   Mon, 21 Feb 2022 10:42:07 +0100
Message-Id: <21b0cdb6dd72654effa451d3b1636ecd07b160e9.1645435888.git.sylv@sylv.io>
In-Reply-To: <cover.1645435888.git.sylv@sylv.io>
References: <cover.1645435888.git.sylv@sylv.io>
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

Add regulator support for PLI1209BC Digital Supervisor.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 drivers/hwmon/pmbus/Kconfig     |  7 +++++++
 drivers/hwmon/pmbus/pli1209bc.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index f18f67a94697..6552467c588d 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -326,6 +326,13 @@ config SENSORS_PLI1209BC
 	  This driver can also be built as a module. If so, the module will
 	  be called pli1209bc.
 
+config SENSORS_PLI1209BC_REGULATOR
+	bool "Regulator support for PLI1209BC"
+	depends on SENSORS_PLI1209BC && REGULATOR
+	help
+	  If you say yes here you get regulator support for Vicor PLI1209BC
+	  Digital Supervisor.
+
 config SENSORS_PM6764TR
 	tristate "ST PM6764TR"
 	help
diff --git a/drivers/hwmon/pmbus/pli1209bc.c b/drivers/hwmon/pmbus/pli1209bc.c
index 5f8847307e55..05b4ee35ba27 100644
--- a/drivers/hwmon/pmbus/pli1209bc.c
+++ b/drivers/hwmon/pmbus/pli1209bc.c
@@ -8,6 +8,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pmbus.h>
+#include <linux/regulator/driver.h>
 #include "pmbus.h"
 
 /*
@@ -33,11 +34,37 @@ static int pli1209bc_read_word_data(struct i2c_client *client, int page,
 			return data;
 		data = sign_extend32(data, 15) * 10;
 		return clamp_val(data, -32768, 32767) & 0xffff;
+	/*
+	 * PMBUS_READ_VOUT and PMBUS_READ_TEMPERATURE_1 return invalid data
+	 * when the BCM is turned off. Since it is not possible to return
+	 * ENODATA error, return zero instead.
+	 */
+	case PMBUS_READ_VOUT:
+	case PMBUS_READ_TEMPERATURE_1:
+		data = pmbus_read_word_data(client, page, phase,
+					    PMBUS_STATUS_WORD);
+		if (data < 0)
+			return data;
+		if (data & PB_STATUS_POWER_GOOD_N)
+			return 0;
+		return pmbus_read_word_data(client, page, phase, reg);
 	default:
 		return -ENODATA;
 	}
 }
 
+#if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
+static const struct regulator_desc pli1209bc_reg_desc = {
+	.name = "vout2",
+	.id = 1,
+	.of_match = of_match_ptr("vout2"),
+	.regulators_node = of_match_ptr("regulators"),
+	.ops = &pmbus_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+#endif
+
 static struct pmbus_driver_info pli1209bc_info = {
 	.pages = 2,
 	.format[PSC_VOLTAGE_IN] = direct,
@@ -75,6 +102,10 @@ static struct pmbus_driver_info pli1209bc_info = {
 	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
 	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT,
 	.read_word_data = pli1209bc_read_word_data,
+#if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
+	.num_regulators = 1,
+	.reg_desc = &pli1209bc_reg_desc,
+#endif
 };
 
 static int pli1209bc_probe(struct i2c_client *client)
-- 
2.34.1

