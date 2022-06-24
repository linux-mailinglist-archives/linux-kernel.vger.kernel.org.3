Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D29055A14B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiFXShK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiFXShH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:37:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751F980507;
        Fri, 24 Jun 2022 11:37:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ge10so6385469ejb.7;
        Fri, 24 Jun 2022 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uwgVPZHuVMNkdfCa9UKUwY1cxzbIh3l91t/u7GZPQdk=;
        b=SFDn17tQvIfE69hDuDP35SrwWTg3D4/IonxhTsD/YLQOtvqNiA3NGg0Zx+X7vRwp/N
         2QazRVybQ/4ZceKRQzb8AFPcYCyxvQaBLkByFztDjnSsU9e+m6O42haLHQa7Vj80vcO4
         RSOzvDXDyzh3ERHmZwUCoZcL4BHyLVPxQGlW58Oe7YslzWYCYiISj3B8TghSy2eBfDJI
         ZttYrQp6FbkufIvEksPJj8QDuqTpgbPQVw4qGssbA85oPQhJWFdQSRLu2rIgYZr72c0i
         HhNqcG6Xmr9N2RkUQli+rfnbD3GhPvGngXof/0QiUaozcV6xI3uiHS638bMjU+pUdZRF
         VPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uwgVPZHuVMNkdfCa9UKUwY1cxzbIh3l91t/u7GZPQdk=;
        b=WUxli5GdyEvIGXG4BLiPsMyswqJrHgIrmUuFQhRzgORxUUS4SNcxr8ucXaHHsFa8HC
         lsAf2pG/ml4rwdY0wF0Z5azuNCI98/Wr4n51g4AnNAQiNvs6THpio9OBxA2r00UFsatj
         Z+4s1HMaTTh8bjUkistgsJD0bDyRDyPvzjq9daNrtU5lh5L9GVAdyNvcC3tbp0FB3FE8
         RFoWhD5BRtFI1VO6SwYOb+E9aezx5j33AJj4T28CSr88tVdv6R8BS3b0jpy6FbIu6lF6
         4nv/ubH7Xb0slt+BiU3LDrHuwB3xvSYmQ2cRqqzvxBkw4V7nQiY6rNr5vwyKIYjErTmc
         disA==
X-Gm-Message-State: AJIora8R8YHvvjLOkoLkXgBB4m3vWF3aOkQMT6fXkijKAhQUY8egE7OZ
        i6D85gGHviZtujf6pykuttU=
X-Google-Smtp-Source: AGRyM1sm6lMMlumIPpmGRAWfdOdVhgyEzLxZmD4DPZGiRJ2tutc7gySrKYqmwfu2+95Zr1Ywvw6trA==
X-Received: by 2002:a17:907:3e18:b0:722:be7e:302c with SMTP id hp24-20020a1709073e1800b00722be7e302cmr339265ejc.437.1656095823848;
        Fri, 24 Jun 2022 11:37:03 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id jw12-20020a170906e94c00b00722e8827c53sm1493822ejb.208.2022.06.24.11.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:37:03 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 2/4] platform/surface: Add KIP/POS tablet-mode switch driver
Date:   Fri, 24 Jun 2022 20:36:40 +0200
Message-Id: <20220624183642.910893-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624183642.910893-1-luzmaximilian@gmail.com>
References: <20220624183642.910893-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver providing a tablet-mode switch input device for Microsoft
Surface devices using the Surface Aggregator KIP subsystem (to manage
detachable peripherals) or POS subsystem (to obtain device posture
information).

The KIP (full name unknown, abbreviation found through reverse
engineering) subsystem is used on the Surface Pro 8 and Surface Pro X to
manage the keyboard cover. Among other things, it provides information
on the positioning (posture) of the cover (closed, laptop-style,
detached, folded-back, ...), which can be used to implement an input
device providing the SW_TABLET_MODE event. Similarly, the POS (posture
information) subsystem provides such information on the Surface Laptop
Studio, with the difference being that the keyboard is not detachable.

As implementing the tablet-mode switch for both subsystems is largely
similar, the driver proposed in this commit, in large, acts as a generic
tablet mode switch driver framework for the Surface Aggregator Module.
Specific implementations using this framework are provided for the KIP
and POS subsystems, adding tablet-mode switch support to the
aforementioned devices.

A few more notes on the Surface Laptop Studio:

