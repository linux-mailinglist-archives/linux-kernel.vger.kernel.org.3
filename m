Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0810552F303
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352784AbiETSf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352761AbiETSew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:34:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D551957A3;
        Fri, 20 May 2022 11:34:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h5so11478247wrb.11;
        Fri, 20 May 2022 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oki+jIYweACkaAIYUi6jFBCdXWeHbNGj/dYS/e1mfMU=;
        b=piNJmX8iNWk1JIGlCpm05y78/wh6XgCmstbJrh5bMXpRYaQWB21iHtZ+wbxHrc5Ws9
         eyMn9iFV1qcE/b4KEpiCHEq/u1P/xLHkQJ94jR1iB07W5Xf+Ec5elUI6dQi+NJmxVH4s
         kr/CO7fFqks0za3tWIq6spozNPZMK5M5EYJ4ESXfprKtejHGkEHJUfMXMruV9VW+ko9O
         B+p1CeGuYvtM1f6xuS2wcZSSyNIItN1+34dTW+5g64bDZEA4DLjp40DuRgpVUYblq8Ch
         n7xizPebX5RPQfqZIq/MarlmjTKf5v8hICa3Mqrn6mh+dj0cOrAWkIuqnj5ZzoHK/Z8Q
         4XfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oki+jIYweACkaAIYUi6jFBCdXWeHbNGj/dYS/e1mfMU=;
        b=oyQN6xBfBzV+GmJtX98Xlwm5fd4lTpRHtyfMv+JYyRg+DafTqj2Rg7WRDhJLAz71xS
         lsaR7xwFwKR9lmpd89BlDTEn0mnhaz6+iTBmAuL3R3QgxfixWNsZHb/Yj38gmzT8Q8Cf
         50doRxUV9DNwajqzrf48j/7RY80vL7k6tRYdS0ZZ7n7iE7EIw2hFZdLsUFc1LWHF3rMc
         OS9zCcP80hXaIHtbuYsHgBe9N1wAcxsiE1/pMbG37W3kB8ZigZiR9u1wXDsfPZ/ryDj+
         myblwg175HgAxIUNQMDS6YemErzNG38Wu02Nr7RMubneJOeRaXV44EjKFwC3cJNUbWJL
         CB4w==
X-Gm-Message-State: AOAM530yDbre89qrnj7Dl8+ik1Dw+6AgXjbdq4n47P4uKHTKhGG7vlG5
        +SMAN1z0DJK6o21JBI1pvro=
X-Google-Smtp-Source: ABdhPJzPfUjHxqGqTd8xsFLzBqhrJV7WTgRgGXwZ3BkmHZxBr713fZ+LKUOR5GegUD2S+Rrol2m9+g==
X-Received: by 2002:a05:6000:10d0:b0:20d:7d3:9972 with SMTP id b16-20020a05600010d000b0020d07d39972mr9423363wrx.554.1653071690233;
        Fri, 20 May 2022 11:34:50 -0700 (PDT)
Received: from xws.localdomain (pd9e5a9fe.dip0.t-ipconnect.de. [217.229.169.254])
        by smtp.gmail.com with ESMTPSA id r9-20020adfa149000000b0020e62feca05sm3252081wrr.32.2022.05.20.11.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:34:49 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] platform/surface: aggregator_registry: Add KIP device hub
Date:   Fri, 20 May 2022 20:34:21 +0200
Message-Id: <20220520183422.7185-10-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520183422.7185-1-luzmaximilian@gmail.com>
References: <20220520183422.7185-1-luzmaximilian@gmail.com>
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

Add a Surface System Aggregator Module (SSAM) client device hub for
hot-removable devices managed via the KIP subsystem.

The KIP subsystem (full name unknown, abbreviation has been obtained
through reverse engineering) is a subsystem that manages hot-removable
SSAM client devices. Specifically, it manages HID input devices
contained in the detachable keyboard cover of the Surface Pro 8 and
Surface Pro X.

