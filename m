Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7314AB3D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350061AbiBGFwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351826AbiBGEjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:39:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060EFC043185
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 20:39:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 127-20020a250f85000000b00611ab6484abso25919831ybp.23
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 20:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fvjMeqmS7YAThM14Nr6hWHQ1rky2oX1fyAm+Zs01zKU=;
        b=dX+tFNmXNa6mZWGOfqwibUN9WltV9vHGJJRY5AFwriAxK+mtAijgyVAGd0wre//BOS
         049UmTSvQrgxrV6f1Gw26FOXVLXemOunLaJPXkgxBlbrvuJwNo//EYmCh6DAJol6Hlf3
         8TTqRMfAQUtoTugTw5TjfCq4L/gc9I9DQCHuHHLVKXMqFmUEExPCnsuyUfQ551ajcY/D
         2vGc0XSaOKJSRZGHNGWBPn6UBiHQ1NVjWvUFY6O66yRsFa5MDLZpw0rFZbmc/a6bvKX9
         ZZl7yup1nNZGj8jiswbWSaDBNLApFxAepHC8Afl6F6t3EaNw6Or4N8Lp4zQXng+oB9tc
         lHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fvjMeqmS7YAThM14Nr6hWHQ1rky2oX1fyAm+Zs01zKU=;
        b=R6pqfgD4TPnszDc0X5StXdnWdE+5nHvPGhEnZ1bCmfHuIVEtg5JZ9T/Ux1v8Oz+CYz
         qdU/LOQ9DD/YySRFAL/09gsO5pSAeJNr7RUQiQua4m0lKhduF0fxyPZf+64i9hccPYZD
         CSbB+NGHxDGXCNpIB+jSvm4mbtKCbhzxv2+/wW3jMc81nTGlQi8mez9EFb1Uiakj41eM
         pJirb4c8+C4gdxMvmeiA9w/mMsSyi7dVbjCcmSddpERbfX5MJjLfvg1aYZLw+RW2w32h
         0WYTLPePSfqm5z/UHcebDAAgQynuU00dyfHeQTAMoOiVD9pAeHajijNdFroZ8P2EL1/B
         1LxQ==
X-Gm-Message-State: AOAM532HerKeHd38DQ2FVURH5B9uIC1xvgV8H2EpR4BvwN8FiAKbdVY2
        M8nUkGvbrkymiixrYEEU5hpj2+EP95M=
X-Google-Smtp-Source: ABdhPJzrC2+QNecsePbDSgJYh4Pk9KseHmfPtb16eAYPVWEGR/YoKcDueljCvUXSLi7OZ9RXXf2u/XBfEeo=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:55d1:a045:9816:1433])
 (user=badhri job=sendgmr) by 2002:a25:7d45:: with SMTP id y66mr8077570ybc.376.1644208755165;
 Sun, 06 Feb 2022 20:39:15 -0800 (PST)
Date:   Sun,  6 Feb 2022 20:39:07 -0800
In-Reply-To: <20220207043907.2758424-1-badhri@google.com>
Message-Id: <20220207043907.2758424-2-badhri@google.com>
Mime-Version: 1.0
References: <20220207043907.2758424-1-badhri@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v1 2/2] usb: typec: tcpm: Enable limit_src_current_set callback
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change allows TCPM to support limit_src_current_set
callback. When limit_src_current_set is enabled, tcpm
updates the local source capabilities to only publish
vSafe5V fixed pdo with the current limit passed through
limit_src_current_set callback. When limit_src_current_set
is disabled, tcpm revert back to publishing the default
source caps.

This patch is co-authored with kyletso@google.com and
also uses some of parts of the code that was reverted
by c17c7cf147ac56312156eaaaf8b2e19c9a59a71a.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 108 ++++++++++++++++++++++++++++++----
 include/linux/usb/tcpm.h      |   4 ++
 2 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5fce795b69c7..491ad6621671 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -475,6 +475,15 @@ struct tcpm_port {
 	 * SNK_READY for non-pd link.
 	 */
 	bool slow_charger_loop;
+
+	/*
+	 * Max current published in vSafe5V fixed pdo when limit_src_current_enabled
+	 * is active.
+	 */
+	u32 limit_src_current_ma;
+	/* True when source current limiting is enabled */
+	bool limit_src_current_enabled;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -5907,12 +5916,99 @@ static int tcpm_port_type_set(struct typec_port *p, enum typec_port_type type)
 	return 0;
 }
 
