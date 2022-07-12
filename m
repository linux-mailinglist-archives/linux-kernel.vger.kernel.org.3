Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290B8572836
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiGLVDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiGLVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:03:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339A41109
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:03:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 70so8517920pfx.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0ouDOTocd4ryU0X2wtR7HE0YSPQPIMij6SMHBNcHvk=;
        b=BLZ53MiPDohoR1ei9h52qUvtRT/WF5kmx4QSKuD2erEmWx+6e3ziWU7U05ercXjTav
         3eChHMZ8sUfiAX6yQKVMd0wiSu/2ollOz4MFJ6rBsM9usYVhukHGV0qJZVwLGnEBPER4
         ObGVuxpGA0fkTbvpESbqnYo9/ouTRnhuf4a4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0ouDOTocd4ryU0X2wtR7HE0YSPQPIMij6SMHBNcHvk=;
        b=PbRx7rILkPxIiGkFCOPeBHOLXIyTKWKZ4l59UX4WgJ88UQW0TG2oM1Ikva6Ic8TpFs
         L5ec8QsGqe/6KXiZPCTFmhCmakzU1L3ptmCdPMd5XvVsvEYW/jLIyDBx4tc/hDiGbKbN
         6iUW4GfmPB9MPv6GY0wfgT/MXE5WUY31vfhVn7yku269Pk4hHGZZTHAa1RZlIr7cUsaD
         HUyqAoQxPE1Bfpst596gczPleAT82uaF6pttNAqUG5XkGdA0u/+mBNDy9JLu4hwptU2D
         bhHm8GfQRxJJt2fe/Pys1Fa5NuYs637TLl8XIm94K5w64TmZyaJZpyBrKc1DR8QHbqRr
         8f4w==
X-Gm-Message-State: AJIora+U+Fe9RtLRahYXsapqaVWVEBzGU8X9pgMsA4SNy+Q6LhlrQQIi
        AwrdOdlXsbnPm2gZ3AyjaEufTXzoJVKB7A==
X-Google-Smtp-Source: AGRyM1u0KoL3IfGKMxtSveG5Sh8uofJj3OBpq26QBgBnPsYH9QtsVzXuwtRvnEQwyw8tOdbKRO904Q==
X-Received: by 2002:a05:6a00:170a:b0:52a:d3d4:3852 with SMTP id h10-20020a056a00170a00b0052ad3d43852mr60708pfc.19.1657659812447;
        Tue, 12 Jul 2022 14:03:32 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902eccf00b0016bf8048bd2sm7284130plh.175.2022.07.12.14.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:03:32 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 2/2] platform/chrome: cros_ec_typec: Register port altmodes
Date:   Tue, 12 Jul 2022 21:03:18 +0000
Message-Id: <20220712210318.2671292-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220712210318.2671292-1-pmalani@chromium.org>
References: <20220712210318.2671292-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using manually managed altmode structs, register the port's
altmodes with the Type-C framework. This facilitates matching them to
partner altmodes later.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 51 +++++++++++++++++++------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index b9848e80f372..e67cccb9ac78 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -25,6 +25,8 @@
 
 #define DRV_NAME "cros-ec-typec"
 
