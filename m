Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC1756D6BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiGKHZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiGKHY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:24:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB07186F4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:24:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v7so2008668pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fbb8SneSCjlmPlmsdgGOqvR9vFnuRN+8XsuuuV97jTk=;
        b=ZVKUq5m0ZGeJ0bDPk/Of0lw3vBoAXuog+tiV0oMC8syhvllGn1ciGoliPyV853yuKm
         sVVc6Y2oOXnO+hVVZX7nkCW3QXv6hyjdC8gJtuMBKib3QOjiikDNvVMwVtSVDzMyKZpJ
         krYJ/WakyTmo6Mbs2UVgIxUlQgki2I0GOQHqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fbb8SneSCjlmPlmsdgGOqvR9vFnuRN+8XsuuuV97jTk=;
        b=tcWAsGp+EXmMIVd6ccKjRQqVRo00eL1FzZi89RyGCSfqgQqzL2wSUaAcpHH6ZvPc5O
         YcUCeClgWNrbL+hbdN6OIJ5I3ZDEpSeVfNYOR2gIiKjgzqeTFwn7gARSYVTzYDFhsOD0
         1nqNTuidVNSVUB6BQIhWpZQFaC+3r5Tac1TJLwLcjpTzCuj/ViVACFNoS8RGhfakWpQN
         7YZphitDf5xAG5t9w+9hmAubWHSy19d0gHX0a1EBkcb45s+btP9Sn56hKTsv2o+HtB7h
         ezj2V+1BAOv8LwUk4ta1OTpeMppc+SZW17uNfAHpIMIQWnKIN6jkM/Nrp4Dxz1uSyVuQ
         hPuA==
X-Gm-Message-State: AJIora+s+TscIqHmupPnzR8JXw/wCDld3Aq9gA7lsMIIsp0ztNvvT3Kd
        m57lTRogj5QgXnNYz+64Li7in7aCYcjz6w==
X-Google-Smtp-Source: AGRyM1sfH/Q2h4TbuPD98mQptsgz1V0zqedGbU2qSmm2w78N9wr2dQSx0cPWrKh87Zb6IhQ0gNZ/vQ==
X-Received: by 2002:a65:6bca:0:b0:411:f92b:5e39 with SMTP id e10-20020a656bca000000b00411f92b5e39mr15338585pgw.259.1657524294041;
        Mon, 11 Jul 2022 00:24:54 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z8-20020aa79e48000000b0051bc5f4df1csm4012839pfq.154.2022.07.11.00.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 00:24:53 -0700 (PDT)
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
Subject: [PATCH v4 2/9] usb: typec: Add retimer handle to port
Date:   Mon, 11 Jul 2022 07:22:56 +0000
Message-Id: <20220711072333.2064341-3-pmalani@chromium.org>
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

Similar to mux and orientation switch, add a handle for registered
retimer to the port, so that it has handles to the various switches
connected to it.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v3:
- No changes.

Changes since v2:
- No changes.

Changes since v1:
- Relinquish retimer reference during typec_release.

 drivers/usb/typec/class.c | 9 +++++++++
 drivers/usb/typec/class.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9062836bb638..f08e32d552b4 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/usb/pd_vdo.h>
 #include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_retimer.h>
 
 #include "bus.h"
 #include "class.h"
@@ -1736,6 +1737,7 @@ static void typec_release(struct device *dev)
 	ida_destroy(&port->mode_ids);
 	typec_switch_put(port->sw);
 	typec_mux_put(port->mux);
+	typec_retimer_put(port->retimer);
 	kfree(port->cap);
 	kfree(port);
 }
@@ -2249,6 +2251,13 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	port->retimer = typec_retimer_get(&port->dev);
+	if (IS_ERR(port->retimer)) {
+		ret = PTR_ERR(port->retimer);
+		put_device(&port->dev);
+		return ERR_PTR(ret);
+	}
+
 	ret = device_add(&port->dev);
 	if (ret) {
 		dev_err(parent, "failed to register port (%d)\n", ret);
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index 43fcf9e37a8c..673b2952b074 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -55,6 +55,7 @@ struct typec_port {
 	enum typec_orientation		orientation;
 	struct typec_switch		*sw;
 	struct typec_mux		*mux;
+	struct typec_retimer		*retimer;
 
 	const struct typec_capability	*cap;
 	const struct typec_operations   *ops;
-- 
2.37.0.144.g8ac04bfd2-goog

