Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6A5197A8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiEDG5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345111AbiEDG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:56:36 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30FC20BF5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 23:53:01 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5B216C64;
        Tue,  3 May 2022 23:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651647181;
        bh=T+pl3SJCSzXLJOiH4mZIAgFL9b9XXugAhhglLLH5nDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mX7+SrYAMIBw0ZLAA5ZzfrgVbR8MjFejgzDqwOnI8FCj2J1NgvmTaWjXI+clUMs0N
         jR6qTIFaLnCw7hHAh74Z03lX/zB5GpyDTYCtkHc+Z170TfVPhO+XpLSTpxFWKm2z8K
         qWSrjHbBxfJbard91MS1vaOx+QKoy65660GrjmCg=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org
Subject: [PATCH 6/6] regulator: core: Add external-consumer driver
Date:   Tue,  3 May 2022 23:52:52 -0700
Message-Id: <20220504065252.6955-6-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504065252.6955-1-zev@bewilderbeest.net>
References: <20220504065252.6955-1-zev@bewilderbeest.net>
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

An external consumer is a dummy device representing a device external
to the system that is supplied by a regulator designated for external
output.  It is purely a virtual placeholder to instantiate a regulator
by calling regulator_get() on it from its probe function.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/regulator/Kconfig |  9 +++++++++
 drivers/regulator/core.c  | 28 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5ef2306fce04..5ec390687a81 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -56,6 +56,15 @@ config REGULATOR_USERSPACE_CONSUMER
 
 	  If unsure, say no.
 
+config REGULATOR_EXTERNAL_CONSUMER
+	bool "External regulator consumer support"
+	help
+	  Some regulators supply devices that are entirely external to
+	  the system.  This driver provides a placeholder consumer
+	  representing such devices.
+
+	  If unsure, say no.
+
 config REGULATOR_88PG86X
 	tristate "Marvell 88PG86X voltage regulators"
 	depends on I2C
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d873606eb41f..4f348b3d5290 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/consumer.h>
@@ -6070,6 +6071,33 @@ static int regulator_summary_show(struct seq_file *s, void *data)
 DEFINE_SHOW_ATTRIBUTE(regulator_summary);
 #endif /* CONFIG_DEBUG_FS */
 
+#ifdef CONFIG_REGULATOR_EXTERNAL_CONSUMER
+static int regulator_external_output_probe(struct platform_device *pdev)
+{
+	struct regulator *reg;
+
+	reg = devm_regulator_get_external(&pdev->dev, "vout");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	return 0;
+}
+
+static const struct of_device_id reg_external_consumer_of_match_table[] = {
+	{ .compatible = "regulator-external-output" },
+	{ },
+};
+
+static struct platform_driver reg_external_consumer_driver = {
+	.driver = {
+		.name = "reg-external-consumer",
+		.of_match_table = reg_external_consumer_of_match_table,
+	},
+	.probe = regulator_external_output_probe,
+};
+builtin_platform_driver(reg_external_consumer_driver);
+#endif /* CONFIG_REGULATOR_EXTERNAL_CONSUMER */
+
 static int __init regulator_init(void)
 {
 	int ret;
-- 
2.36.0

