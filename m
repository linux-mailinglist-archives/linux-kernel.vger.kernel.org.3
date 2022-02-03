Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110844A86DC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351347AbiBCOrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:47:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:37941 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351337AbiBCOqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643899614; x=1675435614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vQNgw02nO8wh7Ms6v2zOlYLS2xcPK0QefbK3K3pecNo=;
  b=eP6Ul204YQ0drPirwdXxnJxSDaDRayiwCveob3eNMd6UDDHIgURAr48E
   eXvBWNzMy7BY5V5LCgPuaSCwvpnyT3NgFT+O39Hkohgz9hbilva/zi3UX
   55j18K8ntLpm+V3HakMJtyr9hOTojeXQxONOB0/up45lJ38Q7amKfm3Lz
   x3MfEOJ5wXkWX5XnlXX5P2il67ok8OWMmi8uz3Q9Z8aDXaTCpZt9sD9IM
   mJzBn0QNZy0Bi6w8usrdpW+/KSW2DVXm0ktjsoTwzeXJX5k+Xd/YXNw8B
   YO59rkI4bFCRGLqFnvlnu/B0LdwzvB6mcz+z+s3L3TP9zUEVQ3ptQu/7E
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308883026"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="308883026"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:46:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="676788169"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2022 06:46:51 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] usb: typec: ucsi: Register USB Power Delivery Capabilities
Date:   Thu,  3 Feb 2022 17:46:57 +0300
Message-Id: <20220203144657.16527-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203144657.16527-1-heikki.krogerus@linux.intel.com>
References: <20220203144657.16527-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UCSI allows the USB PD capabilities to be read with the
GET_PDO command. This will register those capabilities, and
that way make them visible to the user space.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 128 +++++++++++++++++++++++++++++++---
 drivers/usb/typec/ucsi/ucsi.h |   8 +++
 2 files changed, 125 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index f0c2fa19f3e0f..5149001093c7f 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -568,8 +568,8 @@ static void ucsi_unregister_altmodes(struct ucsi_connector *con, u8 recipient)
 	}
 }
 