+int tcpm_update_source_capabilities_locked(struct tcpm_port *port)
+{
+	int ret = 0;
+
+	switch (port->state) {
+	case SRC_UNATTACHED:
+	case SRC_ATTACH_WAIT:
+	case SRC_TRYWAIT:
+		tcpm_set_cc(port, tcpm_rp_cc(port));
+		break;
+	case SRC_SEND_CAPABILITIES:
+	case SRC_NEGOTIATE_CAPABILITIES:
+	case SRC_READY:
+	case SRC_WAIT_NEW_CAPABILITIES:
+		port->upcoming_state = SRC_SEND_CAPABILITIES;
+		ret = tcpm_ams_start(port, POWER_NEGOTIATION);
+		if (ret == -EAGAIN) {
+			port->upcoming_state = INVALID_STATE;
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static int tcpm_fw_get_src_pdo(struct tcpm_port *port, struct fwnode_handle *fwnode, u32 *src_pdo,
+			       unsigned int *nr_src_pdo)
+{
+	int ret;
+
+	ret = fwnode_property_count_u32(fwnode, "source-pdos");
+	if (ret == 0)
+		return -EINVAL;
+	else if (ret < 0)
+		return ret;
+
+	*nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
+	ret = fwnode_property_read_u32_array(fwnode, "source-pdos", src_pdo, *nr_src_pdo);
+
+	return ret;
+}
+
+static int tcpm_limit_src_current_set(struct typec_port *p, u32 limit_src_current_ma, bool enable)
+{
+	struct tcpm_port *port = typec_get_drvdata(p);
+	int ret = 0;
+
+	mutex_lock(&port->lock);
+	if (limit_src_current_ma == port->limit_src_current_ma &&
+	    enable == port->limit_src_current_enabled)
+		goto port_unlock;
+
+	ret = tcpm_fw_get_src_pdo(port, port->tcpc->fwnode, port->src_pdo, &port->nr_src_pdo);
+	if (ret)
+		return ret;
+
+	if (enable) {
+		u32 current_vSafe5V_max_current_ma =
+			((port->src_pdo[0] & (PDO_CURR_MASK << PDO_FIXED_CURR_SHIFT)) >>
+			 PDO_FIXED_CURR_SHIFT) * 10;
+		/*
+		 * Check to see if limited source current does not exceed the
+		 * max current published in default source cap.
+		 */
+		if (limit_src_current_ma > current_vSafe5V_max_current_ma) {
+			ret = -EINVAL;
+			goto port_unlock;
+		}
+		port->src_pdo[0] &= ~(PDO_CURR_MASK << PDO_FIXED_CURR_SHIFT);
+		port->src_pdo[0] |= PDO_FIXED_CURR(limit_src_current_ma);
+		port->nr_src_pdo = 1;
+	}
+
+	ret = tcpm_update_source_capabilities_locked(port);
+	if (!ret) {
+		port->limit_src_current_ma = limit_src_current_ma;
+		port->limit_src_current_enabled = enable;
+	}
+
+port_unlock:
+	mutex_unlock(&port->lock);
+	return ret;
+}
+
 static const struct typec_operations tcpm_ops = {
 	.try_role = tcpm_try_role,
 	.dr_set = tcpm_dr_set,
 	.pr_set = tcpm_pr_set,
 	.vconn_set = tcpm_vconn_set,
-	.port_type_set = tcpm_port_type_set
+	.port_type_set = tcpm_port_type_set,
+	.limit_src_current_set = tcpm_limit_src_current_set
 };
 
 void tcpm_tcpc_reset(struct tcpm_port *port)
@@ -5970,15 +6066,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 
 	/* Get Source PDOs for the PD port or Source Rp value for the non-PD port */
 	if (port->pd_supported) {
-		ret = fwnode_property_count_u32(fwnode, "source-pdos");
-		if (ret == 0)
-			return -EINVAL;
-		else if (ret < 0)
-			return ret;
-
-		port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
-		ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
-						     port->src_pdo, port->nr_src_pdo);
+		ret = tcpm_fw_get_src_pdo(port, fwnode, port->src_pdo, &port->nr_src_pdo);
 		if (ret)
 			return ret;
 		ret = tcpm_validate_caps(port, port->src_pdo, port->nr_src_pdo);
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index bffc8d3e14ad..18372d34a9f4 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -165,5 +165,9 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
 			       enum tcpm_transmit_status status);
 void tcpm_pd_hard_reset(struct tcpm_port *port);
 void tcpm_tcpc_reset(struct tcpm_port *port);
+bool tcpm_is_debouncing(struct tcpm_port *tcpm);
+bool tcpm_is_toggling(struct tcpm_port *port);
+int tcpm_update_source_capabilities(struct tcpm_port *port, const u32 *pdo,
+				    unsigned int nr_pdo);
 
 #endif /* __LINUX_USB_TCPM_H */
-- 
2.35.0.263.gb82422642f-goog

