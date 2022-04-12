Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB3C4FE1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349343AbiDLNQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356756AbiDLNOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:14:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031ACDF06;
        Tue, 12 Apr 2022 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649768437; x=1681304437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d0KbQmgaxWycMLQqzv7h50EkzGujb7PBoiR8V7KLvzs=;
  b=nzk41ZUqsBgNyhP2yF8+cSczd8q5oyP/jj8kfT8ypL+jUeJm4dcKQ7Ie
   FSUujL64VuppVd+9vn5Nx9vgJrzFUdnbT4UXK7gjAWWS6P9lHCnRccLTE
   SOYXodbXJVViAHy2XWm7q4ANWbqirBhWkH3wePIUDtB19f7x2bEO2d+sB
   46qmOfe7MkSeRMehDwvYCFDuNTPCtPXRZ8noW9EZsVv90UyA4o7qdZN1e
   b71To6+fAJRN2WLvI/75HTcKBFkbPY2RFFRkKXBkdWQGyt8NoY04EA0c5
   RVNMfxHD6dXImDKYTUYZWCu6auq5P2zQkBnKX6c26IXVa3bYr3mEexM9b
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244250611"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="244250611"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:00:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="699825924"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2022 06:00:33 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Won Chung <wonchung@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] usb: typec: tcpm: Register USB Power Delivery Capabilities
Date:   Tue, 12 Apr 2022 16:00:23 +0300
Message-Id: <20220412130023.83927-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412130023.83927-1-heikki.krogerus@linux.intel.com>
References: <20220412130023.83927-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register both the port and partner USB Power Delivery
Capabilities so they are exposed to the user space.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 142 +++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3bc2f4ebd1feb..4bac824572ffd 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -394,6 +394,14 @@ struct tcpm_port {
 	bool explicit_contract;
 	unsigned int rx_msgid;
 
+	/* USB PD objects */
+	struct pd *pd;
+	struct pd_capabilities *port_source_caps;
+	struct pd_capabilities *port_sink_caps;
+	struct pd *partner_pd;
+	struct pd_capabilities *partner_source_caps;
+	struct pd_capabilities *partner_sink_caps;
+
 	/* Partner capabilities/requests */
 	u32 sink_request;
 	u32 source_caps[PDO_MAX_OBJECTS];
@@ -2352,6 +2360,52 @@ static void tcpm_pd_handle_msg(struct tcpm_port *port,
 	}
 }
 
+static int tcpm_register_source_caps(struct tcpm_port *port)
+{
+	struct pd_desc desc = { port->negotiated_rev };
+	struct pd_caps_desc caps = { };
+	struct pd_capabilities *cap;
+
+	if (!port->partner_pd)
+		port->partner_pd = pd_register(&desc);
+	if (IS_ERR(port->partner_pd))
+		return PTR_ERR(port->partner_pd);
+
+	memcpy(caps.pdo, port->source_caps, sizeof(u32) * port->nr_source_caps);
+	caps.role = TYPEC_SOURCE;
+
+	cap = pd_register_capabilities(port->partner_pd, &caps);
+	if (IS_ERR(cap))
+		return PTR_ERR(cap);
+
+	port->partner_source_caps = cap;
+
+	return 0;
+}
+
+static int tcpm_register_sink_caps(struct tcpm_port *port)
+{
+	struct pd_desc desc = { port->negotiated_rev };
+	struct pd_caps_desc caps = { };
+	struct pd_capabilities *cap;
+
+	if (!port->partner_pd)
+		port->partner_pd = pd_register(&desc);
+	if (IS_ERR(port->partner_pd))
+		return PTR_ERR(port->partner_pd);
+
+	memcpy(caps.pdo, port->sink_caps, sizeof(u32) * port->nr_sink_caps);
+	caps.role = TYPEC_SINK;
+
+	cap = pd_register_capabilities(port->partner_pd, &caps);
+	if (IS_ERR(cap))
+		return PTR_ERR(cap);
+
+	port->partner_sink_caps = cap;
+
+	return 0;
+}
+
 static void tcpm_pd_data_request(struct tcpm_port *port,
 				 const struct pd_message *msg)
 {
@@ -2381,6 +2435,8 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 		tcpm_validate_caps(port, port->source_caps,
 				   port->nr_source_caps);
 
+		tcpm_register_source_caps(port);
+
 		/*
 		 * Adjust revision in subsequent message headers, as required,
 		 * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
@@ -2488,6 +2544,8 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 
 		port->nr_sink_caps = cnt;
 		port->sink_cap_done = true;
+		tcpm_register_sink_caps(port);
+
 		if (port->ams == GET_SINK_CAPABILITIES)
 			tcpm_set_state(port, ready_state(port), 0);
 		/* Unexpected Sink Capabilities */
@@ -3554,6 +3612,7 @@ static void tcpm_typec_connect(struct tcpm_port *port)
 		port->partner = typec_register_partner(port->typec_port,
 						       &port->partner_desc);
 		port->connected = true;
+		typec_partner_set_pd(port->partner, port->partner_pd);
 	}
 }
 
