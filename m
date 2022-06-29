Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0EA560DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiF2Xk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiF2Xk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:40:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EAEDF11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:40:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c4so15488695plc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+kTivI5j4VL0Glhx/QLH7bOjgxInGIflDMjRi1pPSo=;
        b=QEFE2ZREw7PZn1EHum4nOwGJDD33Zno9d4oJAdexunO9n3X4ns8I0JiPd952564aGh
         pUTkVJkMbnszCLWtgFppUOO0efR1/WSBye2xzGtE2Vo0MHMNqm1kDLz5nxGrwKtlnuVa
         2K+3sl2GvDzAi34rgOeBq3XJ8BEzE8ThbSQKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+kTivI5j4VL0Glhx/QLH7bOjgxInGIflDMjRi1pPSo=;
        b=1ex3o/mOMKeEGEOKyzzDh8Vh1sk8fW6oEak+xpA/GMuhHkD1U3Yd1W/B8bgS9yq2av
         sOc7X8T5gyYCYomLAjpcSxVe4W/aygQdMyK4+5paKXasWFBrtFN+IUpqR2OXXT8Kk0CS
         I8mBXXgJ/m+Hl0OMtzHSb+RmnAg03/tZMHi2nt3JuHyGvPcPKeOqJvVoS13BG2Lz4kkb
         ShlTlD9xUBstaImS4+aUN20X9sKfbDnRuOuC5A7gdCPfg8c/ADmz7cVJQOMy2urxHthw
         ejtkunPFXQkGFGmXCl80BBkqFRc+ljiCxenFI8KEBWMHAaXsTYKXcEEHNWyX71Cp7e+S
         PSRA==
X-Gm-Message-State: AJIora9M4fn/XUDfuqFHyWc4yAtQI7a1bvywWTHnm3fzgBLO4+DtfpJf
        sW+r1e/zHDh0Y3AWU6u4aXiNdva1fxYTrQ==
X-Google-Smtp-Source: AGRyM1tMSOGpkv0MQnR98QputkS7ul89O7sMd6eMaC0iC1T1BtHrnytRuMeNSy6cQ+dAfGv3Hch2WA==
X-Received: by 2002:a17:902:8b87:b0:169:5e5:43de with SMTP id ay7-20020a1709028b8700b0016905e543demr11698212plb.8.1656546055223;
        Wed, 29 Jun 2022 16:40:55 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id rm1-20020a17090b3ec100b001ed27d132c1sm127305pjb.2.2022.06.29.16.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:40:54 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 9/9] platform/chrome: cros_ec_typec: Get retimer handle
Date:   Wed, 29 Jun 2022 23:32:27 +0000
Message-Id: <20220629233314.3540377-10-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233314.3540377-1-pmalani@chromium.org>
References: <20220629233314.3540377-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/platform/chrome/cros_ec_typec.c | 44 +++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 39e6fd4491a9..38c4ac754ea9 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -20,6 +20,7 @@
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_retimer.h>
 #include <linux/usb/typec_tbt.h>
 #include <linux/usb/role.h>
 
@@ -53,6 +54,7 @@ struct cros_typec_port {
 	struct usb_pd_identity c_identity;
 	struct typec_switch *ori_sw;
 	struct typec_mux *mux;
+	struct typec_retimer *retimer;
 	struct usb_role_switch *role_sw;
 
 	/* Variables keeping track of switch state. */
@@ -142,6 +144,12 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
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
@@ -159,6 +167,8 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 role_sw_err:
 	typec_switch_put(port->ori_sw);
 ori_sw_err:
+	typec_retimer_put(port->retimer);
+retimer_sw_err:
 	typec_mux_put(port->mux);
 mux_err:
 	return -ENODEV;
@@ -203,6 +213,21 @@ static void cros_typec_unregister_altmodes(struct cros_typec_data *typec, int po
 	}
 }
 
+/*
+ * Map the Type-C Mux state to retimer state and call the retimer set function. We need this
+ * because we re-use the Type-C mux state for retimers.
+ */
+static int cros_typec_retimer_set(struct typec_retimer  *retimer, struct typec_mux_state state)
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
@@ -211,6 +236,7 @@ static int cros_typec_usb_disconnect_state(struct cros_typec_port *port)
 
 	usb_role_switch_set_role(port->role_sw, USB_ROLE_NONE);
 	typec_switch_set(port->ori_sw, TYPEC_ORIENTATION_NONE);
+	cros_typec_retimer_set(port->retimer, port->state);
 
 	return typec_mux_set(port->mux, &port->state);
 }
@@ -381,9 +407,14 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 
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
@@ -480,7 +511,11 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
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
@@ -569,7 +604,10 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
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
2.37.0.rc0.161.g10f37bed90-goog

