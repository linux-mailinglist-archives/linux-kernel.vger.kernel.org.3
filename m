Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA24247F322
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 12:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhLYLz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 06:55:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231575AbhLYLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 06:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640433326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOK1xfx1Y0/RBH0zV7wf4P4AcTguPlpOLr1LCIhXkCM=;
        b=DIddVUDAZy6jsrhzCJ/TFzsagVqGhQQMTaHAa3bFMPq6KizfTu0ILQrfOI+A/IURzHLaN4
        HFyclI8eOAU780wsLLWZij2L9V8qziQURmC7nevFcdofhnOfnS7d94aZxLTAzpW1556XLO
        476r7hHcUQJoAt6KLEy1OAp3XRZzGLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-BAp-rHESNqaljP2eDi8_jw-1; Sat, 25 Dec 2021 06:55:23 -0500
X-MC-Unique: BAp-rHESNqaljP2eDi8_jw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15BDE2F44;
        Sat, 25 Dec 2021 11:55:22 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5E437ADB4;
        Sat, 25 Dec 2021 11:55:20 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: Add crystal_cove_charger driver
Date:   Sat, 25 Dec 2021 12:55:09 +0100
Message-Id: <20211225115509.94891-5-hdegoede@redhat.com>
In-Reply-To: <20211225115509.94891-1-hdegoede@redhat.com>
References: <20211225115509.94891-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver for the external-charger IRQ pass-through function of the
Bay Trail Crystal Cove PMIC.

Note this is NOT a power_supply class driver, it just deals with IRQ
pass-through, this requires this separate driver because the PMIC's
level 2 interrupt for this must be explicitly acked.

This new driver gets enabled by the existing X86_ANDROID_TABLETS Kconfig
option because the x86-android-tablets module is the only user of the
exported external-charger IRQ.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/Makefile               |   2 +-
 drivers/platform/x86/crystal_cove_charger.c | 153 ++++++++++++++++++++
 2 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/crystal_cove_charger.c

diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index bd20b435c22b..cce124e3acab 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -114,7 +114,7 @@ obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
 obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
 obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
-obj-$(CONFIG_X86_ANDROID_TABLETS)	+= x86-android-tablets.o
+obj-$(CONFIG_X86_ANDROID_TABLETS)	+= x86-android-tablets.o crystal_cove_charger.o
 
 # Intel uncore drivers
 obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