@@ -3622,6 +3681,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
 static void tcpm_typec_disconnect(struct tcpm_port *port)
 {
 	if (port->connected) {
+		typec_partner_set_pd(port->partner, NULL);
 		typec_unregister_partner(port->partner);
 		port->partner = NULL;
 		port->connected = false;
@@ -3684,6 +3744,13 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	port->sink_cap_done = false;
 	if (port->tcpc->enable_frs)
 		port->tcpc->enable_frs(port->tcpc, false);
+
+	pd_unregister_capabilities(port->partner_sink_caps);
+	port->partner_sink_caps = NULL;
+	pd_unregister_capabilities(port->partner_source_caps);
+	port->partner_source_caps = NULL;
+	pd_unregister(port->partner_pd);
+	port->partner_pd = NULL;
 }
 
 static void tcpm_detach(struct tcpm_port *port)
@@ -5924,6 +5991,68 @@ void tcpm_tcpc_reset(struct tcpm_port *port)
 }
 EXPORT_SYMBOL_GPL(tcpm_tcpc_reset);
 
+static void tcpm_port_unregister_pd(struct tcpm_port *port)
+{
+	pd_unregister_capabilities(port->port_sink_caps);
+	port->port_sink_caps = NULL;
+	pd_unregister_capabilities(port->port_source_caps);
+	port->port_source_caps = NULL;
+	pd_unregister(port->pd);
+	port->pd = NULL;
+}
+
+static int tcpm_port_register_pd(struct tcpm_port *port)
+{
+	struct pd_desc desc = { port->typec_caps.pd_revision };
+	struct pd_caps_desc caps = { };
+	struct pd_capabilities *cap;
+	int ret;
+
+	if (!port->nr_src_pdo && !port->nr_snk_pdo)
+		return 0;
+
+	port->pd = pd_register(&desc);
+	if (IS_ERR(port->pd)) {
+		ret = PTR_ERR(port->pd);
+		goto err_unregister;
+	}
+
+	if (port->nr_src_pdo) {
+		memcpy_and_pad(caps.pdo, sizeof(caps.pdo), port->src_pdo,
+			       port->nr_src_pdo * sizeof(u32), 0);
+		caps.role = TYPEC_SOURCE;
+
+		cap = pd_register_capabilities(port->pd, &caps);
+		if (IS_ERR(cap)) {
+			ret = PTR_ERR(cap);
+			goto err_unregister;
+		}
+
+		port->port_source_caps = cap;
+	}
+
+	if (port->nr_snk_pdo) {
+		memcpy_and_pad(caps.pdo, sizeof(caps.pdo), port->snk_pdo,
+			       port->nr_snk_pdo * sizeof(u32), 0);
+		caps.role = TYPEC_SINK;
+
+		cap = pd_register_capabilities(port->pd, &caps);
+		if (IS_ERR(cap)) {
+			ret = PTR_ERR(cap);
+			goto err_unregister;
+		}
+
+		port->port_sink_caps = cap;
+	}
+
+	return 0;
+
+err_unregister:
+	tcpm_port_unregister_pd(port);
+
+	return ret;
+}
+
 static int tcpm_fw_get_caps(struct tcpm_port *port,
 			    struct fwnode_handle *fwnode)
 {
@@ -6382,10 +6511,16 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 		goto out_role_sw_put;
 	power_supply_changed(port->psy);
 
+	err = tcpm_port_register_pd(port);
+	if (err)
+		goto out_role_sw_put;
+
+	port->typec_caps.pd = port->pd;
+
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
 	if (IS_ERR(port->typec_port)) {
 		err = PTR_ERR(port->typec_port);
-		goto out_role_sw_put;
+		goto out_unregister_pd;
 	}
 
 	typec_port_register_altmodes(port->typec_port,
@@ -6400,6 +6535,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	tcpm_log(port, "%s: registered", dev_name(dev));
 	return port;
 
+out_unregister_pd:
+	tcpm_port_unregister_pd(port);
 out_role_sw_put:
 	usb_role_switch_put(port->role_sw);
 out_destroy_wq:
@@ -6422,6 +6559,9 @@ void tcpm_unregister_port(struct tcpm_port *port)
 	hrtimer_cancel(&port->state_machine_timer);
 
 	tcpm_reset_port(port);
+
+	tcpm_port_unregister_pd(port);
+
 	for (i = 0; i < ARRAY_SIZE(port->port_altmode); i++)
 		typec_unregister_altmode(port->port_altmode[i]);
 	typec_unregister_port(port->typec_port);
-- 
2.35.1

