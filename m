Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA172560DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiF2XiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiF2XiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:38:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A4D7679
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:38:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d17so16472895pfq.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJ4Ekk03mtMTH9+JtnKcZsUvsy4h6D9bEJzthyrQZOk=;
        b=cOqRuruWRMNBCraxSvpme46M7pisUmTChhkgS8VvaUdahsZ6SbEbEz+bKt0CZp9sVv
         FP9G6Dqoi7ykS1WTwPQox6q8IlAVaGTTBEvG9f5vVqjDpQyhrKp8rTPqdD4EDcfQ53vO
         J5bQDowCGHowi81tQUjIPGGnMdK9LWXFVANJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJ4Ekk03mtMTH9+JtnKcZsUvsy4h6D9bEJzthyrQZOk=;
        b=3K16su/xm2N6yEXEj0PeTJFV1UYr+dgVqS3siyF89jrIha29Bjwa4agMmlGWqaIZC6
         DqlFRvsnsBwkpDm7AFBXSlhTdlwYv8RiRaTXcxW8k/a/auY7Sj/F9GFt+EK97c2VsECe
         soOkC7LyS1fn4pFLdSoQCpid7glLYhKJAKP9ogN+lMurlZ38SWpVwrEXQi8zc6YiyuFz
         nhGN1Ewf2w/zqUvZE9DKn6P8zcV64BntqCx7XqDEfNCgDsPMeutvcSZLNVnu/8Ucg76+
         TIU+O5o/nsbask+FxYdok+yHzPPW19oDg0c+/2CB0FFhLo30i2GLqUVM7wQpKtajw2AC
         YK/Q==
X-Gm-Message-State: AJIora8QOuPUKAFVr2M9QbgZaJK2GqUPHfZ+tpH7qNAR5xLBoiKucetB
        WxOqodW3IGrwZmLvb1XLEVBKU/aLm4jzDQ==
X-Google-Smtp-Source: AGRyM1vZCzT5t52puiCkqX+/pjUfVrTmJovUgvpooEklETo5F0yNhl4osqTqUpdP/4W3yC/MUUEIPw==
X-Received: by 2002:a05:6a00:180e:b0:525:43ec:ee22 with SMTP id y14-20020a056a00180e00b0052543ecee22mr11379476pfa.81.1656545881287;
        Wed, 29 Jun 2022 16:38:01 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id rm1-20020a17090b3ec100b001ed27d132c1sm127305pjb.2.2022.06.29.16.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:38:00 -0700 (PDT)
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
Subject: [PATCH 6/9] platform/chrome: cros_typec_switch: Add event check
Date:   Wed, 29 Jun 2022 23:32:24 +0000
Message-Id: <20220629233314.3540377-7-pmalani@chromium.org>
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

The Chrome EC updates Type-C status events when mux set requests from
the Application Processor (AP) are completed. Add a check to the
flow of configuring muxes to look for this status done bit, so that
the driver is aware that the mux set completed successfully or not.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_typec_switch.c | 72 ++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index 9faa442dd81a..a226f828514f 100644
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
+bool cros_typec_check_event(struct cros_typec_switch_data *sdata, int port_num, u32 mask)
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
 
 static int
-- 
2.37.0.rc0.161.g10f37bed90-goog

