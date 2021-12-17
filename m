Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35C6479578
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbhLQU27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbhLQU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:28:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEBBC061746
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:28:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j204-20020a2523d5000000b005c21574c704so6879677ybj.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hG4ZnuxgGBUFxXxwDyVLqbjNwRWc8TyfZ/N8ZcihYgE=;
        b=sJl/sdPGiXWSl8Dg24z4et8JM7fCrJrNaMVFBcVLbvfjIhApmeuL8LVy9JYmtHGs1H
         kjrMLNnSqVldyToX8kePmJU8JiAhE8Q94q8MWVa22jakPoy5lhZLyOuFdHd46J/4dLis
         lUqz7mETF9d6Dv5vQMVNeaAZxNjwhQgnXEAK3gnIRQOaPfUU6YYrmytIe7xYybVEb6+O
         c3012/Yn8Lavs9JqfPOYPde4Sgk+Xi3OQ3pfy6ywkvUjUtvvrDT+YRfdyiIaf0Q4mTg2
         A1Rn0q+MrI8nvMOCJub/wxFJ+mcFuTurOF7TTZ1EMzsDRlBGDDnoAkea4/ysXQdGw3jH
         SI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hG4ZnuxgGBUFxXxwDyVLqbjNwRWc8TyfZ/N8ZcihYgE=;
        b=lf/fZkqeQXS23G/bYdWgKPVzDXsckDTv3U8aUdWKlbJEMyrvxMVk6MeTx+tGMB3Lpm
         lJGj6O66tvH0z1r8siKOt/LFEyXHwcUxqb1PKYimiegNyTDDKD8wpMwZISx0+bVJlzvA
         qGXkUp6ctcXEvNuqpW2+6MOBeLMTjP56AqbdYGZaMHdFsC6+pdqzmidDCg3WLwrr4adq
         DwKIXLdeWP4ykLlYcZT3Ebm7WdiTNu5HzspSxyLRkG9QQmabXW5WFTqhbxCi/kAEkzQF
         qTH5lWBMeJA2SC7hLpsWvkds26QKF6aB41zjk+VGujQrsYGdFkOegp76SKghiE/4e6YA
         7P1w==
X-Gm-Message-State: AOAM532+MJogxZ1d6xEioRy1BZLePrmIIwiO15ePZWUhBT5MimGABx1K
        ySb779FyrZoXs6D/n0gPdVG+IbxN8DEM
X-Google-Smtp-Source: ABdhPJz4OF1BNEmrOoVJY/h7W/jYhTOZGKm/yEBShvJn6ah+cuVkUwOA9FzuFGtdq6KV1vTKqLWo+P+sxBfG
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:1bc7:219f:9362:ade9])
 (user=rajatja job=sendgmr) by 2002:a25:31d5:: with SMTP id
 x204mr6558872ybx.750.1639772935122; Fri, 17 Dec 2021 12:28:55 -0800 (PST)
Date:   Fri, 17 Dec 2021 12:28:49 -0800
Message-Id: <20211217202850.1967594-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 1/2] platform/chrome: Add driver for ChromeOS privacy-screen
From:   Rajat Jain <rajatja@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        gwendal@google.com, seanpaul@google.com, marcheau@google.com,
        dtor@google.com
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the ACPI driver for the ChromeOS privacy screen that is
present on some chromeos devices.

Note that ideally, we'd want this privacy screen driver to be probed
BEFORE the drm probe in order to avoid a drm probe deferral:
https://hansdegoede.livejournal.com/25948.html

In practise, I found that ACPI drivers are bound to their devices AFTER
the drm probe on chromebooks. So on chromebooks with privacy-screen,
this patch along with the next one in this series results in a probe
deferral of about 250ms for i915 driver. However, it did not result in
any user noticeable delay of splash screen in my personal experience.

In future if this probe deferral turns out to be an issue, we can
consider turning this ACPI driver into something that is probed
earlier than the drm drivers.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: * Reword the commit log
    * Make the Kconfig into a tristate
    * Reorder the patches in the series.

 drivers/platform/chrome/Kconfig              |   9 ++
 drivers/platform/chrome/Makefile             |   1 +
 drivers/platform/chrome/chromeos_priv_scrn.c | 132 +++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 drivers/platform/chrome/chromeos_priv_scrn.c

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index ccc23d8686e8..d1c209a45a62 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -243,6 +243,15 @@ config CROS_USBPD_NOTIFY
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_usbpd_notify.
 
+config CHROMEOS_PRIVACY_SCREEN
+	tristate "ChromeOS Privacy Screen support"
+	depends on ACPI
+	depends on DRM
+	select DRM_PRIVACY_SCREEN
+	help
+	  This driver provides the support needed for the in-built electronic
+	  privacy screen that is present on some ChromeOS devices.
+
 source "drivers/platform/chrome/wilco_ec/Kconfig"
 
 endif # CHROMEOS_PLATFORMS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index f901d2e43166..cfa0bb4e9e34 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -4,6 +4,7 @@
 CFLAGS_cros_ec_trace.o:=		-I$(src)
 
 obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
+obj-$(CONFIG_CHROMEOS_PRIVACY_SCREEN)	+= chromeos_priv_scrn.o
 obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
 obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
 obj-$(CONFIG_CROS_EC)			+= cros_ec.o
