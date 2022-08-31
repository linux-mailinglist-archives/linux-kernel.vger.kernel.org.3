Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDAF5A7246
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiHaAQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHaAQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:16:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852488E99F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:16:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y81-20020a253254000000b0069339437485so935071yby.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=5Nio9wW+lrrk0jgd+Y112TI5asoBTwAgUJzWnWe5Nhw=;
        b=GxgDoRI4P0OvrNpbWwzEK4jGtOQgr2rUo/p1tJmxnbcbX9UDzCTtFuUHXBW5QVSHP/
         b023aVe+XM1q6hqCb4m9oXFysSAt/yOwgLuYV2h0qzjNPQaqsYbcWdFBfVne3BmMPlbY
         6+YPbO0yxZuak/YnNntxepqoZwwN9TtWfRQMSOTgyxwYEDTlIpfKdPMzH8SRzjsWJtUH
         1F3YvHMeb8A7Zdfmc7uAtbNse0707GHNqBHaXeJBcBdEVQxP2QNIWkWdMsBmDX6KJBAT
         iEwTU5Fb5RCE3eA/dXXlLCSF3iaX1vTT4mhJvNZK8OuvlSv9JDhJIGYDfEcJfeY7j3/V
         oUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=5Nio9wW+lrrk0jgd+Y112TI5asoBTwAgUJzWnWe5Nhw=;
        b=NiPMcc3gcZcSpqRwFNwpFezg9oW0MXNbeWFhaBu78XVm80/7UUMb+bxD6CQdk0u3Bj
         mkjn/Xo9fsbzQHiK2BOn50ESxMnM2dbVQptinNiASCu3VYHwBv4vm5j41tASSsUUlmRq
         pYU2AWagZh943urZaJc0a+T0IZKa9Erc8SXyk3T6n0m2gwPmr8Kd7xy+SQ4Kvsbnwsi3
         NuCP9+pAgL2E4Dqme8QzbFNR1PlDHq2q45jY66i+ZiJKrK8l6TreE1Ybb4qZjhxXSfU2
         FxkvZ27opZe4F+PgE/vS/HUUKJljR10FqO5PjwuQac8dGnILjoFttF+xLoyrFoKKEwT5
         h9Rw==
X-Gm-Message-State: ACgBeo3J2fHwc/1Xb8RcnioQ71XNtWtXs/ZjxWMSwL0yfwIl4StKBT5U
        8K8rv91AGUpbgrdB1AM+2kX0aMui7G4=
X-Google-Smtp-Source: AA6agR4kN2OpfVdA3nH8R3KJ5b+QstCJmTLCZPKSglUrWmI/OJv3b3ydxPKVUvMcbu1V2D6tDUJ4nM9c97Q=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:377b:cea5:463f:f0c9])
 (user=badhri job=sendgmr) by 2002:a05:6902:34b:b0:691:4b82:7624 with SMTP id
 e11-20020a056902034b00b006914b827624mr14001975ybs.614.1661904965815; Tue, 30
 Aug 2022 17:16:05 -0700 (PDT)
Date:   Tue, 30 Aug 2022 17:15:53 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831001555.285081-1-badhri@google.com>
Subject: [PATCH v2 1/3] usb: typec: tcpm: Add callbacks to mitigate wakeups
 due to contaminant
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

On some of the TCPC implementations, when the Type-C port is exposed
to contaminants, such as water, TCPC stops toggling while reporting OPEN
either by the time TCPM reads CC pin status or during CC debounce
window. This causes TCPM to be stuck in TOGGLING state. If TCPM is made
to restart toggling, the behavior recurs causing redundant CPU wakeups
till the USB-C port is free of contaminant.

[206199.287817] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[206199.640337] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[206199.985789] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
...

To mitigate redundant TCPM wakeups, TCPCs which do have the needed hardware
can implement the check_contaminant callback which is invoked by TCPM
to evaluate for presence of contaminant. Lower level TCPC driver can
restart toggling through TCPM_PORT_CLEAN event when the driver detects
that USB-C port is free of contaminant. check_contaminant callback also passes
the disconnect_while_debounce flag which when true denotes that the CC pins
transitioned to OPEN state during the CC debounce window.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 59 +++++++++++++++++++++++++++++++++--
 include/linux/usb/tcpm.h      |  7 +++++
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ea5a917c51b1..072c5a2817d0 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -36,6 +36,7 @@
 #define FOREACH_STATE(S)			\
 	S(INVALID_STATE),			\
 	S(TOGGLING),			\
