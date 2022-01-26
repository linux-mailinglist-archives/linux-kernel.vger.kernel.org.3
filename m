Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A280449D164
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbiAZSFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244077AbiAZSFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:05:23 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B07C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:05:23 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id e9so137262pgb.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHRzkjXAM0E1aJzJpuPlGE2P9DpNKrPAb41dqjf9ou0=;
        b=ALyW7muOssnQBwmbOiO1HjI0CFvrViQtngSRmU4hNa40Kpryb63lcQKjPrU+OVNaKJ
         EyA3G10btji+3Y3Jcl+LMXKxFfCFZ5fJ7LaxAbBmepcHwQTLcqSEJ5JHGJqYlzkCv4NF
         Cz6tB6q+IdZEmuqiIAho8XDZEzowucHZ9iaUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHRzkjXAM0E1aJzJpuPlGE2P9DpNKrPAb41dqjf9ou0=;
        b=R0iA2J9QyHuryVDevToyKS+337psfoLcB+2SsqWQtJZKC5QBZAw+gfDdHpt0w55J+O
         xt38XfrabkLsGVcSKQ/XNvbvyVQ2slvrXJ3U3LHXwu/qr8mnefonwBZrZokbEpmGn4bL
         CEEVodnCgNTao8lYKP4J0QwO3L9ynvNGu0IMyzhTQaMPl01lXa8CfMW5FXuW8rIgHUt6
         3GJTy1f/vryN9WAcJ/W4JbJNLHYKuCuUGcJyQTKV/EwKECdqbVo0e/JFAuFl5fLepzI3
         L6aZlz4iflWBkWlcR2ypWGnbIpD9RYrlsspwINPj/NgHbd3hdGIU5Ky2z6bnIto2eYRY
         7+Uw==
X-Gm-Message-State: AOAM530qMkqAtPROtUkUxSXG54WGCtvWB9COxtvRO7TLvH50OwzPduMq
        5qm22iFgeXeKKBvMCablhnRsW6l/wXvO2Q==
X-Google-Smtp-Source: ABdhPJxfagmQS57r4YpbOqH1dCugE2RtJd6HvM6jTC4LosWKDke2P0BRQ+3/xcSk5ppOQSIV0VrwQw==
X-Received: by 2002:a65:5943:: with SMTP id g3mr63355pgu.3.1643220322880;
        Wed, 26 Jan 2022 10:05:22 -0800 (PST)
Received: from pc98bx3.roam.corp.google.com (c-73-222-23-249.hsd1.ca.comcast.net. [73.222.23.249])
        by smtp.gmail.com with ESMTPSA id u10sm17211404pgl.68.2022.01.26.10.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:05:22 -0800 (PST)
From:   Daisuke Nojiri <dnojiri@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Prashant Malani <pmalani@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3] power: supply: PCHG: Use MKBP for device event handling
Date:   Wed, 26 Jan 2022 10:04:10 -0800
Message-Id: <20220126180413.2565825-1-dnojiri@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes the PCHG driver receive device events through
MKBP protocol since CrOS EC switched to deliver all peripheral
charge events to the MKBP protocol. This will unify PCHG event
handling on X86 and ARM.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
---
v1 -> v2
* Make the patch description concise.
* Change the order of if-conditions in cros_ec_notify.
v2 -> v3
* Style changes. No functional change is made.
* 'This patch' -> 'This change' in the patch description.
---
 .../power/supply/cros_peripheral_charger.c    | 37 ++---------
 .../linux/platform_data/cros_ec_commands.h    | 64 +++++++++++++++++++
 2 files changed, 71 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
index 305f10dfc06d1b..9fe6d826148db9 100644
--- a/drivers/power/supply/cros_peripheral_charger.c
+++ b/drivers/power/supply/cros_peripheral_charger.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/stringify.h>
 #include <linux/types.h>
+#include <asm/unaligned.h>
 
 #define DRV_NAME		"cros-ec-pchg"
 #define PCHG_DIR_PREFIX		"peripheral"
@@ -237,46 +238,22 @@ static int cros_pchg_event(const struct charger_data *charger,
 	return NOTIFY_OK;
 }
 
