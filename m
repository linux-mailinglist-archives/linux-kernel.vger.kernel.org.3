Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D738F4ACB6F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241323AbiBGVlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbiBGVlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:41:11 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2A6C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:41:10 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k17so12218010plk.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6RMVhrwY73oweC4VD7eDKWPb7Lpv9Fo2Z1EMKHmMCs=;
        b=e6IDHSmLKnbw0yyK9PiYrCfWp6ZqKL4teQeTA4/2Xf4NJX9S8XcuvJPDCE1Wt5sBVn
         4tfJqZAXhhLjctxLOsd1bx1F8IAOFTDUCb7GjrwF7xvywVd8JCOdwhyrDFFmKISJ1SZS
         lTyKuggwccFH5Ptx92HuI8qm1cFUWJFQiOeVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6RMVhrwY73oweC4VD7eDKWPb7Lpv9Fo2Z1EMKHmMCs=;
        b=vHD1pMqdO8j1PARsNbjfCxZdu2ZnZWtcZlG1sH1h9MKxXsF0FgRoGEa1Nu8KH4gmkp
         fGVvWh5v4PfXgL3fBuwX/S7Bv5RTwAmo5QjjfifDIcYz53xc8DPcH6HNDrpXl4Z857Bz
         nGhqEEeh2wn+PTmxHI25OuScBXT5X02vYEsGyhhnaHOc+ryeHaQrw20/wMiE9iuZDw34
         XtJ/6/d81Jwu6JK52dh2fNnEyZW3dUFz5EBQHrqstIo7HktXXgfxrIoXUT02ndYEeVt/
         aY9JOuWUVmBHrzJ3BO6P2bjXt5VYmjYa7UjXvXSpXJJQwy9KTdgIF0NfT6ZE/1nXNNJY
         08VQ==
X-Gm-Message-State: AOAM530SbDpuUytiLgzLzdCMZu88yCyyYg1uTP+uJfj2ZTf83YB8/rEb
        8dZCU83nHzLtYyB42eM9FCD2//4Ydy4ZMg==
X-Google-Smtp-Source: ABdhPJykAs6qkVRRxJ4xNzfCBF0q9OYxPMflWpf+vLKVeHRfhAbaAMtFu7HVaLpS93Kd3Dk0ZK2NoQ==
X-Received: by 2002:a17:90a:d58d:: with SMTP id v13mr975999pju.210.1644270069960;
        Mon, 07 Feb 2022 13:41:09 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s9sm9268010pgm.76.2022.02.07.13.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:41:09 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC USB TYPE-C
        DRIVER), Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 2/4] platform/chrome: cros_ec_typec: Get mux state inside configure_mux
Date:   Mon,  7 Feb 2022 21:40:26 +0000
Message-Id: <20220207214026.1526151-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220207214026.1526151-1-pmalani@chromium.org>
References: <20220207214026.1526151-1-pmalani@chromium.org>
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

Move the function which gets current mux state inside the
cros_typec_configure_mux() function. It is better to group those
bits of functionality together, and it makes it easier to move around
cros_typec_configure_mux() later.

While we are doing this, also inline the cros_typec_get_mux_info() inside
of cros_typec_configure_mux().

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 55 +++++++++++--------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 445da4f122e7..671d3569faf6 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -513,27 +513,38 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
 }
 
 static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
-				uint8_t mux_flags,
 				struct ec_response_usb_pd_control_v2 *pd_ctrl)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
+	struct ec_response_usb_pd_mux_info mux_resp;
+	struct ec_params_usb_pd_mux_info req = {
+		.port = port_num,
+	};
 	struct ec_params_usb_pd_mux_ack mux_ack;
 	enum typec_orientation orientation;
 	int ret = 0;
 