+#define DP_PORT_VDO	(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D) | DP_CAP_DFP_D)
+
 /* Supported alt modes. */
 enum {
 	CROS_EC_ALTMODE_DP = 0,
@@ -60,7 +62,7 @@ struct cros_typec_port {
 	uint8_t mux_flags;
 	uint8_t role;
 
-	struct typec_altmode port_altmode[CROS_EC_ALTMODE_MAX];
+	struct typec_altmode *port_altmode[CROS_EC_ALTMODE_MAX];
 
 	/* Flag indicating that PD partner discovery data parsing is completed. */
 	bool sop_disc_done;
@@ -253,6 +255,14 @@ static void cros_typec_remove_cable(struct cros_typec_data *typec,
 	port->sop_prime_disc_done = false;
 }
 
+static void cros_typec_unregister_port_altmodes(struct cros_typec_port *port)
+{
+	int i;
+
+	for (i = 0; i < CROS_EC_ALTMODE_MAX; i++)
+		typec_unregister_altmode(port->port_altmode[i]);
+}
+
 static void cros_unregister_ports(struct cros_typec_data *typec)
 {
 	int i;
@@ -267,34 +277,49 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
 		usb_role_switch_put(typec->ports[i]->role_sw);
 		typec_switch_put(typec->ports[i]->ori_sw);
 		typec_mux_put(typec->ports[i]->mux);
+		cros_typec_unregister_port_altmodes(typec->ports[i]);
 		typec_unregister_port(typec->ports[i]->port);
 	}
 }
 
 /*
- * Fake the alt mode structs until we actually start registering Type C port
- * and partner alt modes.
+ * Register port alt modes with known values till we start retrieving
+ * port capabilities from the EC.
  */
-static void cros_typec_register_port_altmodes(struct cros_typec_data *typec,
+static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 					      int port_num)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
+	struct typec_altmode_desc desc;
+	struct typec_altmode *amode;
 
 	/* All PD capable CrOS devices are assumed to support DP altmode. */
-	port->port_altmode[CROS_EC_ALTMODE_DP].svid = USB_TYPEC_DP_SID;
-	port->port_altmode[CROS_EC_ALTMODE_DP].mode = USB_TYPEC_DP_MODE;
+	desc.svid = USB_TYPEC_DP_SID,
+	desc.mode = USB_TYPEC_DP_MODE,
+	desc.vdo = DP_PORT_VDO,
+	amode = typec_port_register_altmode(port->port, &desc);
+	if (IS_ERR(amode))
+		return PTR_ERR(amode);
+	port->port_altmode[CROS_EC_ALTMODE_DP] = amode;
 
 	/*
 	 * Register TBT compatibility alt mode. The EC will not enter the mode
 	 * if it doesn't support it, so it's safe to register it unconditionally
 	 * here for now.
 	 */
-	port->port_altmode[CROS_EC_ALTMODE_TBT].svid = USB_TYPEC_TBT_SID;
-	port->port_altmode[CROS_EC_ALTMODE_TBT].mode = TYPEC_ANY_MODE;
+	memset(&desc, 0, sizeof(desc));
+	desc.svid = USB_TYPEC_TBT_SID,
+	desc.mode = TYPEC_ANY_MODE,
+	amode = typec_port_register_altmode(port->port, &desc);
+	if (IS_ERR(amode))
+		return PTR_ERR(amode);
+	port->port_altmode[CROS_EC_ALTMODE_TBT] = amode;
 
 	port->state.alt = NULL;
 	port->state.mode = TYPEC_STATE_USB;
 	port->state.data = NULL;
+
+	return 0;
 }
 
 static int cros_typec_init_ports(struct cros_typec_data *typec)
@@ -361,7 +386,11 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 			dev_dbg(dev, "No switch control for port %d\n",
 				port_num);
 
-		cros_typec_register_port_altmodes(typec, port_num);
+		ret = cros_typec_register_port_altmodes(typec, port_num);
+		if (ret) {
+			dev_err(dev, "Failed to register port altmodes\n");
+			goto unregister_ports;
+		}
 
 		cros_port->disc_data = devm_kzalloc(dev, EC_PROTO2_MAX_RESPONSE_SIZE, GFP_KERNEL);
 		if (!cros_port->disc_data) {
@@ -430,7 +459,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
 		data.enter_vdo |= TBT_ENTER_MODE_ACTIVE_CABLE;
 
 	if (!port->state.alt) {
-		port->state.alt = &port->port_altmode[CROS_EC_ALTMODE_TBT];
+		port->state.alt = port->port_altmode[CROS_EC_ALTMODE_TBT];
 		ret = cros_typec_usb_safe_state(port);
 		if (ret)
 			return ret;
@@ -472,7 +501,7 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	/* Configuration VDO. */
 	dp_data.conf = DP_CONF_SET_PIN_ASSIGN(pd_ctrl->dp_mode);
 	if (!port->state.alt) {
-		port->state.alt = &port->port_altmode[CROS_EC_ALTMODE_DP];
+		port->state.alt = port->port_altmode[CROS_EC_ALTMODE_DP];
 		ret = cros_typec_usb_safe_state(port);
 		if (ret)
 			return ret;
-- 
2.37.0.144.g8ac04bfd2-goog

