Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590134BC32E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbiBSAIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:08:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbiBSAIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:08:23 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0ED8A307;
        Fri, 18 Feb 2022 16:08:06 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id BBB01135;
        Fri, 18 Feb 2022 16:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1645229285;
        bh=h2aFBWe+AccNIbs2+7An1hnsjm+hRPECr9bkxUc1y/k=;
        h=From:To:Cc:Subject:Date:From;
        b=nKFGtjRc4qh75CTmjNkq4TAx1m8kOZjClI1sva+i8c+nP/VPxowRFJfV0YABs56No
         8HY0/NV66ge/Ql+La+hLq6aJ/nt1xt2AxtzFyUUs3U7XIWtBu/p5Oi7jEW8msQyxXn
         hvUImPe/l9LujLb1ihUs/OVBOigAJUDgx7qM2ZRk=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH v2] hwmon: (pmbus) lm25066: Add regulator support
Date:   Fri, 18 Feb 2022 16:07:42 -0800
Message-Id: <20220219000742.20126-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While these chips aren't strictly advertised as voltage regulators per
se, they (aside from the lm25056) support the PMBus OPERATION command
to enable and disable their outputs and have status bits for reporting
various warnings and faults, and can hence usefully support all the
pmbus_regulator_ops operations.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---

Changes since v1 [0]:
 - split out of power-efuse driver series

[0] https://lore.kernel.org/openbmc/20220217104444.7695-3-zev@bewilderbeest.net/

 drivers/hwmon/pmbus/Kconfig   |  7 +++++++
 drivers/hwmon/pmbus/lm25066.c | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index c96f7b7338bd..c73aa50c7615 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -174,6 +174,13 @@ config SENSORS_LM25066
 	  This driver can also be built as a module. If so, the module will
 	  be called lm25066.
 
+config SENSORS_LM25066_REGULATOR
+	bool "Regulator support for LM25066 and compatibles"
+	depends on SENSORS_LM25066 && REGULATOR
+	help
+	  If you say yes here you get regulator support for National
+	  Semiconductor LM25066, LM5064, and LM5066.
+
 config SENSORS_LTC2978
 	tristate "Linear Technologies LTC2978 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 8402b41520eb..09792cd03d9f 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -435,6 +435,12 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_SENSORS_LM25066_REGULATOR)
+static const struct regulator_desc lm25066_reg_desc[] = {
+	PMBUS_REGULATOR("vout", 0),
+};
+#endif
+
 static const struct i2c_device_id lm25066_id[] = {
 	{"lm25056", lm25056},
 	{"lm25066", lm25066},
@@ -545,6 +551,14 @@ static int lm25066_probe(struct i2c_client *client)
 	info->m[PSC_CURRENT_IN] = info->m[PSC_CURRENT_IN] * shunt / 1000;
 	info->m[PSC_POWER] = info->m[PSC_POWER] * shunt / 1000;
 
+#if IS_ENABLED(CONFIG_SENSORS_LM25066_REGULATOR)
+	/* LM25056 doesn't support OPERATION */
+	if (data->id != lm25056) {
+		info->num_regulators = ARRAY_SIZE(lm25066_reg_desc);
+		info->reg_desc = lm25066_reg_desc;
+	}
+#endif
+
 	return pmbus_do_probe(client, info);
 }
 
-- 
2.35.1