+	S(CHECK_CONTAMINANT),			\
 	S(SRC_UNATTACHED),			\
 	S(SRC_ATTACH_WAIT),			\
 	S(SRC_ATTACHED),			\
@@ -249,6 +250,7 @@ enum frs_typec_current {
 #define TCPM_RESET_EVENT	BIT(2)
 #define TCPM_FRS_EVENT		BIT(3)
 #define TCPM_SOURCING_VBUS	BIT(4)
+#define TCPM_PORT_CLEAN		BIT(5)
 
 #define LOG_BUFFER_ENTRIES	1024
 #define LOG_BUFFER_ENTRY_SIZE	128
@@ -483,6 +485,13 @@ struct tcpm_port {
 	 * SNK_READY for non-pd link.
 	 */
 	bool slow_charger_loop;
+
+	/*
+	 * When true indicates CC pins transitioned to OPEN state while
+	 * debouncing(tCCDebounce).
+	 */
+	bool disconnect_while_debouncing;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -3663,6 +3672,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
 	port->partner = NULL;
 
 	port->attached = true;
+	port->disconnect_while_debouncing = false;
 	port->send_discover = true;
 
 	return 0;
@@ -3797,6 +3807,7 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 	port->partner = NULL;
 
 	port->attached = true;
+	port->disconnect_while_debouncing = false;
 	port->send_discover = true;
 
 	return 0;
@@ -3824,6 +3835,7 @@ static int tcpm_acc_attach(struct tcpm_port *port)
 	tcpm_typec_connect(port);
 
 	port->attached = true;
+	port->disconnect_while_debouncing = false;
 
 	return 0;
 }
@@ -3908,11 +3920,22 @@ static void run_state_machine(struct tcpm_port *port)
 	switch (port->state) {
 	case TOGGLING:
 		break;
+	case CHECK_CONTAMINANT:
+		port->tcpc->check_contaminant(port->tcpc, port->disconnect_while_debouncing);
+		port->disconnect_while_debouncing = false;
+		break;
 	/* SRC states */
 	case SRC_UNATTACHED:
 		if (!port->non_pd_role_swap)
 			tcpm_swap_complete(port, -ENOTCONN);
 		tcpm_src_detach(port);
+		if (port->disconnect_while_debouncing) {
+			/* Check for contaminant when port reports disconnected while debouncing */
+			if (port->tcpc->check_contaminant) {
+				tcpm_set_state(port, CHECK_CONTAMINANT, 0);
+				break;
+			}
+		}
 		if (tcpm_start_toggling(port, tcpm_rp_cc(port))) {
 			tcpm_set_state(port, TOGGLING, 0);
 			break;
@@ -3922,6 +3945,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_UNATTACHED, PD_T_DRP_SNK);
 		break;
 	case SRC_ATTACH_WAIT:
+		port->disconnect_while_debouncing = true;
 		if (tcpm_port_is_debug(port))
 			tcpm_set_state(port, DEBUG_ACC_ATTACHED,
 				       PD_T_CC_DEBOUNCE);
@@ -3936,6 +3960,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 
 	case SNK_TRY:
+		port->disconnect_while_debouncing = false;
 		port->try_snk_count++;
 		/*
 		 * Requirements:
@@ -4150,6 +4175,13 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_swap_complete(port, -ENOTCONN);
 		tcpm_pps_complete(port, -ENOTCONN);
 		tcpm_snk_detach(port);
+		if (port->disconnect_while_debouncing) {
+			port->disconnect_while_debouncing = false;
+			if (port->tcpc->check_contaminant) {
+				tcpm_set_state(port, CHECK_CONTAMINANT, 0);
+				break;
+			}
+		}
 		if (tcpm_start_toggling(port, TYPEC_CC_RD)) {
 			tcpm_set_state(port, TOGGLING, 0);
 			break;
@@ -4159,6 +4191,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SRC_UNATTACHED, PD_T_DRP_SRC);
 		break;
 	case SNK_ATTACH_WAIT:
+		port->disconnect_while_debouncing = true;
 		if ((port->cc1 == TYPEC_CC_OPEN &&
 		     port->cc2 != TYPEC_CC_OPEN) ||
 		    (port->cc1 != TYPEC_CC_OPEN &&
@@ -4170,14 +4203,16 @@ static void run_state_machine(struct tcpm_port *port)
 				       PD_T_PD_DEBOUNCE);
 		break;
 	case SNK_DEBOUNCED:
-		if (tcpm_port_is_disconnected(port))
+		if (tcpm_port_is_disconnected(port)) {
 			tcpm_set_state(port, SNK_UNATTACHED,
 				       PD_T_PD_DEBOUNCE);
-		else if (port->vbus_present)
+		} else if (port->vbus_present) {
 			tcpm_set_state(port,
 				       tcpm_try_src(port) ? SRC_TRY
 							  : SNK_ATTACHED,
 				       0);
+			port->disconnect_while_debouncing = false;
+		}
 		break;
 	case SRC_TRY:
 		port->try_src_count++;
@@ -4925,6 +4960,12 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 			tcpm_set_state(port, SRC_ATTACH_WAIT, 0);
 		else if (tcpm_port_is_sink(port))
 			tcpm_set_state(port, SNK_ATTACH_WAIT, 0);
+		/* Check for contaminant when port reports disconnected while toggling */
+		else if (tcpm_port_is_disconnected(port) && port->tcpc->check_contaminant)
+			tcpm_set_state(port, CHECK_CONTAMINANT, 0);
+		break;
+	case CHECK_CONTAMINANT:
+		/* Wait for Toggling to be resumed */
 		break;
 	case SRC_UNATTACHED:
 	case ACC_UNATTACHED:
@@ -5225,6 +5266,7 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
 	case SNK_ATTACH_WAIT:
 	case SNK_DEBOUNCED:
 		/* Do nothing, as TCPM is still waiting for vbus to reaach VSAFE5V to connect */
+		port->disconnect_while_debouncing = false;
 		break;
 
 	case SNK_NEGOTIATE_CAPABILITIES:
@@ -5425,6 +5467,10 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
 			port->vbus_source = true;
 			_tcpm_pd_vbus_on(port);
 		}
+		if (events & TCPM_PORT_CLEAN) {
+			tcpm_log(port, "port clean");
+			tcpm_set_state(port, TOGGLING, 0);
+		}
 
 		spin_lock(&port->pd_event_lock);
 	}
