Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE00755A328
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiFXU6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiFXU6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:58:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539BA140E0;
        Fri, 24 Jun 2022 13:58:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ge10so7048852ejb.7;
        Fri, 24 Jun 2022 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KlmYESC1GYwiANC6qkNCDR7hyyL4Q3l0PLEvJy76jl0=;
        b=H19dezghDTdCOu0foEedOGAIYmenDl2M/Uk9xqWbEDcBKSnqRM3ghTa5L3zcvmOvOn
         7oZIHgsonpexHhqQ2ru25SASiA9XwAcab+Ee7mxR8UGiwCh2gu6Yxo6U4a01jc2lXMEA
         iKj4zWMnRABlCNbcd+siZgxk1xNv28dBA3NSydBY2MvQm+x4+nf5UbmCXuis8OprkgNs
         dcvVx73/UlnLrPX4qUjDTT9JOTCr1wD2ZP7lZdwZXq6gXNqN5MZIfdwJZbHPW1JuwJCU
         zV3L/NLMGm8KtIE0syUDJ19P3otgXh8ZafUMzZB7P9U2lKIRjvWH6QBSs7f16QoD+mly
         BVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlmYESC1GYwiANC6qkNCDR7hyyL4Q3l0PLEvJy76jl0=;
        b=GdUrINtAV70tpziO8UIotGmBvf2anwgWJkEfrpPHqSE5oJVafSBlSsB32KDotSqjy5
         RLEqUWy6rYFaSwtq9+lC9Cj1193vXF8HDrnKpLcX0dIARO7LXUePQ47GEm089lrk3g8r
         Q76ZKrQIJafD56Ef96G/cYDV059vGq6O9QM+Qr39dj2QdUn04/Y2QRjV8Ji8K3iwHyCu
         6eK/xBGZoF/co/5FBQeHp4kZGsmE/3Wn9/pe3codYDgnPsVEVz0ixqVfwm8IfD/seHa/
         v+pNe27r/hzpg8hxQwiUYpBOshi7sA3jp629wXaDTFL731XRAFFRJYQBx49Hh2P8lPff
         uNig==
X-Gm-Message-State: AJIora9+QEUSHWNDymv/fV/70Sjl48USJZUP6UOyquSjy8Pi59oyyNNB
        8SKE7Ze5GB4Srf4Qi9lzGrHIFiirI7c=
X-Google-Smtp-Source: AGRyM1sUObgB5XFZ7WmqyXVMKb4vgw50HujmkvIRBbBR2oEmg40hTyaDcRswIrN8s5P5Hhr4u/wCmw==
X-Received: by 2002:a17:907:160c:b0:711:3b56:dc7 with SMTP id hb12-20020a170907160c00b007113b560dc7mr857607ejc.587.1656104290512;
        Fri, 24 Jun 2022 13:58:10 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709061e4500b006feb6dee4absm1672666ejj.137.2022.06.24.13.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 13:58:10 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 2/3] platform/surface: aggregator: Move subsystem hub drivers to their own module
Date:   Fri, 24 Jun 2022 22:57:59 +0200
Message-Id: <20220624205800.1355621-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624205800.1355621-1-luzmaximilian@gmail.com>
References: <20220624205800.1355621-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out subsystem device hub drivers into their own module. This
allows us to load the hub drivers separately from the registry, which
will help future DT/OF support.

While doing so, also remove a small bit of code duplication.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 MAINTAINERS                                   |   6 +
 drivers/platform/surface/Kconfig              |  35 +-
 drivers/platform/surface/Makefile             |   1 +
 .../platform/surface/surface_aggregator_hub.c | 371 ++++++++++++++++++
 .../surface/surface_aggregator_registry.c     | 371 +-----------------
 5 files changed, 410 insertions(+), 374 deletions(-)
 create mode 100644 drivers/platform/surface/surface_aggregator_hub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c6d8c0c6bf6e..e01478062c56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13253,6 +13253,12 @@ F:	include/linux/surface_acpi_notify.h
 F:	include/linux/surface_aggregator/
 F:	include/uapi/linux/surface_aggregator/
 
+MICROSOFT SURFACE SYSTEM AGGREGATOR HUB DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/surface/surface_aggregator_hub.c
+
 MICROTEK X6 SCANNER
 M:	Oliver Neukum <oliver@neukum.org>
 S:	Maintained
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index b152e930cc84..b629e82af97c 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -72,18 +72,45 @@ config SURFACE_AGGREGATOR_CDEV
 	  The provided interface is intended for debugging and development only,
 	  and should not be used otherwise.
 
