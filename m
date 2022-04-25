Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4C50E0BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbiDYMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbiDYMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:53:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8A028996;
        Mon, 25 Apr 2022 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650890998; x=1682426998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G44CKkHDqJKUx7rbtoc+bY7MR18EXetohAqRYvMtbNQ=;
  b=R3sYNMcGkZuglx5KnVarlx6I2t9ymdLjfisc6ffdaN55Pu+3/+RUbRLp
   c2xcN/P7ANYP0MUL60utPvioMSAFjHltDHdvNWx27RTHLsjDtW9HMt6xf
   TBX4Spdc7BkBgfysVh3H7nYkGhpKU8DvxmRtsjiueTOZa+3h3DMYTly12
   wSZSFQA2wZOdXbVDs59pWsbd3HVsCLIRhUA1HXlao6SS+6HSHGYbJ4Nma
   CXQZvmkhC1pHHPzqIOPsG+l1Q7iKitfyEQIQEQXmnCeJk7CAb2sFs6ZYc
   5hDnejGPFyVnpoEIgftzVihkpIGuXc9SE65luanLLnANzMqG24B3E9Icq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264086928"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="264086928"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 05:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="704544232"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 05:49:55 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Won Chung <wonchung@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] usb: typec: tcpm: Register USB Power Delivery Capabilities
Date:   Mon, 25 Apr 2022 15:49:46 +0300
Message-Id: <20220425124946.13064-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425124946.13064-1-heikki.krogerus@linux.intel.com>
References: <20220425124946.13064-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 3bc2f4ebd1feb..5785f174a3ce6 100644
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
+		port->partner_pd = pd_register(NULL, &desc);
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
+		port->partner_pd = pd_register(NULL, &desc);
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
+	port->pd = pd_register(port->dev, &desc);
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

