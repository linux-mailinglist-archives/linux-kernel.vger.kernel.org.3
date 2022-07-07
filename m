Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3256AE55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiGGWYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbiGGWYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:24:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E924A61D73
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:24:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso163712pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N9vAkojdh6qMe19EHyx5mVtuXIIPXXQjqcAFQnpD2/w=;
        b=adbszkRTqfHpbUOBrGo4yWWxnXbH3v4a8KsPa0jahMhmw3oO/dFNATvjEbVCEzUOwb
         PvD8tUn7JS3pKgM/BJUdlbjePyqqtJNTlc/CLuCw+fZH62R0poN3YZH2H+jSqpC74EYp
         aYaACHYagEpGgUwpLFGyDi4BufQ33mU4jXaUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N9vAkojdh6qMe19EHyx5mVtuXIIPXXQjqcAFQnpD2/w=;
        b=BwYrCpYIEE5P+2AuGZGqgf7cVdSDfv/LPQMPP8EMwcatA/6ovBK8YvRJTCM/OVRLaX
         CHqV1jbmM6woK9jtFj4Fp4S7gtfpLqr/cwy9honU11ePSQL8Yhq8hFmyvtV1YehUtY8y
         3ruHXOipL2gRGGLZ/3x2iJU7JVYg1/7oAf86fOz9jL8WqsXDEf6nHsOQMUB9k/d+DheC
         igvX+b13Uv3xzG4ZVMUSu/m9NGIDccICN1a7yJpshhKIslYjsCHHpFVHbyXIctjKDyE8
         dQPt+p9IukcAbP5HbmnslegwO6nmF0VsYF9BzhZMfeeUSVdy0q7k0ML2vc3H5olGRuHV
         36qw==
X-Gm-Message-State: AJIora93q1ZJDdwFDBrIAfck9KbulxnY3PqHinaWyCJNXaOea0B1/cnn
        gfdGIpUCAA87crW9bCiQRcWS3bP7VFc7fA==
X-Google-Smtp-Source: AGRyM1sEExb5BbYrXctyg52GLzsAYr1U0f+5+G8TK57wfvKazzq5tMyp0zqOlqS7G6sv19pDrBvvVQ==
X-Received: by 2002:a17:90b:2496:b0:1ef:a94:7048 with SMTP id nt22-20020a17090b249600b001ef0a947048mr114546pjb.244.1657232681298;
        Thu, 07 Jul 2022 15:24:41 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 66-20020a620445000000b005289bfcee91sm5545657pfe.59.2022.07.07.15.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:24:40 -0700 (PDT)
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
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v3 5/9] platform/chrome: cros_typec_switch: Set EC retimer
Date:   Thu,  7 Jul 2022 22:20:12 +0000
Message-Id: <20220707222045.1415417-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220707222045.1415417-1-pmalani@chromium.org>
References: <20220707222045.1415417-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoke Chrome EC host commands to set EC-controlled retimer switches to
the state the Type-C framework instructs.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v2:
- No changes.

Changes since v1:
- No changes.

 drivers/platform/chrome/cros_typec_switch.c | 56 ++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index 0d319e315d57..b50ecedce662 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -9,7 +9,10 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/usb/typec_altmode.h>
+#include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_retimer.h>
 
 #define DRV_NAME "cros-typec-switch"
@@ -28,9 +31,60 @@ struct cros_typec_switch_data {
 	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
 };
 
+static int cros_typec_cmd_mux_set(struct cros_typec_switch_data *sdata, int port_num, u8 index,
+				  u8 state)
+{
+	struct typec_usb_mux_set params = {
+		.mux_index = index,
+		.mux_flags = state,
+	};
+
+	struct ec_params_typec_control req = {
+		.port = port_num,
+		.command = TYPEC_CONTROL_COMMAND_USB_MUX_SET,
+		.mux_params = params,
+	};
+
+	return cros_ec_command(sdata->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
+			       sizeof(req), NULL, 0);
+}
+
+static int cros_typec_get_mux_state(unsigned long mode, struct typec_altmode *alt)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (mode == TYPEC_STATE_SAFE)
+		ret = USB_PD_MUX_SAFE_MODE;
+	else if (mode == TYPEC_STATE_USB)
+		ret = USB_PD_MUX_USB_ENABLED;
+	else if (alt && alt->svid == USB_TYPEC_DP_SID)
+		ret = USB_PD_MUX_DP_ENABLED;
+
+	return ret;
+}
+
+/*
+ * The Chrome EC treats both mode-switches and retimers as "muxes" for the purposes of the
+ * host command API. This common function configures and verifies the retimer/mode-switch
+ * according to the provided setting.
+ */
+static int cros_typec_configure_mux(struct cros_typec_switch_data *sdata, int port_num, int index,
+				    unsigned long mode, struct typec_altmode *alt)
+{
+	int ret = cros_typec_get_mux_state(mode, alt);
+
+	if (ret < 0)
+		return ret;
+
+	return cros_typec_cmd_mux_set(sdata, port_num, index, (u8)ret);
+}
+
 static int cros_typec_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
 {
-	return 0;
+	struct cros_typec_port *port = typec_retimer_get_drvdata(retimer);
+
+	/* Retimers have index 1. */
+	return cros_typec_configure_mux(port->sdata, port->port_num, 1, state->mode, state->alt);
 }
 
 static void cros_typec_unregister_switches(struct cros_typec_switch_data *sdata)
-- 
2.37.0.rc0.161.g10f37bed90-goog

