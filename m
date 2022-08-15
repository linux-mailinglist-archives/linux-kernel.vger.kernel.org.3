Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8955929B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiHOGl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiHOGly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:41:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DD11AD95
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:41:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so6008315pjf.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DmjHhmRYRQK+znnXE5rwgH9w/NTCsFJdGvq/FsVg4CY=;
        b=D7yaJFBWtQefZHhd2ltWvHiYWaMGjLKMMDACtsG3+unG6sLpKHAF+q5A8NbJAYQ3Fo
         xTf3B3Q6gY6SiF/AGBYDEC2Vm7oqyD1Twfu0MxQemY0MUJPIiYcarJlE+naRRXxxWEap
         tvTiqt/AaQWfiKCibzqsDq6Fq6GOcwLCNlcuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DmjHhmRYRQK+znnXE5rwgH9w/NTCsFJdGvq/FsVg4CY=;
        b=WTMYDxQjn1Y3SixE7byIpVlFaCeyrbhitWBM57Iz+MPvV2lPKpy/lRlyNugsvdcDin
         hGUbIG/ocMzwAqW4HcWRn0eImsPQ3/Ab0LWiDvoZ6Z1goW3/uCoHTHW6yPVNQPsRdD3p
         Alr5F+o+Z/Hkci2KlwOwQT/Lslw98v4CSxEtEcAu+iBJUmMJNX8fikQGEaoxZ08k3Mcj
         6oO3EmhzB63HpL5e8tv7t7LJBFhtmiKELvVWNyrEvl4bjajKirpQQiO8e69LihxKjMcg
         cf0EJ/HerxKXKZaTH96br+cFm4tVsBWL0PRIfGv+I5zIcEhYahOJu0DDYNezBUuDrKeQ
         hNOg==
X-Gm-Message-State: ACgBeo07odKQNPjff6TPwJlHr0VGRaaCzZGekaptpUdtMaIBW1rf5hpb
        ieh7ZSvRbCs94At6DwDOi+MRzMU6WtbrEw==
X-Google-Smtp-Source: AA6agR7XLpaaoz0vscLb0qVgOD0YXAg4+wEejefnfT+bIw9qXQSoGhPji6Vm0B7HJ0y5ioWu74Xmyw==
X-Received: by 2002:a17:90b:164d:b0:1f6:a38b:91e9 with SMTP id il13-20020a17090b164d00b001f6a38b91e9mr17004297pjb.211.1660545712941;
        Sun, 14 Aug 2022 23:41:52 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id 200-20020a6214d1000000b0052db82ad8b2sm5988233pfu.123.2022.08.14.23.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:41:52 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v5 3/7] platform/chrome: cros_typec_switch: Set EC retimer
Date:   Mon, 15 Aug 2022 06:34:21 +0000
Message-Id: <20220815063555.1384505-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220815063555.1384505-1-pmalani@chromium.org>
References: <20220815063555.1384505-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Changes since v4:
- Update cros_ec_command() to cros_ec_cmd().

Changes since v3:
- No changes.

Changes since v2:
- No changes.

Changes since v1:
- No changes.

 drivers/platform/chrome/cros_typec_switch.c | 56 ++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index 0d319e315d57..befe35655a9a 100644
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
+	return cros_ec_cmd(sdata->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
+			   sizeof(req), NULL, 0);
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
2.37.1.595.g718a3a8f04-goog

