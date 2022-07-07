Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1895556AE5B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiGGW0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbiGGW0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:26:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270CC65D45
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:26:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id r1so14848837plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U15qmYXT9GH8TjN1Ut3guN2hyLaKnAjiTAFtYvltatM=;
        b=QnIsu/zns+A7aL1LdpvG6NIX4YjyjQ5N4RZKvlVq8nxakt02znaMQSjhSi48KGXzJY
         gWKS93PjxBD+sqRwECfk0eB1+jYFUeZP1uH8ty/nXlj7b6tqwcYg6gzhzvM1UkjkIg6h
         I6x7S1UFRhTnakk0t8GEKyiFS3C8GX1R4J5Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U15qmYXT9GH8TjN1Ut3guN2hyLaKnAjiTAFtYvltatM=;
        b=UVXwAOpRJU6MWeDka/fhn1CfHp5+pY6gTb/Hew2AapgQxbScFsNUpg0rIFxGsZMjAm
         OZXbRqJfgNJzYafAm4mOP9WuCM4roc3KlxDQI2HGFLQJXWvVBWM72Nl2VciWY7alkqYc
         cTya+h+SSWogknuENhg+n79lRLOeQY9Psvs9W67RHo05q/TkNfZ48koxW1ZmwEB9AVJt
         ofhB4cHOxbxkmGelxM3ieFzbJRvRU3sPLi4lexrzH89miiZyjSpAt39MtyfYsQEGiyN1
         OXnVUMN1JlgIX/4dbPszpsHGD7ziNe7HQrt0eDkXcZKL73DBr7eICMNDPsPCh2J1VSkp
         XALQ==
X-Gm-Message-State: AJIora80+tv5Ohhd7WN2YScmak/ULN4EJoBpA1RWZJkj+UYCBkt18WtD
        bh8XxRpWK7m/9f8J62Ui4DNzD7fCDisYYQ==
X-Google-Smtp-Source: AGRyM1tGwWrSbLUTuvLlh27HVREzxYeyt55EEOyBrvpGsutFkPg0Kb9f8sySfTse8Q7jNRckhyok6w==
X-Received: by 2002:a17:90b:2341:b0:1ef:819f:dfc4 with SMTP id ms1-20020a17090b234100b001ef819fdfc4mr7563605pjb.206.1657232769470;
        Thu, 07 Jul 2022 15:26:09 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 66-20020a620445000000b005289bfcee91sm5545657pfe.59.2022.07.07.15.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:26:09 -0700 (PDT)
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
Subject: [PATCH v3 7/9] platform/chrome: cros_typec_switch: Register mode switches
Date:   Thu,  7 Jul 2022 22:20:14 +0000
Message-Id: <20220707222045.1415417-8-pmalani@chromium.org>
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

Register mode switch devices for Type C connectors, when they are
specified by firmware. These control Type C configuration for any USB
Type-C mode switches (sometimes known as "muxes") which are controlled
by the Chrome EC.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v2:
- Fixed missing "static" identifier.

Changes since v1:
- No changes.

 drivers/platform/chrome/cros_typec_switch.c | 40 +++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index 7c01957a032d..024a2bb146b2 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_retimer.h>
 
 #define DRV_NAME "cros-typec-switch"
@@ -22,6 +23,7 @@
 /* Handles and other relevant data required for each port's switches. */
 struct cros_typec_port {
 	int port_num;
+	struct typec_mux_dev *mode_switch;
 	struct typec_retimer *retimer;
 	struct cros_typec_switch_data *sdata;
 };
@@ -147,6 +149,15 @@ static int cros_typec_configure_mux(struct cros_typec_switch_data *sdata, int po
 	return -ETIMEDOUT;
 }
 
+static int cros_typec_mode_switch_set(struct typec_mux_dev *mode_switch,
+				      struct typec_mux_state *state)
+{
+	struct cros_typec_port *port = typec_mux_get_drvdata(mode_switch);
+
+	/* Mode switches have index 0. */
+	return cros_typec_configure_mux(port->sdata, port->port_num, 0, state->mode, state->alt);
+}
+
 static int cros_typec_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
 {
 	struct cros_typec_port *port = typec_retimer_get_drvdata(retimer);
@@ -163,9 +174,27 @@ static void cros_typec_unregister_switches(struct cros_typec_switch_data *sdata)
 		if (!sdata->ports[i])
 			continue;
 		typec_retimer_unregister(sdata->ports[i]->retimer);
+		typec_mux_unregister(sdata->ports[i]->mode_switch);
 	}
 }
 
+static int cros_typec_register_mode_switch(struct cros_typec_port *port,
+					   struct fwnode_handle *fwnode)
+{
+	struct typec_mux_desc mode_switch_desc = {
+		.fwnode = fwnode,
+		.drvdata = port,
+		.name = fwnode_get_name(fwnode),
+		.set = cros_typec_mode_switch_set,
+	};
+
+	port->mode_switch = typec_mux_register(port->sdata->dev, &mode_switch_desc);
+	if (IS_ERR(port->mode_switch))
+		return PTR_ERR(port->mode_switch);
+
+	return 0;
+}
+
 static int cros_typec_register_retimer(struct cros_typec_port *port, struct fwnode_handle *fwnode)
 {
 	struct typec_retimer_desc retimer_desc = {
@@ -235,6 +264,17 @@ static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
 		}
 
 		dev_dbg(dev, "Retimer switch registered for index %llu\n", index);
+
+		if (!fwnode_property_read_bool(fwnode, "mode-switch"))
+			continue;
+
+		ret = cros_typec_register_mode_switch(port, fwnode);
+		if (ret) {
+			dev_err(dev, "Mode switch register failed\n");
+			goto err_switch;
+		}
+
+		dev_dbg(dev, "Mode switch registered for index %llu\n", index);
 	}
 
 	return 0;
-- 
2.37.0.rc0.161.g10f37bed90-goog

