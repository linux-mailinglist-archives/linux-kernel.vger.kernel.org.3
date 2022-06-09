Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD00545043
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbiFIPJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344174AbiFIPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:09:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7133AC1D0;
        Thu,  9 Jun 2022 08:09:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id h23so37029433ejj.12;
        Thu, 09 Jun 2022 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FL+Fn/HIJcUVVxRUvKNzlk9QD2N4B7SQ3YmtwBgraI0=;
        b=GhIu2aiNAppFWB0JherC/JnQWZ/DpyI9oLu6ERth6SCJuCoUQUV01z/8FbJy3qMBjL
         RKiaPYsx7exysyUumsXZuUMbV+ioSt7wdAbr0xLTbkn0/XRhw86aTANjjC9vSPwj/Os+
         nzfZtsLn2q1XJoC2wuqY9mRta6B+OC3yAOOcZcpksmUXC9QBI9XDksU8DFerWs2aKrbk
         WWHJreIc7bh/43srYZ1VwBmXBuZq8jBhznEGmZy3juN2I/XjaGuNkttZgrD6g20spne8
         OkrPX2um6klRp2/Ee9z5bn3GW3OBZNpXjMOa+gmQSQJEGsYcxfuY+mx2/D3eH0d8dLvd
         cbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FL+Fn/HIJcUVVxRUvKNzlk9QD2N4B7SQ3YmtwBgraI0=;
        b=h0ZIOF2aQ4XGU2cMufrVTsAA4al6anyXkp2FuePNmVUNaEvvaTDvJnzVmaG13OPmzw
         QqiSM2+c+Mt81KQmS67jzDtHa/jJJFivHjNMsczwCxG8/eNWIyahXLSbzhfPmih8Rqxw
         TdAFzN2H36MF/i34GGwxkM+zK1i0o6BVFBHN8Dj6aslCG5QbEf1W8zXfhZgQHsqfIRHY
         DzIshA61SGBpgs6XLQ7oY/+OD4sduW02Xsz8BfkBQwlfoMhfz6DVW7bgTkPVffokfCrq
         FKVT4HeYWVFDdNEE1F3v7hZ8008ZsKleN3ZphWT8NbDC6lNx6VJpz/kEc77P//CTKjIz
         HMKQ==
X-Gm-Message-State: AOAM531U/OiotgKG2bBappOsgOW41b2vYIUAG96jYFngtCc2eioK2mhU
        5g3r643N2c5TB0bjIrT9sKc=
X-Google-Smtp-Source: ABdhPJzVRPneMe80geoZztA4FnZSGb0x/8sLClGGyymf76S+TdyZESyxde1mpqliHGuro9k5vRA+QA==
X-Received: by 2002:a17:907:2c65:b0:711:d06c:e61 with SMTP id ib5-20020a1709072c6500b00711d06c0e61mr18882320ejc.201.1654787378549;
        Thu, 09 Jun 2022 08:09:38 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7c698000000b0042bb229e81esm14395135edq.15.2022.06.09.08.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:09:37 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] pm: add regulator power domain controller
Date:   Thu,  9 Jun 2022 17:08:48 +0200
Message-Id: <20220609150851.23084-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220609150851.23084-1-max.oss.09@gmail.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Acts as a power domain controller which switches its domain power by
enabling/disabling a regulator.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 drivers/power/Kconfig                |   1 +
 drivers/power/Makefile               |   5 +-
 drivers/power/domain/Kconfig         |   7 ++
 drivers/power/domain/Makefile        |   2 +
 drivers/power/domain/regulator-pdc.c | 112 +++++++++++++++++++++++++++
 5 files changed, 125 insertions(+), 2 deletions(-)
 create mode 100644 drivers/power/domain/Kconfig
 create mode 100644 drivers/power/domain/Makefile
 create mode 100644 drivers/power/domain/regulator-pdc.c

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 696bf77a7042..e8eebee629d5 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
+source "drivers/power/domain/Kconfig"
 source "drivers/power/reset/Kconfig"
 source "drivers/power/supply/Kconfig"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index effbf0377f32..4323a8c8c328 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_POWER_RESET)	+= reset/