+config SURFACE_AGGREGATOR_HUB
+	tristate "Surface System Aggregator Module Subsystem Device Hubs"
+	depends on SURFACE_AGGREGATOR
+	depends on SURFACE_AGGREGATOR_BUS
+	help
+	  Device-hub drivers for Surface System Aggregator Module (SSAM) subsystem
+	  devices.
+
+	  Provides subsystem hub drivers which manage client devices on various
+	  SSAM subsystems. In some subsystems, notably the BAS subsystem managing
+	  devices contained in the base of the Surface Book 3 and the KIP subsystem
+	  managing type-cover devices in the Surface Pro 8 and Surface Pro X,
+	  devices can be (hot-)removed. Hub devices and drivers are required to
+	  manage these subdevices.
+
+	  Devices managed via these hubs are:
+	  - Battery/AC devices (Surface Book 3).
+	  - HID input devices (7th-generation and later models with detachable
+	    input devices).
+
+	  Select M (recommended) or Y here if you want support for the above
+	  mentioned devices on the corresponding Surface models. Without this
+	  module, the respective devices mentioned above will not be instantiated
+	  and thus any functionality provided by them will be missing, even when
+	  drivers for these devices are present. This module only provides the
+	  respective subsystem hubs. Both drivers and device specification (e.g.
+	  via the Surface Aggregator Registry) for these devices still need to be
+	  selected via other options.
+
 config SURFACE_AGGREGATOR_REGISTRY
 	tristate "Surface System Aggregator Module Device Registry"
 	depends on SURFACE_AGGREGATOR
 	depends on SURFACE_AGGREGATOR_BUS
 	help
-	  Device-registry and device-hubs for Surface System Aggregator Module
-	  (SSAM) devices.
+	  Device-registry for Surface System Aggregator Module (SSAM) devices.
 
 	  Provides a module and driver which act as a device-registry for SSAM
 	  client devices that cannot be detected automatically, e.g. via ACPI.