A peculiarity of the Surface Laptop Studio is its "slate/tent" mode
(symbolized: user> _/\). In this mode, the screen covers the keyboard
but leaves the touchpad exposed. This is essentially a mode in-between
tablet and laptop, and it is debatable whether tablet-mode should be
enabled in this mode. We therefore let the user decide this via a module
parameter.

In particular, tablet-mode may bring up the on-screen touch keyboard
more easily, which would be desirable in this mode. However, some
user-space software currently also decides to disable keyboard and, more
importantly, touchpad input, while the touchpad is still accessible in
the "slate/tent" mode. Furthermore, this mode shares its identifier with
"slate/flipped" mode where the screen is flipped 180° and the keyboard
points away from the user (symbolized: user> /_). In this mode we would
like to enable auto-rotation, something that user-space software may
only do when tablet-mode is enabled. We therefore default to the
slate-mode enabling the tablet-mode switch.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../sysfs-bus-surface_aggregator-tabletsw     |  57 ++
 MAINTAINERS                                   |   6 +
 drivers/platform/surface/Kconfig              |  23 +
 drivers/platform/surface/Makefile             |   1 +
 .../surface/surface_aggregator_tabletsw.c     | 533 ++++++++++++++++++
 5 files changed, 620 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-surface_aggregator-tabletsw
 create mode 100644 drivers/platform/surface/surface_aggregator_tabletsw.c

diff --git a/Documentation/ABI/testing/sysfs-bus-surface_aggregator-tabletsw b/Documentation/ABI/testing/sysfs-bus-surface_aggregator-tabletsw
new file mode 100644
index 000000000000..74cd9d754e60
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-surface_aggregator-tabletsw
@@ -0,0 +1,57 @@
+What:		/sys/bus/surface_aggregator/devices/01:0e:01:00:01/state
+Date:		July 2022
+KernelVersion:	5.20
+Contact:	Maximilian Luz <luzmaximilian@gmail.com>
+Description:
+		This attribute returns a string with the current type-cover
+		or device posture, as indicated by the embedded controller.
+		Currently returned posture states are:
+
+		- "disconnected": The type-cover has been disconnected.
+
+		- "closed": The type-cover has been folded closed and lies on
+		  top of the display.
+
+		- "laptop": The type-cover is open and in laptop-mode, i.e.,
+		  ready for normal use.
+
+		- "folded-canvas": The type-cover has been folded back
+		  part-ways, but does not lie flush with the back side of the
+		  device. In general, this means that the kick-stand is used
+		  and extended atop of the cover.
+
+		- "folded-back": The type cover has been fully folded back and
+		  lies flush with the back side of the device.
+
+		- "<unknown>": The current state is unknown to the driver, for
+		  example due to newer as-of-yet unsupported hardware.
+
+		New states may be introduced with new hardware. Users therefore
+		must not rely on this list of states being exhaustive and
+		gracefully handle unknown states.
+
+What:		/sys/bus/surface_aggregator/devices/01:26:01:00:01/state
+Date:		July 2022
+KernelVersion:	5.20
+Contact:	Maximilian Luz <luzmaximilian@gmail.com>
+Description:
+		This attribute returns a string with the current device posture, as indicated by the embedded controller. Currently
+		returned posture states are:
+
+		- "closed": The lid of the device is closed.
+
+		- "laptop": The lid of the device is opened and the device
+		  operates as a normal laptop.
+
+		- "slate": The screen covers the keyboard or has been flipped
+		  back and the device operates mainly based on touch input.
+
+		- "tablet": The device operates as tablet and exclusively
+		  relies on touch input (or external peripherals).
+
+		- "<unknown>": The current state is unknown to the driver, for
+		  example due to newer as-of-yet unsupported hardware.
+
+		New states may be introduced with new hardware. Users therefore
+		must not rely on this list of states being exhaustive and
+		gracefully handle unknown states.
diff --git a/MAINTAINERS b/MAINTAINERS
index 2a34deb24594..c6d8c0c6bf6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13176,6 +13176,12 @@ F:	drivers/scsi/smartpqi/smartpqi*.[ch]
 F:	include/linux/cciss*.h
 F:	include/uapi/linux/cciss*.h
 
+MICROSOFT SURFACE AGGREGATOR TABLET-MODE SWITCH
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/surface/surface_aggregator_tablet_switch.c
+
 MICROSOFT SURFACE BATTERY AND AC DRIVERS
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index eb79fbed8059..b152e930cc84 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -99,6 +99,29 @@ config SURFACE_AGGREGATOR_REGISTRY
 	  the respective client devices. Drivers for these devices still need to
 	  be selected via the other options.
 
