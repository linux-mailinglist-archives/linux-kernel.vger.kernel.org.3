Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1413517031
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385268AbiEBNYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385246AbiEBNYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:24:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977DF10FD5;
        Mon,  2 May 2022 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651497669; x=1683033669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vhjt4KJNLWab4SNtPeWonpcHbv2BrmLKxf16cfZ1ZuE=;
  b=fN0RTkmiwzYDvCL1Ar3NBloETP72ei7mzaRPvlcPhzmGUh2tJSoCs0kQ
   j2LK0mp/6TXM8D5EemaynhwQhx5nR0M4TStDbaok9JSGkI3zqYvcwnfRJ
   0ZpImddq5YCwoFdNdhNU7zjrIkYHp/ah4lduwvif4v5cUdFNTx4jsgR2Y
   9+S87g0Cvjo9qtCrbsLI7OoZ/E0HTSO7fOtHnfuOUr5VFcfwK0i/9vlBu
   Bejq71JH33/vkuEYLo6P8DC0sDW6LNGQ0gv81430yVpzzjRSng00k9Lqz
   Ve02IRhm0dndq+/UeUCdGhU5KdOt7J4o3jUDt6y1/QIfajovYrxneuBeF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="267364131"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="267364131"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 06:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="707608396"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 May 2022 06:21:06 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Won Chung <wonchung@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] usb: typec: tcpm: Register USB Power Delivery Capabilities
Date:   Mon,  2 May 2022 16:20:58 +0300
Message-Id: <20220502132058.86236-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502132058.86236-1-heikki.krogerus@linux.intel.com>
References: <20220502132058.86236-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 3bc2f4ebd1feb..ff86e2fb24233 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -394,6 +394,14 @@ struct tcpm_port {
 	bool explicit_contract;
 	unsigned int rx_msgid;
 
+	/* USB PD objects */
+	struct usb_power_delivery *pd;
+	struct usb_power_delivery_capabilities *port_source_caps;
+	struct usb_power_delivery_capabilities *port_sink_caps;
+	struct usb_power_delivery *partner_pd;
+	struct usb_power_delivery_capabilities *partner_source_caps;
+	struct usb_power_delivery_capabilities *partner_sink_caps;
+
 	/* Partner capabilities/requests */
 	u32 sink_request;
 	u32 source_caps[PDO_MAX_OBJECTS];
@@ -2352,6 +2360,52 @@ static void tcpm_pd_handle_msg(struct tcpm_port *port,
 	}
 }
 
+static int tcpm_register_source_caps(struct tcpm_port *port)
+{
+	struct usb_power_delivery_desc desc = { port->negotiated_rev };
+	struct usb_power_delivery_capabilities_desc caps = { };
+	struct usb_power_delivery_capabilities *cap;
+
+	if (!port->partner_pd)
+		port->partner_pd = usb_power_delivery_register(NULL, &desc);
+	if (IS_ERR(port->partner_pd))
+		return PTR_ERR(port->partner_pd);
+
+	memcpy(caps.pdo, port->source_caps, sizeof(u32) * port->nr_source_caps);
+	caps.role = TYPEC_SOURCE;
+
+	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
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
+	struct usb_power_delivery_desc desc = { port->negotiated_rev };
+	struct usb_power_delivery_capabilities_desc caps = { };
+	struct usb_power_delivery_capabilities *cap;
+
+	if (!port->partner_pd)
+		port->partner_pd = usb_power_delivery_register(NULL, &desc);
+	if (IS_ERR(port->partner_pd))
+		return PTR_ERR(port->partner_pd);
+
+	memcpy(caps.pdo, port->sink_caps, sizeof(u32) * port->nr_sink_caps);
+	caps.role = TYPEC_SINK;
+
+	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
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
+		typec_partner_set_usb_power_delivery(port->partner, port->partner_pd);
 	}
 }
 
@@ -3622,6 +3681,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
 static void tcpm_typec_disconnect(struct tcpm_port *port)
 {
 	if (port->connected) {
+		typec_partner_set_usb_power_delivery(port->partner, NULL);
 		typec_unregister_partner(port->partner);
 		port->partner = NULL;
 		port->connected = false;
@@ -3684,6 +3744,13 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	port->sink_cap_done = false;
 	if (port->tcpc->enable_frs)
 		port->tcpc->enable_frs(port->tcpc, false);
+
+	usb_power_delivery_unregister_capabilities(port->partner_sink_caps);
+	port->partner_sink_caps = NULL;
+	usb_power_delivery_unregister_capabilities(port->partner_source_caps);
+	port->partner_source_caps = NULL;
+	usb_power_delivery_unregister(port->partner_pd);
+	port->partner_pd = NULL;
 }
 
 static void tcpm_detach(struct tcpm_port *port)
@@ -5924,6 +5991,68 @@ void tcpm_tcpc_reset(struct tcpm_port *port)
 }
 EXPORT_SYMBOL_GPL(tcpm_tcpc_reset);
 
+static void tcpm_port_unregister_pd(struct tcpm_port *port)
+{
+	usb_power_delivery_unregister_capabilities(port->port_sink_caps);
+	port->port_sink_caps = NULL;
+	usb_power_delivery_unregister_capabilities(port->port_source_caps);
+	port->port_source_caps = NULL;
+	usb_power_delivery_unregister(port->pd);
+	port->pd = NULL;
+}
+
+static int tcpm_port_register_pd(struct tcpm_port *port)
+{
+	struct usb_power_delivery_desc desc = { port->typec_caps.pd_revision };
+	struct usb_power_delivery_capabilities_desc caps = { };
+	struct usb_power_delivery_capabilities *cap;
+	int ret;
+
+	if (!port->nr_src_pdo && !port->nr_snk_pdo)
+		return 0;
+
+	port->pd = usb_power_delivery_register(port->dev, &desc);
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
+		cap = usb_power_delivery_register_capabilities(port->pd, &caps);
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
+		cap = usb_power_delivery_register_capabilities(port->pd, &caps);
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