-	  Such devices are instead provided via this registry and attached via
-	  device hubs, also provided in this module.
+	  Such devices are instead provided and managed via this registry.
 
 	  Devices provided via this registry are:
 	  - Platform profile (performance-/cooling-mode) device (5th- and later
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 18b27898543e..53344330939b 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
 obj-$(CONFIG_SURFACE_ACPI_NOTIFY)	+= surface_acpi_notify.o
 obj-$(CONFIG_SURFACE_AGGREGATOR)	+= aggregator/
 obj-$(CONFIG_SURFACE_AGGREGATOR_CDEV)	+= surface_aggregator_cdev.o
+obj-$(CONFIG_SURFACE_AGGREGATOR_HUB)	+= surface_aggregator_hub.o
 obj-$(CONFIG_SURFACE_AGGREGATOR_REGISTRY) += surface_aggregator_registry.o
 obj-$(CONFIG_SURFACE_AGGREGATOR_TABLET_SWITCH) += surface_aggregator_tabletsw.o
 obj-$(CONFIG_SURFACE_DTX)		+= surface_dtx.o
diff --git a/drivers/platform/surface/surface_aggregator_hub.c b/drivers/platform/surface/surface_aggregator_hub.c
new file mode 100644
index 000000000000..43061514be38
--- /dev/null
+++ b/drivers/platform/surface/surface_aggregator_hub.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Surface System Aggregator Module (SSAM) subsystem device hubs.
+ *
+ * Provides a driver for SSAM subsystems device hubs. This driver performs
+ * instantiation of the devices managed by said hubs and takes care of
+ * (hot-)removal.
+ *
+ * Copyright (C) 2020-2022 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <linux/surface_aggregator/device.h>
+
+
+/* -- SSAM generic subsystem hub driver framework. -------------------------- */
+
+enum ssam_hub_state {
+	SSAM_HUB_UNINITIALIZED,		/* Only set during initialization. */
+	SSAM_HUB_CONNECTED,
+	SSAM_HUB_DISCONNECTED,
+};
+
+enum ssam_hub_flags {
+	SSAM_HUB_HOT_REMOVED,
+};
+
+struct ssam_hub;
+
+struct ssam_hub_ops {
+	int (*get_state)(struct ssam_hub *hub, enum ssam_hub_state *state);
+};
+
+struct ssam_hub {
+	struct ssam_device *sdev;
+
+	enum ssam_hub_state state;
+	unsigned long flags;
+
+	struct delayed_work update_work;
+	unsigned long connect_delay;
+
+	struct ssam_event_notifier notif;
+	struct ssam_hub_ops ops;
+};
+
+struct ssam_hub_desc {
+	struct {
+		struct ssam_event_registry reg;
+		struct ssam_event_id id;
+		enum ssam_event_mask mask;
+	} event;
+
+	struct {
+		u32 (*notify)(struct ssam_event_notifier *nf, const struct ssam_event *event);
+		int (*get_state)(struct ssam_hub *hub, enum ssam_hub_state *state);
+	} ops;
+
+	unsigned long connect_delay_ms;
+};
+
+static void ssam_hub_update_workfn(struct work_struct *work)
+{
+	struct ssam_hub *hub = container_of(work, struct ssam_hub, update_work.work);
+	enum ssam_hub_state state;
+	int status = 0;
+
+	status = hub->ops.get_state(hub, &state);
+	if (status)
+		return;
+
+	/*
+	 * There is a small possibility that hub devices were hot-removed and
+	 * re-added before we were able to remove them here. In that case, both
+	 * the state returned by get_state() and the state of the hub will
+	 * equal SSAM_HUB_CONNECTED and we would bail early below, which would
+	 * leave child devices without proper (re-)initialization and the
+	 * hot-remove flag set.
+	 *
+	 * Therefore, we check whether devices have been hot-removed via an
+	 * additional flag on the hub and, in this case, override the returned
+	 * hub state. In case of a missed disconnect (i.e. get_state returned
+	 * "connected"), we further need to re-schedule this work (with the
+	 * appropriate delay) as the actual connect work submission might have
+	 * been merged with this one.
+	 *
+	 * This then leads to one of two cases: Either we submit an unnecessary
+	 * work item (which will get ignored via either the queue or the state
+	 * checks) or, in the unlikely case that the work is actually required,
+	 * double the normal connect delay.
+	 */
+	if (test_and_clear_bit(SSAM_HUB_HOT_REMOVED, &hub->flags)) {
+		if (state == SSAM_HUB_CONNECTED)
+			schedule_delayed_work(&hub->update_work, hub->connect_delay);
+
+		state = SSAM_HUB_DISCONNECTED;
+	}
+
+	if (hub->state == state)
+		return;
+	hub->state = state;
+
+	if (hub->state == SSAM_HUB_CONNECTED)
+		status = ssam_device_register_clients(hub->sdev);
+	else
+		ssam_remove_clients(&hub->sdev->dev);
+
+	if (status)
+		dev_err(&hub->sdev->dev, "failed to update hub child devices: %d\n", status);
+}
+
+static int ssam_hub_mark_hot_removed(struct device *dev, void *_data)
+{
+	struct ssam_device *sdev = to_ssam_device(dev);
+
+	if (is_ssam_device(dev))
+		ssam_device_mark_hot_removed(sdev);
+
+	return 0;
+}
+
+static void ssam_hub_update(struct ssam_hub *hub, bool connected)
+{
+	unsigned long delay;
+
+	/* Mark devices as hot-removed before we remove any. */
+	if (!connected) {
+		set_bit(SSAM_HUB_HOT_REMOVED, &hub->flags);
+		device_for_each_child_reverse(&hub->sdev->dev, NULL, ssam_hub_mark_hot_removed);
+	}
+
+	/*
+	 * Delay update when the base/keyboard cover is being connected to give
+	 * devices/EC some time to set up.
+	 */
+	delay = connected ? hub->connect_delay : 0;
+
+	schedule_delayed_work(&hub->update_work, delay);
+}
+
+static int __maybe_unused ssam_hub_resume(struct device *dev)
+{
+	struct ssam_hub *hub = dev_get_drvdata(dev);
+
+	schedule_delayed_work(&hub->update_work, 0);
+	return 0;
+}
+static SIMPLE_DEV_PM_OPS(ssam_hub_pm_ops, NULL, ssam_hub_resume);
+
+static int ssam_hub_probe(struct ssam_device *sdev)
+{
+	const struct ssam_hub_desc *desc;
+	struct ssam_hub *hub;
+	int status;
+
+	desc = ssam_device_get_match_data(sdev);
+	if (!desc) {
+		WARN(1, "no driver match data specified");
+		return -EINVAL;
+	}
+
+	hub = devm_kzalloc(&sdev->dev, sizeof(*hub), GFP_KERNEL);
+	if (!hub)
+		return -ENOMEM;
+
+	hub->sdev = sdev;
+	hub->state = SSAM_HUB_UNINITIALIZED;
+
+	hub->notif.base.priority = INT_MAX;  /* This notifier should run first. */
+	hub->notif.base.fn = desc->ops.notify;
+	hub->notif.event.reg = desc->event.reg;
+	hub->notif.event.id = desc->event.id;
+	hub->notif.event.mask = desc->event.mask;
+	hub->notif.event.flags = SSAM_EVENT_SEQUENCED;
+
+	hub->connect_delay = msecs_to_jiffies(desc->connect_delay_ms);
+	hub->ops.get_state = desc->ops.get_state;
+
+	INIT_DELAYED_WORK(&hub->update_work, ssam_hub_update_workfn);
+
+	ssam_device_set_drvdata(sdev, hub);
+
+	status = ssam_device_notifier_register(sdev, &hub->notif);
+	if (status)
+		return status;
+
+	schedule_delayed_work(&hub->update_work, 0);
+	return 0;
+}
+
+static void ssam_hub_remove(struct ssam_device *sdev)
+{
+	struct ssam_hub *hub = ssam_device_get_drvdata(sdev);
+
+	ssam_device_notifier_unregister(sdev, &hub->notif);
+	cancel_delayed_work_sync(&hub->update_work);
+	ssam_remove_clients(&sdev->dev);
+}
+
+
+/* -- SSAM base-subsystem hub driver. --------------------------------------- */
+
+/*
+ * Some devices (especially battery) may need a bit of time to be fully usable
+ * after being (re-)connected. This delay has been determined via
+ * experimentation.
+ */
+#define SSAM_BASE_UPDATE_CONNECT_DELAY		2500
+
+SSAM_DEFINE_SYNC_REQUEST_R(ssam_bas_query_opmode, u8, {
+	.target_category = SSAM_SSH_TC_BAS,
+	.target_id       = 0x01,
+	.command_id      = 0x0d,
+	.instance_id     = 0x00,
+});
+
+#define SSAM_BAS_OPMODE_TABLET		0x00
+#define SSAM_EVENT_BAS_CID_CONNECTION	0x0c
+
+static int ssam_base_hub_query_state(struct ssam_hub *hub, enum ssam_hub_state *state)
+{
+	u8 opmode;
+	int status;
+
+	status = ssam_retry(ssam_bas_query_opmode, hub->sdev->ctrl, &opmode);
+	if (status < 0) {
+		dev_err(&hub->sdev->dev, "failed to query base state: %d\n", status);
+		return status;
+	}
+
+	if (opmode != SSAM_BAS_OPMODE_TABLET)
+		*state = SSAM_HUB_CONNECTED;
+	else
+		*state = SSAM_HUB_DISCONNECTED;
+
+	return 0;
+}
+
+static u32 ssam_base_hub_notif(struct ssam_event_notifier *nf, const struct ssam_event *event)
+{
+	struct ssam_hub *hub = container_of(nf, struct ssam_hub, notif);
+
+	if (event->command_id != SSAM_EVENT_BAS_CID_CONNECTION)
+		return 0;
+
+	if (event->length < 1) {
+		dev_err(&hub->sdev->dev, "unexpected payload size: %u\n", event->length);
+		return 0;
+	}
+
+	ssam_hub_update(hub, event->data[0]);
+
+	/*
+	 * Do not return SSAM_NOTIF_HANDLED: The event should be picked up and
+	 * consumed by the detachment system driver. We're just a (more or less)
+	 * silent observer.
+	 */
+	return 0;
+}
+
+static const struct ssam_hub_desc base_hub = {
+	.event = {
+		.reg = SSAM_EVENT_REGISTRY_SAM,
+		.id = {
+			.target_category = SSAM_SSH_TC_BAS,
+			.instance = 0,
+		},
+		.mask = SSAM_EVENT_MASK_NONE,
+	},
+	.ops = {
+		.notify = ssam_base_hub_notif,
+		.get_state = ssam_base_hub_query_state,
+	},
+	.connect_delay_ms = SSAM_BASE_UPDATE_CONNECT_DELAY,
+};
+
+
+/* -- SSAM KIP-subsystem hub driver. ---------------------------------------- */
+
+/*
+ * Some devices may need a bit of time to be fully usable after being
+ * (re-)connected. This delay has been determined via experimentation.
+ */
+#define SSAM_KIP_UPDATE_CONNECT_DELAY		250
+
+#define SSAM_EVENT_KIP_CID_CONNECTION		0x2c
+
+SSAM_DEFINE_SYNC_REQUEST_R(__ssam_kip_query_state, u8, {
+	.target_category = SSAM_SSH_TC_KIP,
+	.target_id       = 0x01,
+	.command_id      = 0x2c,
+	.instance_id     = 0x00,
+});
+
+static int ssam_kip_hub_query_state(struct ssam_hub *hub, enum ssam_hub_state *state)
+{
+	int status;
+	u8 connected;
+
+	status = ssam_retry(__ssam_kip_query_state, hub->sdev->ctrl, &connected);
+	if (status < 0) {
+		dev_err(&hub->sdev->dev, "failed to query KIP connection state: %d\n", status);
+		return status;
+	}
+
+	*state = connected ? SSAM_HUB_CONNECTED : SSAM_HUB_DISCONNECTED;
+	return 0;
+}
+
+static u32 ssam_kip_hub_notif(struct ssam_event_notifier *nf, const struct ssam_event *event)
+{
+	struct ssam_hub *hub = container_of(nf, struct ssam_hub, notif);
+
+	if (event->command_id != SSAM_EVENT_KIP_CID_CONNECTION)
+		return 0;	/* Return "unhandled". */
+
+	if (event->length < 1) {
+		dev_err(&hub->sdev->dev, "unexpected payload size: %u\n", event->length);
+		return 0;
+	}
+
+	ssam_hub_update(hub, event->data[0]);
+	return SSAM_NOTIF_HANDLED;
+}
+
+static const struct ssam_hub_desc kip_hub = {
+	.event = {
+		.reg = SSAM_EVENT_REGISTRY_SAM,
+		.id = {
+			.target_category = SSAM_SSH_TC_KIP,
+			.instance = 0,
+		},
+		.mask = SSAM_EVENT_MASK_TARGET,
+	},
+	.ops = {
+		.notify = ssam_kip_hub_notif,
+		.get_state = ssam_kip_hub_query_state,
+	},
+	.connect_delay_ms = SSAM_KIP_UPDATE_CONNECT_DELAY,
+};
+
+
+/* -- Driver registration. -------------------------------------------------- */
+
+static const struct ssam_device_id ssam_hub_match[] = {
+	{ SSAM_VDEV(HUB, 0x01, SSAM_SSH_TC_KIP, 0x00), (unsigned long)&kip_hub  },
+	{ SSAM_VDEV(HUB, 0x02, SSAM_SSH_TC_BAS, 0x00), (unsigned long)&base_hub },
+	{ }
+};
+MODULE_DEVICE_TABLE(ssam, ssam_hub_match);
+
+static struct ssam_device_driver ssam_subsystem_hub_driver = {
+	.probe = ssam_hub_probe,
+	.remove = ssam_hub_remove,
+	.match_table = ssam_hub_match,
+	.driver = {
+		.name = "surface_aggregator_subsystem_hub",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.pm = &ssam_hub_pm_ops,
+	},
+};
+module_ssam_device_driver(ssam_subsystem_hub_driver);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Subsystem device hub driver for Surface System Aggregator Module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index c680792a037e..0cbb7f3a6b2d 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -11,14 +11,11 @@
 
 #include <linux/acpi.h>
 #include <linux/kernel.h>
-#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
 
-#include <linux/surface_aggregator/controller.h>
 #include <linux/surface_aggregator/device.h>
 
 
@@ -286,335 +283,6 @@ static const struct software_node *ssam_node_group_sp8[] = {
 };
 
 
-/* -- SSAM generic subsystem hub driver framework. -------------------------- */
-
-enum ssam_hub_state {
-	SSAM_HUB_UNINITIALIZED,		/* Only set during initialization. */
-	SSAM_HUB_CONNECTED,
-	SSAM_HUB_DISCONNECTED,
-};
-
-enum ssam_hub_flags {
-	SSAM_HUB_HOT_REMOVED,
-};
-
-struct ssam_hub {
-	struct ssam_device *sdev;
-
-	enum ssam_hub_state state;
-	unsigned long flags;
-
-	struct delayed_work update_work;
-	unsigned long connect_delay;
-
-	struct ssam_event_notifier notif;
-
-	int (*get_state)(struct ssam_hub *hub, enum ssam_hub_state *state);
-};
-
-static void ssam_hub_update_workfn(struct work_struct *work)
-{
-	struct ssam_hub *hub = container_of(work, struct ssam_hub, update_work.work);
-	enum ssam_hub_state state;
-	int status = 0;
-
-	status = hub->get_state(hub, &state);
-	if (status)
-		return;
-
-	/*
-	 * There is a small possibility that hub devices were hot-removed and
-	 * re-added before we were able to remove them here. In that case, both
-	 * the state returned by get_state() and the state of the hub will
-	 * equal SSAM_HUB_CONNECTED and we would bail early below, which would
-	 * leave child devices without proper (re-)initialization and the
-	 * hot-remove flag set.
-	 *
-	 * Therefore, we check whether devices have been hot-removed via an
-	 * additional flag on the hub and, in this case, override the returned
-	 * hub state. In case of a missed disconnect (i.e. get_state returned
-	 * "connected"), we further need to re-schedule this work (with the
-	 * appropriate delay) as the actual connect work submission might have
-	 * been merged with this one.
-	 *
-	 * This then leads to one of two cases: Either we submit an unnecessary
-	 * work item (which will get ignored via either the queue or the state
-	 * checks) or, in the unlikely case that the work is actually required,
-	 * double the normal connect delay.
-	 */
-	if (test_and_clear_bit(SSAM_HUB_HOT_REMOVED, &hub->flags)) {
-		if (state == SSAM_HUB_CONNECTED)
-			schedule_delayed_work(&hub->update_work, hub->connect_delay);
-
-		state = SSAM_HUB_DISCONNECTED;
-	}
-
-	if (hub->state == state)
-		return;
-	hub->state = state;
-
-	if (hub->state == SSAM_HUB_CONNECTED)
-		status = ssam_device_register_clients(hub->sdev);
-	else
-		ssam_remove_clients(&hub->sdev->dev);
-
-	if (status)
-		dev_err(&hub->sdev->dev, "failed to update hub child devices: %d\n", status);
-}
-
-static int ssam_hub_mark_hot_removed(struct device *dev, void *_data)
-{
-	struct ssam_device *sdev = to_ssam_device(dev);
-
-	if (is_ssam_device(dev))
-		ssam_device_mark_hot_removed(sdev);
-
-	return 0;
-}
-
-static void ssam_hub_update(struct ssam_hub *hub, bool connected)
-{
-	unsigned long delay;
-
-	/* Mark devices as hot-removed before we remove any. */
-	if (!connected) {
-		set_bit(SSAM_HUB_HOT_REMOVED, &hub->flags);
-		device_for_each_child_reverse(&hub->sdev->dev, NULL, ssam_hub_mark_hot_removed);
-	}
-
-	/*
-	 * Delay update when the base/keyboard cover is being connected to give
-	 * devices/EC some time to set up.
-	 */
-	delay = connected ? hub->connect_delay : 0;
-
-	schedule_delayed_work(&hub->update_work, delay);
-}
-
-static int __maybe_unused ssam_hub_resume(struct device *dev)
-{
-	struct ssam_hub *hub = dev_get_drvdata(dev);
-
-	schedule_delayed_work(&hub->update_work, 0);
-	return 0;
-}
-static SIMPLE_DEV_PM_OPS(ssam_hub_pm_ops, NULL, ssam_hub_resume);
-
-static int ssam_hub_setup(struct ssam_device *sdev, struct ssam_hub *hub)
-{
-	int status;
-
-	hub->sdev = sdev;
-	hub->state = SSAM_HUB_UNINITIALIZED;
-
-	INIT_DELAYED_WORK(&hub->update_work, ssam_hub_update_workfn);
-
-	ssam_device_set_drvdata(sdev, hub);
-
-	status = ssam_device_notifier_register(sdev, &hub->notif);
-	if (status)
-		return status;
-
-	schedule_delayed_work(&hub->update_work, 0);
-	return 0;
-}
-
-static void ssam_hub_remove(struct ssam_device *sdev)
-{
-	struct ssam_hub *hub = ssam_device_get_drvdata(sdev);
-
-	ssam_device_notifier_unregister(sdev, &hub->notif);
-	cancel_delayed_work_sync(&hub->update_work);
-	ssam_remove_clients(&sdev->dev);
-}
-
-
-/* -- SSAM base-hub driver. ------------------------------------------------- */
-
-/*
- * Some devices (especially battery) may need a bit of time to be fully usable
- * after being (re-)connected. This delay has been determined via
- * experimentation.
- */
-#define SSAM_BASE_UPDATE_CONNECT_DELAY		msecs_to_jiffies(2500)
-
-SSAM_DEFINE_SYNC_REQUEST_R(ssam_bas_query_opmode, u8, {
-	.target_category = SSAM_SSH_TC_BAS,
-	.target_id       = 0x01,
-	.command_id      = 0x0d,
-	.instance_id     = 0x00,
-});
-
-#define SSAM_BAS_OPMODE_TABLET		0x00
-#define SSAM_EVENT_BAS_CID_CONNECTION	0x0c
-
-static int ssam_base_hub_query_state(struct ssam_hub *hub, enum ssam_hub_state *state)
-{
-	u8 opmode;
-	int status;
-
-	status = ssam_retry(ssam_bas_query_opmode, hub->sdev->ctrl, &opmode);
-	if (status < 0) {
-		dev_err(&hub->sdev->dev, "failed to query base state: %d\n", status);
-		return status;
-	}
-
-	if (opmode != SSAM_BAS_OPMODE_TABLET)
-		*state = SSAM_HUB_CONNECTED;
-	else
-		*state = SSAM_HUB_DISCONNECTED;
-
-	return 0;
-}
-
-static u32 ssam_base_hub_notif(struct ssam_event_notifier *nf, const struct ssam_event *event)
-{
-	struct ssam_hub *hub = container_of(nf, struct ssam_hub, notif);
-
-	if (event->command_id != SSAM_EVENT_BAS_CID_CONNECTION)
-		return 0;
-
-	if (event->length < 1) {
-		dev_err(&hub->sdev->dev, "unexpected payload size: %u\n", event->length);
-		return 0;
-	}
-
-	ssam_hub_update(hub, event->data[0]);
-
-	/*
-	 * Do not return SSAM_NOTIF_HANDLED: The event should be picked up and
-	 * consumed by the detachment system driver. We're just a (more or less)
-	 * silent observer.
-	 */
-	return 0;
-}
-
-static int ssam_base_hub_probe(struct ssam_device *sdev)
-{
-	struct ssam_hub *hub;
-
-	hub = devm_kzalloc(&sdev->dev, sizeof(*hub), GFP_KERNEL);
-	if (!hub)
-		return -ENOMEM;
-
-	hub->notif.base.priority = INT_MAX;  /* This notifier should run first. */
-	hub->notif.base.fn = ssam_base_hub_notif;
-	hub->notif.event.reg = SSAM_EVENT_REGISTRY_SAM;
-	hub->notif.event.id.target_category = SSAM_SSH_TC_BAS,
-	hub->notif.event.id.instance = 0,
-	hub->notif.event.mask = SSAM_EVENT_MASK_NONE;
-	hub->notif.event.flags = SSAM_EVENT_SEQUENCED;
-
-	hub->connect_delay = SSAM_BASE_UPDATE_CONNECT_DELAY;
-	hub->get_state = ssam_base_hub_query_state;
-
-	return ssam_hub_setup(sdev, hub);
-}
-
-static const struct ssam_device_id ssam_base_hub_match[] = {
-	{ SSAM_VDEV(HUB, 0x02, SSAM_SSH_TC_BAS, 0x00) },
-	{ },
-};
-
-static struct ssam_device_driver ssam_base_hub_driver = {
-	.probe = ssam_base_hub_probe,
-	.remove = ssam_hub_remove,
-	.match_table = ssam_base_hub_match,
-	.driver = {
-		.name = "surface_aggregator_base_hub",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm = &ssam_hub_pm_ops,
-	},
-};
-
-
-/* -- SSAM KIP-subsystem hub driver. ---------------------------------------- */
-
-/*
- * Some devices may need a bit of time to be fully usable after being
- * (re-)connected. This delay has been determined via experimentation.
- */
-#define SSAM_KIP_UPDATE_CONNECT_DELAY		msecs_to_jiffies(250)
-
-#define SSAM_EVENT_KIP_CID_CONNECTION		0x2c
-
-SSAM_DEFINE_SYNC_REQUEST_R(__ssam_kip_get_connection_state, u8, {
-	.target_category = SSAM_SSH_TC_KIP,
-	.target_id       = 0x01,
-	.command_id      = 0x2c,
-	.instance_id     = 0x00,
-});
-
-static int ssam_kip_get_connection_state(struct ssam_hub *hub, enum ssam_hub_state *state)
-{
-	int status;
-	u8 connected;
-
-	status = ssam_retry(__ssam_kip_get_connection_state, hub->sdev->ctrl, &connected);
-	if (status < 0) {
-		dev_err(&hub->sdev->dev, "failed to query KIP connection state: %d\n", status);
-		return status;
-	}
-
-	*state = connected ? SSAM_HUB_CONNECTED : SSAM_HUB_DISCONNECTED;
-	return 0;
-}
-
-static u32 ssam_kip_hub_notif(struct ssam_event_notifier *nf, const struct ssam_event *event)
-{
-	struct ssam_hub *hub = container_of(nf, struct ssam_hub, notif);
-
-	if (event->command_id != SSAM_EVENT_KIP_CID_CONNECTION)
-		return 0;	/* Return "unhandled". */
-
-	if (event->length < 1) {
-		dev_err(&hub->sdev->dev, "unexpected payload size: %u\n", event->length);
-		return 0;
-	}
-
-	ssam_hub_update(hub, event->data[0]);
-	return SSAM_NOTIF_HANDLED;
-}
-
-static int ssam_kip_hub_probe(struct ssam_device *sdev)
-{
-	struct ssam_hub *hub;
-
-	hub = devm_kzalloc(&sdev->dev, sizeof(*hub), GFP_KERNEL);
-	if (!hub)
-		return -ENOMEM;
-
-	hub->notif.base.priority = INT_MAX;  /* This notifier should run first. */
-	hub->notif.base.fn = ssam_kip_hub_notif;
-	hub->notif.event.reg = SSAM_EVENT_REGISTRY_SAM;
-	hub->notif.event.id.target_category = SSAM_SSH_TC_KIP,
-	hub->notif.event.id.instance = 0,
-	hub->notif.event.mask = SSAM_EVENT_MASK_TARGET;
-	hub->notif.event.flags = SSAM_EVENT_SEQUENCED;
-
-	hub->connect_delay = SSAM_KIP_UPDATE_CONNECT_DELAY;
-	hub->get_state = ssam_kip_get_connection_state;
-
-	return ssam_hub_setup(sdev, hub);
-}
-
-static const struct ssam_device_id ssam_kip_hub_match[] = {
-	{ SSAM_VDEV(HUB, 0x01, SSAM_SSH_TC_KIP, 0x00) },
-	{ },
-};
-
-static struct ssam_device_driver ssam_kip_hub_driver = {
-	.probe = ssam_kip_hub_probe,
-	.remove = ssam_hub_remove,
-	.match_table = ssam_kip_hub_match,
-	.driver = {
-		.name = "surface_kip_hub",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm = &ssam_hub_pm_ops,
-	},
-};
-
-
 /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
 
 static const struct acpi_device_id ssam_platform_hub_match[] = {
@@ -727,44 +395,7 @@ static struct platform_driver ssam_platform_hub_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
-
-
-/* -- Module initialization. ------------------------------------------------ */
-
-static int __init ssam_device_hub_init(void)
-{
-	int status;
-
-	status = platform_driver_register(&ssam_platform_hub_driver);
-	if (status)
-		goto err_platform;
-
-	status = ssam_device_driver_register(&ssam_base_hub_driver);
-	if (status)
-		goto err_base;
-
-	status = ssam_device_driver_register(&ssam_kip_hub_driver);
-	if (status)
-		goto err_kip;
-
-	return 0;
-
-err_kip:
-	ssam_device_driver_unregister(&ssam_base_hub_driver);
-err_base:
-	platform_driver_unregister(&ssam_platform_hub_driver);
-err_platform:
-	return status;
-}
-module_init(ssam_device_hub_init);
-
-static void __exit ssam_device_hub_exit(void)
-{
-	ssam_device_driver_unregister(&ssam_kip_hub_driver);
-	ssam_device_driver_unregister(&ssam_base_hub_driver);
-	platform_driver_unregister(&ssam_platform_hub_driver);
-}
-module_exit(ssam_device_hub_exit);
+module_platform_driver(ssam_platform_hub_driver);
 
 MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
 MODULE_DESCRIPTION("Device-registry for Surface System Aggregator Module");
-- 
2.36.1