diff --git a/drivers/platform/x86/crystal_cove_charger.c b/drivers/platform/x86/crystal_cove_charger.c
new file mode 100644
index 000000000000..382c19806b12
--- /dev/null
+++ b/drivers/platform/x86/crystal_cove_charger.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for the external-charger IRQ pass-through function of the
+ * Bay Trail Crystal Cove PMIC.
+ *
+ * Note this is NOT a power_supply class driver, it just deals with IRQ
+ * pass-through, this requires this separate driver because the PMIC's
+ * level 2 interrupt for this must be explicitly acked.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/mfd/intel_soc_pmic.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define CHGRIRQ_REG					0x0a
+
+struct crystal_cove_charger_data {
+	struct mutex buslock; /* irq_bus_lock */
+	struct irq_chip irqchip;
+	struct regmap *regmap;
+	struct irq_domain *irq_domain;
+	int irq;
+	int charger_irq;
+	bool irq_enabled;
+	bool irq_is_enabled;
+};
+
+static irqreturn_t crystal_cove_charger_irq(int irq, void *data)
+{
+	struct crystal_cove_charger_data *charger = data;
+
+	/* No need to read CHGRIRQ_REG as there is only 1 IRQ */
+	handle_nested_irq(charger->charger_irq);
+
+	/* Ack CHGRIRQ 0 */
+	regmap_write(charger->regmap, CHGRIRQ_REG, BIT(0));
+
+	return IRQ_HANDLED;
+}
+
+static void crystal_cove_charger_irq_bus_lock(struct irq_data *data)
+{
+	struct crystal_cove_charger_data *charger = irq_data_get_irq_chip_data(data);
+
+	mutex_lock(&charger->buslock);
+}
+
+static void crystal_cove_charger_irq_bus_sync_unlock(struct irq_data *data)
+{
+	struct crystal_cove_charger_data *charger = irq_data_get_irq_chip_data(data);
+
+	if (charger->irq_is_enabled != charger->irq_enabled) {
+		if (charger->irq_enabled)
+			enable_irq(charger->irq);
+		else
+			disable_irq(charger->irq);
+
+		charger->irq_is_enabled = charger->irq_enabled;
+	}
+
+	mutex_unlock(&charger->buslock);
+}
+
+static void crystal_cove_charger_irq_unmask(struct irq_data *data)
+{
+	struct crystal_cove_charger_data *charger = irq_data_get_irq_chip_data(data);
+
+	charger->irq_enabled = true;
+}
+
+static void crystal_cove_charger_irq_mask(struct irq_data *data)
+{
+	struct crystal_cove_charger_data *charger = irq_data_get_irq_chip_data(data);
+
+	charger->irq_enabled = false;
+}
+
+static void crystal_cove_charger_rm_irq_domain(void *data)
+{
+	struct crystal_cove_charger_data *charger = data;
+
+	irq_domain_remove(charger->irq_domain);
+}
+
+static int crystal_cove_charger_probe(struct platform_device *pdev)
+{
+	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
+	struct crystal_cove_charger_data *charger;
+	int ret;
+
+	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
+	if (!charger)
+		return -ENOMEM;
+
+	charger->regmap = pmic->regmap;
+	mutex_init(&charger->buslock);
+
+	charger->irq = platform_get_irq(pdev, 0);
+	if (charger->irq < 0)
+		return charger->irq;
+
+	charger->irq_domain = irq_domain_create_linear(dev_fwnode(pdev->dev.parent), 1,
+						       &irq_domain_simple_ops, NULL);
+	if (!charger->irq_domain)
+		return -ENOMEM;
+
+	/* Distuingish IRQ domain from others sharing (MFD) the same fwnode */
+	irq_domain_update_bus_token(charger->irq_domain, DOMAIN_BUS_WAKEUP);
+
+	ret = devm_add_action_or_reset(&pdev->dev, crystal_cove_charger_rm_irq_domain, charger);
+	if (ret)
+		return ret;
+
+	charger->charger_irq = irq_create_mapping(charger->irq_domain, 0);
+	if (!charger->charger_irq)
+		return -ENOMEM;
+
+	charger->irqchip.name = KBUILD_MODNAME;
+	charger->irqchip.irq_unmask = crystal_cove_charger_irq_unmask;
+	charger->irqchip.irq_mask = crystal_cove_charger_irq_mask;
+	charger->irqchip.irq_bus_lock = crystal_cove_charger_irq_bus_lock;
+	charger->irqchip.irq_bus_sync_unlock = crystal_cove_charger_irq_bus_sync_unlock;
+
+	irq_set_chip_data(charger->charger_irq, charger);
+	irq_set_chip_and_handler(charger->charger_irq, &charger->irqchip, handle_simple_irq);
+	irq_set_nested_thread(charger->charger_irq, true);
+	irq_set_noprobe(charger->charger_irq);
+
+	ret = devm_request_threaded_irq(&pdev->dev, charger->irq, NULL,
+					crystal_cove_charger_irq,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					KBUILD_MODNAME, charger);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "requesting irq\n");
+
+	return 0;
+}
+
+static struct platform_driver crystal_cove_charger_driver = {
+	.probe = crystal_cove_charger_probe,
+	.driver = {
+		.name = "crystal_cove_charger",
+	},
+};
+module_platform_driver(crystal_cove_charger_driver);
+
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com");
+MODULE_DESCRIPTION("Bay Trail Crystal Cove external charger IRQ pass-through");
+MODULE_LICENSE("GPL");
-- 
2.33.1