@@ -5477,6 +5523,15 @@ void tcpm_sourcing_vbus(struct tcpm_port *port)
 }
 EXPORT_SYMBOL_GPL(tcpm_sourcing_vbus);
 
+void tcpm_port_clean(struct tcpm_port *port)
+{
+	spin_lock(&port->pd_event_lock);
+	port->pd_events |= TCPM_PORT_CLEAN;
+	spin_unlock(&port->pd_event_lock);
+	kthread_queue_work(port->wq, &port->event_work);
+}
+EXPORT_SYMBOL_GPL(tcpm_port_clean);
+
 static void tcpm_enable_frs_work(struct kthread_work *work)
 {
 	struct tcpm_port *port = container_of(work, struct tcpm_port, enable_frs);
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index bffc8d3e14ad..436563d91a49 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -114,6 +114,11 @@ enum tcpm_transmit_type {
  *              Optional; The USB Communications Capable bit indicates if port
  *              partner is capable of communication over the USB data lines
  *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
+ * @check_contaminant:
+ *		Optional; The callback is called when CC pins report open status
+ *		at the end of the deboumce period or when the port is still
+ *		toggling. Chip level drivers are expected to check for contaminant
+ *		and call tcpm_clean_port when the port is clean.
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -148,6 +153,7 @@ struct tcpc_dev {
 						 bool pps_active, u32 requested_vbus_voltage);
 	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
 	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
+	void (*check_contaminant)(struct tcpc_dev *dev, bool disconnect_while_debouncing);
 };
 
 struct tcpm_port;
@@ -165,5 +171,6 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
 			       enum tcpm_transmit_status status);
 void tcpm_pd_hard_reset(struct tcpm_port *port);
 void tcpm_tcpc_reset(struct tcpm_port *port);
+void tcpm_port_clean(struct tcpm_port *port);
 
 #endif /* __LINUX_USB_TCPM_H */
-- 
2.37.2.672.g94769d06f0-goog