-static int ucsi_get_pdos(struct ucsi_connector *con, int is_partner,
-			 u32 *pdos, int offset, int num_pdos)
+static int ucsi_read_pdos(struct ucsi_connector *con, enum typec_role role, int is_partner,
+			  u32 *pdos, int offset, int num_pdos)
 {
 	struct ucsi *ucsi = con->ucsi;
 	u64 command;
@@ -579,7 +579,7 @@ static int ucsi_get_pdos(struct ucsi_connector *con, int is_partner,
 	command |= UCSI_GET_PDOS_PARTNER_PDO(is_partner);
 	command |= UCSI_GET_PDOS_PDO_OFFSET(offset);
 	command |= UCSI_GET_PDOS_NUM_PDOS(num_pdos - 1);
-	command |= UCSI_GET_PDOS_SRC_PDOS;
+	command |= is_source(role) ? UCSI_GET_PDOS_SRC_PDOS : 0;
 	ret = ucsi_send_command(ucsi, command, pdos + offset,
 				num_pdos * sizeof(u32));
 	if (ret < 0 && ret != -ETIMEDOUT)
@@ -590,26 +590,39 @@ static int ucsi_get_pdos(struct ucsi_connector *con, int is_partner,
 	return ret;
 }
 
-static int ucsi_get_src_pdos(struct ucsi_connector *con)
+static int ucsi_get_pdos(struct ucsi_connector *con, enum typec_role role,
+			 int is_partner, u32 *pdos)
 {
+	u8 num_pdos;
 	int ret;
 
 	/* UCSI max payload means only getting at most 4 PDOs at a time */
-	ret = ucsi_get_pdos(con, 1, con->src_pdos, 0, UCSI_MAX_PDOS);
+	ret = ucsi_read_pdos(con, role, is_partner, pdos, 0, UCSI_MAX_PDOS);
 	if (ret < 0)
 		return ret;
 
-	con->num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
-	if (con->num_pdos < UCSI_MAX_PDOS)
-		return 0;
+	num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
+	if (num_pdos < UCSI_MAX_PDOS)
+		return num_pdos;
 
 	/* get the remaining PDOs, if any */
-	ret = ucsi_get_pdos(con, 1, con->src_pdos, UCSI_MAX_PDOS,
-			    PDO_MAX_OBJECTS - UCSI_MAX_PDOS);
+	ret = ucsi_read_pdos(con, role, is_partner, pdos, UCSI_MAX_PDOS,
+			     PDO_MAX_OBJECTS - UCSI_MAX_PDOS);
+	if (ret < 0)
+		return ret;
+
+	return ret / sizeof(u32) + num_pdos;
+}
+
+static int ucsi_get_src_pdos(struct ucsi_connector *con)
+{
+	int ret;
+
+	ret = ucsi_get_pdos(con, TYPEC_SOURCE, 1, con->src_pdos);
 	if (ret < 0)
 		return ret;
 
-	con->num_pdos += ret / sizeof(u32);
+	con->num_pdos += ret;
 
 	ucsi_port_psy_changed(con);
 
@@ -638,6 +651,60 @@ static int ucsi_check_altmodes(struct ucsi_connector *con)
 	return ret;
 }
 
+static int ucsi_register_partner_pdos(struct ucsi_connector *con)
+{
+	struct pd_desc desc = { con->ucsi->cap.pd_version };
+	struct pd_capabilities *cap;
+	struct pd_caps_desc caps;
+	int ret;
+
+	con->partner_pd = typec_partner_register_pd(con->partner, &desc);
+	if (IS_ERR(con->partner_pd))
+		return PTR_ERR(con->partner_pd);
+
+	ret = ucsi_get_pdos(con, TYPEC_SOURCE, 1, caps.pdo);
+	if (ret < 0)
+		return ret;
+
+	if (ret < PDO_MAX_OBJECTS)
+		caps.pdo[ret] = 0;
+	caps.role = TYPEC_SOURCE;
+
+	cap = pd_register_capabilities(con->partner_pd, &caps);
+	if (IS_ERR(cap))
+		return PTR_ERR(cap);
+
+	ret = typec_partner_set_pd_capabilities(con->partner, cap);
+	if (ret) {
+		pd_unregister_capabilities(cap);
+		return ret;
+	}
+
+	con->partner_source_caps = cap;
+
+	ret = ucsi_get_pdos(con, TYPEC_SINK, 1, caps.pdo);
+	if (ret <= 0)
+		return ret;
+
+	if (ret < PDO_MAX_OBJECTS)
+		caps.pdo[ret] = 0;
+	caps.role = TYPEC_SINK;
+
+	cap = pd_register_capabilities(con->partner_pd, &caps);
+	if (IS_ERR(cap))
+		return PTR_ERR(cap);
+
+	ret = typec_partner_set_pd_capabilities(con->partner, cap);
+	if (ret) {
+		pd_unregister_capabilities(cap);
+		return ret;
+	}
+
+	con->partner_sink_caps = cap;
+
+	return 0;
+}
+
 static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 {
 	switch (UCSI_CONSTAT_PWR_OPMODE(con->status.flags)) {
@@ -646,6 +713,7 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_PD);
 		ucsi_partner_task(con, ucsi_get_src_pdos, 30, 0);
 		ucsi_partner_task(con, ucsi_check_altmodes, 30, 0);
+		ucsi_partner_task(con, ucsi_register_partner_pdos, 1, HZ);
 		break;
 	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
 		con->rdo = 0;
@@ -704,6 +772,17 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
 	if (!con->partner)
 		return;
 
+	typec_partner_unset_pd_capabilities(con->partner, TYPEC_SINK);
+	pd_unregister_capabilities(con->partner_sink_caps);
+	con->partner_sink_caps = NULL;
+
+	typec_partner_unset_pd_capabilities(con->partner, TYPEC_SOURCE);
+	pd_unregister_capabilities(con->partner_source_caps);
+	con->partner_source_caps = NULL;
+
+	typec_partner_unregister_pd(con->partner);
+	con->partner_pd = NULL;
+
 	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP);
 	typec_unregister_partner(con->partner);
 	con->partner = NULL;
@@ -1037,6 +1116,8 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 	u64 command;
 	char *name;
 	int ret;
+	struct pd_desc desc = { ucsi->cap.pd_version };
+	struct pd_caps_desc caps;
 
 	name = kasprintf(GFP_KERNEL, "%s-con%d", dev_name(ucsi->dev), con->num);
 	if (!name)
@@ -1103,6 +1184,24 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 		goto out;
 	}
 
+	con->pd = typec_port_register_pd(con->port, &desc);
+
+	ret = ucsi_get_pdos(con, TYPEC_SOURCE, 0, caps.pdo);
+	if (ret > 0) {
+		caps.pdo[ret] = 0;
+		caps.role = TYPEC_SOURCE;
+		con->source_caps = pd_register_capabilities(con->pd, &caps);
+		typec_port_set_pd_capabilities(con->port, con->source_caps);
+	}
+
+	ret = ucsi_get_pdos(con, TYPEC_SINK, 0, caps.pdo);
+	if (ret > 0) {
+		caps.pdo[ret] = 0;
+		caps.role = TYPEC_SINK;
+		con->sink_caps = pd_register_capabilities(con->pd, &caps);
+		typec_port_set_pd_capabilities(con->port, con->sink_caps);
+	}
+
 	/* Alternate modes */
 	ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_CON);
 	if (ret) {
@@ -1169,6 +1268,7 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 	    UCSI_CONSTAT_PWR_OPMODE_PD) {
 		ucsi_get_src_pdos(con);
 		ucsi_check_altmodes(con);
+		ucsi_register_partner_pdos(con);
 	}
 
 	trace_ucsi_register_port(con->num, &con->status);
@@ -1379,6 +1479,12 @@ void ucsi_unregister(struct ucsi *ucsi)
 		ucsi_unregister_port_psy(&ucsi->connector[i]);
 		if (ucsi->connector[i].wq)
 			destroy_workqueue(ucsi->connector[i].wq);
+		typec_port_unset_pd_capabilities(ucsi->connector[i].port,
+						 ucsi->connector[i].source_caps);
+		pd_unregister_capabilities(ucsi->connector[i].source_caps);
+		typec_port_unset_pd_capabilities(ucsi->connector[i].port,
+						 ucsi->connector[i].sink_caps);
+		pd_unregister_capabilities(ucsi->connector[i].sink_caps);
 		typec_unregister_port(ucsi->connector[i].port);
 	}
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 280f1e1bda2c9..aa23df98b7730 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -335,6 +335,14 @@ struct ucsi_connector {
 	int num_pdos;
 
 	struct usb_role_switch *usb_role_sw;
+
+	struct pd *pd;
+	struct pd_capabilities *source_caps;
+	struct pd_capabilities *sink_caps;
+
+	struct pd *partner_pd;
+	struct pd_capabilities *partner_source_caps;
+	struct pd_capabilities *partner_sink_caps;
 };
 
 int ucsi_send_command(struct ucsi *ucsi, u64 command,
-- 
2.34.1

