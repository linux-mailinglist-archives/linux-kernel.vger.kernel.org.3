Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A2B5929B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiHOGkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiHOGkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:40:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C51ADA6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:40:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso5988253pjl.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3xUHf3HqS3mIbAzLpagrtMfBUff89AJ2SzxASGdwC3U=;
        b=NyMFVyLH/XSwsw8kvV+j7VDk1gXRk3KDssB9npb6dIfiQSh1g8j1sUNVXvmR6Z+NZx
         5ME+fz5LIFMfLrr0vMXJd+hMTuH1NTqQKk5/C41bEJdtZRV3da27DKnf6bRILG4V3UBP
         UGKOKf/KFPKdVvmUdmhlxfQjSU2ZS7vQo35Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3xUHf3HqS3mIbAzLpagrtMfBUff89AJ2SzxASGdwC3U=;
        b=wvJm5YwW7z3f8D+ZpCI6uNiifCJtWYfZMdltJ8qkDax9ZkJFLdxNuozxKknwDdpcfP
         mMgbOWiHGexhgiuhhRUj4Uk1CLDxszWqsJX8ULfnMfVe2Fs8byBUYKgtzw/y9VOhs+1s
         Ztj3Yd9Du0Ll27xYpD3tKKa4GJl/PTm/CNUUFO4mpc733QIpQ3u4uga0U84QMYUQCKLh
         FOYFAJE1918V/FoWzP1vHLShxmw4YxmsXJ4X+siHc2NgYC+GKtw10TC/xBIWbkXNonhP
         P0S6iPQzkg6kz0SlWr8OpgbbtGkoF/6t2JzTQ65GkrOsFg5EWJ8uQ1sA4qhTba4ZLmNz
         AR4g==
X-Gm-Message-State: ACgBeo3Xh299BhkIVQAsoToj2g1/97gDrmvxkdU41F4VU9bbrh9hdJUZ
        MN/gSBW/f6onbmReoXTC7ldD1V0F3KAIxw==
X-Google-Smtp-Source: AA6agR7YLxLck7accSogjcD0azd/9aNq35LIa8JTqXEvJ/9TlpetoFWCVjY8v0YSb5Q9jLMYWU/YFg==
X-Received: by 2002:a17:903:41c6:b0:16f:3d1:f63 with SMTP id u6-20020a17090341c600b0016f03d10f63mr15463762ple.50.1660545599581;
        Sun, 14 Aug 2022 23:39:59 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id 200-20020a6214d1000000b0052db82ad8b2sm5988233pfu.123.2022.08.14.23.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:39:59 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v5 2/7] platform/chrome: cros_typec_switch: Add switch driver
Date:   Mon, 15 Aug 2022 06:34:19 +0000
Message-Id: <20220815063555.1384505-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220815063555.1384505-1-pmalani@chromium.org>
References: <20220815063555.1384505-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a driver to configure USB Type-C mode switches and retimers
which are controlled by the Chrome OS EC (Embedded Controller).
This allows Type-C port drivers, as well as alternate mode drivers to
configure their relevant mode switches and retimers according to the
Type-C state they want to achieve.

ACPI devices with ID GOOG001A will bind to this driver.

Currently, we only register a retimer switch with a stub set function.
Subsequent patches will implement the host command set functionality,
and introduce mode switches.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v4:
- Add ACPI dependency to Kconfig.

Changes since v3:
- No changes.

Changes since v2:
- Fixed missing "static" identifier.
- Removed unnecessary new line for function signature.

Changes since v1:
- No changes.

 MAINTAINERS                                 |   1 +
 drivers/platform/chrome/Kconfig             |  11 ++
 drivers/platform/chrome/Makefile            |   1 +
 drivers/platform/chrome/cros_typec_switch.c | 170 ++++++++++++++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_typec_switch.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b7221f4143cb..6fa4da411275 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4884,6 +4884,7 @@ M:	Prashant Malani <pmalani@chromium.org>
 L:	chrome-platform@lists.linux.dev
 S:	Maintained
 F:	drivers/platform/chrome/cros_ec_typec.c
+F:	drivers/platform/chrome/cros_typec_switch.c
 
 CHROMEOS EC USB PD NOTIFY DRIVER
 M:	Prashant Malani <pmalani@chromium.org>
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index c45fb376d653..55b68f247f02 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -265,6 +265,17 @@ config CHROMEOS_PRIVACY_SCREEN
 	  this should probably always be built into the kernel to avoid or
 	  minimize drm probe deferral.
 
+config CROS_TYPEC_SWITCH
+	tristate "ChromeOS EC Type-C Switch Control"
+	depends on MFD_CROS_EC_DEV && TYPEC && ACPI
+	default MFD_CROS_EC_DEV
+	help
+	  If you say Y here, you get support for configuring the Chrome OS EC Type C
+	  muxes and retimers.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called cros_typec_switch.
+
 source "drivers/platform/chrome/wilco_ec/Kconfig"
 
 # Kunit test cases
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index f7e74a845afc..2950610101f1 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
 obj-$(CONFIG_CROS_EC)			+= cros_ec.o
 obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_ISHTP)		+= cros_ec_ishtp.o
