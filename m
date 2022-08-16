Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107E95964E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiHPVuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbiHPVuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:50:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C0F71BDA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:49:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 17so10420017pli.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Q4zoMhmVpBlLqmtSRNrbVa7gTMbKl6eNBoUi0qpgn3E=;
        b=fCPsDw/r5fnExQMIkEHHsstPyHzT5sJhS0E8Qa217xg+unHhETgPfWdqTePf9TKlLm
         OIV0gDs2sWTN9L+gNlxsELPYR2onBQmgagXLzKsD+aykTvuNHWt4LQqRnYjB1mDhpeFN
         T9nGQdvC8VYfgd8PWjFoo5fthfVPwYlHENHTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Q4zoMhmVpBlLqmtSRNrbVa7gTMbKl6eNBoUi0qpgn3E=;
        b=TD/91he/1Jhxbm6XMZfL+jBMJ2oiUfk7+u+61C20fda17bQJGUFFB9WJh15yiB2Ss/
         armuFyg8pWYLMLY0fAXaTuecI7AF82bepqfHlXhVzYSkEzWJxwbiGdKUocr91lcKsHRd
         0K2GC0xqwov40zwe7ffDzir+YG0Kl2RIts9QNjNOkwk5mlT6VnV9kTn3TmU7zpeNfIe/
         9jFYWJGCM0AJAc5iBiMVyHla03PxLNTVyly3ZsPePlrYHN+xBpzxj7ouwJEUhqnLBDKg
         Cs9UZ7gk5c4RflH6rRzBzuBmG1dDQ6hpGKQ74rnpnLda8kyjqMVQFzZPwpY88lQtdagE
         OuDQ==
X-Gm-Message-State: ACgBeo3G8QirdDrAIRf0GnhiaHCVzEMz9O1/FlTwFSs9nKvI1IglPEd9
        36hKsKeiQ86A1b67m/p3JppQg5iBzbNHnQ==
X-Google-Smtp-Source: AA6agR5AdidDLEA9mMTsAH8df/6yVyuy7N/c/eFNbzd/K+0cy/zrKKtVDvh4sCNr7iD53su7FYqoaw==
X-Received: by 2002:a17:902:f64a:b0:172:7576:2124 with SMTP id m10-20020a170902f64a00b0017275762124mr8101036plg.155.1660686595664;
        Tue, 16 Aug 2022 14:49:55 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id z5-20020a623305000000b005323a1a9fecsm8916650pfz.101.2022.08.16.14.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:49:55 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v6 2/7] platform/chrome: cros_typec_switch: Add switch driver
Date:   Tue, 16 Aug 2022 21:48:30 +0000
Message-Id: <20220816214857.2088914-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220816214857.2088914-1-pmalani@chromium.org>
References: <20220816214857.2088914-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a driver to configure USB Type-C mode switches and retimers
which are controlled by the ChromeOS EC (Embedded Controller).
This allows Type-C port drivers, as well as alternate mode drivers to
configure their relevant mode switches and retimers according to the
Type-C state they want to achieve.

ACPI devices with ID GOOG001A will bind to this driver.

Currently, we only register a retimer switch with a stub set function.
Subsequent patches will implement the host command set functionality,
and introduce mode switches.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v5:
- Change "Chrome OS -> "ChromeOS".
- Change "Type C" -> "Type-C".
- Remove unnecessary variable init in cros_typec_register_switches().

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
 drivers/platform/chrome/cros_typec_switch.c | 169 ++++++++++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_typec_switch.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..c1e4977cb1c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4894,6 +4894,7 @@ M:	Prashant Malani <pmalani@chromium.org>
 L:	chrome-platform@lists.linux.dev
 S:	Maintained
 F:	drivers/platform/chrome/cros_ec_typec.c
+F:	drivers/platform/chrome/cros_typec_switch.c
 
 CHROMEOS EC USB PD NOTIFY DRIVER
 M:	Prashant Malani <pmalani@chromium.org>
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index c45fb376d653..6b954c5acadb 100644
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
+	  If you say Y here, you get support for configuring the ChromeOS EC Type-C
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
index 000000000000..db773bf57899
--- /dev/null
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2022 Google LLC
+ *
+ * This driver provides the ability to configure Type-C muxes and retimers which are controlled by
+ * the ChromeOS EC.
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
+	struct cros_typec_port *port;
+	struct device *dev = sdata->dev;
+	struct fwnode_handle *fwnode;
+	struct acpi_device *adev;
+	unsigned long long index;
+	int nports, ret;
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
+MODULE_DESCRIPTION("ChromeOS EC Type-C Switch control");
+MODULE_LICENSE("GPL");
-- 
2.37.1.595.g718a3a8f04-goog

