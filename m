Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908685964FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiHPVwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiHPVwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:52:22 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1F38E0ED
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:52:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o3so10398887ple.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ABHvUphZ0aIs8EGZBbtNv5cxZuZ8nYm2ItFqz4z9eZo=;
        b=gC2+U4BX0e8V7cnJCyV8KNzKXV3FB+nHx8CR5zFGwOvSMXsOtAVLamDDZcoCtSzmjn
         lbj3cM6R0gpLFvS3JZhnXXHjxEkMK0NFq1M5VoPxuKm7zFMF0Gk3RaoE2pHF+IRov5E4
         HNSMfJr9DeNc5m+81ILqMI5pyIUVYw1XRTwh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ABHvUphZ0aIs8EGZBbtNv5cxZuZ8nYm2ItFqz4z9eZo=;
        b=naZS70QpkVaLx5Y0SFRzmm8VzV5LcKbawdHy4gdzEcCXeJ38gfUe6byCoj4SFLqGIt
         wImPNIIFqzF2AMZJ5A2Jei180zqdM5gEUSz3DCQF/1f+S4dqZ72Wtozjj66tAehMu1pF
         OXiCM5GLKQMRcPq1BPFfiz6il/Ia6uT/EmDKquf0BrO8PgEZbC9t4d+Pfv1WXh0Pgo/V
         svcG8Bx+hjaYjcAmHdmcnyJ61xSlytHmYfsp+saaByB0SezKk+kWftt1PYIsvzQQ2+r5
         zsWuo9NyYQ13TfrBEfbRh2Lm9NUKudnyehdypa+lwBeJ6oibRGrYcQyY/Q5BJvn43O0/
         pqvQ==
X-Gm-Message-State: ACgBeo2vVPT7U3M3JSxgT9N/AHM2r8Vmv9DMsYLEMlkLsNl4KpnMO0ng
        kAmIP0u0N16cOKR7Mel/bUziC0VraF/JLA==
X-Google-Smtp-Source: AA6agR4bdAQZGh1YJ8rZ+knDDc9jY0Kt1RJx/SZ5KJ/BVrfvCgeiDoA2MoCSv8CIy8EeoyOpj7fTtw==
X-Received: by 2002:a17:902:9882:b0:172:793b:ccc3 with SMTP id s2-20020a170902988200b00172793bccc3mr6252689plp.27.1660686740371;
        Tue, 16 Aug 2022 14:52:20 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id z5-20020a623305000000b005323a1a9fecsm8916650pfz.101.2022.08.16.14.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:52:20 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v6 7/7] platform/chrome: cros_ec_typec: Get retimer handle
Date:   Tue, 16 Aug 2022 21:48:35 +0000
Message-Id: <20220816214857.2088914-8-pmalani@chromium.org>
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

Where available, obtain the handle to retimer switch specified via
firmware, and update the mux configuration callsites to add retimer
support for supported modes.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
---

Changes since v5:
- Picked up Reviewed-by tag.
- Removed double space.

Changes since v4:
- No changes.

Changes since v3:
- No changes.

Changes since v2:
- No changes.

Changes since v1:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 44 +++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index ee54add992db..3ffe3c082ea2 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -20,6 +20,7 @@
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_retimer.h>
 #include <linux/usb/typec_tbt.h>
 #include <linux/usb/role.h>
 
@@ -55,6 +56,7 @@ struct cros_typec_port {
 	struct usb_pd_identity c_identity;
 	struct typec_switch *ori_sw;
 	struct typec_mux *mux;
+	struct typec_retimer *retimer;
 	struct usb_role_switch *role_sw;
 
 	/* Variables keeping track of switch state. */
@@ -143,6 +145,12 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 		goto mux_err;
 	}
 
+	port->retimer = fwnode_typec_retimer_get(fwnode);
+	if (IS_ERR(port->retimer)) {
+		dev_dbg(dev, "Retimer handle not found.\n");
+		goto retimer_sw_err;
+	}
+
 	port->ori_sw = fwnode_typec_switch_get(fwnode);
 	if (IS_ERR(port->ori_sw)) {
 		dev_dbg(dev, "Orientation switch handle not found.\n");
@@ -160,6 +168,8 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 role_sw_err:
 	typec_switch_put(port->ori_sw);
 ori_sw_err:
+	typec_retimer_put(port->retimer);
+retimer_sw_err:
 	typec_mux_put(port->mux);
 mux_err:
 	return -ENODEV;
@@ -204,6 +214,21 @@ static void cros_typec_unregister_altmodes(struct cros_typec_data *typec, int po
 	}
 }
 
+/*
+ * Map the Type-C Mux state to retimer state and call the retimer set function. We need this
+ * because we re-use the Type-C mux state for retimers.
+ */
+static int cros_typec_retimer_set(struct typec_retimer *retimer, struct typec_mux_state state)
+{
+	struct typec_retimer_state rstate = {
+		.alt = state.alt,
+		.mode = state.mode,
+		.data = state.data,
+	};
+
+	return typec_retimer_set(retimer, &rstate);
+}
+
 static int cros_typec_usb_disconnect_state(struct cros_typec_port *port)
 {
 	port->state.alt = NULL;
@@ -212,6 +237,7 @@ static int cros_typec_usb_disconnect_state(struct cros_typec_port *port)
 
 	usb_role_switch_set_role(port->role_sw, USB_ROLE_NONE);
 	typec_switch_set(port->ori_sw, TYPEC_ORIENTATION_NONE);
+	cros_typec_retimer_set(port->retimer, port->state);
 
 	return typec_mux_set(port->mux, &port->state);
 }
@@ -409,9 +435,14 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 
 static int cros_typec_usb_safe_state(struct cros_typec_port *port)
 {
+	int ret;
 	port->state.mode = TYPEC_STATE_SAFE;
 
-	return typec_mux_set(port->mux, &port->state);
+	ret = cros_typec_retimer_set(port->retimer, port->state);
+	if (!ret)
+		ret = typec_mux_set(port->mux, &port->state);
+
+	return ret;
 }
 
 /*
@@ -508,7 +539,11 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	port->state.data = &dp_data;
 	port->state.mode = TYPEC_MODAL_STATE(ffs(pd_ctrl->dp_mode));
 
-	return typec_mux_set(port->mux, &port->state);
+	ret = cros_typec_retimer_set(port->retimer, port->state);
+	if (!ret)
+		ret = typec_mux_set(port->mux, &port->state);
+
+	return ret;
 }
 
 static int cros_typec_enable_usb4(struct cros_typec_data *typec,
@@ -597,7 +632,10 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	} else if (port->mux_flags & USB_PD_MUX_USB_ENABLED) {
 		port->state.alt = NULL;
 		port->state.mode = TYPEC_STATE_USB;
-		ret = typec_mux_set(port->mux, &port->state);
+
+		ret = cros_typec_retimer_set(port->retimer, port->state);
+		if (!ret)
+			ret = typec_mux_set(port->mux, &port->state);
 	} else {
 		dev_dbg(typec->dev,
 			"Unrecognized mode requested, mux flags: %x\n",
-- 
2.37.1.595.g718a3a8f04-goog