+obj-$(CONFIG_CROS_TYPEC_SWITCH)		+= cros_typec_switch.o
 obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
new file mode 100644
index 000000000000..0d319e315d57
--- /dev/null
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2022 Google LLC
+ *
+ * This driver provides the ability to configure Type C muxes and retimers which are controlled by
+ * the Chrome OS EC.
+ */
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_device.h>
+#include <linux/usb/typec_retimer.h>
+
+#define DRV_NAME "cros-typec-switch"
+
+/* Handles and other relevant data required for each port's switches. */
+struct cros_typec_port {
+	int port_num;
+	struct typec_retimer *retimer;
+	struct cros_typec_switch_data *sdata;
+};
+
+/* Driver-specific data. */
+struct cros_typec_switch_data {
+	struct device *dev;
+	struct cros_ec_device *ec;
+	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
+};
+
+static int cros_typec_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
+{
+	return 0;
+}
+
+static void cros_typec_unregister_switches(struct cros_typec_switch_data *sdata)
+{
+	int i;
+
+	for (i = 0; i < EC_USB_PD_MAX_PORTS; i++) {
+		if (!sdata->ports[i])
+			continue;
+		typec_retimer_unregister(sdata->ports[i]->retimer);
+	}
+}
+
+static int cros_typec_register_retimer(struct cros_typec_port *port, struct fwnode_handle *fwnode)
+{
+	struct typec_retimer_desc retimer_desc = {
+		.fwnode = fwnode,
+		.drvdata = port,
+		.name = fwnode_get_name(fwnode),
+		.set = cros_typec_retimer_set,
+	};
+
+	port->retimer = typec_retimer_register(port->sdata->dev, &retimer_desc);
+	if (IS_ERR(port->retimer))
+		return PTR_ERR(port->retimer);
+
+	return 0;
+}
+
+static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
+{
+	struct cros_typec_port *port = NULL;
+	struct device *dev = sdata->dev;
+	struct fwnode_handle *fwnode;
+	struct acpi_device *adev;
+	unsigned long long index;
+	int ret = 0;
+	int nports;
+
+	nports = device_get_child_node_count(dev);
+	if (nports == 0) {
+		dev_err(dev, "No switch devices found.\n");
+		return -ENODEV;
+	}
+
+	device_for_each_child_node(dev, fwnode) {
+		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+		if (!port) {
+			ret = -ENOMEM;
+			goto err_switch;
+		}
+
+		adev = to_acpi_device_node(fwnode);
+		if (!adev) {
+			dev_err(fwnode->dev, "Couldn't get ACPI device handle\n");
+			ret = -ENODEV;
+			goto err_switch;
+		}
+
+		ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &index);
+		if (ACPI_FAILURE(ret)) {
+			dev_err(fwnode->dev, "_ADR wasn't evaluated\n");
+			ret = -ENODATA;
+			goto err_switch;
+		}
+
+		if (index < 0 || index >= EC_USB_PD_MAX_PORTS) {
+			dev_err(fwnode->dev, "Invalid port index number: %llu", index);
+			ret = -EINVAL;
+			goto err_switch;
+		}
+		port->sdata = sdata;
+		port->port_num = index;
+		sdata->ports[index] = port;
+
+		ret = cros_typec_register_retimer(port, fwnode);
+		if (ret) {
+			dev_err(dev, "Retimer switch register failed\n");
+			goto err_switch;
+		}
+
+		dev_dbg(dev, "Retimer switch registered for index %llu\n", index);
+	}
+
+	return 0;
+err_switch:
+	cros_typec_unregister_switches(sdata);
+	return ret;
+}
+
+static int cros_typec_switch_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_typec_switch_data *sdata;
+
+	sdata = devm_kzalloc(dev, sizeof(*sdata), GFP_KERNEL);
+	if (!sdata)
+		return -ENOMEM;
+
+	sdata->dev = dev;
+	sdata->ec = dev_get_drvdata(pdev->dev.parent);
+
+	platform_set_drvdata(pdev, sdata);
+
+	return cros_typec_register_switches(sdata);
+}
+
+static int cros_typec_switch_remove(struct platform_device *pdev)
+{
+	struct cros_typec_switch_data *sdata = platform_get_drvdata(pdev);
+
+	cros_typec_unregister_switches(sdata);
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cros_typec_switch_acpi_id[] = {
+	{ "GOOG001A", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, cros_typec_switch_acpi_id);
+#endif
+
+static struct platform_driver cros_typec_switch_driver = {
+	.driver	= {
+		.name = DRV_NAME,
+		.acpi_match_table = ACPI_PTR(cros_typec_switch_acpi_id),
+	},
+	.probe = cros_typec_switch_probe,
+	.remove = cros_typec_switch_remove,
+};
+
+module_platform_driver(cros_typec_switch_driver);
+
+MODULE_AUTHOR("Prashant Malani <pmalani@chromium.org>");
+MODULE_DESCRIPTION("Chrome OS EC Type C Switch control");
+MODULE_LICENSE("GPL");
-- 
2.37.1.595.g718a3a8f04-goog