+config SURFACE_AGGREGATOR_TABLET_SWITCH
+	tristate "Surface Aggregator Generic Tablet-Mode Switch Driver"
+	depends on SURFACE_AGGREGATOR
+	depends on SURFACE_AGGREGATOR_BUS
+	depends on INPUT
+	help
+	  Provides a tablet-mode switch input device on Microsoft Surface models
+	  using the KIP subsystem for detachable keyboards (e.g. keyboard covers)
+	  or the POS subsystem for device/screen posture changes.
+
+	  The KIP subsystem is used on newer Surface generations to handle
+	  detachable input peripherals, specifically the keyboard cover (containing
+	  keyboard and touchpad) on the Surface Pro 8 and Surface Pro X. The POS
+	  subsystem is used for device posture change notifications on the Surface
+	  Laptop Studio. This module provides a driver to let user-space know when
+	  the device should be considered in tablet-mode due to the keyboard cover
+	  being detached or folded back (essentially signaling when the keyboard is
+	  not available for input). It does so by creating a tablet-mode switch
+	  input device, sending the standard SW_TABLET_MODE event on mode change.
+
+	  Select M or Y here, if you want to provide tablet-mode switch input
+	  events on the Surface Pro 8, Surface Pro X, and Surface Laptop Studio.
+
 config SURFACE_DTX
 	tristate "Surface DTX (Detachment System) Driver"
 	depends on SURFACE_AGGREGATOR
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 0fc9cd3e4dd9..18b27898543e 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SURFACE_ACPI_NOTIFY)	+= surface_acpi_notify.o
 obj-$(CONFIG_SURFACE_AGGREGATOR)	+= aggregator/
 obj-$(CONFIG_SURFACE_AGGREGATOR_CDEV)	+= surface_aggregator_cdev.o
 obj-$(CONFIG_SURFACE_AGGREGATOR_REGISTRY) += surface_aggregator_registry.o
+obj-$(CONFIG_SURFACE_AGGREGATOR_TABLET_SWITCH) += surface_aggregator_tabletsw.o
 obj-$(CONFIG_SURFACE_DTX)		+= surface_dtx.o
 obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
 obj-$(CONFIG_SURFACE_HOTPLUG)		+= surface_hotplug.o