+	ret = cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO,
+			      &req, sizeof(req), &mux_resp, sizeof(mux_resp));
+	if (ret < 0) {
+		dev_warn(typec->dev, "Failed to get mux info for port: %d, err = %d\n",
+			 port_num, ret);
+		return ret;
+	}
+
 	/* No change needs to be made, let's exit early. */
-	if (port->mux_flags == mux_flags && port->role == pd_ctrl->role)
+	if (port->mux_flags == mux_resp.flags && port->role == pd_ctrl->role)
 		return 0;
 
-	port->mux_flags = mux_flags;
+	port->mux_flags = mux_resp.flags;
 	port->role = pd_ctrl->role;
 
-	if (mux_flags == USB_PD_MUX_NONE) {
+	if (port->mux_flags == USB_PD_MUX_NONE) {
 		ret = cros_typec_usb_disconnect_state(port);
 		goto mux_ack;
 	}
 
-	if (mux_flags & USB_PD_MUX_POLARITY_INVERTED)
+	if (port->mux_flags & USB_PD_MUX_POLARITY_INVERTED)
 		orientation = TYPEC_ORIENTATION_REVERSE;
 	else
 		orientation = TYPEC_ORIENTATION_NORMAL;
@@ -548,22 +559,22 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	if (ret)
 		return ret;
 
-	if (mux_flags & USB_PD_MUX_USB4_ENABLED) {
+	if (port->mux_flags & USB_PD_MUX_USB4_ENABLED) {
 		ret = cros_typec_enable_usb4(typec, port_num, pd_ctrl);
-	} else if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
+	} else if (port->mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
 		ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
-	} else if (mux_flags & USB_PD_MUX_DP_ENABLED) {
+	} else if (port->mux_flags & USB_PD_MUX_DP_ENABLED) {
 		ret = cros_typec_enable_dp(typec, port_num, pd_ctrl);
-	} else if (mux_flags & USB_PD_MUX_SAFE_MODE) {
+	} else if (port->mux_flags & USB_PD_MUX_SAFE_MODE) {
 		ret = cros_typec_usb_safe_state(port);
-	} else if (mux_flags & USB_PD_MUX_USB_ENABLED) {
+	} else if (port->mux_flags & USB_PD_MUX_USB_ENABLED) {
 		port->state.alt = NULL;
 		port->state.mode = TYPEC_STATE_USB;
 		ret = typec_mux_set(port->mux, &port->state);
 	} else {
 		dev_dbg(typec->dev,
 			"Unrecognized mode requested, mux flags: %x\n",
-			mux_flags);
+			port->mux_flags);
 	}
 
 mux_ack:
@@ -638,17 +649,6 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
 	}
 }
 
-static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
-				   struct ec_response_usb_pd_mux_info *resp)
-{
-	struct ec_params_usb_pd_mux_info req = {
-		.port = port_num,
-	};
-
-	return cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO, &req,
-			       sizeof(req), resp, sizeof(*resp));
-}
-
 /*
  * Helper function to register partner/plug altmodes.
  */
@@ -946,7 +946,6 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 {
 	struct ec_params_usb_pd_control req;
 	struct ec_response_usb_pd_control_v2 resp;
-	struct ec_response_usb_pd_mux_info mux_resp;
 	int ret;
 
 	if (port_num < 0 || port_num >= typec->num_ports) {
@@ -982,15 +981,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 		cros_typec_handle_status(typec, port_num);
 
 	/* Update the switches if they exist, according to requested state */
-	ret = cros_typec_get_mux_info(typec, port_num, &mux_resp);
-	if (ret < 0) {
-		dev_warn(typec->dev,
-			 "Failed to get mux info for port: %d, err = %d\n",
-			 port_num, ret);
-		return 0;
-	}
-
-	ret = cros_typec_configure_mux(typec, port_num, mux_resp.flags, &resp);
+	ret = cros_typec_configure_mux(typec, port_num, &resp);
 	if (ret)
 		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
 
-- 
2.35.0.263.gb82422642f-goog