-static u32 cros_get_device_event(const struct charger_data *charger)
-{
-	struct ec_params_device_event req;
-	struct ec_response_device_event rsp;
-	struct device *dev = charger->dev;
-	int ret;
-
-	req.param = EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS;
-	ret = cros_pchg_ec_command(charger, 0, EC_CMD_DEVICE_EVENT,
-				   &req, sizeof(req), &rsp, sizeof(rsp));
-	if (ret < 0) {
-		dev_warn(dev, "Unable to get device events (err:%d)\n", ret);
-		return 0;
-	}
-
-	return rsp.event_mask;
-}
-
 static int cros_ec_notify(struct notifier_block *nb,
 			  unsigned long queued_during_suspend,
 			  void *data)
 {
-	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
-	u32 host_event = cros_ec_get_host_event(ec_dev);
+	struct cros_ec_device *ec_dev = data;
 	struct charger_data *charger =
 			container_of(nb, struct charger_data, notifier);
-	u32 device_event_mask;
+	u32 host_event;
 
-	if (!host_event)
+	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_PCHG ||
+			ec_dev->event_size != sizeof(host_event))
 		return NOTIFY_DONE;
 
-	if (!(host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_DEVICE)))
-		return NOTIFY_DONE;
+	host_event = get_unaligned_le32(&ec_dev->event_data.data.host_event);
 
-	/*
-	 * todo: Retrieve device event mask in common place
-	 * (e.g. cros_ec_proto.c).
-	 */
-	device_event_mask = cros_get_device_event(charger);
-	if (!(device_event_mask & EC_DEVICE_EVENT_MASK(EC_DEVICE_EVENT_WLC)))
+	if (!(host_event & EC_MKBP_PCHG_DEVICE_EVENT))
 		return NOTIFY_DONE;
 
 	return cros_pchg_event(charger, host_event);
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 271bd87bff0a25..95e7e5667291b7 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -3386,6 +3386,9 @@ enum ec_mkbp_event {
 	/* Send an incoming CEC message to the AP */
 	EC_MKBP_EVENT_CEC_MESSAGE = 9,
 
+	/* Peripheral device charger event */
+	EC_MKBP_EVENT_PCHG = 12,
+
 	/* Number of MKBP events */
 	EC_MKBP_EVENT_COUNT,
 };
@@ -5527,6 +5530,67 @@ enum pchg_state {
 	[PCHG_STATE_CONNECTED] = "CONNECTED", \
 	}
 
+/*
+ * Update firmware of peripheral chip
+ */
+#define EC_CMD_PCHG_UPDATE 0x0136
+
+/* Port number is encoded in bit[28:31]. */
+#define EC_MKBP_PCHG_PORT_SHIFT		28
+/* Utility macro for converting MKBP event to port number. */
+#define EC_MKBP_PCHG_EVENT_TO_PORT(e)	(((e) >> EC_MKBP_PCHG_PORT_SHIFT) & 0xf)
+/* Utility macro for extracting event bits. */
+#define EC_MKBP_PCHG_EVENT_MASK(e)	((e) \
+					& GENMASK(EC_MKBP_PCHG_PORT_SHIFT-1, 0))
+
+#define EC_MKBP_PCHG_UPDATE_OPENED	BIT(0)
+#define EC_MKBP_PCHG_WRITE_COMPLETE	BIT(1)
+#define EC_MKBP_PCHG_UPDATE_CLOSED	BIT(2)
+#define EC_MKBP_PCHG_UPDATE_ERROR	BIT(3)
+#define EC_MKBP_PCHG_DEVICE_EVENT	BIT(4)
+
+enum ec_pchg_update_cmd {
+	/* Reset chip to normal mode. */
+	EC_PCHG_UPDATE_CMD_RESET_TO_NORMAL = 0,
+	/* Reset and put a chip in update (a.k.a. download) mode. */
+	EC_PCHG_UPDATE_CMD_OPEN,
+	/* Write a block of data containing FW image. */
+	EC_PCHG_UPDATE_CMD_WRITE,
+	/* Close update session. */
+	EC_PCHG_UPDATE_CMD_CLOSE,
+	/* End of commands */
+	EC_PCHG_UPDATE_CMD_COUNT,
+};
+
+struct ec_params_pchg_update {
+	/* PCHG port number */
+	uint8_t port;
+	/* enum ec_pchg_update_cmd */
+	uint8_t cmd;
+	/* Padding */
+	uint8_t reserved0;
+	uint8_t reserved1;
+	/* Version of new firmware */
+	uint32_t version;
+	/* CRC32 of new firmware */
+	uint32_t crc32;
+	/* Address in chip memory where <data> is written to */
+	uint32_t addr;
+	/* Size of <data> */
+	uint32_t size;
+	/* Partial data of new firmware */
+	uint8_t data[];
+} __ec_align4;
+
+BUILD_ASSERT(EC_PCHG_UPDATE_CMD_COUNT
+	     < BIT(sizeof(((struct ec_params_pchg_update *)0)->cmd)*8));
+
+struct ec_response_pchg_update {
+	/* Block size */
+	uint32_t block_size;
+} __ec_align4;
+
+
 /*****************************************************************************/
 /* Voltage regulator controls */
 
-- 
2.31.0

