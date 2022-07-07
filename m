Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDCF56AE56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiGGWZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiGGWZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:25:19 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D5061D77
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:25:18 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id o18so19652425pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySuBOD6Wk3XGCffFBEm6ereJYHzD1HhIjVAepmGuLus=;
        b=m6ML3qwJwRRDJtYpa4OS/Fw81GoVjPL/hGPb6qhjkXcq+fCwMb4vy4uvGrMbf+WRth
         jX/Z5js7MqHdccR9CPeEJJl1XSOuMsj5FXSnoFIK7SkrHTTwk2U7NKAg0BELARiTE2cP
         z2MF4eAsYC5dHNgeQozl45zi1dS+QiJJbkPe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySuBOD6Wk3XGCffFBEm6ereJYHzD1HhIjVAepmGuLus=;
        b=hI8SUwRBIQMmPdnSgBH2mcZlS9es3Jq0d2dguhzNEoV+uqR5htLeVIKdrbcWRuH68n
         nPu1MY2JHyoVHgbh/RDdJP2DMBfLhkg6dwXk0MI0aa1VxCNKzXtuKQ98Bkv15IiNrr1o
         1n9dkFap81TJ6etfiQJTfAzeIvRQNO3I/NGsauc+OoQWXQYhK5W9dX8xaq2lkgwPvmqe
         6102FSiHklTpGCrAggtQhTSzOX4pkw4gBQ5p2gM2goMeQOrMFYsXUhNkMmpiuM4ZmND+
         TuQSvv6hZM69KfpexiEQa1dyyxXQKeBwVqQNROvWTUVODkNQ0XaoszCuTqQ2T/tSWYTj
         BzLQ==
X-Gm-Message-State: AJIora98dFpeHNSGNdtzg+ua1v/ekpY7xDhTCWYVf5wcPNDW1EwumBi1
        gtgRn6ryvJTSvPZft1zwqOtWps24K6Lt/g==
X-Google-Smtp-Source: AGRyM1u24A+fgEN+ITg8VBtY7hYsxlZKWWPqKb92e//MBPci4qHIz/AZuFO2WEo1YciLmQx+1g7w8A==
X-Received: by 2002:a63:4d26:0:b0:411:83dd:2c3 with SMTP id a38-20020a634d26000000b0041183dd02c3mr298378pgb.508.1657232717576;
        Thu, 07 Jul 2022 15:25:17 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 66-20020a620445000000b005289bfcee91sm5545657pfe.59.2022.07.07.15.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:25:17 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 6/9] platform/chrome: cros_typec_switch: Add event check
Date:   Thu,  7 Jul 2022 22:20:13 +0000
Message-Id: <20220707222045.1415417-7-pmalani@chromium.org>
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

The Chrome EC updates Type-C status events when mux set requests from
the Application Processor (AP) are completed. Add a check to the
flow of configuring muxes to look for this status done bit, so that
the driver is aware that the mux set completed successfully or not.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v2:
- Fixed missing "static" identifier.

Changes since v1:
- No changes.

 drivers/platform/chrome/cros_typec_switch.c | 72 ++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index b50ecedce662..7c01957a032d 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -7,6 +7,8 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -63,6 +65,40 @@ static int cros_typec_get_mux_state(unsigned long mode, struct typec_altmode *al
 	return ret;
 }
 
+static int cros_typec_send_clear_event(struct cros_typec_switch_data *sdata, int port_num,
+				       u32 events_mask)
+{
+	struct ec_params_typec_control req = {
+		.port = port_num,
+		.command = TYPEC_CONTROL_COMMAND_CLEAR_EVENTS,
+		.clear_events_mask = events_mask,
+	};
+
+	return cros_ec_command(sdata->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
+			       sizeof(req), NULL, 0);
+}
+
+static bool cros_typec_check_event(struct cros_typec_switch_data *sdata, int port_num, u32 mask)
+{
+	struct ec_response_typec_status resp;
+	struct ec_params_typec_status req = {
+		.port = port_num,
+	};
+	int ret;
+
+	ret = cros_ec_command(sdata->ec, 0, EC_CMD_TYPEC_STATUS, &req, sizeof(req),
+			      &resp, sizeof(resp));
+	if (ret < 0) {
+		dev_warn(sdata->dev, "EC_CMD_TYPEC_STATUS failed for port: %d\n", port_num);
+		return false;
+	}
+
+	if (resp.events & mask)
+		return true;
+
+	return false;
+}
+
 /*
  * The Chrome EC treats both mode-switches and retimers as "muxes" for the purposes of the
  * host command API. This common function configures and verifies the retimer/mode-switch
@@ -71,12 +107,44 @@ static int cros_typec_get_mux_state(unsigned long mode, struct typec_altmode *al
 static int cros_typec_configure_mux(struct cros_typec_switch_data *sdata, int port_num, int index,
 				    unsigned long mode, struct typec_altmode *alt)
 {
-	int ret = cros_typec_get_mux_state(mode, alt);
+	unsigned long end;
+	u32 event_mask;
+	u8 mux_state;
+	int ret;
+
+	ret = cros_typec_get_mux_state(mode, alt);
+	if (ret < 0)
+		return ret;
+	mux_state = (u8)ret;
 
+	/* Clear any old mux set done event. */
+	if (index == 0)
+		event_mask = PD_STATUS_EVENT_MUX_0_SET_DONE;
+	else
+		event_mask = PD_STATUS_EVENT_MUX_1_SET_DONE;
+
+	ret = cros_typec_send_clear_event(sdata, port_num, event_mask);
+	if (ret < 0)
+		return ret;
+
+	/* Send the set command. */
+	ret = cros_typec_cmd_mux_set(sdata, port_num, index, mux_state);
 	if (ret < 0)
 		return ret;
 
-	return cros_typec_cmd_mux_set(sdata, port_num, index, (u8)ret);
+	/* Check for the mux set done event. */
+	end = jiffies + msecs_to_jiffies(1000);
+	do {
+		if (cros_typec_check_event(sdata, port_num, event_mask))
+			return 0;
+
+		usleep_range(500, 1000);
+	} while (time_before(jiffies, end));
+
+	dev_err(sdata->dev, "Timed out waiting for mux set done on index: %d, state: %d\n",
+		index, mux_state);
+
+	return -ETIMEDOUT;
 }
 
 static int cros_typec_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
-- 
2.37.0.rc0.161.g10f37bed90-goog

