Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F13560D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiF2XhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiF2Xgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:36:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4444D9FD7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:36:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g7so12047963pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+vvOVFfU8uFzQawpdSqHer9f8bP2F/YEZu8I7Rg7Ys=;
        b=Hsx4uyO6Tu8d1qkUz87tehFJnYFEFwfbLDWpyERC4QzZKwmDRdCaBNJT0XQai56BI2
         XOIETp9qqPz0fiJPpbqaSnz5L0ChQCrUP61uGKamb28EkZ/TT/HNlZHEIBP8f/sfhzKb
         QACpp1wGtG5FUkfqBDsnsTkWY3sLEjSLnGUn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+vvOVFfU8uFzQawpdSqHer9f8bP2F/YEZu8I7Rg7Ys=;
        b=umg52B5zkCq/vBkGavgNHIjx4t829rEoT0htDIy1pV/w5nR+kLB//Lofxn6osJOUNP
         6FZghMvswxkj6m924HoQP5lcsjvPikSkvzsSzUoEZjdY+kA1wGRc7wSYLHFGtLrSSKv+
         C3zx8mK31885wnCMMFFYRywHjdSoy0GiYMWYoG6ce5EhQC/3AG94y0LjNQryBBBhVEpk
         nrl40ZhWaAVqWtCvT/LAs7ED/daXf4KwDpirXTo5aEm77v6LgaXbWxSLdNiW1TNOmqkB
         k7HSgmyciC1Di39Gr1xlsRs7gYBKqSiRlh55RxcchX6yxwo/pFa/V5LzeDKZRH7ZTHi8
         2A2A==
X-Gm-Message-State: AJIora9yuY8TG1Nh9d9VGz7NortF45z7SHBfSTX6PmK/ogjHZopPCg1l
        MjosqndOxrMy2RLAea9ANrlQ7PWsUsy3Fw==
X-Google-Smtp-Source: AGRyM1tMl81u3qj7l08Q5QHb4umX3T3yLJEnR7ouqJeY+P4T3j1/UV6EFuqv1Gvm5cQoy0RILlPVXg==
X-Received: by 2002:a17:902:d583:b0:16a:29de:9dfb with SMTP id k3-20020a170902d58300b0016a29de9dfbmr11374975plh.44.1656545794430;
        Wed, 29 Jun 2022 16:36:34 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id rm1-20020a17090b3ec100b001ed27d132c1sm127305pjb.2.2022.06.29.16.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:36:33 -0700 (PDT)
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
Subject: [PATCH 5/9] platform/chrome: cros_typec_switch: Set EC retimer
Date:   Wed, 29 Jun 2022 23:32:23 +0000
Message-Id: <20220629233314.3540377-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233314.3540377-1-pmalani@chromium.org>
References: <20220629233314.3540377-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/platform/chrome/cros_typec_switch.c | 56 ++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index 1a795f613543..9faa442dd81a 100644
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
@@ -28,10 +31,61 @@ struct cros_typec_switch_data {
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
 static int
 cros_typec_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
 {
-	return 0;
+	struct cros_typec_port *port = typec_retimer_get_drvdata(retimer);
+
+	/* Retimers have index 1. */
+	return cros_typec_configure_mux(port->sdata, port->port_num, 1, state->mode, state->alt);
 }
 
 void cros_typec_unregister_switches(struct cros_typec_switch_data *sdata)
-- 
2.37.0.rc0.161.g10f37bed90-goog