The KIP subsystem handles a single group of devices (e.g. all devices
contained in the keyboard cover) and cannot handle devices individually.
Thus we model it as a client device hub, which (hot-)removes all devices
contained under it once removal of the hub (e.g. keyboard cover) has
been detected and (re-)adds all devices once the physical hub device has
been (re-)attached. To do this, use the previously generified SSAM
subsystem hub framework.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c     | 103 +++++++++++++++++-
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 09cbeee2428b..1e60435c7cce 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -551,6 +551,93 @@ static struct ssam_device_driver ssam_base_hub_driver = {
 };
 
 
+/* -- SSAM KIP-subsystem hub driver. ---------------------------------------- */
+
+/*
+ * Some devices may need a bit of time to be fully usable after being
+ * (re-)connected. This delay has been determined via experimentation.
+ */
+#define SSAM_KIP_UPDATE_CONNECT_DELAY		msecs_to_jiffies(250)
+
+#define SSAM_EVENT_KIP_CID_CONNECTION		0x2c
+
+SSAM_DEFINE_SYNC_REQUEST_R(__ssam_kip_get_connection_state, u8, {
+	.target_category = SSAM_SSH_TC_KIP,
+	.target_id       = 0x01,
+	.command_id      = 0x2c,
+	.instance_id     = 0x00,
+});
+
+static int ssam_kip_get_connection_state(struct ssam_hub *hub, enum ssam_hub_state *state)
+{
+	int status;
+	u8 connected;
+
+	status = ssam_retry(__ssam_kip_get_connection_state, hub->sdev->ctrl, &connected);
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
+static int ssam_kip_hub_probe(struct ssam_device *sdev)
+{
+	struct ssam_hub *hub;
+
+	hub = devm_kzalloc(&sdev->dev, sizeof(*hub), GFP_KERNEL);
+	if (!hub)
+		return -ENOMEM;
+
+	hub->notif.base.priority = INT_MAX;  /* This notifier should run first. */
+	hub->notif.base.fn = ssam_kip_hub_notif;
+	hub->notif.event.reg = SSAM_EVENT_REGISTRY_SAM;
+	hub->notif.event.id.target_category = SSAM_SSH_TC_KIP,
+	hub->notif.event.id.instance = 0,
+	hub->notif.event.mask = SSAM_EVENT_MASK_TARGET;
+	hub->notif.event.flags = SSAM_EVENT_SEQUENCED;
+
+	hub->connect_delay = SSAM_KIP_UPDATE_CONNECT_DELAY;
+	hub->get_state = ssam_kip_get_connection_state;
+
+	return ssam_hub_setup(sdev, hub);
+}
+
+static const struct ssam_device_id ssam_kip_hub_match[] = {
+	{ SSAM_SDEV(KIP, 0x01, 0x00, 0x00) },
+	{ },
+};
+
+static struct ssam_device_driver ssam_kip_hub_driver = {
+	.probe = ssam_kip_hub_probe,
+	.remove = ssam_hub_remove,
+	.match_table = ssam_kip_hub_match,
+	.driver = {
+		.name = "surface_kip_hub",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.pm = &ssam_hub_pm_ops,
+	},
+};
+
+
 /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
 
 static const struct acpi_device_id ssam_platform_hub_match[] = {
@@ -673,18 +760,30 @@ static int __init ssam_device_hub_init(void)
 
 	status = platform_driver_register(&ssam_platform_hub_driver);
 	if (status)
-		return status;
+		goto err_platform;
 
 	status = ssam_device_driver_register(&ssam_base_hub_driver);
 	if (status)
-		platform_driver_unregister(&ssam_platform_hub_driver);
+		goto err_base;
+
+	status = ssam_device_driver_register(&ssam_kip_hub_driver);
+	if (status)
+		goto err_kip;
 
+	return 0;
+
+err_kip:
+	ssam_device_driver_unregister(&ssam_base_hub_driver);
+err_base:
+	platform_driver_unregister(&ssam_platform_hub_driver);
+err_platform:
 	return status;
 }
 module_init(ssam_device_hub_init);
 
 static void __exit ssam_device_hub_exit(void)
 {
+	ssam_device_driver_unregister(&ssam_kip_hub_driver);
 	ssam_device_driver_unregister(&ssam_base_hub_driver);
 	platform_driver_unregister(&ssam_platform_hub_driver);
 }
-- 
2.36.1

