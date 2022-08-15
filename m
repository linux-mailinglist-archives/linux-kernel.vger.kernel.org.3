Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D305929CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbiHOGqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240921AbiHOGp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:45:57 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560312744
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:45:56 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q16so5831490pgq.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gDBcg0wiSt3vt58MkrYOdJVnzrhs/iuSr5KaWkfmmJs=;
        b=Rpg2cHfn9geuKVw2PWXcGPrGGPdoOcCuc2mzQtFYXHUc1NFqJoHD+Q65LeIDlTAkZh
         Ho+BCTnrV1FW7s+DXLxQ86XaSgG7uTc0Kbtduz27bdUQ1Z+6tQ/JEgkYxGBgyePQESfo
         VyQ4VUkp78/Jr5UqUfUJ2o7oIlrxzC6oSoZeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gDBcg0wiSt3vt58MkrYOdJVnzrhs/iuSr5KaWkfmmJs=;
        b=QULnA6iIKe7z1lBB7ONReVn/0QbaS4lNrKrH1dSIKnwV/Z8+8/qlOw+CxOOuG6bU4C
         lLR76E2bQ7k6Phdd3uYL+buCI1lWM2eu+MC7Y5BOrpVTLBFDZMuihcVIr5q5N/4pYJfh
         4zEHd+8tNekbLyPoktTeCWVY7RH1gl5Gu6iQ3Muo4lKAYCjKPg056LtY3c+TPMa7M/5s
         +AUmzYQTBDzWj2DDT+y/KpshVX5OHL6AoLU0LQu0cLya3OtWjJnBGJ+yV7ckhcEzgPKY
         MkKcV7U/MKRco3eIcObVUYaOt1H1xdrNDih7RqhapbgmJevPPfWnVuAPMErO9M2GcBvU
         uvnQ==
X-Gm-Message-State: ACgBeo2vVtTBdk7SvqOFgvtgy6K4xZ8YCAio1RSfP9aMw6UO1yeWVFgU
        dWmLynaSAgD2DEQQj7Ynr7DsXvu78EgP5g==
X-Google-Smtp-Source: AA6agR6+QNzJvVOPc6SO6E5AvT3N2Uy4ByBUAkDC38sn+9xFIB7EdYtQAcgRJhYAz/madR1QwA0M7w==
X-Received: by 2002:a65:57c8:0:b0:41c:fa29:ae1d with SMTP id q8-20020a6557c8000000b0041cfa29ae1dmr13125889pgr.136.1660545955347;
        Sun, 14 Aug 2022 23:45:55 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id 200-20020a6214d1000000b0052db82ad8b2sm5988233pfu.123.2022.08.14.23.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:45:54 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v5 5/7] platform/chrome: cros_typec_switch: Register mode switches
Date:   Mon, 15 Aug 2022 06:34:26 +0000
Message-Id: <20220815063555.1384505-6-pmalani@chromium.org>
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

Register mode switch devices for Type C connectors, when they are
specified by firmware. These control Type C configuration for any USB
Type-C mode switches (sometimes known as "muxes") which are controlled
by the Chrome EC.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v4:
- No changes.

Changes since v3:
- No changes.

Changes since v2:
- Fixed missing "static" identifier.

Changes since v1:
- No changes.

 drivers/platform/chrome/cros_typec_switch.c | 40 +++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index a9e114391321..9eb37b3b754f 100644
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
2.37.1.595.g718a3a8f04-goog