diff --git a/drivers/platform/chrome/chromeos_priv_scrn.c b/drivers/platform/chrome/chromeos_priv_scrn.c
new file mode 100644
index 000000000000..a4cbf5c79c2a
--- /dev/null
+++ b/drivers/platform/chrome/chromeos_priv_scrn.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ *  chromeos_priv_scrn.c - ChromeOS Privacy Screen support
+ *
+ * Copyright (C) 2022 The Chromium OS Authors
+ *
+ */
+
+#include <linux/acpi.h>
+#include <drm/drm_privacy_screen_driver.h>
+
+/*
+ * The DSM (Define Specific Method) constants below are the agreed API with
+ * the firmware team, on how to control privacy screen using ACPI methods.
+ */
+#define PRIV_SCRN_DSM_REVID		1	/* DSM version */
+#define PRIV_SCRN_DSM_FN_GET_STATUS	1	/* Get privacy screen status */
+#define PRIV_SCRN_DSM_FN_ENABLE		2	/* Enable privacy screen */
+#define PRIV_SCRN_DSM_FN_DISABLE	3	/* Disable privacy screen */
+
+static const guid_t chromeos_priv_scrn_dsm_guid =
+		    GUID_INIT(0xc7033113, 0x8720, 0x4ceb,
+			      0x90, 0x90, 0x9d, 0x52, 0xb3, 0xe5, 0x2d, 0x73);
+
+static void
+chromeos_priv_scrn_get_hw_state(struct drm_privacy_screen *drm_priv_scrn)
+{
+	union acpi_object *obj;
+	acpi_handle handle;
+	struct device *priv_scrn = drm_priv_scrn->dev.parent;
+
+	if (!priv_scrn)
+		return;
+
+	handle = acpi_device_handle(to_acpi_device(priv_scrn));
+	obj = acpi_evaluate_dsm(handle, &chromeos_priv_scrn_dsm_guid,
+				PRIV_SCRN_DSM_REVID,
+				PRIV_SCRN_DSM_FN_GET_STATUS, NULL);
+	if (!obj) {
+		dev_err(priv_scrn, "_DSM failed to get privacy-screen state\n");
+		return;
+	}
+
+	if (obj->type != ACPI_TYPE_INTEGER)
+		dev_err(priv_scrn, "Bad _DSM to get privacy-screen state\n");
+	else if (obj->integer.value == 1)
+		drm_priv_scrn->hw_state = drm_priv_scrn->sw_state =
+			PRIVACY_SCREEN_ENABLED;
+	else
+		drm_priv_scrn->hw_state = drm_priv_scrn->sw_state =
+			PRIVACY_SCREEN_DISABLED;
+
+	ACPI_FREE(obj);
+}
+
+static int
+chromeos_priv_scrn_set_sw_state(struct drm_privacy_screen *drm_priv_scrn,
+				enum drm_privacy_screen_status state)
+{
+	union acpi_object *obj = NULL;
+	acpi_handle handle;
+	struct device *priv_scrn = drm_priv_scrn->dev.parent;
+
+	if (!priv_scrn)
+		return -ENODEV;
+
+	handle = acpi_device_handle(to_acpi_device(priv_scrn));
+
+	if (state == PRIVACY_SCREEN_DISABLED) {
+		obj = acpi_evaluate_dsm(handle,	&chromeos_priv_scrn_dsm_guid,
+					PRIV_SCRN_DSM_REVID,
+					PRIV_SCRN_DSM_FN_DISABLE, NULL);
+	} else if (state == PRIVACY_SCREEN_ENABLED) {
+		obj = acpi_evaluate_dsm(handle,	&chromeos_priv_scrn_dsm_guid,
+					PRIV_SCRN_DSM_REVID,
+					PRIV_SCRN_DSM_FN_ENABLE, NULL);
+	} else {
+		dev_err(priv_scrn, "Bad attempt to set privacy-screen status\n");
+		return -EINVAL;
+	}
+
+	if (!obj) {
+		dev_err(priv_scrn, "_DSM failed to set privacy-screen state\n");
+		return -EIO;
+	}
+
+	drm_priv_scrn->hw_state = drm_priv_scrn->sw_state = state;
+	ACPI_FREE(obj);
+	return 0;
+}
+
+static const struct drm_privacy_screen_ops chromeos_priv_scrn_ops = {
+	.get_hw_state = chromeos_priv_scrn_get_hw_state,
+	.set_sw_state = chromeos_priv_scrn_set_sw_state,
+};
+
+static int chromeos_priv_scrn_add(struct acpi_device *adev)
+{
+	struct drm_privacy_screen *drm_priv_scrn =
+		drm_privacy_screen_register(&adev->dev, &chromeos_priv_scrn_ops);
+
+	if (IS_ERR(drm_priv_scrn)) {
+		dev_err(&adev->dev, "Error registering privacy-screen\n");
+		return PTR_ERR(drm_priv_scrn);
+	}
+
+	dev_info(&adev->dev, "registered privacy-screen '%s'\n",
+		 dev_name(&drm_priv_scrn->dev));
+
+	return 0;
+}
+
+static const struct acpi_device_id chromeos_priv_scrn_device_ids[] = {
+	{"GOOG0010", 0}, /* Google's electronic privacy screen for eDP-1 */
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, chromeos_priv_scrn_device_ids);
+
+static struct acpi_driver chromeos_priv_scrn_driver = {
+	.name = "chromeos_priv_scrn_drvr",
+	.class = "ChromeOS",
+	.ids = chromeos_priv_scrn_device_ids,
+	.ops = {
+		.add = chromeos_priv_scrn_add,
+	},
+};
+
+module_acpi_driver(chromeos_priv_scrn_driver);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ChromeOS ACPI Privacy Screen driver");
+MODULE_AUTHOR("Rajat Jain <rajatja@google.com>");
-- 
2.34.1.307.g9b7440fafd-goog