diff --git a/drivers/platform/surface/surface_aggregator_tabletsw.c b/drivers/platform/surface/surface_aggregator_tabletsw.c
new file mode 100644
index 000000000000..596ca6c80681
--- /dev/null
+++ b/drivers/platform/surface/surface_aggregator_tabletsw.c
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Surface System Aggregator Module (SSAM) tablet mode switch driver.
+ *
+ * Copyright (C) 2022 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <linux/surface_aggregator/controller.h>
+#include <linux/surface_aggregator/device.h>
+
+
+/* -- SSAM generic tablet switch driver framework. -------------------------- */
+
+struct ssam_tablet_sw;
+
+struct ssam_tablet_sw_ops {
+	int (*get_state)(struct ssam_tablet_sw *sw, u32 *state);
+	const char *(*state_name)(struct ssam_tablet_sw *sw, u32 state);
+	bool (*state_is_tablet_mode)(struct ssam_tablet_sw *sw, u32 state);
+};
+
+struct ssam_tablet_sw {
+	struct ssam_device *sdev;
+
+	u32 state;
+	struct work_struct update_work;
+	struct input_dev *mode_switch;
+
+	struct ssam_tablet_sw_ops ops;
+	struct ssam_event_notifier notif;
+};
+
+struct ssam_tablet_sw_desc {
+	struct {
+		const char *name;
+		const char *phys;
+	} dev;
+
+	struct {
+		u32 (*notify)(struct ssam_event_notifier *nf, const struct ssam_event *event);
+		int (*get_state)(struct ssam_tablet_sw *sw, u32 *state);
+		const char *(*state_name)(struct ssam_tablet_sw *sw, u32 state);
+		bool (*state_is_tablet_mode)(struct ssam_tablet_sw *sw, u32 state);
+	} ops;
+
+	struct {
+		struct ssam_event_registry reg;
+		struct ssam_event_id id;
+		enum ssam_event_mask mask;
+		u8 flags;
+	} event;
+};
+
+static ssize_t state_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ssam_tablet_sw *sw = dev_get_drvdata(dev);
+	const char *state = sw->ops.state_name(sw, sw->state);
+
+	return sysfs_emit(buf, "%s\n", state);
+}
+static DEVICE_ATTR_RO(state);
+
+static struct attribute *ssam_tablet_sw_attrs[] = {
+	&dev_attr_state.attr,
+	NULL,
+};
+
+static const struct attribute_group ssam_tablet_sw_group = {
+	.attrs = ssam_tablet_sw_attrs,
+};
+
+static void ssam_tablet_sw_update_workfn(struct work_struct *work)
+{
+	struct ssam_tablet_sw *sw = container_of(work, struct ssam_tablet_sw, update_work);
+	int tablet, status;
+	u32 state;
+
+	status = sw->ops.get_state(sw, &state);
+	if (status)
+		return;
+
+	if (sw->state == state)
+		return;
+	sw->state = state;
+
+	/* Send SW_TABLET_MODE event. */
+	tablet = sw->ops.state_is_tablet_mode(sw, state);
+	input_report_switch(sw->mode_switch, SW_TABLET_MODE, tablet);
+	input_sync(sw->mode_switch);
+}
+
+static int __maybe_unused ssam_tablet_sw_resume(struct device *dev)
+{
+	struct ssam_tablet_sw *sw = dev_get_drvdata(dev);
+
+	schedule_work(&sw->update_work);
+	return 0;
+}
+static SIMPLE_DEV_PM_OPS(ssam_tablet_sw_pm_ops, NULL, ssam_tablet_sw_resume);
+
+static int ssam_tablet_sw_probe(struct ssam_device *sdev)
+{
+	const struct ssam_tablet_sw_desc *desc;
+	struct ssam_tablet_sw *sw;
+	int tablet, status;
+
+	desc = ssam_device_get_match_data(sdev);
+	if (!desc) {
+		WARN(1, "no driver match data specified");
+		return -EINVAL;
+	}
+
+	sw = devm_kzalloc(&sdev->dev, sizeof(*sw), GFP_KERNEL);
+	if (!sw)
+		return -ENOMEM;
+
+	sw->sdev = sdev;
+
+	sw->ops.get_state = desc->ops.get_state;
+	sw->ops.state_name = desc->ops.state_name;
+	sw->ops.state_is_tablet_mode = desc->ops.state_is_tablet_mode;
+
+	INIT_WORK(&sw->update_work, ssam_tablet_sw_update_workfn);
+
+	ssam_device_set_drvdata(sdev, sw);
+
+	/* Get initial state. */
+	status = sw->ops.get_state(sw, &sw->state);
+	if (status)
+		return status;
+
+	/* Set up tablet mode switch. */
+	sw->mode_switch = devm_input_allocate_device(&sdev->dev);
+	if (!sw->mode_switch)
+		return -ENOMEM;
+
+	sw->mode_switch->name = desc->dev.name;
+	sw->mode_switch->phys = desc->dev.phys;
+	sw->mode_switch->id.bustype = BUS_HOST;
+	sw->mode_switch->dev.parent = &sdev->dev;
+
+	tablet = sw->ops.state_is_tablet_mode(sw, sw->state);
+	input_set_capability(sw->mode_switch, EV_SW, SW_TABLET_MODE);
+	input_report_switch(sw->mode_switch, SW_TABLET_MODE, tablet);
+
+	status = input_register_device(sw->mode_switch);
+	if (status)
+		return status;
+
+	/* Set up notifier. */
+	sw->notif.base.priority = 0;
+	sw->notif.base.fn = desc->ops.notify;
+	sw->notif.event.reg = desc->event.reg;
+	sw->notif.event.id = desc->event.id;
+	sw->notif.event.mask = desc->event.mask;
+	sw->notif.event.flags = SSAM_EVENT_SEQUENCED;
+
+	status = ssam_device_notifier_register(sdev, &sw->notif);
+	if (status)
+		return status;
+
+	status = sysfs_create_group(&sdev->dev.kobj, &ssam_tablet_sw_group);
+	if (status)
+		goto err;
+
+	/* We might have missed events during setup, so check again. */
+	schedule_work(&sw->update_work);
+	return 0;
+
+err:
+	ssam_device_notifier_unregister(sdev, &sw->notif);
+	cancel_work_sync(&sw->update_work);
+	return status;
+}
+
+static void ssam_tablet_sw_remove(struct ssam_device *sdev)
+{
+	struct ssam_tablet_sw *sw = ssam_device_get_drvdata(sdev);
+
+	sysfs_remove_group(&sdev->dev.kobj, &ssam_tablet_sw_group);
+
+	ssam_device_notifier_unregister(sdev, &sw->notif);
+	cancel_work_sync(&sw->update_work);
+}
+
+
+/* -- SSAM KIP tablet switch implementation. -------------------------------- */
+
+#define SSAM_EVENT_KIP_CID_COVER_STATE_CHANGED	0x1d
+
+enum ssam_kip_cover_state {
+	SSAM_KIP_COVER_STATE_DISCONNECTED  = 0x01,
+	SSAM_KIP_COVER_STATE_CLOSED        = 0x02,
+	SSAM_KIP_COVER_STATE_LAPTOP        = 0x03,
+	SSAM_KIP_COVER_STATE_FOLDED_CANVAS = 0x04,
+	SSAM_KIP_COVER_STATE_FOLDED_BACK   = 0x05,
+};
+
+static const char *ssam_kip_cover_state_name(struct ssam_tablet_sw *sw, u32 state)
+{
+	switch (state) {
+	case SSAM_KIP_COVER_STATE_DISCONNECTED:
+		return "disconnected";
+
+	case SSAM_KIP_COVER_STATE_CLOSED:
+		return "closed";
+
+	case SSAM_KIP_COVER_STATE_LAPTOP:
+		return "laptop";
+
+	case SSAM_KIP_COVER_STATE_FOLDED_CANVAS:
+		return "folded-canvas";
+
+	case SSAM_KIP_COVER_STATE_FOLDED_BACK:
+		return "folded-back";
+
+	default:
+		dev_warn(&sw->sdev->dev, "unknown KIP cover state: %u\n", state);
+		return "<unknown>";
+	}
+}
+
+static bool ssam_kip_cover_state_is_tablet_mode(struct ssam_tablet_sw *sw, u32 state)
+{
+	switch (state) {
+	case SSAM_KIP_COVER_STATE_DISCONNECTED:
+	case SSAM_KIP_COVER_STATE_FOLDED_CANVAS:
+	case SSAM_KIP_COVER_STATE_FOLDED_BACK:
+		return true;
+
+	case SSAM_KIP_COVER_STATE_CLOSED:
+	case SSAM_KIP_COVER_STATE_LAPTOP:
+		return false;
+
+	default:
+		dev_warn(&sw->sdev->dev, "unknown KIP cover state: %d\n", sw->state);
+		return true;
+	}
+}
+
+SSAM_DEFINE_SYNC_REQUEST_R(__ssam_kip_get_cover_state, u8, {
+	.target_category = SSAM_SSH_TC_KIP,
+	.target_id       = 0x01,
+	.command_id      = 0x1d,
+	.instance_id     = 0x00,
+});
+
+static int ssam_kip_get_cover_state(struct ssam_tablet_sw *sw, u32 *state)
+{
+	int status;
+	u8 raw;
+
+	status = ssam_retry(__ssam_kip_get_cover_state, sw->sdev->ctrl, &raw);
+	if (status < 0) {
+		dev_err(&sw->sdev->dev, "failed to query KIP lid state: %d\n", status);
+		return status;
+	}
+
+	*state = raw;
+	return 0;
+}
+
+static u32 ssam_kip_sw_notif(struct ssam_event_notifier *nf, const struct ssam_event *event)
+{
+	struct ssam_tablet_sw *sw = container_of(nf, struct ssam_tablet_sw, notif);
+
+	if (event->command_id != SSAM_EVENT_KIP_CID_COVER_STATE_CHANGED)
+		return 0;	/* Return "unhandled". */
+
+	if (event->length < 1)
+		dev_warn(&sw->sdev->dev, "unexpected payload size: %u\n", event->length);
+
+	schedule_work(&sw->update_work);
+	return SSAM_NOTIF_HANDLED;
+}
+
+static const struct ssam_tablet_sw_desc ssam_kip_sw_desc = {
+	.dev = {
+		.name = "Microsoft Surface KIP Tablet Mode Switch",
+		.phys = "ssam/01:0e:01:00:01/input0",
+	},
+	.ops = {
+		.notify = ssam_kip_sw_notif,
+		.get_state = ssam_kip_get_cover_state,
+		.state_name = ssam_kip_cover_state_name,
+		.state_is_tablet_mode = ssam_kip_cover_state_is_tablet_mode,
+	},
+	.event = {
+		.reg = SSAM_EVENT_REGISTRY_SAM,
+		.id = {
+			.target_category = SSAM_SSH_TC_KIP,
+			.instance = 0,
+		},
+		.mask = SSAM_EVENT_MASK_TARGET,
+	},
+};
+
+
+/* -- SSAM POS tablet switch implementation. -------------------------------- */
+
+static bool tablet_mode_in_slate_state = true;
+module_param(tablet_mode_in_slate_state, bool, 0644);
+MODULE_PARM_DESC(tablet_mode_in_slate_state, "Enable tablet mode in slate device posture, default is 'true'");
+
+#define SSAM_EVENT_POS_CID_POSTURE_CHANGED	0x03
+#define SSAM_POS_MAX_SOURCES			4
+
+enum ssam_pos_state {
+	SSAM_POS_POSTURE_LID_CLOSED = 0x00,
+	SSAM_POS_POSTURE_LAPTOP     = 0x01,
+	SSAM_POS_POSTURE_SLATE      = 0x02,
+	SSAM_POS_POSTURE_TABLET     = 0x03,
+};
+
+struct ssam_sources_list {
+	__le32 count;
+	__le32 id[SSAM_POS_MAX_SOURCES];
+} __packed;
+
+static const char *ssam_pos_state_name(struct ssam_tablet_sw *sw, u32 state)
+{
+	switch (state) {
+	case SSAM_POS_POSTURE_LID_CLOSED:
+		return "closed";
+
+	case SSAM_POS_POSTURE_LAPTOP:
+		return "laptop";
+
+	case SSAM_POS_POSTURE_SLATE:
+		return "slate";
+
+	case SSAM_POS_POSTURE_TABLET:
+		return "tablet";
+
+	default:
+		dev_warn(&sw->sdev->dev, "unknown device posture: %u\n", state);
+		return "<unknown>";
+	}
+}
+
+static bool ssam_pos_state_is_tablet_mode(struct ssam_tablet_sw *sw, u32 state)
+{
+	switch (state) {
+	case SSAM_POS_POSTURE_LAPTOP:
+	case SSAM_POS_POSTURE_LID_CLOSED:
+		return false;
+
+	case SSAM_POS_POSTURE_SLATE:
+		return tablet_mode_in_slate_state;
+
+	case SSAM_POS_POSTURE_TABLET:
+		return true;
+
+	default:
+		dev_warn(&sw->sdev->dev, "unknown device posture: %u\n", state);
+		return true;
+	}
+}
+
+static int ssam_pos_get_sources_list(struct ssam_tablet_sw *sw, struct ssam_sources_list *sources)
+{
+	struct ssam_request rqst;
+	struct ssam_response rsp;
+	int status;
+
+	rqst.target_category = SSAM_SSH_TC_POS;
+	rqst.target_id = 0x01;
+	rqst.command_id = 0x01;
+	rqst.instance_id = 0x00;
+	rqst.flags = SSAM_REQUEST_HAS_RESPONSE;
+	rqst.length = 0;
+	rqst.payload = NULL;
+
+	rsp.capacity = sizeof(*sources);
+	rsp.length = 0;
+	rsp.pointer = (u8 *)sources;
+
+	status = ssam_retry(ssam_request_sync_onstack, sw->sdev->ctrl, &rqst, &rsp, 0);
+	if (status)
+		return status;
+
+	/* We need at least the 'sources->count' field. */
+	if (rsp.length < sizeof(__le32)) {
+		dev_err(&sw->sdev->dev, "received source list response is too small\n");
+		return -EPROTO;
+	}
+
+	/* Make sure 'sources->count' matches with the response length. */
+	if (get_unaligned_le32(&sources->count) * sizeof(__le32) + sizeof(__le32) != rsp.length) {
+		dev_err(&sw->sdev->dev, "mismatch between number of sources and response size\n");
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+static int ssam_pos_get_source(struct ssam_tablet_sw *sw, u32 *source_id)
+{
+	struct ssam_sources_list sources = {};
+	int status;
+
+	status = ssam_pos_get_sources_list(sw, &sources);
+	if (status)
+		return status;
+
+	if (sources.count == 0) {
+		dev_err(&sw->sdev->dev, "no posture sources found\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * We currently don't know what to do with more than one posture
+	 * source. At the moment, only one source seems to be used/provided.
+	 * The WARN_ON() here should hopefully let us know quickly once there
+	 * is a device that provides multiple sources, at which point we can
+	 * then try to figure out how to handle them.
+	 */
+	WARN_ON(sources.count > 1);
+
+	*source_id = get_unaligned_le32(&sources.id[0]);
+	return 0;
+}
+
+SSAM_DEFINE_SYNC_REQUEST_WR(__ssam_pos_get_posture_for_source, __le32, __le32, {
+	.target_category = SSAM_SSH_TC_POS,
+	.target_id       = 0x01,
+	.command_id      = 0x02,
+	.instance_id     = 0x00,
+});
+
+static int ssam_pos_get_posture_for_source(struct ssam_tablet_sw *sw, u32 source_id, u32 *posture)
+{
+	__le32 source_le = cpu_to_le32(source_id);
+	__le32 rspval_le = 0;
+	int status;
+
+	status = ssam_retry(__ssam_pos_get_posture_for_source, sw->sdev->ctrl,
+			    &source_le, &rspval_le);
+	if (status)
+		return status;
+
+	*posture = le32_to_cpu(rspval_le);
+	return 0;
+}
+
+static int ssam_pos_get_posture(struct ssam_tablet_sw *sw, u32 *state)
+{
+	u32 source_id;
+	int status;
+
+	status = ssam_pos_get_source(sw, &source_id);
+	if (status) {
+		dev_err(&sw->sdev->dev, "failed to get posture source ID: %d\n", status);
+		return status;
+	}
+
+	status = ssam_pos_get_posture_for_source(sw, source_id, state);
+	if (status) {
+		dev_err(&sw->sdev->dev, "failed to get posture value for source %u: %d\n",
+			source_id, status);
+		return status;
+	}
+
+	return 0;
+}
+
+static u32 ssam_pos_sw_notif(struct ssam_event_notifier *nf, const struct ssam_event *event)
+{
+	struct ssam_tablet_sw *sw = container_of(nf, struct ssam_tablet_sw, notif);
+
+	if (event->command_id != SSAM_EVENT_POS_CID_POSTURE_CHANGED)
+		return 0;	/* Return "unhandled". */
+
+	if (event->length != sizeof(__le32) * 3)
+		dev_warn(&sw->sdev->dev, "unexpected payload size: %u\n", event->length);
+
+	schedule_work(&sw->update_work);
+	return SSAM_NOTIF_HANDLED;
+}
+
+static const struct ssam_tablet_sw_desc ssam_pos_sw_desc = {
+	.dev = {
+		.name = "Microsoft Surface POS Tablet Mode Switch",
+		.phys = "ssam/01:26:01:00:01/input0",
+	},
+	.ops = {
+		.notify = ssam_pos_sw_notif,
+		.get_state = ssam_pos_get_posture,
+		.state_name = ssam_pos_state_name,
+		.state_is_tablet_mode = ssam_pos_state_is_tablet_mode,
+	},
+	.event = {
+		.reg = SSAM_EVENT_REGISTRY_SAM,
+		.id = {
+			.target_category = SSAM_SSH_TC_POS,
+			.instance = 0,
+		},
+		.mask = SSAM_EVENT_MASK_TARGET,
+	},
+};
+
+
+/* -- Driver registration. -------------------------------------------------- */
+
+static const struct ssam_device_id ssam_tablet_sw_match[] = {
+	{ SSAM_SDEV(KIP, 0x01, 0x00, 0x01), (unsigned long)&ssam_kip_sw_desc },
+	{ SSAM_SDEV(POS, 0x01, 0x00, 0x01), (unsigned long)&ssam_pos_sw_desc },
+	{ },
+};
+MODULE_DEVICE_TABLE(ssam, ssam_tablet_sw_match);
+
+static struct ssam_device_driver ssam_tablet_sw_driver = {
+	.probe = ssam_tablet_sw_probe,
+	.remove = ssam_tablet_sw_remove,
+	.match_table = ssam_tablet_sw_match,
+	.driver = {
+		.name = "surface_aggregator_tablet_mode_switch",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.pm = &ssam_tablet_sw_pm_ops,
+	},
+};
+module_ssam_device_driver(ssam_tablet_sw_driver);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Tablet mode switch driver for Surface devices using the Surface Aggregator Module");
+MODULE_LICENSE("GPL");
-- 
2.36.1