-obj-$(CONFIG_POWER_SUPPLY)	+= supply/
+obj-$(CONFIG_PM_GENERIC_DOMAINS)	+= domain/
+obj-$(CONFIG_POWER_RESET)		+= reset/
+obj-$(CONFIG_POWER_SUPPLY)		+= supply/
diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
new file mode 100644
index 000000000000..74c50baf2df0
--- /dev/null
+++ b/drivers/power/domain/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config POWER_DOMAIN_REGULATOR
+	bool "A power domain controller using a regulator for power control"
+	help
+	  Say Y here to enable a power domain controller which uses a regulator
+	  to control its power domain.
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
new file mode 100644
index 000000000000..13b3378fb11f
--- /dev/null
+++ b/drivers/power/domain/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_POWER_DOMAIN_REGULATOR)	+= regulator-pdc.o
diff --git a/drivers/power/domain/regulator-pdc.c b/drivers/power/domain/regulator-pdc.c
new file mode 100644
index 000000000000..e03cfe901d70
--- /dev/null
+++ b/drivers/power/domain/regulator-pdc.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A power domain controller which uses a regulator to control its power domain.
+ *
+ * Copyright 2022 Toradex
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/regulator/consumer.h>
+
+struct reg_pd {
+	struct device *dev;
+	struct generic_pm_domain pd;
+	struct regulator *supply;
+};
+
+static int reg_pd_power_off(struct generic_pm_domain *domain)
+{
+	struct reg_pd *pd = container_of(domain, struct reg_pd, pd);
+
+	return regulator_disable(pd->supply);
+}
+
+static int reg_pd_power_on(struct generic_pm_domain *domain)
+{
+	struct reg_pd *pd = container_of(domain, struct reg_pd, pd);
+
+	return regulator_enable(pd->supply);
+}
+
+static const struct of_device_id reg_pd_of_match[] = {
+	{
+		.compatible = "regulator-pm-pd",
+	},
+	{ },
+};
+
+static int reg_pd_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct of_phandle_args child, parent;
+	struct reg_pd *pd;
+	const char *name;
+	int ret;
+
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd) {
+		of_node_put(np);
+		return -ENOMEM;
+	}
+	pd->dev = dev;
+
+	if (of_property_read_string(np, "label", &name) < 0)
+		name = kbasename(np->full_name);
+	pd->pd.name = kstrdup_const(name, GFP_KERNEL);
+	if (!pd->pd.name)
+		return -ENOMEM;
+
+	pd->supply = devm_regulator_get(dev, "power");
+	if (IS_ERR(pd->supply))
+		return dev_err_probe(dev, PTR_ERR(pd->supply),
+				     "failed to get regulator\n");
+
+	pd->pd.power_off = reg_pd_power_off;
+	pd->pd.power_on = reg_pd_power_on;
+
+	ret = pm_genpd_init(&pd->pd, NULL, true);
+	if (ret)
+		goto err_out;
+	ret = of_genpd_add_provider_simple(np, &pd->pd);
+	if (ret)
+		goto err_out;
+
+	if (of_parse_phandle_with_args(np, "power-domains",
+				      "#power-domain-cells", 0, &parent) == 0) {
+		child.np = np;
+		child.args_count = 0;
+
+		if (of_genpd_add_subdomain(&parent, &child))
+			pr_warn("%pOF failed to add subdomain: %pOF\n",
+				parent.np, child.np);
+		else
+			pr_info("%pOF has as child subdomain: %pOF.\n",
+				parent.np, child.np);
+	}
+
+	return 0;
+
+err_out:
+	dev_warn(dev, "failed to probe pd %s", pd->pd.name);
+	return ret;
+}
+
+static struct platform_driver reg_pd_driver = {
+	.driver = {
+		.name	= "regulator_power_domain",
+		.of_match_table = reg_pd_of_match,
+		.owner	= THIS_MODULE,
+	},
+	.probe = reg_pd_probe,
+};
+
+static __init int reg_pd_init(void)
+{
+	return platform_driver_register(&reg_pd_driver);
+}
+core_initcall(reg_pd_init);
-- 
2.20.1

