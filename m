Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7056D6C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiGKH1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiGKH1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:27:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD3B1A39F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:27:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 23so4021646pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltR4ACK7cvdVqSLD7lT3OdzN4AnkmkLPklaRa89XJQM=;
        b=Pe/Jn/mOYQgAgyY9boCsCzaQh8QhJ1HQMNdF4UX+IR5rGs8Pl/1r9zwDF2BNWNdhx/
         tRWcpu92DOeSf1exbLAkE1owKuifnx8Cxgp7kvqLpdMiZXx9rBizqH8dRtQ9xT5LrLhe
         AYblPA6frGhG+CS+o7GAzlTySapuCcrB2r0jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltR4ACK7cvdVqSLD7lT3OdzN4AnkmkLPklaRa89XJQM=;
        b=U1ZH+ekd6rQi1enpPlvXLn1v0w7QniWKdCG1FPGgIGTGOoaII+f+PzBNgw+Uw1pq6e
         b0W6uu6O+vEpG2WpuW7bvmWYgBoZl230/mw3vNy5Vtvqx+2syY9TOK+jkgYHYEpH7jSZ
         sDBbMOXoyY3xbOJtGFyz85ZVdQeeRNlkfOvWqydUSuVeXKIarSlcVF32C2Ms+h/tFE3F
         J2K3g6Ua9iKnvsl0ZJMArpBDwYIV+uCxZOGTIkQCXA3U34rv+Zf1+tnKOgnpljwIENEm
         HW4wXGcWTRq+0+w0KffOMSn5eGoPy/Gw0LMf2XnqQZQnckbr6Fh7obZqd593d/saA2uA
         hcQA==
X-Gm-Message-State: AJIora+12U7r8VSN8knnP70khdtXWoSnWR2yGULl/h2oQN89a3aIWG8d
        ZR7HJ7AQSnq7hOqyPkt6CM6T0jSFcyCLzA==
X-Google-Smtp-Source: AGRyM1sAX3lU1UhTYLRAmEnvbJ8kmdvvRlGBV4XwrAs1ppKD9Fwbxg+ZWeV+2k8AjBzGsN/gi3VaFA==
X-Received: by 2002:a63:165c:0:b0:412:6f3a:1b4b with SMTP id 28-20020a63165c000000b004126f3a1b4bmr15220079pgw.98.1657524457024;
        Mon, 11 Jul 2022 00:27:37 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z8-20020aa79e48000000b0051bc5f4df1csm4012839pfq.154.2022.07.11.00.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 00:27:36 -0700 (PDT)
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
Subject: [PATCH v4 5/9] platform/chrome: cros_typec_switch: Set EC retimer
Date:   Mon, 11 Jul 2022 07:22:59 +0000
Message-Id: <20220711072333.2064341-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220711072333.2064341-1-pmalani@chromium.org>
References: <20220711072333.2064341-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes since v3:
- No changes.

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
2.37.0.144.g8ac04bfd2-goog

