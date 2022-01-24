Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF024976D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiAXBED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbiAXBEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:04:02 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E9BC06173D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 17:04:02 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id i1so4335763pla.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 17:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5G40ymEd1HDdhQ2y/B55hpG0NKzOzY5pNK8ntoCLb8=;
        b=fRhtFYFP3PRJXwF1UZ6kUJQ8NpJc+gBUp7YjMiUTW9fWonTh6hoTLbNw6gx80DtJrZ
         Jg2HucJ/JkP2wA3zkhcoUhSGRq7SE3aRWHvAKuXi+OdNJNpVWtwzpDKFV5iGTJM5kNQS
         RBUfzg79fB5gxzKMGz/0nCLSApafCV6NiF1N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5G40ymEd1HDdhQ2y/B55hpG0NKzOzY5pNK8ntoCLb8=;
        b=dSarXw9IbwZG1KVaTI0G9Em1U54OtEshHA/eCYQ5s0v5hfyq6XUdDO0grxeAPv1YF+
         sn/6R8zh7CwgICmgY0qWxiSD/+nqWXeN2+67pqa2JQ4UaIuoxOCiYoQ53Fv/rANRuK/a
         q90fKcV7KNRVXBBtPuCT9kHg10ZBS6EqhIuPRVuIHX59mSfoSsZCIcVTIqToTq4NeFND
         UouNkrx8329gJTnnPLhj6+OZq1xjMV5wOcZzsXJf4S030B2sHtmhGAVqE4VpbBuQTsVX
         HndY6zRpbWpjPCzo/7bNpEXdTkxanzwtjNNuhyFCVUw3o+j7UDQwsIwT+9b9ExIsFYM0
         MDGA==
X-Gm-Message-State: AOAM530/CkW6NDF3KeksRIYi1njMbS1UzZfR+xNXaa9rlK2Ui5pfOnxF
        BDcgZDCl7vUsdUEKWQEU5beI6ga76VjPDg==
X-Google-Smtp-Source: ABdhPJzJgmoKx+WN8xYtbuF/z8gd3EVdChCOMfapo2zaSAbPVSB3c3aCboZ2DCyaecuRi1tQvKk/xw==
X-Received: by 2002:a17:903:1c2:b0:14b:465f:2482 with SMTP id e2-20020a17090301c200b0014b465f2482mr4470918plh.73.1642986241295;
        Sun, 23 Jan 2022 17:04:01 -0800 (PST)
Received: from pc98bx3.roam.corp.google.com (c-73-222-23-249.hsd1.ca.comcast.net. [73.222.23.249])
        by smtp.gmail.com with ESMTPSA id q9sm13642558pfj.113.2022.01.23.17.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 17:04:00 -0800 (PST)
From:   Daisuke Nojiri <dnojiri@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: PCHG: Use MKBP for device event handling
Date:   Sun, 23 Jan 2022 17:03:44 -0800
Message-Id: <20220124010348.681893-1-dnojiri@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the PCHG driver receive device events through
MKBP protocol since CrOS EC switched to deliver all peripheral
charge events to the MKBP protocol. This will unify PCHG event
handling on X86 and ARM.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
---
 .../power/supply/cros_peripheral_charger.c    | 35 ++--------
 .../linux/platform_data/cros_ec_commands.h    | 64 +++++++++++++++++++
 2 files changed, 70 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
index 305f10dfc06d1b..cb402f48087ddf 100644
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
+	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_PCHG
+			|| ec_dev->event_size != sizeof(host_event))
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

