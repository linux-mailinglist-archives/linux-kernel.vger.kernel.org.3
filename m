Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5DE49754D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbiAWToS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbiAWToR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:44:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89B8C06173D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:44:16 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id t18so13562744plg.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VrIVhm/tT4bnZMey3UaZiv1Koz5mSPssAn+EHahI0dE=;
        b=cZ7dutwXPMlBBwtHlcdJ5ZQz2kEMjCXWHitAvDvB3S2zjudDD0vnlp3nVMArD9Y3iI
         ETcPxJ7VFMmugu9BNdCLHZwNnYurWkjx43dwkbclV8iC/bHT2I7ltiUHCcbdEJ/b6P0z
         KWpoBTCXZF8iZH296kb6RlphtOlqluV4oe1yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VrIVhm/tT4bnZMey3UaZiv1Koz5mSPssAn+EHahI0dE=;
        b=vrM5Mk/b0bdlbMDpDrZZ1SDstc4ff7t/29mZHmhFextO3kuKvih0eur3agAH5HVqZ9
         ArdWH/SqRLDyhW2hZpqrcdgtBpyJujkidHDfSGKzvUzsmunlpDXqW5DxNqw+y2nBVCuD
         I993t4ROoYnwJLdiN8YNHSMpJ55M31RIWqioJCNJFDP447KCHJG+7/UijQ4Qek9FNO5b
         glTbMWHjK4G0mV2Ve2oOfrQKbtOCB8EEW042HJdcHCDfIAqkvJkvc31QonHWvjSO2K2v
         1FGevRADdNjxPfMSvG81EcqHhd+dbtj9LVCcUxbraFz2nJdaHTvfd80E/FEWE4PTcbdk
         LLPA==
X-Gm-Message-State: AOAM5318z5Qg4S6Wa7dxeea/em+Gu88EwUu0uSQ5upZ+m6OMyQA9EIIl
        sU60sSlVoFFLk4Qn9h7N+bOPmRj+Xm0Tag==
X-Google-Smtp-Source: ABdhPJwyTVQyINWK3UfKRZvn6JFthrRDASFsah3VOZ1ni8WGxYO3lB4IbiUtOCMY21CCi+djRI+nPQ==
X-Received: by 2002:a17:902:ecc4:b0:14a:15a7:c3d3 with SMTP id a4-20020a170902ecc400b0014a15a7c3d3mr11803474plh.117.1642967056224;
        Sun, 23 Jan 2022 11:44:16 -0800 (PST)
Received: from pc98bx3.roam.corp.google.com (c-73-222-23-249.hsd1.ca.comcast.net. [73.222.23.249])
        by smtp.gmail.com with ESMTPSA id j4sm4229661pfc.217.2022.01.23.11.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 11:44:15 -0800 (PST)
From:   Daisuke Nojiri <dnojiri@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: PCHG: Use MKBP for device event handling
Date:   Sun, 23 Jan 2022 11:43:13 -0800
Message-Id: <20220123194317.481022-1-dnojiri@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the peripheral device charger driver receives PCHG
events as device events (EC_HOST_EVENT_DEVICE=10) except ones
related to firmware updates. This is delivered via the Chrome OS
host event protocol.

On X86 systems, the Chrome OS host event protocol is implemented on
ACPI and a ACPI handler for EC_HOST_EVENT_DEVICE (a.k.a. _Q0A)
doesn't exist.

Instead of adding a device event ACPI handler, this patch makes the
PCHG driver receive a device event through the MKBP protocol.

The MKBP protocol is already used for firmware update for PCHG
devices.  So, this allows us to unite all PCHG event handling via
MKBP on both x86 and ARM platforms.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
---

 .../power/supply/cros_peripheral_charger.c    | 35 ++--------
 .../linux/platform_data/cros_ec_commands.h    | 64 +++++++++++++++++++
 2 files changed, 70 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
index 305f10dfc06d1b..d1c45af2c50638 100644
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
 	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
-	u32 host_event = cros_ec_get_host_event(ec_dev);
 	struct charger_data *charger =
 			container_of(nb, struct charger_data, notifier);
-	u32 device_event_mask;
+	u32 host_event;
 
-	if (!host_event)
+	if (ec_dev->event_size != sizeof(host_event))
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
+	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_PCHG
+			|| !(host_event & EC_MKBP_PCHG_DEVICE_EVENT))
 		return NOTIFY_DONE;
 
 	return cros_pchg_event(charger, host_event);
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 271bd87bff0a25..c784bed3388865 100644
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
 
+/**
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

