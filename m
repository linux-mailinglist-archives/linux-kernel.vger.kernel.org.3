Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC354AE161
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385400AbiBHSrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385420AbiBHSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:47:51 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5FFC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:47:48 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id z35so65239pfw.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/3NuIwovuNz7GFfgDQq4eFqfd72S+Kgga4jDeLgjulM=;
        b=SzH2BGmudD3cz76o4hl70v9hFx3qos+SW+CF2fSdozabjfuEYin1BxdO3i1Sh3bz1k
         f0QnRL2Hg/FR+wrTeG2j/LIoVU+XsLkzJu1R0kwKk83N2TRU0H00ewQBTObfFOT07DKp
         b28EoLTtSO7N5TuA0VEV9OQpT/Dq7zIM1LSUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/3NuIwovuNz7GFfgDQq4eFqfd72S+Kgga4jDeLgjulM=;
        b=GddWLimVzu76zlf6MmLjcoU2TnDuoxbBFpsqZx+/F8G6nWLsVSolV6XBUoezHhJVpt
         drhE3FEHfoPBZkRdgyjNXFmePQB+QnxUWtVMSE7qi4Sr6lQoICDd/989wn8XudrWZ3NB
         jaIbdLDiZGOQ+CisUnuOm15G5OlI+xx/8MAehOtoU4Th0rqid3j3bp4bwQ+N3e5b02WU
         HsKw08iC/22LFJBOzCPUmXZbP7BBEystbnXPze/5iWHG0uFy19tzVAQ/zM7uuKthoFmb
         mKnD+FE2ZOhUxdNBQze7cGksr6j5KD//jEcJce+c2Ne4sY5JP+ScRsANCNZ3Q9R/B9od
         RjgA==
X-Gm-Message-State: AOAM532FFfcodN3pdjaF1j1IRA72Qu901Kfqf7Ouh1Ycumd6wRlFMaBF
        KUqbvpldF7ipb2+UtAbLVEFy12MO+RrIBQ==
X-Google-Smtp-Source: ABdhPJyo4hczEo4QVG0QQbOtNVE621++a+UKKID1yceuZbTeFSoguE2vzqnQAoU7XAW46pwWfXOsPw==
X-Received: by 2002:a63:8343:: with SMTP id h64mr4581287pge.566.1644346068314;
        Tue, 08 Feb 2022 10:47:48 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gk15sm3594453pjb.3.2022.02.08.10.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:47:48 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC USB TYPE-C
        DRIVER), Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 2/4] platform/chrome: cros_ec_typec: Get mux state inside configure_mux
Date:   Tue,  8 Feb 2022 18:47:20 +0000
Message-Id: <20220208184721.1697194-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208184721.1697194-1-pmalani@chromium.org>
References: <20220208184721.1697194-1-pmalani@chromium.org>
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

Changes in v2:
- Changed "mux_resp" variable to "resp".

 drivers/platform/chrome/cros_ec_typec.c | 55 +++++++++++--------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 58d08dd02f65..3d34ece7f790 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -513,27 +513,38 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
 }
 
 static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
-				uint8_t mux_flags,
 				struct ec_response_usb_pd_control_v2 *pd_ctrl)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
+	struct ec_response_usb_pd_mux_info resp;
+	struct ec_params_usb_pd_mux_info req = {
+		.port = port_num,
+	};
 	struct ec_params_usb_pd_mux_ack mux_ack;
 	enum typec_orientation orientation;
 	int ret;
 
+	ret = cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO,
+			      &req, sizeof(req), &resp, sizeof(resp));
+	if (ret < 0) {
+		dev_warn(typec->dev, "Failed to get mux info for port: %d, err = %d\n",
+			 port_num, ret);
+		return ret;
+	}
+
 	/* No change needs to be made, let's exit early. */
-	if (port->mux_flags == mux_flags && port->role == pd_ctrl->role)
+	if (port->mux_flags == resp.flags && port->role == pd_ctrl->role)
 		return 0;
 
-	port->mux_flags = mux_flags;
+	port->mux_flags = resp.flags;
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

